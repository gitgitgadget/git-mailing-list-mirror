Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AF2C25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 16:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjAVQKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 11:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjAVQKn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 11:10:43 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D6121976
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 08:10:28 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so13292594pjm.1
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 08:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwpcYhsAKI2TR2Ro47n5trSTff0Z0Degn81otIYAbS4=;
        b=PTyQApfcexvSR2ncHfNud7LYEJpyt+hvIWVoIaRjK8GYXXMATJhWQ8iOOwyY4W7XwL
         +umjwmtxGIla95HGTyh2+HCMTL2UPwAelJkPATlYU0OIJ/+tdxevmSQ17QgqDBCOOBLf
         dECInhKD8/l/DfLa//dIrENEeFRiWJVKfFkxP5QrQVXJqP22Ir6S3hO+E2EsGQGt3WEZ
         O/qmv3vWvbQRX9xukm9B4NKqH1bpFNxuGAFC5FPKXEQpInmAYn3XffAijRGxqj8Zt6Mn
         rokE9FRvWRUzKdmgulytvlBtfnPBzoFQdxA3N/wC8fVMv1BGczRFAlf6o1oii5JJU5HX
         btXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mwpcYhsAKI2TR2Ro47n5trSTff0Z0Degn81otIYAbS4=;
        b=oEo6Y3Vo0S9ux7PaT7srjUver/Ro5LLPdyyrbQLY/jr7dwT1mJw7A7VBCF/k2e9KSv
         2zhvXteKyrJMkFmPSkCNUrJUwssZCZ5nT4FkI4v2fdxOw/b1EpbMcCPN/hlXdMGw4bwm
         tHadUKJpQeCWMrVAeiY5rYz5IqQAgKt+MSoIjysG3APLBpCB4rwpTRuXM2mugZNxz7TQ
         E+Fmwq7JE/+UZGe1zbMawPeHuSVxiCMItFroqvVkHKFAFMrCeJhXMT9W5DpqDu30aL6D
         R+avQw50Ro9VjFl6s+/8sREwmM77RnagVVACOkPtMx42wSjDMIE3d8Wl3A63WZfvLT5c
         sW/Q==
X-Gm-Message-State: AFqh2krsG9raI3Qy1e3soFwbDnuq1/7su4gME3fMDRYicNoIutUUbu3H
        kzUd80qm05ZoglCqqALdV7b1Dd6++ls=
X-Google-Smtp-Source: AMrXdXveexMlUtlqeaViOFaRaaIOj7ZPv+bNzmMuBH4ZYyo3PX7vwCt2rk9Hleahrn2Mk9MYGWM12A==
X-Received: by 2002:a17:902:7288:b0:192:9a7d:c38a with SMTP id d8-20020a170902728800b001929a7dc38amr21110738pll.9.1674403827739;
        Sun, 22 Jan 2023 08:10:27 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001869b988d93sm23604983pli.187.2023.01.22.08.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 08:10:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] attr: fix instructions on how to check attrs
References: <pull.1441.git.git.1674356774172.gitgitgadget@gmail.com>
Date:   Sun, 22 Jan 2023 08:10:27 -0800
In-Reply-To: <pull.1441.git.git.1674356774172.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Sun, 22 Jan 2023 03:06:14 +0000")
Message-ID: <xmqq8rhuturw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> The instructions in attr.h describing what functions to call to check
> attributes is missing the index as the first argument to git_check_attr.
>
> Fix this to make it consistent with the actual function signature.

Sounds quite sensible.  It would have been very good to explain some
research in the above, like

    When 7a400a2c (attr: remove an implicit dependency on the_index,
    2018-08-13) started passing an index_state instance to
    git_check_attr(), it forgot to update the API documentation that
    was in Documentation/technical/api-gitattributes.txt.  Later,
    3a1b3415 (attr: move doc to attr.h, 2019-11-17) moved the API
    documentation to attr.h and made it to a comment, without
    realizing the earlier mistake.
    
or something like that.

Thanks.

> diff --git a/attr.h b/attr.h
> index 2f22dffadb3..47f1111f391 100644
> --- a/attr.h
> +++ b/attr.h
> @@ -45,7 +45,7 @@
>   * const char *path;
>   *
>   * setup_check();
> - * git_check_attr(path, check);
> + * git_check_attr(&the_index, path, check);
>   * ------------
>   *
>   * - Act on `.value` member of the result, left in `check->items[]`:
>
> base-commit: 904d404274fef6695c78a6b055edd184b72e2f9b
