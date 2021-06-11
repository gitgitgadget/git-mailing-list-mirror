Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABFBC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 14:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989426100B
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 14:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhFKOh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 10:37:57 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:39801 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhFKOh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 10:37:57 -0400
Received: by mail-oo1-f52.google.com with SMTP id 67-20020a4a01460000b0290245b81f6261so753280oor.6
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=O6WaPyEDjVJ0pYHretk4fBHIj+K0M8AJMD07iWcLPrg=;
        b=TWJPjDhwB0eKXn+Z40uQ0DI9TCFsiK1JRY5UcSq0HvyslVTyn+1DuTFx5npS+5dN2h
         iBYIqTtOb05z+0jaRmhnUFbBtty7bQOWkXgxhK36d9FYj0JwkhkOzxWt9LT9dJY23qkP
         w0nBmvebzXMWfriKK6PQmDjx+ciOeYVehJfORqrJu/GCGn6VTUhU/bnnVu6HiB5xc4j1
         2l2PfMfDIGrglEN2frXW/uT2qVCEZmlaoTJVEOtKoORlOJOuP5C+BjDQAO534WfJge2X
         tYKW03L6FluAR18zRANyXowqiy1zC5sEwf02TFLtHon3aRdscQZQ2ppnBkICSgEQQwDh
         SfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=O6WaPyEDjVJ0pYHretk4fBHIj+K0M8AJMD07iWcLPrg=;
        b=keKvLeogSqfapE5yPDuoNQJJj6qTVKg7BIbHg5RW0+6T+6nTRTFXoSTmfiQnYlLtxW
         M8GPL0gwZkm3BKCkXYDn6tB+wi+Po7v5UEU6QMk97lRVf5W6DAhGizmiMTY3krwys2me
         yf4SUGdJbfkEUbMM+3N6PFYWaZwO/me19lWzTTFdtw2oydHjH9YXR44tjG1GAgxzVNDx
         HpPHRf6UpJm/jqcR1M1vCmYXnVMZrvJqrmICjEKAAOkU49ACCb3tiDRgEEc9l647yzO1
         u9S8sEEytTrolQbJsYW1HPe/D2MLBojmORMmKyKgFRuerxKzvLyXiwOVbmCgbUX9B5ti
         zTsg==
X-Gm-Message-State: AOAM532XDzAlhR38iYmKBZjhkcwD6kudSG5DkMSj+/qG1JefxGGEsdzK
        WkRfuHrZL0eWvuENPkKnM8c=
X-Google-Smtp-Source: ABdhPJwP62cgqKN5mF+Id5p/4EcfoSKqr6RUf7xufcQT/tU8dwQ72icagx6SxoXwIfP81u0yy6wNsQ==
X-Received: by 2002:a4a:97ab:: with SMTP id w40mr3310910ooi.19.1623422082583;
        Fri, 11 Jun 2021 07:34:42 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id b8sm1331941ots.6.2021.06.11.07.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:34:42 -0700 (PDT)
Date:   Fri, 11 Jun 2021 09:34:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <60c37480c6ab9_3ad920882@natae.notmuch>
In-Reply-To: <5164b67c-d701-077f-7743-aea4ae13779d@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-5-felipe.contreras@gmail.com>
 <b4b9264d-1c17-1a62-f0ec-2791ab20adeb@gmail.com>
 <60c21d9ce8848_b25b120884@natae.notmuch>
 <49da6d73-c49f-d75e-0eb2-b12bd529fcfa@gmail.com>
 <60c23e8b7f672_b25b1208d2@natae.notmuch>
 <5164b67c-d701-077f-7743-aea4ae13779d@gmail.com>
Subject: Re: [PATCH 4/7] checkout: fix merge.conflictstyle handling
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 10/06/2021 17:32, Felipe Contreras wrote:
> > Phillip Wood wrote:
> >> On 10/06/2021 15:11, Felipe Contreras wrote:
> >>> Phillip Wood wrote:
> >>>> On 09/06/2021 20:28, Felipe Contreras wrote:
> >>>>> Currently both merge.conflictStyle and `git commit --merge
> >>>>> --conflict=diff3` don't work together, since the former wrongly
> >>>>> overrides the later.
> >>>>>
> >>>>> The way merge configurations are handled is not correct.
> >>>>> It should be possible to do git_config(merge_recursive_config, ...) just
> >>>>> like we can with git_diff_basic_config and others.
> >>>>
> >>>> It would be helpful to explain what the problem with
> >>>> merge_recursive_config() actually is rather than just saying "it should
> >>>> be possible ..."
> >>>
> >>> The problem is that you can't do this:
> >>>
> >>>     git_config(merge_recursive_config, NULL);
> >>>
> >>> As it was explained.
> >>
> >> You do not explain why you cannot do that
> > 
> >    % git grep merge_recursive_config
> >    static void merge_recursive_config(struct merge_options *opt)
> > 
> > For starters it's a static function.
> > 
> > Second, clearly the type of functions git_config() receives are not
> > `void (*)(struct merge_options *)`.
> > 
> > I mean, I do see value in explaning as much detail as needed in the
> > commit message, but it shouldn't be a lesson on git's codebase:
> > git_config() is a standard thing, and it's even mentioned in the user
> > manual.
> 
> I'm not asking for a lesson on git's config system, I'm asking you to 
> add a sentence to the commit message to explain what the problem is 
> rather than just saying "you should be able to do this but you can't".

Yes, but why? What possible reason could there be for this to fail? Can
you list two?

  git_config(merge_recursive_config, NULL);

But more importantly, why does it matter? How would it change the patch?

> > https://git-scm.com/docs/user-manual#birdview-on-the-source-code
> > 
> >>> That is the problem. I don't know how that's not clear.
> >>>
> >>>>> Therefore builtins like `git merge` can't call this function at the
> >>>>> right time.
> >>>>    >
> >>>>> We shuffle the functions a little bit so at least merge_recursive_config
> >>>>> doesn't call git_xmerge_config directly and thus override previous
> >>>>> configurations.
> >>>>
> >>>> Rather than papering of the problem, how difficult would it be to add a
> >>>> field to ll_merge_options and pass the conflict style with that rather
> >>>> than fiddling with the order that we set a global variable.
> >>>
> >>> Probably not that difficult, but then we also need a parser that
> >>> converts from "diff3" to whatever values we decide in that new field. We
> >>> would need a new parse_config_conflict_style() function.
> >>> And that function will be only used by `git checkout` and nothing else.
> >>> So I don't think there's much value in it.
> >>
> >> It would allow us to add a --conflict option to all the mergey commands
> >> in the future and would be much easier to reason about than the approach
> >> of juggling where we call git_xmerge_config().
> > 
> > Feel free to write a patch for that.
> > 
> >> This patch requires us to audit all the code paths that end up in
> >> merge_recursive_config() to make sure they now call
> >> git_xmerge_config() themselves. You don't seem to have done that as
> >> you don't know if am/apply are affected or not.
> > 
> > That is a separate issue, that I already mentioned...
> 
> I know you are going to add some tests but the point is that when making 
> a change like this you need to actively audit all the callers of 
> init_merge_options() and ensure that they are now calling 
> git_config(git_xmerge_config) and base you tests on what you find while 
> doing that.

And what makes you think I haven't?

If developers were perfect there would be no need for code review.

> Have you run 'grep init_merge_options()' to see where it is 
> being called?

Now that is insulting.

Cheers.

-- 
Felipe Contreras
