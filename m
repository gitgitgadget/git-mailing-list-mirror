Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A42C35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 22:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 495D621473
	for <git@archiver.kernel.org>; Thu,  7 May 2020 22:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOF279Lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgEGW7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 18:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgEGW7b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 18:59:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F69C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 15:59:30 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w20so8182455ljj.0
        for <git@vger.kernel.org>; Thu, 07 May 2020 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nUi6A75XOOwMEkEO2JWdIanfc2iKzbybZ/xN3I5N5aI=;
        b=hOF279LorrNsY8oVwYEqrbhlR9lXLXbRxAXg8KBAOc8mGk4iS/z6XeiB0h8JJyJplI
         e9k72O652AH0iJ/yPAUFGqceB2rKZdyYc8W6EeZ91tJM5rRvkfhI03WQwKPoAkVCYHS2
         Q+Cay1pzt5hDZMFp66O5kmKjq7usVOxSmVbWXIbKninOtWugCUG7GGr1mg75QTVE/lG/
         s8SLA4I5xYhqdq1pj1eOQDvSuHOAikjnf0RnLO+p5J3Hgtu16c5ps32FV7Ghot6l2qmJ
         9NwB58RX0/edEkhfq3xTICnh6pMAG4bPFEFaQzePo5WEpHsXyEhv5LA4s1YRTdFwOP8Y
         0wBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nUi6A75XOOwMEkEO2JWdIanfc2iKzbybZ/xN3I5N5aI=;
        b=Q3qLud2XehxrM4qSWjTmEViCoJi2UxSMmU+6tXOGucg+Tma/kv1mz6zUpeT6Tv8lE7
         GEc8zBLf+BWRs5JmmZE4C7SQd749a6y/QMoSdy91RPUDkNeUTF4RQioYi8zRRtj9YAmK
         sKnlB7ppAsf9ZRkU9FDpNSmp5MDsG3NfXziZHB4Are7mIJGcGkryiqIXUkMKsSUNd81V
         PdxkPZsvJkzLScXC3c8bvKjOiwEzwo9BtyNKsAqAv0yUMP5SkQvEw6KOjBP6tDhQy+49
         NL64a8e+FxD/EOKryoWIVSUpbtJqH0F+/xsmYnpANB6JkxojhYbCIJm13YaCol256kzv
         RFZw==
X-Gm-Message-State: AGi0Pub8ywK5hkJLxQPDI4Wk36V2XWerCZF7/pjmPWMxMiSSwrgzgq21
        FIxLKVptaeBLM2nkwoTsQLcKCLbdFMhuYKkCmBTxw5AnkF8=
X-Google-Smtp-Source: APiQypLK9af0kVcFmuGmom+WudYeD2jSe84bsADKYPS8mH8UtbSjAp+K6F1L1kleQrPmI78WSeAESq443y05GoldO44=
X-Received: by 2002:a2e:99cc:: with SMTP id l12mr10018408ljj.290.1588892367974;
 Thu, 07 May 2020 15:59:27 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Thu, 7 May 2020 15:59:16 -0700
Message-ID: <CA+KyZp7TELrswPjNgB99BXXHEXi5pRr5bO3g_wy7zBvv1R4Kww@mail.gmail.com>
Subject: check if one branch contains another branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am looking for a command:

1>  if branch x contains branch y

right now all I can find is

2> if current branch contains commit y

can someone please accomplish #1 ?
Crazy hard to find an answer to #1 online.
The user case is to delete old local branches by comparing them with
the remote integration branch.

more info if needed:
https://stackoverflow.com/questions/61669056/how-to-determine-if-integration-branch-contains-feature-branch

-alex

--
Alexander D. Mills
New cell phone # (415)730-1805
linkedin.com/in/alexanderdmills
