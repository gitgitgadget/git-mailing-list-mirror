Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B19B020958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965090AbdCWP3v (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:29:51 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36527 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965065AbdCWP3t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:49 -0400
Received: by mail-wr0-f194.google.com with SMTP id l37so31602958wrc.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpRVcolnbGJT5KQWu9UDCbUIoofq8Z6Km5eoM6SyicA=;
        b=UdpnidVoZ/1VdW25uI+8LRYoST6u38/rosRgqngSM/Fyx7yWr/AMK9pBdBHm7zhsdo
         Qpj/YQNowxAqaXB9eX3+Ct+RfJPEWJZ7hFVomNMIfCexB/UpDSRgLkIBhtlhyQaaxKui
         dkmhfBAK9D7wCr7FHzq0h+2W4w0Dv9ivnktMKiIJIrxCOTyXmfGvv3iOfsGyy2YGptmJ
         KuIH1xnqV0BnmvelD5boOtiQD8BLPkVTZV/5QIef2jc87aaByBVVo/e6MtZQjfm+NYvX
         IZkVoX9CmPAYeeyIDCHNLyRyFzsB/TXnRV4AK9tvvgpMImtmeUxOV4STCiTbAHvbmzE6
         CTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpRVcolnbGJT5KQWu9UDCbUIoofq8Z6Km5eoM6SyicA=;
        b=EdIJoyPhvSKoq3lslgR3PB7i97ExcyHkHEfles6xyqbwYqFp/+Aq7EdadogT3ScJlN
         wEfGj49WfnTsWorLT+LAb6186J8lpV2QH4+m2Sy8RO1InJ8dtNC6EOJ58OCnXNauONJ1
         fC3YPSy2rQbwqtUFtitOUZ/TwA1jIa72eO+nJtUZcWYijeldUxvD+aSvI/EKWFxTiCNZ
         6MQeg0aFFBRvfVKkXwVvWB4jiwJWyhZbgDn4kAPn5xp8AByGk7+81gcG0Zr+gSGRrrN3
         Tkc8EGgqxJYOXJ2Om65yrJ+kYqIRL7ZymlcbSUqKRoMVWa4pt49bFrID+fNS75N/CPwd
         Phpg==
X-Gm-Message-State: AFeK/H1rNjH5Vjnl9UZ2+6GS/s9QY/CcY3gPZtFUhfpd8S9bTrkxVVDjk63+9LujnFbsZg==
X-Received: by 10.28.155.65 with SMTP id d62mr3629675wme.7.1490282987144;
        Thu, 23 Mar 2017 08:29:47 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id q135sm455057wmd.8.2017.03.23.08.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:29:46 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 13/14] completion: fill COMPREPLY directly when completing fetch refspecs
Date:   Thu, 23 Mar 2017 16:29:23 +0100
Message-Id: <20170323152924.23944-14-szeder.dev@gmail.com>
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

The __git_complete_fetch_refspecs() has to iterate over __git_refs()'s
output anyway to turn the listed matching refs into refspecs, and it
knows about the prefix and suffix that has to be added to each
refspec.

Modify this function to add the prefix and suffix to each refspec
while iterating and feed the result, since it doesn't need further
processing, to the new __gitcomp_direct() helper added in the previous
commit, because it should be faster when there are a lot of refspecs
to list.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 41e658931..86c7d93b8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -536,11 +536,11 @@ __git_complete_fetch_refspecs ()
 {
 	local i remote="$1" pfx="${2-}" cur_="${3-$cur}" sfx="${4- }"
 
-	__gitcomp_nl "$(
+	__gitcomp_direct "$(
 		for i in $(__git_refs "$remote" "" "" "$cur_") ; do
-			echo "$i:$i"
+			echo "$pfx$i:$i$sfx"
 		done
-		)" "$pfx" "$cur_" "$sfx"
+		)"
 }
 
 # __git_refs_remotes requires 1 argument (to pass to ls-remote)
-- 
2.12.1.485.g1616aa492

