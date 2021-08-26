Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85DBC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 22:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9276361004
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 22:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbhHZWvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 18:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhHZWvX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 18:51:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D8C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 15:50:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j2so2723738pll.1
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 15:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HxU0eLqEKauV0lKhfNXlKp6e0R39y8LfNi35i9fhCX8=;
        b=AGnMPf4VeB8VIeLM8SDgs+vSzSqu7MDIeYfvIltLUzsd/e+aGvnHzKMQTeP468boGf
         qYqyt9GYorGEEdzr4AYnNZynShy5HwR5Wd/dyOov3OEGVlZlDr+sfK6p/fJoud03cE99
         3dmEaPHERAq0xSFRGuEze1SEp3r+FIL/zD6J9qYZJc8vhmL0armWlScnlLLqNpnKoD+C
         t0q6wSWocumGRD9gtcXrB9xZsLOVcprdR+WdrD+K2fvAtEytiYv526qpzmDWpRwWGDps
         DaT8rUfrRlkDOVVo+qB7oIN8ZO70cgameRiI/tWINVNyJSMqB2Dzg/iGY5VIgX0R5ZE8
         yC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HxU0eLqEKauV0lKhfNXlKp6e0R39y8LfNi35i9fhCX8=;
        b=Qeg2baBj7Yg+lTqOVE3zfAoOlhn9ta2gDYGuG1UnTVEOkGf0PI2ZzFPChyB6Lvs6kx
         CO309WCW7uc2Glm2SJdHtQrQ0yWQExltyZRjNdMMiHVARN5HnON4bStW/Yu6ceHtS/l2
         cAwR4YkEMwnsHnPCrmZXslSXNOQb9Lv8eEu6pPDvobixXZhDymWT7dblx1j+ku3eEwLH
         JpJXLjXQuPwsRcl318mMK2oxemNfWQTytMH84eO83XxKkJbJIYl2Jbux9jdAGgUdu7DT
         lwTS+jjjUkft2lHUQUPBj9s4PGxJMVTfjm5RqREEBQUSkQ4aM3bm7fhvebOfJHNrzKig
         s+uQ==
X-Gm-Message-State: AOAM532sNRnH9rJ4jCEU+Bn+GxfMPTLUIe5EXauvxSdph+CflYUWZ8gq
        e5NiunX7QieqWcb4+TG/YqNV8rWQzHPCmw==
X-Google-Smtp-Source: ABdhPJyH3PijEwJ76B1NrQIfEEMSy4R1pajnoTfFT7sejk1ccNQI5A+FFIvc/yJtvsBl1Kg9fWS7Lw==
X-Received: by 2002:a17:90a:2fc2:: with SMTP id n2mr6671338pjm.112.1630018234389;
        Thu, 26 Aug 2021 15:50:34 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:c1d9:3a1d:fe59:b07a])
        by smtp.gmail.com with ESMTPSA id a2sm4686961pgb.19.2021.08.26.15.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 15:50:33 -0700 (PDT)
Date:   Thu, 26 Aug 2021 15:50:28 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] hook: allow running non-native hooks
Message-ID: <YSgatN5kYwLJtDMQ@google.com>
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-5-emilyshaffer@google.com>
 <87o89mej3y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o89mej3y.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 05:55:13PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Wed, Aug 18 2021, Emily Shaffer wrote:
> 
> > As the hook architecture and 'git hook run' become more featureful, we
> > may find wrappers wanting to use the hook architecture to run their own
> > hooks, thereby getting nice things like parallelism and idiomatic Git
> > configuration for free. Enable this by letting 'git hook run' bypass the
> > known_hooks() check.
> >
> > We do still want to keep known_hooks() around, though - by die()ing when
> > an internal Git call asks for run_hooks("my-new-hook"), we can remind
> > Git developers to update Documentation/githooks.txt with their new hook,
> > which in turn helps Git users discover this new hook.
> >
> > [...]
> >
> > +It's possible to use this command to refer to hooks which are not native to Git,
> > +for example if a wrapper around Git wishes to expose hooks into its own
> > +operation in a way which is already familiar to Git users. However, wrappers
> > +invoking such hooks should be careful to name their hook events something which
> > +Git is unlikely to use for a native hook later on. For example, Git is much less
> > +likely to create a `mytool-validate-commit` hook than it is to create a
> > +`validate-commit` hook.
> > +
> >  SUBCOMMANDS
> >  -----------
> 
> The goal here makes sense, but...
> 
> > diff --git a/builtin/hook.c b/builtin/hook.c
> > index d21f303eca..80397d39f5 100644
> > --- a/builtin/hook.c
> > +++ b/builtin/hook.c
> > @@ -46,7 +46,7 @@ static int list(int argc, const char **argv, const char *prefix)
> >  
> >  	hookname = argv[0];
> >  
> > -	head = hook_list(hookname);
> > +	head = list_hooks_gently(hookname);
> >  
> >  	if (list_empty(head))
> >  		return 1;
> > @@ -105,7 +105,7 @@ static int run(int argc, const char **argv, const char *prefix)
> >  	git_config(git_default_config, NULL);
> >  
> >  	hook_name = argv[0];
> > -	hooks = list_hooks(hook_name);
> > +	hooks = list_hooks_gently(hook_name);
> >  	if (list_empty(hooks)) {
> >  		/* ... act like run_hooks_oneshot() under --ignore-missing */
> >  		if (ignore_missing)
> 
> This introduces a bug v.s. the previous state, e.g. before:
> 
>     $ git hook run --ignore-missing foobar
>     fatal: the hook 'foobar' is not known to git, should be in hook-list.h via githooks(5)
> 
> But after we'll silently ignore it. I.e. we've conflated
> --ignore-missing with a new and hypothetical (and this is now a synonym
> of) --ignore-missing-and-allow-unknown-hook-names.
> 
> So we've conflated the user's one-shot "foobar" script with wanting to
> catch a typo in e.g. git-send-email.perl.
> 
> Also instead of the user's typos being caught with a die (here using
> your BUG(...) version):
> 
>     $ git hook list pre-recive
>     BUG: hook.c:115: Don't recognize hook event 'pre-recive'! Is it documented in Documentation/githooks.txt?
>     Aborted
> 
> We'll now silently return 1, so indistinguishabl from typing it properly
> as pre-receive.
> 
> All that being said I think it's arguable that if we're going to allow
> "git hook run blahblah" that the die() in the base topic in my
> "hook-list.h: add a generated list of hooks, like config-list.h" is more
> trouble than it's worth.
> 
> I.e. do we really need to be concerned about new hooks being added and
> someone forgetting a githooks.txt update, or a typo in the git.git code
> that nobody notices? Probably not.
> 
> But I think the change here is clearly broken vis-a-vis the stated goals
> of its commit message as it stands, i.e. "[...]we do still want to keep
> known_hooks() around, though[...]". Should we fix it by adding a new
> internal-only flag to the command, or just saying we shouldn't have the
> behavior at all? What do you think.

I think it's A) pretty important to make it easy for users to run
whatever not-necessarily-git-native hook they want, and B) useful for
script Git commands to take advantage of the typo check. So, I'll add a
`--enforce-known-hookname` (or maybe a better named one, this isn't my
strong suit) and switch git-send-email and friends to use it. Like we
discussed off-list, I think it's a good idea to drop the envvar for
exceptional test names from the codebase entirely.

> 
> Aside from that, this change seems to be untested, I tried making this
> non-gentle for testing, and all tests still passed. I.e. we don't have
> any tests for running such a hook like mytool-validate-commit, but
> should as part of this change.

Sure.


Actually, I was in the middle of typing about how I wouldn't change your
'test-hook' and so on tests, and it occurs to me that it might actually
be a better fit for your series to add this --reject-unknown (or
whatever) flag, instead of the envvar magics. So I'll hold off on making
any changes unless I hear from you.

 - Emily
