Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AC5C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJMPkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJMPkI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D86237DD
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j16so3459550wrh.5
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3sURYIMcphLen+YV83UIINhDyBbfDPahKecLc0UodM=;
        b=jVtbua90UjvTNl/X4Uc+kbeDDCnSBb+4t4D4ad/vIfXEo83h0sTnh2qrYkFQe4k4U7
         KXaEbZxs29DGlK0vvYpz5fripCfRmDls4zgEaCE+9DerZwmE5++iM3SgxYF+IEzSgROt
         avphpv2Kd6qxwgNNEhB6s3G7QV8LIaGIg/JvzuytL73oxeNbvQXRjEGiViqLJJCJ6Dih
         x4VgPWec+ZJXTBtHi4Y4Bj+dv4Y2upcXIiEJIG3FSZ03XEyeQskETJPtmDGQwG8crjQN
         rXrnZ1Ov66yljbxxmjDmiNz3Z/npVYW+vg1IIDsfpk+QGnYF0ZPtJlyIbnRQ9xy+fGDJ
         7mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3sURYIMcphLen+YV83UIINhDyBbfDPahKecLc0UodM=;
        b=0LgB5Or6qv/GY9ljfpygKJfWTsZPWWlI37ywEircBIn8LGdtDAGFUpgQTrQJnq2Z4t
         WV2/fReHnGrJvQIuGuJyB+iztIeFlD+AGcJfkSa9FWk2eWQCxHs1Uup9a7uX4IzNCADz
         K4nNyMVsK4cFT3fH455K2kEi0tvBjHOQ8RO36FL/icoSsUbiq66Fvp3EvNByGoi1P4ST
         2t4+cDKBt4T6vBmUVvsx8O8LhM4WNxGx4DzkANVf6/Nf8p6lINuxbGJn5FvW37jEnxr/
         2PS7Fpwc44yg82p8UeeBJUAi725nvyJa5bxnOLZVJt72BFs5ZZRCNC8Cl3/ghNfLFb9Z
         ei3A==
X-Gm-Message-State: ACrzQf3LZjUDGdOxQgxV3Px+MVaEninCrH4JuR/atfcc0h4Meq3iC2BX
        ECQ8PnnTn5uROh/fP4rvZVdpSHerxLR1Fw==
X-Google-Smtp-Source: AMsMyM44RPT8Gon/Q2AZcfL7r050FxDtc884cBW2tbbv9syFo/YKYoAj6g0eWBOjt8nDYS+3LP9uWQ==
X-Received: by 2002:a5d:64eb:0:b0:22e:48df:f1bb with SMTP id g11-20020a5d64eb000000b0022e48dff1bbmr407915wri.262.1665675589749;
        Thu, 13 Oct 2022 08:39:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:48 -0700 (PDT)
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
Subject: [PATCH v5 15/34] doc SYNOPSIS & -h: use "-" to separate words in labels, not "_"
Date:   Thu, 13 Oct 2022 17:39:09 +0200
Message-Id: <patch-v5-15.34-00b4cc7dfcc-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
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
2.38.0.1085.gb7e61c3016c

