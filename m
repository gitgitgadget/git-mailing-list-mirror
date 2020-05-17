Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7FEC433DF
	for <git@archiver.kernel.org>; Sun, 17 May 2020 07:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5AC206D5
	for <git@archiver.kernel.org>; Sun, 17 May 2020 07:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqlKp2uL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgEQHoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 03:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgEQHoi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 03:44:38 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D62C061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 00:44:38 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v63so3256755pfb.10
        for <git@vger.kernel.org>; Sun, 17 May 2020 00:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=pdsVChJYAP5r0lrSP6y6Ui0a2of4S39EPNwMRDNsAHM=;
        b=PqlKp2uL5Wku1/AT6o3DCiD4ZNmseJ1ztT/n0fidHoDnflYn6JG0zz0vF/MyecSmeh
         HPjFfRNvYklUBfERxfEWsHFdLTx+2LdCdx3FGXVIJH/sTVPgPsk8fsfpUC18EeNc7yYV
         XEyIrOp8enWj2J35+l6CldJXR9FVrHm7AdoYmC6YHGx/K1X3ycQ2IVgTI9KDA3qY84kN
         euIqJWWmThRrGUWpBKNrMY8EEAHdJZxXAbvdksknYHMMEOX4Ys4oAmrAMuz3Rec/14rF
         Io7JhdkVUORr/eYR+j1/L+SSiXImUmtriPg+x8w3ZLLHp5VbHrCRi9D61WowY5JNaTuI
         mC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=pdsVChJYAP5r0lrSP6y6Ui0a2of4S39EPNwMRDNsAHM=;
        b=gd1QR/nHaA565tnISZklzK+Eb9hNS6ZM6clBHmQPFIuLEL1yKnCAG+3AX+ciy6cRbN
         k3WX7Po7rwnosKCJdxU7PpFWHupbeB/4gFumg1ngUajfbvs4A/Q87m/AXf658hSfEaSV
         4sG1O9oYxxKXyvE0ebA8UnCUI2JNYpSMkjkt7slNFRfNUiFYL20ARbC+iM5Cxn1qQRXC
         nwdkkWZPy0Gq/ArsCcP1o6L3jgmCEqpFk552hdDex9mh8aAKLrASntmNif0DXMrhYsut
         2fLDrVmsS7b84Q9eK8oPVbpKdjFA48Kw1eIFIny64zEzoTemudZSjZmqre0Xuyx8+Q68
         71ig==
X-Gm-Message-State: AOAM530L5S43nMxXXLfpm3U8c4lI/i3dnH53jmNh4TWQsfO/OH90fOSy
        D2Kv+F3tP0XKzuz/jF1YeZIrQKV+j3o=
X-Google-Smtp-Source: ABdhPJw8f3ScCBRbWeeyiEu/yDpvLjY71HOL4MTEns3VKJ5kQXy78dIW+v919BJnNVXo8/vvrE95Vg==
X-Received: by 2002:a63:145c:: with SMTP id 28mr9728993pgu.77.1589701477918;
        Sun, 17 May 2020 00:44:37 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:1c:9c42:c40:e2b6:f2aa:f55d])
        by smtp.gmail.com with ESMTPSA id w21sm726920pfu.47.2020.05.17.00.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 00:44:37 -0700 (PDT)
Date:   Sun, 17 May 2020 13:12:58 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Kenneth Lorber <keni@hers.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] various documentation bits
Message-ID: <20200517074258.GA1381@Abhishek-Arch>
Reply-To: 1589681624-36969-1-git-send-email-keni@hers.com
References: <1589681624-36969-1-git-send-email-keni@hers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589681624-36969-1-git-send-email-keni@hers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Kenneth,

On Sat, May 16, 2020 at 10:13:38PM -0400, Kenneth Lorber wrote:
> From: Kenneth Lorber <keni@his.com>
> 
> This started as an effort to understand this section of config.txt:
>   When inventing new variables for use in your own tool, make sure their
>   names do not conflict with those that are used by Git itself and
>   other popular tools, and describe them in your documentation.
> and grew from there.
> 
> I don't expect this to be adopted as is, but I've found it much easier
> to discuss something concrete rather than an abstract "this is
> incomplete" or "this is hard to find."
> 
> Cut from master.
> 
> keni (6):
>   Tell the glossary about core.hooksPath
>   Add bit on extending git to Hacking Git
>   Add namespace collision avoidance guidelines file
>   Include NAMESPACE COLLISIONS doc into gitrepository-layout.txt
>   Tell config.txt about NAMESPACE COLLISIONS
>   Add NAMESPACE COLLISIONS reference to Hacking Git
> 
>  Documentation/config.txt                      |  4 +-
>  Documentation/gitrepository-layout.txt        |  2 +
>  Documentation/glossary-content.txt            | 10 ++-
>  .../technical/namespace-collisions.txt        | 86 +++++++++++++++++++
>  Documentation/user-manual.txt                 |  9 ++
>  5 files changed, 106 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/technical/namespace-collisions.txt
> 
> -- 
> 2.17.1
> 

Some general notes about your patch series:

1. Conventionally, we prefix the first line with "area: " where the area
is a filename or identifier for general area of the code being modified.
It's customary to start the remainder of the first line after "area: "
with a lower-case letter.

For example, your commit titles could have been:
- doc: tell the glossary about core.hooksPath
- doc: add bit on extending git to hacking Git

and so on.

Check out SubmittingPatches for more information.

2. We generally don't have a line like in our patches:

> From Kenneth Lorber <keni@his.com>

Between the author information and the signed-off-by, it's redundant.

3. You could probably join the patches 3 to 6 together. Or maybe
introduce namespace-collisions.txt in third patch and add references in
all other files in a new, fourth patch.

Thanks for the contribution!

Regards
Abhishek
