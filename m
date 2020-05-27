Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83ADC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 23:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8D42075F
	for <git@archiver.kernel.org>; Wed, 27 May 2020 23:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Duugzv85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgE0Xh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 19:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0Xh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 19:37:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10821C08C5C1
        for <git@vger.kernel.org>; Wed, 27 May 2020 16:37:57 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d10so12541992pgn.4
        for <git@vger.kernel.org>; Wed, 27 May 2020 16:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fu7EDbVQVkoCoPjBn9YIGcPS1rP9R9ImY5BxZBXJj2E=;
        b=Duugzv85sDEFa1nH2qXdDCblPk8lFnqOuY9CjGQpGxwrZAZI5nEPpMB79w+OBLaaVF
         QI2X4keF+rm+Yb9YXMx6/MWQMQ1i0+CRQyP5HTl0XyFkbMShasY4qgLUONWZZfniams3
         SNt8xud+SQmN+GhCZZ7Nlug96N73lUffS602E0JpvQg+bIwceUCzGeSJ5lzz3agt8JSV
         aUB7663q9kQbBZLhMJh7fSMbus1KY3xV0bmTgRYEA20QSwt5CQ8+ClitrjgwfCRXrgmi
         K1wthKQnzwce27o292FSTgC0QBlidMZBK1qjg+SlDz70JfW6OTd2PvgcdyLdNu1W6DdU
         S4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fu7EDbVQVkoCoPjBn9YIGcPS1rP9R9ImY5BxZBXJj2E=;
        b=CBB28rCMDy+vtUvLDAuK88DMgdq5F2ZyFQMdMdCTmyhzr1WKp8oNGvVbJnlT0+WD2Z
         rrlRzv3YhEsgQs39z0PijkaOYE/P8VeTM5gATYmGrGiK/1nNJdfMWRf8kmd9kHsHOmhE
         pDLxENPStuxQtgcZNYJ/I+ij4C3mChxLexu6r0OO9l+Krqbs6fh7SfQOVcHaGtdpQu3q
         SQpdVhuuQ8WqHBsazGWL7knO9VjoDnTKYbQueVkyAngj92aA8ml91fzf2Gq9b8Zexrl7
         7BxVvDLTu/FiKBdu3tXCDrlWaIUq4pdv7KBWjvNy6iitCOTo7cfIICki2halBg0ls8si
         7wrw==
X-Gm-Message-State: AOAM530tLF6fkpsG38ArTv3U2HhrMONOMpTem/1dzG9znGNZ7DuVdz8k
        hDVg9nQ54n3Ju+MWkGIGXkelOkPmLMk=
X-Google-Smtp-Source: ABdhPJxYlmYQSRyZB4IWUhU7QN63zV7xkCMCBKPD8nIgfQ1UYiFkhjZJD2odevWFkscMAyGH12kuXw==
X-Received: by 2002:aa7:9298:: with SMTP id j24mr173964pfa.209.1590622676293;
        Wed, 27 May 2020 16:37:56 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id a14sm2889188pfc.133.2020.05.27.16.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 16:37:55 -0700 (PDT)
Date:   Wed, 27 May 2020 16:37:49 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hook: add list command
Message-ID: <20200527233749.GC196295@google.com>
References: <20200521185414.43760-1-emilyshaffer@google.com>
 <20200521185414.43760-4-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.2005250055180.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2005250055180.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 25, 2020 at 01:00:03AM +0200, Johannes Schindelin wrote:
> cc: git@vger.kernel.org
> 
> Hi Emily,
> 
> On Thu, 21 May 2020, Emily Shaffer wrote:
> 
> > diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
> > index 34b0df5216..4e46d7dd4e 100755
> > --- a/t/t1360-config-based-hooks.sh
> > +++ b/t/t1360-config-based-hooks.sh
> > @@ -4,8 +4,55 @@ test_description='config-managed multihooks, including git-hook command'
> >
> >  . ./test-lib.sh
> >
> > -test_expect_success 'git hook command does not crash' '
> > -	git hook
> > +test_expect_success 'git hook rejects commands without a mode' '
> > +	test_must_fail git hook pre-commit
> > +'
> > +
> > +
> > +test_expect_success 'git hook rejects commands without a hookname' '
> > +	test_must_fail git hook list
> > +'
> > +
> > +test_expect_success 'setup hooks in global, and local' '
> > +	git config --add --local hook.pre-commit.command "/path/ghi" &&
> > +	git config --add --global hook.pre-commit.command "/path/def"
> > +'
> > +
> > +test_expect_success 'git hook list orders by config order' '
> > +	cat >expected <<-\EOF &&
> > +	global:	/path/def
> > +	local:	/path/ghi
> > +	EOF
> > +
> > +	git hook list pre-commit >actual &&
> > +	test_cmp expected actual
> 
> This, as well as the next two test cases, won't work on Windows, as you
> almost certainly realized from looking at the failed GitHub workflow run
> of your branch.

Thanks very much for sending this - to be honest, the failed workflow
run appeared to be because of the earlier SDK download issue, which I
have not rebased on top of a fix for yet, so I missed any actionable
failures when I ran the CI locally. I'll take it into account, much
appreciated.

 - Emily
