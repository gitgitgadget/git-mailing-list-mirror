Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EAE91F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503586AbfJQXbo (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:31:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39505 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438573AbfJQXbo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:31:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so4201332wrj.6
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KeDc6PDZqubPUPCmyzn0xp4SX3EYXTVhIGEn6YS4DU=;
        b=d/wRIWy1ToxB/CpjeIqVZ6OaUHO1yErFuk/MYJaFTPlkDKksKk4X9JqJv4mrcVLo0i
         b4ValZPX6HGeDynjCEaYGPWk85zPd4oVCfi3IVxTVf3NmremtH4byauB5k1S9fdzKurX
         EE3mET1FNVx2AfLLwQiKkYMeoW5tT9POWK62rMAe0MQrpatl1X28/xt1zJGdyEzHhWm5
         hThpP+cNK3o+cqCG+/JV6cRAVCGxNifx/Y1XQIa3B/2/TbunODElHoP0McbDU3rS7BPl
         wXlpMSfBvvxpl2Npijum4h5qsU81beXQoM+gsyrimBRV4R5IFKCoGOCgMC+ZSOkiHwwN
         Ynog==
X-Gm-Message-State: APjAAAWfb2RmGeY1Z1hV9LuZT689GsPu7v09k8/puNrTomMSCxqe3qnZ
        QtknnRIoaOC1msd9aD+ViOHcBaQuT+ji3GbSwhM=
X-Google-Smtp-Source: APXvYqwzu3hdRKMFP2R5TT0sMsm9Y3APb0/80zH0wAl9f0jVJTpZd5oOpAqEM35+ifNk8+WR2GtayqznXSU5gAA+0CA=
X-Received: by 2002:adf:e8c6:: with SMTP id k6mr5137990wrn.78.1571355102629;
 Thu, 17 Oct 2019 16:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571354136.git.liu.denton@gmail.com> <d6b74c5e58d9a45ca8b915ba699cafe08f300723.1571354136.git.liu.denton@gmail.com>
In-Reply-To: <d6b74c5e58d9a45ca8b915ba699cafe08f300723.1571354136.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 17 Oct 2019 19:31:31 -0400
Message-ID: <CAPig+cT5Xp_=QG9965_Nmdo2kbt3wnDGb9J0Nwt3-xkYGb0jBQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] t5520: replace test -{n,z} with test-lib functions
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 7:17 PM Denton Liu <liu.denton@gmail.com> wrote:
> Instead of using `test -n` or `test -z`, replace them respectively with
> invocations of test_file_not_empty() and test_must_be_empty().
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> @@ -206,15 +206,18 @@ test_expect_success 'fail if the index has unresolved entries' '
> -       test -z "$(git ls-files -u)" &&
> +       git ls-files -u >unmerged &&
> +       test_must_be_empty unmerged &&

A better justification for these change (and all others in this patch)
is that the original threw away the exit code of the "git ls-files -u"
invocation, whereas the new code takes the exit code into account. The
commit message perhaps instead ought to focus on that benefit.
