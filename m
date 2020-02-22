Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC7BC35676
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D78D206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nO9ZcgiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgBVUSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:31 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39078 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726930AbgBVUSH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:07 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B3E9A609CF
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402686;
        bh=DYLOd9VnldDrimGAr+4wisqa/X6w7UMcQqzFrqlqGRI=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=nO9ZcgiUeGd0HcBAYHZXvYZGpQkgfkwntZuP2L8sbRtuD/OGIHgoOOmmSahR0Pgrl
         VbQwmCxyx1GNfuFmEvbmAvinH+cg6lLxNpOd4xgiCHQKbfcTTJuxcbcdH0I3R9XPfl
         fGjRbbTZMivXnw3cr8HUynqxA1wLSFejFiVKK57X5qaM+jJngl9og0mpqNgXVV1cwg
         lw/S+muaC1OIWhKspPGQXNE6J70YhVOdUa70NsmosUBC0pnKro4/+06KyOWNj2U8RB
         CbAjeZBBnLyLVVzDEPeMKFBkyR/EBWj2CZ6R5rbCPVLTF7ZFQH+jxZ6jRMssOaXAsi
         +q7+8ae0PI28rwCp3fSepbRXYkgjiIWhIVhXSIwgLYys43fqv9rVK15E1+hCKS94Ib
         Y9OuFcuOCfLuqEpgABDoeWIJIjQv4TxG34fLHEGlWNqAdTR+RW6rRG6B1CLzJ5vwGb
         XEIu0rnA3ymJdK1m7m0mE1anOY2RUnFAQyT+PLGnBbDrclTdYX8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 08/24] t6300: make hash algorithm independent
Date:   Sat, 22 Feb 2020 20:17:33 +0000
Message-Id: <20200222201749.937983-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the git for-each-ref tests asks to sort by object ID.  However,
when sorted, the order of the refs differs between SHA-1 and SHA-256.
Sort the expected output so that the test passes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6300-for-each-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2406b93d35..b3c1092338 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -650,7 +650,7 @@ test_atom refs/tags/signed-long contents "subject line
 body contents
 $sig"
 
-cat >expected <<EOF
+sort >expected <<EOF
 $(git rev-parse refs/tags/bogo) <committer@example.com> refs/tags/bogo
 $(git rev-parse refs/tags/master) <committer@example.com> refs/tags/master
 EOF
