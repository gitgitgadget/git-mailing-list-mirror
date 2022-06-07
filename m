Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5C5C43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 07:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbiFGHy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 03:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiFGHyy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 03:54:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5803C9668
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 00:54:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id s12so26270305ejx.3
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwZ73naHa2REJEk8XUrnI1eLcQ/84xeotLyjVOFp5FY=;
        b=hCxVft2vF5jBKz95sMLRc6TZcP08LTthzaXQ/MQ+ZuNx+TV884ULKKOtbn9ge4jz+y
         T4kx+TOryCoLlktprB+P9MC2KiS84D1BAzF470gzF337SeeJ5RzAYH0QNVmk6UXGZL77
         8lMnIjjcdqKVCb/MMZFqG69hi0ll1gb9ta2STbqcuSOF/aLulpN44Eul0bO1mAvcExkq
         5hZ2ZKgOGuvR6cCc/GDmVOpW8wz/DATdl8wYagsuxD1p9aksbPgzFieTjnnB+RHA5JNR
         0A6WOGmG9um8TX1nFP/JiGULXV3/4cMzz9XgxnWCNq03QUTVFo0J6YjewMDhnSxJiPhQ
         380w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwZ73naHa2REJEk8XUrnI1eLcQ/84xeotLyjVOFp5FY=;
        b=D6dOZ4zyi0ZwGl6PntmYPE/ierR8t7Gv2cwDw4Zh/wWZPLEvK7GdSiaTLxb+xLkK0f
         emVLgJDwwJbYegBcI4ZKtdARxovCuagrK+oTk3Y1RpfBJQTjlo+fi+pkSvrgybXMVxUp
         2pnaKETNYys46U/Ejf5togbu8IWXmCNLW5cWM6vcdKrEtWZh3sJkBos32Gvd4Fx8vgoD
         iy0Ldxk5FDHzIErQxUzlmGYJYNASKuhOPwKXPdyOaZDiLhGJ7fgj4ZSuwaWZFh/S9CDs
         3dndi4b+y2RxtiZghF/82S4JYQ8SdvrFVEpH0yGmotQKRnVeqw8GuCgQTSxs8UbR2iJD
         N2Jg==
X-Gm-Message-State: AOAM533yKeYrZl7T6lHvHktRzefrxvmUbnxAIe19TmgblETC/I6HpRnJ
        Xae9Tmoy4RYelhMyszScTBNZwUwLxkA=
X-Google-Smtp-Source: ABdhPJy4X8FHEdZbY04MWZhjqvck7Sa/NtxIrGagD7E9JC6nTUbvB31WE+bmY3scVxdfsVL9HWSyng==
X-Received: by 2002:a17:907:94c3:b0:711:8b08:e7e with SMTP id dn3-20020a17090794c300b007118b080e7emr12128763ejc.451.1654588491958;
        Tue, 07 Jun 2022 00:54:51 -0700 (PDT)
Received: from localhost.localdomain (12-96-132-5.ftth.glasoperator.nl. [5.132.96.12])
        by smtp.gmail.com with ESMTPSA id wj17-20020a170907051100b006fed9a0eb17sm7207646ejb.187.2022.06.07.00.54.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jun 2022 00:54:51 -0700 (PDT)
From:   Son Luong Ngoc <sluongng@gmail.com>
To:     git@vger.kernel.org
Cc:     Son Luong Ngoc <sluongng@gmail.com>
Subject: [PATCH] fsmonitor: query watchman with right valid json
Date:   Tue,  7 Jun 2022 09:54:25 +0200
Message-Id: <20220607075425.39510-1-sluongng@gmail.com>
X-Mailer: git-send-email 2.36.1.231.g6924ef9a07
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In rare circumstances where the current git index does not carry the
last_update_token, the fsmonitor v2 hook will be invoked with an
empty string which would caused the final rendered json to be invalid.

  ["query", "/path/to/my/git/repository/", {
          "since": ,
          "fields": ["name"],
          "expression": ["not", ["dirname", ".git"]]
  }]

Which will left user with the following error message

  > git status
  failed to parse command from stdin: line 2, column 13, position 67: unexpected token near ','
  Watchman: command returned no output.
  Falling back to scanning...

Hide the "since" field in json query when "last_update_token" is empty.

Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
---
 templates/hooks--fsmonitor-watchman.sample | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
index 14ed0aa42d..b4ee86dfc4 100755
--- a/templates/hooks--fsmonitor-watchman.sample
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -79,6 +79,12 @@ sub watchman_query {
 	or die "open2() failed: $!\n" .
 	"Falling back to scanning...\n";
 
+	my $query = <<"	END";
+		["query", "$git_work_tree", {
+			"fields": ["name"],
+			"expression": ["not", ["dirname", ".git"]]
+		}]
+	END
 	# In the query expression below we're asking for names of files that
 	# changed since $last_update_token but not from the .git folder.
 	#
@@ -87,15 +93,14 @@ sub watchman_query {
 	# output to file names only. Then we're using the "expression" term to
 	# further constrain the results.
 	if (substr($last_update_token, 0, 1) eq "c") {
-		$last_update_token = "\"$last_update_token\"";
+		$query = <<"		END";
+			["query", "$git_work_tree", {
+				"since": "$last_update_token",
+				"fields": ["name"],
+				"expression": ["not", ["dirname", ".git"]]
+			}]
+		END
 	}
-	my $query = <<"	END";
-		["query", "$git_work_tree", {
-			"since": $last_update_token,
-			"fields": ["name"],
-			"expression": ["not", ["dirname", ".git"]]
-		}]
-	END
 
 	# Uncomment for debugging the watchman query
 	# open (my $fh, ">", ".git/watchman-query.json");
-- 
2.36.1.231.g6924ef9a07

