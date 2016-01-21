From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] git submodule: Teach add to accept --group
Date: Wed, 20 Jan 2016 16:08:40 -0800
Message-ID: <xmqq37tr3ibb.fsf@gitster.mtv.corp.google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-2-git-send-email-sbeller@google.com>
	<xmqq1t9c54qz.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaHLkQpaHOY2aqPgdNvWjmpbuMZSogqzPkkVHRUXyibYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 01:08:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM2nv-0006Qx-Jk
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 01:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbcAUAIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 19:08:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750886AbcAUAIm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 19:08:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C41DE3EE6A;
	Wed, 20 Jan 2016 19:08:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=URA6d6kBTFUGDuKCVW9YCysWODc=; b=SmI9CV
	SAxIwWNUIw3ncz0tQOIeID06lvo/Jx7dGf9yQ91aRF8U4z6YnpVAofVxui00dqBx
	VREnQJA67vwU9hdBcRKgiGlrWqQ5iSJM8zAm0mQHsfRsokXSFF4ZQmic56AN7w5H
	sxtPhWnLIj8A+imetbMM84fZ08GQNGQqnDaFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ftBYThdX2sMA9Ldo6paTVcJK+IpluVHO
	Q7D+qEIME1J6n1GA3Ohm1mXq8/+Ci7B9h1NMk7rBwgLdUbuSoGwhZ5uQfNe323mN
	mN7jSzCeo28SdWGucgGRItmJA/p7cSjEqTkPZZSHGKjfCT/pcmHBHaE8+zN/yU2z
	8yEu2mcZcRQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BCD043EE68;
	Wed, 20 Jan 2016 19:08:41 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 417193EE67;
	Wed, 20 Jan 2016 19:08:41 -0500 (EST)
In-Reply-To: <CAGZ79kaHLkQpaHOY2aqPgdNvWjmpbuMZSogqzPkkVHRUXyibYw@mail.gmail.com>
	(Stefan Beller's message of "Wed, 20 Jan 2016 15:57:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 20BB5EAA-BFD3-11E5-9457-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284489>

Stefan Beller <sbeller@google.com> writes:

>>> @@ -165,6 +166,10 @@ cmd_add()
>>>               --depth=*)
>>>                       depth=$1
>>>                       ;;
>>> +             -g|--group)
>>> +                     submodule_groups=${submodule_groups:+${submodule_groups};}"$2"
>>> +                     shift
>>> +                     ;;
>>
>> You would want to accept "--group=<name>" as well, just like
>> existing --reference and --depth do.  It won't be much more code,
>> and when you move to C (hence parse_options) you'd get it for free
>> anyway.
>
> I am not sure, if I will to move `add` to C any time soon. Sure I desire
> less shell and more C[1], but I'd think my time could be spent better than
> just converting scripts to C. Sometimes I have to though, such as in the
> case of `init` as the the call out from C to shell is too ugly and the effort to
> do that is not that much less.

You can do so in less time than you spent making the above 5-line
excuse.  It won't be much more code, and it is not ugly at all.

	--group=*)
        	group=$group ${1#--group=} ;;

or something, right?
