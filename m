Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 164F51F404
	for <e@80x24.org>; Wed, 14 Feb 2018 04:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966814AbeBNEiz (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 23:38:55 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35288 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966753AbeBNEiy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 23:38:54 -0500
Received: by mail-pl0-f65.google.com with SMTP id o11so4262061pls.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 20:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TdfiOe1QQOaQhBz7kl/WFQohhvIWBqr4rtTbS/d2Gfc=;
        b=hhN6XBy/UNc2vmfVWtEueoJxMnNODF0CTKwh48u6E31qyl4E5Od7BEqwt13maB295x
         EbwWc1wF58+Ygkz3leWW9f8NuWvmoRALCDacVh8jrTvNssSJTLvubXZ/2jYOjqA2WFne
         AmObAH7DEHbYndhRdnhSLy5TOMIkjv/D1yxDNEnkwMEKHDkJgCne7atRXiBqNIHN5WMN
         6qjAGqNUeY/Diz/d+gL3xOB+ulsjGiPEphCQTUhP8IpGr7E4CCXgr6AOdknYZdWwQBPL
         yqxijQGkL2/kfRec6KJHGwenp4qb/JSWuV0rYcGLr17vusD15eUhJc8a+h05pwHHUpKj
         PaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TdfiOe1QQOaQhBz7kl/WFQohhvIWBqr4rtTbS/d2Gfc=;
        b=diJGhMWFjAvv3yqvObvTo4g6LUL84appob9kBsFH+qpIkTrm++W7DoUv5IIR97aR7d
         qMvSrR9+Ie8OaprgEgNmEKSXrmkv7DtoSPZ0h3bKDDH+YIABhc7TdCFUZrmMiBAKtHao
         fC25fRFuVCRx71DvP4EFJy89oqZyZU/cZrubCsCgVFNKOycsGV6hBBrsXUVzA9B+t61p
         PFf74FrqM5V38+v6FLUuk/O4DVn422w6J+NCLGc2DnsxgoMZ5JM//3t+qfHkqrgaXiQs
         dOoubsxYEpq1/Nwm4OBzOKBOabX1+324PpfG637JTlFI2tp5AmrjKPy60MfP+itSP8hq
         jzIw==
X-Gm-Message-State: APf1xPBY/4CovxU8j8DSpPDlSaNmZ+864iCvdrYBZ/rjBU2CgxY+A6Mk
        LgbmqAY4f3Thy6XoUuuQA1cv9XSbQRQ=
X-Google-Smtp-Source: AH8x224sKCrWYwRlS5CFU3l2rfAVqVu8P/DUHGuYaViQUHyyU4IiBixp3rbxlrhDWtpci5UMeLi5mw==
X-Received: by 2002:a17:902:9893:: with SMTP id s19-v6mr3213070plp.101.1518583133124;
        Tue, 13 Feb 2018 20:38:53 -0800 (PST)
Received: from localhost.localdomain (122x221x184x68.ap122.ftth.ucom.ne.jp. [122.221.184.68])
        by smtp.gmail.com with ESMTPSA id n7sm28783035pgd.28.2018.02.13.20.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Feb 2018 20:38:52 -0800 (PST)
From:   Hironao OTSUBO <motemen@gmail.com>
To:     git@vger.kernel.org
Cc:     greened@obbligato.org, Hironao OTSUBO <motemen@gmail.com>
Subject: [PATCH] subtree: die if failed to find existing splits
Date:   Wed, 14 Feb 2018 13:38:21 +0900
Message-Id: <20180214043821.13900-1-motemen@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using git-subtree with --squash option, you may not have commits
indicated by git-subtree-split: at hand.

find_existing_splits dies on such situation, but the caller cmd_split
ignored it and produce unwanted output, i.e. a history that does not
contain commits from subproject. This patch fixes it.

Signed-off-by: Hironao OTSUBO <motemen@gmail.com>
---

Notes:
    I know there was a discussion [1] about moving git-subtree development to
    GitHub, but don't know where the actual repository is, so I am sending this
    patch to the mailing list.
    
    [1]: https://public-inbox.org/git/87mv7kf369.fsf@waller.obbligato.org/

 contrib/subtree/git-subtree.sh     |  2 +-
 contrib/subtree/t/t7900-subtree.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index dec085a23..81ad6e716 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -693,7 +693,7 @@ cmd_split () {
 	then
 		unrevs=
 	else
-		unrevs="$(find_existing_splits "$dir" "$revs")"
+		unrevs="$(find_existing_splits "$dir" "$revs")" || die "could not find existing splits"
 	fi
 
 	# We can't restrict rev-list to only $dir here, because some of our
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index d05c613c9..fb3d73acf 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -493,6 +493,24 @@ test_expect_success 'split "sub dir"/ with --branch for an incompatible branch'
 	)
 '
 
+next_test
+test_expect_success 'split fails without squashed commits existing' '
+	subtree_test_create_repo "$subtree_test_count" &&
+	subtree_test_create_repo "$subtree_test_count/sub proj" &&
+	test_create_commit "$subtree_test_count" main1 &&
+	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+		commit1=$( cd "$subtree_test_count/sub proj" && git rev-parse HEAD ) &&
+	test_create_commit "$subtree_test_count/sub proj" sub2 &&
+	(
+		cd "$subtree_test_count" &&
+		git fetch ./"sub proj" master &&
+		git subtree add --prefix="sub dir" --squash FETCH_HEAD &&
+		git gc --prune=all &&
+		! git rev-parse -q --verify "$commit1^{commit}" &&
+		test_must_fail git subtree split --prefix="sub dir"
+	)
+'
+
 #
 # Validity checking
 #
-- 
2.16.1

