Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB3BC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 22:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A6260EC0
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 22:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhHJWZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 18:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbhHJWZU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 18:25:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAF4C061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 15:24:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w14so271889pjh.5
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=KiNiMyDx6Agol2U36z80cWmFDULXNMhI9ZrKdIrHvF0=;
        b=GM2ScFIsJQk4ekES9CYbYFOStjKfd+ssdukaoQl+8AXrcxZ/2X8ovwb2DCE2tWN2Bt
         04u9NKxwYVaKfQuGDWB5grp7QarE/uvjIRIBtrfj0XEzEWhjJfiL7uCI6BnjnjlbLm42
         p5vYmfdiUW+ZFT1BBKbFQ+YedYIU1jRQqfVwCmCrMt7SMwbnwEh5EZE2zXKkjuNVQafS
         Y3RpcISk58/8OZ61kHT4W0OrHFiJneITKYSuwZeaLRC9PWpSNRvrQmxTBtVizqrWldER
         i9geLGtji0fTG8tNelV15TyL8KR6Y5KOFc6a2dyjetdAkp7w5VBuEhrSR+8faS03VgIp
         D8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=KiNiMyDx6Agol2U36z80cWmFDULXNMhI9ZrKdIrHvF0=;
        b=FWyMY9EocaPzd02A6mXTA5fwz1nrCMjFWPgdzAONSVn/55dnGpOQ2wrs4yse85hLNv
         3CubWCVlRn+TOvCBZ1TnJhgnzyH5DEGmhV6kn/T0ZZ/6mJ0D5zfF2WuP9BJNpR9AMsO6
         oGVAiwLB1RNcVqgRSqOtfNwIrHKYJ0t25gdRY+7cQyoRKXVzHNqtfwgeqqxV7N0SHrKS
         Bgf5HIwOUUmkwPClBVH5EwYCfBCY6sfDoF0sepruAewAqJcVXChlap1Wg8q0wWaQqyK6
         8Gve+R+DWdn9MGdP1qzEe8GR71qiPJmJ9BmluvZJVnLsYhBkd9wRMY6JB9q433wbUqRB
         Rxhg==
X-Gm-Message-State: AOAM533Tj2QydTrflp4GWCj5PS0Q+tJdZhZAnFF28l0nKGtdnr0alcOX
        E+vxAE3lEvPzF9TfE0SPfSZ5Xeqkx81Kjw==
X-Google-Smtp-Source: ABdhPJysVtKS19ydG/XKCHCgjeMTrmH6Cnnc04OtJQfbH3VngrZFf60J6Zs7wNJKLa81UDJEd4mbzg==
X-Received: by 2002:a17:902:db08:b029:12c:c5d2:534c with SMTP id m8-20020a170902db08b029012cc5d2534cmr4021791plx.47.1628634297005;
        Tue, 10 Aug 2021 15:24:57 -0700 (PDT)
Received: from OFFICE (38-29-232-210.dynamic.airfiber.cc. [38.29.232.210])
        by smtp.gmail.com with ESMTPSA id d10sm6077237pfd.49.2021.08.10.15.24.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Aug 2021 15:24:56 -0700 (PDT)
From:   <mail.chris.az@gmail.com>
To:     <git@vger.kernel.org>
Subject: Branch Management
Date:   Tue, 10 Aug 2021 15:24:55 -0700
Message-ID: <01d001d78e36$8d47f380$a7d7da80$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdeONovnxYHOlBLnReeMaO+gVX+zkA==
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a private git repository (private.git) on a private server
(PRIVATEREPO.COM).  That repo is updated via development on my local system.
All works great in that area.  I have 2 branches, "master" and "version".

I want to update my production system via git from the private git
repository via command line.  The production system not only contains the
files from the repo, but also additional files and directories.  I need
those files to be left alone.

I was able to successful clone just the "master" branch using:

# git clone -b master git_user@PRIVATEREPO.COM:private.git production.git

I am now ready to move the new "version" branch.  
1.  How can I do that?

The "version" branch contains some new files that are not in the "master"
branch.

Now suppose that I move to the "version" branch, but determine that I need
to go back to the "master" branch.

2.  How do I go back to the "master" branch and remove any of the new files
that were uploaded from the "version" branch?  I don't want any remnants
that the "version" branch was even there.

Hopefully someone can head me in the right direction.

Thanks!

