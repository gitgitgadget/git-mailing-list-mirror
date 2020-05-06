Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DBAC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 14:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E422078E
	for <git@archiver.kernel.org>; Wed,  6 May 2020 14:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMhknGUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgEFOZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 10:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgEFOZF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 10:25:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0B8C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 07:25:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x10so557432plr.4
        for <git@vger.kernel.org>; Wed, 06 May 2020 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mu9hQiZVtdNoxafXrH1lkpDU+gkdqafnrtWW1pvY4Os=;
        b=qMhknGUZ6HHMVEFcXgtY4AcOKst+L0Hs8j0EQrO4ZHiswLmtv++rQEYQkDg7s3zS/C
         rTr/FugFxMZUd4nwweMWv7CvKkWD8Mupk8xh9clSDChjq+y8ScV9MJ0A2GZTPgUovuWl
         nJ8XndfRtXjH/JNyH+xSvygx4jDTgHMz3GELvQD6pzM7LYY5fyKLhZG1LyjxKzUbhUwr
         B9bCa5c3OEPbnrMrZd6KHh/PnDFK1OltzPPIj1oZJph1UoAqaGF9VcCh2Gwq1FmlCcJ8
         8Si9cwCBKd3loElXNDvNgsLIWwxS3uGDvBjhWxRQbEQXlkJKXh80wx/fMdLvYs6qSA9r
         v4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mu9hQiZVtdNoxafXrH1lkpDU+gkdqafnrtWW1pvY4Os=;
        b=gJbkiWwgwIBloTHap6bJGDABPZLEAl1eE5Dpy1jythYmjhuwWYv2KroFMgIZHrOFCk
         0CJTQSc7mdglCVt/4ufAXU+CqimDu6i4AWRSieWf9rzwuykLH6HzcITPeAqzJYRSgXPj
         HWagPQSx++BIoG5Rn7X0sS97Fo8UHoSmRJsJXS6bg8CbTSlVy00Ysbw1lV26aHv6SFeB
         L8augK2AS/RIuLcPyhwQUat2W8IqLsoIfEsfnKbzs9ME/eWWQlL/9MaWFHovtCQ+01Nt
         I9+mdUIPfAhb3C21ucfB9PdyR8gVRMzTkZ4x8qJDpFR8hJmrIWkJY8nAWexeFQwR++xO
         jC/w==
X-Gm-Message-State: AGi0PubZqYQyfsO2scSS8aZVO7da1Ml9WmaZ2640bHA84dNRG7qEH7Ax
        UfNSff1ZlfEzc82G/w7lbck=
X-Google-Smtp-Source: APiQypI87JktmGzFxThlUG2bT9SkRr4evsjT4jzmR7zORQC937W1Ajb3Ogk7fK1Z1AJZQS37Vt6SUA==
X-Received: by 2002:a17:902:bb86:: with SMTP id m6mr7832861pls.341.1588775103118;
        Wed, 06 May 2020 07:25:03 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id e135sm2024887pfh.37.2020.05.06.07.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 07:25:02 -0700 (PDT)
Date:   Wed, 6 May 2020 21:25:00 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200506142500.GA2429@danh.dev>
References: <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
 <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
 <20200506004612.GE927@danh.dev>
 <xmqqr1vx90mt.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqr1vx90mt.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-05 20:56:58-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> > +--------------
> > +$ git checkout --orphan ci-config
> > +$ cp contrib/ci-config-allow-ref allow-ref
> > +$ $EDITOR allow-ref
> > +$ git rm -rf .
> 
> This sounds horrible.  You just nuked the entire files in the
> working tree you use for your everyday Git hacking to edit a
> single file.

It isn't that horrible as it sounds. It only removes the files that are
currently added in index, which is the same with tracked files in old
branch, and we can get it back by switching back to old branch.

I decided to make an orphanage branch because I would like to save
time and network bandwidth for the "check-ci" jobs. Since GitHub will
fetch only single branch in GitHub Actions:

	/usr/bin/git -c protocol.version=2 fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +refs/ci/config:refs/ci/config

I wonder whether the "git rm -rf ." makes that block sounds horrible?
If that is the case, we can use the experimental git-switch(1)
instead, it's doing more-or-less the same (or is it the same?) with
"git checkout --orphan" and "git rm -rf ."

-----------------
$ cp contrib/ci-config-allow-ref.sample allow-ref
$ git switch --orphan ci-config
$ edit allow-ref
$ git add allow-ref
$ git commit
-----------------

Note: I changed `$EDITOR` to `edit` to match other example of `edit`.

> As the instruction above says, we should set the example and
> describe the behaviour we implemented initially.  Something as basic
> like ...
> 
>     # Build any branch other than those whose name begins with "no-ci"

That's definitely better.
And I think we should add `.sample` suffix to this file, too

If all of that's sensible enough, here is the replacement fix-up patch.
--------------------8<------------------
Subject: [PATCH] fixup! ci: allow per-branch config for GitHub Actions

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .github/workflows/main.yml         |  3 +--
 Documentation/SubmittingPatches    | 12 ++++++++++++
 contrib/ci-config-allow-ref.sample | 12 ++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100755 contrib/ci-config-allow-ref.sample

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 51f4ff6e89..08217c5ed8 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -19,8 +19,7 @@ jobs:
           name: check whether CI is enabled for ref
           run: |
             enabled=yes
-            if test -e ref-whitelist &&
-               ! grep '^${{ github.ref }}$' ref-whitelist
+            if test -x allow-ref && ! ./allow-ref '${{ github.ref }}'
             then
               enabled=no
             fi
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b916f07f2c..bf06284f29 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -82,6 +82,18 @@ Alternately, you can use GitHub Actions (which supports testing your changes
 on Linux, macOS, and Windows) by pushing into a branch in your fork
 or opening a GitHub Pull Request against
 https://github.com/git/git.git or a fork of that repository.
+In the event that you only want to trigger GitHub Actions for specific
+refname, you can create an executable file named `allow-ref` in
+`refs/ci/config`. The following steps may help you:
+--------------
+$ cp contrib/ci-config-allow-ref.sample allow-ref
+$ git switch --orphan <a-branch-name-of-your-choice>
+$ edit allow-ref
+$ git add allow-ref
+$ git commit allow-ref
+$ git push <your-fork> HEAD:refs/ci/config
+--------------
+
 
 Do not forget to update the documentation to describe the updated
 behavior and make sure that the resulting documentation set formats
diff --git a/contrib/ci-config-allow-ref.sample b/contrib/ci-config-allow-ref.sample
new file mode 100755
index 0000000000..1973e88912
--- /dev/null
+++ b/contrib/ci-config-allow-ref.sample
@@ -0,0 +1,12 @@
+#!/bin/sh
+# Sample filter for GitHub Actions
+# GitHub Actions will run if and only if this script exits with zero status
+
+# This sample filter will ask GitHub Actions to build
+# any branches whose name doesn't start with "no-ci"
+
+REFNAME="$1"
+
+case "$REFNAME" in
+refs/heads/no-ci*) exit 1 ;;
+esac
-- 
2.26.2.672.g232c24e857

