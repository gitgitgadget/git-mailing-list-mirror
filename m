Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E276C433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 02:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiBNCIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Feb 2022 21:08:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiBNCIt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Feb 2022 21:08:49 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6137554BF1
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 18:08:42 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8369B5A09F;
        Mon, 14 Feb 2022 02:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1644804521;
        bh=bMk6gsTnRO5Q+tC4Tv9Cw3kHElh1fz7xU3GUhiIYibc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=RK46PPWsD2sT0l9IAPNSBcStUwwazLTrGbQtBhI8+aHFWdA05mX5BOJhtrqG5OsG1
         z42B+Bg4XMhnikw1A+2aoeefWu1IU5gEDiuK6O4xaScz4VUIKCZMx58DHuhYZ87tTV
         zWcT3A765MQIY8fgdav2S0/bgHmgxirbQbnfs2Xr+9WngoMCOtV1WfT21awSDRYpj4
         QoVYN+Fa63wQ5qwKjhZ8GKi684rpDOrdOGhvMyewG0IZSevIIB3aJ9K3nk7wRUlNev
         djZ6CDE3pl+x4rvsa0ke3RhSy8C5Z9ihEv1i2IvzdfMsS0d8e40L3V6JJyP9Mqdu38
         IMPoCfiTDgzXsW6N7vqmK7VWcQ6bnJRnxZKR2Z3aMIIu60G6hcxACoBWgBvRNCjcGc
         y8/ogX7ZZGzGSwolPQO0dN6Qeddwv8oj3J/JW/qF1I0OGOaFTPBVXLVhiCP9ZosmeK
         dQyCplsRlLfjOyBS0fcwEqyAmtxiPBb7tzfOHbuquMW8PjkhUgH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 2/2] docs: correct documentation about eol attribute
Date:   Mon, 14 Feb 2022 02:08:27 +0000
Message-Id: <20220214020827.1508706-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb
In-Reply-To: <20220214020827.1508706-1-sandals@crustytoothpaste.net>
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
 <20220214020827.1508706-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for the eol attribute states that it is "effectively
setting the text attribute".  However, this implies that it forces the
text attribute to always be set, which has not been the case since
6523728499 ("convert: unify the "auto" handling of CRLF", 2016-06-28).
Let's avoid confusing users (and the present author when trying to
describe Git's behavior to others) by clearly documenting in which
cases the "eol" attribute has effect.

Specifically, the attribute always has an effect unless the file is
explicitly set as -text, or the file is set as text=auto and the file is
detected as binary or has CRLF endings.  It used to be the case that
text=auto did cause automatic conversion of files with CRLF endings, but
that is no longer the case, so let's document that fact as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitattributes.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 83fd4e19a4..a71dad2674 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -160,11 +160,13 @@ unspecified.
 ^^^^^
 
 This attribute sets a specific line-ending style to be used in the
-working directory.  It enables end-of-line conversion without any
-content checks, effectively setting the `text` attribute.  Note that
-setting this attribute on paths which are in the index with CRLF line
-endings may make the paths to be considered dirty.  Adding the path to
-the index again will normalize the line endings in the index.
+working directory.  This attribute has effect only if the `text`
+attribute is set or unspecified, or if it is set to `auto`, the file is
+detected as text, and it is stored with LF endings in the index.  Note
+that setting this attribute on paths which are in the index with CRLF
+line endings may make the paths to be considered dirty unless
+`text=auto` is set. Adding the path to the index again will normalize
+the line endings in the index.
 
 Set to string value "crlf"::
 
