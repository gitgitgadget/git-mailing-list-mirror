From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Fri, 24 Jul 2015 00:44:33 -0700
Message-ID: <CA+P7+xrmu-waa6OTg4f5Q_gcDbDz3d_5f7W1HfbmMHWyBSe3=A@mail.gmail.com>
References: <20150723012343.GA21000@peff.net> <xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
 <CA+P7+xoOkTfair3M7HH_TPs9qxBAUR5GodHGDuw8Ux_HaUvvyQ@mail.gmail.com> <20150724073415.GD2111@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 24 09:45:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIXfD-0003JL-FU
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 09:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbbGXHoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 03:44:55 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38874 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbbGXHox (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 03:44:53 -0400
Received: by iggf3 with SMTP id f3so10402910igg.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VibZVBjYyhrfONNCiqyrhf96UrHaMqjJook40YRpqSo=;
        b=kmZCyZwrHOzC5AHys82mZqlqDwa/9p2PtArn8eN0Mu96yXR/i8tx1V7P5bFvgNhL9b
         7ok6wTxz5ad2E5uyLtbnmeSb9QZsdbHlFUvYarbeASuXzbkpIZz+jeOPr2jySOSOMTBB
         p+zu/euMtb8DzbkRrAzfMx3GgodSxg58qPbwYh3fH5QDjCcBkgFRKh25H1OK08/SgKz5
         ysw1N3So6uk9PAwLwYQgfdtU5h1+rQvr2QczBsD7pLFzY9r5PtUESJ/4ZrRtqn9VWDB4
         gEER8Ig0d+k5nmI9DwglIidBxvx89AqRjP76NNLpT8kNq0q1C12rak1ZkHaX/er+jJ53
         4oPg==
X-Received: by 10.107.6.231 with SMTP id f100mr18944206ioi.61.1437723893125;
 Fri, 24 Jul 2015 00:44:53 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Fri, 24 Jul 2015 00:44:33 -0700 (PDT)
In-Reply-To: <20150724073415.GD2111@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274561>

On Fri, Jul 24, 2015 at 12:34 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 23, 2015 at 11:07:58PM -0700, Jacob Keller wrote:
>
>> I think some projects definitely benefit from the first-parent setup,
>> and it could be valuable, but I do tend to agree with Junio here that
>> the mess is always helpful. If may be helpful if people's commit
>> messages on that mess are good, but generally those that don't take
>> the time to rebase local work and re-express the commit messages are
>> not going to leave insightful messages the first time. However, have
>> the ability to view history this way is still possibly valuable.
>
> I think a really simple example is something like:
>
>   1. somebody implements as feature. It needs to handle cases a, b, and
>      c, but it only handles case a. Therefore it is buggy.
>
>   2. During review, somebody notices case b, and a new commit is made to
>      fix it. Nobody notices case c.
>
>   3. The topic is merged.
>
>   4. Much later, somebody notices the system is buggy and hunts in the
>      history.
>
> In a "clean" history, the patches from steps 1 and 2 are squashed. While
> reading the history, you see only "implement feature X", and no mention
> of the bug and its fix. But even if the person writes a terrible commit
> message for step (2), even seeing it pulled out into its own diff shows
> the exact nature of the already-seen bug, and may make it more obvious
> to realize that case (c) is a problem.
>
> I realize that's kind of vague. Another way to think about it is: in a
> squashing workflow like git.git, any time you have to turn to the
> mailing list to read the original sequence of re-rolls, you would have
> been better off if that information were in git. That's a minority case,
> but I certainly have turned to it (in some cases, the "fix" from our
> step 2 above actually introduces the new bug, and it's nice to see the
> reasoning that went into it :) ).
>

Actually this and the GitHub workflow make sense to me. I am concerned
like you are about what to do in the case for passing commits.. maybe
just make the option turn it on only if no arguments are passed (ie:
"git log") and clearly document that it does not enable the behavior
for arbitrary commits? That would make it useful without being too
confusing nor too magical. Though, it does mean if you do pass a
commit and want it on you'd have to specify.. I certainly would find
it more confusing to have it enabled if I pass an arbitrary commit..
Maybe not though, I am not 100% sure on that.

> Not that I am advocating for git.git to move to such a workflow. I think
> on balance the "clean" history is nicer to work with. I am only arguing
> that keeping the messy history is not without value; there are some
> cases where it is nice to have (and we keep it in the list archive,
> which is a minor pain to access compared to git).
>
> -Peff

For projects which make this easier (pull request style) I think this
is making more sense. I'm not sure exactly whether it would be best to
only enable via "git log" with no parameters, but it does seem weird
to turn this on and then accidentally get the behavior on a random
commit log sequence.... Maybe it's not a huge deal either way though..

Regards,
Jake
