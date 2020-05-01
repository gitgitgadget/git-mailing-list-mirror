Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDEDC47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 08:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0560B208C3
	for <git@archiver.kernel.org>; Fri,  1 May 2020 08:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgEAIuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 04:50:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40577 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgEAIuD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 04:50:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id u16so5620929wmc.5
        for <git@vger.kernel.org>; Fri, 01 May 2020 01:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0eNTcuV2OeL6uy+iJy4AO6uDSFZuGZH9dJKtnVr4JI=;
        b=bMo65jXyqGuQ9Djdf7TnGJx4rMP7OWgfYGuIUhZqx00fWwrmlv9Z4109dO09mOpyeH
         YJUmvgH6C+0fvaUMUODUL+YI1aFZEmwr3efweJuz089b10S0Yr4VPqvDbOQNGiqWnhI9
         oOXuQ8o9nMK5CmvTNcbJL/9MKEM6Km1VwmoqC7NMLOWb7bMu466NxFA+N1FC3A5KwPdZ
         zvelJ920BH+OS7Y69lUCQNAL5mnD3et4HnnQ5B2xsQCGaFCWKBm4O9ouQm3VCZFtwloU
         ocnJ0DhocXP7pc6cv9Y8aaVmvyvNmZHCPk8VTDdY7ya2wFkTPzlxub08M/Q3GcQ5B6PA
         2LSA==
X-Gm-Message-State: AGi0PuZ0joW3rjQzAAX7JHa+8nLZxpmRqKt5U8DZtWoFaDf1LZ6f5Ksr
        Nxnb7onZhIgfMUgy4no+JnwhU9XO1EscSO4Kf0lTkQ==
X-Google-Smtp-Source: APiQypLJQ6qqmnN3DJL5N72ph3DcrtD4jaDZ2X5fGEtKM+n22SLMmkVtmpKHZTZOs6X1UMo6w3HCvCoZs0Xa+Z6fvI4=
X-Received: by 2002:a7b:c213:: with SMTP id x19mr2824859wmi.53.1588323001687;
 Fri, 01 May 2020 01:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200501082746.23943-1-sunshine@sunshineco.com> <20200501082746.23943-2-sunshine@sunshineco.com>
In-Reply-To: <20200501082746.23943-2-sunshine@sunshineco.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 May 2020 04:49:50 -0400
Message-ID: <CAPig+cR4VpyAzqok8+QoUgQQc=mS-ooD8+PUCPMuO6XQ21dL6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] restore: require --source when combining --worktree
 and --staged
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?SGFycmkgTWVodMOkbMOk?= <harri.mehtala@finago.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 1, 2020 at 4:28 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> @@ -1604,6 +1604,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>         }
>         if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
>                 BUG("these flags should be non-negative by now");
> +       if (opts->checkout_index > 0 && opts->checkout_worktree > 0 &&
> +           !opts->from_treeish)

If I re-roll the series for some reason, I'll drop the unnecessary ">
0". (But this code goes away in patch 2/2 anyhow, so I'm not too
worried about it.)
