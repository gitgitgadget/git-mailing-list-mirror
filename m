Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2555DC433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiI3SMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiI3SLd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:11:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BE2C5BE5
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:10:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e18so3408862wmq.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nnL8flvoTCD6OPL0Vqzt2nJkh/wr1DeOOkmlTrCse94=;
        b=fN+qdU1QCP+WDHRwYqU96oxzpfZpyaGd3Coc70o640uvPmkf6eo2n06YreIStT9VTC
         ug4byRwlz0g1apxFrq09rsokMik6+NCaANeEwfpo6vsHd4u4IN+LkR9i5Li/fGJFPmL+
         xSq0DnudmPQwgX2IsZnQUhDdWhjSukBHPoLHHUiQYZbqZg+sjnVZke1jfbOW4laiLVxN
         cjR/cKgePJoXbDkR5vbnf/VsWxP+6CWRLPt6fibQa+sDWWdB4T/d4Br+q50yNWD/1nGI
         q4n/lYQyJ7wy72DWktrR8yXZJ3h+Oz7UXv8TfQsyWYSSrlB3lpKDLUJXMc8gu8c83hdg
         m3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nnL8flvoTCD6OPL0Vqzt2nJkh/wr1DeOOkmlTrCse94=;
        b=ImvHO4d5lWtdaUvZh+pvuN3rfstpke2g6/ZGVWXVeFGVhwxi+9ciUq1bhQnZPfm7fb
         yVbSyNduvBRL0tcFp+bLxB4goQqm1v7EMQYxBsCPd24xOazzChV2h2cQF6A3qko/dT4O
         BQVXWBiqprhN60bAEYvyY9b4BRDHZK8lqyy68X+eh1tdlWYq9PGp5/3vqYjOip5K1DHC
         SN3rpbkz1n+hK34Wsji6CuvIqBvTo2lt3LK9WEFNBFDkZgppM03xIDWevhiJONZowO5K
         /lintFPrSO2Npno2DKuhgeV3TOoen9CqdBl+cD6gSJPnv1Ov7yLV2mnfltFKBTwjPEmR
         7rJQ==
X-Gm-Message-State: ACrzQf0Z+NjuykHFz3H/3JMv5UU+FKHS4KnpRJec4nOjOgrDxRXX3uOU
        U4aQcxcj/jSIVk+1mBcgsdbh2yKjweq/2Q==
X-Google-Smtp-Source: AMsMyM6Uz+ZXkUQI/LxeBfEwr0JOqmHiLSThgoblt0+gcH6v+UkKT7kIS0vtv+Bvr/wE49nZgZKckQ==
X-Received: by 2002:a05:600c:1989:b0:3b4:b6b6:737 with SMTP id t9-20020a05600c198900b003b4b6b60737mr6707958wmq.79.1664561407536;
        Fri, 30 Sep 2022 11:10:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:10:06 -0700 (PDT)
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
Subject: [PATCH v3 36/36] tests: assert consistent whitespace in -h output
Date:   Fri, 30 Sep 2022 20:07:59 +0200
Message-Id: <patch-v3-36.36-b56113dd620-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
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

Which should instead be like this instead, i.e. the options lines
should be aligned:

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
index 6a710b07408..adc81ec590b 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -66,6 +66,21 @@ do
 		! grep "$HT" help.raw
 	'
 
+	test_expect_success "$builtin -h output has consistent spacing" '
+		builtin_to_synopsis "$builtin" >help.raw &&
+		sed -n \
+			-e "/^ / {
+				s/[^ ].*//;
+				p;
+			}" \
+			<help.raw >help &&
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

