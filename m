Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E11C001DE
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 02:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjHACy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 22:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjHACyz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 22:54:55 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5074F114
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 19:54:55 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 0E5E41F545
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 02:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1690858495;
        bh=qTsAIUKmL631I4jO9v0HiGG6QZL473DYlvhuQVuP0r8=;
        h=From:To:Subject:Date:From;
        b=xBpd1zLD6qjfwb2g8YoWr9ECC6J4AzRd33yy36mpOKFMHZQnAZARrrr606DkGjQmf
         WEA6I05qCG1bdQBIBxDLU1r6zubuVizXgYIiiHsvQNqAxlx4R4M4TwaMEzSXdsnPce
         exOtgT2cxt8DbLwfuBRijqzQZbpa83FATv/YOUY0=
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] avoid functions deprecated in OpenSSL 3+
Date:   Tue,  1 Aug 2023 02:54:52 +0000
Message-Id: <20230801025454.1137802-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OpenSSL appears to be getting rid of the SHA1* and SHA256*
functions in favor of the more generic EVP_* APIs.  The EVP_*
APIs unfortunately require more attention to be paid to memory
management and require specialized copy functions (like gcrypt),
so I'm only using them with OpenSSL 3.x (I've tested 1.1.1n, too).

I'm in favor of keeping OpenSSL support since its development
headers/libraries are more likely to be already-installed on
developers' systems than nettle or gcrypt.

On Debian systems participating in popularity-contest:
libssl-dev is in 21.95% of systems, while nettle-dev and
libgcrypt20-dev is are only in 4.08% and 2.94%, respectively:

  https://qa.debian.org/popcon.php?package=openssl
  https://qa.debian.org/popcon.php?package=nettle
  https://qa.debian.org/popcon.php?package=libgcrypt20

Eric Wong (2):
  sha256: avoid functions deprecated in OpenSSL 3+
  avoid SHA-1 functions deprecated in OpenSSL 3+

 Makefile         |  6 ++++++
 hash-ll.h        | 18 ++++++++++++++++--
 sha1/openssl.h   | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 sha256/openssl.h | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 2 deletions(-)
 create mode 100644 sha1/openssl.h
 create mode 100644 sha256/openssl.h
