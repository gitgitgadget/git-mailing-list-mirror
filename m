Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E7CB206FB
	for <e@80x24.org>; Sat,  9 Jul 2016 05:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933108AbcGIFY0 (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 01:24:26 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33088 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcGIFYW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 01:24:22 -0400
Received: by mail-lf0-f67.google.com with SMTP id l188so8725374lfe.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 22:24:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67BIVVnj93QeytkA5Pn+BVFuBz9F39EIhto+wsiXyCI=;
        b=Z7n5NhFPteC8MNB408TrqHDU3v82cHJ8J3ok1zMFV1X5Uho53oiPKuC9737TXqn2fN
         qnckNlYdpb0nsENAMFPaeR2HQYZlz0OC93StiFZKu9zUfBsIfEDr0gikWyShD4znddeM
         tZ+XIQeBPtsoaTTozKlLDQMMy6H9lvANpixQj4dyZAjiM9Ne9YWnwuc88SXQzvA9JqAP
         me8qj9ozQc3kgyuEe0sPDiy33JzqdYRDF3VPRq5ymI4w3extW1vLn8ve9ll/jV/ku4yI
         AvXhl0Pu2fBd2pMBKQBhdNRfxxDdtMDl4bCUlhMlCc1UAJkM/jg68o/vTfM0s82IKhJ/
         b1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67BIVVnj93QeytkA5Pn+BVFuBz9F39EIhto+wsiXyCI=;
        b=P+kFiR8+PYsFitvQrvJfIVw1kUIOb2TPYsPTP6fw9yJL/xiSO1uEiDIhoBKJczB06F
         J1wxXktpQ7xA71+5r7IrDY15UiIFp3+jA5C6/HXNja22Ft8Npp1zXn9CzbPJm1wPm9Lz
         YPoN0rJckU//MBBObTt50Jz3pWS5qy2Y9jLJ3b/RDYmL/JTbguqo95tkWbkEl/KEhoZi
         Xd+Em2WGbS3wWGXt7ldWWbNIgatw6xjPcSdoqzhpFDYuNe74GuyeHH7vUvZu+NB1i1yc
         idC9zh4psMsKcfxzSfcqNGmPrvybanXhkZVAe2dpzcEnfcLkDmHk2xCXXd+o4US1qTH5
         RCnA==
X-Gm-Message-State: ALyK8tJwB3K1JfitX61cfgAL8/ECYihM44JhU15+mNkGzK4VCw6d0s5rdML0EHERx/G1XA==
X-Received: by 10.25.24.98 with SMTP id o95mr1955625lfi.23.1468041861004;
        Fri, 08 Jul 2016 22:24:21 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id f66sm1450237lji.13.2016.07.08.22.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jul 2016 22:24:19 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, yuri.kanivetsky@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 4/4] cache-tree: do not generate empty trees as a result of all i-t-a subentries
Date:	Sat,  9 Jul 2016 07:23:56 +0200
Message-Id: <20160709052356.30570-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
In-Reply-To: <20160709052356.30570-1-pclouds@gmail.com>
References: <20160706184829.31825-1-pclouds@gmail.com>
 <20160709052356.30570-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If a subdirectory contains nothing but i-t-a entries, we generate an
empty tree object and add it to its parent tree. Which is wrong. Such
a subdirectory should not be added.

Note that this has a cascading effect. If subdir 'a/b/c' contains
nothing but i-t-a entries, we ignore it. But then if 'a/b' contains
only (the non-existing) 'a/b/c', then we should ignore 'a/b' while
building 'a' too. And it goes all the way up to top directory.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache-tree.c          |  7 +++++++
 t/t2203-add-intent.sh | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index c2676e8..2d50640 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -380,6 +380,13 @@ static int update_one(struct cache_tree *it,
 			continue;
 		}
 
+		/*
+		 * "sub" can be an empty tree if subentries are i-t-a.
+		 */
+		if (sub && sub->cache_tree->entry_count < 0 &&
+		    !hashcmp(sha1, EMPTY_TREE_SHA1_BIN))
+			continue;
+
 		strbuf_grow(&buffer, entlen + 100);
 		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0');
 		strbuf_add(&buffer, sha1, 20);
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 24aed2e..f4b2fac 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -99,5 +99,19 @@ test_expect_success 'cache-tree does not ignore dir that has i-t-a entries' '
 	)
 '
 
+test_expect_success 'cache-tree does skip dir that becomes empty' '
+	rm -fr ita-in-dir &&
+	git init ita-in-dir &&
+	(
+		cd ita-in-dir &&
+		mkdir -p 1/2/3 &&
+		echo 4 >1/2/3/4 &&
+		git add -N 1/2/3/4 &&
+		git write-tree >actual &&
+		echo $_EMPTY_TREE >expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done
 
-- 
2.8.2.537.g0965dd9

