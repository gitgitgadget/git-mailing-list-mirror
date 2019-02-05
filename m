Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6491F453
	for <e@80x24.org>; Tue,  5 Feb 2019 09:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfBEJT5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 04:19:57 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:34282 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfBEJT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 04:19:57 -0500
Received: by mail-vs1-f41.google.com with SMTP id y27so1736529vsi.1
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 01:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cybereason-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=2MnGTEWDnEIEhGyET70VTy7r5QuWSs5Qc5sRNtfMywY=;
        b=pVO3WWywH8n2EnunUhcl8XJGXATldO/VE8pXnEtBE6Z1BOLPxq7CRFZlCOSXlXECvS
         xPXi301idNikLHBIjJNM0EGzfkOASLnVVRB8Xn4KQmi2Xte/IkPxRr98mo7qMiSLhROL
         GD7g9L3BAxfXZmnmo1Seh1qA73BzJyV6+Z0VnseNPPDojT3+KxcrydyleInjHVJsOuPN
         go42qolqe5SOXpUu8D+GqehHe9IXaPQiWJwvqQ54cxQvXfIosTnXRbr40LwX8YG50ta5
         X38ps32vZsLZC+prGHAyzrbi66KHwMrp+qz9WcZ4NAN+abLXxL6PlidIFHOW+24Zv4o7
         8fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2MnGTEWDnEIEhGyET70VTy7r5QuWSs5Qc5sRNtfMywY=;
        b=PZza3UnyEMpOmlVpihaFK+LmqYreR4A/VaEL5SaHMqmRAybGH+WzwfLBvmX8PANFuC
         I2KiXkYiqdTKAC81E2dyCGW8abSj3P31h5Rz6QlyFU7orQ17lXp5+UqemcNPmyaKE4nk
         fMlf5pFwsvNQhXc+DqIM4IR+lScC9D2xRIH9X4zrOdP4VG5rRwGlxnOS2gCmiaJMh3t8
         22/HoAXyp9fXSMIMbsOG3B7A98+zbqcYdsTbMt8jiBvL7Jq6njX9/AHvJul2SdbpdyAB
         66GQzfE2tYt7vXVjlTst3b9dJYyq79HjakaoYoesOREHCM3DMkdykO4Zr7fdC3kZBLGo
         qSAQ==
X-Gm-Message-State: AHQUAua8tcuKBFObKBC7SHdorax7+j2nQsveiNOJI4meR9GyRPAd6nDA
        zeQEpGf/i8+52q7L7SLuVgyzZbrpj/JguGRT/U0DJUTL9bp30Q==
X-Google-Smtp-Source: AHgI3IYuxYqUGGzy7lNYL0tft7Emul0r7wbP967hnbj0hVqwr3kZDRUhRpbKbCI74ZZKXd+DKTae8AIUL2XIHvzE+hc=
X-Received: by 2002:a67:7d86:: with SMTP id y128mr1777787vsc.0.1549358395984;
 Tue, 05 Feb 2019 01:19:55 -0800 (PST)
MIME-Version: 1.0
From:   Dani Koretsky <Dani@cybereason.com>
Date:   Tue, 5 Feb 2019 11:19:40 +0200
Message-ID: <CANcfovV3Pq3pubtNq4HCSZOJ5OC9dVSm+19VkOiQimAH+fttYw@mail.gmail.com>
Subject: [BUG]: git checkout on a new tag with current HEAD shows "head
 detached" at previous tag
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have 2 tags such as release-17.6.230 and release-17.6.220:
If I'm changing commits, all works as expected.

If however both are pointing to the same commit, the output is as follows:

git checkout release-17.6.220
git status
HEAD detached at release-17.6.220

now if I run:
git checkout release-17.6.230
git status
HEAD detached at release-17.6.220

Which is theoretically correct, but I'd expect after checking out a
certain tag I'd be see that specific tag...

Sorry if this is intended behavior, I couldn't find clear mention of
this behavior on the git checkout documentation online..

Let me know if I can help in anyway.

Cheers,
Dani Koretsky - Researcher
