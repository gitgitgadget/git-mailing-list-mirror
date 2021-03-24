Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BF0C433E5
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F11161A01
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbhCXVac (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 17:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbhCXVaB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 17:30:01 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554A9C06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:30:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j25so18433034pfe.2
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PBCUd/rYi3Pn6HO/qppD4Ka7VKta/we3hiow1pcw6DA=;
        b=tnn+xZ92imsuK3zMUB7BXcWoHP5To8w3uV1/L1xx+pzKy/zGgLG2H7G2+heS/E1Zy5
         fersIHf/2Dd4Nuhdh5e38XmAxMjfz9H1zlj6t7OmiPgl/HhLOrgsG+WD8Xd/TB+PoOdJ
         e9JM68RjjBxdaQ3tgKSS+kUCMQdXIsUfSS7hTzApMvo5UtVxlQgb7Bz9vhIiPPMj47LD
         EUbYzEc7kBKb4Yfp32V+/7e9V9O2Lq3WbHytxy43KyLknDXyb+Zyu7MXsPh1LDm/VfAw
         AYfR/iOARNFX5gQ2ijU2BIj/1CG862C4Glgs1+w/K5gZ4IPzkyeVmZAFj45f9Gglre2h
         zLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PBCUd/rYi3Pn6HO/qppD4Ka7VKta/we3hiow1pcw6DA=;
        b=D/dbdZqzY5jlgUncCvSEO1gg26PBC8GbaAeDep8zBMPRsPAw7bz5uzvm/sgENMs52v
         ZEtpWTlH2W3xvKb/4Mv2u+AA13+lHuHlDjhpsboRRtmAQHAQU5N55sgvAqx5g4RooqHA
         am3A9Ey+iqUowgxsj6rp/1w61aQio8notfo6pAYbJsNpScoz93yhuCWsF8QRVbbZooEe
         RNiiMjUSFzplA4EEQPL0NAUGPbEMUnMLotor3vNh7bptY8Rie4Vb/opCgGd1ugDuHdzB
         bn4n/SANdtDHpTbJq+fR+Y31ZVhBRszTW5iiyUVX9dVFoLKiPFb1mpM8+WKJhfMwwQ6f
         5pmw==
X-Gm-Message-State: AOAM532ByzTwu0BOO7ugVV3oHpavJDeFwu7npnHrjAMkiNyuh36vr73e
        ZTZH8M2ThtZjYwlG8xf7AApmUetHFexcCg==
X-Google-Smtp-Source: ABdhPJyB3Ls8fD0dq95UTCdGgstXeogezPVBEjmiduK479Ta/1jPDf08oVUiol41P7Sgb4oqLsZ1/w==
X-Received: by 2002:a63:6c9:: with SMTP id 192mr4704626pgg.302.1616621400631;
        Wed, 24 Mar 2021 14:30:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:d027:9201:1f66:e720])
        by smtp.gmail.com with ESMTPSA id u79sm3684031pfc.207.2021.03.24.14.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:29:59 -0700 (PDT)
Date:   Wed, 24 Mar 2021 14:29:54 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 08/37] hook: add 'run' subcommand
Message-ID: <YFuvUlMOaJ0qAxzk@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-9-emilyshaffer@google.com>
 <87a6r8hhvf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6r8hhvf.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 09:54:28AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Mar 11 2021, Emily Shaffer wrote:
> 
> >  'git hook' list <hook-name>
> > +'git hook' run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] <hook-name>
> 
> [...]
> 
> > +	switch (cfg)
> > +	{
> > +		case HOOKDIR_ERROR:
> 
> Overly indented case statements again.
Thanks. Probably need to fix my autoformatter or something.
> 
> > +			fprintf(stderr, _("Skipping legacy hook at '%s'\n"),
> > +				path);
> > +			/* FALLTHROUGH */
> > +		case HOOKDIR_NO:
> > +			return 0;
> > +		case HOOKDIR_WARN:
> > +			fprintf(stderr, _("Running legacy hook at '%s'\n"),
> > +				path);
> > +			return 1;
> > +		case HOOKDIR_INTERACTIVE:
> > +			do {
> > +				/*
> > +				 * TRANSLATORS: Make sure to include [Y] and [n]
> > +				 * in your translation. Only English input is
> > +				 * accepted. Default option is "yes".
> > +				 */
> > +				fprintf(stderr, _("Run '%s'? [Yn] "), path);
> 
> Nit: [Y/n]
ACK

> 
> > +				} else if (starts_with(prompt.buf, "y")) {
> 
> So also "Y", "yes" and "yellow"...
That's also how add-patch.c:prompt_yesno(),
builtin/bisect--helper.c:decide_next(), and
git-add--interactive.perl:prompt_yesno (assuming I'm grokking the perl
correctly) work. builtin/clean.c:ask_each_cmd checks that the user's
reply matches a substring anchored to the beginning (e.g. "y", "ye",
"yes").  git-diftool--helper.sh:launch_merge_tool just checks for "not
'n'". And git-send-email.perl:ask just checks for "'y' or not".

So I think there's a little flexibility :) But I like builtin/clean.c's
approach most out of these, so I'll switch.

> 
> > [...]
> >  	git hook list pre-commit >actual &&
> >  	# the hookdir annotation is translated
> > -	test_i18ncmp expected actual
> > +	test_i18ncmp expected actual &&
> > +
> > +	test_write_lines n | git hook run pre-commit 2>actual &&
> > +	! grep "Legacy Hook" actual &&
> > +
> > +	test_write_lines y | git hook run pre-commit 2>actual &&
> > +	grep "Legacy Hook" actual
> > +'
> > +
> > +test_expect_success 'inline hook definitions execute oneliners' '
> > +	test_config hook.pre-commit.command "echo \"Hello World\"" &&
> > +
> > +	echo "Hello World" >expected &&
> > +
> > +	# hooks are run with stdout_to_stderr = 1
> > +	git hook run pre-commit 2>actual &&
> > +	test_cmp expected actual
> > +'
> > +
> > +test_expect_success 'inline hook definitions resolve paths' '
> > +	write_script sample-hook.sh <<-EOF &&
> > +	echo \"Sample Hook\"
> > +	EOF
> > +
> > +	test_when_finished "rm sample-hook.sh" &&
> > +
> > +	test_config hook.pre-commit.command "\"$(pwd)/sample-hook.sh\"" &&
> > +
> > +	echo \"Sample Hook\" >expected &&
> > +
> > +	# hooks are run with stdout_to_stderr = 1
> > +	git hook run pre-commit 2>actual &&
> > +	test_cmp expected actual
> > +'
> > +
> > +test_expect_success 'hookdir hook included in git hook run' '
> > +	setup_hookdir &&
> > +
> > +	echo \"Legacy Hook\" >expected &&
> > +
> > +	# hooks are run with stdout_to_stderr = 1
> > +	git hook run pre-commit 2>actual &&
> > +	test_cmp expected actual
> > +'
> > +
> > +test_expect_success 'out-of-repo runs excluded' '
> > +	setup_hooks &&
> > +
> > +	nongit test_must_fail git hook run pre-commit
> >  '
> >  
> >  test_expect_success 'hook.runHookDir is tolerant to unknown values' '
> 
> No tests for --env or --arg?

Yikes, I guess not. Thanks, will add.

 - Emily
