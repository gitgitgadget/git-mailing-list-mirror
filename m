Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0633420248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDCLgO (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:36:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43334 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCLgN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:36:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id m10so7897684plt.10
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Sww8ndWyCxak9+iI+JOYHneVIA0yT5/XJ9VtPjuYpA=;
        b=KFr4lhcGDuVhrk/38+h/AtbYQP0nD8CEYcr1NamEFWFrP4SCoIswGQlXYs0QvlBKyf
         vEQ9D0cn4c11WRHJTDByb01r30NC6nfiSXpfmjALgifrkOQxw1dxKvuVRf9EEMABXZRf
         ia00+CwLk3kVLCp66OC7Nb5I4qm+uIdEFiPxL9HjUlA6oTjZZ54fP4MGnjLOkwcIjHK1
         TNIfpHthAgNGscbqjSrxLgHF++G328cgJWYGSisuF+aQb1CLxOmMfDUQ/wLfJLmnWgXE
         IZ0+4pV4Omgiwdpa4YnWPktnzeti+89TQ6PbUXJjlOJcVlzBdl2/dAzPqU5XEC82tVck
         BCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Sww8ndWyCxak9+iI+JOYHneVIA0yT5/XJ9VtPjuYpA=;
        b=lysLMJtWd2RvL/f4qGOI1IzfGqDaftkUVxwyyOassHdmSz6KIIDoD3ViVZyNY8962p
         xb/teYIRLciqo+WMvji3XwFEwFaDD1lbtRNs00aeyNIoZ/qGrjeBi5FDJ+gCixq3tA9L
         E+yBhHFACbvLBgLE+h9MtMbDwzxCsyIsNIFOKj8RUGlljNWkqzQciql77WM+Nao5zAjO
         4LpQMEeZ9nYmQN69XsQw7SUA47mRoNuTSlmQOv/OBdRq3asqwiiobOIsRK8rhgrTaOU6
         eoB38038t7wsuUBY6GhyRUkDO6wGkGw3XNIDmBfaDaMnX5U9LXZZHq/gyXWdCwyLeUvO
         irlw==
X-Gm-Message-State: APjAAAXCJwgit3CH6oIYw5+y7zXenVd9ohz0rr4H/R0q/CWbMmV4FAP5
        anFznskRpUahoqTL3E21rm8=
X-Google-Smtp-Source: APXvYqz1LSCqGBiWN/5aMeaSH3ePCblXUbD+1JDewZ7verqc1Ke7mWiUdDxIDZdolQ84g7GjNEfjbg==
X-Received: by 2002:a17:902:2b88:: with SMTP id l8mr24150393plb.262.1554291372757;
        Wed, 03 Apr 2019 04:36:12 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id 75sm28611618pfr.55.2019.04.03.04.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:36:12 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:36:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 12/32] sha1-name.c: remove the_repo from find_abbrev_len_packed()
Date:   Wed,  3 Apr 2019 18:34:37 +0700
Message-Id: <20190403113457.20399-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 7558ce51a3..b9381aaba6 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -514,6 +514,7 @@ struct min_abbrev_data {
 	unsigned int init_len;
 	unsigned int cur_len;
 	char *hex;
+	struct repository *repo;
 	const struct object_id *oid;
 };
 
@@ -619,9 +620,9 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 	struct multi_pack_index *m;
 	struct packed_git *p;
 
-	for (m = get_multi_pack_index(the_repository); m; m = m->next)
+	for (m = get_multi_pack_index(mad->repo); m; m = m->next)
 		find_abbrev_len_for_midx(m, mad);
-	for (p = get_packed_git(the_repository); p; p = p->next)
+	for (p = get_packed_git(mad->repo); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
 
@@ -658,6 +659,7 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	if (len == hexsz || !len)
 		return hexsz;
 
+	mad.repo = the_repository;
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
-- 
2.21.0.479.g47ac719cd3

