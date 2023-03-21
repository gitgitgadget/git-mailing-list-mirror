Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312BEC6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 01:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCUB5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 21:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCUB5g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 21:57:36 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBC8211D0
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 18:57:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 20so6936845lju.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679363853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZNlFZmyieutSd+WGUHPZu9xHdJyexdRGJU/A2khkkg=;
        b=ZUeEFcb/13HwOW+E9jRMGWAUIlGClUU3R+E5U4FL2SCYs+1X2x1SwFCJjeE/UHTYMR
         j9wl62NWZ3aA2YpXmVhcVI/ZzoIjrJAPGfen1Ce34fFgbiR3NTFQ4v6aHFL3un40bIun
         K6DSMrVHCEoOSJVvH39auHIU20ydJCiKyNN6BaksNp0omnKYi/4YkatA8QSvF6T8SaMY
         goQIVPBeqqxZiAv4+2VylWy93blZL5SUFRwl6ZJWjMIsvl7C729umTaSOJfknw1rKAHV
         8tPV3xgbFAHfpIpXI/Jy/kPVWgh/iVx36edX6M4Ek0VOn2hiUKU1VX8/qUs6sbMG47ZN
         a0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679363853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZNlFZmyieutSd+WGUHPZu9xHdJyexdRGJU/A2khkkg=;
        b=WwDMRxlhWpXoDVIv6qc2Z0wdjfCWHnj1XynNALhS8ml8Dog2hAizDisiAVJiZc+3oq
         jN/dKib2vM2tbx5y4bvDuQv8GrOFgAyJcnj5I3ZjMkz58bjGkJNx64uZ9BzzB1gkWdrc
         6GuTLK+yJstSPoLqa3udTcnZ/8CXaHOdQ/fnfUV0b/42eTg5e1nCUBGITdrKaVPDiFL8
         CsPoTj8tDdl/mbaMR0cMN8uTU258tpp94WsiHdOTiwwc9vex/XJaYnq6goRZL0QK/fvn
         et5z3yi4p2PWAytAql4OnJ6uFAcD8j61smNPaXCvsGjSLcmN8BkhRBesFxByC6ZkjtK2
         cZqQ==
X-Gm-Message-State: AO0yUKW3cg3pZJgRZE3BXOnb6pJVFPajaWlT81uauDiMgiPsmJKmJW2X
        UWyXGnEJDsUoHRq+aSkyC83vtJgJu/OXA0Oe+STiSr0lRGc=
X-Google-Smtp-Source: AK7set8UhtviyLWICXtg8sNG3PADI8/XZYGKddPCwzoT1RPzc6JUT5zsmkYNmYUs0X2lvQFr8ws+yy3WR2PW+DISNiQ=
X-Received: by 2002:a2e:9257:0:b0:295:93eb:bab1 with SMTP id
 v23-20020a2e9257000000b0029593ebbab1mr368559ljg.1.1679363853443; Mon, 20 Mar
 2023 18:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <BBB169A5-0665-47C9-819B-6409A22AB699@lanl.gov>
In-Reply-To: <BBB169A5-0665-47C9-819B-6409A22AB699@lanl.gov>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Mar 2023 18:57:21 -0700
Message-ID: <CABPp-BEG+vp-UcpVfcZecPBnfcuTjO6JYCo7wEU5ZrDUHBUd9g@mail.gmail.com>
Subject: Re: bug? round-trip through fast-import/fast-export loses files
To:     "Priedhorsky, Reid" <reidpr@lanl.gov>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Mar 20, 2023 at 11:23=E2=80=AFAM Priedhorsky, Reid <reidpr@lanl.gov=
> wrote:
>
>   Hello,
>
>   I believe I=E2=80=99ve found a bug in Git. It seems that (1) round-trip=
ping through
>   fast-export/fast-import a repository (2) that contains a commit that ch=
anges
>   a file to a directory (3) deletes the contents of that directory from t=
he
>   repository.
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
>   Run this shell script:
>
>   ~~~~
>   #!/bin/bash
>
>   set -ex
>
>   mkdir -p /tmp/weirdal
>   cd /tmp/weirdal
>   git --version
>
>   # init repo
>   rm -Rf wd
>   mkdir wd
>   cd wd
>   git init -b main
>
>   # first commit - foo is a file
>   touch foo
>   git add -A
>   git commit -m 'file'
>
>   # second commit - foo is a directory
>   rm foo
>   mkdir foo
>   touch foo/bar
>   git add -A
>   git commit -m 'directory'
>
>   # the contents of foo are in the working dir and the repo
>   git status
>   ls -lR
>   git ls-tree --name-only -r HEAD
>
>   # import/export repository (add --full-tree to work around bug)
>   git fast-export --no-data -- --all > ../export
>   cat ../export
>   git fast-import --force --quiet < ../export
>
>   # bug: foo is still in the WD but not the repo; should still be both
>   git status
>   ls -lR
>   git ls-tree --name-only -r HEAD
>   #git fast-export --no-data -- --all | diff -u --text ../export - || tru=
e
>   ~~~~
>
> What did you expect to happen? (Expected behavior)
>
>   Repo should be unchanged, i.e.:
>
>   + git status
>   On branch main
>   nothing to commit, working tree clean
>
> What happened instead? (Actual behavior)
>
>   Git thinks foo/bar has been staged:
>
>   + git status
>   On branch main
>   Changes to be committed:
>     (use "git restore --staged <file>..." to unstage)
>           new file:   foo/bar
>
> What's different between what you expected and what actually happened?
>
>   File foo/bar is staged when it should be unchanged.
>
> Anything else you want to add:
>
>   This also happens in 2.38.1 built from source.
>
>   The bad behavior can be worked around with =E2=80=9C--full-tree=E2=80=
=9D on fast-export, but
>   the real repo where I want to do this is pretty large, so I=E2=80=99d p=
refer not to.
>
>   Note the =E2=80=9Cgit fast-export=E2=80=9D output:
>
>     commit refs/heads/main
>     mark :2
>     author Reid Priedhorsky <reidpr@lanl.gov> 1679330805 -0600
>     committer Reid Priedhorsky <reidpr@lanl.gov> 1679330805 -0600
>     data 10
>     directory
>     from :1
>     M 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 foo/bar
>     D foo
>
>   It looks to me like the =E2=80=9CM ... foo/bar=E2=80=9D is being proces=
sed before =E2=80=9CD foo=E2=80=9D
>   when it should happen in the opposite order.

Thanks for the well-written bug report, including not only a testcase
but even the relevant bits of the fast-export output.  I thought I had
fixed D/F issues in fast-export & fast-import before, and indeed a
search turns up both of

253fb5f889 (fast-import: Improve robustness when D->F changes provided
in wrong order, 2010-07-09)
060df62422 (fast-export: Fix output order of D/F changes, 2010-07-09)

However, it looks like both of those only considered D->F (directory
becomes a file) changes, whereas you specifically have a case of F->D
(file becoming a directory).

Honestly, looking back at those two patches of mine, I think both were
rather suboptimal.  A better solution that would handle both F->D and
D->F would be having fast-export sort the diff_filepairs such that it
processes the deletes before the modifies.  Another improved solution
would be having fast-import sort the files given to it and handling
deletes first.  Either should fix this.

Might be a good task for a new contributor.  Any takers?  (Tagging as
#leftoverbits.)
