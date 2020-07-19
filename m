Return-Path: <SRS0=m+L4=A6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD807C433E0
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 04:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3E020724
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 04:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skylittlesystem-org.20150623.gappssmtp.com header.i=@skylittlesystem-org.20150623.gappssmtp.com header.b="Epot5JZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgGSEZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jul 2020 00:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGSEZR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jul 2020 00:25:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26150C0619D2
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 21:25:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so14724289wrw.5
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 21:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skylittlesystem-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSMXPDLBGT5IP7V/aT7rRsdoQlpQF3Us+64LI4p8+Pw=;
        b=Epot5JZjSkDAFERYdsYw1lqszVviPKPIh7uHpBxtaJZXjiR+ykUH3oTN9y9rvPs/1D
         5uvhSisZ1VUOGKU5XxFddHLqu//tl17BUJe/5Ans5QB9MEichKEMa3px1YyIoqbm15Ui
         h2QJWO/+EjzWh+t3/Hd1WgqCaKLAUZ0Bhmbr96Fw1/7xndD9XbsxBTHFT8//bcoW/ZQC
         a0hu+8XTJp3frmbq3v7qcpsBqO6ebCj0J1UCQrRXLWgqFfYPXAJdSLwVdjHsORlnTNAH
         sBQDPH1gKDPjZloBmzXxSQ4UxocMj4Fng9r+QYFr2s2dAgsMdKnXW9QMOYS7Ie6u/dUU
         E++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSMXPDLBGT5IP7V/aT7rRsdoQlpQF3Us+64LI4p8+Pw=;
        b=sOjnht08hb3jXCh3heW/gLPAa1CDXO8c4Lf3900Xtt19rK0R9hgWuBw0AP0M1Zh25n
         Np0zU44/PugmXUZonWBsRhsnpy6+Mxg/j7f+OPkbUmp7MiOpUaMUn5sstCbajVEzY0t+
         T8J+KPBYVYrUuOPtbi0PEjr7gzetY4MkdtNTxFCptRJLT/R7WD7pziXV8fkljKLhjc4O
         uGg+l/Thlpg/7S3ubqkIq9kqJrncwSjv46ISYU1Fb50saqX1KcH2t0qgIHCqG/h1WE67
         bykuH2JbwNTuc8bT31OZ2tmda2liawjmWe9EryE5a0GwZ0rd2AszzuWZg00CNRZeBs4t
         nD/g==
X-Gm-Message-State: AOAM532lsQoBgcZMkIi9JfDSa/zYvE0UKEj+NZfEw7PEMMQS2EAvzlOD
        XBXwIDIrYziSUnQQOtlXcdiSnyO1cgc=
X-Google-Smtp-Source: ABdhPJy9AHPJ97V6ASgLDB1gvhqeT+XI6Y5M+YFrljoP8BYSqqYPGH5/0AWW6vyGWgitInlcib7wSw==
X-Received: by 2002:a5d:618e:: with SMTP id j14mr8302321wru.252.1595132714393;
        Sat, 18 Jul 2020 21:25:14 -0700 (PDT)
Received: from localhost.localdomain (cpc110667-lewi19-2-0-cust284.2-4.cable.virginm.net. [80.7.253.29])
        by smtp.gmail.com with ESMTPSA id z16sm23571965wrr.35.2020.07.18.21.25.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 21:25:13 -0700 (PDT)
From:   pudinha <rogi@skylittlesystem.org>
To:     git@vger.kernel.org
Cc:     pudinha <rogi@skylittlesystem.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] Support nvim as merge tool
Date:   Sun, 19 Jul 2020 05:23:35 +0100
Message-Id: <20200719042335.3913-1-rogi@skylittlesystem.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200718192001.27434-1-rogi@skylittlesystem.org>
References: <20200718192001.27434-1-rogi@skylittlesystem.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> For example, we could add another method the backends could define,
> call it list_tool_variants, and whenever the control flow goes from
> run_merge_tool through setup_tool for a tool whose name ends with
> [1-9], e.g. "foomerge3", we first see if there is "foomerge" tool
> and if there is ask it if it knows about "foomerge3" variant by
> calling its list_tool_variants.
>
> That way, we probably can remove the files for vimdiff2, vimdiff3,
> gvimdiff2 and gvimdiff3 (gvimdiff needs to stay there, as we do not
> want to make the name derivation rule too complex) only to hold a
> single line ". vimdiff".  Then the next person who adds yet another
> set of backends based on a yet another reimplementation or skin of
> vim would only have to add a single file in mergetools/ directory,
> not three.

This is what I managed to do.

pudinha (2):
  Refactor vimdiff and bc merge tool variants
  Support nvim as merge tool

 contrib/completion/git-completion.bash |  4 +--
 git-mergetool--lib.sh                  | 35 ++++++++++++++++++++------
 mergetools/bc                          |  5 ++++
 mergetools/bc3                         |  1 -
 mergetools/gvimdiff3                   |  1 -
 mergetools/{gvimdiff2 => nvimdiff}     |  0
 mergetools/vimdiff                     | 21 ++++++++++++----
 mergetools/vimdiff2                    |  1 -
 mergetools/vimdiff3                    |  1 -
 9 files changed, 51 insertions(+), 18 deletions(-)
 delete mode 100644 mergetools/bc3
 delete mode 100644 mergetools/gvimdiff3
 rename mergetools/{gvimdiff2 => nvimdiff} (100%)
 delete mode 100644 mergetools/vimdiff2
 delete mode 100644 mergetools/vimdiff3

-- 
2.27.0

