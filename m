Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842A2C4363D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 23:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E38A23119
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 23:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9LvLe4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIWXE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 19:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWXE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 19:04:57 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC053C0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 16:04:56 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v14so1045715qvq.10
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 16:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SGKuSQtftmkXeLkYr/NWeLXpAANbhxlPUO6qcCRcy8g=;
        b=c9LvLe4peXGUe6hDe0DdxmQGkhftUSNWm2+tdWBpInObbGEllqvja5/fyTkfEeDBwN
         TXOObz9ZSHu0X85x7HZm+ed+O4ks6hPHoNQu/8MtV7YCkGsCpYWtCHSJRzHFyikYMXeg
         Ok5JJzfrvAfsNX9bLDetscsV9pDKndltj42jjBYFry+joSSa/b8vyuBrvpv9TgQ0/IMx
         susn9ZFmPeKFhua7z7vdOwZj5WQuAx+tCnD/FmB3oc92qahaIg+ZfnCL6dAxEQApKpsO
         tUA5o5JY6y24ATbWuj/TYtBM8n4vPBxmvfaFn8/goG2nvRfdqWKD9KdqCzHddoCVrdbs
         dekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SGKuSQtftmkXeLkYr/NWeLXpAANbhxlPUO6qcCRcy8g=;
        b=bh19AII7sFw277ItTrOVhKhNNtmdAkUJYq6snJj3iUUh/qZa9xSraUWoSaLk6nivdn
         6ab1jjaJB1YtAXGszWJDYXwFDmKUL9gyEmlyV/Gb80oQXWIeJpR6s/XweHWMiZFe+36A
         cuAMs8vSl2F8WOP1FreaDV9qLdYzUu1kep3mAuYGs/M0ti2XwilcGtHNBHDVG7JmgiTg
         DQBwvigpMbMYWACDKsEgf5laUKTXNWR9I6Pmvmi57NZndKbS3/46CJtIcSOIK0C3aU+Q
         0rZOISOEbMT+7JrgzAj/duMM3ZDMpgYyLYaZAObBk1mkHgDLCuVMK3jqOdakvbYYFRM2
         fP+w==
X-Gm-Message-State: AOAM530zaq3y2i/8xuJ7uUyFf01upc6XgIzRszx5tXAmeP25JtFtQo5S
        ILSAZA9RJK8WlxDDD5JU3C41v9LRBECDAHFJLUgq
X-Google-Smtp-Source: ABdhPJzWO2CAMm9/cfSaE75AqOpKaF6CJ+5JZdec3HT4si2qqOdpZtlKcLMxQ7ZaSkMqVX39dstuxQROxLNtuxdFYken
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:e892:: with SMTP id
 b18mr2485182qvo.5.1600902293517; Wed, 23 Sep 2020 16:04:53 -0700 (PDT)
Date:   Wed, 23 Sep 2020 16:04:51 -0700
In-Reply-To: <20200909004939.1942347-4-emilyshaffer@google.com>
Message-Id: <20200923230451.1279511-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200909004939.1942347-4-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: Re: [PATCH v4 3/9] hook: add list command
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>   $ git hook list pre-commit
>   ~/baz/from/hookcmd.sh
>   ~/bar.sh

In the tests below, there is a "local:" prefix (or similar). It's
clearer if the commit message has that too.

Also, looking at a later commit, the "list" command probably should
include the legacy hook if it exists.

> +static void emplace_hook(struct list_head *pos, const char *command)
> +{
> +	struct hook *to_add = malloc(sizeof(struct hook));
> +	to_add->origin = current_config_scope();
> +	strbuf_init(&to_add->command, 0);
> +	/* even with use_shell, run_command() needs quotes */
> +	strbuf_addf(&to_add->command, "'%s'", command);
> +
> +	list_add_tail(&to_add->list, pos);
> +}

It might be odd to a programmer reading this that an existing "struct
hook" with the same name is not reused - the scanning of the list done
in hook_config_lookup() could probably go here instead.

> +test_expect_success 'git hook list orders by config order' '
> +	setup_hooks &&
> +
> +	cat >expected <<-EOF &&
> +	global:	$ROOT/path/def
> +	local:	$ROOT/path/ghi

Will the "global" strings etc. be translated? If yes, it's probably not
worth it to align the paths in this way.
