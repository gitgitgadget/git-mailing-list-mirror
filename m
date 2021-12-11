Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A281CC433EF
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 03:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345712AbhLKDsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 22:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhLKDsb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 22:48:31 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CCDC061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 19:44:55 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so10787542pjb.5
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 19:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W85i9I3wbh+TiPw3ML6T57IxwRPzrv+xUQ+FdWt+K8g=;
        b=GkzOSLV0rK9rSiEGPjMyIwgc1T2scpVsOZgBt+Tyo7QYZdK0JYAmjBdZgybHMJg6cf
         XYyaFEBOgOr4dAU8E0lnvSSOX/xtWOQENc/OaIwdHIFEzwFVwape82a+385NoM+X78bp
         ic8UhwoLOk0FCCBNcxHXm8X2mQyueDIXbeeEO/2vTDxWW7NIYixzAAmvt0LMYmCcthyK
         H+Rn5nS8uwfHqNNLiK1sweJxiNgvpBnKmJo34iyIRQSd6BnJWFtxkGOvPPpPG5SQb5a6
         xvhYawYayQ6N5MGY2gog/UJweinwnGHTFlgDLLnbpiT50ozn9F2jOknGiCMbr2UuGcw+
         5lMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W85i9I3wbh+TiPw3ML6T57IxwRPzrv+xUQ+FdWt+K8g=;
        b=x/qVO5CkInI3p1/ja8R+Y7joR0Gn/h+9702rtiOoUSq1LSQmw3me6LELO6PNPTDWft
         mw8TAsjes676WaaJqAMXy9YdbJV//FI1RUJynttLbuumnGm2P6pbN6owhY87kWwe+5rA
         zE0T4BuIFuy2VjwqJOrwp27ugL+6i/jU1BegbfMf/VaY5m4rgPYAFnKXybOTBJF5A9cH
         7iPdiaSdqrUz2jodHfrjqQI5mzpPrEpYPR7yDZ03GpSX1qQ59j6NwEUjCLV+4WKD7T+P
         ISCPoL8EIxpHtVy9Z8wWaoLoVObVDQuGgvJ9HuTW9/BlOOGfuFWvwT5NkXKgODr8bJtZ
         +H9Q==
X-Gm-Message-State: AOAM532dTU7N3RjHGhXP2Ih1TXkkIB+6x068+HNmBXuaU/jhppEmysZF
        6ciMpPuYEO6E6AuBL7wONVnVZ0CbvL8=
X-Google-Smtp-Source: ABdhPJzUWZB68gP5lIMQPhXb1nI6Lqdh0Xlu3ukKVYgolQyhK+PftPwC1x3gMR0raQO742mJmaKLEw==
X-Received: by 2002:a17:90a:fe87:: with SMTP id co7mr28224597pjb.21.1639194294821;
        Fri, 10 Dec 2021 19:44:54 -0800 (PST)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id t38sm4764623pfg.218.2021.12.10.19.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 19:44:54 -0800 (PST)
Date:   Fri, 10 Dec 2021 19:44:52 -0800
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ns/batched-fsync and ns/remerge-diff
Message-ID: <20211211034452.GA15683@neerajsi-x1.localdomain>
References: <xmqqilvvluoa.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqilvvluoa.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,
I'd recommend dropping ns/batched-fsync from 'seen' since it will be pretty much rewritten on top of ns/core-fsync [1]. I don't think there's value in looking for conflicts or testing the current version.

Also my understanding is that ns/remerge-diff will be dropped in favor of an updated series from Elijah Newren.

Thanks and have a good weekend,
Neeraj

1. https://lore.kernel.org/git/pull.1093.v3.git.1639011433.gitgitgadget@gmail.com/
