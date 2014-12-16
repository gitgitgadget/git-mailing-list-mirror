From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 5/6] push.c: add an --atomic-push argument
Date: Tue, 16 Dec 2014 12:43:04 -0800
Message-ID: <xmqqbnn39vhj.fsf@gitster.dls.corp.google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-5-git-send-email-sbeller@google.com>
	<CAPig+cR5x=GsZ6Gg_i==o0WKgqU1PP9uQ6QAgNkF8SBOvRCJ5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, ronniesahlberg@gmail.com,
	Ronnie Sahlberg <sahlberg@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 21:43:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0yxc-0006vW-PR
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 21:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbaLPUnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 15:43:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750866AbaLPUnG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 15:43:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F1DE27D30;
	Tue, 16 Dec 2014 15:43:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eKr9T6NtZcmkjSeQJdj9Jbqp2fE=; b=AsdJK9
	bGQjzZduQBdRZv3WaBN9uefe9Sbl16jZQ6tKLDdxcd9Zpz8GL7Ewequ8kqhrsBcO
	iK7OufGMoWUgE5k+5xtvpHwHifsscZgQ5XKhrjyuD+4jtZK7BpDNUebfHVnQHscQ
	YYGg/6d7Zt/cSKw069hdOYyQ23WcPQUH41xSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vhEsUoXaEjFs+4XBFPA6w+l9r/+p3/gO
	rhghnwkeWAYuuxol9G4bz3pojAXdCF1t90wXE7NMHKn3c9Fu/8vYd3IbK+aNIhW7
	isp9YAPCXtbTI0C3exT1UK25n3Iwx1lUCy8mWRl7sK4RJDLr069ao+IoBJKHBKT+
	fag7OvrbDl4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34E0027D2F;
	Tue, 16 Dec 2014 15:43:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 926A227D2E;
	Tue, 16 Dec 2014 15:43:07 -0500 (EST)
In-Reply-To: <CAPig+cR5x=GsZ6Gg_i==o0WKgqU1PP9uQ6QAgNkF8SBOvRCJ5g@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 16 Dec 2014 14:33:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 241882C6-8564-11E4-8983-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261469>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +--atomic::
>> +       Use the an atomic transaction on the server side if available.
>
> s/the an/an/
> ...
>> +               OPT_BIT(0, "atomic", &flags, N_("use a single atomic transaction at the serverside, if available"),
>
> "single atomic" sounds awfully redundant.
>
> "serverside" is odd. Perhaps "server side" or merely "remote" or "remote side".
> ...
>> diff --git a/transport.h b/transport.h
>> index 3e0091e..25fa1da 100644
>> --- a/transport.h
>> +++ b/transport.h
>> @@ -125,6 +125,7 @@ struct transport {
>>  #define TRANSPORT_PUSH_NO_HOOK 512
>>  #define TRANSPORT_PUSH_FOLLOW_TAGS 1024
>>  #define TRANSPORT_PUSH_CERT 2048
>> +#define TRANSPORT_ATOMIC_PUSH 4096
>
> For consistency with existing names, should this be TRANSPORT_PUSH_ATOMIC?

As always, thanks for a careful reading.  I missed everything you
pointed out (I agree with you).
