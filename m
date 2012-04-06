From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push.default: current vs upstream
Date: Fri, 06 Apr 2012 09:44:48 +0200
Message-ID: <vpqr4w12tjj.fsf@bauges.imag.fr>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
	<vpqty12h995.fsf@bauges.imag.fr>
	<20120405131301.GB10293@sigill.intra.peff.net>
	<vpqwr5uceis.fsf@bauges.imag.fr>
	<20120406071520.GD25301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 09:45:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG3r5-0001jj-IY
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 09:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab2DFHpC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 03:45:02 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42886 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543Ab2DFHpB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 03:45:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q367dEqZ013361
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Apr 2012 09:39:14 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SG3qj-0003vz-Ea; Fri, 06 Apr 2012 09:44:49 +0200
In-Reply-To: <20120406071520.GD25301@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 6 Apr 2012 03:15:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 06 Apr 2012 09:39:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q367dEqZ013361
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334302756.75996@AkWelEfZI4veERKt3N9Bbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194857>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 05, 2012 at 06:46:51PM +0200, Matthieu Moy wrote:
>
>> It seems rather natural to me to have "asymetric workflow, asymetric
>> commands" by default. So, if one wants to push to a place other than
>> upstream, say "git push public-repo branch", or set your upstream to
>> where you want to push (simple with "git push -u"), and say explicitely
>> "git pull repo branch".
>
> That makes sense _if_ the user is thinking about pull and push as
> symmetric commands. That may be immediately obvious for some people's
> mental models. But I suspect it is not for others (it is not for mine,
> though I obviously do not count as a beginner).

I think exactly the opposite. Once you learnt about remote-tracking
branches, about "git fetch" Vs "git pull", you understand why "git pull"
and "git push" are not strictly speaking symmetrical operations.

But just from the wording, it should be obvious that the commands are
doing something somehow symmetrical.

> So shouldn't the advice for a non-fast-forward push be:
>
>    if $source_ref is currently checked out
>            advise "git checkout $source_ref, and then..."
>    fi
>    if $dest_remote == branch.$source_ref.remote &&
>       $dest_ref == branch.$source_ref.merge
>            advise "git pull"
>    else
>            advise "git pull $dest_remote $dest_ref"
>    fi
>
> That handles only one ref, of course. If you get multiple non-ff
> failures, I'm not sure what we should advise.

The topic ct/advise-push-default does essentially that indeed.

> You wrote above that we'll have a hard time explaining how "git pull"
> works. But I don't think so; if it hasn't been a problem with
> "matching", then why would it with "current"?

I mis-spoke. I think I meant something like "if the assumption that
explaining push -c push.current=upstream is hard, then we'll have a hard
time explaining git pull".

> I'm less concerned with explaining and more concerned about safe
> defaults.

Yes, my rant about simplicity was a reply to Junio, who was arguing
about simplicity:

Junio C Hamano writes:

| Obviously the former ["current"] is much simpler to explain and understand, as
| people do not have to learn upstream tracking before doing their first
| "push".

Your arguments about safety are valid (we don't agree on the relative
importance), but I think the argument of simplicity simply doesn't hold.

About safety, I don't think we can tell in general which bad push is the
most serious. push.default=current may create branches unexpectedly,
while push.default=upstream would ask you to "push --set-upstream" when
creating the remote branch. push.default=upstream may push to the master
when you wanted to create a remote topic branch. My feeling is that both
are equally bad, but maybe I'm wrong here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
