Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D524C2D0C9
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656FA2465E
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFUc6sfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLMVDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:03:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38066 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfLMVDt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 16:03:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so194448wrh.5
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 13:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sLUhsNwEaKY8Jzf6tworAbZGDSwhlM9UMNu/EF3CQ7o=;
        b=PFUc6sfGcdo9exDF3XBcKEHZecyuubkuk4CiGGgi4bKvWKYzT87x4+7zctUTsDUMNl
         JfGbxo60h4iOENZHs3Lo+toivSV2Me8xz6kIReEAqXXR3q5P0pAHyoFaErj+cEUpbWHk
         8iCaWt5Iys3KqQU69mDQRlaBXiyztTs8ov4iJznAdxzXtLyWjVBygwe8udEloBLB6y+7
         MJuBPk/oH/3+mH+LzkMhf68wIdZBtwkVfj8SskL0AaTxYkgANBEOQO2JHoMosgv05zpz
         rHymmW5gv9/wCLUoUPqUJ7i3S+HdggjT8d0Nx+CknKKQv57UsCHvn4G4BpJlUf7BPE85
         StmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sLUhsNwEaKY8Jzf6tworAbZGDSwhlM9UMNu/EF3CQ7o=;
        b=OvLq+zSFsURVCqmHPECAB5gmNmhMuPGCuwmwlDE+hvqFUljMEHZZNzLKgmr0362JHT
         lncEhZXawVGcjwXUBZjCROCcJwBqEePxcnkcLDROIuGEdKqZdpIgGEmQ1UlnuRcyjA1x
         STxxqcPRv117sy4m7HyfCw0bdSPpAW6rL09zjaWbBOPpP0lu/oJOUQ5E7R7ijeXGlTBg
         4tkMLZ2HR/TBVwpgF1C/Be/IJY5j93ZAToRpM3ObyZMcerYDYFmlUC+4nYrb/f+nmsjw
         pxDjeQvqOLCM8sKY/Ob/0h8KwB2O5ivy7GV4O8A2g2pNc28zPVKOHgjeqdZV1pU8BnZD
         Q0dA==
X-Gm-Message-State: APjAAAUKZ3+QRHxkj8Y+BRxB2/U7MJq/MO3vIny4uujMQDqMFC6GuVoc
        Oo85ukHSaAp2aB7JClDa/XeuaQcO
X-Google-Smtp-Source: APXvYqwCBlAf0lC/cK3AkKUS86qkmPLUxN4bK+g1eU1e+LsJoc2yXUUnugI2Il3fuhprZ53GkC/RIw==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr14697892wrn.384.1576271027166;
        Fri, 13 Dec 2019 13:03:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm2362643wmm.15.2019.12.13.13.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 13:03:46 -0800 (PST)
Message-Id: <2d1f9a8485e744e23b1f02826877afe829a639cf.1576271025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.678.git.git.1576271025.gitgitgadget@gmail.com>
References: <pull.678.git.git.1576271025.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 21:03:45 +0000
Subject: [PATCH 1/1] t3434: mark successful test as such
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

t3434.3 was fixed by commit 917d0d6234be ("Merge branch
'js/rebase-r-safer-label'", 2019-12-05).  t3434 did not exist in
js/rebase-r-safer-label, so could not have marked the test as fixed, and
it was probably not noticed that the merge fixed this test.  Mark it as
fixed now.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3434-rebase-i18n.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
index 4b5b128cd6..c7c835cde9 100755
--- a/t/t3434-rebase-i18n.sh
+++ b/t/t3434-rebase-i18n.sh
@@ -45,7 +45,7 @@ test_expect_success 'rebase --rebase-merges update encoding eucJP to UTF-8' '
 	compare_msg eucJP.txt eucJP UTF-8
 '
 
-test_expect_failure 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP' '
+test_expect_success 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP' '
 	git switch -c merge-eucJP-ISO-2022-JP first &&
 	git config i18n.commitencoding eucJP &&
 	git merge -F "$TEST_DIRECTORY/t3434/eucJP.txt" second &&
-- 
gitgitgadget
