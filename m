Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8868CC433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 01:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6240F20897
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 01:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rams-colostate-edu.20150623.gappssmtp.com header.i=@rams-colostate-edu.20150623.gappssmtp.com header.b="b/PkCC7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgFBBAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFBBAI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 21:00:08 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D572BC061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 18:00:07 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h4so5768470iob.10
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 18:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rams-colostate-edu.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=dbZhNealWG/+dW9Vsm3h7gMLsTl9FLosDJ4qPAWiAsU=;
        b=b/PkCC7I43sgkKdzkYEb9utgka0sAeJX1dL5u81pkb/4tuV09EJFYvBnKfberu9G5K
         +VCmmCJINOoOoTqSdTl/QIhm7Tamq65Uyb8ZXlAgBFmIv6wDvAEeYu1w8XoxPXrOJQF8
         1WQwJZ5Tvp3MyUnFuYE5mjBGY32KjzCFMNbCKL6fYEQDfsFIDnPNHfYPqQFdPhH/hw5+
         DdFDSLjCwaDn4/CJudyQiEKH7m2+fPrKDeoa+jOj+srQ7c0LDbjQBeNyP+2eE+yIJuA0
         7A59gEKZtu5Zz9jsd4L994FJ7irrBJnQdgxyI4tFN4vYyIFyERf/9CNwgpdkzG0WmdhA
         LEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=dbZhNealWG/+dW9Vsm3h7gMLsTl9FLosDJ4qPAWiAsU=;
        b=pgIZmMgTqOIeTXWlZFKI5DLHYPs8uY1Dv/IGkNMtftvU13yQ4YK6rm3AUwLXrnK9de
         pnVEUQcyBpLnfnVYIkEDNOjXvpOQw4xfWEcI+aMyA4CD3fwjEOm6bZ2+vMRIJjmUbHN2
         hvKO0g3YsxOag1vkd5sDRmUgwl85pTbWYd2VA2UH2lnoLZAvSpZ3Oc5LVYky8sTe7S2r
         M6tj3T2KrLE5XqHV75kw3+FAHs7r8eHqBhspM5Fy9jynnCgIWblT4T6vWlHmZ9IiW3yX
         yOhlcZ8opZRWouefLUwj6av1OCGMIYTkA7RficyFt/GbWg82OEWB8ys5xY67vyj4ZZ+s
         fcpA==
X-Gm-Message-State: AOAM532jOlohANXDZAc+PqRiGBxywDiF/q7+NQGEKTIqXj3ucBYU4sxt
        VeMQPRM92QqnMR3Z85cnz3FWplt1d3o=
X-Google-Smtp-Source: ABdhPJwVHisYxJnpUHXBJiNHu6Cwmhm6sXDWMIzzuODhCWolcJx7ogM6wMuq+LGvjAn5Hbt0louoYw==
X-Received: by 2002:a02:707:: with SMTP id f7mr22792393jaf.119.1591059606810;
        Mon, 01 Jun 2020 18:00:06 -0700 (PDT)
Received: from [10.180.91.251] (host-110-27.cofcdis.ftcollins.co.us.clients.pavlovmedia.net. [68.180.110.27])
        by smtp.gmail.com with ESMTPSA id w78sm640990ilk.14.2020.06.01.18.00.06
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 18:00:06 -0700 (PDT)
From:   Jimit Bhalavat <jimit@rams.colostate.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: [Hyperledger Git Commit Signing Project
Message-Id: <EADD025F-5A1D-4F9A-A8DE-1CCCE5D191C3@rams.colostate.edu>
Date:   Mon, 1 Jun 2020 18:56:54 -0600
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good Evening,=20

I am Jimit Bhalavat, a junior at Colorado State University. I am going =
to be working on Hyperledger Git Commit Signing Project and carry on the =
work done from Summer 2019.=20

Who is the maintainer for the Git Commit Signing Project? Who do I =
contact if I come across questions?

Thank you so much.

Best,
Jimit Bhalavat.=
