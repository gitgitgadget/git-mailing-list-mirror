Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A326C64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 14:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjB1OO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 09:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB1OO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 09:14:27 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1612723D93
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 06:14:26 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so13879463pjh.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 06:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677593665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWDDz1H09hS+qZ8Mzjt3niQedh0uKiefAG3RK2IVUIQ=;
        b=BNtR9HfZmzukcav0YgvjrRz9TxyXRbYUVd0uaaFwNz/RmqB7yYZzTsbzqJvWbAK3Y1
         M7Hppa8nqh6MEIjdUUWARx+7WW1TfPm6q/27LfY2frdVlVovIqauorMZMC/4cfsjeREx
         3GHgLPQ302LkYRWZs0VBDv6QBFo4qtWByC7I9J3uIRVigGkhxooPnK8ochgJHkICz8bX
         CiyC2HPhM7YpUIp+K+URYqRAbV3YbKyex3PajKvOexAuk11FfuDV6DW6P1dzClvG6ZQl
         p2HPu7y5+BSSrPeKtA2UT6P+QCCPzqZgERngoKxiRBh074vVfeRW54BL2raYimS4n/RD
         wNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677593665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWDDz1H09hS+qZ8Mzjt3niQedh0uKiefAG3RK2IVUIQ=;
        b=hJFInwLMB1Q2W1Ei43x70BXSt+eKMzHXeoqyoV5x45yqZveAXtOxjKWnLGOhwRsSBB
         EF7WPVmwUgF5ABk2oQIaV95B0vwfS350N5VBwHcXCQhS8PSsiy+atoT21CdjfFEQbqkP
         BSOX09yghXCXUqnE3v7mGN3WLVeFNYTWkP1XMU/Qim5JnJroxuZsdZNP/rK77b1v3ePV
         4Rxfx2X4vICWNSbbxIJRNKZgIdNChIzxr3G89rnociHw63geus+NNUSIrMtEjry5Hoj9
         eNZZqf7aKujVGGEhnBfl8l0PR0Kh+NZeMBC4jleLshcEyK3THkl0nn2EPZUKH/WlOhep
         cneg==
X-Gm-Message-State: AO0yUKWDSVhJGxaAGehvmqWuL8eecUmRgEMzDzbLhJnCkndCqq3PzLBH
        ubvAGnAv+z5prrSivKNMlQSySxYHkZTtDZ9s
X-Google-Smtp-Source: AK7set9YYKr3qbKPhZ2O/0+3DO1BJmm3jXAGTLXH/ZzPIQUTsWYtaNF59odevXR6tlrkNS6wj5+KLg==
X-Received: by 2002:a17:903:249:b0:19a:debb:58f7 with SMTP id j9-20020a170903024900b0019adebb58f7mr3259321plh.13.1677593665490;
        Tue, 28 Feb 2023 06:14:25 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.61])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902744c00b001993411d66bsm6601029plt.272.2023.02.28.06.14.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Feb 2023 06:14:25 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v6 3/3] notes.c: introduce '--separator=<paragraph-break>' option
Date:   Tue, 28 Feb 2023 22:14:19 +0800
Message-Id: <20230228141419.47430-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.2.459.gd58159df.dirty
In-Reply-To: <xmqqk005v3ex.fsf@gitster.g>
References: <xmqqk005v3ex.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The two callers of this function prepares the string_list, and have
> this function consume it by concatenating its contents to d->buf.
> After calling this function, neither of them talks about messages,
> which means we are leaking the strings kept in the string_list.
>
> I could eject the topic from today's integration run (because the
> topic is not ready to be merged to 'next' as-is; "-C/-c" codepaths
> need to be adjusted, at least), but as I took a look already, I'll
> queue this fix-up on top of the topic for now.  Feel free to squash
> it in (or address the leaks in your own way) when sending in an
> update.
>
> Thanks.
>
>  builtin/notes.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git c/builtin/notes.c w/builtin/notes.c
> index 97c18fc02f..cd7af76e2f 100644
> --- c/builtin/notes.c
> +++ w/builtin/notes.c
> @@ -220,7 +220,8 @@ static void insert_separator(struct strbuf *message, size_t pos)
>  		strbuf_insertf(message, pos, "%s%s", separator, "\n");
>  }
>
> -static void parse_messages(struct string_list *messages, struct note_data *d)
> +/* Consume messages and append them into d->buf */
> +static void concat_messages(struct string_list *messages, struct note_data *d)
>  {
>  	size_t i;
>  	for (i = 0; i < messages->nr; i++) {
> @@ -231,6 +232,7 @@ static void parse_messages(struct string_list *messages, struct note_data *d)
>  		strbuf_stripspace(&d->buf, 0);
>  		d->given = 1;
>  	}
> +	string_list_clear(messages, 0);
>  }
>
>  static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
> @@ -451,7 +453,7 @@ static int add(int argc, const char **argv, const char *prefix)
>  		usage_with_options(git_notes_add_usage, options);
>  	}
>
> -	parse_messages(&messages, &d);
> +	concat_messages(&messages, &d);
>  	object_ref = argc > 1 ? argv[1] : "HEAD";
>
>  	if (get_oid(object_ref, &object))
> @@ -622,7 +624,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  		usage_with_options(usage, options);
>  	}
>
> -	parse_messages(&messages, &d);
> +	concat_messages(&messages, &d);
>
>  	if (d.given && edit)
>  		fprintf(stderr, _("The -m/-F/-c/-C options have been deprecated "

Thanks, will apply in next patch.
