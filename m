Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9572C61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 22:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjBUWBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjBUWBk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 17:01:40 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9968D2E825
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 14:01:39 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g12so3381678pfi.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 14:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEuu8tUJMXg/uDEEwVBpkI3WaYRwJcJmSjFAoi9HIcU=;
        b=nuUaGryx6MNNZc2OcEnLwuql/qWJa4gcMTQMrAVYEygKVUAU7K7ILMxmPjl1QZ943W
         NyCdqHDonhczpZOS1dUv50BQGzMc/De4M7EdGUHBJIAu1wSnzpKM7IxAsdupjc/w4cQm
         nSY8PGLJPjRoAwviSGan2R4Y59Vfcrp+4xcOv+6KtSfwKeOwBtl7yDXCtdw/xmD5mav8
         I4p6HJAnverj8QgAwakU9woHxJtSCxYKYCgd1YZtaD74D494R0ls+wfypVdLo/6pmZLd
         2PcL8S+wJEtDZ/5CvKXKqWQPs5CscbI0KJTPxWy2y9dZzSsWA6zxH/6PWvSWZmEc1LLf
         y0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wEuu8tUJMXg/uDEEwVBpkI3WaYRwJcJmSjFAoi9HIcU=;
        b=hjkfcQ2WbjFKuVU0w+awKUAIZrrTlKXlTcntC3I0uJp1JdYXzHhubNaWg8POH009ct
         ZXk9H/Mb3W2Q8C/NJo9fDr9jALlYbTJHsYrM71i4F3RTtlnRUN3IiFfZwQJ45e+MiMKJ
         fOJk8iKOAMbfN8TboWdX42tFgLZxBR3mBsAhl1sOZ6fdtNwL6ndAn5eCBNeat3RjL7TO
         9T63Nj4OKAoUJsM0b12niv3mnUi5T/nFOFbJpBfuS/PMjv6jJsotSLISsyyXBWh6xHyD
         LhRooOwcKBzBXJsr63oFdlXFknmCejFpn0dSrFjathr65hRj93FKqFiy55F7CtkYppTZ
         Q0fQ==
X-Gm-Message-State: AO0yUKWqJeM5lM+29heG/k8FuQaVvyctGe7C62ZLy+Ek7EQiYwRV+9m7
        zsQmcAlSZqS45ZBQPgHoIempjAFIY2A=
X-Google-Smtp-Source: AK7set9Bm6QyYJfMc+eVE8CFVeuVd4UEIlYQmR3OegnVKyFcGKJPVbtOoC1kFJGsfdBn2+AjI5tMbQ==
X-Received: by 2002:aa7:950d:0:b0:5a8:4883:4213 with SMTP id b13-20020aa7950d000000b005a848834213mr5741308pfp.20.1677016898899;
        Tue, 21 Feb 2023 14:01:38 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id x15-20020a62fb0f000000b0058bf2ae9694sm9917164pfm.156.2023.02.21.14.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 14:01:38 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        --cc=tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 1/1] range-diff: let '--abbrev' option takes effect
References: <20230220142444.18739-1-tenglong.tl@alibaba-inc.com>
        <20230220142444.18739-2-tenglong.tl@alibaba-inc.com>
Date:   Tue, 21 Feb 2023 14:01:37 -0800
In-Reply-To: <20230220142444.18739-2-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Mon, 20 Feb 2023 22:24:44 +0800")
Message-ID: <xmqqzg96d6f2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> diff --git a/range-diff.c b/range-diff.c
> index 8255ab43..086365df 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -383,11 +383,14 @@ static void output_pair_header(struct diff_options *diffopt,
>  	const char *color_new = diff_get_color_opt(diffopt, DIFF_FILE_NEW);
>  	const char *color_commit = diff_get_color_opt(diffopt, DIFF_COMMIT);
>  	const char *color;
> +	char abbrev = diffopt->abbrev;
> +
> +	if (abbrev < 0)
> +		abbrev = DEFAULT_ABBREV;

OK.  I _think_ this explicit defaulting to DEFAULT_ABBREV does not
need to exist, as find_unique_abbrev() falls back to the default
when given a negative value anyway, but it is good to be explicit.

Will queue.  Thanks.
