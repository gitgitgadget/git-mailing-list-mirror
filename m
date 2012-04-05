From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push.default: current vs upstream
Date: Thu, 05 Apr 2012 18:46:51 +0200
Message-ID: <vpqwr5uceis.fsf@bauges.imag.fr>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
	<vpqty12h995.fsf@bauges.imag.fr>
	<20120405131301.GB10293@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 18:47:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFpqV-0003rc-U1
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 18:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094Ab2DEQre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 12:47:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46242 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760Ab2DEQrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 12:47:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q35GfKCO023794
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Apr 2012 18:41:20 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SFppk-00036V-O8; Thu, 05 Apr 2012 18:46:52 +0200
In-Reply-To: <20120405131301.GB10293@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 5 Apr 2012 09:13:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 05 Apr 2012 18:41:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q35GfKCO023794
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334248883.4525@jIaYaGoxIeiKp4uNM1PM9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194788>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 02, 2012 at 09:40:22AM +0200, Matthieu Moy wrote:
>
>> For the others, they already have to learn about the "upstream"
>> semantics. And making argumentless "git pull" and "git push" purposely
>> asymetric to make it simple for the user sounds like an oxymoron to me.
>
> We can make the operations technically symmetric in terms of the actual
> sources and destinations from which commits are moved, but they are not
> necessarily symmetric in the user's workflow.

It seems rather natural to me to have "asymetric workflow, asymetric
commands" by default. So, if one wants to push to a place other than
upstream, say "git push public-repo branch", or set your upstream to
where you want to push (simple with "git push -u"), and say explicitely
"git pull repo branch".

I can hardly imagine someone knowing what "git pull" does, and
_surprised_ to see that "git push" sends commits to the same place. I
agree that sending commits to upstream may be a mistake, but I don't
think it can happen "by surprise".

There are also ways to shoot yourself in the foot with when setting
upstream to something other that where you usually push. For example,
run "git rebase -i" without argument, and it will offer you to rewrite
some published history. "git pull --rebase" also becomes a potentially
dangerous operation, while it's normally harmless with
'push.default=upstream'.

And I still have my concern with real beginners: what advice would you
give to a user whose "git push" is denied because of non-fast forward. I
raised this concern already:

  http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=193196

and I essentially had the answer "telling the user to pull is wrong"
(with which I disagree), but no one managed to give another advice.

With real-real-newbies, this is my number 1 issue (they don't even do
branches, they just run push, git tells them to pull, and they come to
me saying "git is broken, we can't work"). With not-so-newbies, I have
less experience ;-).

>> The discussion seems to focuse on 'let's make "git push" easy to
>> explain', but I think the right thing to do is to make _Git_ easy to
>> explain. With "push.default = current", we'll have a hard time
>> explaining how "git pull" works.
>
> Do we have a hard time explaining how "git pull" works now?

I don't think so, but Junio's argument is that explaining what push
would do with 'upstream' would be too complex, and that 'current' is
easier to explain. If 'git pull' is simple, then 'git -c
push.current=upstream push' is equally simple.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
