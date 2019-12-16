Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85530C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 18:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA83206A5
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 18:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="Pm+O/LL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfLPSnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:43:04 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:41216 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbfLPSnB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 13:43:01 -0500
Received: by mail-il1-f172.google.com with SMTP id f10so6241623ils.8
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 10:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWKsZDyVj2eTfpXhV1svyKHXq9y8cafVc/nSo31ho/M=;
        b=Pm+O/LL1h4xSEZQ7z+UnO5JL1GhhrAC1fVJUtZkwQ/ZscPqqH6AZwl4g8hE5AwoEV1
         LEocDbYu3wfvgZ9A6VOhcNr555LbQsNZL+1P0smesJy5MeyhCV9haR2RqJMo+bS+nyZX
         TC47Jnu91SAmfXNN8YqPcA+99Pclmb6jitf596k0Dqvp4MbiGjIk19KpCTa78kLDmNR1
         iFPfFxTIatbN2D0GgChPGr8+LrrHqf8rb/RM20+aGNe8Dm9wrHcF9SvbJi+07AiRPUuE
         PATCbQrTU82fvxBF0mnTHhrpn+l6VzsQeQmyg+0aphusDQ+7tjGeMIwDwE+Rl7O0RaFu
         1DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWKsZDyVj2eTfpXhV1svyKHXq9y8cafVc/nSo31ho/M=;
        b=AH97mm3om8wjCu/k+jZnSqDSZbyDkXcU6p0anb8W53up4R5f/zHRPu69c/ttJ7QJ5N
         ovFZ31/zvCSsKgaotEdwUHoAyoZT4o2U8l6D/YTp3FvIyzlgkm1RwdT8BnKrOaO2DiWE
         Vruymv7v5wVi7tAzQohACBBPfSSphanVtcCzrrVDb7S8r4/QiwW1dKLlZ/gEF5Pd8cd5
         bzyuWXCVUj/d5Tv23iQ34RiQfyFOEuiGEzo+VA2GgYpuNl/Y98MpwGCNX/QYjB8YyEH+
         jO9CHu8JcGbb418leQKcst5kQkVrBIQY0F+uD7/g5VK1d0IxtzfBHJCfJFTXXy74IqsH
         3+Qw==
X-Gm-Message-State: APjAAAX4eoHqeSdJm9FtdXHq4znMXfATymTPaOOQzpTZomfArBoS8RLi
        yppRvF93Cr2fcmljySKiLjvW7GPDv9FAjd3LmNqoDQ==
X-Google-Smtp-Source: APXvYqyErdsg+SRQf+sJaHB2n6lwNTxjbNGLom6sIyjYX75cMQdlnkSisEvMFuwN8aPFgAenvBN2YmXvKwzX+HwfzhE=
X-Received: by 2002:a92:6a08:: with SMTP id f8mr12832311ilc.185.1576521780424;
 Mon, 16 Dec 2019 10:43:00 -0800 (PST)
MIME-Version: 1.0
References: <296B296B-EBA0-4F1E-AFEA-ADC232E84656@sixfeetup.com>
 <87immizf55.fsf@kyleam.com> <87fthmzewl.fsf@kyleam.com> <EF4FE28C-1111-46C7-9EDE-24940E8A5727@sixfeetup.com>
In-Reply-To: <EF4FE28C-1111-46C7-9EDE-24940E8A5727@sixfeetup.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 16 Dec 2019 10:42:49 -0800
Message-ID: <CAGyf7-G7yFpGwwv2E72pGW_WjeYkLRh4sFdP+6E-dn2Gm+T8ow@mail.gmail.com>
Subject: Re: Stash does not save rename information
To:     Chrissy Wainwright <chrissy@sixfeetup.com>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 6:32 AM Chrissy Wainwright
<chrissy@sixfeetup.com> wrote:
>
> Thank you, using --index does work! Now the trick is to actually remember to use it in this case, since it doesn't seem the change can be restored if you forget to use it the first time you pop/apply.

You could create a Git alias for it, if that helps.

>
> Then the fix is to `git mv` the files back to the original name, and to the new name again.

That shouldn't be necessary. Really all you need to do is stage the
parts of the change that "git stash apply" didn't automatically stage
as part of restoring them. "git add -a" would likely do it, but may
also stage other things. A simple "git add foo" (based on the names
from your example) should also do it:

$ git init foo
Initialized empty Git repository in /.../foo/.git/
$ cd foo
$ touch foo && git add foo && git commit -m "Initial commit"
[master (root-commit) 934d270] Initial commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo
$ git mv foo bar
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    renamed:    foo -> bar

$ git stash
Saved working directory and index state WIP on master: 934d270 Initial commit
$ git stash apply
Removing foo
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    new file:   bar

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    deleted:    foo

$ git add foo
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    renamed:    foo -> bar

On some older versions of Git you may need to use "git add -f foo" to
add the deleted file, but at least on 2.20.1, what I happen to be
running locally, it's not necessary.

With or without "-f", all you really need to do is update what parts
of the change are staged; you don't need to (essentially) revert and
reapply the change.

One other thing I think may be worth clarifying, just in case it's not
know, is in relation to the subject: "Stash does not save rename
information." Git itself does not track renames, at all, in any
commands. git mv does not somehow record renames; it's just a
simplification for:
mv foo bar
git rm foo # or git add foo to stage the deletion
git add bar

You can confirm that easily:
$ git reset --hard HEAD
HEAD is now at 934d270 Initial commit
$ mv foo bar
$ git rm foo
rm 'foo'
$ git add bar
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    renamed:    foo -> bar

$ git reset --hard HEAD
HEAD is now at 934d270 Initial commit
Lafiel:foo bturner$ mv foo bar
Lafiel:foo bturner$ git add foo bar
Lafiel:foo bturner$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    renamed:    foo -> bar

Git uses heuristics to "pair up" deletions and adds into probable
renames. If you rename a file and change it significantly as part of
the same commit, Git will not consider it a rename. Similarly, if you
rename multiple similar files in a single commit, paired with some
changes to those files, Git may pair up the "wrong" combinations (i.e.
if you rename A to X and B to Y, "git diff" may show renaming A to Y
and B to X).

Hope this helps,
Bryan Turner

>
> Thanks
> Chrissy Wainwright
