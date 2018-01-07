Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58F431F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754468AbeAGSPc (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:32 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40868 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754445AbeAGSP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:29 -0500
Received: by mail-qk0-f196.google.com with SMTP id d18so1317832qke.7
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SwQtcy4OKPS7QRV7dzdfrziJyz0YYVJXPGdSvnd6liQ=;
        b=iO0378EB1GmFWSXxyzx86BH9dGAfnUno+l/bwaEFFasdW6W5Dr4FZtjQOk/x6iiIT7
         qkkzqEfnmzHe9lasJvOX+HxzNmtTKuncHQBaT/U6g1ZakSPYKJxzTa0uq5UT4YYLf+T7
         Jp3P6P2/nUdIj4EEBx7vQXg8DdZEO17KXMhZekmtlCb2dThAUr1xhcyf6DhTb+HwxY4k
         0mP2U0F8EfmSZg+XiDJxhuvFd+v3dGBvesev+INyEEmAtxrz1JUbB0+ZscfdiN6pWxKv
         r33qjKIDNU/AAemInf9qd8b4iUA322smHmU7bIPN2oz9tkxXpQUskAZooTTRIE3XmRX2
         QdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SwQtcy4OKPS7QRV7dzdfrziJyz0YYVJXPGdSvnd6liQ=;
        b=Jk/ZeDtUpDeEsd4R+kN1zD/oJx+yI90FBLR7q/bjynA7JpPMcdPjGpBe0al/2sOG1u
         gbfS0aso0MLPCDdOjWfN8qWDTR6IFDH5OQK4zt2+LwTg2tzDt2Fj/nlPUMpql8a5iZ7U
         QC748F3oN7uP9IsCU5eaoOiDzwu1pwepKF87L9P0fu29q30GOU7UoCoh4OoXR/oy0V5R
         N73NM2UguwMSgbOcS79+P/14a6mlPRRotgu9iAo0pUv9ZxoYlLQvx1nhMDQ71Fb25hNj
         oT6vV3nNcrLjqLo0qAWd7kz7vM8IAu6rKvsrO4SZvTKtkEUjInIRblx2m44bVJayEcYZ
         EAWA==
X-Gm-Message-State: AKGB3mJ0ltwDjZwP8mPFC9Z5hCqAri+UEkyWHGpMBr3KWwHUsUgc55uw
        h5jCAyh4F+PWE+SuGQgVYz5vsTdbavE=
X-Google-Smtp-Source: ACJfBovNy0kL3WwCxwO0ME7eOFtPTuupCguOyAkeF6vJZoqmQkPgfiGnaQRkNXgl8q5RKT45vz4EpQ==
X-Received: by 10.55.192.2 with SMTP id o2mr12064295qki.232.1515348928367;
        Sun, 07 Jan 2018 10:15:28 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:27 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 15/18] midx: use midx for approximate object count
Date:   Sun,  7 Jan 2018 13:14:56 -0500
Message-Id: <20180107181459.222909-16-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The MIDX files contain a complete object count, so we can report the number
of objects in the MIDX. The count remains approximate as there may be overlap
between the packfiles not referenced by the MIDX.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 packfile.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 1c0822878b..866a1f30dd 100644
--- a/packfile.c
+++ b/packfile.c
@@ -803,7 +803,8 @@ static void prepare_packed_git_one(char *objdir, int local)
 		if (ends_with(de->d_name, ".idx") ||
 		    ends_with(de->d_name, ".pack") ||
 		    ends_with(de->d_name, ".bitmap") ||
-		    ends_with(de->d_name, ".keep"))
+		    ends_with(de->d_name, ".keep") ||
+		    ends_with(de->d_name, ".midx"))
 			string_list_append(&garbage, path.buf);
 		else
 			report_garbage(PACKDIR_FILE_GARBAGE, path.buf);
@@ -828,9 +829,12 @@ unsigned long approximate_object_count(void)
 	static unsigned long count;
 	if (!approximate_object_count_valid) {
 		struct packed_git *p;
+		struct midxed_git *m;
 
-		prepare_packed_git();
+		prepare_packed_git_internal(1);
 		count = 0;
+		for (m = midxed_git; m; m = m->next)
+			count += m->num_objects;
 		for (p = packed_git; p; p = p->next) {
 			if (open_pack_index(p))
 				continue;
-- 
2.15.0

