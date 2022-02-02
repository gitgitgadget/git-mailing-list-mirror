Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8191EC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347626AbiBBVc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347616AbiBBVct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:32:49 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED98C061741
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 13:32:49 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a8so431418pfa.6
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 13:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=TAQjDSexxlY4UQM/1KFsnj6Ex1U3LfDI6THsLB/2F5Q=;
        b=WSj72I5pBtopSS45JYRjrkcQFy0ZwLXCEXNl8qZrA2wtuu/1p2FNUd8/n+BeC2fQYv
         PiTPEWh6o6MWcYMq4pZ4HkjFNS5WSIOwXXlftA2p0cYpcCZ0jIdyk7kupcmdhzEwEYSw
         wrokqE2Z7+zdAGvQNr3ZLQduoYOKShAeiqVORxyM1FLULq44RdW2VbEXViqy2PBDjFhO
         Bu3rFdCDZhwvXX3ry8Jx0jodshYZJHsX9g3uOdIohAAZCdEtxLxXjJ7PdYa7ZDcUoTbv
         VwGot+GYMdKuOfK5Uw4S3nlxysaobC5Y4ODh/f014uQ0LM+lXcsOyV8ljLGeSy2vSYkV
         qMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=TAQjDSexxlY4UQM/1KFsnj6Ex1U3LfDI6THsLB/2F5Q=;
        b=B//jNXMNjBl+RD8TXk1LpfclMzleAO182Rjgl4wSwZkhIoO83wDHRiZjufghLj+fdz
         vmXx3H81cAQS9PZK2ba40RGoD5Bdt8FoPA6HXd+QEODKubhq1OGKSyp4mHYukH2Z9vSY
         DQgPDAVinDcDfHMZvDht0Spw28l9eljcS4WKgUyzZGkCR4Zf4lcl/Y0v0ox7owuSbdt+
         1cewtaUdCZIJ0UiHO04Pyd+1ZGnGeZFG5IjqbliSUlNpXpgIxaHylp44jo9eUxYGIDgz
         UxBIrFaEvrDaRwScNM0QR3NwdH6ZIr7jk0L8dBbjMKdxQXSmv7nk1WXPgcmDtc2fyaSH
         5lnA==
X-Gm-Message-State: AOAM530paviTWaZ4Es7CBkZRAc2g5C1LyRbK8AydOy7p4kKACYMRhV1r
        +iiTZqX3sbkguaxMlHIK5a4=
X-Google-Smtp-Source: ABdhPJxzSRUg+MKZ0wDR9zrxy8FB+kPLghrgXoWTDmctEVWYnHxGw5qpbp1Mim4Z7sTxSA6UuZjzbg==
X-Received: by 2002:a62:e116:: with SMTP id q22mr31305125pfh.48.1643837568558;
        Wed, 02 Feb 2022 13:32:48 -0800 (PST)
Received: from localhost ([2620:15c:289:200:da7f:76ba:d0d5:da44])
        by smtp.gmail.com with ESMTPSA id lr8sm8035906pjb.11.2022.02.02.13.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:32:48 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 11/13] merge-tree: provide easy access to `ls-files
 -u` style info
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <c322e4c6938b7270b6e90998994642074a2813e0.1643479633.git.gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 13:32:47 -0800
Message-ID: <xmqqr18lvts0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -450,7 +451,11 @@ static int real_merge(struct merge_tree_options *o,
>  		merge_get_conflicted_files(&result, &conflicted_files);
>  		for (i = 0; i < conflicted_files.nr; i++) {
>  			const char *name = conflicted_files.items[i].string;
> -			if (last && !strcmp(last, name))
> +			struct stage_info *c = conflicted_files.items[i].util;
> +			if (!o->exclude_modes_oids_stages)
> +				printf("%06o %s %d\t",
> +				       c->mode, oid_to_hex(&c->oid), c->stage);
> +			else if (last && !strcmp(last, name))
>  				continue;
>  			write_name_quoted_relative(
>  				name, prefix, stdout, line_termination);

OK.  The addition (and disabling of the deduping) is quite trivial.
We do not even have to worry about line termination since the extra
pieces of info are prepended to the pathname.  Nice.

> @@ -485,6 +490,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  			    N_("do a trivial merge only"), 't'),
>  		OPT_BOOL(0, "messages", &o.show_messages,
>  			 N_("also show informational/conflict messages")),
> +		OPT_BOOL_F('l', "exclude-modes-oids-stages",
> +			   &o.exclude_modes_oids_stages,
> +			   N_("list conflicted files without modes/oids/stages"),
> +			   PARSE_OPT_NONEG),

Why does "-l" give shorter output than without it?  "-l" strongly
hints a longer output than without, at least to me.  Just wondering
if this will not become a source of confusion to future scripting
users.

>  		OPT_END()
>  	};
>  
