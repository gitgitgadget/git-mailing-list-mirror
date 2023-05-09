Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CE3C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 20:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbjEIUnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 16:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEIUnn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 16:43:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C671A199F
        for <git@vger.kernel.org>; Tue,  9 May 2023 13:43:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64395e741fcso6472879b3a.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683665022; x=1686257022;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNkuzOjuhmnt+8JRY7cuCL9UEMQqNjbaXCiUgZQUuoM=;
        b=IPFaAiQvgu+9B/ZqlZFWntYJxmDsq9tq9Mdqei3A0mG/4ljU6K+s/8xNgPQEnCzdia
         YB6P57S07l5AK5noQpqAQZ4lOks3nshAPeMHb8sTEH7OS469Ygs90UA4d4SJ/TOIm/nE
         64MTMptZUx+BCgKdOS0ofuRh4mHX/AcbC1wVJnJRo3GpuSOUUlV4bbv11MNP4WhmcC2N
         TdeyuCqwHtW1T8XX3OtO2hmQn/m+ddQKfuF6pLC1swAsf0sf+exEgsOJcxAMtBgM5yVM
         PMZ9K8+NzGz3spJ8WQ4n0hXQAGV7XBJR8aXX7pzXO+G4Z/5veKF6ZMcmrKZNi4YaDi83
         Ujng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683665022; x=1686257022;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SNkuzOjuhmnt+8JRY7cuCL9UEMQqNjbaXCiUgZQUuoM=;
        b=OTVSU2N2Ef9wrlobzG9tIqYKQSkeU20hwcelIINfFEW20DCLvJeROZIg0yxDceXN3f
         tctwxVe2M1GATTI9+fo8DLrgUICbRtD3wnJhU7C5qtOlD1zdDAbhUvgEih/qHPUHkmXz
         C+tF6fdQQ7s3TqI89mouv5JgoDqhXMJOFHqkHDOEOtfRL3/3uIjAlWG4Lftp+ZmG4JnS
         O5WXCNRFN+ehFW7Pt5vnrO1VYwpatNcxJjqiuisMIYJG5FWgHdkU9QYnbEedGPlVZvcV
         mAsicuICAYA6KrAcyNzH8xt17rSKF916clP9axTm9NzwOUmvYvOxUfyR01actWSdzHtH
         Z/ug==
X-Gm-Message-State: AC+VfDzg51PipAWBwfgcU9hgGoZg2imhBnw5BIUVefYOrl1kXQLpI5TM
        2x066P89wJ4xUahqf5oH+nM=
X-Google-Smtp-Source: ACHHUZ69kmFE6+xvpdSp//bOpJzlGa+bwkHVR/O6NujeHWdZxsoj7gEw3JLYDhX1OZuEWZmHYRN82A==
X-Received: by 2002:a05:6a20:4297:b0:f5:398e:b455 with SMTP id o23-20020a056a20429700b000f5398eb455mr20264308pzj.48.1683665022177;
        Tue, 09 May 2023 13:43:42 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id ku12-20020a17090b218c00b0023a9564763bsm12127790pjb.29.2023.05.09.13.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:43:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4 8/8] fetch: introduce machine-parseable "porcelain"
 output format
References: <cover.1681906948.git.ps@pks.im> <cover.1683636885.git.ps@pks.im>
        <24ae381950249fd5c1cd799b75dda1407495d9d4.1683636885.git.ps@pks.im>
Date:   Tue, 09 May 2023 13:43:41 -0700
In-Reply-To: <24ae381950249fd5c1cd799b75dda1407495d9d4.1683636885.git.ps@pks.im>
        (Patrick Steinhardt's message of "Tue, 9 May 2023 15:02:33 +0200")
Message-ID: <xmqqjzxhw802.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Considering that both multi-remote and submodule fetches are user-facing
> features, using them in conjunction with `--porcelain` that is intended
> for scripting purposes is likely not going to be useful in the majority
> of cases. With that in mind these restrictions feel acceptable. If
> usecases for either of these come up in the future though it is easy
> enough to add a new "porcelain-v2" format that adds this information.

Two steps ago, the proposed log message still mentioned "--output-format",
which may want to be proofread again and revised.

> @@ -1786,7 +1810,8 @@ static int add_remote_or_group(const char *name, struct string_list *list)
>  	return 1;
>  }
>  
> -static void add_options_to_argv(struct strvec *argv)
> +static void add_options_to_argv(struct strvec *argv,
> +				enum display_format format)
>  {
>  	if (dry_run)
>  		strvec_push(argv, "--dry-run");
> @@ -1822,6 +1847,8 @@ static void add_options_to_argv(struct strvec *argv)
>  		strvec_push(argv, "--ipv6");
>  	if (!write_fetch_head)
>  		strvec_push(argv, "--no-write-fetch-head");
> +	if (format == DISPLAY_FORMAT_PORCELAIN)
> +		strvec_pushf(argv, "--porcelain");
>  }

Hmph.  

[PATCH 9/8] may want to also introduce and pass down the
"--output-format=full/compact" option, but that is clearly outside
of the scope of this step.

> +static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
> +{
> +	enum display_format *format = opt->value;
> +	*format = DISPLAY_FORMAT_PORCELAIN;
> +	return 0;
> +}

Lack of "if (unset) ..." worries me.  Shouldn't the code allow

	git fetch --porcelain --no-porcelain

to defeat an earlier one and revert back to the default?

Other than that the changes in this step were mostly expected and I
didn't spot anything glaringly wrong, but I didn't spend as much
time as I did for the other steps.

Thanks.

