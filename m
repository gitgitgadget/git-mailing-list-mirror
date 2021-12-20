Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB1BC433FE
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 14:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbhLTO5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 09:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbhLTOyr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 09:54:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CCCC08EC32
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:48:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e5so20588345wrc.5
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lisa/RicwXWE0t+E5583E7BBfl3r4+pUbqm6E10qN8U=;
        b=Ia399P1Ln4W9McX0dwGXp/zxmmvdfX8/4fgRsbGXrv/gx7Ssos7IrazLxI1eGIIKBB
         OJo6mWgPAr/6ra+hXDif91IjMQApUWIBy6UKKPapQKy8sRGO4zkAdDMYONi63fuz/DFZ
         M3DTkxxBfTMIqkREkkJ2Bc7bctpUF92GwPp3/EouZH1qect0eB2x1zPw92T7ts0JpU8X
         TjECr5Gdw+6tyF7r3XaTVqsVWzyK4dRS767Ps032qPpHQITOh8uKFmB7OkaK4/omPHas
         2mkzcC01Z9cxtopLQ6Q2VyxVhHw3tIMWhvetYSw74hSi2yCKezkTuG0P1PseF4XFJMes
         OrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Lisa/RicwXWE0t+E5583E7BBfl3r4+pUbqm6E10qN8U=;
        b=1L11uTWrjtEKhbhKuO5Ekl5qtLJjDFxvlNm0qO+4gNFw6ziisz0ZVC1l2bElmlcaDr
         tM6HY6XTSLkCABSuLByGiQBY57h4RLWeSw0Y3uI9RXKtjMHzsXfLgWBpwkjrrsZNDGB4
         BMywpjHAMz9uqhCRhs1y5z0sCufyVmFyMpxcuVpIak0KuHVgNMgxygtuxD97HEaGSeb7
         QNYTCpQb7LfINr8RDtQWXVPNuLcBmW6TNv/BFvvlrbgCs+fG2XZfJGhT3hci4RrUhUwR
         yLoqvR3I2WuYfyxIyN4n7VJNpvigrP9STooei6s2LG0KyUq42OpGP/MAXheemxepqKSB
         hDkQ==
X-Gm-Message-State: AOAM5316p7vKVC2gA1YhvMZtIeC705kUpoh/Qrhdyz+z6YCj5s76Dy2A
        TQTxl4SBj/tEGboMmmr5HUc1MrlbvqY=
X-Google-Smtp-Source: ABdhPJxAj/3VQVl3/XhZIM4VA4INisht4AuLRBHeJcdHIY6jiV6h/XdxeEYLuIWMcZ3unPK9byKPzw==
X-Received: by 2002:a5d:53cf:: with SMTP id a15mr12872482wrw.395.1640011693751;
        Mon, 20 Dec 2021 06:48:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm12333448wrp.79.2021.12.20.06.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 06:48:13 -0800 (PST)
Message-Id: <747328a4dd69f2325892b4d89e3e62a0bcfbba59.1640011691.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1098.v2.git.1640011691.gitgitgadget@gmail.com>
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
        <pull.1098.v2.git.1640011691.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 14:48:10 +0000
Subject: [PATCH v2 1/2] repack: respect kept objects with '--write-midx -b'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Historically, we needed a single packfile in order to have reachability
bitmaps. This introduced logic that when 'git repack' had a '-b' option
that we should stop sending the '--honor-pack-keep' option to the 'git
pack-objects' child process, ensuring that we create a packfile
containing all reachable objects.

In the world of multi-pack-index bitmaps, we no longer need to repack
all objects into a single pack to have valid bitmaps. Thus, we should
continue sending the '--honor-pack-keep' flag to 'git pack-objects'.

The fix is very simple: only disable the flag when writing bitmaps but
also _not_ writing the multi-pack-index.

This opens the door to new repacking strategies that might want to keep
some historical set of objects in a stable pack-file while only
repacking more recent objects.

To test, create a new 'test_subcommand_inexact' helper that is more
flexible than 'test_subcommand'. This allows us to look for the
--honor-pack-keep flag without over-indexing on the exact set of
arguments.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/repack.c        |  2 +-
 t/t7700-repack.sh       |  6 ++++++
 t/test-lib-functions.sh | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 9b0be6a6ab3..1f128b7c90b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -693,7 +693,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		write_bitmaps = 0;
 	}
 	if (pack_kept_objects < 0)
-		pack_kept_objects = write_bitmaps > 0;
+		pack_kept_objects = write_bitmaps > 0 && !write_midx;
 
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
 		die(_(incremental_bitmap_conflict_error));
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 0260ad6f0e0..63c9a247f57 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -372,4 +372,10 @@ test_expect_success '--write-midx with preferred bitmap tips' '
 	)
 '
 
+test_expect_success '--write-midx -b packs non-kept objects' '
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git repack --write-midx -a -b &&
+	test_subcommand_inexact git pack-objects --honor-pack-keep <trace.txt
+'
+
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 389153e5916..c3d38aaccbd 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1759,6 +1759,40 @@ test_subcommand () {
 	fi
 }
 
+# Check that the given command was invoked as part of the
+# trace2-format trace on stdin, but without an exact set of
+# arguments.
+#
+#	test_subcommand [!] <command> <args>... < <trace>
+#
+# For example, to look for an invocation of "git pack-objects"
+# with the "--honor-pack-keep" argument, use
+#
+#	GIT_TRACE2_EVENT=event.log git repack ... &&
+#	test_subcommand git pack-objects --honor-pack-keep <event.log
+#
+# If the first parameter passed is !, this instead checks that
+# the given command was not called.
+#
+test_subcommand_inexact () {
+	local negate=
+	if test "$1" = "!"
+	then
+		negate=t
+		shift
+	fi
+
+	local expr=$(printf '"%s".*' "$@")
+	expr="${expr%,}"
+
+	if test -n "$negate"
+	then
+		! grep "\"event\":\"child_start\".*\[$expr\]"
+	else
+		grep "\"event\":\"child_start\".*\[$expr\]"
+	fi
+}
+
 # Check that the given command was invoked as part of the
 # trace2-format trace on stdin.
 #
-- 
gitgitgadget

