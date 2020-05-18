Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0ADC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2747720674
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgERQTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 12:19:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50785 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgERQTe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 12:19:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id m12so125739wmc.0
        for <git@vger.kernel.org>; Mon, 18 May 2020 09:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihnyjaUdtcoEbT/07vBlOP8K6/TjAmCot+vw4B0ijaQ=;
        b=FvlWDuJ05YJ7K+0rwT4ySc7CWnMzwkCOeOcSeQmXgS5gWegOfS8/+1z+v/DUgT5fCH
         SWMo0sT0DsZQR+LumdCXfjpmPXF77jCw2JyH4kkDszuoc877Q8VDbUt8qYQ95a1r1/vL
         q94asFzBcwBVkLBiToFwmcxKBNM5m8ulKzDYlFN8eluhf47qfJlwa7GIIjiE7dUA6aG2
         8yL3SkooS4shDl2E0xEccOPJ54U+HlxzRhvNyyNHwJ12gvGTxjnvFryYvK/KR/RJAWa9
         6XKWjIt6luDBnTlCdVjVfLfaGRjRIP5KiIXirl6vG3JFXjf1ClaZuP1Il/PwT8i+ucC9
         +RKg==
X-Gm-Message-State: AOAM530JRRYrKtRvTjXSw9nEJNkeTPBR1I/kjbBG7zqTrX33/BbA/rpW
        xC1Xhc9Jg2m0vig05XE8avtIKuS1XGJHv2jTr+I=
X-Google-Smtp-Source: ABdhPJxkfDGvoZ3elAdR5SOc7a8l6RVoAF8uSwKWObT5WzqZVW4HuhqQnyKMcJR5i+5z3J/jOVcOrei9mre/OHpJfyA=
X-Received: by 2002:a1c:2702:: with SMTP id n2mr132670wmn.107.1589818771896;
 Mon, 18 May 2020 09:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200515155706.GA1165062@spk-laptop> <20200515233130.GC6362@camp.crustytoothpaste.net>
 <xmqq1rnk923o.fsf@gitster.c.googlers.com> <20200516173828.GB34961@spk-laptop>
 <92cb6302-09a8-6780-9398-890b1e766680@gmail.com> <20200516194033.GA2252@spk-laptop>
 <20200517021452.GA2114@danh.dev> <xmqqlflq7fyd.fsf@gitster.c.googlers.com> <20200518094021.GA2069@spk-laptop>
In-Reply-To: <20200518094021.GA2069@spk-laptop>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 May 2020 12:19:20 -0400
Message-ID: <CAPig+cRNCdtK9SSMSXj83tTCV1n+YW3-a0EnfM_VVVCry8rXCg@mail.gmail.com>
Subject: Re: [PATCH v5] diff: add config option relative
To:     Laurent Arnoud <laurent@spkdev.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 5:40 AM Laurent Arnoud <laurent@spkdev.net> wrote:
> The `diff.relative` boolean option set to `true` show only changes on
> the current directory and show relative pathnames to the current
> directory.
>
> Teach --no-relative to override earlier --relative
>
> Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
> ---
> diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
> +check_diff_relative_option () {
> +       dir=$1
> +       shift
> +       expect=$1
> +       shift
> +       relative_opt=$1
> +       shift
> +       short_blob=$(git rev-parse --short "$blob_file2")
> +       cat >expected <<-EOF
> +       diff --git a/$expect b/$expect
> +       new file mode 100644
> +       index 0000000..$short_blob
> +       --- /dev/null
> +       +++ b/$expect
> +       @@ -0,0 +1 @@
> +       +other content
> +       EOF
> +       test_expect_success "config diff.relative $relative_opt -p $*" "
> +               test_config -C $dir diff.relative $relative_opt &&
> +               git -C '$dir' diff -p $* HEAD^ >actual &&
> +               test_cmp expected actual
> +       "
> +}

Let's move all the setup code into the test itself so that a failure
of git-rev-parse will be caught. For instance:

check_diff_relative_option () {
   dir=$1
   shift
   expect=$1
   shift
   relative_opt=$1
   shift
   test_expect_success "config diff.relative $relative_opt -p $*" "
       short_blob=$(git rev-parse --short $blob_file2) &&
       cat >expected <<-EOF &&
       diff --git a/$expect b/$expect
       new file mode 100644
       index 0000000..$short_blob
       --- /dev/null
       +++ b/$expect
       @@ -0,0 +1 @@
       +other content
       EOF
       test_config -C $dir diff.relative $relative_opt &&
       git -C '$dir' diff -p $* HEAD^ >actual &&
       test_cmp expected actual
   "
}

Same comment applies to the other new function added by this patch.
