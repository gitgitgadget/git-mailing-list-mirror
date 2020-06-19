Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8577C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816CB2080C
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuQBK+cX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgFSNBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgFSNBC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 09:01:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31890C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 06:01:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s23so4397872pfh.7
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 06:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=74ADLmi2ClfgJUJ9o/MAQV+gCOEEk7wBHw/8ROWeWTs=;
        b=QuQBK+cXw2Yw0yHTpNBtPz30xZQYqihH7NJrq6+GHqa1Tx8kD0clDQwfx4MVPdwNq/
         69Gx4AyJPozH87cN9zhLHCReEoZ12xhbaiIwjtPdu7Z/QGs1oWlq3kSXwT1KJVf9E1P0
         LUCwoNzUApsVPc/QtjEjrac1VnGxYch5l1YMy7b7lgMFWnCIrmKi7MKIBGr1hPzSdUKV
         AcjK/pXPF6Ger8zXB3VXdoukKMGKf9hyUEjQri4W6jXhsCdj4fytM9P9vi73T4naCOVA
         LKsRWmyd1BbS1t/2BETmW5XENqE+MkV1yzKONQI91Urct3N5XEWv7e3yOoOl4t2A/wzZ
         au1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=74ADLmi2ClfgJUJ9o/MAQV+gCOEEk7wBHw/8ROWeWTs=;
        b=tDWI8WlMJPyC1IhvYjz8/RkQrjtQkEiZdc+80r6LOJMnoTal1f6yNTAOQRNXPA6rtN
         JHBXPDsb72VlwV39ivUvBv1pqMiM7sT4WNQJhL8N1jVpa4/SGglwuo5sjeFY6G7MrVCo
         PBpnuhQq7DT+oCDmHm56ngiqcnYkmnSjpc6MQtThPmSBk61le3XNQb2JiSnNRqbJRZNI
         gIAS1mlYDEVMjbnovV38MdBcrddMdsXN7HBUifhkpMb7+YNy4Y7DqBHZ9G6yxh+UjW2K
         4kgaZ5zeftr1U3sYQFiGUgTUXDyGg+hHL7rXs++ECmTTgUgi0PuFT9Fj4GPto3HuV1dT
         65Ig==
X-Gm-Message-State: AOAM532kxA1V4nzBOB0VhDM6BIkb9hD2swDXkRN2pb6imwRRgKMHbMmf
        1+wC1iVMLU0GIAzaheXhdkQ=
X-Google-Smtp-Source: ABdhPJyPcOlFuBkIswcUzXNbOYvx45CR8YM8p2QnCqn6VUopB81fluhYA2KGPizEHuLf4Gr06yPkDA==
X-Received: by 2002:a65:534d:: with SMTP id w13mr2897970pgr.18.1592571661650;
        Fri, 19 Jun 2020 06:01:01 -0700 (PDT)
Received: from localhost ([2402:800:6375:a18c:ce1a:d70b:8a27:2927])
        by smtp.gmail.com with ESMTPSA id q1sm6379711pfk.132.2020.06.19.06.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 06:01:01 -0700 (PDT)
Date:   Fri, 19 Jun 2020 20:00:58 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     git@vger.kernel.org, msuchanek@suse.de,
        Till Maas <tmaas@redhat.com>
Subject: Re: [PATCH v2] tests: do not use "slave branch" nomenclature
Message-ID: <20200619130058.GA5027@danh.dev>
References: <20200619093210.31289-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619093210.31289-1-pbonzini@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-19 11:32:10+0200, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Git branches have been qualified as topic branches, integration branches,
> development branches, feature branches, release branches and so on.
> Git has a branch that is the master *for* development, but it is not
> the master *of* any "slave branch": Git does not have slave branches,
> and has never had, except for a single testcase that claims otherwise. :)

reading this text and the change may give the impression that this is
used for feature branch only.

I think common terminology in Git's test is this kind of branch is side.
In this inaccurate comparison:

	git grep -E '(branch|checkout|switch).* side '
	git grep -E '(branch|checkout|switch).* feature'

The former yields more result than the latter.
The latter shows only t1090 and t3420.

If I were writing this patch, I would go with the former.

<xmqqr1umg8fp.fsf@gitster.c.googlers.com> seems to prefer side, too.

Other than that, the patch looks good to me.

> 
> Independent of any future change to the naming of the "master" branch,
> removing this sole appearance of the term is a strict improvement: it
> avoids divisive language, and talking about "feature branch" clarifies
> which developer workflow the test is trying to emulate.
> 
> Reported-by: Till Maas <tmaas@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  t/t4014-format-patch.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 575e079cc2..958c2da56e 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -81,16 +81,16 @@ test_expect_success 'format-patch --ignore-if-in-upstream handles tags' '
>  '
>  
>  test_expect_success "format-patch doesn't consider merge commits" '
> -	git checkout -b slave master &&
> +	git checkout -b feature master &&
>  	echo "Another line" >>file &&
>  	test_tick &&
> -	git commit -am "Slave change #1" &&
> +	git commit -am "Feature branch change #1" &&
>  	echo "Yet another line" >>file &&
>  	test_tick &&
> -	git commit -am "Slave change #2" &&
> +	git commit -am "Feature branch change #2" &&
>  	git checkout -b merger master &&
>  	test_tick &&
> -	git merge --no-ff slave &&
> +	git merge --no-ff feature &&
>  	git format-patch -3 --stdout >patch &&
>  	grep "^From " patch >from &&
>  	test_line_count = 3 from
> -- 
> 2.25.4
> 

-- 
Danh
