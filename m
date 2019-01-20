Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E36B1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 08:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfAUIBy (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 03:01:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40884 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbfAUIBy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 03:01:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so22096516wrt.7
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 00:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j+GDuvS6UdHWoKJEjzslmQxxd1iCxz+2Q3jbwUSEC60=;
        b=RDS4fABn287Ce64kyds+7zGGLXxmNYDQweeL4f91phl4BFgEH/jyy4QG7qAXumVaZa
         U+KvSv3TPiOi27uMCEuXJFVOLYMWzzg56+kndpWOw1DT9oKFVh4p6Z4u8qUUHQRKVHeP
         nc9f7hPdsVnMqDaME85OLQRGqaoqjmiAfv08GX8x+muFWOxo3qNxgwv5YyhXuBceYIyF
         dJN+Ixl9wkH1KueR1fQWu0vJ5dJPgSvobgSifW/YaEouS3qn6X5RJ77ci5wnrVOUEVrW
         iUux7+lNC1zq8s01yiLUhlHoQNY+qY6280PpvYMIlEPQdalCN71gUbCclyCS407bVzqA
         +BGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j+GDuvS6UdHWoKJEjzslmQxxd1iCxz+2Q3jbwUSEC60=;
        b=mcU70g8xUtABnJwJDscrnEgIwyCKAz/7JtA337rFMLHlVtb9pJr56HxzzOJwmTYsUc
         oCREbOXtzArwCmX5gXVC2yp/hiYGYrmXjtEG0qkQyRp/AHRrhBvJKY5tQendUUlpXc4P
         /XN77SKy76v/gWbqWRJNk4cbzh4A9kCJQtDQCWHLmaXSWC+y+wjMLIePajPkNgZeH79z
         HvcJSIWn4hrXGfbyZu1hDMSbYx3yIXdKN4wXcw4cqLUBFzw021ZRsd3BDLdYuMR+kWgO
         tuwX5Y5VZCFC0Nm9/U4AA7FXb1jsSimTkmYP+IyEJ/L9XoyVnAt+PsJG2W6YFYum+xDo
         W6tA==
X-Gm-Message-State: AJcUukeorajtEsHAiGiQHewu9ciucsarDkPoc14mrfS7bA4vmC6OY1WK
        b+TjcZmHu/EaXQkoFv9nd5SErcwB
X-Google-Smtp-Source: ALg8bN6YGxf9krQJpgMTifzmztwfljexOWPdp6vO2dy0W7QKor2c0ZQ4f6lhBpRbFnsgkEaVIvpjXQ==
X-Received: by 2002:a5d:444a:: with SMTP id x10mr25889825wrr.162.1548017272132;
        Sun, 20 Jan 2019 12:47:52 -0800 (PST)
Received: from t500.lan (13.162.125.91.dyn.plus.net. [91.125.162.13])
        by smtp.gmail.com with ESMTPSA id f137sm42236305wmg.29.2019.01.20.12.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Jan 2019 12:47:51 -0800 (PST)
From:   Sven van Haastregt <svenvh@gmail.com>
To:     git@vger.kernel.org
Cc:     Sven van Haastregt <svenvh@gmail.com>
Subject: [PATCH] git-submodule.sh: shorten submodule SHA-1s using rev-parse
Date:   Sun, 20 Jan 2019 20:46:53 +0000
Message-Id: <20190120204653.3224-1-svenvh@gmail.com>
X-Mailer: git-send-email 2.12.2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Until now, `git submodule summary` was always emitting 7-character
SHA-1s that have a higher chance of being ambiguous for larger
repositories.  Use `git rev-parse --short` instead, which will
determine suitable short SHA-1 lengths.

Signed-off-by: Sven van Haastregt <svenvh@gmail.com>
---
 git-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5e608f8bad..a422b0728d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -850,8 +850,8 @@ cmd_summary() {
 			;;
 		esac
 
-		sha1_abbr_src=$(echo $sha1_src | cut -c1-7)
-		sha1_abbr_dst=$(echo $sha1_dst | cut -c1-7)
+		sha1_abbr_src=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src)
+		sha1_abbr_dst=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_dst)
 		if test $status = T
 		then
 			blob="$(gettext "blob")"
-- 
2.20.1.dirty

