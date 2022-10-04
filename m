Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A99C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiJDNZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiJDNYY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178E254665
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j16so9367896wrh.5
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGPeLHvg6snkBSDRyooy7ahwLAfAURDFXKqmU6AELyE=;
        b=QDiWjp9xsjKg3/LEkj6Lp3sXBnQ74CFNbzHDan9Tnh2OCd06CxKP38loBbl0yuRNio
         gWO44cXgNx0KfaERLv4GGsQBaL/v2lcxiB7KVUA7ciSHRJZaxdYkSglety7erC9g7dZH
         TJkcyhw08VUARpBglOlCqOFIL/Gnl+P/eVYxYlwMKImascsVXwPzt78yGBlU67vHP9zG
         utoT8UoQsU2W/lVY6Kyq265XYghjB20ZLnU07v95CS5ZNaC4q2OkszV4LGhCESifkThn
         dog+PXk3nSpg5Fx1xkihcGjslUQSqrN/15rkpiXTBoiagsqerNo3hhjW3rFnvd/ymEwS
         04xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGPeLHvg6snkBSDRyooy7ahwLAfAURDFXKqmU6AELyE=;
        b=W/YtWr9yXyEeEA6HBQD76ONzcpwnO1CCu6uQQuepJpOyEt7zfDAy2IYCkaNu6nCYKG
         Nj0kbEH5YkuMFn8TEpolWSkANqj2LVI9EtxEzhtpBrlEoPoqbd1AkqoZ/VTz+SrSUE9l
         4FPxqmcfAQ3y7sSdNnGz82Xkni4LpYTwhQFNpzfnoyVf2kBHaJQnkPieGw4oUvHrKmTh
         k5yYLEU/ZoD7Lbl6f/ajrRwzSWStXNrAOJQvYn+WDivJs2nokgcGnKmy9gdz61Pvsb8W
         CQUxgpvBDRmma0UVPCeQjpE33oNGZiBTWXiIfnwZkCD8xYjLIs+bAG2XLR8xCVZ3InLv
         6bVw==
X-Gm-Message-State: ACrzQf1Akj43Z/Er/HSrknXKc4XqztzSNbRCjAUzLJCor5sm468zYKvr
        ZrNJy/w8o2fwdGUCfg6yFtD6w9kMphjD8Q==
X-Google-Smtp-Source: AMsMyM4JHVoIesvJRgL8O015wYKUpQ7sLRd6ksiep5p12wYwcDQ35X7po+TdyTfDo3aXrfoka2RK+g==
X-Received: by 2002:a05:6000:98b:b0:22c:c3b1:3f2a with SMTP id by11-20020a056000098b00b0022cc3b13f2amr16719507wrb.11.1664889850031;
        Tue, 04 Oct 2022 06:24:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 15/34] doc SYNOPSIS & -h: use "-" to separate words in labels, not "_"
Date:   Tue,  4 Oct 2022 15:23:29 +0200
Message-Id: <patch-v4-15.34-403e7ceb449-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "builtin/credential-cache--daemon.c" to use "<socket-path>" not
"<socket_path>" in a placeholder label, almost all of our
documentation uses this form.

This is now consistent with the "If a placeholder has multiple words,
they are separated by dashes" guideline added in
9c9b4f2f8b7 (standardize usage info string format, 2015-01-13), let's
add a now-passing test to assert that that's the case.

To do this we need to introduce a very sed-powered parser to extract
the SYNOPSIS from the *.txt, and handle not all commands with "-h"
having a corresponding *.txt (e.g. "bisect--helper"). We'll still want
to handle syntax edge cases in the *.txt in subsequent commits for
other checks, but let's do that then.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/credential-cache--daemon.c |  2 +-
 t/t0450-txt-doc-vs-help.sh         | 46 ++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 4c6c89ab0de..ca672a6a619 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -267,7 +267,7 @@ int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 	const char *socket_path;
 	int ignore_sighup = 0;
 	static const char *usage[] = {
-		"git-credential-cache--daemon [opts] <socket_path>",
+		"git-credential-cache--daemon [opts] <socket-path>",
 		NULL
 	};
 	int debug = 0;
diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index c8820bdd38f..efd00cfc51a 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -30,6 +30,35 @@ help_to_synopsis () {
 	echo "$out"
 }
 
+builtin_to_txt () {
+       echo "$GIT_BUILD_DIR/Documentation/git-$1.txt"
+}
+
+txt_to_synopsis () {
+	builtin="$1" &&
+	out_dir="out/$builtin" &&
+	out="$out_dir/txt.synopsis" &&
+	if test -f "$out"
+	then
+		echo "$out" &&
+		return 0
+	fi &&
+	b2t="$(builtin_to_txt "$builtin")" &&
+	sed -n \
+		-e '/^\[verse\]$/,/^$/ {
+			/^$/d;
+			/^\[verse\]$/d;
+
+			p;
+		}' \
+		<"$b2t" >"$out" &&
+	echo "$out"
+}
+
+check_dashed_labels () {
+	! grep -E "<[^>_-]+_" "$1"
+}
+
 HT="	"
 
 while read builtin
@@ -39,6 +68,23 @@ do
 		h2s="$(help_to_synopsis "$builtin")" &&
 		! grep "$HT" "$h2s"
 	'
+
+	test_expect_success "$builtin -h output has dashed labels" '
+		check_dashed_labels "$(help_to_synopsis "$builtin")"
+	'
+
+	txt="$(builtin_to_txt "$builtin")" &&
+	preq="$(echo BUILTIN_TXT_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
+
+	if test -f "$txt"
+	then
+		test_set_prereq "$preq"
+	fi &&
+
+	# *.txt output assertions
+	test_expect_success "$preq" "$builtin *.txt SYNOPSIS has dashed labels" '
+		check_dashed_labels "$(txt_to_synopsis "$builtin")"
+	'
 done <builtins
 
 test_done
-- 
2.38.0.rc2.935.g6b421ae1592

