Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED0C1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 20:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753700AbeDVUrp (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 16:47:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40581 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753693AbeDVUrm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 16:47:42 -0400
Received: by mail-pf0-f195.google.com with SMTP id a26so2446372pfi.7
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y5sGpXFe7gC+wDxoTkkbKnDPrkVOfFJT7S5xCazQmiY=;
        b=Ukv2usDfF8PMOguXZt6mayybA8whzyFuhKIg9FVSpbTwfZ6pRI3BLDfI5YFC0s2z3S
         MXuj4lepoRrXz9jRM9c0AB0hPu4tFeieEbVIICkJzkR82A77bOwrsLBtprxRi6mUnkDf
         NMGLmt6p2UFLz1midfk7d5othI+aeyOrmqdhL+9oeFkRVzi3NzOwz8q0+gW/nxh6Sm2q
         +/Y8ZLBeaRGPtiIIGgtndWd7/ZCvwa9uWHN59U/DfdYy/v0FjIsJtN1s3ekzMusI8F7M
         mgaY0M1pq64wBipvQ7e7pUai0BDX50+xfXzgWOqHfyJD6d3fPeB0pCsXwz0Lq1hvOyds
         MwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y5sGpXFe7gC+wDxoTkkbKnDPrkVOfFJT7S5xCazQmiY=;
        b=bWNpFZE136sjiQwZCFMhtMNazQZLWaiXyA2y+O2k4a//V9iStR2W44P4YfuJGF7MSY
         FBeGCdrd8T9dV3Sfycvzvy3nqHT3031uAQp8c7rgPOdJ0zFgFuD2igaJj2llAT0lL5hz
         befUmZbUoGSSERGSSvu3h5bZgC5wCVKE0DLm/8nx8RUNlDTHEvY93gnOJR84Pde1b0pf
         Gp3iegTR5n/cDSMnjoy2NXfIPorUVqx+UmyGb/IMNr51q1al7Bxq5ODAn559KQsHGZDz
         BByve6qTowHDC+AWgmQ5S0FsxVAMUb5sN8jV5iHE/nVAARi/D1HliP+CT//bgEhpO6WD
         G8tw==
X-Gm-Message-State: ALQs6tDrVAdIqveTw+j8aTvwuPdz8Q/5QqfHglhVL0Ge/KmgduXlj9WO
        bG16NAzo/xhreUWDfaETgcAQsxXMgVM=
X-Google-Smtp-Source: AIpwx4+hUiXwVLnIbepUBygcG3iDVefK7wGJuLlfRDGoKUS7KrYdOiBvWQ7pVN7wUcx2ZNALiOAtYQ==
X-Received: by 10.99.5.195 with SMTP id 186mr14778439pgf.218.1524430061146;
        Sun, 22 Apr 2018 13:47:41 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id y20sm17799975pfe.20.2018.04.22.13.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 13:47:39 -0700 (PDT)
Date:   Sun, 22 Apr 2018 13:47:38 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net
Subject: [PATCH v2 6/6] contrib/git-jump/git-jump: use column number when
 grep-ing
Message-ID: <b9d2578d8dc644e68a09445e14156d789bfe395b.1524429778.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524429778.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch adds the '--column-number' synonym '-m' to the default
grep command so that callers are brought to the correct line _and_
column of each matched location.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 contrib/git-jump/git-jump | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 80ab0590bc..2706963690 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -52,7 +52,7 @@ mode_merge() {
 # editor shows them to us in the status bar.
 mode_grep() {
 	cmd=$(git config jump.grepCmd)
-	test -n "$cmd" || cmd="git grep -n"
+	test -n "$cmd" || cmd="git grep -n -m"
 	$cmd "$@" |
 	perl -pe '
 	s/[ \t]+/ /g;
-- 
2.17.0
