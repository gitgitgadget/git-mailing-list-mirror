Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E00C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 17:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbiDMRg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbiDMRgy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 13:36:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D78A64E3
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 10:34:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 7-20020a250c07000000b0064137917a4eso2237521ybm.12
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=veYYA353vci8ORIxi/1ytUVIftkzp4zmMi02wycdzQk=;
        b=oPo5sRQCPHjrxh41LCFw5xN5ib9eauyyYDbNA4BUl0T2M4khlxa11Cln11mnV/MrM1
         WOb63ivmb/JfwIY8sn+ZkJ3+XS+Qnto5hvBT2VSKQHvkPf2whjAWo1d4w0bSZmZy/52C
         xwFlcsnfcNa1TWpK4m8O6ka0aMU14YbXEJg0F/DKytBZ6TZlWTeB6yTafRNFeiR1H9l/
         YBi+JeksnT5cvmpuJInWLKnTYahYssUMSSyRtDsBE/NxXc3UtKzbxL3yWvl1aS1HP97F
         dHe8/2Yvc1SUfuusVP2dw4PutDLaIXiApQ4cpGmebHlPRX0KG1NTcvySN82QyMByFkx7
         j4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=veYYA353vci8ORIxi/1ytUVIftkzp4zmMi02wycdzQk=;
        b=IpxpusSyhIYDMrEL6nwr7+uQsMNo99vAepofyOsK+yh6jadxtjzz/0bPpoBZGGNv9M
         OOOBzF5Ix/I/NqSKuxBi7R4J5P0tnv0C2mXLbr2Ud6QrjIybrLJXD5X0MPjP6L9CWiDX
         BZap3ZP0ZmMGgioOxIh3lTiTNGpsROwyhlzTYROF4idUJEiOgSYWjJqV3sE4y+rkvLk0
         im03IwsfFaqLGXDwGXYim/jrN6ButvV48JDMZAH2SlKtP6jOy1kyz4ydg/Sbff51K0pp
         eVKpSsVzc94rCn3iisxRM8jp6+Z2Os8jDmnGPRzhp0nZNsIDX1j2h6AxxHa/lUX5UnRY
         aNwg==
X-Gm-Message-State: AOAM531cQq4gv3t76Megq/Ma33O3Bb44p1NunIKLEvAIw6UuUrfC4Ett
        TShyEYRfut+d3bBtZTVSrNY61L1LG5QEjUQQvUzO
X-Google-Smtp-Source: ABdhPJyi+cYYdvWuJrgetjM76j6qvG/OoeNtJw4luUyY9+2+0TUZj3KUApdvevlIm8TvDGB+vYhzzPu1yUvFFlPCuw9H
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:13:b0:2dc:50bc:c975 with
 SMTP id bc19-20020a05690c001300b002dc50bcc975mr37782796ywb.173.1649871272611;
 Wed, 13 Apr 2022 10:34:32 -0700 (PDT)
Date:   Wed, 13 Apr 2022 10:34:28 -0700
In-Reply-To: <YlYjgLcnNH8V1yj0@camp.crustytoothpaste.net>
Message-Id: <20220413173429.971159-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: Re: [PATCH v4 4/4] builtin/stash: provide a way to import stashes
 from a ref
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:
> On 2022-04-12 at 20:14:34, Jonathan Tan wrote:
> > This seems like you're using the commit message as the reflog message -
> > is this necessary? For what it's worth, all tests still pass if I
> > replace "msg" with "NULL".
> 
> I think that's what the existing stash code does, and so I did the same
> here.  It's not strictly necessary, but it's a nice to have.
> 
> I didn't think it worth testing, because I don't think we test it
> elsewhere, either.
> 
> > It might be worth adding tests that check that the exported stashes are
> > in the expected format (to ensure that we can read stashes exported from
> > another Git version) but I don't think that has to block the submission
> > of this patch set.
> 
> There's a tiny patch for that for the base commit, but you're right that
> some more tests wouldn't hurt.  I can send a followup patch or two as
> part of a new series.

OK, these sound good to me.
