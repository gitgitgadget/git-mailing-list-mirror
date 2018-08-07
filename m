Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7E22208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 08:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbeHGKfQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 06:35:16 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:32809 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732249AbeHGKfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 06:35:16 -0400
Received: by mail-io0-f193.google.com with SMTP id z20-v6so13347068iol.0
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 01:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=os8colO/belCNuVU5L/u4kraFh+oWdTudetxxMmJq2k=;
        b=ngIj9vkaCpeA/oAHChwZzaYWFAdWIJS/BNze7esrv0WGjewVAsCleuJgSSZlLiBNtp
         WF1ElJZXiIP0dyOeGGzAyJ2zvcaGsHiJIYeyvg7D20TrcV0+ehjp/gJ2K5FEAfCesW1G
         ws7eU16AzWDqJRYnBSBHosP/KzhmuKdTbKjtPX1R8UGkxhhDNPUnj6FjWpFezT5Vo43E
         sA5EGxrtZz+yXvoM9rQfStg6UGSxrkgRDauuSUib1VM0qYN7aJPcvXFHGv+UHMjHxBvZ
         SRCTJD16eOCsDpckoX+5bJdw+i/Y6IiBgXssZwt1zZ7DMTlJh43zPCBd/jMIjPPTFMKu
         XnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=os8colO/belCNuVU5L/u4kraFh+oWdTudetxxMmJq2k=;
        b=YiYewTAquZtNKlCMgsnBcHbjRTcXtAOAHJs3Gi6faf0xxlCGYb1EBeZ+3uQhuHsXB1
         FtLdBMUPuc8Cg8vVpbfQ2sxrUQ/2V/7UD7s2c6cDOhKCVF0TOeGNcr+92XuxRukEPwkw
         yqwsd0Ea1sZqjX6CJigKKAfn7ZYELpt99jMO7tFTskO7GafDSx8YmNrVW7XE08IvZBs8
         mebZnvwLW4vVDiqiYe83z6NBk27zBXoXJHS8zd8Lr53xp71Pkgaes2wV7o+odsswJ4FS
         xp2p/F7vRh4yRKUe6baTnagELFzN9WhQBafYnwU2JH0mcj4gV2g+aBo0UA6SR90uVxGP
         XUCA==
X-Gm-Message-State: AOUpUlFavbkB2Z/ELBdZcvZbGTerC7XTRBJZbdWadrMko997L9PPXiVo
        lbyZMyPA81/CPJfwexlY0fH9ufwL
X-Google-Smtp-Source: AAOMgpffHBRXrNLLiH7dpxy+V7AP5WV1IsO4cqaGLFbxFJ7NLrYVm6gFspN1YG6CnqiWG+J5jWIiXA==
X-Received: by 2002:a6b:b845:: with SMTP id i66-v6mr16880409iof.142.1533630122752;
        Tue, 07 Aug 2018 01:22:02 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id e19-v6sm210792ioc.46.2018.08.07.01.22.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 01:22:02 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/5] chainlint: recognize multi-line $(...) when command cuddled with "$("
Date:   Tue,  7 Aug 2018 04:21:32 -0400
Message-Id: <20180807082135.60913-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.758.g1932418f46
In-Reply-To: <20180807082135.60913-1-sunshine@sunshineco.com>
References: <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180807082135.60913-1-sunshine@sunshineco.com>
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
index bd76c5d181..a0726d3e7d 100644
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
2.18.0.758.g1932418f46

