Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD78C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 18:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiJZStE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 14:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiJZStC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 14:49:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82501C704A
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 11:49:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso2998427pjc.2
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGTdj8ihM3ixVqV+NlguVEJL0eDc+GecdcHJhbFn8Tk=;
        b=L+QkJNE2bbzLrwFEdMy5WP06WataHRE2e1okg/QO0KuZiJgGgr2PZ7tGY3Hx3lEY56
         egMymMxpNGMXBJzp75KMviaFI2IR5vqtNXhVQX4EpVrD1Oa7boT01Et0QX+JkN8vnK27
         RYeSt09ZxFDXQ7IatdCyjp+x2UUyPruKGMIdgpiG1g3+2QeP9zOkqwMyVDLB9HpfaDhk
         S7f2JQj/llJ+Nc6WNicV6uD6Hifu4nu1bd6c7j4zRGx9Je4I5GyUGC3tp4ELpCPPoSFM
         gXKhFo4iUhYjiFu80O/i0E67aRq1EdCbC42jhsE+SEeExNcb6dvszTG4h/0S6E4CCH0d
         OtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGTdj8ihM3ixVqV+NlguVEJL0eDc+GecdcHJhbFn8Tk=;
        b=1DFlPXsCvBcQuVP/IMfZVY0AQ66pTutwQlnlHY0t+YjNmQSL/ITfJJ8g8ifv8BgEdx
         yh7Zw6r+0uc/VdTpxkDZ+afjsQvsMrGsUfMxfN063Twz3GYHdh4GVeGMjbkEao7tIAiF
         whhPsHtofYOnK4s82FtUXKzqhvU5/wlo0EeA/FoVS2QIswgKJp76Lbn60OeXVLJVojKD
         ZDgY6l5dspRLKDDTRlgUWPJycgr8wdCtm7HDDWtmeT+XLXQsEtX2tNgkTVTC27MbOBGO
         6XpFIQa6pzSXqr6UxlkH05ruoj9L8mxlEDeFcTvKEtf6t430IDbKGO5/uSlye8XLmz1H
         QRJA==
X-Gm-Message-State: ACrzQf3Th9VEq08Upix2D0tabotJd02CS9vC4FCJ5wfFU19CzAUNN39X
        E8SAfcX1kMr+iGX3qlOJ7+JZK3L87iQ=
X-Google-Smtp-Source: AMsMyM5EjMQN595yLNNxqtbAIEYXI7Boc0U0aRO3XyZUgF5krN/DaXjKbCZWtNEiKzNtYxu+l6tvMA==
X-Received: by 2002:a17:90b:224c:b0:20d:8828:3056 with SMTP id hk12-20020a17090b224c00b0020d88283056mr5915908pjb.136.1666810140855;
        Wed, 26 Oct 2022 11:49:00 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090a2c8400b001fe39bda429sm1397102pjd.38.2022.10.26.11.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 11:49:00 -0700 (PDT)
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
Date:   Wed, 26 Oct 2022 11:48:59 -0700
Message-ID: <xmqqr0yuh144.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> -test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
> +define cmd_munge_bin_wrappers_script
> +sed \
> +	-e $(call cmd_munge_script_sed_shell_path_arg) \
> +	-e 's|@@BUILD_DIR@@|$(shell pwd)|' \
> +	-e 's|@@PROG@@|$(2)$(1)$(3)|' \
> +	<$< >$@ && \
> +	chmod +x $@
> +endef

We've talked about relying on another feature of GNU make (which we
already depend on) to automatically remove the target build artifact
when a rule to build it fails, but I see quite a many old world best
practice pattern "generate >$@+ && chmod +x $@+ && mv $@+ $@" still
in today's Makefile.  What happens when a rule that uses the above
fails in the middle?  Do we correctly remove the half-built target?

> -all:: $(test_bindir_programs)
> +define bin_wrappers_template
> +
> +## bin_wrappers_template
> +# 1 = $(1)
> +# 2 = $(2)
> +# 3 = $(3)
> +# 4 = $(4)

Whatever the above comment wants to convey to readers, it seems to
fail to do so at least to me, while ...

> +BW_$(1) = $$($(1):%=bin-wrappers/%)
> +BIN_WRAPPERS += $$(BW_$(1))
> +all:: $$(BW_$(1))
> +$$(BW_$(1)): bin-wrappers/% : $(3)%$(4)
> +$$(BW_$(1)): wrap-for-bin.sh
> +	$$(call mkdir_p_parent_template)
> +	$$(QUIET_GEN)$$(call cmd_munge_bin_wrappers_script,$(2),$(3),$(4))
> +endef
>  
> +define bin_wrappers_templates
> +$(call bin_wrappers_template,BINDIR_PROGRAMS_NEED_X,'$$(@F)',,$$X)
> +$(call bin_wrappers_template,BINDIR_PROGRAMS_NO_X,'$$(@F)')
> +$(call bin_wrappers_template,TEST_PROGRAMS_NEED_X,'$$(@F)',t/helper/,$$X)
> +endef
> +$(eval $(call bin_wrappers_templates))
> +
> +all:: $(BIN_WRAPPERS)

... what it expands to looked quite straight-forward.
