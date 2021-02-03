Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F2BC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59AE64F67
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBCFVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 00:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBCFVC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 00:21:02 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4659AC061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 21:20:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f16so4299996wmq.5
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 21:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=61sJOgKklO/nzcxqJhVtuvcN8qYSV60V5Y6+AR6XMsQ=;
        b=cn3pltColBR2QYQDEuWJ2YIJlVFyYmyX20+jLW8+K/VJ83OZeKz3IVzwm9XYlL8v7z
         lEBUfiADofM90FGuYT9B+RhGhY/eG6SG8GQPLfVr249iM35st6yxNfrZK7HBZdrasEkf
         wdZXwpeDMEt1f4eNcNk9bBZjVFYpgOOqYCNPw80hU7pyC6tDgLP/1aHkeEeufqogkqrP
         dVw4mnCpeXno5stFMpPUucHoeqZ4aMWnHHbjWm/JEvbF+1D19Z6hX+A+u3B3XhISjdss
         3UaQm3yI4U5w2zokJtaLiGZhqFBz2AtnX3WoKKAmXEJrvuqnMV0wAK+XE5zS93jxhE0c
         ESwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=61sJOgKklO/nzcxqJhVtuvcN8qYSV60V5Y6+AR6XMsQ=;
        b=jFg444xztwfjQO4soHxD0xunnncQ4of2mYYrXsCc3gkM1EAcF4gnzol+kZyWeMn72k
         lrl1/v/LMhZkVmlX3UQ0bu4Pi00ptKin5BVZRFwS5Yv865rTyvMmuBUjOejskkbiT3b4
         0TJAAvLDFOqtfUzNOTPcym4IlRoQrCdaFEvewC3ye2aadsIPOPBGcPwM3IWbdck2QzDK
         zIJMSxPiFNqkz0bfZeawtF+FHEPLZgvd8vmx1pDkeDqz7D0Z2wndpPDgrjCh9HR+V9PF
         lOHVy/tUnuAhgHhbUc6QOguoEx/BOyn3KeJ9WSEc+xqDKSgAWbb5rQzlHMsyVKJpfpgL
         WH/g==
X-Gm-Message-State: AOAM532d4VZ62vhi2bVptDiIfRcRbytNkT1J5aUxDSaenbrPwKPDXltU
        OkUYCic6KsXqivbeurVaoCQ=
X-Google-Smtp-Source: ABdhPJzjDeKNSjiwGI3ElBLnGxgYH6qcbpJvDxXsO9bP9BpbxoJwKlKnA+TvFQBGi0KJsPksowj9rw==
X-Received: by 2002:a05:600c:19c7:: with SMTP id u7mr1102981wmq.122.1612329620224;
        Tue, 02 Feb 2021 21:20:20 -0800 (PST)
Received: from szeder.dev (84-236-109-63.pool.digikabel.hu. [84.236.109.63])
        by smtp.gmail.com with ESMTPSA id s23sm993864wmc.35.2021.02.02.21.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 21:20:19 -0800 (PST)
Date:   Wed, 3 Feb 2021 06:20:18 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 4/4] init: provide useful advice about
 init.defaultBranch
Message-ID: <20210203052018.GE2091@szeder.dev>
References: <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
 <pull.921.v5.git.git.1607686618.gitgitgadget@gmail.com>
 <ce26446b1a2e7bf14cdf814ca56c37b2e7d6b578.1607686618.git.gitgitgadget@gmail.com>
 <20210202212451.GC2091@szeder.dev>
 <xmqqsg6eds5e.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsg6eds5e.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 02, 2021 at 02:25:01PM -0800, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >> -		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
> >> +		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" -c \
> >> +			init.defaultBranch="${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}" \
> >> +			init \
> >>  			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
> >
> > This breaks GIT_TEST_INSTALLED when the given Git version doesn't yet
> > contain 8b1fa77867 (Allow passing of configuration parameters in the
> > command line, 2010-03-26):
> 
> Yes, but test-installed is about running an old version of Git on
> the current Git test suite.  In the tests we make liberal use of
> "git -c <var>=<val>", which such an old version of Git has no chance
> of passing.  So...

I've never run the whole test suite with GIT_TEST_INSTALLED for the
exact reason you mentioned.  However, I do regularly use it with
custom tests using only commands and options that already existed as
early as v1.6.0 (my go-to "old" version) to check when some
interesting or puzzling behavior appeared, and did just that yesterday
as well.

