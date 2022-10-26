Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5F5C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 20:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiJZU2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiJZU2u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 16:28:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1B6A23F4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:28:49 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e4so12680295pfl.2
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzW2J2k8damr1k7RmD15OFHXEOvK06Hq4001CENN+r8=;
        b=OnOivbgZQKnEXX2Tj26nU97mEOJzFRL/g0bbE3WxL7KU1oju9FiQ4ez2BqZMPvhSky
         fy2pqmIPRHooqHt9adRwFwKf8UE7bqDCtr7ycD5eTkya2lxZh1bWW6BFCbh7FCIBc3TF
         BMes1AkbtpTe+Mg+Zzr3AndfkcLFirKjESw7h4n6YMKb16uwTh/EGZCGiaaQzK4Xvs02
         cCXRLSXknIC0v4KfiulRrG9Wq5QvaV+5ovKkXDR5W2yRcnuOvW/Ci9nrTls/YJ79mg75
         sVKZb885De97fnRK/2h80VxPRJhXNHkEPjhDOYYkaHUHxj/BPyO9LNUArhpXhOPsmcmV
         /eEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzW2J2k8damr1k7RmD15OFHXEOvK06Hq4001CENN+r8=;
        b=kcOFF6KCc0UUMCheqKrTIQG1Xzdo+PxYij3Xop+xLFl7a6DMYIqbO66+X21EMHZs97
         fwIpuaao1Re/54UJyU5UjPYJNjHk0FEEQPDNYscOtcaGMGWlqkETyNEwS31OSRHRzsgR
         WB9VHhL//PPgMVTNbQcafxQY08sfIQzqKC2Mq/7hcwvhzWpsgtCPJZ8p1tK8AVhmZc6g
         U5fqmtc/eqFMb/ScCKvTP7r+YuU0SIB46vY8qiGQ4oUD+uGNtlJF8kSd4UhhszEYEnF5
         Z4oj8vobYyZi1l8wXC0t1Q6mO2EtZTsccQBxhWY40Yi5guA5W8+pbmo6feyJvsD1L5eu
         aJpA==
X-Gm-Message-State: ACrzQf2rxU1kUS9U+H69HBdioQVlKVr1n+3fieV+UgashBR1mBVMKpRm
        nmrfDJZrEco2Yx2C8omddK8=
X-Google-Smtp-Source: AMsMyM5o++S5lYZEDWGHu4U2t2BUpCNuwv11beFRYlX4VJBC9/7BiYjY+Rz9k5EYkB0i2xHi2EHySQ==
X-Received: by 2002:a05:6a00:cd1:b0:563:8df5:2b8b with SMTP id b17-20020a056a000cd100b005638df52b8bmr45957973pfv.67.1666816129084;
        Wed, 26 Oct 2022 13:28:49 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i11-20020a056a00224b00b0056be2a3c87csm3390329pfu.154.2022.10.26.13.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:28:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/3] Makefile: simplify $(test_bindir_programs) rule
 by splitting it up
References: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
        <patch-v2-3.3-400f487e30d-20221026T143534Z-avarab@gmail.com>
        <xmqqr0yuh144.fsf@gitster.g>
        <221026.86tu3qbd03.gmgdl@evledraar.gmail.com>
Date:   Wed, 26 Oct 2022 13:28:47 -0700
In-Reply-To: <221026.86tu3qbd03.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 26 Oct 2022 21:14:29 +0200")
Message-ID: <xmqq5yg6gwhs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Are you asking if "define"'s execute in some context outside the purview
> of rules, so that if you $(call) one from within a rule and it errors,
> that we won't clean up the file?

Not at all.

I was wondering why the defined sequance does not end in

	...
	<$> >$@+ && \
	chmod +x $@+ && \
	mv $@+ $@

like many other command sequences in the Makefile.  As I said, I did
remember we had discussed delete-on-error; I just didn't recall if
we do depend on it already.

> I can drop them, FWIW I've found it quite handy to add these to ad-hoc
> debug templates. E.g. you can run:
> 	
> 	$ make -f /dev/null -E '$(eval $(file <Makefile))' -E '$(error $(call bin_wrappers_template,a,b,c,d))'
> 	make: *** 
> 	## bin_wrappers_template
> 	# 1 = a
> 	# 2 = b
> 	# 3 = c
> 	# 4 = d

OK.  That use pattern was what I was missing.
> ...
> So you see what the parameters expand to. Maybe just changing the
> heading to:
>
> 	## bin_wrappers_template: $(1..N) below for manual "$(error $(call ..." deubgging

Yeah, it would be totally useless without such an instruction.
