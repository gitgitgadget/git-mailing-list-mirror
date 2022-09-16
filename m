Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CF9ECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 21:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIPVAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 17:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiIPVAf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 17:00:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD0A564CA
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 14:00:32 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so736151pjh.3
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ec7lnRrWxes9wRXdmSVNlVd+wZHqPLLPNdxLPr8MAg4=;
        b=phOiXMuIZs9xnZAgNPwXfkeBnA+b/N7Q0Os8ucd8ydmA3uBqXXECPL1S8pM6q5F/iC
         ihMGBdlNlp+suvq4QVzGQxsiufVyS1GtD3oCDpMOYT0DKKrhRe+hmxT5fCE8WUTa7uAL
         vVj2Lk94nGabRiHh1kX+iGN9AExEZwKX5M8YCzgMYqfbBJiTBbSGuikMvR+851qBs5gW
         aj7SF9AcUnyF64rfiYmHKobXCThRJJtBezywIj/RWKU6Hd3J3Beec1nqjxdhfeuAgafX
         LPgygVe3dnQ6gOswyodH6Tqh+I1iC8fv+vxdEbKKIWMgQzKbJfjAbjzOkDRbAdqQx7Tj
         aXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ec7lnRrWxes9wRXdmSVNlVd+wZHqPLLPNdxLPr8MAg4=;
        b=XdBAiQDg0WIi3yn/bWBwjwsBSfTddCLPR1e27bP2rE2YFoebA5xXDSy+vuKj4PKzhg
         NW7Bb29+6SAZdIPOwfwAGxvenYqDZQkpVkJX8yuh5UC7yKJJQbPKyNpuJlwfAQGCV4LA
         7mpnShrGnFzWAAvbJTquGa1VzphRk0rCuOmCiMb7cNRNhQ/D8Pf+5B9ZdGqk5HaA/N/b
         HrcRRuEqVXxLTb4KZCxjVqTKatK9xS/uQzSClpxFTyrPgR9SzoALLk4sbSU9IAjm/8vb
         FCHMMxZWO3AzR7jeWzI8YH45inGRk/MNrguqoERNTTEn2hGkGal12Gc9xwvHOvAmir/r
         1LHw==
X-Gm-Message-State: ACrzQf0ewZof+rZF6W0dHqKgN7L8WnnzeJJhQKOy+3cZrsxP4Fa1OH7o
        yOiHE+9zJ3zurcWquvR/koEU3v6styx0Eg==
X-Google-Smtp-Source: AMsMyM7OnbruDRGo5QDKcPCA5cEDepgUZ5I/VcqjXYJhedHBzISfjbdt1inMBTbl8I3JXGD/JvoUJg==
X-Received: by 2002:a17:902:eb82:b0:178:2166:fe75 with SMTP id q2-20020a170902eb8200b001782166fe75mr1619315plg.31.1663362031751;
        Fri, 16 Sep 2022 14:00:31 -0700 (PDT)
Received: from HB2.. ([2409:4081:9e81:25b3:3dbb:95ec:385b:406f])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090a3d0900b002002fb120d7sm1961568pjc.8.2022.09.16.14.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 14:00:31 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 3/3] cat-file: add mailmap support to --batch-check option
Date:   Sat, 17 Sep 2022 02:29:46 +0530
Message-Id: <20220916205946.178925-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.0.rc0.3.g53c2677cac
In-Reply-To: <20220916205946.178925-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using `git cat-file --use-mailmap` with --batch-check option, like the
following is allowed:

 git cat-file --use-mailmap -batch-check

The current implementation will return the same object size irrespective
of the mailmap option, which is not as useful as it could be. When we
use the mailmap mechanism to replace the idents, the size of the object
can change and --batch-check option would be more useful if it shows the
size of the changed object. This patch implements that.

Mentored-by: Christian Couder's avatarChristian Couder <christian.couder@gmail.com>
Mentored-by: John Cai's avatarJohn Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt |  2 ++
 builtin/cat-file.c             | 13 +++++++++++++
 t/t4203-mailmap.sh             | 22 ++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 708d094db4..0d5cc9335f 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -101,6 +101,8 @@ OPTIONS
 	with `--use-mailmap`, `--textconv` or `--filters`. In the case of `--textconv` or
 	`--filters` the input lines also need to specify the path, separated by whitespace.
 	See the `BATCH OUTPUT` section below for details.
+	If used with `--use-mailmap` option, will show the size of updated object after
+	replacing idents using the mailmap mechanism.
 
 --batch-command::
 --batch-command=<format>::
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9942b93867..93d127d687 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -424,6 +424,12 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 
 static void print_default_format(struct strbuf *scratch, struct expand_data *data)
 {
+	if (use_mailmap && (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {
+		size_t s = data->size;
+		*data->info.contentp = replace_idents_using_mailmap((char*)*data->info.contentp, &s);
+		data->size = cast_size_t_to_ulong(s);
+	}
+
 	strbuf_addf(scratch, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
 		    type_name(data->type),
 		    (uintmax_t)data->size);
@@ -441,9 +447,14 @@ static void batch_object_write(const char *obj_name,
 			       struct packed_git *pack,
 			       off_t offset)
 {
+	void *buf = NULL;
+
 	if (!data->skip_object_info) {
 		int ret;
 
+		if (use_mailmap)
+			data->info.contentp = &buf;
+
 		if (pack)
 			ret = packed_object_info(the_repository, pack, offset,
 						 &data->info);
@@ -474,6 +485,8 @@ static void batch_object_write(const char *obj_name,
 		print_object_or_die(opt, data);
 		batch_write(opt, "\n", 1);
 	}
+
+	free(buf);
 }
 
 static void batch_one_object(const char *obj_name,
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 59513e7c57..4b236c68aa 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1032,4 +1032,26 @@ test_expect_success 'git cat-file -s returns correct size with --use-mailmap' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file --batch-check returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	echo "92d99959b011b1cd69fe7be5315d6732fe302575 commit 220" >expect &&
+	echo "HEAD" >in &&
+	git cat-file --use-mailmap --batch-check <in >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-command returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	echo "92d99959b011b1cd69fe7be5315d6732fe302575 commit 220" >expect &&
+	echo "info HEAD" >in &&
+	git cat-file --use-mailmap --batch-command <in >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.38.0.rc0.3.g53c2677cac

