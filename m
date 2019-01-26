Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2491F453
	for <e@80x24.org>; Sat, 26 Jan 2019 20:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfAZUvH (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 15:51:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42259 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbfAZUvH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 15:51:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so13800979wrx.9
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 12:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWc5/f532QW6EynJZlIY671NQMxy3PpskJg8B9OXVE8=;
        b=jtpeeijwFscHWb9+IB9NYVnC4NRJg/GtPt2vlkfKoHvM5vMB1hftjm9+aE6/HJAzwu
         bGqGchhdmFVtIRWWXwJuICvrmkFOqguBtYBJh/LhNpR15PWfKllfnnaHmw1vM/xbsosT
         iEUzwRNW7PyGi4zpfZfxjpwWv9o0cJxHu7SPJnChbiOGumb5iEMDeK6uhTSVf3pTOaF0
         rj1XG6qLasHF29KndZq2U8Wan7z2NV1hluhQCGIc8/gZXQPI1WEVN/P88/NvJ2gkTqCD
         3oWY762kACJSrQpQxbTMYIxp31Wzkbo+UqT61X+ZhuKr6qQhTZHCsjd4WmjSDHh/vjM8
         qijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWc5/f532QW6EynJZlIY671NQMxy3PpskJg8B9OXVE8=;
        b=bWy1Nad5b0vgcj+WxpvkPa5yYWKPtmYR1kuXNyb15JfHZW0X6VVnoFyVZQIMU/psWk
         vYHdt1XyZOpmVVrTqCNoH790WFdBQNTAiuFFcXsOhHPeXij/kwCfZEgMYsqpO3UIwBJ+
         ldb6paR5GOSfP85g6LLwu2CemEd638TObZNOX/0eEhPeDbcZSBFEjO5sE77twyf1FT9W
         x4pPMd7poCBIDEGzvCmiHdypwwXTCTQ7j1SduijGl+TK6fMeNcvjLaj7/FS8WAjffktM
         wd72KxJsSCnTQFWPDc3Fc3Z2rw8AfQUj39BTbd4Iu/yv4cLHX902k10mpkQdwKxozSna
         rCzA==
X-Gm-Message-State: AJcUukf/0hWPdrZPI1rx+iFoD5la97zp1P3Byg/Hv22wJa4/BF3qmXQl
        8MlAKHfnOKhjp4++S4QyJLCAhBDEwYE=
X-Google-Smtp-Source: ALg8bN6OBY5/9Qpg68gQqHWjQ25zmH18PQMpd6g/lVhgd50HInJOkgOhNXim75Rrk+5pthkX0ovGzw==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr15439746wrt.193.1548535865135;
        Sat, 26 Jan 2019 12:51:05 -0800 (PST)
Received: from localhost.localdomain (ip5b43d796.dynamic.kabel-deutschland.de. [91.67.215.150])
        by smtp.gmail.com with ESMTPSA id m21sm48049415wmi.43.2019.01.26.12.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 26 Jan 2019 12:51:04 -0800 (PST)
From:   Sebastian Staudt <koraktor@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>
Subject: [PATCH v2 2/3] Setup working tree in describe
Date:   Sat, 26 Jan 2019 21:49:50 +0100
Message-Id: <20190126204951.42455-2-koraktor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190126204951.42455-1-koraktor@gmail.com>
References: <20190126204951.42455-1-koraktor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This ensures the given working tree is used for --dirty.

The implementation of --broken uses diff-index which calls
setup_work_tree() itself.

Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
---
 builtin/describe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index cc118448ee..b5b7abdc8f 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -629,6 +629,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			struct argv_array args = ARGV_ARRAY_INIT;
 			int fd, result;
 
+			setup_work_tree();
 			read_cache();
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
-- 
2.20.1

