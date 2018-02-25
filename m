Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 422621F576
	for <e@80x24.org>; Sun, 25 Feb 2018 11:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbeBYLTS (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 06:19:18 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42582 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeBYLTR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 06:19:17 -0500
Received: by mail-pf0-f194.google.com with SMTP id t15so5376322pfh.9
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 03:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBJksSBzQKQh4Y90ofWZs2oh3r93F+IQ1fVbXvcuxu4=;
        b=cRDQVdJ7U+1KDeb4ta3fN8PIAnztCBqlwfs70rjcUkWXNVcJzYbtCAKmPYWDlgqL7Q
         n8JVG/2ac8dST7QPfox29WI65jd8rFrgnUdqYzMYxIzgtf2bta5h4fmjDkFjJm7Lpyvy
         X2VGH2O8b12MdTikR71t+Cvjuhj05+/BSmrTKn+/mdAAPHMhl2Rvxh3OWCQn5L9pA3hm
         qnH5pD3bqRVJCaW89BYdWVUD4Fxja8HRpyp1iUCPsuwaV4D/8LhW+OkCg2f4UtI7Z7C9
         7+T8mbaQEKcSCTZPrkl24L5qGjqrxo7qKu4etwux6Dq4vLWOCuaUZZS66K9X1dOCNK2g
         567w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBJksSBzQKQh4Y90ofWZs2oh3r93F+IQ1fVbXvcuxu4=;
        b=kKlBC36UdZ/6cFWXs3KQ8FP8QDW0dL7TKF6b/dQZ8pB5diRQxT9ViRPPR9d6zodYuA
         LKwEH1ETeO5sg2CWNm9lXNXG3t71+77VtvY3fdyW7Y0qi7Pv0eRh6ElxOnGHiHhz4QWO
         BynB74oKhGho/vEbFy1WcwbytajGz1qErdoRuQIs1w6jF5SWx9BqmW8QLzGsXlCvkNhg
         OPoUB/Whhq59XFsvLIUflsUBAuPgFcAhX4XVq1lizm4ZaQPElNU0786uLxed+2XVv1c3
         MbY5pPfRqnYIpprSwwotSUPEXIstaNQUo1k0lF3mtLOwv+cfdkT80DDUzlkU38K5tMZK
         XejA==
X-Gm-Message-State: APf1xPAMJmZnai7bBcT2XdMprCOZoLmQrQ9jC0FZUDsDBEu5Kf2sD/E4
        KsQRh8sZkfn92TpoyDIDJw1jZw==
X-Google-Smtp-Source: AH8x225DejV0vx/Ma5JXXj8F40zCi+H72jyzY2hCqHph12jK6sukyMF34pSl74v1X2p1UfS4GGQhOA==
X-Received: by 10.99.148.17 with SMTP id m17mr5827463pge.367.1519557557538;
        Sun, 25 Feb 2018 03:19:17 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id d15sm8896035pfj.121.2018.02.25.03.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 03:19:16 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 25 Feb 2018 18:19:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH v3 5/6] diff.c: initialize hash algo when running in --no-index mode
Date:   Sun, 25 Feb 2018 18:18:39 +0700
Message-Id: <20180225111840.16421-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180225111840.16421-1-pclouds@gmail.com>
References: <20180224033429.9656-1-pclouds@gmail.com>
 <20180225111840.16421-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our "git diff" command supports running as a standalone tool. In this
code path, we try to hash the file content but after
18e2588e11 (sha1_file: switch uses of SHA-1 to the_hash_algo -
2018-02-01), there is a chance that the_hash_algo (required by
index_path) may still be uninitialized if no repository is found.

Executing index_path() when the_hash_algo is NULL (or points to unknown
algo) either crashes or dies. Let's make it a bit safer by explicitly
falling back to SHA-1 (so that the diff output remains the same as
before, compared to the alternative that we simply do not hash).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/diff.c b/diff.c
index 21c3838b25..5f28d84b87 100644
--- a/diff.c
+++ b/diff.c
@@ -3995,6 +3995,18 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 		return;
 	}
 
+	/*
+	 * NEEDSWORK: When running in no-index mode (and no repo is
+	 * found, thus no hash algo configured), fall back to SHA-1
+	 * hashing (which is used by diff_fill_oid_info below) to
+	 * avoid regression in diff output.
+	 *
+	 * In future, perhaps we can allow the user to specify their
+	 * hash algorithm from command line in this mode.
+	 */
+	if (o->flags.no_index && !repo_has_valid_hash_algo(the_repository))
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	diff_fill_oid_info(one);
 	diff_fill_oid_info(two);
 
-- 
2.16.1.435.g8f24da2e1a

