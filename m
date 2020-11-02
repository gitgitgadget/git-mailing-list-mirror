Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895E0C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 06:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0B322226
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 06:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=barzilay-org.20150623.gappssmtp.com header.i=@barzilay-org.20150623.gappssmtp.com header.b="YalPSOjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgKBGx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 01:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbgKBGx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 01:53:29 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF7FC0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 22:53:29 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id dk16so16797790ejb.12
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 22:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barzilay-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=bHC/J1dnd6jENkGroj8yntS/HNMrIdvzY168SgIkMHc=;
        b=YalPSOjWzwDuGEOhxpULXFeGqmAT78AUGycl9uqgKtBFWbVEoiB8ffnz2BIL1N7pws
         Kwf4YVTgPKs/W4tH2SmQE3DOFyD3Cy5n9BodM169K2tAQUVqsj6S79KFrQcKkB36byUZ
         HHXtlQPKu1JJgYi/8HQcxfLYTr1cW0kaKHEwxLMe+j7iS5BjcKDfqA76PQ/Lyf+bg+VI
         M9NUUGuw8EpeSwYViPzOEXDp09Qt+tvA6CmH7/ItZdN0zmO5Yuu6tZKvctJFetZ5I4DV
         MLx7rwcmPdYosEOMui7UTlifviV0sH7u9jNLY+LdgcHE1XnfoPGL4sPzPbWzaHYxjQ8+
         CjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bHC/J1dnd6jENkGroj8yntS/HNMrIdvzY168SgIkMHc=;
        b=MDBoMRx69klfBLYh1ow3BnzQ0zkQek2R0DmHnMunoyTFj2P155VIMd42Fpd9bXeEHL
         lkbZ2odl3uVNxhGu7Xin6I7S5IPZolN6Kkr2kM3iCuPWL8PoR9IApfK45Dbj0vDgmP2n
         Fhpn2+14+fCRTb5i/GVhMkBUadD8pSI8m+oy3yRGCtOLVx4bWwbfH1wwq8haGcU8r4E9
         OKufBiv6GxHLqdDjEnOzAjFmwttyO08/Pn6lTcFWwkG5GGn6VeS6QSLl5/ati5J+kHMU
         ZprI98MbPRQ3uS+yHU01b0FOIKNedLhzEg3Vtfcqv/new9OgOn+hcFUh6zKEp4rKeopv
         2aYw==
X-Gm-Message-State: AOAM530AQUfwsvO2Kbwsn55rZJG3ALJzprNVDirlRenVggD+wCt2dqTi
        O+I9EUiOVJ3SZqPN49gu6AzhTQg/FxQVML2fsIyXqyd3MFEmdA==
X-Google-Smtp-Source: ABdhPJxPhFxQzyJLXFIBIxpwrNPedxtVJZebTvtG7LAg3ej6bGDMYn7ohvl8orb1458ohchRyWmLBr/ahOqVzWemSWo=
X-Received: by 2002:a17:906:c0ce:: with SMTP id bn14mr5162151ejb.105.1604300007566;
 Sun, 01 Nov 2020 22:53:27 -0800 (PST)
MIME-Version: 1.0
From:   Eli Barzilay <eli@barzilay.org>
Date:   Mon, 2 Nov 2020 01:53:33 -0500
Message-ID: <CALO-guviA4xKjUi0HfA+RLkTPPaQw7KArj__A9fKz0oP3m5MGw@mail.gmail.com>
Subject: git-diff bug?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is the following a bug?

    $ printf "aaa\nbbb\nccc\n\n" > 1
    $ printf "aaa\nbbb\n\nccc\n" > 2
    $ git diff --ignore-blank-lines 1 2

This shows a weird output, as if `ccc` was removed and then re-added.
Flipping the 1 & 2 names makes it show no difference at all.  I tried
a bunch of variants, including --minimal, and the four algorithms, and
all show the same results.  (Similar brokenness happens with an empty
line at the beginning on one side and after the first line on the
other.)

I'm really not sure that the following is a bug, because I see the
same behavior from `diff` (which is what made me try git-diff, hoping
that it would be more consistent).  (But I can't think of any rational
that would make it not a bug.)

-- 
                   ((x=>x(x))(x=>x(x)))                  Eli Barzilay:
                   http://barzilay.org/                  Maze is Life!
