From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Fix a signal handler
Date: Tue, 23 Feb 2010 09:55:45 +0100
Message-ID: <4B839811.6040109@web.de>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de> <4B72E81B.3020900@web.de> <20100210173348.GA5091@coredump.intra.peff.net> <4B76A985.9070809@web.de> <20100214064745.GC20630@coredump.intra.peff.net> <7vsk94qfuy.fsf@alter.siamese.dyndns.org> <4B7D6B7A.1090004@web.de> <7veikib96d.fsf@alter.siamese.dyndns.org> <4B82744B.4060805@web.de> <7v1vgdgm02.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 09:55:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjqYf-0001cl-8b
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 09:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411Ab0BWIzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 03:55:51 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:42334 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab0BWIzv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 03:55:51 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id A890714F689F4;
	Tue, 23 Feb 2010 09:55:49 +0100 (CET)
Received: from [78.49.33.20] (helo=[192.168.1.202])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NjqYX-0002al-00; Tue, 23 Feb 2010 09:55:49 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <7v1vgdgm02.fsf@alter.siamese.dyndns.org>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX18ahLbMurh1p/mb352dttGC5Z1aLhnC1C/qIMXw
	izFa8/cfYlogI3vxgv7S2Z4i5f70K7rNdabKgBB11KKSxMjGuN
	BFRKPNTT40emjr19W0AQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140778>

>     Subject: [PATCH] log --early-output: signal handler pedantic fix

I would prefer a correct and portable approach here instead of a "pedantic" one.
  ;-)


> I'd phrase the above like this:

It might be that the suggested commit message was too terse.


>     The behavior is undefined if the signal handler refers to any object
>     other than errno with static storage duration other than by assigning
>     a value to a static storage duration variable

I would not repeat the specification of undefined behaviour if a reference to a
standard like POSIX will be sufficient.


> and that would be sufficiently clear without saying anything else.

It seems that we have got different opinions about the clarity of signal handling.


> Your proposed log message also needs to make a good counter-argument why
> the above "we purposely avoid using sigatomic_t --- it is not worth the
> hassle of having to deal with systems that lack this type in practice" is
> worried too much, and it now is sensible to assume that everybody has
> sigatomic_t these days to allow us do "the right thing".

This data type is actually not used (because an underscore is missing in the
name).   ;-)


> It can be just as simple as 'Output from "git grep sigatomic_t" indicates
> that we are already using it.' but you need to say something, as this
> comment you are removing makes it clear that it was not a bug by mistake
> or ignorance, but instead was a deliberate choice.

Should I really add to the log message that there is another user for it like
the source file "progress.c"?


> According to POSIX, "s-e-o" has to be "volatile sig_atomic_t".

How do you think about informations from a discussion on a topic like 'Is
"volatile sig_atomic_t" redundant'?
http://groups.google.de/group/comp.lang.c/browse_frm/thread/da3118a2d2c0737c/718dc093b83e03f8?#718dc093b83e03f8


> Also we do not explicitly initialize bss variables to zero or NULL.

If we would like to insist on the implementation of a strictly conforming
program, the source code should be restructured even more.
https://www.securecoding.cert.org/confluence/display/seccode/SIG31-C.+Do+not+access+or+modify+shared+objects+in+signal+handlers

The variable "show_early_output" should be moved to the source file
"builtin-log.c" where it will become "static". Other means would be needed to
transfer corresponding state changes to the function "path_name".

Regards,
Markus
