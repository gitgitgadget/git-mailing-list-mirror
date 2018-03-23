Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32AFD1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeCWRWR (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:17 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38540 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752511AbeCWRWM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:22:12 -0400
Received: by mail-lf0-f68.google.com with SMTP id y2-v6so19397170lfc.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwOnj3gnVNfmVHLCRMzDPaPA63xcb+m2281GT5qYQdw=;
        b=JRvTGb2YRW/RIeVfPmtGxyel9dBMGCdZu28wLC6YpYPfipIQ1o5nhEiyoPKoH38Uc/
         86dXsa4hN7X5fmnFQmDpXy+EsOs83O7in5Mzi6/dNkNiBVRY2lKmt//b0WQwGkTOnCVO
         gouniz7UboWb7ovq5Bck1dAgBx0FvBQ6vX+jxn0MgkRd10/60AYz/Xm05+5uVfzfou9/
         OXxzguiUWz4Siqrj8VWu6vyeEbOEvHbuBzLiuc4LT5KQNf4S/JDOkxHl+BUXv6/5oKJu
         dJn/qWW2SVbhGomXqJqh8fD6U/HrpP7esm4Rh3iWPzCUiyYVkg1LUa1yosJ3QFWjIR5q
         DGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwOnj3gnVNfmVHLCRMzDPaPA63xcb+m2281GT5qYQdw=;
        b=YIs2MifVspt2hLccbxha2AVNmydHnHv5J+XTO60ksoOI7wT17hl8TzntYx5XvA2Q8z
         3SOrT+f8zsmrpLalsg7lc81KnjlNXz1vIfot96ADvM1D+NM08xuJOXn8bDze+Hb9T7gF
         aIVjh6L1T2SWqYxQ7CI+HRg/eHAX3shu61KiIWGJW7OqdXENXFuvbT5JEyIpPs9j383a
         6Yg3qI9mhqwxO/Do81Vz0u4v7Wlqc8I41rmTGfHg0rF7Mq7tvEXSeKZWUx/fOXbRCSji
         O5Vft3iQSfNJTl04Bbs+sTOUujEdOavMBMb8tRhIuORSNtCs79vX3bZtwD5c/jwsK9EJ
         5rmA==
X-Gm-Message-State: AElRT7GhzvbylQJgX6C3JsSaZ28zX7y3fg+JRU49wxO+2inhhSG2/kzM
        ZdLD5JZY0r2kWulDP9KbReY=
X-Google-Smtp-Source: AG47ELu4dK7KscaeElDx2BBo50hh+q75Ko0P/RF4I9okzcVp0LWxQ2V1JnHI21ALgyd02izHiex2rQ==
X-Received: by 10.46.65.210 with SMTP id d79mr15241009ljf.80.1521825730909;
        Fri, 23 Mar 2018 10:22:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:22:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 23/27] sha1_file: allow stat_sha1_file to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:21:17 +0100
Message-Id: <20180323172121.17725-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index aed9a558c5..fc4f209981 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -867,23 +867,22 @@ int git_open_cloexec(const char *name, int flags)
  * Note that it may point to static storage and is only valid until another
  * call to sha1_file_name(), etc.
  */
-#define stat_sha1_file(r, s, st, p) stat_sha1_file_##r(s, st, p)
-static int stat_sha1_file_the_repository(const unsigned char *sha1,
-					 struct stat *st, const char **path)
+static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
+			  struct stat *st, const char **path)
 {
 	struct alternate_object_database *alt;
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(the_repository, &buf, sha1);
+	sha1_file_name(r, &buf, sha1);
 	*path = buf.buf;
 
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb(the_repository);
+	prepare_alt_odb(r);
 	errno = ENOENT;
-	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next) {
+	for (alt = r->objects->alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
-- 
2.17.0.rc0.348.gd5a49e0b6f

