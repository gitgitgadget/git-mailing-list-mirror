From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 0/2] strbuf: improve API
Date: Thu, 2 Jun 2016 16:22:05 +0200
Message-ID: <20160602142205.GA5566@Messiaen>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <1069084553.156626.1464607928755.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <20160601074218.GB14096@sigill.intra.peff.net>
 <20160601210713.GA18118@sigill.intra.peff.net>
 <5750147C.5060609@alum.mit.edu>
 <vpqwpm7n3wx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 02 16:22:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8TVq-0003uF-16
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 16:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbcFBOWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 10:22:12 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:50477 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932761AbcFBOWK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 10:22:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 16BAE256C;
	Thu,  2 Jun 2016 16:22:07 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yigxZbsLTn_G; Thu,  2 Jun 2016 16:22:07 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0597C256B;
	Thu,  2 Jun 2016 16:22:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id F2F2B2077;
	Thu,  2 Jun 2016 16:22:06 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Fd9-yZobvhj; Thu,  2 Jun 2016 16:22:06 +0200 (CEST)
Received: from Messiaen (eduroam-033123.grenet.fr [130.190.33.123])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id D5BC22064;
	Thu,  2 Jun 2016 16:22:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <vpqwpm7n3wx.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296200>

On Thu, Jun 02, 2016 at 02:58:22PM +0200, Matthieu Moy wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> 1. The amount of added code complexity is small and quite
>>    encapsulated.
> 
> Actually, STRBUF_OWNS_MEMORY can even be seen as a simplification if
> done properly: we already have the case where the strbuf does not own
> the memory with strbuf_slopbuf. I already pointed places in
> strbuf_grow() which could be simplified after the patch. Re-reading the
> code it seems at lesat the call to strbuf_grow(sb, 0); in strbuf_detach
> becomes useless. The same in strbuf_attach() probably is, too.
> 
> So, the final strbuf.[ch] code might not be "worse" that the previous.
> 
> I'm unsure about the complexity of the future code using the new API. I
> don't forsee cases where using the new API would lead to a high
> maintenance cost, but I don't claim I considered all possible uses.
> 
>> 2. The ability to use strbufs without having to allocate memory might
>>    make enough *psychological* difference that it encourages some
>>    devs to use strbufs where they would otherwise have done manual
>>    memory management. I think this would be a *big* win in terms of
>>    potential bugs and security vulnerabilities avoided.
> 
> Note that this can also be seen as a counter-argument, since it
> may psychologically encourage people to micro-optimize code and use
> contributors/reviewers neurons to spend time on "shall this be on-stack
> or malloced?".
> 
> I think we already have a tendency to micro-optimize non-critical code
> too much in Git's codebase, so it's not necessarily a step in the right
> direction.
> 
> In conclusion, I don't have a conclusion, sorry ;-).

Thank you all for your input and your tests, those are very valuable!
Me and Simon have to take a decision, as this contribution is part of a
school project that comes to an end. We won't have the time to create
tests that are representative of the use of strbuf in the Git codebase
(partly because we lack knowledge of the codebase) to settle on whether
this API improvement is useful or not.

Jeff made very good points, and the tests we ran ourselves seem to
agree with yours. That being said, the tests made by Michael, more
detailed, suggest that there may be room for an improvement of the
strbuf API (even thought that's to confront to the reality of the
codebase).

Having little time, we will refactor the patch and send it as a V2: this
way, if it appears one day that improving the API with stack-allocated
memory is indeed useful, the patch will be ready to merge :)
