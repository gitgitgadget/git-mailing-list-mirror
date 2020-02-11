Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1E9C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 13:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50E72070A
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 13:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfE0qxG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgBKNkh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:40:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43237 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgBKNkg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 08:40:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id u131so5734893pgc.10
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 05:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6cW6YfQdymMN1eDkG0CPIA+nwOtGmZ3pronI/Q73cGM=;
        b=vfE0qxG1F7yzT1TkzaPXgSkrResaC6WRR3byZPimjW9hO3k8SfIhMV0tcvQ3dbPYYq
         hoLCDSlmZrQ2XyZtmyNX+scTr5nHlFYVfNeXxcNg9Cj2ksiOgCC6nt5pdtbW1qe2vgpt
         wbjKL0Af3oARX4omz3r0wJLCua3rSXPAK/HkwNH00Y8sJRMu/2/JFjsLzd88+e4gSDDR
         WkxIF4dAJzKwEXjg1hMFfnSFOPCgv1tqU+zBgD5BvQasYxsJ36XDa9rawNx5eUYU/RZ9
         XJbm/LRaedHCIjYOfWonarYhz112rH2gXd1/Ja3BWwVwdEE1G0Yv3cmjdkx2Q1BYdb93
         R1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6cW6YfQdymMN1eDkG0CPIA+nwOtGmZ3pronI/Q73cGM=;
        b=pQXaCZaN9MhVRDhmCDTKM8uCp97oifsQsdjwTThcsOr9n5Fr6u1HrSW1PoehOUgENa
         xFftUdOISpgb7nt9XyIKgOpEbXFfhTSeO9rxcqyp4tYyuUt2HlZdBqQLbin7OxPfMtJ5
         uClxZDEo3DUWaTdSbwtqMLGh8iMS0xBf43Xbuu/YBElZvX31EsOAZ1lZvEFjs2unjd9L
         guLKljxiPbBsRCbTfGh05yJawsz+rkKQkVyljDvKFDIvUdFl92jYLhDewcGXZ6bsJLK9
         zKjzvjLwYJPud2BAO2IBpWKUPUnP3qfImpWBEf3ocS4ipMM2Q+q4AmG2CZzfBHm+3+N0
         paNw==
X-Gm-Message-State: APjAAAVAiCmqODpzs5Da+mp3afNpUuV8hPXjDFmM+2aaYSwRRJ2kWtX/
        JgX+ibIkbqUIULLMMGO4GmI=
X-Google-Smtp-Source: APXvYqxc4rIW3PP28wpDp9/Pt+IxPGO7mvZlph1ODzv6xyV9ahpCHKzFQv8TN3rPMbmO82S3DGHmfA==
X-Received: by 2002:a63:583:: with SMTP id 125mr3165840pgf.100.1581428435965;
        Tue, 11 Feb 2020 05:40:35 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id 13sm4178011pgo.13.2020.02.11.05.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 05:40:35 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     keller.steve@gmx.de
Cc:     git@vger.kernel.org, Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: Develop a patch series with git?
Date:   Tue, 11 Feb 2020 19:10:22 +0530
Message-Id: <20200211134022.7975-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <trinity-f39d7ed5-e4c9-45fe-944c-b5cb101cfdcd-1581412940557@3c-app-gmx-bap62>
References: <trinity-f39d7ed5-e4c9-45fe-944c-b5cb101cfdcd-1581412940557@3c-app-gmx-bap62>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Steve,

> My question is whether there is git functionality to replace quilt.
> Or is the combination of quilt and git common?

I think we can use interactive rebase[1] as well as 'git am'[2] (am = apply mail)
to apply a series of patches from a mailbox.

In the case of, let's say a dependency missing on your end, you can do an
interactive rebase using 'git rebase -i' to edit your _mini-commits_ which
you will be making on applying the patches to include the dependencies. One
can also 'squash' commits together(i.e. meld multiple commits into one) in
case you want a smaller commit history or you think there is a redundancy in
any of your commits.

BTW, I think that 'git quiltimport' is quite old now right? And maybe even
obsolete?

Best,
Shourya Shukla

[1]: https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History
[2]: https://git-scm.com/docs/git-am
