Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F31C433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 19:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380216AbiD2TKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353413AbiD2TKP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 15:10:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5274B0D04
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 12:06:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y3so17095771ejo.12
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 12:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e+8oOt7u7SOrcGHPxMQ7ccRoCR5+cB+Ji5SpMX2yp1M=;
        b=L0wB9vW3LlsEYZVEDEFSg4kRN44Y92x8boz6oUoReP3eFPwoyQCHeonbRZyDgL+Kn5
         UpdO4dI1vWD83hCT36dDMeqhPZNkdPlCIUW1IAvkmWPKRSvaiEebJ3G8bz52b7xAQZoo
         nQs9367xRqR2KNorA54lAh0M2UISZeuJBhKs0PP9PBZvZS/77adz8OE7WT8LivarUzMv
         ZIgep6O8XrJsID6O2URfNvr3Nw7lAWs8ARBpfCE9r9+mnT3P3C5nppDNsMmTVrYNr/dt
         ErN8Vvuf3jT/PDj/Q5CaqX2s3UZbAnbPbXUYmp4Zz0Pl/OOwaZZwI/BZvGeqkxsV2fOX
         fQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e+8oOt7u7SOrcGHPxMQ7ccRoCR5+cB+Ji5SpMX2yp1M=;
        b=s40R2tYiJ95fRi84VETE3J+AqBPhYpMXdPMzvWPn1KjeKWpo6vzAoaokERon1DF7TF
         70Vhvh4XmLNEeCUnO4wAK9OBRceTeTRpHUGpLw/HtDCbSFW93937F8Th5m/7NmChXqR6
         QFJUxNK7IM/aojGc8d4fhwibfoRUqQc4JBQg3HrALxwM/Hb7tn7Gd/GB+ZCecIm47xgf
         1tDixoaNnbZqQ0iEAQv6j+I5kBbpe58S4uF5udMb9LqjDx7i85HZeH7BudmYYt3GPUDl
         GIeAWP1RuaIsi8cmPOe5Z1DaBg8FJLQO9Q4pz2lTKVNpsElztVA+kFD4bMJaiIYXpV1e
         nzvQ==
X-Gm-Message-State: AOAM5338TFWiBm0QrSAmkk+dpX0BmqCifF4rpUKqcxA4espl+9A5qP1e
        3aq95yqMmeaojWcVR4q5bss=
X-Google-Smtp-Source: ABdhPJyObmSDqBTUkYCJufsg5S7Px7EglukRfaVvx9f/NRtyQLYHoQUe6brR5s2z3XyggMEgrKGkhw==
X-Received: by 2002:a17:907:d20:b0:6f3:be6a:ece8 with SMTP id gn32-20020a1709070d2000b006f3be6aece8mr675358ejc.503.1651259214235;
        Fri, 29 Apr 2022 12:06:54 -0700 (PDT)
Received: from szeder.dev (84-236-109-183.pool.digikabel.hu. [84.236.109.183])
        by smtp.gmail.com with ESMTPSA id og13-20020a1709071dcd00b006f3ef214e3fsm896306ejc.165.2022.04.29.12.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 12:06:53 -0700 (PDT)
Date:   Fri, 29 Apr 2022 21:06:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/3] t0033-safe-directory: check when 'safe.directory' is
 ignored
Message-ID: <20220429190625.GA1626@szeder.dev>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
 <20220427170649.4949-3-szeder.dev@gmail.com>
 <xmqqr15il0uo.fsf@gitster.g>
 <a44b4f0e-038c-9bcd-80d6-f53c87bd7f2d@github.com>
 <xmqq8rrndb6h.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8rrndb6h.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2022 at 10:57:58AM -0700, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
> > On 4/27/2022 4:37 PM, Junio C Hamano wrote:
> >> SZEDER Gábor <szeder.dev@gmail.com> writes:
> >> 
> >>> According to the documentation 'safe.directory' "is only respected
> >>> when specified in a system or global config, not when it is specified
> >>> in a repository config or via the command line option -c
> >>> safe.directory=<path>".
> >>>
> >>> Add tests to check that 'safe.directory' in the repository config or
> >>> on the command line is indeed ignored.
> >>>
> >>> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> >>> ---
> >>>  t/t0033-safe-directory.sh | 13 +++++++++++++
> >>>  1 file changed, 13 insertions(+)
> >>>
> >>> diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
> >>> index 6f9680e8b0..82dac0eb93 100755
> >>> --- a/t/t0033-safe-directory.sh
> >>> +++ b/t/t0033-safe-directory.sh
> >>> @@ -16,6 +16,19 @@ test_expect_success 'safe.directory is not set' '
> >>>  	expect_rejected_dir
> >>>  '
> >>>  
> >>> +test_expect_success 'ignoring safe.directory on the command line' '
> >>> +	test_must_fail git -c safe.directory="$(pwd)" status 2>err &&
> >>> +	grep "unsafe repository" err
> >>> +'
> >>> +
> >>> +test_expect_success 'ignoring safe.directory in repo config' '
> >>> +	(
> >>> +		unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
> >>> +		git config safe.directory "$(pwd)"
> >>> +	) &&
> >>> +	expect_rejected_dir
> >>> +'
> >> 
> >> I am debating myself if we want to remove the in-repository
> >> safe.directory configuration setting after this test piece is done,
> >> with test_when_finished.  We just made sure, with this test, that
> >> having the variable does not affect anything, so the subsequent
> >> tests should not care hence it is probably OK.  On the other hand,
> >> to make sure those settings they make (e.g. setting it globally is
> >> what the next test we can see below does) is what affects their
> >> outcome, it removes one more thing we need to worry about if we
> >> clean after ourselves.  I dunno.
> >
> > test_config would do the same, right? I think it automatically
> > does the test_when_finished for us.
> 
> I thought it (specifically, anything depends on test_when_finished)
> has trouble working well from inside a subprocess?

Yeah, test_config doesn't work in a subshell, because modifying
the variable holding the cleanup commands won't be visible after
leaving the subshell, and the protection added in 0968f12a99
(test-lib-functions: detect test_when_finished in subshell,
2015-09-05) will kick in.  And we do need a subshell to set the
config, because without unsetting GIT_TEST_ASSUME_DIFFERENT_OWNER 'git
config' would refuse to touch the config file.

I think something like

  test_when_finished "(
        unset GIT_TEST_ASSUME_DIFFERENT_USER &&
        git config --unset safe.directory
        )"

would work, though.

I considered cleaning up the config file, but all subsequent tests
leave behind config settings for later tests as well (in the global
config file, though).

