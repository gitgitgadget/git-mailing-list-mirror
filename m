Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEDFC4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 06:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBF322460
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 06:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyAtgp5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895657AbgJVG36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 02:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508316AbgJVG3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 02:29:55 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3563C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 23:29:55 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i12so550024ota.5
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 23:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+mLo9XaETWce4x6ceMIePE49W5PtEAA5Ken1yx95HHY=;
        b=oyAtgp5BmpEU8z9GMJuEy/JKdMWY9LToSStfH3olmhKD80p4CZ4XfFWhBc5STCiBcg
         yM5Y6qxmr/MrkTC/akj1WG9jfytp50yw/+WDr8FQPF8aXeC1CNPUBhfEZigJ5iS7hv1H
         zA4Kuv9h27qgdWgZKLbJZYqpG0IdR4fCy/PPzpeXxRYybcwOTbH3yAf/66LAXyRMHNhI
         VmX/VkYgFAzTDlb3zP/IoOR+TOgKgv6CT2MPP+MBhKP9QU6O6NJGEXCDHgw0tAPPz307
         6kgxmz2Ymbvw2iJz+gRwaebo+ueCVIIeTjE99DZUdhgm9HDMlc1yoHff6pGB+4NYqJhV
         45jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mLo9XaETWce4x6ceMIePE49W5PtEAA5Ken1yx95HHY=;
        b=dETq4xDWb9FqDxo85LVKL6Z0+X1Dx9apaKxcLMiZwzbI+NX/w2HFKc7kLhvtWlDmLM
         xzhOkxRVvdnT4KPMrNJBarq0Dj7Y/7o83lKDAhTUJVpdvwIs/spYDFR7WWh7VCS7UTMU
         xS6ffzYEFGbxXyZzpENefkXZuGCiU+tNa1hmL/BIfOLMfWqUDPEhVhv3efVCJoxnbdT3
         Im71hia57m8btGkniBxz5tNHzGdteWd667KvuFuV9xAKHKUmqyUsd+X01J2yncVNXM5g
         GCv73WWCBRiIpL2cTffDAtc4uzqI6IJvdABP13IUQsgh9YmLAva5t6Ml2PA1wAPnNFPe
         +HcQ==
X-Gm-Message-State: AOAM530qBAdt9JS8Bqw8WPXrVOUr1Nc/IL6x/ptq7rB4c0b5s0u9cs5/
        A37JHywQVeh7aG2qCHp0RCl/48yOqzQny9TH2yurGJA2Uzk=
X-Google-Smtp-Source: ABdhPJzOU7ylBxbBL1GLLx4PUf7L24qMeQVnPgWdjZTpocRm+8ig+OTLKDpp8v9gdIwMobyHBXfQicvVxJQSCrbk6s4=
X-Received: by 2002:a9d:23a6:: with SMTP id t35mr793946otb.210.1603348195036;
 Wed, 21 Oct 2020 23:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201020121152.21645-1-charvi077@gmail.com> <20201021124823.2217-1-charvi077@gmail.com>
 <20201021124823.2217-4-charvi077@gmail.com> <CAPig+cRzLpY4Pe11SQ0uux-_+x_CSVYM1FvRvDebH3TNi-bVow@mail.gmail.com>
 <xmqq36264xx5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq36264xx5.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 22 Oct 2020 11:59:43 +0530
Message-ID: <CAPSFM5d+GSOTAUiea_6oX-Wdk95b=r6aGY-smia+bDD17i4-8w@mail.gmail.com>
Subject: Re: [PATCH v5 3/5][Outreachy] t7102,t7201: remove whitespace after
 redirect operator
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 22 Oct 2020 at 11:14, Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > On Wed, Oct 21, 2020 at 8:51 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> >> According to Documentation/CodingGuidelines, redirect
> >> operator is written with space before, but no space
> >> after them.
> >>
> >> Let's remove these whitespaces after redirect operators.
> >>
> >> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> >> ---
> >> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> >> @@ -460,14 +460,14 @@ test_expect_success 'resetting an unmodified path is a no-op' '
> >> -cat > expect << EOF
> >> +cat >expect << EOF
> >
> > There's still a space after the '<<' operator which should be removed:
> >
> >     cat >expect <<EOF
>
> Also, this is outside any test_expect_*, which is unusual in
> modernized test scripts.  There are many other instances of
> preparing expected output outside test_expect_* in this file,
> so we may need another patch to clean them up.
>
> For now, within the context of this patch, let's just fix the space
> after the << here-doc redirection operator, as you spotted.  The
> attached I'll squash into this patch.
>
> Thanks.
>

Thanks Eric and Junio, I am resending the patch with the fix of
space after <<  as mentioned.

>  t/t7102-reset.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git i/t/t7102-reset.sh w/t/t7102-reset.sh
> index a8c96bf162..07acaa2beb 100755
> --- i/t/t7102-reset.sh
> +++ w/t/t7102-reset.sh
> @@ -460,7 +460,7 @@ test_expect_success 'resetting an unmodified path is a no-op' '
>         git diff-index --cached --exit-code HEAD
>  '
>
> -cat >expect << EOF
> +cat >expect <<EOF
>  Unstaged changes after reset:
>  M      file2
>  EOF
>
>
>
