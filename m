Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B48EC4320A
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 11:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1E661184
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 11:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245330AbhHFLMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbhHFLMx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 07:12:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4450C061798
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 04:12:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j1so16080994pjv.3
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=PN3p3HB98bTN97bElbZY27bS+TN/IFzXKANwQLF2ZtQ=;
        b=mxxP+lSvcOjlXCClw5dKgO8D2fAGroa2PkqG/dhk12tg+bQMP5D1FQ8dZZgjSrNq8D
         hJIrfPg2UnNaObqj/YnaljcyE4pFG+0tCzBwtsfwmXA+QcXg7sQ+GrU/SUaVZFMaF87m
         enyKH6bsuoK4O77W0jJ4PA1uRNOG2SRAfq9J1Bz9oznZguvGYrxbqN0kiSQqgH3+J8MB
         EvQQNH+T+7zsMSVONWoVN0ux/fqPYU119cbs9L037ypwRPAvU/9v1qe98xNYAnGuSngA
         zw0ksv/pJ9jX1XwUO8eCz9ph78/NCO0hsbhTXjIRlYzYZhllulc5DGBUekhImD63fl58
         Xe/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=PN3p3HB98bTN97bElbZY27bS+TN/IFzXKANwQLF2ZtQ=;
        b=OtEbcmjuvBQyH2nqY8qej4zfoy14VYRkDVtaRXuSNqe0JtRQqCUupS/7oTH2idS237
         8P5uPd0XhlzL+pcYR1vZj91R7moKQK90mO44AFTkQyYcaaahNTzv3OoU94fUKc+pQ1Gc
         y9Mzwd+rEs2zCp/iR3Vy+nlprUuVP4Mw8NC4rZAXoFiL29/M1PUKtbYaZHTL88DrJMag
         0jjKsfs+OM+rMNhWjsYZDODcatH8wYH2tB3Aj8y4D5MqvUWQdUK3EDwwazCjqQQKfq19
         YCYvGlP3IgQQM9Rn7BW8i1nxymtI9eer+mD2+VYqs3XjXKbdWcd4ZFf29Y1Yo9WrWBbm
         BGkg==
X-Gm-Message-State: AOAM532MZEtB79mRhn7zPVl27XmZja4bgieEwFhnG35QtfXUUMsEmQZr
        QGRRD53xFBghGc0dNfTFZ0M=
X-Google-Smtp-Source: ABdhPJzsmCuVNdrx0hLtzbFmxy2smjpvhy9nlp9RBZeLuyXCuKz5FVWI5O4Zn01YuXPQVNmYZ0dCUQ==
X-Received: by 2002:a17:90a:e604:: with SMTP id j4mr20530606pjy.215.1628248357315;
        Fri, 06 Aug 2021 04:12:37 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id c14sm11555190pgv.86.2021.08.06.04.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:12:36 -0700 (PDT)
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805074054.29916-1-raykar.ath@gmail.com>
 <20210805074054.29916-5-raykar.ath@gmail.com> <xmqqim0jk4qx.fsf@gitster.g>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [GSoC] [PATCH v2 4/9] dir: libify and export helper functions
 from clone.c
In-reply-to: <xmqqim0jk4qx.fsf@gitster.g>
Message-ID: <m235rmvnc1.fsf@gmail.com>
Date:   Fri, 06 Aug 2021 16:42:30 +0530
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Atharva Raykar <raykar.ath@gmail.com> writes:
>
>> These functions can be useful to other parts of Git. Let's move them to
>> dir.c, while renaming them to be make their functionality more explicit.
>
> Hmph, guess_dir_name_from_git_url() is not all that more clarifying
> than the original, at least to me.  For a file-scope static helper,
> it probably was good enough with a short name with no function doc,
> but we should describe what it does in comments in dir.h and come up
> with a suitable name, taking input from that description.
>
> [...]
>
>> @@ -1041,8 +927,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>  	if (argc == 2)
>>  		dir = xstrdup(argv[1]);
>>  	else
>> -		dir = guess_dir_name(repo_name, is_bundle, option_bare);
>> -	strip_trailing_slashes(dir);
>> +		dir = guess_dir_name_from_git_url(repo_name, is_bundle, option_bare);
>> +	strip_dir_trailing_slashes(dir);
>
> So, what does this new public helper function guess?  The name of
> the function says it guesses a directory name, but it is not just
> any directory name, but a directory with some specific meaning.
>
> Here repo_name has the URL the user gave "git clone", and even
> though there are some code before this part that computed on the
> variable, it hasn't been modified.  And "from_git_url" is a good way
> to indicate that that is one of the input the function uses to guess
> the name of "the directory with some unknown specific meaning".
>
> I think this codepath wants the new directory to create as the
> result of "git clone" operation in "dir".  So, even though I still
> do not have a good answer to the earlier "this is not just any
> directory but with some specific meaning---what is it?" question,
> adjectives that are appropriate for the "directory" to answer it
> may be along the lines of "new", "resulting", "cloned", etc.

Naming things is hard...

Maybe the right phrase would be 'target directory'? We are creating a
target directory name by looking at the "humanish" part of the Git URL.

I think the intention of all callers of this function is to get a
"default" directory name which will be used as the target of some
operation in the absence of the user providing one.

So maybe the name could be: 'guess_target_dir_from_git_url()'

This would make sense for any operation now or in the future that wants
to reuse this functionality.

>> diff --git a/dir.h b/dir.h
>> index b3e1a54a97..76441dde2d 100644
>> --- a/dir.h
>> +++ b/dir.h
>> @@ -453,6 +453,9 @@ static inline int is_dot_or_dotdot(const char *name)
>>
>>  int is_empty_dir(const char *dir);
>>
>
> We would want docstring here for the function (and possibly rename
> the function to clarify what kind of "dir" we are talking about).

Okay, I will add it.

>> +char *guess_dir_name_from_git_url(const char *repo, int is_bundle, int is_bare);
>> +void strip_dir_trailing_slashes(char *dir);
>> +
>>  void setup_standard_excludes(struct dir_struct *dir);
>>
>>  char *get_sparse_checkout_filename(void);
>
> Thanks.
