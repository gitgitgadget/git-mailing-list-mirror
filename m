Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DC6C77B7C
	for <git@archiver.kernel.org>; Sat, 29 Apr 2023 18:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjD2Shp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Apr 2023 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjD2Sho (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2023 14:37:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816D01BEF
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 11:37:43 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b5c830d5eso832749b3a.2
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682793463; x=1685385463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJypmL+5QhwOSKUcVolOgIprR7iBibd2lkK6/p65qC8=;
        b=YKRYzp75Nz0C7T4rFrj0TbWoWuARB0NsPHDIiJIxgF/TrlULHtA8ItVne+yvLjb6XZ
         DpxYm8xeNVPaKk96nPJzuEd1FDY9Sm0Moc8FfkxgQUcOgRQe/hLC7qnc2BuCEo3Jrcbl
         fRTj9zurCHQlDYrTh+GHjQhrP0bnmOFBcvylD7B8B6mjTL4rWzwSCXJMPPtA8yiK6Byz
         BvdWtp9BeHX2M5kdas9bWVM2kk+9tqL+KXpTPP/UlODbRfJnXLYlPRvd6Lnymoom0jce
         ayaeJSJsRNOsVocGv2m+HQHxkhze1VaUroFXwsDv+Mq5dRd7DklIUe3djfGFbIB24AEi
         FhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682793463; x=1685385463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJypmL+5QhwOSKUcVolOgIprR7iBibd2lkK6/p65qC8=;
        b=aEHvlNr1tNyc7JmRYgUJ2URxJvlez2CZfOTTla0AJB+rQbRE4PkghQwzHNsio06TX5
         YvW8vDMBXoTzhBD/Qmk1UI1HSphu9TVZSueacaMVdvATEr6aKqokLznHNenV2jHn1J4Z
         mDybOt8G0Zf5aEM3nnCPQg4EzY22FbyHYxY4eRxzkNo2mL/OoJmnt/hqFF+6S/eu9w2P
         qc6GFq/M3tY4SZZ9tvTVhgDjIqAt8YGIsw+C3vKhbNx8V1LmlBUnpft75Eml61mpXvYj
         aDnxeSweeLiJnlJxpFE1YCRondgbdNxkPWj9++Im0vQyus8ZdregHYnGMsxhT71fp0Gq
         J+nw==
X-Gm-Message-State: AC+VfDwzXoCqe7k4fZmbWm64bPEod2mtih6Nf+A14ShZyzDSbhrM0xe/
        hEtNOOyP+2a8L9VzNdji/FG6FS/od4jLvFP1
X-Google-Smtp-Source: ACHHUZ5J93eFjaILh9PZPzIMJW975TdvuU0800+Sxk3BoDdhxkm8Vene3JLqzAR6tu1sO4t6zhPRvQ==
X-Received: by 2002:a05:6a20:7d84:b0:f0:dedb:83b7 with SMTP id v4-20020a056a207d8400b000f0dedb83b7mr12134722pzj.60.1682793462738;
        Sat, 29 Apr 2023 11:37:42 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.146.132])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7850b000000b0062bc045bf4fsm17732807pfn.19.2023.04.29.11.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 11:37:42 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     five231003@gmail.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        hariom18599@gmail.com, jaydeepjd.8914@gmail.com, gitster@pobox.com,
        nsengiyumvawilberforce@gmail.com
Subject: Re: [PATCH v5 1/1] ref-filter: add new "signature" atom
Date:   Sun, 30 Apr 2023 00:07:36 +0530
Message-Id: <20230429183736.3337-1-five231003@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428182925.14975-1-five231003@gmail.com>
References: <20230428182925.14975-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

>> +test_expect_success GPG 'test bare signature atom' '
>
> I think this test is failing on CI because, as Junio said, there
> are different versions of gpg coming into play here. In particular,
> this test is failing on (according to the logs) linux32 (daald/ubuntu32:xenial).
> The version of GPG that xenial can use is at a maximum v1.4.20 (this is
> evident here https://packages.ubuntu.com/xenial/allpackages). But
> according the code in lib-gpg.sh, we should be able to handle any GPG
> version, except for v1.0.6.

After digging a little bit more into this, I found that when checking
the trustdb, the output is different for GPG v1 and GPG v2. So, I
understand now why you did this

>> +	grep -v "checking the trustdb" out_orig >out &&

The test is still failing because this is not the only line in the
output that is different, but also the line following it, which
conveys information about the key trust levels

  gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model


This is also evident from the diff between "expected" and "actual" in
the logs[1].

[1] https://github.com/git/git/actions/runs/4410308954/jobs/7727652857#step:6:1898

Thanks
