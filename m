Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA96E1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 18:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeHOVjh (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 17:39:37 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54185 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeHOVjg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 17:39:36 -0400
Received: by mail-it0-f68.google.com with SMTP id 72-v6so3017903itw.3
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XukeHWAjI/a3FBYrK9YLmuJXfgLyq910NFDqc9fodV8=;
        b=nxHQ8s7kbj8dhXgUOxTCas686sNTfYa+UyNkHCeCPtA0M+Yb4+VSEmGw/fLMFoNJtn
         KcQe4pwVTZNqFvlsthkNVLaDezpl0Qb4uWy2z6noGmJbQSZICMte6o0SVyvcbwVsmXkt
         mZwgM+6qa1UOoGgY5rwwQdfPQuw8kG4X7HxRYk8HPiI8I+xSRiar1O8wF2vLUZoRCyvr
         5hHreadooBwvaFqH64F6thwTHj35Uqnx8EJV/bS0LIh5fyf0Yo3wfVpJG9bR9Zl8+QJP
         xjJyXiJLvqVenfs2+u7RBHbdi7JyrP+NLQQ4oq0cGAwO/IuAYzhb917LegalxfZtjZQY
         oWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XukeHWAjI/a3FBYrK9YLmuJXfgLyq910NFDqc9fodV8=;
        b=qBZA1E7V349wn68/gbFLVNGwRmdwP5yisx/ZUrBxTl6ofWUv4lMaCoYZh9OvZrhemo
         Bf1CyMW4WvG7DQ06lYnb50uTNiP9myiJZhtc9fHBaD6FFPyasvXlZqdXXX3rnzKlgJy8
         f95NZvj7JeU4AbTtiCddH94IfzDMBhfC//HsJiUs7vZSkMS8hnzybLoBoG+Ad09qrWGf
         6oI26QXkByOY869VhA67oRV94Xgh1MrHJpqSkPkbJu+dAGD/5psSAeaCvJuhQaUvSmJN
         TAMRd91Gv1B4Jj8zOKn1yEH2Adg0sfEWkRQVQ7XRuElkztuzywu2asHQmml9K3fvFbJB
         IwlQ==
X-Gm-Message-State: AOUpUlGy1A8D3CfGNFhEW3RlZFrDWMST6dUXnDbYkDsgPlXGfFevfKAd
        xvIpwL0G0sO4mo+MyjVj1F5sVOo7
X-Google-Smtp-Source: AA+uWPw2ZtRbxW4I61p0Ra/4jiIcrIBstF97VZljIy1jekz7/LG6gafoQUDQhEU0BxbQBdv1AKWdlA==
X-Received: by 2002:a02:b522:: with SMTP id l31-v6mr24393662jaj.104.1534358777136;
        Wed, 15 Aug 2018 11:46:17 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r14-v6sm6533993ioj.86.2018.08.15.11.46.16
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Aug 2018 11:46:16 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 3/6] chainlint: recognize multi-line $(...) when command cuddled with "$("
Date:   Wed, 15 Aug 2018 14:45:49 -0400
Message-Id: <20180815184552.8418-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.758.g1932418f46
In-Reply-To: <20180815184552.8418-1-sunshine@sunshineco.com>
References: <20180813084739.16134-1-sunshine@sunshineco.com>
 <20180815184552.8418-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For multi-line $(...) expressions nested within subshells, chainlint.sed
only recognizes:

    x=$(
        echo foo &&
        ...

but it is not unlikely that test authors may also cuddle the command
with the opening "$(", so support that style, as well:

    x=$(echo foo &&
        ...

The closing ")" is already correctly recognized when cuddled or not.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                                       |  2 +-
 .../multi-line-nested-command-substitution.expect     | 11 ++++++++++-
 .../multi-line-nested-command-substitution.test       | 11 ++++++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 07c624fe09..a21c4b4d71 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -216,7 +216,7 @@ s/.*\n//
 # "$(...)" -- command substitution; not closing ")"
 /\$([^)][^)]*)[^)]*$/bcheckchain
 # multi-line "$(...\n...)" -- command substitution; treat as nested subshell
-/\$([ 	]*$/bnest
+/\$([^)]*$/bnest
 # "=(...)" -- Bash array assignment; not closing ")"
 /=(/bcheckchain
 # closing "...) &&"
diff --git a/t/chainlint/multi-line-nested-command-substitution.expect b/t/chainlint/multi-line-nested-command-substitution.expect
index 19c023b1c8..59b6c8b850 100644
--- a/t/chainlint/multi-line-nested-command-substitution.expect
+++ b/t/chainlint/multi-line-nested-command-substitution.expect
@@ -6,4 +6,13 @@
 >>	) &&
 	echo ok
 >) |
-sort
+sort &&
+(
+	bar &&
+	x=$(echo bar |
+		cat
+>>	) &&
+	y=$(echo baz |
+>>		fip) &&
+	echo fail
+>)
diff --git a/t/chainlint/multi-line-nested-command-substitution.test b/t/chainlint/multi-line-nested-command-substitution.test
index ca0620ab6b..300058341b 100644
--- a/t/chainlint/multi-line-nested-command-substitution.test
+++ b/t/chainlint/multi-line-nested-command-substitution.test
@@ -6,4 +6,13 @@
 	) &&
 	echo ok
 ) |
-sort
+sort &&
+(
+	bar &&
+	x=$(echo bar |
+		cat
+	) &&
+	y=$(echo baz |
+		fip) &&
+	echo fail
+)
-- 
2.18.0.267.gbc8be36ecb

