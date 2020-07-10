Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B85C433EB
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 12:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4A82082E
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 12:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyQBwxoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGJM0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgGJM0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 08:26:07 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15311C08C5CE
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 05:26:07 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id r7so1185214vkf.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 05:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Imqki9IKOiPGQrRJSBIZW7NKyQK/W7gGchopv7shvGM=;
        b=qyQBwxoc8Yip9vdqXjlIzzlGu+XO6AnmE9OZck6nJb3h6GJG428lyKRF/oQ3wvCM5P
         iNEOBGCLkwprfxVR3wEZVGPMDZS5sl/aGbFWWDwO+qDP1whmimfLcA3t1gQGzZNVETbO
         oxK4d3j/CZCjMK5cnEvHHGYncJ5q3I1W+HXHvfKvRJM6sG5DE29Q451vpCCpuFw4Zxmw
         D1KXwRIC1k1pmkhqA5KxurwnV1oWzZIKcowXDeld/5johT1VuPJCfr2vE3Crgi+QNev3
         23ZtGuNaI0C603N+N0vIkKYEmitFEr8YzFZwJC+P20OR4kZKGga5e6soesrvcHQ91K6L
         iSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Imqki9IKOiPGQrRJSBIZW7NKyQK/W7gGchopv7shvGM=;
        b=ED5TTvdc9jjCN9SVskniLf3XA5V1oP5Q3eDLbmvqWFr0WcwKGuiTAKeRo1daWoK5CV
         vPgkQqwgudGv33/BTUdlljaAwuSQzCnjOAOEBb1aCmvAPOJHNlgxlvdh3e1BKMk9NDHE
         KAcGn6U43weIz8BKWYN77pJd/+GosK/xNU2VqNAj9EbXLlM2wFwc5hRcMl1tjegYezr3
         sPsI9Urweq2wSDKea+59yFcrN90VGLwQmSJIZnfN2NP0Hyj8JSELjzpz69W/02jXE82k
         D5f3AXbhp0WFVtM2QRMVtvUZ+KpVuKvLUvP8tUl7GKNi1jBzRJMPih+FkCAju4PyoKso
         LByw==
X-Gm-Message-State: AOAM530FCqNPfMuspOXk8+znr1mB56XnSgimuSG2eipfZgnld3uL0YRu
        6bdQSZmMV9qjuAIO6Mf44Q4McrT0E2TBvoTvu+1T+iFwQq0=
X-Google-Smtp-Source: ABdhPJxo/6WJzq4N2Uzt3CPk0eKZmplEa2YjLVjPphUbGiB2mZoecZocgCsLoCVT9IRg0dg1pkQ/mKTV6sjvlldbMLU=
X-Received: by 2002:a1f:a883:: with SMTP id r125mr37243303vke.29.1594383965370;
 Fri, 10 Jul 2020 05:26:05 -0700 (PDT)
MIME-Version: 1.0
From:   Tom Browder <tom.browder@gmail.com>
Date:   Fri, 10 Jul 2020 07:25:29 -0500
Message-ID: <CAFMGiz97fcw_nvaa=Xo-roTtB1o25qO06=PHGSrBzv4k_zGqaw@mail.gmail.com>
Subject: "git rm" could be safer and have a better help msg
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I often need to remove a file from Git but leave it as is, changed or not.
The only safe way to do that as far as I know is:

    $ git rm -f --cached myfile   # many thanks to @jast on IRC #git

The "git help rm" command yields copious information but nowhere can I find
a clear statement about safely removing a modified file from Git without
removing it from the file system.

I am going to create an alias to help me, but I believe the brute force
removal should be a different option, say, '-F' ('--Force'), and the
existing '-f' ('--force') ought to be safe operations as far as the file
system is concerned.

Best regards,

-Tom
