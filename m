Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CA1C33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD9A2081E
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="EbMELyWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgAMMs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:28 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37780 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728895AbgAMMsA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:00 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C47B4607FB
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919680;
        bh=DYLOd9VnldDrimGAr+4wisqa/X6w7UMcQqzFrqlqGRI=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=EbMELyWdY4+xbjtKePvzTPfDT8CnHwRgfQ64vsezI/ICKLf708p7RU+OfIo9C3uya
         yDRGVkCu7kmCzvE+Xe2MGVx3lYfr/SkXSOIg90CQf37XxcYgH52jTYyK6Nn5BRdADK
         FPlAhyD1MHY63Cc1xgpuJ2HQ3/LDuH5fq1e0BO7OQehMAbxfbB7FRDq65CIqX9VRcQ
         eAPuzLGNKe0BfOugtGe5qQexSGiK0N9dYN58D9vgDo7vEI39ikMwzINKUBJdfqwgUG
         NmI55B4rR2TRv3bpYhoSvhqodhIvzSFwaQyAOsVGjBbQsmE5S6OfuvbtSWUavijTzI
         d6dq54qhkBmjO0Q70dX3WLue35G2tnsrYQDztmRCgqgFIRapfyUetNv595M2a8IqwD
         Ad8wnGcdACDaE7ZjNdKIqbWaCq77W1u4pCAhCfR1ewFzAU4xdiHJ6em0sGsYN2dqKV
         1cbFA1A2Q3PBGSEkotiSqfNMcppAwZcvNyTD3zkHuqbP0R7LHiw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 06/22] t6300: make hash algorithm independent
Date:   Mon, 13 Jan 2020 12:47:13 +0000
Message-Id: <20200113124729.3684846-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
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
