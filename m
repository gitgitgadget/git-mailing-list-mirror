From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] transport-helper: clarify pushing without refspecs
Date: Thu, 18 Apr 2013 10:29:30 -0700
Message-ID: <7v38un7nnp.fsf@alter.siamese.dyndns.org>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
	<1366258473-12841-4-git-send-email-felipe.contreras@gmail.com>
	<20130418101133.GW2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Apr 18 19:29:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USsea-0001vx-GB
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 19:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967181Ab3DRR3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 13:29:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967001Ab3DRR3n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 13:29:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C307117476;
	Thu, 18 Apr 2013 17:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=5tSkDx8Tir18/2yy0FBTNprEeZg=; b=mz8BGVtILamMYwJ7Asce
	RagKy7FopjapH5E5XQf1PWlF5WYVk8w+D04WAWxuu5uMqaW73LMVHrTAdcxR/NjQ
	XPRL0JFLJzrK49FQVun3+5vOQKAEW+vZ2+9FQPOvroTYqPZK05IMoguH91Y+QExq
	vg4SNpGuitJ4gfe1o2te56I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=STtJCXlR99iKx/Opyyqd6+oACeyerSk3JoN31ieIKmsbNW
	6kkHzxzmrJWkaJrnedqsNbgooF29Iw/COAHPyY+7ZNWaPOizzcCzBjZc0fl1Y1+i
	aAjxFNIIdDNRdl65YUYbZrR91P1QTrhFU0fPLrXF8YLMhzeKI3ZiToEoqzqBE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B668917475;
	Thu, 18 Apr 2013 17:29:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36EC617474;
	Thu, 18 Apr 2013 17:29:32 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 880ECFE2-A84D-11E2-99A5-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221674>

John Keeping <john@keeping.me.uk> writes:

>> +	It is recommended that all importers providing the 'import'
>> +	capability use this. It's mandatory for 'export'.
>
> s/It's/It is/

I personally do not care _too_ deeply either way, but I agree our
documentation tends to use the latter more and being consistent
would be good.

>> diff --git a/transport-helper.c b/transport-helper.c
>> index cea787c..4d98567 100644
>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -785,6 +785,9 @@ static int push_refs_with_export(struct transport *transport,
>>  	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
>>  	struct strbuf buf = STRBUF_INIT;
>>  
>> +	if (!data->refspecs)
>> +		die("remote-helper doesn't support push; refspec needed");
>
> I think the "refspec needed" text is likely to be confusing if an
> end-user ever sees this message.  I'm not sure how we can provide useful
> feedback for both remote helper authors and end-users though.

This "refspecs" only come via the helper and not directly from the
end user, no?

If that is the case, I do not think "confusing" is much of an issue.
Not _("localizing") is also the right thing to do.  We may want to
say "BUG: " at front to clarify it is not the end-user's fault, but
a problem they may want to report.  If we at this point know what
helper attempted export without giving refspecs, it may help to show
it here, so that developers will know with what helper the user
had problems with.
