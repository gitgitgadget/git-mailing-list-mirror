Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 624A120958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965029AbdCWPai (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:30:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33286 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965100AbdCWP3w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:52 -0400
Received: by mail-wr0-f195.google.com with SMTP id 20so3656021wrx.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oS+QlqD6wfQJsk0iFOe8bMH9oKE+AW9OjAd5/qq8YJM=;
        b=PQSuh9jYAP34Cat6HRZ3fdHLKE/y6UdsJDgTSTWCz2GlPeSwZeTdsSM/eLe3BLVZfc
         L4eNncldrrm5ik213aRga4KsZEsp+UHahdhBQBuooqLytaRFcIDwfJphIJulsbwqs/DL
         w8UvjjlrDlUohoI/VbQxlf6ydj1JZ6vAQQWbnM+MoxH6I8Pux40IcY49bP3NQOOmv3MZ
         cS9AFfTRoZW0BowP5CWE4lbTBR7GENaIQTi+7OaYXYzXwQQdfGHJtSgxxEyZ46cpfBeV
         uG+d+87w5FLcYB98Czik9ZOewn3enwgjOEd7+UHy9iU/xiDybRcHKA4xlTlv3lp0EA8O
         px4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oS+QlqD6wfQJsk0iFOe8bMH9oKE+AW9OjAd5/qq8YJM=;
        b=aVAUO5ysx6fwbs2blXlAV6hqQlG3ieehgqJTTduo5F0jatwe5XzuhqQMaKphE5VAYh
         72N8JIy1XaMIG5zmey6MhJD83rL+Wlc2HdYo/YetUpwcg0PGJPX+HCleDjqKGPWEIu6h
         8KMvMJt/P38wzD1zs8rAUD1khqz5X2r/yyUnLp0qMMPk3ftZwhbpH9H0VWPxBY1DptJL
         dJiEAXwmHwlLUDYGw3o4MIEMOJuwfSF45SYDBE1wxuBq+oNnwFl4THm4B0H2FfD/FHjk
         kO+Grv/h6gI3wSBD8VZKYCDdD3tvqpLgKTP0tyrKGJK2/PTPTAgy2ef1N7RaJe6j3Pqg
         ELeA==
X-Gm-Message-State: AFeK/H2lW4nz8VCpy/zB1Bk+A89b5eqxOdsBo9AWEboUFfJ4nLESPMPn5ATDxmZB1iKDkQ==
X-Received: by 10.223.136.24 with SMTP id d24mr3206347wrd.160.1490282985571;
        Thu, 23 Mar 2017 08:29:45 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id q135sm455057wmd.8.2017.03.23.08.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:29:45 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 11/14] completion: let 'for-each-ref' sort remote branches for 'checkout' DWIMery
Date:   Thu, 23 Mar 2017 16:29:21 +0100
Message-Id: <20170323152924.23944-12-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
In-Reply-To: <20170323152924.23944-1-szeder.dev@gmail.com>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When listing unique remote branches for 'git checkout's tracking
DWIMery, __git_refs() runs the classic '... |sort |uniq -u' pattern to
filter out duplicate remote branches.

Let 'git for-each-ref' do the sorting, sparing the overhead of
fork()+exec()ing 'sort' and a stage in the pipeline where potentially
relatively large amount of data can be passed between two subsequent
pipeline stages.

This speeds up refs completion for 'git checkout' a bit when a lot of
remote branches match the current word to be completed.  Listing a
single local and 100k remote branches, all packed, best of five:

  On Linux, before:

    $ time __git_complete_refs --track

    real    0m1.856s
    user    0m1.816s
    sys     0m0.060s

  After:

    real    0m1.550s
    user    0m1.512s
    sys     0m0.060s

  On Windows, before:

    real    0m3.128s
    user    0m2.155s
    sys     0m0.183s

  After:

    real    0m2.781s
    user    0m1.826s
    sys     0m0.136s

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 394dcece6..d26312899 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -423,8 +423,9 @@ __git_refs ()
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
 			__git for-each-ref --format="%(refname:strip=3)" \
+				--sort="refname:strip=3" \
 				"refs/remotes/*/$match*" "refs/remotes/*/$match*/**" | \
-			sort | uniq -u
+			uniq -u
 		fi
 		return
 	fi
-- 
2.12.1.485.g1616aa492

