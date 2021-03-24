Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55582C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 17:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCDB619EC
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 17:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbhCXRbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 13:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbhCXRbL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 13:31:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4631FC061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 10:31:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso1586652pjb.3
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=plc7QTyIFumCwfbu9IFAXn59BZYKuhe1KptOuSqQAIQ=;
        b=uiZsWRZl9ZzCXJqMCPnDlU8v2+esUdrLR6NXS3SQgKpHy4GBlc83cFJmt5DpvG/Pgz
         /J54BYyKWk4kbKQHQIYJLlUpk5Qj4DJqIcbTEIvdoU/P4DPq4j1Pv7Kqqd/YCO5QQIjk
         ZZdOg09VR/FlW5MUdr2050L11n0vQXRCJ4FdhGKkkPB/xsitaUL/284BxTDtV16ssxo4
         k5pCflIed6ZBrKtcJjmaohe2MfFjh+VSnq2lUkg/xrEG3LRlTW0h7iKMAw4VmD3gwTyR
         g3YoIcpZNQE673N8fHKbo/L8buNPwStJIt6wrxSoF1rYGrjS9dbRSbFeWqXXslvvFyTC
         SqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=plc7QTyIFumCwfbu9IFAXn59BZYKuhe1KptOuSqQAIQ=;
        b=WT+oxSh5ygwcIW5ifA4J3H7BJLwSguLKhhtlB1pai4y7zJewiK4X3wS7VL17iEpJ/2
         uWbJ9dNdlK+geCS2pbRcGxX/CoKnpdnl/rhnTNm2E10sdORtNlrrARjTzHpk4KesrnS1
         HQ9nL4qxk0QFljeBISMwQl5xVxvKVsUqZ4CO0zt1ZximNyeJxCFowOUt26ipmRG9EF40
         A9AV3VC+Q8mf7/biiAIJj4ruYgTQ4HVzZGajTZsf8zd9B28tBU3JQPwveVMcrrridn80
         FXktyGB5vYs+iBESUsYS340R2TRCP+cv1MvKlKITv2diNZ+ifDcQzP2klABWP9v2LjMm
         mMpQ==
X-Gm-Message-State: AOAM533uVrY9rovTZUISLrti9WaLTbz5Xdiavn/LmwUlyLdgNzPb0YrO
        ejWucCjayJE3ZltXkBXpTLhSessJn+cjGg==
X-Google-Smtp-Source: ABdhPJzvjZ4hkrOLqeCSxYKSuJnowcjrqyAvKblGOB4QRnB7OdDSLesx4EyZIeO7GPNPQ20l4mLa1w==
X-Received: by 2002:a17:90b:1202:: with SMTP id gl2mr4525925pjb.121.1616607070646;
        Wed, 24 Mar 2021 10:31:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:d027:9201:1f66:e720])
        by smtp.gmail.com with ESMTPSA id x186sm3118922pfc.65.2021.03.24.10.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:31:09 -0700 (PDT)
Date:   Wed, 24 Mar 2021 10:31:04 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 03/37] hook: add list command
Message-ID: <YFt3WOAGVKohAF6X@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-4-emilyshaffer@google.com>
 <87o8fohjgq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8fohjgq.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 09:20:05AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Mar 11 2021, Emily Shaffer wrote:
> 
> > diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
> > new file mode 100644
> > index 0000000000..71449ecbc7
> > --- /dev/null
> > +++ b/Documentation/config/hook.txt
> > @@ -0,0 +1,9 @@
> > +hook.<command>.command::
> > +	A command to execute during the <command> hook event. This can be an
> > +	executable on your device, a oneliner for your shell, or the name of a
> > +	hookcmd. See linkgit:git-hook[1].
> > +
> > +hookcmd.<name>.command::
> > +	A command to execute during a hook for which <name> has been specified
> > +	as a command. This can be an executable on your device or a oneliner for
> > +	your shell. See linkgit:git-hook[1].
> > diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> > index 9eeab0009d..f19875ed68 100644
> > --- a/Documentation/git-hook.txt
> > +++ b/Documentation/git-hook.txt
> > @@ -8,12 +8,65 @@ git-hook - Manage configured hooks
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git hook'
> > +'git hook' list <hook-name>
> 
> Having just read this far (maybe this pattern is shared in the rest of
> the series): Let's just squash this and the 2nd patch together.
> 
> Sometimes it's worth doing the scaffolding first, but adding a new
> built-in is so trivial that I don't think it's worth it, and it just
> results in back & forth churn like the above...

Yeah, I think you are right here :)

> > +void free_hook(struct hook *ptr)
> > +{
> > +	if (ptr) {
> > +		strbuf_release(&ptr->command);
> > +		free(ptr);
> > +	}
> > +}
> 
> Neither strbuf_release() nor free() need or should have a "if (ptr)" guard.

I'll take free() out of the if guard, but I think
'strbuf_release(&<null>->command)' will go poorly - dereferencing the
NULL to even invoke strbuf_release will not be a happy time, and
strbuf_release internally is not NULL-resistant.

> > +struct list_head* hook_list(const struct strbuf* hookname)
> > +{
> > +	struct strbuf hook_key = STRBUF_INIT;
> > +	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
> > +	struct hook_config_cb cb_data = { &hook_key, hook_head };
> > +
> > +	INIT_LIST_HEAD(hook_head);
> > +
> > +	if (!hookname)
> > +		return NULL;
> 
> ...if a strbuf being passed in is NULL?

Yeah, I think this is misplaced. But since it sounds like generally
folks don't like having the strbuf at the input here, I will address the
error checking then also.

> 
> > [...]
> > +ROOT=
> > +if test_have_prereq MINGW
> > +then
> > +	# In Git for Windows, Unix-like paths work only in shell scripts;
> > +	# `git.exe`, however, will prefix them with the pseudo root directory
> > +	# (of the Unix shell). Let's accommodate for that.
> > +	ROOT="$(cd / && pwd)"
> > +fi
> 
> I didn't read up on previous rounds, but if we're squashing this into 02
> having a seperate commit summarizing this little hack would be most
> welcome, or have it in this commit message.

Sure. I squashed it in from a commit dscho sent, so I can preserve that
commit in tree instead.

> 
> Isn't this sort of thing generally usable, maybe we can add it under a
> longer variable name to test-lib.sh?

I wonder. `git grep cd \/ &&` shows me that this hack also happens in
t1509-root-work-tree.sh. I think most tests must use relative paths, so
this must not be in broad use? But since it's not used elsewhere I feel
ambivalent about adding a helper to test-lib.sh. I can if you feel
strongly :)

 - Emily
