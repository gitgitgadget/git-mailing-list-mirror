Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74E2C209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969446AbdEZDfi (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:35:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34236 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946821AbdEZDfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:35:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so43045593pfk.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rOGNLoc33uTsg+C6Zw3OYBx8EyOougBS2g85f6sbUkA=;
        b=mm/8pdvU5Gr6MIyfyXl3Q1eNp8+iWn+DubVh/UdWzpZ2Zya6fmB3OwjdVEAMqIAfDp
         UTuxkB8XT+YNXX3rhxzwNSSOCyi+iOZsWVHd4HTcyHvrFcyqgRJzmOscqLy9B67KrYaT
         5m3UL+rwBGviV9isP7cbgcu4f2VdE3smK/2Rrl2t6YWO3SrKTUavOfk7PBmhahC93r7v
         R4SmP4Cq447LfYIU0wjk5dHEJzn3B25fmJmB6nrn8gTJwtejw7CKwMnR99C2dOcayFSS
         YcmIWigH4WsKByB9sQ+MQPZg1nulKb/LbkZItnqUvQtKzaXz45W+W1cskfPBSckQkb+a
         AjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rOGNLoc33uTsg+C6Zw3OYBx8EyOougBS2g85f6sbUkA=;
        b=X0T80YA0YxizMN682gAYb7hUSrl9sEQu660vx6r3sm9qK2ly3WzSfzEj2BP9gJ/n9G
         dS1ChJ/2sFs+YPv59O9wUnZTfLl/y8hYYdHy59UAfs2R6c5Ud5oOqZdDDHPJzIFKDdiB
         gzRhDJnPM8fi5SU1s6RUBW+KPS8qeVeyhLztPIdq/EGj90rt2KkUp6CAKdq8RJXXQ2UK
         3nInpGb5O8LtDERG9pSq3UjpbRLLbV81d6EvLP5zMkp6EUJySfdYESVG7S3vbcxV9RJ9
         yTF7Nz3cFZroa/NzF7e5FNGoKISIUZTuYVpc2IIb75x9QU0ZwG82ue3OEShUHZiXCv3q
         8aXQ==
X-Gm-Message-State: AODbwcCRbeF824XeSWoUN1OHjUEZnYi9FCJF7nXHbla0c1ze7/4q83Wx
        iEkw/okQj1Z56Q==
X-Received: by 10.98.163.152 with SMTP id q24mr48581094pfl.217.1495769724638;
        Thu, 25 May 2017 20:35:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id x12sm16899649pgc.47.2017.05.25.20.35.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 20:35:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 10/13] rerere.c: move error_errno() closer to the source system call
Date:   Fri, 26 May 2017 12:35:07 +0900
Message-Id: <20170526033510.1793-11-gitster@pobox.com>
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

We are supposed to report errno from fopen(). fclose() between fopen()
and the report function could either change errno or reset it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rerere.c b/rerere.c
index 1351b0c3fb..c26c29f87a 100644
--- a/rerere.c
+++ b/rerere.c
@@ -489,8 +489,9 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 	if (output) {
 		io.io.output = fopen(output, "w");
 		if (!io.io.output) {
+			error_errno("Could not write %s", output);
 			fclose(io.input);
-			return error_errno("Could not write %s", output);
+			return -1;
 		}
 	}
 
-- 
2.13.0-491-g71cfeddc25

