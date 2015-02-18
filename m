From: Junio C Hamano <gitster@pobox.com>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Wed, 18 Feb 2015 09:31:43 -0800
Message-ID: <xmqqy4nv2kjk.fsf@gitster.dls.corp.google.com>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com>
	<vpqtwyl90mx.fsf@anie.imag.fr>
	<340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com>
	<vpqiof14qu8.fsf@anie.imag.fr>
	<13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com>
	<vpqr3tozzs5.fsf@anie.imag.fr>
	<xmqqwq3g31hj.fsf@gitster.dls.corp.google.com>
	<vpqwq3fup5g.fsf@anie.imag.fr>
	<xmqq4mqj3zyx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fairuzan Roslan <fairuzan.roslan@gmail.com>, git@vger.kernel.org,
	tboegi@web.de
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 18 18:31:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO8TY-0003FK-TH
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 18:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbbBRRbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 12:31:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64170 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752937AbbBRRbp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 12:31:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7C1F38A7B;
	Wed, 18 Feb 2015 12:31:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yc2p4ssaG8bdPUvwZSxZ3N565Xg=; b=j/4JNO
	W/6bdkrAmyXqmjP/zeBvK2b0iUnnzSTV1mQiYlbSk/45JOGIgKBllS71OyfFOxmD
	755RX/27r19kkjad4KR0m6LZbBGANBh6zfwIu9R9SKGrvSr1DlHs8aTgC/4M+4yF
	oLr1mLuqvq4RANue3Ozb6+F60Zb0Pb/rh5aBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=szpje+AgF4PrAfyZgN6R+jU3i/wTDxcP
	c/oqvbnU8WK8zAfxTEtqAUUEA27Rpmnque6+Rx0dVUbEbE7Me2FQRMBda7F9rQmT
	NmY+jgYdcTz/Yy/EAZxsVPW5vmoDybWxtLY/RPMoUFQ/DO7AXrIrcUJr00cyGeDf
	Nt75yeTZ2Yk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD08A38A79;
	Wed, 18 Feb 2015 12:31:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D78338A77;
	Wed, 18 Feb 2015 12:31:44 -0500 (EST)
In-Reply-To: <xmqq4mqj3zyx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 18 Feb 2015 09:13:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 01ECA9B8-B794-11E4-9A09-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264032>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> in compat/broken-unlink.c and something like this
>>>
>>> 	#ifdef BROKEN_UNLINK
>>> 	#define unlink(x) workaround_broken_unlink(x)
>>>         #endif
>>>
>>> in git-compat-util.h instead? 
>>
>> That means we have to know BROKEN_UNLINK at compile-time. I had never
>> heard about AFP before this thread, but they seem mountable on Linux and
>> Windows. I don't know whether these platforms will have the same issue,
>> but I suspect they will (if the server rejects the unlink).
>>
>> So, if my suspicion is right, we'd have to activate it on any platform
>> able to mount AFP, i.e. essentially everywhere.
>
> Sigh.

That is "Sigh.  It is unfortunate but you are correct.".

Perhaps we would need to do something ugly like this:

 * add "core.brokenUnlink" configuration (or whatever we end up
   calling this filesystem trait) and add "int broken_unlink" in
   environment.c (declare it in cache.h).

 * in init-db.c, autoprobe by doing something like this:

    create a test file with 0444 permission bits;
    if (unlink(that test file)) {
	chmod(that test file, 0644);
        if (!unlink(that test file)) {
		broken_unlink = 1;
		git_config_set("core.brokenunlink", broken_unlink);
	} else {
        	die("aaargh");
	}
    }

 * Do your unlink_or_chmod() thing in wrapper.c, but perhaps call it
   xunlink(), like this:

        int xunlink(...) {
		int ret = unlink(...);
		if (broken_unlink && ret) {
                        chmod(..., 0644);
                        ret = unlink(...);
                }
                return ret;
        }

We probably need something similar for xrename()?
	
