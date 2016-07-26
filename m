Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D756203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 15:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbcGZPdD (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 11:33:03 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35905 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757136AbcGZPdA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 11:33:00 -0400
Received: by mail-wm0-f54.google.com with SMTP id q128so178298850wma.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 08:32:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=9XTNTnn8wK24DUzPbiQ2npxGFbjGha8qtbtpaSEBLH8=;
        b=IKGWvsfzJKi2aEfCn6rRzDz+IGEct+gEF6CvdeYH3MmWRCmBQuZOHNF2YmFGY6itg9
         mHItL/T4fkgnuVngh+gRsxvnHLInH56NsXO//rt/g2fM1XdkjAOgWr0iLBNpN1lI1DsM
         wl6h5gh7wzv60gjGyJ6v27xoaQqgsc33/2+3gQTglRuxsRrWV9Cy0gVLyr4xn0sI3faQ
         CDjeL4a+gabLiOZNDus5W45vNc/OrWqUv2ziw1eUCOFIVE0G3l3Zrfjeqeix03877lxi
         zHWI8eri6sh2gV+UIvzMVDNy2npgCCpOv33dTEAcMcU+x0RsMZKkdJ/fel+k3+9jGsCY
         Bmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9XTNTnn8wK24DUzPbiQ2npxGFbjGha8qtbtpaSEBLH8=;
        b=Ows+UPZvR63d+njIVdPrfRRWGTvbwNt4gsiPPvu8nQm3t86db6Lj4QROw2zQ97LiIR
         ZJu2Z85VAOqWbCIMrqjgQGwfZG1oUCSPLuI576IbRXxPlK8mz5JC7lWl6FsttHMJtRj6
         yhvQCuEgnbyv3Q9Eb5WztMf7zKy2WRaq5RWI+ydSJ7zmQkCBW/HkHlqeB46Kif4akSj/
         u7zoVip1kdZnpL8oI6+iFLs/u0M5ki99/Irb0napuS1e6/91eEH7HonW89DYIV4zGaPm
         dizVkZbACJWaG+UsxuOtULoOG1Xe714DoG5Lk06buNshEVpN7NiuilSnIe099hwi6t2r
         BipQ==
X-Gm-Message-State: AEkooutQ0lerjpFp4+FHSYehhK17ADXoeXHoW4VRo1EwBGk2z13UAtjQyZ80rcCAAAiPKknum/oW/7s4pyhYhw==
X-Received: by 10.28.14.68 with SMTP id 65mr25675801wmo.68.1469547174805; Tue,
 26 Jul 2016 08:32:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.140.67 with HTTP; Tue, 26 Jul 2016 08:32:54 -0700 (PDT)
From:	Orgad Shaneh <orgads@gmail.com>
Date:	Tue, 26 Jul 2016 18:32:54 +0300
Message-ID: <CAGHpTBKoLeAe9paTOLRuQM3JSv5GAq60LP64+kLS2JYuJEOcoQ@mail.gmail.com>
Subject: [PATCH] merge: Run commit-msg hook
To:	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi again,

On Tue, Jul 26, 2016 at 5:54 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Orgad,
>
> On Tue, 26 Jul 2016, Orgad Shaneh wrote:
>
> > On Tue, Jul 26, 2016 at 4:02 PM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Tue, 26 Jul 2016, Orgad Shaneh wrote:
> > >
> > >> commit-msg is needed to either validate the commit message or edit it.
> > >> Gerrit for instance uses this hook to append its Change-Id footer.
> > >>
> > >> This is relevant to merge commit just like any other commit.
> > >
> > > Hmm. This is not very convincing to me, as
> > >
> > > - if you call commit-msg in `git merge` now, why not `prepare-commit-msg`?
> >
> > prepare-commit-msg is already called, a few lines above this addition.
>
> Oh. That would have made a heck of a convincing argument in the commit
> message. Pity it was not mentioned. (Yes, please read that as a strong
> suggestion to fix that in the next patch iteration.)


Done.

>
>
> FWIW I dug out the original submission:
> http://thread.gmane.org/gmane.comp.version-control.git/151297/focus=151435
>
> It seems that there was no discussion about the commit-msg. Which makes me
> wonder why nobody thought of this.
>
> Now, you could make a case that you want to run the commit-msg hook in the
> same spirit as prepare-commit-msg (and mention that apparently nobody
> thought of that when the patch was accepted into builtin/merge.c).
>
> But then I wonder what your argument would be for *not* running the
> pre-commit and the post-commit hooks in `git merge` as well?
>
> Seems like a big inconsistency to me, one that would not be helped by a
> piecemeal patch that does only half the job of resolving the inconsistency.
>
> There was actually a question why the post-commit hook was not run in `git
> merge`:
> http://thread.gmane.org/gmane.comp.version-control.git/168716/focus=168773
> (but it seems nobody cared all that much).


pre-commit seems to have been rejected, though I must admit I don't
fully understand why.
post-commit might make sense, but I wouldn't include it in the same
patch. These are
different issues.

>
> > > - a merge is a different beast from a simple commit. That is why we
> > > have two different commands for them. A hook to edit the merge message
> > > may need to know the *second* parent commit, too, for example to
> > > generate a diffstat, or to add information about changes in an "evil
> > > commit".
> >
> > That is correct for a post-merge hook. Why should *message validation*
> > differ between simple and merge commit?
>
> You yourself do not use the hook for validation. You use it to *edit* the
> message. My examples do the very same thing. Why should they wait for a
> *post-merge* hook to amend the message?


Because commit-msg doesn't know anything about the commit. It only refers
to the message. The commit might even not exist when it is called. If you
need data from the commit, post-merge is the right place.

>
> Otherwise, why wouldn't you use the post-merge hook to add the Change-Id:
> in your use case, too...
>
> > > - if Gerrit is the intended user, would it not make more sense to
> > >   introduce a new hook, e.g. `merge-msg` (and `prepare-merge-msg`), as you
> > >   have to teach Gerrit a new trick anyway?
> >
> > Why is that new? Every commit in gerrit has a Change-Id footer, which is
> > generated by commit-msg hook.
>
> So it already works for Gerrit? Why is this patch needed, then? This is
> confusing.


Gerrit is a server, the user installs a commit-msg hook provided by
Gerrit on the local machine.
This hook currently works only for simple commits and not for
(trivial) merge commits.
That's where this patch comes to the rescue.

>
> > What I currently do for merges that succeed without conflicts is
> > unconditional commit --amend --no-edit just to run the hook.
>
> So you do that manually? Or you taught Gerrit to do that? Please clarify.


Gerrit can't do anything on my machine. It's a web/ssh server. I have my own
post-merge hook that runs commit --amend

> > > - if Gerrit is the intended user, why does it not simply edit the merge
> > >   message itself? After all, it executes it, and probably crafts a merge
> > >   message mentioning that this is an automatic merge, anyway, so why not
> > >   add the Change-Id *then*?
> >
> > Most Gerrit setups require Change-Id in the commit message that the user
> > pushes. It is possible to disable this setting, and then you don't need the
> > Change-Id at all, but then you can't push a new patch set for the change
> > (unless you copy the Change-Id from gerrit to your commit message).
> > That's a real pain, I'm not aware of any public gerrit server that
> > disables this :)
>
> Forgive me, I never used Gerrit, and neither do I intend to do so.

Too bad, great system :)

> I would appreciate a self-contained commit message that explains just
> enough about Gerrit to understand what the patch tries to solve, and in a
> manner such that even developers who decided to ignore Gerrit understand.


I hope it's better now. Thanks for your comments.

- Orgad
