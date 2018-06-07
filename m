Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA62B1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbeFGOEn (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:43 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46427 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932852AbeFGODx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:53 -0400
Received: by mail-qt0-f196.google.com with SMTP id h5-v6so9906777qtm.13
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EEtwY+UHE57gUl3Jx0cNICXH1pn4bAsKZ7bSoIQ2ZWU=;
        b=YPrzZr8q8jjfCCtcMqXehmNZ/s4XjLoVB8ZDtsm1fe/QWNjPcode8a5fHEwTzyq4cD
         8+PuCkjPf8LWX6tgH8itI6Z29uamglpE51561wWxppyfFCNOmwsx+6BWCyQofa2dQ3gx
         h8vBfDW2zUzcqwny+ofyjw1UGd9nyId2Majkt4C2FakFgcenXxamlJ1UJPNVwiXI07yx
         qCrc4sD8GKB2bPIPybf+I9Basp6FFl6nRXm86Ilw6PWN2Y8TaJLFV4+oK+vkxM8Y732I
         hc7pUG3IRz0ykKdsKIEhRTqqzIGy4xZUfz9cMOdrZcFy3CTil+7SJQ63S4G4zFd2XTDh
         2RCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EEtwY+UHE57gUl3Jx0cNICXH1pn4bAsKZ7bSoIQ2ZWU=;
        b=FduEaMXgRcYnKDdsYTooTO5wV/ZzTc1fEupu51E5IMwaaPzl7s5wbwLLzEaKK0L+9K
         0mcOTWRqwScVAmMfz1PzjLBikn7PJV8+H1mTLJO+QK070WdP2H0fj/e2WUkQ8pN8cIgZ
         M3OXaKwB+Q68WSXWHjCniBJ40Ajjn33HIefW15owXCZLJQaYaUMyHU3W2XQY3CWlAoVc
         PgriR33VZ5YEMMWp+rSitb3KbXp3hxysRYLNe2B9R3xopYbnDrv2LWA/TWCdO59vZ3+w
         fOPBKHPUJ/SQQW0y25mJ7n98z6jgSX4utSY9Cx9/Ndd2ZKcF/0QztWfu44XmUK04RTgv
         HVMw==
X-Gm-Message-State: APt69E2w0MPzeukCTjQPfwJZxtJnU1aiBOBNkZYxlGrxfVhYqTN9rBpY
        poc4Ul52DGFNVxg8lFdyjhk4Yi7B
X-Google-Smtp-Source: ADUXVKLqRmG4YPKGessxH8bKLIpBC6vAPUzm9b3AJPyABsAsQlORBTyGaWi6aly8Pjw/NwxGJuq4NQ==
X-Received: by 2002:ac8:264d:: with SMTP id v13-v6mr1791097qtv.228.1528380232274;
        Thu, 07 Jun 2018 07:03:52 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:03:51 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 08/23] midx: read packfiles from pack directory
Date:   Thu,  7 Jun 2018 10:03:23 -0400
Message-Id: <20180607140338.32440-9-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When constructing a multi-pack-index file for a given object directory,
read the files within the enclosed pack directory and find matches that
end with ".idx" and find the correct paired packfile using
add_packed_git().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c          | 51 +++++++++++++++++++++++++++++++++++++++++++++++--
 t/t5319-midx.sh | 15 ++++++++-------
 2 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/midx.c b/midx.c
index fa18770f1d..9fb89c80a2 100644
--- a/midx.c
+++ b/midx.c
@@ -102,10 +102,15 @@ static size_t write_midx_header(struct hashfile *f,
 int write_midx_file(const char *object_dir)
 {
 	unsigned char num_chunks = 0;
-	uint32_t num_packs = 0;
 	char *midx_name;
 	struct hashfile *f;
 	struct lock_file lk;
+	struct packed_git **packs = NULL;
+	uint32_t i, nr_packs = 0, alloc_packs = 0;
+	DIR *dir;
+	struct dirent *de;
+	struct strbuf pack_dir = STRBUF_INIT;
+	size_t pack_dir_len;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -114,14 +119,56 @@ int write_midx_file(const char *object_dir)
 			  midx_name);
 	}
 
+	strbuf_addf(&pack_dir, "%s/pack", object_dir);
+	dir = opendir(pack_dir.buf);
+
+	if (!dir) {
+		error_errno("unable to open pack directory: %s",
+			    pack_dir.buf);
+		strbuf_release(&pack_dir);
+		return 1;
+	}
+
+	strbuf_addch(&pack_dir, '/');
+	pack_dir_len = pack_dir.len;
+	ALLOC_ARRAY(packs, alloc_packs);
+	while ((de = readdir(dir)) != NULL) {
+		if (is_dot_or_dotdot(de->d_name))
+			continue;
+
+		if (ends_with(de->d_name, ".idx")) {
+			ALLOC_GROW(packs, nr_packs + 1, alloc_packs);
+
+			strbuf_setlen(&pack_dir, pack_dir_len);
+			strbuf_addstr(&pack_dir, de->d_name);
+
+			packs[nr_packs] = add_packed_git(pack_dir.buf,
+							 pack_dir.len,
+							 0);
+			if (!packs[nr_packs])
+				warning("failed to add packfile '%s'",
+					pack_dir.buf);
+			else
+				nr_packs++;
+		}
+	}
+	closedir(dir);
+	strbuf_release(&pack_dir);
+
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
 
-	write_midx_header(f, num_chunks, num_packs);
+	write_midx_header(f, num_chunks, nr_packs);
 
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	commit_lock_file(&lk);
 
+	for (i = 0; i < nr_packs; i++) {
+		close_pack(packs[i]);
+		FREE_AND_NULL(packs[i]);
+	}
+
+	FREE_AND_NULL(packs);
 	return 0;
 }
diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
index 2c25a69744..abe545c7c4 100755
--- a/t/t5319-midx.sh
+++ b/t/t5319-midx.sh
@@ -4,8 +4,9 @@ test_description='multi-pack-indexes'
 . ./test-lib.sh
 
 midx_read_expect() {
+	NUM_PACKS=$1
 	cat >expect <<- EOF
-	header: 4d494458 1 1 0 0
+	header: 4d494458 1 1 0 $NUM_PACKS
 	object_dir: .
 	EOF
 	git midx read --object-dir=. >actual &&
@@ -16,7 +17,7 @@ test_expect_success 'write midx with no packs' '
 	git midx --object-dir=. write &&
 	test_when_finished rm pack/multi-pack-index &&
 	test_path_is_file pack/multi-pack-index &&
-	midx_read_expect
+	midx_read_expect 0
 '
 
 test_expect_success 'create objects' '
@@ -47,14 +48,14 @@ test_expect_success 'write midx with one v1 pack' '
 	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
 	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
 	git midx --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 1
 '
 
 test_expect_success 'write midx with one v2 pack' '
 	pack=$(git pack-objects --index-version=2,0x40 pack/test <obj-list) &&
 	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx &&
 	git midx --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 1
 '
 
 test_expect_success 'Add more objects' '
@@ -85,7 +86,7 @@ test_expect_success 'write midx with two packs' '
 	pack1=$(git pack-objects --index-version=1 pack/test-1 <obj-list) &&
 	pack2=$(git pack-objects --index-version=1 pack/test-2 <obj-list2) &&
 	git midx --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 2
 '
 
 test_expect_success 'Add more packs' '
@@ -108,7 +109,7 @@ test_expect_success 'Add more packs' '
 		git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
 		} >obj-list &&
 		git update-ref HEAD $commit &&
-		git pack-objects --index-version=2 test-pack <obj-list &&
+		git pack-objects --index-version=2 pack/test-pack <obj-list &&
 		i=$(expr $i + 1) || return 1 &&
 		j=$(expr $j + 1) || return 1
 	done
@@ -116,7 +117,7 @@ test_expect_success 'Add more packs' '
 
 test_expect_success 'write midx with twelve packs' '
 	git midx --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 12
 '
 
 test_done
-- 
2.18.0.rc1

