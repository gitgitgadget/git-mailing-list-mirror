Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ED7ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 13:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiIANUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 09:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiIANTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 09:19:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276CAB9E
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 06:17:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso1436790wmb.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nbTmGQPoIZoSQF9p1Fb3rn4Z0Y7w4YKv6xXJYR7gR1o=;
        b=jjGCyQm5gh+KCmMYigdGnu1OxTv/thM2ooAziRosI8XMGr0rAX0feHoMjkQjeo5agh
         XTSieJr9QJi0f1ozpUjeBcn0Q3gLEOvSYTF/CkR/C2tOINJY1pxeSUt9kgAF8zl81gBd
         OFRvjEclP9NeM82DINpckTcs8FKokOVa1vb+CPc9s9MwhGpRy7pfWGnWHVrH2Dzo8ZP/
         8KTV2mWey5wwiLLB+2G687/TMkqeHdp4gp6zMZvyclnWHGnb68u+etBoNUYv8ISY4uRY
         poT2OklU90G/6tfN2gMGde9AMDmLtSXd7iLGP93VTdTuZx/uee1USTGAiZ3GQaCqKuJZ
         rP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nbTmGQPoIZoSQF9p1Fb3rn4Z0Y7w4YKv6xXJYR7gR1o=;
        b=ktt99DCJtfQSiDhYjP2xcAGTxTK0TPHBrkxZfp35KHLswf5Yf9eA8reJqA90YlMEQk
         UKtWH5t72VnsK5bCGex+V0ygTaKAInypW5ht9dDRXJyDK/AJtrooZfqs/YOer80KmLlO
         s3/TMnlfyA2iKoThFaIg380t5JtK/xg+agJuLL7FhWMQPpd8Jonm5CG5Y/EAw3wb5cmB
         u5gfJjz8vrYvha8HuAOKJmYz3aNFKzvoBr9sdigRpHaV+lJlkf3YYRYn5uiHjgwyBkBu
         MrKX6hSoHSxXVuQpojZG5xKfBJx4UkyU4ylyRdztuQSJ7rLFilTJTXfboLWzXA4gvIvr
         dTcA==
X-Gm-Message-State: ACgBeo0q3V8LLBjv2H6LgLU/rVenCj2N2PKPPlUdqiU/hM9gaK+KGM4K
        JV+gUuYuosTkr8Dwx7PUbqGVgsOVrcNaLA==
X-Google-Smtp-Source: AA6agR7vEsosjYIgKYAp1YNu4OsP6zwS9R8Yih6L1h6srvBlc+848Xy/YS3s1ufGHeK8mOFJfVg/KQ==
X-Received: by 2002:a05:600c:190b:b0:3a5:f8a3:7abe with SMTP id j11-20020a05600c190b00b003a5f8a37abemr5272281wmq.81.1662038251030;
        Thu, 01 Sep 2022 06:17:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b00225239d9265sm14816089wrs.74.2022.09.01.06.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:17:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] Makefile: split up $(test_bindir_programs)
Date:   Thu,  1 Sep 2022 15:17:23 +0200
Message-Id: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1426.g360dd7cf8ca
In-Reply-To: <sso99so6-n28s-rq86-8q20-4456r3pn869r@tzk.qr>
References: <sso99so6-n28s-rq86-8q20-4456r3pn869r@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 01 2022, Johannes Schindelin wrote:

> [...]
> On Wed, 31 Aug 2022, Victoria Dye via GitGitGadget wrote:
> [...]
>> @@ -3062,7 +3067,7 @@ bin-wrappers/%: wrap-for-bin.sh
>>  	$(call mkdir_p_parent_template)
>>  	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>>  	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
>> -	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
>> +	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
>
> It took me a good while to wrap my head around this (and let me be clear:
> I consider none of this your fault, it's the fault of the design of the
> Makefile syntax).
>
> Let me untangle this, for posterity's benefit. We substitute the
> placeholder `@@PROG@@` with a concatenation of two strings that are both
> derived from `@F`, i.e. the basename of the to-be-wrapped command.

We could do this later, but the 3/5 here is my reply to the "fault of
the design of the Makfile syntax".

I really don't think that's the case, the problem here is something
you'd get any any language.

We have three lists which we'd like to treat differently, but for no
particularly good reason other than incrementally building on past
changes to end up with this we end up having to on-the-fly guess which
list a given item came from.

With this series the end result is instead to do:
	
	define bin_wrappers_template
	BW_$(1) = $$($(1):%=bin-wrappers/%)
	BIN_WRAPPERS += $$(BW_$(1))
	all:: $$(BW_$(1))
	$$(BW_$(1)): bin-wrappers/% : $(3)%$(4)
	$$(BW_$(1)): wrap-for-bin.sh
		$$(call mkdir_p_parent_template)
		$$(QUIET_GEN)$$(call cmd_munge_bin_wrappers_script,$(2),$(3),$(4))
	endef
	
	$(eval $(call bin_wrappers_template,BINDIR_PROGRAMS_NEED_X,'$$(@F)',,$$X))
	$(eval $(call bin_wrappers_template,BINDIR_PROGRAMS_NO_X,'$$(@F)'))
	$(eval $(call bin_wrappers_template,TEST_PROGRAMS_NEED_X,'$$(@F)',t/helper/,$$X))
	
	all:: $(BIN_WRAPPERS)

This obviously conflicts with Victoria's changes here, but if picked
up the conflict can be entirely solved in favor of this series, and
this "scalar" series will benefit.

I.e. the only reason this series needs to patch this one liner is
because the Makefile is losing track of where the item(s) came from.

Once we're not doing that we're perfectly capable of creating a
bin-wrappers/scalar, because we're no longer running into the logic
that uses git% as a heuristic to determine whether something is "not
from the $(TEST_PROGRAMS_NEED_X) variable".

A CI run, showing that this also works on Windows etc.:
https://github.com/avar/git/runs/8135048620

Ævar Arnfjörð Bjarmason (5):
  Makefile: factor sed-powered '#!/bin/sh' munging into a variable
  Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
  Makefile: simplify $(test_bindir_programs) rule by splitting it up
  Makefile: define bin-wrappers/% rules with a template
  Makefile: fix "make clean && make bin-wrappers/$NAME" dependencies

 Makefile | 58 +++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 19 deletions(-)

-- 
2.37.3.1426.g360dd7cf8ca

