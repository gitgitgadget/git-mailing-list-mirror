Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C9EC2D0CE
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD6C2071E
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehCA29nm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAXV4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:56:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36702 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgAXV4d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:56:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so916122wma.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lTCTjDc814IzWs4aoSeTV/5G7iu/Hhuy/CgON+FXdL0=;
        b=ehCA29nmvsbxcHBJCNbYu1sN5MQj5B1o706WUXs6YvU7cje2zEm91ldfOuKFvJQ4tC
         QAeKK+LKpH+76dJ5G4jA3NGuap0RklCooJmq30VHtUZCTl9zYPYgPi+VAP1kvNDirbec
         eSfxSXYJ6cQYW3TXBr5W8BhtUfDPFUfvrU/X/G3ypFwF0VPmg9u9mvqzdP5if12Xb9c3
         pFGOdlHgGKDFGJ9qbvhtsMmBpAnamP3KkXIsW1YNPWo0VPIWGlyItvX4tnSMH+cEw86s
         n3J8IDP7k0D3ul0GS2d3Z3hpgjtTdc90GO1ej9VpqqC1vgOl5F6+lMt3pvEih3pZClMh
         DHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lTCTjDc814IzWs4aoSeTV/5G7iu/Hhuy/CgON+FXdL0=;
        b=P3+pdmuA5vaO1x0IBpawX174rUddoVQIEmj37PLEwUkpfZdDHzEtmBl3uOuK9AJK23
         f5MEip5BouRQDWpBSehZTsCOVpHJza7/VMbDs2eruxvI4Nvz1Eg1aFOeqscvCDc2JW3n
         Ckn0V7rLh14oHOOh+T3t0JrMNurfI3ud9qE85lMq0uvBFPnzZkfvZbaie42GJ5YGCBTt
         7KX8tvFTTyLux32uVpF2GJV09Av5Jq3OgGJvWZd+S2IbN+Yzj/HLXX+2rjlTiQ5EYcPl
         snyTx6gK0QSnxhzidnKc5MILDyT144tB3oodLeIOhUjjO7wYw4uZw2PJRNeeNJbsqhlY
         VobA==
X-Gm-Message-State: APjAAAXhQptFQ1ivngcSg3LkwLY9WLen1uDC+rZmvi9i2+wKR5jnqYaW
        CkiomMDpLfUe+Kk33gu9dA0=
X-Google-Smtp-Source: APXvYqz21vU6VDGxEoa1rY0kDsHB8NM75MQH9kiP5V2bXHs0qERCZ7Pq0kiYhw5mep+a5P1o2nLCdA==
X-Received: by 2002:a7b:c622:: with SMTP id p2mr1093387wmk.94.1579902991840;
        Fri, 24 Jan 2020 13:56:31 -0800 (PST)
Received: from szeder.dev (x4db61038.dyn.telefonica.de. [77.182.16.56])
        by smtp.gmail.com with ESMTPSA id g21sm8267956wmh.17.2020.01.24.13.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 13:56:31 -0800 (PST)
Date:   Fri, 24 Jan 2020 22:56:28 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7] MyFirstContribution: add avenues for getting help
Message-ID: <20200124215628.GI6837@szeder.dev>
References: <20200124210148.220007-1-emilyshaffer@google.com>
 <20200124212602.74194-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200124212602.74194-1-emilyshaffer@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 24, 2020 at 01:26:02PM -0800, Emily Shaffer wrote:
> With https://lore.kernel.org/git/20191114194708.GD60198@google.com/ we
> now have a mentoring mailing list, to which we should direct new
> contributors who have questions.

Why should a supposedly "open" open source project direct new
contributors to a mailing list that is not openly accessible, and even
reading and searching its archives requires registration?

