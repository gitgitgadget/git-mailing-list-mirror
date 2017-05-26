Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 339E9209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946802AbdEZDfV (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:35:21 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36594 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969447AbdEZDfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:35:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so43014443pfb.3
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMwftVyx06WoqgXBe3/+oNSxgUJL41pycp0IAqTb08A=;
        b=DSJqghFbfT+zLLqdKhsrIB2BQyWwx9D+UC5G8nH9uWjbPM1MVz+J/if3kmCq66mg24
         L4fZa4ZLD69GZ6KQWh54DLoQPqkDMTHhV0oGUAvdapaeB26bzH62afISzFmfVzelATQ0
         0PLPxrXd5sZqno4IRExQ2R+IlRYw4ae0T5NyHJYWJS8XPmMeyq/eQCWe1syr7qRjndCd
         1AnUNcCnwv6bBwUt+uh6B7gM/KJ1e+iH983FZyuTAAhNj2LJNnvCtUkfLzR+HUgazcga
         OY04VdmUKk8Ucj7IpKguWr4IGZI3ojOcq2ElimKdEd60yLYWBWdU2rHtkXMnvg1oxbfr
         5xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rMwftVyx06WoqgXBe3/+oNSxgUJL41pycp0IAqTb08A=;
        b=G5GtqzU19Q6XJJlZKrS/rMNjQgQFlnrPhjMgJ89Fw8JqRqbsVU+SkKIPqv4ZGPzn3m
         PdY5OkOi7RjuvONkALOhwS53Gf/2rK9NigtxhONC+02/Srt2VO13W03oOnuycHdR0YcL
         xGSMY8bcv5YnFf62e8GL7KFi6utRMJmcBY5QP/R9y0ILjXRcTfKfhnRUBc/Lj3j/igQB
         E6/bvWMzfTWMzr7zHT4sbEkNPbi+VuR+HL/rqUlmPyBtyk6oLmrrgYCosc/DvIJq6Agi
         okGgZd5zHovAYek65M5UrgtYHRHpe5SyIpZgW2tET/5DKaJj9cvrbAyp9I+0BcIj/E8b
         t0uw==
X-Gm-Message-State: AODbwcDYtbT+nx2PlZhSQynhKmd7gxNQNhcFNDDdk0Enc+ehi7SoR/RY
        vLUNhRaEHd7gRw==
X-Received: by 10.84.133.134 with SMTP id f6mr7297567plf.24.1495769715426;
        Thu, 25 May 2017 20:35:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id s68sm16993773pfj.5.2017.05.25.20.35.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 20:35:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 03/13] clone: use xfopen() instead of fopen()
Date:   Fri, 26 May 2017 12:35:00 +0900
Message-Id: <20170526033510.1793-4-gitster@pobox.com>
X-Mailer: git-send-email 2.13.0-491-g71cfeddc25
In-Reply-To: <20170526033510.1793-1-gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

copy_alternates() called fopen() without handling errors. By switching
to xfopen(), this bug is fixed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index de85b85254..dde4fe73af 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -357,7 +357,7 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 	 * to turn entries with paths relative to the original
 	 * absolute, so that they can be used in the new repository.
 	 */
-	FILE *in = fopen(src->buf, "r");
+	FILE *in = xfopen(src->buf, "r");
 	struct strbuf line = STRBUF_INIT;
 
 	while (strbuf_getline(&line, in) != EOF) {
-- 
2.13.0-491-g71cfeddc25

