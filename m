Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358E6C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 19:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbjELTdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 15:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238565AbjELTdc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 15:33:32 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D548A41
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:33:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6439d505274so6347513b3a.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683920006; x=1686512006;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AoP98DT5RdNU2qX5Jw4tU31RVWTul5T8+euzXcPjkm4=;
        b=XxwhFjZMCWEW1LhNj63gZ6w1gNMunfUoMbA13D79zO0zHfCp83ZMmmatlVZvxteulh
         SIqid2coTPSW94Xyt19Xvhmec46LM21SV9VXpVf02Qp8HLhG5FmRSpDi6BtTUrsiANMF
         UiQOIViohL058LjsKcS4tgsa5HcNOqc0OlkdT9QMbeMKRBUsRLTeWclWhInt8JN60GKS
         qvMIMEb9BaIZQTmv4+jmrKBZueGnG2TNkCNQP3Wmns69dZSNiKrIA5bbcDxtGggLfdxL
         kmFLCXUt98c3yPylgv32xo3dCATC+5ja8b6T6VFcuLJm/cmsoCy8CeDxxvhlQFRnSljq
         j9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683920006; x=1686512006;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AoP98DT5RdNU2qX5Jw4tU31RVWTul5T8+euzXcPjkm4=;
        b=Cb2q++83agEianOmM004FwTNYJ+4v4Q91tDJm+os5RSOz/su5L72v0G0aF5GJ1yHsn
         3dsq5fQfziwTNAPFzjjX+4hVrOUOWI1WFJv9nHkGAxngbFSLD9Ar3D7hNXqUyx736/xC
         UOLiSm9MvXv7V0KcGAkUehiDa5/MXF8EBRxx+pWU/s6IdvxEG/UNXv8TsDkb7MB4P4Iw
         JQQb4A8GUcS8NpW30QiT9sCQ6sKM5BfoW3wrBkPEO3LN3/q5G2p3y78/x3zmDAcv5ywf
         oGTtSZUrBajlyRgM8h8UpokGNRIbyZK03KJmzsWrk33xqPyAoeP4TMigBnY8IVhn0deB
         kprg==
X-Gm-Message-State: AC+VfDzen05b4GKte9NKZWaZqyVkvWm3mKxKeWyCepQ7Y6E7NSai1rTl
        yLQOclI7UNf7ELs1B5k9pJJFaMwUVEY=
X-Google-Smtp-Source: ACHHUZ5w8mYiWOWKou/WRqV2JIxhb/t5VNms2TV9zzCLKkM9b5Y2g1BgoRuJDvgf1czMlTVeTJyO8A==
X-Received: by 2002:a17:903:2452:b0:1ad:bc86:851 with SMTP id l18-20020a170903245200b001adbc860851mr11279491pls.45.1683920005696;
        Fri, 12 May 2023 12:33:25 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903244800b001ac2c3e54adsm8305458pls.118.2023.05.12.12.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 12:33:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: ps/fetch-output-format
References: <xmqqo7mqs7rp.fsf@gitster.g> <ZF3nFaHjOxt4a3ee@ncase>
Date:   Fri, 12 May 2023 12:33:25 -0700
In-Reply-To: <ZF3nFaHjOxt4a3ee@ncase> (Patrick Steinhardt's message of "Fri,
        12 May 2023 09:13:25 +0200")
Message-ID: <xmqqmt29pcoq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> We may add below diff to "fetch: introduce `display_format` enum". No
> further changes would be required for any of the other patches as we
> always explicitly initialize the value already and don't use the
> `UNKNOWN` value anywhere.

Yup, if I were writing this series from scratch I wouldn't have
added the UNKNOWN one myself, but it is so small thing that we can
leave it for those who want to do trivial clean-ups after the dust
settles (it could even be one of future microprojects).

>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 462fc86b99..6583e31e3d 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -49,7 +49,6 @@ enum {
>  };
>  
>  enum display_format {
> -	DISPLAY_FORMAT_UNKNOWN = 0,
>  	DISPLAY_FORMAT_FULL,
>  	DISPLAY_FORMAT_COMPACT,
>  	DISPLAY_FORMAT_PORCELAIN,
>
> I'm rather indifferent though and feel like re-sending all patches only
> to change this one line of code generates too much noise. But I'm happy
> to adjust in order to make your life easier.
>
> Thanks!
>
> Patrick
