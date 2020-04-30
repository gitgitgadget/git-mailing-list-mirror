Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C684C47253
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 14:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F58A20775
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 14:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhSWg/gW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgD3OzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727065AbgD3OzM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 10:55:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE465C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 07:55:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d15so7316214wrx.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=oir5ozb1zTrSrRjUqihyWFdZoeBclMEoGWNLsVH6rVU=;
        b=VhSWg/gWtufFRLM7/Cg/iSX+S8ynhQq4NWn2gu3p72QJyXElbPdVk42HxHp+OJpcy6
         W3fbAWzJ9o/ZTeCh1Jm+7wTIYwoGYvNl64wBavp5lyVyMv8aeZA74d+0HUCXI6BIFSGi
         xzZNkftUhDQA+TvC8/OBWi9TkUDTboEoEVpiQSQcwgJBg9erg/Rv8NURq34n0Pnx4Kzt
         DQKYNHKCnrr0+2ei+QSqpHxgHsOAg6UEQ2MsmIbRENR1MTjsTpsrDo4UiEQqG+DoqRRF
         xooapmxxAifEC2AGzKdpegj77uUUxX/YUJ5fdKub292dqh/1vFMFfHa4Jmf98PcMNYqe
         RJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=oir5ozb1zTrSrRjUqihyWFdZoeBclMEoGWNLsVH6rVU=;
        b=AwV4umiMSHi8gpGmHDv51we3seuQJCiZlHGy3H/GfZKEeP1cpmun0ehTAKLrC1LcHn
         EvLaWQlqcrthFT/se1xx+i3DRPAil3NCU0nR7aYy74xeEB0A9EWWpcR0cThVbaqw8wFb
         /cxAg9Qq2WLiotsy8ogf4Mwk6pKIZe2dzmQq2teYNHMVLTUMSybDQJazoYu933EV4eaw
         lSXlr8rFXFAPAmr8YVagmd/+m5Hw1H+gKELHdSdLChhi5xYhfD+D6uXRlhDnwm3vHgF6
         1qFFyhe4aMrD7vmjq/8Zgi/mjQMQpHtcTuNMUA0p2WJpZDOua13LUBKpjrjMKKBO6pQi
         p0ZQ==
X-Gm-Message-State: AGi0PuYayqGoy2C35BqTS1fQk0bG6JIK0mHBdUWEbNE+yx6bk3Ta3av9
        ulcZLJvLJAVVVqW1buurg/byDxbBgPk=
X-Google-Smtp-Source: APiQypKCjspRFW/TUoh0DKufpAD16h1zXl7AlM5wUEIhI2LOOvwgwGnkwRtKNZpes03be0o/O6SZfQ==
X-Received: by 2002:adf:f1cd:: with SMTP id z13mr4824462wro.166.1588258509365;
        Thu, 30 Apr 2020 07:55:09 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:811c:204b:9f3f:3cce? ([2a02:a210:ca2:9c00:811c:204b:9f3f:3cce])
        by smtp.gmail.com with ESMTPSA id h3sm4272920wrm.73.2020.04.30.07.55.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:55:08 -0700 (PDT)
From:   Son Luong Ngoc <sluongng@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Seg Fault on git fetch with fetch.negotiationAlgorithm=skipping
Message-Id: <450D5CC7-113A-40D8-9CD4-53786198526D@gmail.com>
Date:   Thu, 30 Apr 2020 16:55:07 +0200
Cc:     Junio C Hamano <gitster@pobox.com>
To:     git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

We recently encountered a segfault during a git fetch
strace output could be found =
https://gist.github.com/sluongng/e48327cc911c617ed2ef8578acc2ea34

The root cause was due to having `fetch.negotiationAlgorithm=3Dskipping`
The repo is about linux.git size with a few NULL commit that we have =
been using `fsck.skipList`=20
on both server and client side to skip.

Is this and edge case for the new algorithm?

Cheers,
Son Luong.=
