Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F48C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3F960FC0
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbhILWQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 18:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhILWQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 18:16:58 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77340C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 15:15:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h17so1239622edj.6
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Ey5ndDpVbrp/0AoNww8U+nOHQkYH9iwh1wEuOwYkZds=;
        b=PoflayIJ7N3ywbZMQ869a7IdLxDVL1Z5fOdCpSl3aM5GUFUVoWTs8+JGFqFnD0pVEI
         nVOT+ThS1B1Fue1w/kpq0Y/Gu5wy8zdlI6ijteVHJoMHFzM3/EW84be1+ML4LlYL2lss
         CB6Nn62ZbwVBG03+lEO8ADkdjHfTIKotDAgYqyLGSSwg8OV3n/geU0mVyiGaPmjUpirP
         t/wr0OKRMLdDMAFBuqW7eVG5T/XSIQ6ETHV3h81jzK+p3RWgVNXmRe6GhPDRxnC1VyIX
         /HCKA8E79z4j9xoD0SFApjGSIWxUXg6V9Jb2K0wKdtZAVzfK4ZQEbmZSWCZRSO0OAfk3
         5OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Ey5ndDpVbrp/0AoNww8U+nOHQkYH9iwh1wEuOwYkZds=;
        b=NFkifWIfXGvtgewqSYtk7Gx627umofmUXBH+jG1eqXAUclRjHnR2yljUV9NrT1rz7K
         IEYtHxKQOHtZCc3TjnfmhJ1E/j9g3OrA9N9+qBF9/o2X5dv76m+ByMBhYBB9tHHrEx0r
         E03Lwwdg1unb7pwnoPqggwMU3LS+rFC+36bD2g0LYayDdtSA+70p0XZT+Rb92X5anm36
         33w8VXGXxBinndaRwLwK2RQVbYfyDYqKea8wjzu/ciCOVM1PG5mu0syktlKtpdzdIzTr
         FkTMeNXe+8UezoBpe4ZzePNkH0hCnWj+mZu8HClhKTWlz/H57Dw7Qt6dUFosbiVC26gj
         c1jQ==
X-Gm-Message-State: AOAM532cevWyu86quO3pAxZIk0KjB0zMpF49s/VwK7+qD7p0ceMF7tMn
        2U60qhJrLstl95txKiokadMs41BE4m4lmg==
X-Google-Smtp-Source: ABdhPJxs4b0VI9SB2LF3m6UYhKALQR4oNSP7pTu4ox40tK2tc3N1rwzTlO/mW6MZRC2jOQUps1Qsqw==
X-Received: by 2002:a50:f1d9:: with SMTP id y25mr9965172edl.116.1631484941786;
        Sun, 12 Sep 2021 15:15:41 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g9sm2520645ejo.60.2021.09.12.15.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 15:15:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        matheus.bernardino@usp.br, stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 14/14] advice: update message to suggest '--sparse'
Date:   Sun, 12 Sep 2021 23:58:35 +0200
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <f2abc387822378e02d0b221baf9a09ac91d44d7d.1631453010.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <f2abc387822378e02d0b221baf9a09ac91d44d7d.1631453010.git.gitgitgadget@gmail.com>
Message-ID: <87pmtd5tkj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 12 2021, Derrick Stolee via GitGitGadget wrote:

> -	fprintf(stderr, _("The following pathspecs didn't match any"
> -			  " eligible path, but they do match index\n"
> -			  "entries outside the current sparse checkout:\n"));
> +	fprintf(stderr, _("The following paths and/or pathspecs matched "
> +			  "paths that exist outside of your\n"
> +			  "sparse-checkout definition, so will not be "
> +			  "updated in the index:\n"));
>  	for_each_string_list_item(item, pathspec_list)
>  		fprintf(stderr, "%s\n", item->string);

This before and after looks about as well line-wrapped...

>  	advise_if_enabled(ADVICE_UPDATE_SPARSE_PATH,
> -			  _("Disable or modify the sparsity rules if you intend"
> +			  _("Disable or modify the sparsity rules or"
> +			    " use the --sparse option if you intend"
>  			    " to update such entries."));
>  }

...but here..

>  	cat >sparse_error_header <<-EOF &&
> -	The following pathspecs didn't match any eligible path, but they do match index
> -	entries outside the current sparse checkout:
> +	The following paths and/or pathspecs matched paths that exist outside of your
> +	sparse-checkout definition, so will not be updated in the index:
>  	EOF
>  
>  	cat >sparse_hint <<-EOF &&
> -	hint: Disable or modify the sparsity rules if you intend to update such entries.
> +	hint: Disable or modify the sparsity rules or use the --sparse option if you intend to update such entries.
>  	hint: Disable this message with \"git config advice.updateSparsePath false\"
>  	EOF

...this used to line-wrap at 80 characters, but is now a bit beyond
that.

Maybe instead make these two into bullet-points?

Also the third "Disable" looks a bit jarring at first, it seems like a
continuation of the first message, but it's just the standard "disable
this message" we tend to print out.

This commentary pre-dates this commit, but just in general:

I think the advice system is best used where there's an initial
non-optional message, and then the advice elaborates on what happened,
how to fix it. A good example is the "short object ID %s is ambiguous"
in object-name.c.

But in this case both messages are rather long. I'd think better would
be something like (and I didn't look very deeply at the involved code):

    error("pathspec '%s' matched only outside sparse checkout")

I.e. in e.g. cmd_rm() we loop through the pathspecs, and we error on the
first one, so to a first approximation why do we need to for sparse emit
ALL the pathspecs we didn't match? if we're going to error out anyway
shouldn'w we just error out on the first one?

But going on, I'd think this would be better overall (pseudocode):

    error("pathspec '%s' matched only outside sparse checkout")
    if (advice_enabled(ADVICE_UPDATE_SPARSE_PATH)) {
        char *list_str;
        list_of_bad_pathspecs = make_that_list(my_pathspec_string_list, &list_str);
  
      if (list_of_bad_pathspecs.nr > 1)
            /* Emit a message that details what's wrong, but also has a
             * list of all the other pathspecs we'd also die on if the user */
      else
          /* Ditto, but no list *?

Maybe I'm missing something with the sparse implemention, but I'd think
going above & beyond and listing all failures is a bit much in either
case, i.e. for non-sparse we have:

    $ git rm 'file-i-do-not-have' 'directory-i-do-not-have/'
    fatal: pathspec 'file-i-do-not-have' did not match any files
    $

I'd think in general a user who's screwed up and typo'd both isn't going
to be much harmed by us noting the first, maybe they'll get another
error then.

But usually it's obvious (e.g. you just ran the command in the wrong
directory), so if you have a large list of pathspecs getting a firehose
of all the things that didn't match can be less helpful due to being
overrly verbose.


