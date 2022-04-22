Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC3FC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 01:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443121AbiDVBmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 21:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443119AbiDVBmR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 21:42:17 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A114249FA6
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 18:39:25 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id d198so4880086qkc.12
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 18:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s79p6NMqGaEP3pPpBYMOESC4ce5PbPUbbCTmuMu1SEk=;
        b=V0b2IDheuXSahPoMnIXMk6aXw3Hdmya13kk7Ibyht78nf0DxsGI0xn2OnYuenfOCGw
         wO1gZGbQXIc0L+0H0T2dkLJM7oGqJCKbRKpkkdAkdgWg8IVAeYXm/BjLKzMX5YaMCUF/
         8/UA4VIoNI4cnjtCRlUm2jyXJ3hQ0H3rX8Ok2J77DqTBLib5XxI9JtRT3K2rysIEw8fr
         zptqFwBvF1heCcDLie2YKTtJX+/iQOeJTcQs5sTOM7sK++rKIgEB0WxrnGvhn7rkpC3o
         GxELY4SHhqhMeVGfKzNvdt3+rzBQHMSqCLEP1PZajZSL0mr3WkyzybzSo/FxSxpPKegW
         D6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s79p6NMqGaEP3pPpBYMOESC4ce5PbPUbbCTmuMu1SEk=;
        b=xtG2mwGjoYWpA/05Fra3be8DI6gmGRYp8ltvVEHJHQIv7R9MpsrkIEr6Qx+/UkrnhK
         cxbgX/dfN+wSa6YkygZwpD68jsNcw+tfPh830aw0yl5ykr0zUFFoggFhRHDut7Zj5D7Z
         otJ7vUnPC1xTqUjTzJ8EeuGs7H0MZ8rqz54mgUVUKVh9HOeCiVZZqCbX9bv7qyzOHybN
         RuftOsmyUQaw/FwhskLQxvKe48RALi55jokEEyPntd3va25ZnxNl1C9IbInhME7CuTtp
         22qxJ7P2yqpKWAzS6MLwgk3Om/6I3LD9IgRMZp7ePHtnp/B44AjWW9BByNrVfkHt6ISD
         e7uQ==
X-Gm-Message-State: AOAM531Pu+t2XxwkTrTZJlGRWnSJUJi9ylBzGub17PqPtTnzJjaz2c1c
        O62xwY3fMzBVRyxhAf7QkU6wSWOc4hI=
X-Google-Smtp-Source: ABdhPJzkfX1DrbYoiV41r/8OyNVXfkXSdUvRKWixNQ8AH0akMqduhmjoewY8i0Lv+hPz0mBWL0kkog==
X-Received: by 2002:a37:9dc5:0:b0:69e:ce44:d114 with SMTP id g188-20020a379dc5000000b0069ece44d114mr1349546qke.580.1650591564680;
        Thu, 21 Apr 2022 18:39:24 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id y3-20020a376403000000b0069e899ec3c7sm308026qkb.75.2022.04.21.18.39.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 18:39:24 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 1/2] ci: make failure to find perforce more user friendly
Date:   Thu, 21 Apr 2022 18:39:10 -0700
Message-Id: <20220422013911.7646-2-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <20220422013911.7646-1-carenas@gmail.com>
References: <20220421225515.6316-1-carenas@gmail.com>
 <20220422013911.7646-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for a future change that will make perforce installation
optional in macOS, make sure that the check for it is done without
triggering scary looking errors and add a user friendly message instead.

Only one invocation of type is changed as that is what is only needed
for the expected future use case, and because `type` is recommended in
the CodingGuidelines, so changing that recommendation or a more complex
change has been specifically punted.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 ci/install-dependencies.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index dbcebad2fb2..6de20108775 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -78,12 +78,14 @@ linux-gcc-default)
 	;;
 esac
 
-if type p4d >/dev/null && type p4 >/dev/null
+if command -v p4d >/dev/null && type p4 >/dev/null
 then
 	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
 	p4d -V | grep Rev.
 	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
 	p4 -V | grep Rev.
+else
+	echo "WARNING: perforce wasn't installed, see above for clues why"
 fi
 if type git-lfs >/dev/null
 then
-- 
2.36.0.266.g59f845bde02

