From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Mon, 8 Aug 2011 23:27:34 +0200
Message-ID: <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com> <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org> <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
 <7vfwlbztfg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 23:28:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqXMy-00017M-Jf
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 23:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328Ab1HHV2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 17:28:15 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50553 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868Ab1HHV2O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 17:28:14 -0400
Received: by pzk37 with SMTP id 37so8916684pzk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 14:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HjNN/dlHwcnCQZ1Zla7+CfIh3ty7E+dgn7cBU+8qDVk=;
        b=sY9e4NzZ5ngLTHycTjJ62YfL/TUjUIwsFrH3jI6Rf69Op3MzDvDwTEHcppuXPCybto
         uxDKOeRHEFNny34r8/arKSggBOHbY1yLpL2CO1KWrLVJH7d56gCcMTOAQdfAvRCA04mm
         5JYPirNoOWqnK+pR0rZ2uP1JsiCyibO8pIYF0=
Received: by 10.143.13.10 with SMTP id q10mr6462686wfi.64.1312838894085; Mon,
 08 Aug 2011 14:28:14 -0700 (PDT)
Received: by 10.68.63.102 with HTTP; Mon, 8 Aug 2011 14:27:34 -0700 (PDT)
In-Reply-To: <7vfwlbztfg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178989>

Heya,

On Mon, Aug 8, 2011 at 19:47, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> If you do that, you're back to start. Since obj has not the faintest clue
>> whether the pending object was added from a negative or a positive ref.
>
> But the point is that this codepath does not have a faintest clue whether
> the "obj" parameter is something the end user actively asked for (which
> might have been marked as uninteresting for other reasons, namely, because
> it is reachable from other negative refs). So passing unconditional 0 is
> just as bad.

Doesn't passing 0 indicate that we _did not_ receive any explicit user
input on this ref, which is exactly what we want to record? If the
user passed us any explicit input on the ref, we record it at the
other call-sites, here, the user told us nothing, so we record exactly
that, nothing.

>> Is this not a little bit of a big, huge, tremendous overkill?
>
> As long as you can show your "flags" can (be extended to) express the same
> richness to solve sample problems I mentioned in my response, as well as
> your immediate issue, I wouldn't insist implementing a parsed struct/union
> that may be a more (and unnecessarily) verbose way to say the same thing.

I cannot recall you ever asking somebody to implement some feature
_nobody needs right now_ while trying to fix a _bug_, why now? I do
not know this code well enough to implement it, and Dscho doesn't have
the time to do it.

>> Or in other words: I'd rather stay with a simple, elegant, minimal patch
>> that solves the problem at hand while not preventing future enhancements.
>
> We are on the same page, but what I read from the patch didn't show a
> clear way forward to extend the "flags" to allow the stuff I mentioned

Nobody needs the stuff you mentioned right now. We do need this to fix
this bug. If someone else does want it at a later date, replacing it
will be exactly as much work with or without this patch.

> I would be reluctant to accept a myopic hack that is only good for one
> caller and that needs to be ripped out and re-done, especially when we
> already know other issues that can be solved cleanly if you go a little
> further in the initial round.

While I understand this reluctance, remember that this "one caller" is
required to fix a bug in the current code. If you had a similar
complaint about the remote-hg.py patches that I haven't sent yet, I
would be more than willing to invest the extra time in addressing
those concerns, since I'm adding new functionality anyway, this is
different.

> As I said, I am not married to the verbose struct/union representation
> (the only reason I showed that verbosity was because it allowed me to do
> away without having to enumerate all the syntax sugars we already
> support); if your "flags" can express the same thing (it may needs to
> become a bitfield with enough width, but I highly suspect that you would
> also need at least a component that says "this is the string the user gave
> us --- the user said 'master', not 'master^0', for example) and is a lot
> more compact, that is definitely we want to go with.

Don't we already store that in the name field?

-- 
Cheers,

Sverre Rabbelier
