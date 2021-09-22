Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425F3C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 204BF61181
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbhIVW5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 18:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbhIVW5j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 18:57:39 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3529BC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 15:56:09 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id q17-20020a0cf5d1000000b00380e60ef363so15157566qvm.9
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 15:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZTpqK+KjUz17FgT71Mxt0DV//6cva+InEg4Dy+ix5rE=;
        b=fAHtvbn8wW/85fwlRye9QbGQUeJkRKF0WVrtk+BiBnnYBuXUbFKNkFZPDV3O1DWZGX
         LS5LOquMrz8s2y3KykVlg1Ja1DqddHPrmYgyWQP6Miv6JJgRUt3ppHav3mmSoSe83f9P
         N2zPVKS8cTyfN7Fv3EknPS7lxGgdbUDVL3HpTBEV5waxXRfeTZBbksvZqSzTRQWjSaS7
         Lwxs1eDbhWwmZJBpzsmMyNT2e9hnSEpGaOTh7w2KvLv/PAP3onHjqz7DmUWiI8EC6m9N
         fL4hefMBxwOPlQSLl8BbQGAYw0kfknLrUsKk0KHubjsxOrjZGWNUfJrODsnOHsCAw4Sf
         yZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZTpqK+KjUz17FgT71Mxt0DV//6cva+InEg4Dy+ix5rE=;
        b=Gi5F8aD/oWstysQ3Hix4pL6olS4wmG/owNqtNpThn0qHIkwxPc7Ja1Q+Q93X8U/POz
         zZ48g/vh97n3ryo0BrcFOUgEDq2mBpX4oOVEi4BdnMxmmzploGB/IArdJs4igVSHb+is
         fAbVBbwvBq5eIxOg5u73l0jtKnQzRbKfeNZDLmA1BUk2GiYVRx7SM3//37gYGf5buJAj
         KyZrt/cLaSehHPbQFXakLBdzvpOFx2w3eZs13lgZ7Fiw6Y6zEViA0Jfpk+F8vJb+SJK0
         ZPHHV1CCdmjgT5ugeDJr3q1341hpZGaV6s2SGfQYrsW0xsFYRUOdzW5GBRUODr4gbJc+
         juBA==
X-Gm-Message-State: AOAM532CXUBO9NShyQXsgaQ302r5VwP7NiubeJs+CckcSs4SL9OI07gh
        drpuVf4raCYO4hQzr+mVnhqJUWKgg23xunbKI9ah
X-Google-Smtp-Source: ABdhPJy6PdBEDQZAPNLe9DkDo2m2xW8S5659of8yX5g7mgFHEVv/9VorzK7yictqR1ycZCnDWEJrZl5noYQ5H3MCoBCI
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:612:: with SMTP id
 d18mr1899338ybq.113.1632351368265; Wed, 22 Sep 2021 15:56:08 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:56:05 -0700
In-Reply-To: <c0d045a9de1a5e75d684b0dd2009a3137b6e5c59.1631730270.git.me@ttaylorr.com>
Message-Id: <20210922225605.2608085-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <c0d045a9de1a5e75d684b0dd2009a3137b6e5c59.1631730270.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: Re: [PATCH v2 4/8] builtin/repack.c: keep track of existing packs unconditionally
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -98,8 +98,9 @@ static void remove_pack_on_signal(int signo)
>   * have a corresponding .keep file. These packs are not to
>   * be kept if we are going to pack everything into one file.
>   */
> -static void get_non_kept_pack_filenames(struct string_list *fname_list,
> -					const struct string_list *extra_keep)
> +static void collect_pack_filenames(struct string_list *fname_list,
> +				   struct string_list *fname_kept_list,
> +				   const struct string_list *extra_keep)
>  {
>  	DIR *dir;
>  	struct dirent *e;

The comment in the before-context of this hunk needs to be updated.

Also, I think that fname_list should be renamed to fname_nonkept_list.
It does have the same semantics as before, but the name of the function
has changed. And also, fname_list sounds like a superset of
fname_kept_list, but that is not the case.

> @@ -440,6 +440,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	struct string_list names = STRING_LIST_INIT_DUP;
>  	struct string_list rollback = STRING_LIST_INIT_NODUP;
>  	struct string_list existing_packs = STRING_LIST_INIT_DUP;
> +	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
>  	struct pack_geometry *geometry = NULL;
>  	struct strbuf line = STRBUF_INIT;
>  	int i, ext, ret;

Likewise here - the introduction of a new similarly-named variable means
that existing_packs should be renamed, I think.

Other than that, this patch looks good.
