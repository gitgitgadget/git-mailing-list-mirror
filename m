Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5931FC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182712078D
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rams-colostate-edu.20150623.gappssmtp.com header.i=@rams-colostate-edu.20150623.gappssmtp.com header.b="hF3ghuk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgFJXPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgFJXPW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 19:15:22 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB67C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 16:15:21 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id c8so4282421iob.6
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 16:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rams-colostate-edu.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=iA8WTHYosc5eJJngXy1YINjJDSeRqEXxPnix9HJN/yc=;
        b=hF3ghuk8T7iBYVlzVfhklOH5/oVd/O8eHzBzrmSIT6sOn2HFmemhd+4bZnqB61/Pd/
         CaBHv0xMV1tuY0ljMP+eVRxg1ZpswmO08WF6IV2I5Rh+ZSrTyyzB/z0xLwZuHsroBiAQ
         nUT1zoO0AfvhaqsJWanlI+VNOOayjjeWCC2HZL95YY1kjSAZDIHIfxJac+9MSg/+/P6v
         8yY5iv5Sp41jAfKO44jxFGr/h0GTg5IEqZMmOMQW+QpMGMbWWph8YuH0wtPS/l5HZ9rV
         58qO5vQ1uyzjTEeEk4cWD6ZsTVDVgwWbO8KjOdwUbl2eZNnJQdo1SpxlOkgbVIUPC3IV
         wfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=iA8WTHYosc5eJJngXy1YINjJDSeRqEXxPnix9HJN/yc=;
        b=gbKqmeVDbGWYX0hAaWCNcmRbGc754Pa/5rV0Ry2URyk/Urg0ajmATiikXpYv0rAwg2
         yg3uUtNhQ5xK7XP2sFn70f/KJny//Vbf/z0Qu6A15bttY8ULmO0pbiSBYN2yfbXjIuV8
         dg7zYV5uA9QcuROvNU0Vr2jLdvDkYB37b/kLMMshaPeVltq7Ozt53LUoJ9DwYf6wRGW6
         53vlm6cotXRF4sYaJgPw1oqJciham8aKWcKvcTexvG4b/v79RwHdnlz9yJFXfsJgehmt
         wwtfYHFlLJLzPWMt6mA9hK5D+0RcxmYi4q1E09HWP1iUaXhSUt6ZRjyFLeeQGDgYrGU/
         4bMg==
X-Gm-Message-State: AOAM530KUVMPepe0Td1MA4uXL4Ut4r0BaOffp17+o8T4D6ltpQoLwYLI
        Y9ZvJ+dlpgUgNtT7PWIN56ETFwUWq6c=
X-Google-Smtp-Source: ABdhPJwfWHisTrJ2V6+iKCjh68NOEDfcJFjNObWj9FyA5KEXrF9mZNpKWgk0kj3EGbXR0wmylIW8QA==
X-Received: by 2002:a02:952f:: with SMTP id y44mr600146jah.128.1591830920705;
        Wed, 10 Jun 2020 16:15:20 -0700 (PDT)
Received: from [10.180.91.128] (host-110-24.cofcdis.ftcollins.co.us.clients.pavlovmedia.net. [68.180.110.24])
        by smtp.gmail.com with ESMTPSA id n20sm650718ila.85.2020.06.10.16.15.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 16:15:20 -0700 (PDT)
From:   Jimit Bhalavat <jimit@rams.colostate.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: GPG Commit Signing Project 
Message-Id: <E1FF93D8-514C-4559-A8DE-1845D0FD3479@rams.colostate.edu>
Date:   Wed, 10 Jun 2020 17:11:39 -0600
Cc:     git@vger.kernel.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good Afternoon,=20

Hope you are doing well. As you know, I have been selected by The Linux =
Foundation to work on the Commit Signing Project. We are trying again to =
make the signing subsystem generic so that we can use other signing =
tools while preserving backward compatibility with existing .gitconfigs =
and setups. The code changes are pretty significant.=20

Do you think we should create a topic under the pu branch?=20

The below link shows some of the topics currently in pu:

https://github.com/git/git/commits/pu

Thank you once again. I really appreciate all your help and guidelines.=20=


Be well and Stay safe,
Jimit Bhalavat.=
