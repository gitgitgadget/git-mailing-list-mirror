Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83DB320248
	for <e@80x24.org>; Fri, 12 Apr 2019 18:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfDLSqv (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 14:46:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35611 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLSqu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 14:46:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so13197381wrp.2
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 11:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNzHEizVq6pjjvy8Nt9gSbW746gfoVaWGFUMlB0a0xw=;
        b=Z2798SOYRtfB4UgiFa6G+GBQIf50WU1MExqiSTQb6hGk4velNMqbvUYikaqDRbhyNy
         ax0SxJycDAtSZTjwBmtgD/e/RSTg+8XSk2fIN/UoBeePDhPq9WPEb+6jxxLYBFmpTJsS
         XJtMp5PFvKRb6W0a1g81PqGGzomxe2umY4td/YZ9QAddsz90ZdBXOTJoWF7Hnrf9E1w8
         6M/qQpig7K6FJnyA9dEESw+XkXVF47jG+nmPvqs5IG6DtWDIWM+Qy4a7OLlV68iZlKU4
         o0TP8FIZ1MAbd8uLTMyk09V2B7ONM+BETroMmQminey8TtLbYbJQ4UCjHOhhFlsKrhjG
         XDKQ==
X-Gm-Message-State: APjAAAVRC5iqdh9eoQEGdkFPr1ffd9CGluuCFH3ArSNBAH5wu+VyYony
        VQ3PyqLwuU4BiH9hsH6jWVEAnpCXgfySIT3eT2s=
X-Google-Smtp-Source: APXvYqyyRLfPWFJVKMvkrMbcX6GgCVPKHOkV7Ks+Ks8rnR95m/jwlb/Zeiw9a6h7x1vTjR4BY3X+xlmjsD2jUGz+6GU=
X-Received: by 2002:adf:eaca:: with SMTP id o10mr1433410wrn.273.1555094808848;
 Fri, 12 Apr 2019 11:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.168.git.gitgitgadget@gmail.com> <31d8e43cbfaec36f662006a711b64bca47009e59.1555070430.git.gitgitgadget@gmail.com>
In-Reply-To: <31d8e43cbfaec36f662006a711b64bca47009e59.1555070430.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 12 Apr 2019 14:46:38 -0400
Message-ID: <CAPig+cTiF-9+pXnx19y0PUs3Nwek7N2cEg2r2jAPzEXPTvpxpA@mail.gmail.com>
Subject: Re: [PATCH 4/7] docs: exclude documentation for commands that have
 been excluded
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 12, 2019 at 8:00 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When building with certain build options, some commands are excluded
> from the build. For example, `git-credential-cache` is skipped when
> building with `NO_UNIX_SOCKETS`.
>
> Let's not build or package documentation for those excluded commands.
> [...]
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/Makefile b/Makefile
> @@ -2455,22 +2455,25 @@ $(VCSSVN_LIB): $(VCSSVN_OBJS)
> +Documentation/GIT-EXCLUDED-PROGRAMS: Makefile config.mak.uname
> +       $(QUIET_GEN)echo "EXCLUDED_PROGRAMS := $(EXCLUDED_PROGRAMS)" >$@

Should this rule also have a dependency upon "config.mak.autogen"?
Perhaps like this:

Documentation/GIT-EXCLUDED-PROGRAMS: Makefile $(wildcard config.mak*)
