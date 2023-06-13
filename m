Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57DCEB64D7
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 22:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjFMWTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbjFMWTl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 18:19:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D4E1BE3
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 15:19:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6664a9f0b10so29946b3a.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686694778; x=1689286778;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8PbHxQxo6hoKkc0yMvcGXq2xteKS3vZIAadbbU6MRk=;
        b=mxvW8+grBv3yMBweg4GpDBaq3TG+cR1T/8htD88AqLJe73vqoHOf8/n79Y9SR4DZLk
         oEGAdHTDAMZ7WQebAE/7XDsXeI4GpfJeTmabC/VBAhEJmkf+Jk/SeNY7ZbOzMw/RMQm4
         ad9X/cPGGKvn1N2gSCTtXZtDXhlvLxc/g518rYJLOBRpDWyPxdTSM8yovJ9hAhgodAXN
         bHUGk1vPgnl3xlV9rBQc1UPq15OUPL12MFdpDwtCoxD+z6u6l3koYjBo1VGO7iI3Bl8c
         5exb21e6K9h4ynLo2jrS//b4ZcqGYs+ScrvNDCWC7mKM1rg6b5k7gYkUT1Tf4QOsSEk7
         LT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686694778; x=1689286778;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U8PbHxQxo6hoKkc0yMvcGXq2xteKS3vZIAadbbU6MRk=;
        b=CawgrcWvOHqHodpvP0aPoNhFcJNrGAkx/WNLiJTmqBXnd4sov2gLWQonN2xJLSrhCT
         tZ7MgT19OCia+IKMMUcA152UmYJ21aQtXBGVnIXgfqFtgjmRabndLnWIQpHrFBxaKCYx
         qb+4EYetKef3WcgRsActcgg21NHyWTMStrrlUSgg7cp4vx9T84adosM00iGDvit7bijO
         pFcpQSGIdSeDy042P1q24hj4H/CiQ39SsGeQd+uBlWoDyoUTbUj27r/co9anp1Ob9lWy
         9H9I+YjK9AJloNC/rD3I2MTYaXps2/xNRSZbRe086kwAbq602MRF0Xgn9ropvmn/DHxZ
         o0lw==
X-Gm-Message-State: AC+VfDyaOJhgYnVAXcKG4ZeeLQ6AqTeJVkrCyT2AND8+lGCo8udQbJd8
        18Qe4yel7tGjCdbTRySQr6qztpPXtgw=
X-Google-Smtp-Source: ACHHUZ7p4FHfrWbI/2H17nBcWrD3V+lcSvT/oDusV2heN6E7IGy+89Aw2XTvnW6xV+RWZengUMmT6A==
X-Received: by 2002:a05:6a20:432c:b0:10c:9773:5e6 with SMTP id h44-20020a056a20432c00b0010c977305e6mr13826207pzk.47.1686694777866;
        Tue, 13 Jun 2023 15:19:37 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id k4-20020aa790c4000000b0063b8d21be5asm9373457pfk.147.2023.06.13.15.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 15:19:37 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 01/16] refs.c: rename `ref_filter`
References: <cover.1683581621.git.me@ttaylorr.com>
        <cover.1686134440.git.me@ttaylorr.com>
        <afac948f04dca5cd532ceea08fbc646184336311.1686134440.git.me@ttaylorr.com>
Date:   Tue, 13 Jun 2023 15:19:37 -0700
In-Reply-To: <afac948f04dca5cd532ceea08fbc646184336311.1686134440.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 7 Jun 2023 06:40:53 -0400")
Message-ID: <xmqqedmf3szq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> -static int filter_refs(const char *refname, const struct object_id *oid,
> -			   int flags, void *data)
> +static int for_each_filter_refs(const char *refname,
> +				const struct object_id *oid,
> +				int flags, void *data)
>  {
> -	struct ref_filter *filter = (struct ref_filter *)data;
> +	struct for_each_ref_filter *filter = data;

Nice to see that a trivial and obvious clean-up like this is
silently included ;-)
