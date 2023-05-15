Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9070FC77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 05:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbjEOFBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 01:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjEOFA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 01:00:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF521AE
        for <git@vger.kernel.org>; Sun, 14 May 2023 22:00:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-643912bca6fso9587797b3a.0
        for <git@vger.kernel.org>; Sun, 14 May 2023 22:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684126858; x=1686718858;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hf/hDmp0cGgGK5UbTEWp7TLjAhAViMIMZ9OTGp3FlWA=;
        b=YxE1q9lpqH6RY391sdtJYSSbUQHotJYmqcLMJpeHWoLlbh60hYB1cnzU5890pmvZ+7
         FzMv3SubtTeemF072LkqDLB0KYkaGP3aWYLau/oV5Jjf9ENIf4zAUg91HASTs64jU05m
         pNAwe8/t+aQnRVw2e5UnG/4xOvocJlWGir6yLWOUHablIQXa9M1hhdtuPzEPFonNaSQy
         RzBfz3hbG1IKaRnazlTcikbb0Q0kCR76I3nt7dwatUi0i1rvUhIbWCrGRwo3W1os50Gi
         pyTrASmtDJ/XjaxKX6ywXQzxjy4LdDBBeVLyCoPowq65u0LPIw7IQgpJ5xGD4jEGy+on
         CZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684126858; x=1686718858;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hf/hDmp0cGgGK5UbTEWp7TLjAhAViMIMZ9OTGp3FlWA=;
        b=P5gi5kNTqimKQtLdg93+KKLb3am4s6cYUUg1IiW8cy0QPL/voPMaIiu0j0GxQxkdgc
         unlBnbjHMbCNITZO8BpToFAgEvvQ7EC+jslwPC9W4tnnGBDQ19VyRh1qxjGGRwxaJIPr
         caQz20NVCqkcbD1SoGgFonc83NqBOpg2/vJCduiOS95SQ+arNW/ieC58b3I155EDU2Jw
         HDyHaKQ1fMLDqknG4N5gLxQKOH2Om10K6aL0mn0nkACdTopwAH602HvZN90/5tbqrO9w
         9ffOHDoDQ6Bd71LTO/7CuwTrZeu4AFb25hNRFCPk8fBcwx832958k/1O8g2wQKIopZ5N
         Qz4w==
X-Gm-Message-State: AC+VfDykoQVCwKXKfGMMFxZlQYVHNZfAgmgxsV5Idl3IROsuyFpqcy7s
        YlNNxl24xWQhUMYKBN29NfA=
X-Google-Smtp-Source: ACHHUZ6Sj2Bf/9ViI6ghcGoCfWk0/fX/Ie6FpP/t3wpnjy3xxWaPqCE7wrm/AIs1nC5/Mm1Uja4bbQ==
X-Received: by 2002:a05:6a20:432a:b0:100:5a09:4524 with SMTP id h42-20020a056a20432a00b001005a094524mr30000001pzk.31.1684126857815;
        Sun, 14 May 2023 22:00:57 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id q22-20020a656256000000b005287a0560c9sm10120153pgv.1.2023.05.14.22.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 22:00:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin Monperrus <martin.monperrus@gnieh.org>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 1/2] ls-files: add %(objecttype) atom to format option
References: <pull.1533.git.1683969100.gitgitgadget@gmail.com>
        <3f8884457d3628439aa9e6800c976f5a597cdda3.1683969100.git.gitgitgadget@gmail.com>
Date:   Sun, 14 May 2023 22:00:56 -0700
In-Reply-To: <3f8884457d3628439aa9e6800c976f5a597cdda3.1683969100.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Sat, 13 May 2023 09:11:38
        +0000")
Message-ID: <xmqqednicho7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Sometimes users may want to align the feature of
> `git ls-files --format` with that of `git ls-tree --format`,
> but the %(objecttype) atom is missing in the format option
> of git ls-files compared to git ls-tree.

"Sometimes users may want to" sounds a bit awkward; even if no user
notices that the two very similar commands supports different subset
of the vocabulary without good reason, wouldn't we want to align the
feature set of these two commands?

> Therefore, the %(objecttype) atom is added to the format option
> of git ls-files, which can be used to obtain the object type
> of the file which is recorded in the index.

And from that point of view, this conclusion has a bit more to think
about.  Is the %(objecttype) singled out here only because somebody
happened to have complained on the list, or did somebody went into
the list of supported atoms between two commands and considered what
is missing from one but is supported by the other, and concluded that
only adding this one atom to ls-files would make the two consistent?

I would not complain if it were the former, but it must be explained
here in the proposed log message.  That would encourage others to do
a follow-on work to complete the comparison to fill the gaps on the
both sides.  If it were the former, saying so explicitly in the
proposed log message will save others---otherwise they may try to do
the comparison themselves only to find that this was the last one
remaining discrepancy.

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  Documentation/git-ls-files.txt | 2 ++
>  builtin/ls-files.c             | 2 ++
>  t/t3013-ls-files-format.sh     | 7 +++++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 1abdd3c21c5..4356c094cec 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -270,6 +270,8 @@ interpolated.  The following "fieldname" are understood:
>  
>  objectmode::
>  	The mode of the file which is recorded in the index.
> +objecttype::
> +	The object type of the file which is recorded in the index.
>  objectname::
>  	The name of the file which is recorded in the index.
>  stage::
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 625f48f0d61..6ff764cda18 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -272,6 +272,8 @@ static size_t expand_show_index(struct strbuf *sb, const char *start,
>  		strbuf_addf(sb, "%06o", data->ce->ce_mode);
>  	else if (skip_prefix(start, "(objectname)", &p))
>  		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
> +	else if (skip_prefix(start, "(objecttype)", &p))
> +		strbuf_addstr(sb, type_name(object_type(data->ce->ce_mode)));
>  	else if (skip_prefix(start, "(stage)", &p))
>  		strbuf_addf(sb, "%d", ce_stage(data->ce));
>  	else if (skip_prefix(start, "(eolinfo:index)", &p))
> diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
> index ef6fb53f7f1..3a1da3d6697 100755
> --- a/t/t3013-ls-files-format.sh
> +++ b/t/t3013-ls-files-format.sh
> @@ -38,6 +38,13 @@ test_expect_success 'git ls-files --format objectname v.s. -s' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git ls-files --format objecttype' '
> +	git ls-files --format="%(objectname)" o1.txt o4.txt o6.txt >objectname &&
> +	git cat-file --batch-check="%(objecttype)" >expect <objectname &&
> +	git ls-files --format="%(objecttype)" o1.txt o4.txt o6.txt >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'git ls-files --format v.s. --eol' '
>  	git ls-files --eol >tmp &&
>  	sed -e "s/	/ /g" -e "s/  */ /g" tmp >expect 2>err &&
