Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D61C11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 01:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B78206E2
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 01:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQ1+FUv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgBUBIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:08:38 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:39702 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbgBUBIh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 20:08:37 -0500
Received: by mail-oi1-f177.google.com with SMTP id z2so386145oih.6
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 17:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BQC2nxtEti2jJedWgQ5CQSP6W28XuQ391HnhHA9Ydt0=;
        b=pQ1+FUv1uV4KWugQs2WLRwXkuOx+lxL/gHcRhrB4cmedKJfpiZioeATg29XqoR2hEq
         YNPu3/8xNtDJS7kNRIo35ibIrr6shV9Yy/5w+jW2+wNurEvkQxMOPAudhn8KpsgSOwFI
         2OYmAasDC/jCMw9UwDFN8zJ7sfEL6X81dLhtqPMeFec0wwRZmrWlyfyo0gm4yM84IomH
         CClEurA/9qJnYwf5w9VKsA+XK4wq+V771mzuAwsFGD4ZEsHoh6nKKHhqPSwfPdy/aip5
         Low7iou7XlMJe0q/Sjz6qCMVX/bFVXrRMUOBkymJgG+3NjuyAAQYW6DkkocCnpU7NdEM
         b2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BQC2nxtEti2jJedWgQ5CQSP6W28XuQ391HnhHA9Ydt0=;
        b=QRKvU3vCoWjs03bt5CLW1hZHBQ1kdXKFkgz2lbYev93Vcfc77dI6HjUOlj26nWf7yZ
         io6KFw0XZweKpvh5KP0YvFHyV0vGh5z+aqPt+qP1UW9F7afWSEM/veUes5bOhqW2vV+R
         RtV8fAos/Fu5nC7gOZV1p66t2ccI4tApQHh4gJlvPwifPfpfVxl94tVP6yR0gfyjH9hU
         mp05b1MMTmILfYqTa+lUrNtRcKysOHKdN1T15f+bFoxYBe8DLIgjzIB12CxVL9r8Q7jT
         9IhQdCxVKBdHZE5peMwPvk0+9tsgJRmP6MRYBNhnEsa3I4uN/GRx+nyUlkTJYeXTYMXM
         xqlw==
X-Gm-Message-State: APjAAAXCsBn6ahhRqr7hSLRgSYmGH9Zocakq4RFRWHRf7lfgL4+kgMkD
        WjJUmQ11fzxm362T08gpm+jgOKzD1kXUIigxyvc=
X-Google-Smtp-Source: APXvYqxhJl97hoxolcInZSPdkvpZOX/ffAg1nIxSkn8v8qqIcZTa63293RhNMlvdBgZT9xo+Iz/F35WSyUYcrWFKW+A=
X-Received: by 2002:aca:a9c3:: with SMTP id s186mr8945oie.31.1582247316557;
 Thu, 20 Feb 2020 17:08:36 -0800 (PST)
MIME-Version: 1.0
References: <BL0PR2101MB1089AA571A3277AEF4798B5D80120@BL0PR2101MB1089.namprd21.prod.outlook.com>
In-Reply-To: <BL0PR2101MB1089AA571A3277AEF4798B5D80120@BL0PR2101MB1089.namprd21.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 20 Feb 2020 17:08:25 -0800
Message-ID: <CABPp-BHJeAfj0=OWLeU8UuXtAu1-cCCLs4O_rLqiDHxGbMEhAQ@mail.gmail.com>
Subject: Re: BUG: git clean -d cannot remove files from read-only directories
To:     Adam Milazzo <Adam.Milazzo@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 4:52 PM Adam Milazzo <Adam.Milazzo@microsoft.com> w=
rote:
>
> The fragmenting and duplication of this discussion via email is unfortuna=
te, but I'm not sure what can be done about that.
>
> > Yeah, arguing to change existing behavior (as you started with by label=
ling the thread with "BUG") will probably get you a lot of pushback, but le=
t me address your new angle of suggesting a new option...
>
> Sorry if the subject prefix annoyed people, but I wasn't trying to. There=
's no template that I could find for bug reports... sorry, feature suggesti=
ons. :-)
>
> I appreciate your responding to my arguments here and you make some good =
objections. I'm not sure at this point that they're insuperable, but let me=
 try to respond.
>
> > Let's say we did implement a new flag that said we should override stan=
dard permissions. In such a case, shouldn't ACLs also be overridden?
>
> Maybe, and probably ideally. I suppose it depends in part on the difficul=
ty of implementation. I don't know how other tools, like rsync (which has n=
o problem deleting files from read-only directories), handle ACLs. But I wo=
uld say that if rsync can do it then Git can do it.
>
> > Can we handle that in any semi-portable fashion? Assuming we do attempt=
 to override ACLs, do we destroy portability of git?
>
> I don't know. I know there are POSIX ACLs, but I'd be surprised if even t=
he POSIX layer on Windows implements them, for example. I've never used a U=
nix-like system with ACLs. I'd be tempted to say again "do what rsync does"=
, but I don't actually know what that is and don't have an easy way to test=
 it out. I think Unix-like systems with ACLs are very rare, much less than =
1% of installations, but of course Windows is ACL-based.

Yeah, I know almost nothing about ACLs so I don't know the answer to
the questions either...

> Let me turn your questions around. Git knows about, tracks, and stores st=
andard Unix file permissions. It manipulates them and cares about them. Wha=
t about ACLs? Does Git apply the same versioning to ACLs as it does to file=
s? If the answer is "no", as I expect, doesn't that mean Git's portability =
is already "destroyed", or nonexistent? And that therefore it's wrong for G=
it to even try to maintain Unix file permissions since they don't apply to =
all operating systems? I could put it another way: since Git knows and care=
s about and already manipulates Unix file permissions but (presumably) not =
ACLs, it is not inconsistent with the current design to continue doing exac=
tly that - supporting Unix permissions but not ACLs - in new features.

Hehe, but you left an opening for your turn around to be turned
around...  Git does not actually track standard Unix file permissions.
It _only_ tracks the executable bit (and not a separate one for user &
group & other, but just an overall is-executable or not).  Of
particular note for this discussion is that it does not track the
writable bit.  So, wouldn't it be in line with the way Git already
behaves to not touch the writable permission?  :-)

> > If we don't try to overrule ACLs, doesn't that defeat your whole argume=
nt that "git clean" (with various levels of forcing) is about trying to do =
as much as possible to put the repository in a clean state?
>
> I think the discussion of "would it be a good feature?" is fairly indepen=
dent from the question of "is it easy to implement?". The question of what =
"git clean" is about is separate from the question of what limitations we m=
ight have due to implementation difficulties. You've probably seen the "Kno=
wn limitations" sections of many man pages. If you can solve 90% of a probl=
em with 10% of the effort, it's usually reasonable to do so. I.e. "don't le=
t perfection be the enemy of good" and all that. And I suspect explicit ACL=
 support is missing from Git generally, so having another feature without e=
xplicit ACL support is not a showstopper.

Ok, fair point.

> > what if we attempt to override the permissions by marking directories a=
s writable, but find out the user isn't the owner of the directory and thus=
 can't change its permissions?
>
> Well, then you fail. If the user isn't the owner of the thing being delet=
ed, that's a different ballgame.
>
> > Do we try harder by attempting to invoke chmod under sudo to see if we =
can override the permissions?
>
> Certainly not. :-)  The user can sudo git if they have permission to do s=
uch a thing.
>
> > At what point do we give up? What's the clear line...and why does that =
line not just get drawn at not changing permissions at all?
>
> I would say that first it should be determined whether the feature is use=
ful. If not, then the line should get drawn at not changing permissions. Bu=
t if it would be useful, then the line should be initially drawn at whereve=
r gives the most "bang for the buck", the 80/20 case, etc. If it turns out =
that it's an unreasonable effort even to get a minimally useful implementat=
ion, then the stance of the Git team should be "It'd be nice to have, but i=
f you want it you'll have to write it yourself and send us a patch." Which =
is, I think, how more esoteric features like ACLs should be handled, if the=
y are to be handled at all.
>
> To be specific, I propose that if the unlink or rmdir system call returns=
 EPERM, and you are going to delete the parent directory anyway, then you s=
tat the parent directory, see if it's missing write permissions, and if so,=
 try to chmod u+w and retry the deletion of the child. And if any of those =
steps fail, you print an error message exactly like today. Alternately, and=
 preferably, you do it even if you won't delete the parent directory, but i=
n that case you have to put the permissions back when you're done. I think =
both of those are simple to implement, but I don't know about Git's impleme=
ntation.

This is some good food for thought, especially the bit about "[if] you
are going to delete the parent directory anwyay".  Hmm...


> > Here you've changed the goalposts slightly.  I didn't compare "git clea=
n" to "rm", I compared "git clean -fd" to "rm -rf" on untracked directories=
.
>
> True, but I only realized that after sending the email.
>
> > In other words, "git clean -fd" avoids bringing the repository back to =
a pristine state in a certain circumstance; it's actually more cautious tha=
n rm.
>
> Which is the main trouble with it. It's very difficult to know exactly wh=
at it's going to want to delete, hence the difficulty of fixing the problem=
 myself (where myself is a script invoking "git clean") with any kind of wo=
rkaround outside Git, and hence my request for it to be handled inside Git.
>
> But I come back to rsync, which I think is perhaps spiritually closer to =
"git clean" than rm is. It has no problem syncing files even if it has to t=
widdle some permission bits to do it. And that's convenient.

Yeah, the comparison to rsync is interesting.  I do worry a bit about
what can of worms it opens and whether we really want to do all this
work just to avoid a simple toplevel recursive chmod from the user,
but you do raise some interesting points.
