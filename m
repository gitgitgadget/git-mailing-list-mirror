Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DAC620A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeLIKp3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:29 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37725 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeLIKp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id e5-v6so7102645lja.4
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zanxQY/jpn9Lha8aMgRoOtfW2fwUr1nfkSko1F3+hc=;
        b=NuNVAVmyggKuLuqLmzQ6RD9Jq6qclO7gLVWbTd7e/tjcsPHV9LktJbvvfV5P0gWkZy
         y+zuztIr27+m8vEozfx7rr4K74FCobfpgVFDXTiCtJeON1xKD2fKnFvyo7GrRCAe+afl
         C3+pHMGiQdb2wH2Sp4bKEewfod+REWVqX/i+d3enwdAMWTmBrqkgWTq08NAtRJtDXelW
         Mk029/W4L0q2BvAGmLvbRP/Blbyo7RwIdLqBigaammXD9Elf0exVZ437HM39gupsq4EG
         C0YfUfvXrWnN6pWVo3rffPFXynSKlv4f3ZA8tEiUS+o8eXfznHeSj1kr+eHKFX+GuNA7
         dGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zanxQY/jpn9Lha8aMgRoOtfW2fwUr1nfkSko1F3+hc=;
        b=ncfnYOqfbAHKL2k+g7UKXfYHxm4fagtQoPy4jB3SvnhEvuAoOIPW5b5GKEXr1q4CLC
         2i79A4T/TeT8ku9CdVOdZ83MvFhN6dggFdAre8x96EapKf2i5UknnTGAjm7Yd5QuOwgx
         0rcaYXBzNm2sclfGgt1Ad+K654HEo5LWdMWIgkkvTSS+KgoiWf8VjEK2rk4WDBmYr6Lr
         qjp5efm1STBupsqlwys4RhM+Zdjh4JRAY5hXDbjkuIsQ0Q+Nar7l8tI4TwQxCfzass3z
         JWJbikzr08ET9Rdjnu9lKi93iCZYkytkWyEYuaNCKZhCdo6ngI/lGUq8iNo44RJy8V4Z
         xbCQ==
X-Gm-Message-State: AA+aEWbdo06LH/1q8SOIjrsfO0bNzej1p+K0jNZoQWPBuVgq0tZIBUfZ
        4/jmFAWGQDSlA0ai/lkKGu2S298I
X-Google-Smtp-Source: AFSGD/VvOCGXeFjVI5qAUhzs53HKkB61JrfdriC1CS9rz30wWBhXEJUp5DiRH0QU134eYXN50gqrYw==
X-Received: by 2002:a2e:3509:: with SMTP id z9-v6mr4679712ljz.54.1544352324902;
        Sun, 09 Dec 2018 02:45:24 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:24 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 22/24] am: keep backup of overwritten files on --skip or --abort
Date:   Sun,  9 Dec 2018 11:44:17 +0100
Message-Id: <20181209104419.12639-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/am.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 8f27f3375b..098bbaab39 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1886,6 +1886,9 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	opts.update = 1;
 	opts.merge = 1;
 	opts.reset = reset;
+	if (opts.reset)
+		repo_config_get_bool(the_repository, "core.backupLog",
+				     &opts.keep_backup);
 	opts.fn = twoway_merge;
 	init_tree_desc(&t[0], head->buffer, head->size);
 	init_tree_desc(&t[1], remote->buffer, remote->size);
-- 
2.20.0.rc2.486.g9832c05c3d

