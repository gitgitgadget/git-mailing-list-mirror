Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287A6C433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 11:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbiFGLOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 07:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiFGLOf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 07:14:35 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73DC32C
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 04:14:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fd25so22543870edb.3
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 04:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/SWfGyB+HJh1APG45/OXssNif84B+4xkcKoHqhhoKg=;
        b=exII/iof5faxGrxGs2eH6+J6knO6jyMiy6bZ114o/YFTGIk3v/h2GITehAxKwN9184
         JLRwWybODurfVx8ML0564u8XWpKuY/FQFtMHpDD7ASh9/c8MDM4QUqPCO6rJJswZ28eX
         44aWltYLG8QUfguWHo/v75GQFfc640jF0bVpt96DUNoxhA400QoP92hUaIPMEggvhMYx
         ZQKRR7hkG2Ply5hzl4F/OOTXIbG1CBWPUcbKeqEJt4bqnf224hFvIks9QPbcwog9/byp
         PbW1k6UgDA3ByA2hNnx27qsmkBEnkD02crE4wXVb/GuI6Zc2OKYk90dF0BR3nr81jsCJ
         EnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/SWfGyB+HJh1APG45/OXssNif84B+4xkcKoHqhhoKg=;
        b=pSleR/V0Bts4g1Q6eyq81f7Tr+CU2ZfIIXY7U2a7heqOnvqOoSvUnAdomi2wD54aaa
         Uk5rRqdPykGHEnIVJ+S5cgqvwxmLNgb3MYKTMdN9ksXYP/9AdiFokNLR8iuogsKiGQue
         bZ+bEUSZ48K+VN7F0hb1ACxM7tOn0aUB73kOFgLdEa9aFMORrPkvP3pZnkMPz2ZLRPpt
         BK0HJ/fN894geOV69sW3jcglpyczXZqtRYtWqGg6hnC20pBcpDVoSyn7YwewebltXqt8
         D5e9meJLwrWXnwgXZ5kVbDIdJmzWGFqfmtFshAERAC2I6xAGf98Xf6qKjXMc3nix8zCT
         fBNw==
X-Gm-Message-State: AOAM53253L4yN+g4ZuqXV5dDpj1kq79OGfaVGNr0K1KRJIOq7A6KOuw8
        wOCRkQOCYOwbt51QcumiFUl9RQj6hfI=
X-Google-Smtp-Source: ABdhPJyCw/iCqgNVeeXCukp+nADbz8b+mK8KaZjz7J2ijJXc18VkLbOLHKRxBidk9BT5vTy5uCnZKQ==
X-Received: by 2002:a05:6402:2405:b0:431:6ef1:e2a with SMTP id t5-20020a056402240500b004316ef10e2amr8661574eda.26.1654600472157;
        Tue, 07 Jun 2022 04:14:32 -0700 (PDT)
Received: from localhost.localdomain (12-96-132-5.ftth.glasoperator.nl. [5.132.96.12])
        by smtp.gmail.com with ESMTPSA id d5-20020a170906344500b006fee98045cdsm7564255ejb.10.2022.06.07.04.14.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jun 2022 04:14:31 -0700 (PDT)
From:   Son Luong Ngoc <sluongng@gmail.com>
To:     git@vger.kernel.org
Cc:     Son Luong Ngoc <sluongng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] fsmonitor: query watchman with right valid json
Date:   Tue,  7 Jun 2022 13:14:19 +0200
Message-Id: <20220607111419.15753-1-sluongng@gmail.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d
In-Reply-To: <CAL3xRKev_KHvAFuviG7RxsxA_786K4QY5F08a8D23M9MLM81+g@mail.gmail.com>
References: <CAL3xRKev_KHvAFuviG7RxsxA_786K4QY5F08a8D23M9MLM81+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Co-authored-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
---
 templates/hooks--fsmonitor-watchman.sample | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
index 14ed0aa42d..23e856f5de 100755
--- a/templates/hooks--fsmonitor-watchman.sample
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -86,12 +86,13 @@ sub watchman_query {
 	# recency index to select candidate nodes and "fields" to limit the
 	# output to file names only. Then we're using the "expression" term to
 	# further constrain the results.
+	my $last_update_line = "";
 	if (substr($last_update_token, 0, 1) eq "c") {
 		$last_update_token = "\"$last_update_token\"";
+		$last_update_line = qq[\n"since": $last_update_token,];
 	}
 	my $query = <<"	END";
-		["query", "$git_work_tree", {
-			"since": $last_update_token,
+		["query", "$git_work_tree", {$last_update_line
 			"fields": ["name"],
 			"expression": ["not", ["dirname", ".git"]]
 		}]
-- 
2.36.1.476.g0c4daa206d

