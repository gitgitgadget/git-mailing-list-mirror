Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B12FC433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 447DB20890
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9812GQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgFRUuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbgFRUuD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 16:50:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7B7C0613EE
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 13:50:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q11so7542934wrp.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Afy3BAHE/qGBeTKBC6xu6rAROAktgU6zmq0JPztX8Uk=;
        b=A9812GQKkLyanFZm4e3Nx0HFQCt9FTGaZ5/JDvJQ0e1Q9H3FsQchu1sXNxeylkpMct
         z2/pnsyNcSHd7da8fbTtgFhSNgnYgeNV9KrbwidR7GJxpVSNwW7HzNKKtol+1OACPpJZ
         FZnpI6f5LhOboMnDiMV5A87PJsxCkyHdtkzmAWkut5aKi7etNMyzXo1qKtlhEuj2QjZC
         JvhxSrkuG0xhQlxuU7f80jjGZQjLtsMlY1OmOibGNIxNyPClW/VdMzpX4Bv+2/B+jpBn
         ufCjuLFR7mkbLhJuqk7ZIha54IRyQmT+NSfQVJg75mzLiPdy2mSaqHVWXxfKIYubTsvP
         swAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Afy3BAHE/qGBeTKBC6xu6rAROAktgU6zmq0JPztX8Uk=;
        b=gILcMtUWuZWlzmE64yRrZBksPiUrnbFSJThHLcHLbDntFabyFBTjwR+Y4oWttrMVdH
         F9A6tk7cSBgNYAvrJLzUmXkyN497Jv928wx9AL4MBHoZCDSMSizZd/M8yzHbs1YzkLui
         XI9vnnnWXlJHPmxtPFG0+ZDbrWwi0z5omjfPxFma8Lvyqjz3tJsvBbpKMn8Bq7+821i2
         8tRMLqcIntWIcmLjZX0MZxfFs7o340X2wWirEubC28VdWW0WZfrONfIdhJjLiSytR9Mh
         LAoHSilMjXpSSHk6TXIvHpAgX1vrB089r5AyJrsdphMONpCOooWpo2qWB9iHhlQlqmaY
         RtDA==
X-Gm-Message-State: AOAM533vY3/gaYlUXgBJds1G3FyucoNKT5XUAEm1PokU9/zkIG/6JiUj
        4IDVmwULO1Ak3IbrG2LnWr7Sp5ws
X-Google-Smtp-Source: ABdhPJyS0FZd8MJuRh8tLuVhmthexsKbCa6HVF3l8I7kxq86NFmL61EXpYuiUjR9/GHnNYQ1GW2Log==
X-Received: by 2002:adf:dc42:: with SMTP id m2mr368376wrj.342.1592513401901;
        Thu, 18 Jun 2020 13:50:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2sm2861652wrt.76.2020.06.18.13.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:50:01 -0700 (PDT)
Message-Id: <17254b30a5bcbbe3e14dd47272dfcb4c867030dd.1592513398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com>
References: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
        <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Jun 2020 20:49:58 +0000
Subject: [PATCH v2 2/2] git-prompt: include sparsity state as well
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The current git prompt includes a lot of possible state information from
cherry-picks, merges, bisects, and various flavors of rebases.  Add
sparsity as another state flavor (though one which can be present
simultaneously with any of rebase/cherry-pick/merge/bisect).  This extra
state is shown with an extra
    |SPARSE
substring before the other states, providing a prompt that looks like:
    (branchname|SPARSE|REBASE 6/10)

The reason for showing the "|SPARSE" substring before other states is to
emphasize those other states.  Sparsity is probably not going to change
much within a repository, while temporary operations will.  So we want
the state changes related to temporary operations to be listed last, to
make them appear closer to where the user types and make them more
likely to be noticed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-prompt.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 014cd7c3cfc..3e7344a4014 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -421,6 +421,11 @@ __git_ps1 ()
 		return $exit
 	fi
 
+	local sparse=""
+	if [ "$(git config --bool core.sparseCheckout)" == "true" ]; then
+	    sparse="|SPARSE"
+	fi
+
 	local r=""
 	local b=""
 	local step=""
@@ -543,7 +548,7 @@ __git_ps1 ()
 	fi
 
 	local f="$w$i$s$u"
-	local gitstring="$c$b${f:+$z$f}$r$p"
+	local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
 
 	if [ $pcmode = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
-- 
gitgitgadget
