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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA6CC432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AF32071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiQZByTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKVTAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33678 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKVTAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay6so3486293plb.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mJK+lcHlA1fY+OG1hmib6cPHKLrlJBTUhqlH4O40ELI=;
        b=fiQZByTF00bsQ667k/RfHbvbQgzU8bgus5a4mJSv8i0io32Wvh5W9oNv+JnTcTtRjp
         OpcFKzyx+SqfyqobbZHxG4paetpxRwmbFLa83pWkvMB6kEH9LVtf01OD7H7lwV2DyfDQ
         Gvh1355wtI2CQr4nYioMO+/HD7rRv+H/biPeJo9sK97ZvGp9hScqdYn/GKCVOLtHczhB
         f3dtmFr7TxXE2hJ3sOXqRQNMEJLThq74giEbq7uFJi6vnwPk482iXHoeICqMw3gS0UR9
         vik2LC9mDFbbKU26zZPr7lVddLFqcSA094pb2sBmsUfV64iL0phPv1DNemvMRMYgIxxF
         iP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mJK+lcHlA1fY+OG1hmib6cPHKLrlJBTUhqlH4O40ELI=;
        b=fhg5zNcg008mPsa/o9AcshbdTrL/Bgvxa9D7ySzBGzw2K4IP9t5AVJYm9Z04AmSX6q
         kNqwqTC5vWWQP0mLT98evaaxT67Y7A/5vdXYEndAQWAmtgFrREU3gUkGjasnqAXu9/6r
         hUvzUXyHmo+eFsVaibhitBXLsHkkuI+jvAg3lgwS+k73TvltTABPSzA5s5zsUz9HXEM9
         zoasUIgTEjJ59c9NFn+2AFvdGRBsnfuL1Co067AA9kL3sJswKJaT6KFgb0unyERyqgP+
         uYvtH8HEDKZWuYRJDKYYHOn0fSE9kxxeU6U2BrgTsix0SbYy9eYaSnFTkmslZQaTeITF
         gIZQ==
X-Gm-Message-State: APjAAAV7w6cN2whLoyL7+u9UG1LVN8ZS9SiUegxOeBV8XcWhPxGTuxf8
        UfDJ9ESY86TXH0nKEYly+O6JiYD2
X-Google-Smtp-Source: APXvYqyiDqvBeX0gzjzinfVkAoG4+1NdSZKQqUgU6T6UReQoe8E/Ox4kXFAbOkdKHiztT5a9Bxv3XQ==
X-Received: by 2002:a17:902:b101:: with SMTP id q1mr16189915plr.154.1574449213473;
        Fri, 22 Nov 2019 11:00:13 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id m6sm7287459pgl.42.2019.11.22.11.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:00:12 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:00:11 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 12/22] t5317: stop losing return codes of git commands
Message-ID: <56eebcc249681233ea19b5d12400030aad9a259d.1574449072.git.liu.denton@gmail.com>
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
command's. Rewrite instances of this such that git commands output to a
file and surrounding commands only call command substitutions with
non-git commands.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5317-pack-objects-filter-objects.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 2d2f5d0229..a8bbad74e2 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -72,7 +72,8 @@ test_expect_success 'get an error for missing tree object' '
 	echo foo >r5/foo &&
 	git -C r5 add foo &&
 	git -C r5 commit -m "foo" &&
-	del=$(git -C r5 rev-parse HEAD^{tree} | sed "s|..|&/|") &&
+	git -C r5 rev-parse HEAD^{tree} >tree &&
+	del=$(sed "s|..|&/|" tree) &&
 	rm r5/.git/objects/$del &&
 	test_must_fail git -C r5 pack-objects --revs --stdout 2>bad_tree <<-EOF &&
 	HEAD
@@ -230,10 +231,9 @@ test_expect_success 'verify explicitly specifying oversized blob in input' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
-	HEAD
-	$(git -C r2 rev-parse HEAD:large.10000)
-	EOF
+	echo HEAD >objects &&
+	git -C r2 rev-parse HEAD:large.10000 >>objects &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k <objects >filter.pack &&
 	git -C r2 index-pack ../filter.pack &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
@@ -377,7 +377,8 @@ test_expect_success 'verify sparse:oid=OID' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	oid=$(git -C r4 ls-files -s pattern | awk -f print_2.awk) &&
+	git -C r4 ls-files -s pattern >staged &&
+	oid=$(awk -f print_2.awk staged) &&
 	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=$oid >filter.pack <<-EOF &&
 	HEAD
 	EOF
-- 
2.24.0.497.g17aadd8971

