Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF4AC47409
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB0520733
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="AZhRvlFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLVGse (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 01:48:34 -0500
Received: from mr85p00im-hyfv06011401.me.com ([17.58.23.191]:36705 "EHLO
        mr85p00im-hyfv06011401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbfLVGsd (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Dec 2019 01:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1576997313; bh=m3uuJCGAWgXpdu/O0+TwgNvGXWrZgpeRF6Bmzh+UGCs=;
        h=From:To:Subject:Date:Message-Id;
        b=AZhRvlFTKYVLWafXlHdi2L7vmYRmWnXv65c4AwNCUfdKWc5cJRbDJ5O9zLtK8AGsz
         2Jkd9KzYJYM1oICVig266K/X3niW+9iVBTMb5oIca9R4S4qsXXCXkbJ+6qHIanqN2x
         dlicJQtndjTJtgYt1DwN5aPwouP0KFkEdG0Z29SIWClaqBAEdbrsxjr/fqwN9r+Lyc
         X66mQ7PTQYOZ39TmUe6eWHiFu6g14+jTiZXuKM2r+DtrVDnOXao1C4DmHQDs2E7VDR
         d8kG30LRofp2OiBQuwFW4MP/HLQZZO5vP8AkCcVxauOP2cfM+s+btn8iK4wBZ2cmw9
         O9K7gP+5APS+w==
Received: from localhost.localdomain (125-237-36-9-fibre.sparkbb.co.nz [125.237.36.9])
        by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id 8CEDED20971;
        Sun, 22 Dec 2019 06:48:32 +0000 (UTC)
From:   Michael Clark <michaeljclark@mac.com>
To:     git@vger.kernel.org
Cc:     Michael Clark <michaeljclark@mac.com>
Subject: [PATCH 6/6] Add sha/README.md with table of SHA algorithm details
Date:   Sun, 22 Dec 2019 19:48:09 +1300
Message-Id: <20191222064809.35667-7-michaeljclark@mac.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191222064809.35667-1-michaeljclark@mac.com>
References: <20191222064809.35667-1-michaeljclark@mac.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912220061
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

- Add table showing algorith name, mnemonic, type-code, wdith,
  and library implementation (builtin, gcrypt, OpenSSL, EVP).
---
 sha/README.md | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 sha/README.md

diff --git a/sha/README.md b/sha/README.md
new file mode 100644
index 000000000000..0e24049e4cc7
--- /dev/null
+++ b/sha/README.md
@@ -0,0 +1,23 @@
+# SHA algorithms
+
+### Algorithms
+
+Table showing details of the SHA algorithms:
+
+| algorithm      | mnemonic | type-code    | width | extension | builtin      | gcrypt | OpenSSL| EVP    |
+|:---------------|:---------|:-------------|------:|----------:|:-------------|:-------|:-------|:-------|
+| `sha1`         | `sha1`   | `0x73686131` | 160   | yes       | `sha/sha1`   | yes    | yes    | -      |
+| `sha256`       | `s256`   | `0x73323536` | 256   | yes       | `sha/sha256` | yes    | yes    | -      |
+| `sha224`       | `s224`   | `0x73323234` | 224   | no        | `sha/sha256` | yes    | yes    | -      |
+| `sha512`       | `s512`   | `0x73353132` | 512   | yes       | `sha/sha512` | yes    | yes    | yes    |
+| `sha512/224`   | `s226`   | `0x73323236` | 224   | no        | `sha/sha512` | yes    | yes    | yes    |
+| `sha512/256`   | `s228`   | `0x73323238` | 256   | no        | `sha/sha512` | yes    | yes    | yes    |
+| `sha3-224`     | `s388`   | `0x73333838` | 224   | no        | `sha/sha3`   | yes    | -      | yes    |
+| `sha3-256`     | `s398`   | `0x73333938` | 256   | no        | `sha/sha3`   | yes    | -      | yes    |
+| `sha3-384`     | `s3a8`   | `0x73336138` | 384   | no        | `sha/sha3`   | yes    | -      | yes    |
+| `sha3-512`     | `s3b8`   | `0x73336238` | 512   | no        | `sha/sha3`   | yes    | -      | yes    |
+
+#### Notes
+
+- The _'extension'_ column refers to whether the algorithm is vulnerable to the
+ [length extension attack](https://en.wikipedia.org/wiki/Length_extension_attack).
\ No newline at end of file
-- 
2.20.1

