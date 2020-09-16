Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B72C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E3421D24
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgIPUr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:47:56 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38246 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgIPRBR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 13:01:17 -0400
Received: by mail-pj1-f68.google.com with SMTP id u3so1844058pjr.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 10:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDNh7ZO5SD3CUZ1aRuKtByYal/zrQ4YCNT6LNwi+6wg=;
        b=UmMqdFUlPokPJ7uK1wxNyt9iSd6I8m+sUCdYxJRPdjn+g7guLVylKo/TCrKtdV9hRD
         Tw7fzz2ASMm8UbqWrrkJy2n4VWpebelFNWovqvoLZCgVYDDRc/HB2d/ihpFBeFLQXlVO
         jUzgW6z+a/FvE3PBvbVJTIT9zQJbYsOAaKCstGX+iGqidWiSRf9DDKhklZbJFfHrDPR/
         7w8v4KT9U8wGt8entd8Wp0uDjTkjigUpX+JdgIFxa0gA48t2rGsuU33cyr+MqCqUJW6E
         dOIOMzbJ67IjVbFaqAr4f0KQeA/HlKf5KvepoIYlLCCLflxJxWmLY2epFOsX+2iOXCxh
         ku9Q==
X-Gm-Message-State: AOAM5330vc2F8qOkX3k+bVzjKNyMvU0yp88mO/mfmYE3BsaB02OK5Sfm
        Wq1527xu2ZH1npfdtyzbiI8SxKTBiX4qzw==
X-Google-Smtp-Source: ABdhPJy5k8Ojo1Ip48m3aUBR3lbrOqCmQaGxUaQi0z2qvLNYrpjLkl1wFLoQ34YGYv/wCGrQxfnuWw==
X-Received: by 2002:a62:2581:0:b029:13f:ba38:b113 with SMTP id l123-20020a6225810000b029013fba38b113mr20871687pfl.15.1600273734549;
        Wed, 16 Sep 2020 09:28:54 -0700 (PDT)
Received: from localhost.localdomain (50-125-94-129.hllk.wa.frontiernet.net. [50.125.94.129])
        by smtp.gmail.com with ESMTPSA id d20sm3072171pjv.39.2020.09.16.09.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 09:28:54 -0700 (PDT)
From:   Sean Barag <sean@barag.org>
To:     stolee@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de, sean@barag.org
Subject: Re: [PATCH 3/4] clone: validate --origin option before use
Date:   Wed, 16 Sep 2020 09:28:39 -0700
Message-Id: <20200916162839.1877248-1-sean@barag.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <bf0107fb-2a6c-68d3-df24-72c6a9df6182@gmail.com>
References: <bf0107fb-2a6c-68d3-df24-72c6a9df6182@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 11 Sep 2020 at 15:24:15 -0400, Derrick Stolee writes:
> On 9/11/2020 2:25 PM, Sean Barag via GitGitGadget wrote:
> > +	strbuf_addf(&resolved_refspec, "refs/heads/test:refs/remotes/%s/test", option_origin);
> > +	if (!valid_fetch_refspec(resolved_refspec.buf))
> > +		/* TRANSLATORS: %s will be the user-provided --origin / -o option */
> > +		die(_("'%s' is not a valid origin name"), option_origin);
>
> Looking at this again, I'm not sure the translators note is
> necessary. Also, I would say "is not a valid remote name".
> That makes the string align with the already-translated string
> in builtin/remote.c.

Makes perfect sense!  My original intention was to provide a separate
use-case specific message, but you're right: "is not a valid remote
name" (as in `builtin/remote.c`) is still very clear.

> This code is duplicated from builtin/remote.c, so I'd rather
> see this be a helper method in refspec.c and have both
> builtin/clone.c and builtin/remote.c call that helper.
>
> Here is the helper:
>
> void valid_remote_name(const char *name)
> {
> 	int result;
> 	struct strbuf refspec = STRBUF_INIT;
> 	strbuf_addf(&refspec, "refs/heads/test:refs/remotes/%s/test", name);
> 	result = valid_fetch_refspec(refspec.buf);
> 	strbuf_release(&refspec);
> 	return result;
> }
>
> And here is the use in builtin/clone.c:
>
> 	if (!valid_remote_name(option_origin))
> 		die(_("'%s' is not a valid remote name"), option_origin);
>
> and in builtin/remote.c:
>
> 	if (!valid_remote_name(name))
> 		die(_("'%s' is not a valid remote name"), name);

That's a fantastic idea -- thanks for the suggestion!  I'll do that for
v2.

> > +test_expect_success 'rejects invalid -o/--origin' '
> > +
> > +	test_expect_code 128 git clone -o "bad...name" parent clone-bad-name 2>err &&
> > +	test_debug "cat err" &&
> > +	test_i18ngrep "'\''bad...name'\'' is not a valid origin name" err
> > +
> > +'
> > +
>
> Double newlines here! I personally appreciate newlines to
> spread out content, but it doesn't fit our guidelines.

Darn, I missed this one.  Thanks for the heads-up :)

--
Sean
