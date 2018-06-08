Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152311F403
	for <e@80x24.org>; Fri,  8 Jun 2018 20:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbeFHUdE (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 16:33:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40831 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbeFHUdC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 16:33:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id n5-v6so5810018wmc.5
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 13:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ime4zh3EZC0opadWNOlYWYGDGJNHSGX7g0CC79tnxT4=;
        b=CpmUQsKJUd/Sv60TCLzX8zbuzmHu8qsbHBkXk3mRPJXa5H28DTWsCkBbrsiC9GzRJO
         fLIVv+S5m/ZjsUPUHg5QAnf/0S4gXmKppNUKbVC3TMZ3E4rU1B/YVJXvtl3mtd4zLXhD
         n6IPoVJ7pSchcliSf/SNz1vJo5jeGlkg6AtwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ime4zh3EZC0opadWNOlYWYGDGJNHSGX7g0CC79tnxT4=;
        b=YPjR8ZJApjWUbmKhIjfP40CC9+WXCd+/ZpuCobiMMlnQsXP2KP0mRxF4iGNhVKSlLx
         IdGm5lLUXCceqRWUllrW49WY/b2Sh9sg3VzxI3MszEMdbg2fJToKBwNx/KWG4ofzI/xZ
         zhvUiXl8s4OQfRSOChXDBftFgLNkUUp7k/P6JhHXv8c6uzedYDyAb+AEmwtoS6I+MXM0
         WaOluoPdQv/SRo8v8JK4jyLu4wdvl7/qQHBpSe1KM6YIQr7dyuV2HfZ51F+nK86sJV88
         VX4HzhOMnuyl6hBntu2/CY+sZyd59wsibY/1AcaK+HTl4hmgCV/UTP7c9uM2MwXLesMi
         HJfw==
X-Gm-Message-State: APt69E0IhCboyq0XbQgh/imCQssmoTy++iekel+hqf5MvEvwnNo5U4Qw
        0PEt7PuLU9YzW2G0m7WKOoz1Jeog
X-Google-Smtp-Source: ADUXVKIjhRUKvQnwLNHrF+bDfMwAaXUeWGT9lkEBAZDRS+8lWsKybYJ8jOfD3LxVy5C6ggMP0m2UNw==
X-Received: by 2002:a1c:8312:: with SMTP id f18-v6mr2614356wmd.127.1528489981111;
        Fri, 08 Jun 2018 13:33:01 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id k82-v6sm240001wmg.10.2018.06.08.13.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 13:33:00 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Eric Scouten <eric@scouten.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>, viniciusalexandre@gmail.com,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 5/6] git-p4: narrow the scope of exceptions caught when parsing an int
Date:   Fri,  8 Jun 2018 21:32:47 +0100
Message-Id: <20180608203248.16311-6-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
In-Reply-To: <20180608203248.16311-5-luke@diamand.org>
References: <20180608203248.16311-1-luke@diamand.org>
 <20180608203248.16311-2-luke@diamand.org>
 <20180608203248.16311-3-luke@diamand.org>
 <20180608203248.16311-4-luke@diamand.org>
 <20180608203248.16311-5-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current code traps all exceptions around some code which parses an
integer, and then talks to Perforce.

That can result in errors from Perforce being ignored. Change the code
to only catch the integer conversion exceptions.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index f4b5deeb83..5f59feb5bb 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -959,7 +959,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
         try:
             (changeStart, changeEnd) = p4ParseNumericChangeRange(parts)
             block_size = chooseBlockSize(requestedBlockSize)
-        except:
+        except ValueError:
             changeStart = parts[0][1:]
             changeEnd = parts[1]
             if requestedBlockSize:
-- 
2.17.0.392.gdeb1a6e9b7

