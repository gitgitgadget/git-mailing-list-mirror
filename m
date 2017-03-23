Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AEB420958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965128AbdCWP3z (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:29:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35208 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965078AbdCWP3q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id z133so17386993wmb.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TIuglEWGavMDg+yrcAXDFT8T9ETpaUF3TXmv4da2Ycc=;
        b=ILCJI0QXlWTrk/HJ8W6hKjadiv8NbPORsttvg9RVR73Ndg4XbGUlSKCpMy+X3r+b9C
         H3vozYR/NLCHd9Gam+iDl85VzFl9tqpT/QrgslRJcmpE0Cr7rwKZMud1wcjWH2AryARt
         HrM2jryHrs8cXBi4zgwNxbQgI73+ACK4PD+LVwZGTvp63dOod5Vn+ydJKH7x//5I8jzg
         965C400sRrM1cJeESbA195VL/uBWnroc6svnaVGAR9VaV1LF4+Ixtex+KLt4eKxiv1kx
         IEodc9yk+kTgeibTF7Inm6ZDBoFH1xmm4FY62IdajWoBri5utTv4TJD7eXN6OaCOBGUd
         bpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TIuglEWGavMDg+yrcAXDFT8T9ETpaUF3TXmv4da2Ycc=;
        b=bZgkCnSm1yuaPndo2EGgWE3yi1F5dHblZv3a+7G+GbxWTABVyTIbhNCnxOsVGTkroJ
         PpSUhL2q2B5Dj5fqNWepOCmtUrzEoabmzXx49GD69gQboBqky607/ekDU+mHBnxJ9em9
         J4NqxsiyTXk3gCMumkI+M4btX2HNoB5kvlO4d6uJyQIheEBgXtUlAjJEMSXCE89erP5a
         wrwal3f0iTUcAdGBLQp317AVbKXfysHrDgB2bF1S5Us97fYzeCkr6ENaYwnFmJ+amDFZ
         z1f9QefILMWR2UnMWUuBMS/3eEPJG5gteInyrEB6IKsoZ9wEeKmAAi0aW+C96FHknyLP
         y/6w==
X-Gm-Message-State: AFeK/H1pLKufAcUdo7YPa3IMiE6OS49Meg9DNfQC3TllABC+N9aUlzP9VRF0lYeOyac5qA==
X-Received: by 10.28.87.138 with SMTP id l132mr13996683wmb.95.1490282984735;
        Thu, 23 Mar 2017 08:29:44 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id q135sm455057wmd.8.2017.03.23.08.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:29:44 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 10/14] completion: let 'for-each-ref' filter remote branches for 'checkout' DWIMery
Date:   Thu, 23 Mar 2017 16:29:20 +0100
Message-Id: <20170323152924.23944-11-szeder.dev@gmail.com>
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

The code listing unique remote branches for 'git checkout's tracking
DWIMery outputs only remote branches that match the current word to be
completed, but the filtering is done in a shell loop iterating over
all remote refs.

Let 'git for-each-ref' do the filtering, as it can do so much more
efficiently and we can remove that shell loop entirely.

This speeds up refs completion for 'git checkout' considerably when
there are a lot of non-matching remote refs to be filtered out.
Uniquely completing a branch in a repository with 100k remote
branches, all packed, best of five:

  On Linux, before:

    $ time __git_complete_refs --cur=maste --track

    real    0m1.993s
    user    0m1.740s
    sys     0m0.304s

  After:

    real    0m0.266s
    user    0m0.248s
    sys     0m0.012s

  On Windows, before:

    real    0m6.187s
    user    0m3.358s
    sys     0m2.121s

  After:

    real    0m0.750s
    user    0m0.015s
    sys     0m0.090s

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 206eaf0ca..394dcece6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -422,15 +422,9 @@ __git_refs ()
 			# employ the heuristic used by git checkout
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
-			local ref entry
-			__git for-each-ref --shell --format="ref=%(refname:strip=3)" \
-				"refs/remotes/" | \
-			while read -r entry; do
-				eval "$entry"
-				if [[ "$ref" == "$match"* ]]; then
-					echo "$ref"
-				fi
-			done | sort | uniq -u
+			__git for-each-ref --format="%(refname:strip=3)" \
+				"refs/remotes/*/$match*" "refs/remotes/*/$match*/**" | \
+			sort | uniq -u
 		fi
 		return
 	fi
-- 
2.12.1.485.g1616aa492

