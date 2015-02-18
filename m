From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Wed, 18 Feb 2015 18:04:43 +0100
Message-ID: <vpqwq3fup5g.fsf@anie.imag.fr>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com>
	<vpqtwyl90mx.fsf@anie.imag.fr>
	<340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com>
	<vpqiof14qu8.fsf@anie.imag.fr>
	<13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com>
	<vpqr3tozzs5.fsf@anie.imag.fr>
	<xmqqwq3g31hj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fairuzan Roslan <fairuzan.roslan@gmail.com>, git@vger.kernel.org,
	tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 18:05:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO83Z-0005xJ-5s
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 18:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbbBRRE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 12:04:57 -0500
Received: from mx2.imag.fr ([129.88.30.17]:42287 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbbBRRE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 12:04:56 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t1IH4gb6020518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Feb 2015 18:04:42 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1IH4hXr024950;
	Wed, 18 Feb 2015 18:04:43 +0100
In-Reply-To: <xmqqwq3g31hj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 17 Feb 2015 09:13:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 18 Feb 2015 18:04:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1IH4gb6020518
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1424883884.08803@42azfHPL82mtfmDx3q/z+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264029>

Junio C Hamano <gitster@pobox.com> writes:

> in compat/broken-unlink.c and something like this
>
> 	#ifdef BROKEN_UNLINK
> 	#define unlink(x) workaround_broken_unlink(x)
>         #endif
>
> in git-compat-util.h instead? 

That means we have to know BROKEN_UNLINK at compile-time. I had never
heard about AFP before this thread, but they seem mountable on Linux and
Windows. I don't know whether these platforms will have the same issue,
but I suspect they will (if the server rejects the unlink).

So, if my suspicion is right, we'd have to activate it on any platform
able to mount AFP, i.e. essentially everywhere.

> That way, people on well behaving systems do not have to worry about
> clobbering errno and stuff, perhaps?

With my solution, unlink() is always the last call in the function, so
it should behave correctly right? Or did I miss anything?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
