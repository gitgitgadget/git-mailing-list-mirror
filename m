Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA85C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 13:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E60923106
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 13:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbhAFNRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 08:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbhAFNRf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 08:17:35 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE96C06134D
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 05:16:54 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id w1so4875370ejf.11
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 05:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g8OzB65KJ7Euvr5AZajfQu6CbnLYq8lCDF+IsvedlBs=;
        b=BKhCk5PXmm/0vEm/whqwvkexIOkyZp6xuvKMljdOMStFLMFvTSy+Qep1O9r5l6tq59
         qeXnw9l0r+bX/aJuY+5cCfxnxuw2fPaGy/RYEE5SHCg5Y7nQ+w2tHlv1qNDFxi6zMKci
         ZmoT1rbAUIscxGDKAs7Yqo+ESY3GxifLyjcaMONOnV/OeYiwQq3kssXcMeHLiIF+J142
         fReK+AWI7kRIvxULs6pQZtSiuIyEu1DdJ82ualwOWbH7j4oxqAADceqa2BFl2Abul13a
         p8VjhkOsrubBUIJozIfUK5jD6u0xPH+N5YCgYC6MkKiLm8AY4IgjkW0UbtWXWe4VgzMt
         LhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g8OzB65KJ7Euvr5AZajfQu6CbnLYq8lCDF+IsvedlBs=;
        b=F71pWpvhZQdsENwg8XSac8A6+HArcSajg5BA6MZ/E3KHba5Oh5a2G9w2J1xkL69dUi
         kZlO1omm8wQwrmZkDhdTwdEP4Hblk6ahxNHsiuhPOTFjm9bgK0OVpxPokJE4+oQgB+Ca
         pDgOgAaqHSYu9ZMwd9qn/N63BtEzX/xlGPAqI+kIh7Oqh6YpX+8vxu9AakaTV/dP2pGt
         5BDOLsso3uHVFo5dD7FlOKMwk+RZoHkrlZze1r19q21p3uf73y1GVthEmbGNiUV0az0A
         POu/gIbrmSSBUURmMUNWOiXOD6wh5dm8P9JdUNLDi4yHsIb77OSsPWLvNYVB+poxTLYu
         Uwvg==
X-Gm-Message-State: AOAM532yOov3DdTLDnuCmf1YXvavafnLWRyh9Ylk+fh7+lMu+l0CHAPq
        /jAlwN6IfoXafhrzWAnJht4gUnXcNFo=
X-Google-Smtp-Source: ABdhPJwjl0H3QQgerxwXGYeZC1kyEHf5xm0gaSJnC3Z7UI8DuQV7iuGZbFNI3oZayh9S/QG8iv3vbw==
X-Received: by 2002:a17:906:b2d1:: with SMTP id cf17mr2879915ejb.281.1609939013625;
        Wed, 06 Jan 2021 05:16:53 -0800 (PST)
Received: from szeder.dev (84-236-109-79.pool.digikabel.hu. [84.236.109.79])
        by smtp.gmail.com with ESMTPSA id r7sm1448999edh.86.2021.01.06.05.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 05:16:53 -0800 (PST)
Date:   Wed, 6 Jan 2021 14:16:51 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        pudinha <rogi@skylittlesystem.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2] mergetool--lib: fix '--tool-help' to correctly show
 available tools
Message-ID: <20210106131651.GQ8396@szeder.dev>
References: <pull.825.git.1609179751864.gitgitgadget@gmail.com>
 <pull.825.v2.git.1609184505071.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.825.v2.git.1609184505071.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 28, 2020 at 07:41:44PM +0000, Philippe Blain via GitGitGadget wrote:
> To prevent future regressions, add a simple test that counts the number
> of tools shown by 'git mergetool --tool-help', irrespective of their
> installed status, by making use of the fact that mergetools are listed
> by 'git mergetool --tool-help' on lines starting with tabs. Prefix the
> `git config` commands used at the beginning of the test to remove the
> fake tools used by the previous test with 'test_might_fail' so that the
> test can be run independantly of the previous test without failing.

> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index 70afdd06fa7..ebd3af139e5 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -828,4 +828,14 @@ test_expect_success 'mergetool -Oorder-file is honored' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'mergetool --tool-help shows all recognized tools' '
> +	# Remove fake tools added in previous tests
> +	test_might_fail git config --unset merge.tool &&
> +	test_might_fail git config --remove-section mergetool.mytool &&
> +	test_might_fail git config --remove-section mergetool.mybase &&
> +	git mergetool --tool-help >output &&
> +	grep "$(printf "\t")" output >mergetools &&
> +	test_line_count = 30 mergetools
> +'

This new test fails when the topic 'pb/mergetool-tool-help-fix' is
built and tested in isolation, because 'git mergetool --tool-help'
lists only 29 tools instead of the expected 30.  The reason is that
'pb/mergetool-tool-help-fix' doesn't include commit 6bc9082c0f
(mergetools/bc: add `bc4` to the alias list for Beyond Compare,
2020-11-11), which added that 30th tool (and is already part of
v2.30.0).

It also makes me wonder whether this is the right way to test this
fix, because we'll need to adjust this test case every time we add
support for a new merge tool (which arguably doesn't happen that
often, but since we are already at 30 it doesn't seem to be that rare
either).

