Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37F4C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 21:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiIGVpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 17:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiIGVp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 17:45:29 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53E9753AC
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 14:45:28 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id b21so2979827plz.7
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 14:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=7eyxhPICGcmqG+6F/i/oV3VWZQY5NecF+SDumPJzz2Q=;
        b=FTrTf6dTXbL2HBD6pPDppOz+mvuT8dCMPEJJoNIiEILZEPECT+EPtiOmFd/OnnPw3N
         4pBzpq5a/aGVlec1UavtLwTqhSyYCM2kbDlwv1NexCL64L6wgqa1TVCVCTzhvfmblEb3
         A4SsxR02Dsm/3SEUavFqCgvu7JLzKiW/qc0gomrJK95PPdI9ag2VRtWN1KeY36P48Z+h
         ixJslBd6W+Pj9j/b6MKAyDn+DjAO9ulwL4h+g3Omw1oWd5Di+3TJom8wPSd0X7pNQWjf
         9GbwW7t53SNv7a72d7tC/d0rCwLHA6wCJmuM7hzcud3e2UhrPRgLimzjtnn4ujB9UwGK
         QA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7eyxhPICGcmqG+6F/i/oV3VWZQY5NecF+SDumPJzz2Q=;
        b=OY6mFdEmpgY77tnmOr6Rrl1K5fAI9ETqj4BWjMRswTm6Pbb+sw99vRaJzd6KLy2csg
         UTp27FGULpKN6qgxm8ZmbAdIDDhDXlVnTObPkfG/QJEiOEBWOFbHCtGWslFXH6tGR6Uv
         4fmB1jEOvam1cG5YIocKYww3rq9uUcz0m+ClvqO30xMJtVinu573df6EqSx8Dev90TGB
         BLCzzYvlb95ilXmNCs5SAOlDuEECzwGvxCh19+dhoNCAmA6/yvepn8kPfC66Wnn9UKxl
         gnj/c/3mhj0uHZkUlvhephUVGScSJTyshBWws9qi+HLshMOpP7N9XzWhenMWgEwT+nIg
         NB9A==
X-Gm-Message-State: ACgBeo21rfNjMvhGOT8xx9hYi94pob9c86/kcliGZbawrhb+IYv5QodQ
        8uEqa0WpOxUnlyeCGnumGPQ=
X-Google-Smtp-Source: AA6agR6XjrKnsLAFTYi5nE1426CuFjycb78kycCzA1ww4hy2mnANHfoDxDcr2gvNKYrcgiYIbpO6IQ==
X-Received: by 2002:a17:902:ba8f:b0:175:42c1:61ce with SMTP id k15-20020a170902ba8f00b0017542c161cemr6156209pls.130.1662587128105;
        Wed, 07 Sep 2022 14:45:28 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u13-20020a170903124d00b0016bb24f5d19sm12922804plh.209.2022.09.07.14.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:45:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re* [PATCH] tests: replace mingw_test_cmp with a helper in C
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
        <xmqqwnbv7trp.fsf@gitster.g>
        <354qp59q-r4r3-1971-5o09-71q224911orp@tzk.qr>
        <b21d2b60-428f-58ec-28b6-3c617b9f2e45@web.de>
        <xmqq7d2fywvr.fsf@gitster.g>
Date:   Wed, 07 Sep 2022 14:45:27 -0700
In-Reply-To: <xmqq7d2fywvr.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        07 Sep 2022 09:25:44 -0700")
Message-ID: <xmqqlequsvt4.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> René Scharfe <l.s.r@web.de> writes:
>
>> "git diff --no-index - -" also doesn't complain, by the way.
>
> True, but in this case hopefully it is worth to call it out, as both
> this code that uses "diff --no-index" and "diff --no-index" itself
> came from the same author ;-)
>
> I think "git diff --no-index - -" should just exit 0 after slurping
> all its input (i.e. allow it to be placed downstream of a pipe
> without blocking the upstream), but it is also fine to exit with 0
> without reading a single byte from the standard input.  Of course
> the latter is easier to implement ;-)


----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] diff: "--no-index - -" compares the same standard input

Conceptually, "git diff --no-index - A" slurps the standard input to
the EOF and compares it with the contents of A, so it is a natural
extension for "git diff --no-index - -" to slurp the standard input
to the end, and compares it with itself, which should always yield
"true".

There can be two plausible implementations.  We could read and
discard the input to the end and exit 0.  It would allow us to avoid
sigpipe on the upstream command

    $ dd if=/dev/zero bs=1m count=1 | git diff --no-index - -

As we can tell the outcome without even consuming a single byte from
the standard input, we can just notice the two input files specified
are "-" and immediately exit.  It would allow us to give a correct
answer to

    $ git diff --no-index - - </dev/full

but can kill the command on the upstream side of a pipe that feeds
us.

We pick the latter (i.e. not touching the input at all), simply
because it is more efficient.  Data producer that can be placed on
the upstream side of a pipe should always be prepared for a consumer
that does not consume all its output (e.g. "head" and pager) anyway.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-no-index.c          | 11 +++++++++++
 t/t4053-diff-no-index.sh | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/diff-no-index.c b/diff-no-index.c
index 18edbdf4b5..940b66b4c8 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -278,6 +278,17 @@ int diff_no_index(struct rev_info *revs,
 			p = to_free[i] = prefix_filename(prefix, p);
 		paths[i] = p;
 	}
+	if (paths[0] == file_from_standard_input &&
+	    paths[1] == file_from_standard_input) {
+		/*
+		 * "git diff --no-index - -".  We are asked to compare
+		 * what came from the standard input with itself; we
+		 * know they are the same without even reading a
+		 * single byte.
+		 */
+		ret = 0;
+		goto out;
+	}
 
 	fixup_paths(paths, &replacement);
 
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 3feadf0e35..d089d9c2b1 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -156,6 +156,16 @@ test_expect_success 'diff --no-index normalizes mode: no changes' '
 	test_must_be_empty out
 '
 
+test_expect_success 'diff --no-index with standard input' '
+	echo foo >x &&
+	echo bar >z &&
+	git diff --no-index - x <x &&
+	git diff --no-index x - <x &&
+	test_must_fail git diff --no-index - x <z &&
+	test_must_fail git diff --no-index x - <z &&
+	git diff --no-index - - <x
+'
+
 test_expect_success POSIXPERM 'diff --no-index normalizes mode: chmod +x' '
 	chmod +x y &&
 	cat >expected <<-\EOF &&
@@ -180,6 +190,7 @@ test_expect_success POSIXPERM 'diff --no-index normalizes: mode not like git mod
 '
 
 test_expect_success POSIXPERM,SYMLINKS 'diff --no-index normalizes: mode not like git mode (symlink)' '
+	rm -f z &&
 	ln -s y z &&
 	X_OID=$(git hash-object --stdin <x) &&
 	Z_OID=$(printf y | git hash-object --stdin) &&
-- 
2.37.3-732-ge93f299430

