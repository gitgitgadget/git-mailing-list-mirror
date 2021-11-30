Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2043C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 13:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbhK3Nii (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 08:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhK3Nid (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 08:38:33 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B28C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 05:35:14 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l25so86612797eda.11
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 05:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=nEhw/OkVmSCsmGvOxJohnuQiXdJf17YUUW/d27Osn8Q=;
        b=C7S/0RHo6N8AHZL1hmzt1l0LcQu272rX/QJ1ZZw90YK6N8tPJXk+WdnHUtzsPmMgX4
         B3/qXgaX3OOsNwrTQ8+09vr16plNUQcoNblA720ksPPUdoI6q85NLI3ObyGrbkis+58T
         3WbLHUElj4SaBiSpBHj3D2mjwqit45nkpXSJ0Bia6tZWOZtL/mHujDRoNn7C3JkcIsHO
         E1woCaoc0jqH53HEodImzMbhO6fxjLG9NGtaZ1gtnVJjORt+U7CTWbNapIe32mNfW9S6
         zsoe8nKkiloXgIJY26irCnetbd7qF7CavcfVsb+bERtDIwSF8FibGWTsiRLTfunQsTBh
         xjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=nEhw/OkVmSCsmGvOxJohnuQiXdJf17YUUW/d27Osn8Q=;
        b=HmILkoZQUCS5TIEht0LZJnaogyTXyWVPeNjUYTB4mDg5ssLzkrT3d0kyS0fnN8pzn5
         mBjd5yY+5pMVPFWAHXRWzr1iBsL/bQS++kXo4YF+68fKODG58phHbCMXnHcAlan/taDW
         WIONp2wEo8leEGajQIub1oxT3gptdvoiDOTO4zP2n+VR+lTE0vB+ze+OAubdqKnHRsjq
         jx81eLyVCIjDmyCLffh8iB9omNOJs2SufxEPJ1p4njmxqQpzrFyrWVBwm5lNrQLNEaGQ
         Avk4u3O9W8Q0kg8DPMnn1aY031JY6/ELnOsmhqopJ+NHl3TXAcTOIKtc/ZWRvWELarES
         5gEQ==
X-Gm-Message-State: AOAM5307V7V602tJ17u2dyMNB/GFznOgH2Jjs086z3DFiON/tvaFIviH
        YFulLu9+/IkpFzyifYuWLdGww5jOZL8nYA==
X-Google-Smtp-Source: ABdhPJzt9kqMLqRd9UFvwwc9MNXjWzE93+6Szxmt2RJfmR/KCWKz7Gj/rE7DsKAyKYcxqomvZqfShw==
X-Received: by 2002:aa7:d80d:: with SMTP id v13mr83649195edq.7.1638279312885;
        Tue, 30 Nov 2021 05:35:12 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id di4sm9462928ejc.11.2021.11.30.05.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 05:35:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ms3Hr-0010EL-Rw;
        Tue, 30 Nov 2021 14:35:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v8 04/17] scalar: create test infrastructure
Date:   Tue, 30 Nov 2021 14:27:03 +0100
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
 <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
 <37231a4dd07833807639c8a650185569d0c99af2.1637363025.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <37231a4dd07833807639c8a650185569d0c99af2.1637363025.git.gitgitgadget@gmail.com>
Message-ID: <211130.86ee6xepgw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 19 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
> +-include ../../../config.mak.autogen
> +-include ../../../config.mak
> +
> +SHELL_PATH ?= $(SHELL)
> +PERL_PATH ?= /usr/bin/perl
> +RM ?= rm -f
> +PROVE ?= prove
> +DEFAULT_TEST_TARGET ?= test
> +TEST_LINT ?= test-lint
> +
> +ifdef TEST_OUTPUT_DIRECTORY
> +TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
> +else
> +TEST_RESULTS_DIRECTORY = ../../../t/test-results
> +endif

So here we'll inject our output into t/test-results[...]

> +T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))

...end up with a $(T) with just the one scalar test...

> +test-lint-duplicates:
> +	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
> +		test -z "$$dups" || { \
> +		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
> +

...so I *think* (but haven't checked) that print-test-failures.sh will
work with the later CI integration, but both t/Makefile & this one
assume in some ways that test numbers are unique, this now lives in the
same namespace, but neither check the two for conflicts.

We only have the one t9099 test here, so unless we add another one in
the top-level t/ that should be OK, but is there any reason to carry
this at all? It seems pointless given the above.

I think to make this meaningful we'd need to teach t/Makefile to have a
T_ALL variable or something, derived from its T, and have that wildcard
the scalar tests and other contrib tests and check them for namespacing
conflicts.

> +test-results:
> +	mkdir -p test-results
> +

This target seems to be unused, don't we always use the top-level
t/test-results? This seems to be copy/pasting also dead code from
contrib/subtree/t/Makefile.
