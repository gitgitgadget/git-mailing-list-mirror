Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59AE31F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfGaPgJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:36:09 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45276 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfGaPgI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:36:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so49598804qkj.12
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yXfxPzWNak9YSI5e0c49Fnv0hGNcR2aF7viOrArhXGQ=;
        b=ZxkPsezBwPehrkgn5KhcLOklUAGZEvmaVwZormnAXmPlcCipCN13/+02Lt4Uxfapzs
         rPWWnrady0DQQ7zRlrKmWC86K3pVqsz8mphlw9kKxjXYoWAewNpe17nyBkQh4zulRkN5
         1zKmhZJ0aoy2ZldYAzw3zDLsXFCrxmYN6sr7zDyXqyXJplhWIe/J1lId6fajMqPMzgsR
         i5+VViQU4+u02WDAR+Yu2XzGWhrq0OeAkBV6Vi/KQGZBcFkUTfUUl48yKKFhk7hExC0D
         0prYwllReDoWZ5SpYDEetj4DPR5l47FO31/ZSK6g/5CEMzpmpowLn+d39Gkygq7djGCI
         vj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yXfxPzWNak9YSI5e0c49Fnv0hGNcR2aF7viOrArhXGQ=;
        b=hUeuxG35jK4Bba+CPKsba+/uCDbjCzqY0piz6BDKVFEE+TdeR5dMHQHwYcIZkRGRFw
         DHge1JEdNhc3to/kUAKj0UGQtZE62VisNzLiAOlLAula+PkeEd2xD3jbIyxbXGkKkeCW
         vPH3JMDCSwGiHEHFBNo2iUnxbSSs+i2ZnFfndfrXVe6/6m8KtiB8Fza72VW5LbHkypae
         7syekAj0n/jek+Pn6wv0onkwqPimYCaONCbS1z76RamUQ9wGUaOQnDF5qseMwofaLfaz
         4RJ41Bbl+h7lrKk+E9lBD8en9SuY24luw0z2z/AiqNutPs3mAua2WHuTeuglgvUjkY5s
         XW9g==
X-Gm-Message-State: APjAAAXvS3vBeQyoQrE7DmgzGCjhzT7eFRkRsJzAqPSzpeDNjJbY0CgR
        aDIHkEIpJ5D0/NSmn2OB0MipdXNPAP8=
X-Google-Smtp-Source: APXvYqyn3QWJKNMevmDJErigLXoHn5UUeRxxJgrLPdZJHMY/yq/qrBKejSbXQMWJ/kPi0beJjotVXg==
X-Received: by 2002:a37:7704:: with SMTP id s4mr81237860qkc.310.1564587367272;
        Wed, 31 Jul 2019 08:36:07 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id w9sm29145025qts.25.2019.07.31.08.36.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 08:36:06 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, jackdanielz@eyomi.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v2] grep: fix worktree case in submodules
Date:   Wed, 31 Jul 2019 12:35:32 -0300
Message-Id: <d1fdd091f289e836633b875d87341a66d1fc528a.1564587317.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <ba3d8a953a2cc5b4ff03fefa434ffd7bd6a78f15.1564505605.git.matheus.bernardino@usp.br>
References: <ba3d8a953a2cc5b4ff03fefa434ffd7bd6a78f15.1564505605.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running git-grep with --recurse-submodules results in a cached grep for
the submodules even when --cached is not used. This makes all
modifications in submodules' tracked files be always ignored when
grepping. Solve that making git-grep respect the cached option when
invoking grep_cache() inside grep_submodule(). Also, add tests to
ensure that the desired behavior is performed.

Reported-by: Daniel Zaoui <jackdanielz@eyomi.org>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v2:
- repositioned the '/* ignored */' comment to avoid ambiguity
- joined `git clean` and `git reset` invokations in a single `git
  submodule foreach`. 

travis build: https://travis-ci.org/matheustavares/git/builds/565749070

builtin/grep.c                     | 10 ++++++----
 t/t7814-grep-recurse-submodules.sh | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 560051784e..d9866dd936 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -403,7 +403,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 static int grep_submodule(struct grep_opt *opt,
 			  const struct pathspec *pathspec,
 			  const struct object_id *oid,
-			  const char *filename, const char *path)
+			  const char *filename, const char *path, int cached)
 {
 	struct repository subrepo;
 	struct repository *superproject = opt->repo;
@@ -475,7 +475,7 @@ static int grep_submodule(struct grep_opt *opt,
 		strbuf_release(&base);
 		free(data);
 	} else {
-		hit = grep_cache(&subopt, pathspec, 1);
+		hit = grep_cache(&subopt, pathspec, cached);
 	}
 
 	repo_clear(&subrepo);
@@ -523,7 +523,8 @@ static int grep_cache(struct grep_opt *opt,
 			}
 		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
 			   submodule_path_match(repo->index, pathspec, name.buf, NULL)) {
-			hit |= grep_submodule(opt, pathspec, NULL, ce->name, ce->name);
+			hit |= grep_submodule(opt, pathspec, NULL, ce->name,
+					      ce->name, cached);
 		} else {
 			continue;
 		}
@@ -598,7 +599,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			free(data);
 		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
 			hit |= grep_submodule(opt, pathspec, &entry.oid,
-					      base->buf, base->buf + tn_len);
+					      base->buf, base->buf + tn_len,
+					      1 /* ignored */);
 		}
 
 		strbuf_setlen(base, old_baselen);
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index a11366b4ce..edb64690e6 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -408,4 +408,24 @@ test_expect_success 'grep --recurse-submodules with submodules without .gitmodul
 	test_cmp expect actual
 '
 
+reset_and_clean () {
+	git reset --hard &&
+	git clean -fd &&
+	git submodule foreach --recursive 'git reset --hard && git clean -fd'
+}
+
+test_expect_success 'grep --recurse-submodules without --cached considers worktree modifications' '
+	reset_and_clean &&
+	echo "A modified line in submodule" >>submodule/a &&
+	echo "submodule/a:A modified line in submodule" >expect &&
+	git grep --recurse-submodules "A modified line in submodule" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --recurse-submodules with --cached ignores worktree modifications' '
+	reset_and_clean &&
+	echo "A modified line in submodule" >>submodule/a &&
+	test_must_fail git grep --recurse-submodules --cached "A modified line in submodule" >actual 2>&1 &&
+	test_must_be_empty actual
+'
 test_done
-- 
2.22.0

