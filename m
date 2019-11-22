Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F32C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FC02071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fibzc66q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKVTAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:22 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37918 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfKVTAW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:22 -0500
Received: by mail-pj1-f65.google.com with SMTP id f7so3413746pjw.5
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hi4eiqG4xxcONrlK+1IWoE97ViTKdOAINNiTnaEMKKw=;
        b=fibzc66qVhmS26JklWa1OsrKHQXTncCPjeksd/BxUlSGUnfnqZG1n9fAe8QsxtfrD9
         K8PbHMzhxvhIqBGlaVvX8ovgbNOK20QuGdyWtwMFxkMf8OG9mfmEuTrdfn2OLTZZcYoh
         KhKa5UNB/iufiwKhtLtjxVlW1VNpqBkvXZ7eCgJEzEz4nCkShH3TbyF6D9fbZDYtjdZt
         Cd3PRFZpsnlS3vKV8NsOhDlNkHnxAHJRd+ahl87de/vV7ltyChqH/zEw3yeG9paFrfwF
         ig7eAaAoBEueLNFt1Nhr7IxrL0ME7cqezCY/QKkO/IqePKUEUaP2d5Jfpn2OH46Yojf/
         KjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hi4eiqG4xxcONrlK+1IWoE97ViTKdOAINNiTnaEMKKw=;
        b=fKdkw3cu9FDEpNyfrZuxYQ1LkfuEQgyEvwPHJ4zNvVBR6pFl8S6SxqKpK1lUE47WAH
         o2VfA7S7QHt6HbArC9okiQp0SebdIOxlB8Des4rjdqV09LI8TxTY67af5FjdNEbOgw2b
         pAOuEe6SeD2rWPZ4vvhAKBFAXWUWeXC8j7IR4RZHtk8qDqDuTlk+gyruYNzw5998LIiO
         qWpbHjbN/u6xhcH8S328krSPwQhX6rRBlJsPdZhnYOcEiMJ24ROkOSJtWUsh2LZw/Cx5
         hjFu0gdGqVqWMkU9d5ftP0lSvNvbt3252cEE9rTtsSuKlYBh/x27k33Ea75JxM+Vfyag
         8/PA==
X-Gm-Message-State: APjAAAXwBNL5tM4NGVAU1ZHX/Y91LGm0p5emvWn5Lbk/Lc+E288dXGZs
        hBhk1nZBRMGdJ2/0Ik63XQKB/vrR
X-Google-Smtp-Source: APXvYqz2o+YVe0d/hSpwtmLiYZ+XndJxWGC/LpPNh/16MpPHZ5pU3C38zsAnkahm9sTsKajY968Sow==
X-Received: by 2002:a17:90a:3be4:: with SMTP id e91mr21687564pjc.56.1574449221124;
        Fri, 22 Nov 2019 11:00:21 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id i10sm7728039pgd.73.2019.11.22.11.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:00:20 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:00:18 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 15/22] t5703: stop losing return codes of git commands
Message-ID: <28ef8f3a59d2b7647ee20ded55743e7dcb174919.1574449072.git.liu.denton@gmail.com>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574449072.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there are two ways where the return codes of git commands are
lost. The first way is when a command is in the upstream of a pipe. In a
pipe, only the return code of the last command is used. Thus, all other
commands will have their return codes masked. Rewrite pipes so that
there are no git commands upstream.

The other way is when a command is in a non-assignment command
substitution. The return code will be lost in favour of the surrounding
command's. Rewrite instances of this such that git commands are in an
assignment-only command substitution.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5703-upload-pack-ref-in-want.sh | 46 +++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 88338c4e09..1424fabd4a 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -18,14 +18,16 @@ get_actual_commits () {
 		p
 		}' <out | test-tool pkt-line unpack-sideband >o.pack &&
 	git index-pack o.pack &&
-	git verify-pack -v o.idx | grep commit | cut -c-40 | sort >actual_commits
+	git verify-pack -v o.idx >objs &&
+	grep commit objs | cut -c-40 | sort >actual_commits
 }
 
 check_output () {
 	get_actual_refs &&
 	test_cmp expected_refs actual_refs &&
 	get_actual_commits &&
-	test_cmp expected_commits actual_commits
+	sort expected_commits >sorted_commits &&
+	test_cmp sorted_commits actual_commits
 }
 
 # c(o/foo) d(o/bar)
@@ -75,17 +77,19 @@ test_expect_success 'invalid want-ref line' '
 '
 
 test_expect_success 'basic want-ref' '
+	oid=$(git rev-parse f) &&
 	cat >expected_refs <<-EOF &&
-	$(git rev-parse f) refs/heads/master
+	$oid refs/heads/master
 	EOF
-	git rev-parse f | sort >expected_commits &&
+	git rev-parse f >expected_commits &&
 
+	oid=$(git rev-parse a) &&
 	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
 	0001
 	no-progress
 	want-ref refs/heads/master
-	have $(git rev-parse a)
+	have $oid
 	done
 	0000
 	EOF
@@ -95,19 +99,22 @@ test_expect_success 'basic want-ref' '
 '
 
 test_expect_success 'multiple want-ref lines' '
+	oid_c=$(git rev-parse c) &&
+	oid_d=$(git rev-parse d) &&
 	cat >expected_refs <<-EOF &&
-	$(git rev-parse c) refs/heads/o/foo
-	$(git rev-parse d) refs/heads/o/bar
+	$oid_c refs/heads/o/foo
+	$oid_d refs/heads/o/bar
 	EOF
-	git rev-parse c d | sort >expected_commits &&
+	git rev-parse c d >expected_commits &&
 
+	oid=$(git rev-parse b) &&
 	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
 	0001
 	no-progress
 	want-ref refs/heads/o/foo
 	want-ref refs/heads/o/bar
-	have $(git rev-parse b)
+	have $oid
 	done
 	0000
 	EOF
@@ -117,10 +124,11 @@ test_expect_success 'multiple want-ref lines' '
 '
 
 test_expect_success 'mix want and want-ref' '
+	oid=$(git rev-parse f) &&
 	cat >expected_refs <<-EOF &&
-	$(git rev-parse f) refs/heads/master
+	$oid refs/heads/master
 	EOF
-	git rev-parse e f | sort >expected_commits &&
+	git rev-parse e f >expected_commits &&
 
 	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
@@ -138,17 +146,19 @@ test_expect_success 'mix want and want-ref' '
 '
 
 test_expect_success 'want-ref with ref we already have commit for' '
+	oid=$(git rev-parse c) &&
 	cat >expected_refs <<-EOF &&
-	$(git rev-parse c) refs/heads/o/foo
+	$oid refs/heads/o/foo
 	EOF
 	>expected_commits &&
 
+	oid=$(git rev-parse c) &&
 	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
 	0001
 	no-progress
 	want-ref refs/heads/o/foo
-	have $(git rev-parse c)
+	have $oid
 	done
 	0000
 	EOF
@@ -211,13 +221,14 @@ test_expect_success 'fetching with exact OID' '
 
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
+	oid=$(git -C "$REPO" rev-parse d) &&
 	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin \
-		$(git -C "$REPO" rev-parse d):refs/heads/actual &&
+		"$oid":refs/heads/actual &&
 
 	git -C "$REPO" rev-parse "d" >expected &&
 	git -C local rev-parse refs/heads/actual >actual &&
 	test_cmp expected actual &&
-	grep "want $(git -C "$REPO" rev-parse d)" log
+	grep "want $oid" log
 '
 
 test_expect_success 'fetching multiple refs' '
@@ -239,13 +250,14 @@ test_expect_success 'fetching ref and exact OID' '
 
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
+	oid=$(git -C "$REPO" rev-parse b) &&
 	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin \
-		master $(git -C "$REPO" rev-parse b):refs/heads/actual &&
+		master "$oid":refs/heads/actual &&
 
 	git -C "$REPO" rev-parse "master" "b" >expected &&
 	git -C local rev-parse refs/remotes/origin/master refs/heads/actual >actual &&
 	test_cmp expected actual &&
-	grep "want $(git -C "$REPO" rev-parse b)" log &&
+	grep "want $oid" log &&
 	grep "want-ref refs/heads/master" log
 '
 
-- 
2.24.0.497.g17aadd8971

