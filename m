Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5A0C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 01:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1887261074
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 01:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhJZBif (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 21:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhJZBie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 21:38:34 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A956C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 18:36:11 -0700 (PDT)
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635212168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UgMT852jlWMgEPaTJFf9JNOlFzxcHj39AfJdgFFnZuo=;
        b=qB2SrK1l6LQlzuvTx59U39YfYiChL8VKOjU0BNPtE5tkCU4VP/4g3b7Ny8XIqOKyeKgnH4
        tQOMj2or+Kz7UsldWeLlC7F9g+0piWWnfNYRENoOkF7yiltbj9/fptSnSTlOtF+nlakKYQ
        CH6DWKZkW1WKYCOJKehqceUVHE8Bi64Z6f0bxRCrntVbcs2I7cg3cBWPgx6Q23T6FcY4dU
        1ClcLhApAVzNk7XFwUgyFiN7/gZ4wBNPCez99V5F5wM3PA9dTKZFL2wwRsKkKf+CGEN/Eb
        yHKqLNRC0jo5moSK8+s3UbhEsPko4Tl0zMuCPdrHu4EPtsCiUBuVeNUwaECNQa3axSiXj2
        Cm+OhjNFCxJ7h8zSqkDPB0H7NoD3yhZJ3s26/1yFmutHD5N/ahHNSd591E1UmCPhKe6/OI
        1nXabkayZmT7XBwdJeuMiJtRiU0NfIh66abY44j+Nng0a/IJ7p3VqU6qBZQ+iuZKiqcsjB
        h1hZF17Wwv9K2c1Tdg3+aSc9mo0AGw1lEljypzCrQab76B2/Kizy2NzubVZg2p5F0kE1g8
        RGFj/01+REXhgd5rAS50xMQCR2C9ftnNMI7coWEwxecf8PVLaxVhBmZ7Cn4LyFNHErUoZ9
        outMiNm3G01cOphDoWuqyMGK95lJG+HX8NJBMl318o+4Xh9lg1ZYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635212168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UgMT852jlWMgEPaTJFf9JNOlFzxcHj39AfJdgFFnZuo=;
        b=Nbyrp+l2bBFiWdzl8R1oJzHey8IlkNlG3ysAc29ExFCNxNSCwxkVEro+Fu8MBylgLlVVqD
        KR7QMLlmsz5heyCg==
To:     git@vger.kernel.org
Subject: [PATCH v2 0/3] Add some more options to the pretty-formats
Date:   Mon, 25 Oct 2021 21:34:49 -0400
Message-Id: <20211026013452.1372122-1-eschwartz@archlinux.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211024014256.3569322-1-eschwartz@archlinux.org>
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the reworked implementation and all-new replacement first patch,
as suggested by review comments.

Minor tweaks to documentation in the second patch, otherwise
documentation and test cases are the same.

Eli Schwartz (3):
  pretty.c: rework describe options parsing for better extensibility
  pretty: add tag option to %(describe)
  pretty: add abbrev option to %(describe)

 Documentation/pretty-formats.txt | 16 +++++++---
 pretty.c                         | 55 ++++++++++++++++++++++++++------
 t/t4205-log-pretty-formats.sh    | 16 ++++++++++
 3 files changed, 72 insertions(+), 15 deletions(-)

-- 
2.33.1

