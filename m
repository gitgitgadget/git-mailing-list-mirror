Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D5CD1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 17:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbdHPR7Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 13:59:16 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33654 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbdHPR7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 13:59:11 -0400
Received: by mail-lf0-f65.google.com with SMTP id 71so10735lfs.0
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IiW8n+ssDKkam8KvRUv9oMEye1e7ZyOaV9esP9IPuAU=;
        b=Z0Kbc+ayO9e3kNvrb336+15Lo2Eom87y0rbyAlR03mIE79U5qtgyPXWlMsMJaIAPFx
         d8kRW182daAeb+0WZvN/buqKtZHHbcUYw66crga6r2uCg1glJZtyBBB4FiIuRjtids3/
         /IZBGKuKSwVh1HXZUiL678d/SXnM9wQbS+jMOoHz78EeEunmtgD3M1pIocTutRSv1MSC
         Ho3h3CxdOyFoHwg2kYz462vlE6PTVFXUSmSMdnwuq12rFKsjTNZ+Nnv6bBUmFM/PAeCy
         dEy8Sx98k/7xBya14YuWJmh+nj9d6wTmAnXjbXLtSMhxa6MBRAJq4pVlFLpahzC2JfpO
         J2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=IiW8n+ssDKkam8KvRUv9oMEye1e7ZyOaV9esP9IPuAU=;
        b=Nva0+TBrEdrWbPl+bm0kiI3zUFZXgN4qwGJwGyJWjtZ9tU0bOYm2sYSgbxFOTSr+tv
         723+pCPUgtDm4rLiUKqbwEmX/JVWnQ9lREd4LxuBOSWTxNpcxoE/3eLo0hNQLkgJ6GLl
         NcucJuzzpOviEQatATSxZLBbgYf9xAb8Yig8n5k6lQ/MRLjJ7R2KIt7aPzo1NnrOwz77
         squEJkH5NH4dLoiIHHvXitdPEA1vaZ00inZACLAzGLdXQ+BSM2WYgCqA+MOmXGrfKQKN
         rNfnTYPd1f5YLK1zb6d4yO9It14dWOVnqUPd7clczbUfW06kT3An06HdtJMM5cVp1ld0
         T6hg==
X-Gm-Message-State: AHYfb5iKfY/GV8+VxnbAeEj15mTCBEE3IGRV45AEQindXcMdaTXzUhLV
        4dtRkfMN6M2QGrEogIA=
X-Received: by 10.25.151.209 with SMTP id z200mr1032357lfd.198.1502906350248;
        Wed, 16 Aug 2017 10:59:10 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id c64sm361245lfc.4.2017.08.16.10.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Aug 2017 10:59:09 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH v2 3/4] commit: implement free_commit_graft
Date:   Wed, 16 Aug 2017 19:58:24 +0200
Message-Id: <1aefab7d155cffded7184d7c79ae08d6db721d70.1502905085.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1502905085.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
 <cover.1502905085.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1502905085.git.patryk.obara@gmail.com>
References: <cover.1502905085.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for new graft struct version introduced in next commit.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 commit.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 499fb14..4d23e72 100644
--- a/commit.c
+++ b/commit.c
@@ -109,15 +109,20 @@ static int commit_graft_pos(const unsigned char *sha1)
 			commit_graft_sha1_access);
 }
 
+static void free_commit_graft(struct commit_graft *graft)
+{
+	free(graft);
+}
+
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 {
 	int pos = commit_graft_pos(graft->oid.hash);
 
 	if (0 <= pos) {
 		if (ignore_dups)
-			free(graft);
+			free_commit_graft(graft);
 		else {
-			free(commit_graft[pos]);
+			free_commit_graft(commit_graft[pos]);
 			commit_graft[pos] = graft;
 		}
 		return 1;
@@ -163,7 +168,7 @@ struct commit_graft *read_graft_line(struct strbuf *line)
 
 bad_graft_data:
 	error("bad graft data: %s", buf);
-	free(graft);
+	free_commit_graft(graft);
 	return NULL;
 }
 
-- 
2.9.5

