Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2920C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 17:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AB864E10
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 17:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhBPRzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 12:55:37 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:34744 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhBPRz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 12:55:28 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1lC4Yg-00Ga97-Nb; Tue, 16 Feb 2021 10:54:46 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1lC4Yf-002L1k-Eb; Tue, 16 Feb 2021 10:54:46 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 403FA500764;
        Tue, 16 Feb 2021 10:54:45 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 003m2sMSW5ZB; Tue, 16 Feb 2021 10:54:45 -0700 (MST)
Received: from ellen.lan (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id CE4EC5007BC;
        Tue, 16 Feb 2021 10:54:44 -0700 (MST)
Date:   Tue, 16 Feb 2021 10:54:41 -0700
From:   Seth House <seth@eseth.com>
To:     Knapperig knaapie <isaacvanson@kpnmail.nl>
Cc:     git@vger.kernel.org
Message-ID: <YCwG4SkN4unSANjX@ellen.lan>
References: <66eb4eba-ed94-b467-336b-dbe6f398d8af@kpnmail.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66eb4eba-ed94-b467-336b-dbe6f398d8af@kpnmail.nl>
X-XM-SPF: eid=1lC4Yf-002L1k-Eb;;;mid=<YCwG4SkN4unSANjX@ellen.lan>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: the git add command
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 04:21:44PM +0100, Knapperig knaapie wrote:
> A screenshot of the problem occurring on the command line is attached.
> Holler if you need more info.

Hello. Everything in this screenshot looks working as intended to me.
I'll walk through line-by-line to explain what is happening.

1.  `git commit -m 'tests weg uit admin file'`

    The `admin.py` file was modified but not yet staged which is why Git
    reported "no changes added to commit" and no commit was created.

2.  `git add`

    This command requires an argument which is why Git reported "Nothing
    specified, nothing added".

3.  `git add ookleuk/admin.py`

    This succesfully staged the file for commit.

4.  `git push`

    The admin file has been staged but a commit for it has not yet been
    created which is why Git reported "Everything up-to-date".

5.  `git commit -m 'tests weg uit admin file'`

    This successfully created a commit containing the admin file.

6.  `git push .`

    The first argument to the push command is the name of a remote to
    push to.

    This can also be a file path which in this case is the path to the
    local repository that you're currently working in which is why Git
    reports "Everything up-to-date".

    Without any arguments it'll use the default behavior [1] (the
    current branch is pushed to the corresponding upstream branch). Or
    it's also common to specify name of a remote (e.g., "origin"). One
    of these would be a good choice for this workflow.

    [1] https://www.git-scm.com/docs/git-push#_description

7.  `git add .`

    Nothing was staged since there were no modified files.

8.  `git push .`

    Same as above: pushing changes from the local repository to the same
    local repository. `git push` without arguments would do the trick.

9.  `git status`

    This reports there is one commit that is ready to push -- the commit
    from #5. It also looks like the file was modified again after that
    commit was created.

10. `git add admin.py`

    This did not work because `git add` is looking for a file named
    `admin.py` in the current directory. It would work with the full
    path like in #3, or it would work if the current directory was the
    `ookleuk` directory but from the shell prompt and the `git status`
    output from the previous step it looks like the current directory is
    `vinkmoi` and not `ookleuk`.

11. `git add .`

    This successfully staged the new changes to the admin file but
    a commit has not yet been created.

12. `git push`

    This successfully pushed the commit created in #5.

    The commits that were pushed can be viewed in GitHub [2] or on the
    CLI with `git log --oneline 5a0c6bb...966fde2`. If `git status` were
    run after this it would report your branch is up-to-date with
    origin/master and there is one file currently staged for commit.

    [2] https://github.com/Ivsvinkmoi/Django_project/compare/5a0c6bb...966fde2

Based on that screenshot, I'd suggest reading about staging vs.
committing and pushing and remotes. Also to pay close attention to which
arguments are given to which commands and what directory each command is
run from.

The Git website has excellent written and video tutorials [3] that cover
those topics and the Google Groups mailing list [4] is a good resource
to discuss Git usage and questions with other people that are also
learning Git.

[3] https://www.git-scm.com/doc
[4] https://www.git-scm.com/community
    https://groups.google.com/g/git-users

You said:

> I want to be sure I'll be able to only upload
> specific files in the future.

Which is a great workflow and definitely possible! Stick with it and
you'll get there. If your Git experience is anything like mine: it's
a long road to learning it at first but the time investment will be more
than worthwhile in the long run.

Cheers.

