Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB481C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 04:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhLIEKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 23:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhLIEKM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 23:10:12 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71463C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 20:06:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z5so15375556edd.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 20:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6XxKCEfX9B7i6SY9ffXIqFy/EuC/5D3FTWXl2iNn6K8=;
        b=ZV9G+CDa6+IcU7C1HEk8Wdcbu8nkQJLzH/aRO/YKjo3rRamAaF5cgNsmDDn9kUI8Dv
         1c6kEdAgCd4Ev/YJNfGz5cAjESXrOYGWxi6MkV0LVa++ehCKuqe+0AFTDd58Tzo+AAmX
         2tJF/DAT0W3kXLqsLG+2BMQV8W0DAfe6r9BhfppPyaCvtNk2iYn+kEjYyzSs6kkHCpSq
         ZeDhYwgU+ZaANr7HpX5HTboLDEdcinymUuocmedKceohvTbkp5n9hQPx6N9bbizWonY1
         6h6+AStZLYzvr0JLPl9a7WILfgvc0cB6Fhe2pexB8Ug/EIUH3wZdaKFYz8Yd5imNfL5c
         HAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6XxKCEfX9B7i6SY9ffXIqFy/EuC/5D3FTWXl2iNn6K8=;
        b=MRvMzdMB3irjuKWT4sC9/2qSlNZ+kiigTk/CrA0gcp01xcBpq7aqTgBTU0U3jGmI7H
         EJccBXzzgXRGuKsrfxqy/oV6QNbhAb40btN7LGvmVz7kXCmx42J0StHq9L4W6Cav45wn
         63ZywyGY/VzbLXmLV9SLJZ3QJMelwtz/4yKA0cvMMAeZzNiGDkP38kwZDIG8P+u7/Mm4
         +Yn+jkTEs6F7q3riUlmyldAYwarjsn/L+H/8c9sYnGiqjbdiz//7kaTFz60jEBtsy0JR
         ht2nWeN/6zQVpKwqn469J9RhFrlnOQgRe1NpK23sRVSSW6LeJ9ZYXTQpibRItAeh3rWe
         41xw==
X-Gm-Message-State: AOAM531ab8Fo+4iauvORI0R/cl74ZsPsg7k/OjPHYohuU68C1+yRZRnm
        kHrR+90gBPsfdfln3e3mRzY=
X-Google-Smtp-Source: ABdhPJwspjhSO/r6sRsIqxPZB5Wlt28S8ifMHJVjtHCpvvk+qjozqpbH+kN9WFKw+OV8jFP1Yp99xw==
X-Received: by 2002:a05:6402:60c:: with SMTP id n12mr26179944edv.17.1639022797883;
        Wed, 08 Dec 2021 20:06:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nb17sm2363863ejc.7.2021.12.08.20.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 20:06:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvAhY-001Vf6-Iz;
        Thu, 09 Dec 2021 05:06:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
Date:   Thu, 09 Dec 2021 04:44:11 +0100
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
        <xmqq4k7nmksi.fsf@gitster.g>
        <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
        <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqq8rwu278d.fsf_-_@gitster.g>
Message-ID: <211209.86fsr2l8vn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 08 2021, Junio C Hamano wrote:

> We ship contrib/ stuff within our primary source tree but except for
> the completion scripts that are tested from our primary test suite,
> their test suites are not run in the CI.
>
> Teach the main Makefile a "test-extra" target, which goes into each
> package in contrib/ whose Makefile has its own "test" target and
> runs "make test" there.  Add a "test-all" target to make it easy to
> drive both the primary tests and these contrib tests from CI and use
> it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Junio C Hamano <gitster@pobox.com> writes:
>
>> That is an interesting way to demonstrate how orthogonal the issues
>> are, which in turn means that it is not such a big deal to add back
>> the coverage to the part that goes to contrib/scalar/.  As the actual
>> implementation, it is a bit too icky, though.
>
> So, how about doing it this way?  This is based on 'master' and does
> not cover contrib/scalar, but if we want to go this route, it should
> be trivial to do it on top of a merge of ab/ci-updates and js/scalar
> into 'master'.  Good idea?  Terrible idea?  Not good enough?

With the caveat that I think the greater direction here makes no sense,
i.e. scalar didn't need its own build system etc. in the first place, so
having hack-upon-hack to fix various integration issues is clearly worse
than just having it behave like everything else....

... then yes, adding this to the top-level Makefile makes more sense....

>  Makefile                  | 12 +++++++++++-
>  ci/run-build-and-tests.sh | 10 +++++-----
>  2 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git i/Makefile w/Makefile
> index d56c0e4aad..ca14558e3c 100644
> --- i/Makefile
> +++ w/Makefile
> @@ -2878,10 +2878,20 @@ export TEST_NO_MALLOC_CHECK
>  test: all
>  	$(MAKE) -C t/ all
>  
> +# Additional tests from places in contrib/ that are prepared to take
> +# "make -C $there test", but expects that the primary build is done
> +# already.
> +test-extra: all
> +	$(MAKE) -C contrib/diff-highlight test
> +	$(MAKE) -C contrib/mw-to-git test
> +	$(MAKE) -C contrib/subtree test
> +
> +test-all:: test test-extra
> +
>  perf: all
>  	$(MAKE) -C t/perf/ all
>  
> -.PHONY: test perf
> +.PHONY: test test-extra test-all perf
>  
>  .PRECIOUS: $(TEST_OBJS)

Which, if we're nitpicking this would be better, i.e. it allows them to
run in parallel, as they won't be defined by only one rule, and will be
listede individuall in the test-all and test-extra prereqs:

diff --git a/Makefile b/Makefile
index d892dbc6c6e..3f47c9f58ad 100644
--- a/Makefile
+++ b/Makefile
@@ -2878,15 +2878,25 @@ export TEST_NO_MALLOC_CHECK
 test: all
 	$(MAKE) -C t/ all
 
+define TMPL_test-extra
+TEST_EXTRA_TARGETS += test-$(1)
+.PHONY: test-$(1)
+test-$(1): all
+	$$(MAKE) -C $(1) test
+endef
+
 # Additional tests from places in contrib/ that are prepared to take
 # "make -C $there test", but expects that the primary build is done
 # already.
-test-extra: all
-	$(MAKE) -C contrib/diff-highlight test
-	$(MAKE) -C contrib/mw-to-git test
-	$(MAKE) -C contrib/subtree test
+$(eval $(call TMPL_test-extra,contrib/diff-highlight))
+$(eval $(call TMPL_test-extra,contrib/mw-to-git))
+$(eval $(call TMPL_test-extra,contrib/subtree))
+
+.PHONY: test-extra
+test-extra:: all $(TEST_EXTRA_TARGETS)
 
-test-all:: test test-extra
+.PHONY: test-all
+test-all: test $(TEST_EXTRA_TARGETS)
 
 perf: all
 	$(MAKE) -C t/perf/ all

> diff --git i/ci/run-build-and-tests.sh w/ci/run-build-and-tests.sh
> index cc62616d80..9da0f26665 100755
> --- i/ci/run-build-and-tests.sh
> +++ w/ci/run-build-and-tests.sh
> @@ -19,7 +19,7 @@ make
>  case "$jobname" in
>  linux-gcc)
>  	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> -	make test
> +	make test-all
> [...]

But I think we're expanding the scope quite a bit here. The reason we
were talking about testing scalar by default is because it uses
libgit.a, so it's not decoupled at all, whereas the "contrib" programs
are only using the built "git" command.

I think it would probably be good to test these anyway, but it's an
argument beyond that which applies to scalar.

I also share Jeff's general concerns that the other stuff in contrib may
not be all that stable.

But I don't see why we should be pursuing this direction of running
certain tests in CI only, as opposed to just under "make test", that
distinction is something new in js/scalar (before that we run libgit.a
test *modes* in CI, but not a different set of tests).
