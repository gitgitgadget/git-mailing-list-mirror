Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD58C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 18:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBPSjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 13:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBPSjn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 13:39:43 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EDB5288A
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 10:39:31 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c11so2222210ple.9
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 10:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvGzPFwRcQQ09on7uUuC6mJsgshRAX6iCeQoO5B6ToM=;
        b=IHffcC5+cd5Hq8+qv7o/vC7m4EDoQ6LZIIWvT7HJGEbTNIBgG0OSRc1qPkfOPRMviV
         UgMNkGq3b9+z3GmXC03cB1PoKAv1rKQ+FfShaNkIC1qKC6/DWfTQhJ/e+1l7pG1KpI3l
         c76ehz26QvWGOU2PqFEfNw+Bg4UiJ9leZgsPWENkE9jbxZMawRHuuW8mDSb+93L1HL50
         5zTG89VFy7TMiBwLYCQmiJ2ZjAiLMpFRscjDY7dZb8ZWFo/0MBcqccbfZu9fxr8T2hDQ
         HD7RHe/lQRlguehg8Ykuz6iIyK7AXHiRwZlks82lWUb8s+N76nDcxxE8c2wdEyzx1dpj
         Hpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qvGzPFwRcQQ09on7uUuC6mJsgshRAX6iCeQoO5B6ToM=;
        b=ClxtV+iGEbhLsEaHt88MtixIOA+YxC9dV3CNlw6dLwtxipsppWH2sjgVX5cBAusrYp
         /x0/TY4qoBPPWgeEnt7kKbXOtVfoFf5wQbhiAlz2FePGSk3rhbtlTEZDOaTxWq1AI8Bd
         G5LMt+gCIPlasydcn3CsnP3vuvOlITsjU4mKDfaMdSs+OHoebGsDbiiMBtL8nSLFmRsn
         0UUrYBChHYuxwtJNOBht4Cs2claJWIrXoucf/owT0XuG00k4HmWAEDWfBFLXMgU2uEw1
         IB09+AknWdadcAJPgGmk7hbcLXk2Z2B/5XSobF/bdoloSXh3KyGhCj/wAe8uYrLSXZVv
         BO9Q==
X-Gm-Message-State: AO0yUKUfKe0M/L0iWhCR6ij56mmYJbNVExFoM2xDdSgtfu2+mrZz91MV
        eLlYV38f4eNYlq+UOfflb8hPh2CALdQ=
X-Google-Smtp-Source: AK7set8kOBvS4d8uJLbtcV3YIK6t6Lnp4zKUdl8swQ7c+HeEgK7ASgH1y67ExJ1pKxGf/bDNgaOhmw==
X-Received: by 2002:a17:902:da8b:b0:19a:f02c:a05b with SMTP id j11-20020a170902da8b00b0019af02ca05bmr3253567plx.3.1676572770814;
        Thu, 16 Feb 2023 10:39:30 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id jk3-20020a170903330300b0019a75ea08e5sm1646867plb.33.2023.02.16.10.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:39:30 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 2/3] notes.c: cleanup for "designated init"
References: <cover.1676551077.git.dyroneteng@gmail.com>
        <e7bc606005d8255f8951aa4f994f98b0c08d1d77.1676551077.git.dyroneteng@gmail.com>
Date:   Thu, 16 Feb 2023 10:39:30 -0800
In-Reply-To: <e7bc606005d8255f8951aa4f994f98b0c08d1d77.1676551077.git.dyroneteng@gmail.com>
        (Teng Long's message of "Thu, 16 Feb 2023 21:05:04 +0800")
Message-ID: <xmqqfsb5pi8t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> The "struct note_data d = { 0, 0, NULL, STRBUF_INIT };" style could be
> replaced with designated init format.
> ---

Missing sign-off.

The change itself with the explanation does make sense.

Thanks.

>  builtin/notes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 23cb6f0d..553ae2bd 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -401,7 +401,7 @@ static int add(int argc, const char **argv, const char *prefix)
>  	struct notes_tree *t;
>  	struct object_id object, new_note;
>  	const struct object_id *note;
> -	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
> +	struct note_data d = { .buf = STRBUF_INIT };
>  	struct option options[] = {
>  		OPT_CALLBACK_F('m', "message", &d, N_("message"),
>  			N_("note contents as a string"), PARSE_OPT_NONEG,
> @@ -567,7 +567,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  	const struct object_id *note;
>  	char *logmsg;
>  	const char * const *usage;
> -	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
> +	struct note_data d = { .buf = STRBUF_INIT };
>  	struct option options[] = {
>  		OPT_CALLBACK_F('m', "message", &d, N_("message"),
>  			N_("note contents as a string"), PARSE_OPT_NONEG,
