From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/2] strbuf: improve API
Date: Thu, 02 Jun 2016 14:58:22 +0200
Message-ID: <vpqwpm7n3wx.fsf@anie.imag.fr>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
	<1069084553.156626.1464607928755.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<20160601074218.GB14096@sigill.intra.peff.net>
	<20160601210713.GA18118@sigill.intra.peff.net>
	<5750147C.5060609@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 02 14:58:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8SCz-0000tr-Ur
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 14:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbcFBM6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 08:58:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38045 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbcFBM6l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 08:58:41 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u52CwLXJ024140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 2 Jun 2016 14:58:21 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u52CwMsu016615;
	Thu, 2 Jun 2016 14:58:22 +0200
In-Reply-To: <5750147C.5060609@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 2 Jun 2016 13:11:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 02 Jun 2016 14:58:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u52CwLXJ024140
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465477105.80425@StdP25bj7ab7fLXM2zWrOw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296197>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> 1. The amount of added code complexity is small and quite
>    encapsulated.

Actually, STRBUF_OWNS_MEMORY can even be seen as a simplification if
done properly: we already have the case where the strbuf does not own
the memory with strbuf_slopbuf. I already pointed places in
strbuf_grow() which could be simplified after the patch. Re-reading the
code it seems at lesat the call to strbuf_grow(sb, 0); in strbuf_detach
becomes useless. The same in strbuf_attach() probably is, too.

So, the final strbuf.[ch] code might not be "worse" that the previous.

I'm unsure about the complexity of the future code using the new API. I
don't forsee cases where using the new API would lead to a high
maintenance cost, but I don't claim I considered all possible uses.

> 2. The ability to use strbufs without having to allocate memory might
>    make enough *psychological* difference that it encourages some
>    devs to use strbufs where they would otherwise have done manual
>    memory management. I think this would be a *big* win in terms of
>    potential bugs and security vulnerabilities avoided.

Note that this can also be seen as a counter-argument, since it
may psychologically encourage people to micro-optimize code and use
contributors/reviewers neurons to spend time on "shall this be on-stack
or malloced?".

I think we already have a tendency to micro-optimize non-critical code
too much in Git's codebase, so it's not necessarily a step in the right
direction.

In conclusion, I don't have a conclusion, sorry ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
