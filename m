Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E04C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiJDN0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiJDNY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2499AE64
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j16so9369646wrh.5
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGJWUZvyHoLX4t1/2DFPneiiSdXZoUuIEm+kB/8bNwI=;
        b=eG5bILQkRoY8QvKNxORaMfbGc1GhzfRDEdBiSuzXA+XQaGTjmJ8A+DtUJtRAALj9DE
         G9xMSom94Dl1ZPtTh5ZGkIcHYSsDBrJ4kasuBnJr2dYy3NYSgzaPK/7TDWroBdJDXDnG
         5sUUl7bnLT15Bk65wYg/jSQ5INipvxX5lAS4eZ6VN2MCw0qX5YVUbpQ0Atw42mqokpIR
         J466Qz4hl5Bubef7BXxco7QS9N9nrPdfOxc4C0/A2qGWr0UKU7m57lzXPtmDYSscyMSp
         vl0PxkUIbs4H7Nudip+ws6Rgem7Rq13lxn009qnIOp6X8vMcHHqR6TXsyneYJhJMS+V5
         r15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGJWUZvyHoLX4t1/2DFPneiiSdXZoUuIEm+kB/8bNwI=;
        b=4Dh3pvNVWikFjMVdfvuEntBOF1Oa4jISa6r9xQiSHwogRl7nYP3MBwxkQDTM1JRbbd
         7ElA8uOhH+yjAKi1RORwlBzK9eqHDfcdCJXqx5akog04XXUXpHfS2Yls73r6N+QatS1u
         wCwAgNVYdwqSAlX67k5Ik5qQiz92BdhzhmhVhiZJVynVntarAjc+8zGxMq4eNQO9WlUD
         QCkWKZwYD8acQRfpPRHbnc5XlNljbVI0rjKF6Ih4Fxi2eHifGk5yleTbWmdR8u9ygVIq
         IO60OKe9kJPlkwQd2+xx4r8c4EkoDNmIROPVjNzvswb398oNZmAvQ6QzpEDJAxxK9MBU
         xbYA==
X-Gm-Message-State: ACrzQf2B6FLnkGc0rnnY5q7TJci2mspREkTmY+7UgUTqJ3M2dUtC1qXt
        qXEd9LXeA1pJ81lSU7RYHFHEL423fh0tgw==
X-Google-Smtp-Source: AMsMyM5R04r4MZQIbc/D9D4jq3a8n7G/Sedf/spMkLvC1G5LQaX+W96OUz46+zyWEaY/7Sxp2zOEsw==
X-Received: by 2002:adf:c713:0:b0:22a:3670:b08d with SMTP id k19-20020adfc713000000b0022a3670b08dmr16537610wrg.175.1664889876182;
        Tue, 04 Oct 2022 06:24:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:33 -0700 (PDT)
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
Subject: [PATCH v4 34/34] tests: assert consistent whitespace in -h output
Date:   Tue,  4 Oct 2022 15:23:48 +0200
Message-Id: <patch-v4-34.34-3443ae7ee6b-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the *.txt and *.c output assertions which asserts that
for "-h" lines that aren't the "usage: " or " or: " lines they start
with the same amount of whitespace. This ensures that we won't have
buggy output like:

   [...]
   or: git tag [-n[<num>]]
               [...]
       [--create-reflog] [...]

Which should instead be like this, i.e. the options lines should be
aligned:

   [...]
   or: git tag [-n[<num>]]
               [...]
               [--create-reflog] [...]

It would be better to be able to use "test_cmp" here, i.e. to
construct the output we expect, and compare it against the actual
output.

For most built-in commands this would be rather straightforward. In
"t0450-txt-doc-vs-help.sh" we already compute the whitespace that a
"git-$builtin" needs, and strip away "usage: " or " or: " from the
start of lines. The problem is:

 * For commands that implement subcommands, such as "git bundle", we
   don't know whether e.g. "git bundle create" is the subcommand
   "create", or the argument "create" to "bundle" for the purposes of
   alignment.

   We *do* have that information from the *.txt version, since the
   part within the ''-quotes should be the command & subcommand, but
   that isn't consistent (e.g. see "git bundle" and "git
   commit-graph", only the latter is correct), and parsing that out
   would be non-trivial.

 * If we were to make this stricter we have various
   non-parse_options() users (e.g. "git diff-tree") that don't have the
   nicely aligned output which we've had since
   4631cfc20bd (parse-options: properly align continued usage output,
   2021-09-21).

So rather than make perfect the enemy of the good let's assert that
for those lines that are indented they should all use the same
indentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0450-txt-doc-vs-help.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 8fd20b6dba6..cd3969e852b 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -96,6 +96,21 @@ do
 		check_dashed_labels "$(help_to_synopsis "$builtin")"
 	'
 
+	test_expect_success "$builtin -h output has consistent spacing" '
+		h2s="$(help_to_synopsis "$builtin")" &&
+		sed -n \
+			-e "/^ / {
+				s/[^ ].*//;
+				p;
+			}" \
+			<"$h2s" >help &&
+		sort -u help >help.ws &&
+		if test -s help.ws
+		then
+			test_line_count = 1 help.ws
+		fi
+	'
+
 	txt="$(builtin_to_txt "$builtin")" &&
 	preq="$(echo BUILTIN_TXT_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
 
-- 
2.38.0.rc2.935.g6b421ae1592

