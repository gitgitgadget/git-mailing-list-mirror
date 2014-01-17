From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Fri, 17 Jan 2014 11:11:28 -0800
Message-ID: <xmqqzjmuwhi7.fsf@gitster.dls.corp.google.com>
References: <20140117041430.GB19551@sigill.intra.peff.net>
	<20140117042153.GB23443@sigill.intra.peff.net>
	<398F146D-72F1-44CD-B205-729665FD8765@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Yuri <yuri@rawbw.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 20:11:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4EpN-0004IH-GE
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 20:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbaAQTLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 14:11:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51798 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbaAQTLc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 14:11:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58850627FF;
	Fri, 17 Jan 2014 14:11:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=45qVXAsa+Jh+YKGync4ePbbhjjQ=; b=SEcXNQ
	KOLOr2gIorM0t1HtJNERu9g930gusxj4/b32SVj/AjmSa7ccRJ2VZnc29hY50LQc
	1X10C0Um6ZmQBGZIHpGht+npGSy4q+dbi3hFcxsRp+wpw+fhgnfZ4hWVZPSn4xeR
	Cfmdukvv6IkYMeob5FWI+QEiVtdjnBS7WqXwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kP/pqIm2cNIBmIj/Hdkrnimltj+CWTW2
	9z/qx/IU1l6lS02t+y+v0zgiECsNgmNDqSIBo1doYLBu7Z4IiQXINZ9DTZcrM0RJ
	y2oUCDxFmXj5u61C4eR8SeFW37/pgHE2T3qYbZ2IiPu5NXjiWxKg8+vseI9wxxXL
	Dd9YBFVjB9E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47B56627FE;
	Fri, 17 Jan 2014 14:11:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 914F0627FD;
	Fri, 17 Jan 2014 14:11:30 -0500 (EST)
In-Reply-To: <398F146D-72F1-44CD-B205-729665FD8765@gmail.com> (Kyle J. McKay's
	message of "Thu, 16 Jan 2014 23:26:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2C073974-7FAB-11E3-ABAB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240611>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> On Jan 16, 2014, at 20:21, Jeff King wrote:
>> When we run the pager, we always set "LESS=R" to tell the
>> pager to pass through ANSI colors. On modern versions of
>> FreeBSD, the system "more" can do the same trick.
> [snip]
>> diff --git a/pager.c b/pager.c
>> index 90d237e..2303164 100644
>> --- a/pager.c
>> +++ b/pager.c
>> @@ -87,6 +87,10 @@ void setup_pager(void)
>> 		argv_array_push(&env, "LESS=FRSX");
>> 	if (!getenv("LV"))
>> 		argv_array_push(&env, "LV=-c");
>> +#ifdef PAGER_MORE_UNDERSTANDS_R
>> +	if (!getenv("MORE"))
>> +		argv_array_push(&env, "MORE=R");
>> +#endif
>
> How about adding a leading "-" to both the LESS and MORE settings?
> Since you're in there patching... :)

The discussion we had when LV=-c was added, namely $gmane/240124,
agrees.  I however am perfectly fine to see it done as a separate
clean-up patch.
