Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90339C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 13:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiKGNmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 08:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKGNmx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 08:42:53 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507B71C927
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 05:42:52 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a67so17583693edf.12
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 05:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fUt/ICq97XeawalotcnBaxEtnv3HW+Q/biO93SwnzVE=;
        b=iSfytdtZBgEN3vbxts7zpur+Hd6R5qHOxoaI/GCmDsOskBB1fFsKndaewXncPMQtdT
         fvGWjrfW7D+U3BcmDUPfdeTX1A0GhgjXWX6Te+pAW3JqlSxQKtNVJTa4k8S22ry0StTE
         9ru5/OLg6WQuxLf0VMEcABOJ487E8pctBYMHdY2zpmbnmzvHsA7ZWljYyhIHqDr0hgN2
         s2jnindy3623V58XdXo4o3RaNCWUi9oxAzdBveApnoBqtKP6MFRny5/6IOZ02X2HiZVg
         rAfSbDnDVOEmu2imwRpjh/bdKdT4JK1G1KAuJPXAwPe7ZGuPr03UcQ+I/aQASer6Aqqc
         m1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUt/ICq97XeawalotcnBaxEtnv3HW+Q/biO93SwnzVE=;
        b=mMbRElMGt+czXgCetJS73cA12X05ItUtpmmkIvE8JzjY6xE5ge3dYHBzI4uhhkBgG4
         xHI0bFBKu6B05CcQNYQCQjaNm78tUtm7pbiP78wxrdH/yA4LVXUy36hLqQZQaXUse7mw
         zTGVc6L2G6zFE7R5/7Ko1CBLlGxWOnd4zdej0CJLmtOwCNJwYu1+P765FYUxgTdPAq4k
         RZ/DzL2ll6oRNFBkpLLTxXQ5dVfnDQ0+p/XqWUmLyYJA+/lc+hoj4pHYQnLopuXgRfd5
         3LdUc8DYnsDIzw6348+7k+K8DkeCvbklN25zJf8u4T15IBfzcsKhBvXg1Zm/K1xCMa82
         GBfw==
X-Gm-Message-State: ACrzQf2P6QUi6IrQzqDUAKj9/4MsRWVQqDtS+vudFcOUPh9HPqrwB9GB
        +YPtXYDi0RhGcQqPDYzT5H4=
X-Google-Smtp-Source: AMsMyM6/i1VdO6oMfcqRoq8Qc7t1YHeR3O1mAIxbsl4pmnX/uRiHnwWm0sByVNLzqQn3ZumeXbXhlA==
X-Received: by 2002:a05:6402:11cc:b0:462:76cd:1215 with SMTP id j12-20020a05640211cc00b0046276cd1215mr50078894edw.318.1667828570704;
        Mon, 07 Nov 2022 05:42:50 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id et19-20020a170907295300b0077205dd15basm3461402ejc.66.2022.11.07.05.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 05:42:50 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os2On-0005L0-1j;
        Mon, 07 Nov 2022 14:42:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/6] revision: add new parameter to exclude hidden refs
Date:   Mon, 07 Nov 2022 14:34:45 +0100
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
 <de7c1aa210c2df9bdbbb6c19f44f72c37f56c5da.1667823042.git.ps@pks.im>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <de7c1aa210c2df9bdbbb6c19f44f72c37f56c5da.1667823042.git.ps@pks.im>
Message-ID: <221107.86pmdyx4me.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, Patrick Steinhardt wrote:

> +--exclude-hidden=[transfer|receive|uploadpack]::
> +	Do not include refs that have been hidden via either one of
> +	`transfer.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs` that

Maybe worth adding "(see linkgit:git-config[1]) after listing the config
variables.

>  int ref_excluded(const struct ref_exclusions *exclusions, const char *path)
>  {
> +	const char *stripped_path = strip_namespace(path);
>  	struct string_list_item *item;
> +

nit: stray whitespace in otherwise "clean" commit, but the post-image looks nicer, so...

>  void init_ref_exclusions(struct ref_exclusions *exclusions)
>  {
>  	string_list_init_dup(&exclusions->excluded_refs);
> +	string_list_init_dup(&exclusions->hidden_refs);
>  }

Per my comment on 3/6 we wouldn't need this when using the macro as a
source of truth.

>  void clear_ref_exclusions(struct ref_exclusions *exclusions)
>  {
>  	string_list_clear(&exclusions->excluded_refs, 0);
> +	string_list_clear(&exclusions->hidden_refs, 1);
>  }

Hrm, I'l read on, but I don't see any use of "util" here at a glance,
should the "1" here be "0", or maybe I've just missed how it's used...

> +	if (strcmp(section, "transfer") && strcmp(section, "receive") &&
> +	    strcmp(section, "uploadpack"))
> +		die(_("unsupported section for hidden refs: %s"), section);
> +
> +	if (exclusions->hidden_refs.nr)
> +		die(_("--exclude-hidden= passed more than once"));

We usually just ignore the first of --foo=bar --foo=baz and take "baz"
in our CLI use. Is it better to die here than just clear the previous
one & continue?


> -#define REF_EXCLUSIONS_INIT { .excluded_refs = STRING_LIST_INIT_DUP }
> +#define REF_EXCLUSIONS_INIT { .excluded_refs = STRING_LIST_INIT_DUP, .hidden_refs = STRING_LIST_INIT_DUP }

...the getting overly long line I mentioned in 3/6...

> +TEST_PASSES_SANITIZE_LEAK=true

Thanks for adding this! :)
