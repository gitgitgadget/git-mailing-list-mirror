Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA64C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 17:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiJZRvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 13:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiJZRvv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 13:51:51 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4340A664F3
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 10:51:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d24so14890621pls.4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oO08gldFKi+WREGGPAvDDhU+7ybd1ZsKx2g1zyjnrw4=;
        b=OMwcspdakU2YSY3vbGSmP9egpJdvimOJ626Zq5sPlQXjJhpyrIshT6S5uadCiZHlNQ
         omZrTrvwlZJPrs1M9lMD6efk5/uimTtFZHVfg4bYL+hWz4f3KdKszQQRnpdMdQp60KTi
         BNdouWYnCQNUg+Ggq0ZYfOjh0f7A6cXfCis1v1m3ta7Bj18qOx5yTKxFfWwTylYo+umC
         9JmeqM1SJ7YEbJKi7Wsg9qS8Slq11KKxG5zU7v/APmFCijll83Ur20G+cOtLmL0IUYlW
         8YzJea6WmF/ionKkbVqvWzFgqCMfvp7k6j0BrH3BDTAmDUegAm9gbji8YfEZrmyhJNGV
         MX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oO08gldFKi+WREGGPAvDDhU+7ybd1ZsKx2g1zyjnrw4=;
        b=mgqZPFW2qGEyoEnlpIkNvhOHFobTaqMotsCmAvuIGM/Gbqsa8vnyg0+E16oyivxnxR
         Hg67lBMRgC8hMn3znkomvcVZmHtoTaIN6yYpEljqhOvqp/4GG6H1V52gvFESQyTSh2sa
         UInHB4Z6n/ODhqVZFKz0HBR5S/aD/Co78ywBbQAGUqtcWbkZ9SO+yd9eGuVpAE6Bo1m6
         ngtKe4xHOeQU/y2YeczRUdebjM2275U4vx9b5JuxrhUMv7QE4jiPolnRraaZN0gVE8HM
         Iep6h5j70qNH2Ltthsrb+O310lFD0BAdZu97lWkBa7dh8A3n5XdHCEbzZSTNmndOkTsg
         6CjA==
X-Gm-Message-State: ACrzQf3FKMi2xxWulNTxm2RQz8xxSTq3OFx24IikmyiT5oiF8AJE+Ed6
        6H7DVmn33wfphT+kKKDKHw73QJPwMSY=
X-Google-Smtp-Source: AMsMyM5FAxZ8x9zqtlBd2X964PoxTYuuRji+6UQJAGSVxn5cgoz0z8rWNvrj+Z/4Fem4oePKUayVWA==
X-Received: by 2002:a17:90b:4b09:b0:213:655c:158b with SMTP id lx9-20020a17090b4b0900b00213655c158bmr1838748pjb.119.1666806709656;
        Wed, 26 Oct 2022 10:51:49 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g12-20020a17090a708c00b001f559e00473sm1348367pjk.43.2022.10.26.10.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 10:51:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/3] Makefile: factor sed-powered '#!/bin/sh' munging
 into a variable
References: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
        <patch-v2-1.3-fc6c5a6a8df-20221026T143534Z-avarab@gmail.com>
Date:   Wed, 26 Oct 2022 10:51:48 -0700
Message-ID: <xmqq1qquiibv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Reduce the amount of magical copy/pasting in the Makefile by factoring
> the munging of "#!/bin/sh" on the first line of a shellscript into a
> variable we can re-use in the various rules that need to do so.

At least when taken standalone, this looks more like replacing one
magical copy pasting with another magical one, the difference being
that the latter is not immediately obvious without referring back to
the definition of the variable.

If we need to change the replacement wholesale in a later step, then
it might give us a good trade off, but otherwise I am not sure why
this is a good idea that is worth the churn.  

When adding or updating these actions, in the original, you can typo
SHELL_PATH_SQ, but you can typo cmd_munge_script_sed_shell_path_arg
in the updated to break it the same way.  So...?

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Makefile | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 85f03c6aed1..45b22d33513 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2344,8 +2344,12 @@ GIT-SCRIPT-DEFINES: FORCE
>  		echo "$$FLAGS" >$@; \
>              fi
>  
> +define cmd_munge_script_sed_shell_path_arg
> +'1s|#!.*/sh|#!$(SHELL_PATH_SQ)|'
> +endef
> +
>  define cmd_munge_script
> -sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
> +sed -e $(call cmd_munge_script_sed_shell_path_arg) \
>      -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
>      -e 's|@@DIFF@@|$(DIFF_SQ)|' \
>      -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
> @@ -2447,7 +2451,7 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
>  else # NO_PERL
>  $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
>  	$(QUIET_GEN) \
> -	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
> +	sed -e $(call cmd_munge_script_sed_shell_path_arg) \
>  	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
>  	    unimplemented.sh >$@+ && \
>  	chmod +x $@+ && \
> @@ -2468,7 +2472,7 @@ $(SCRIPT_PYTHON_GEN): % : %.py
>  else # NO_PYTHON
>  $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
>  	$(QUIET_GEN) \
> -	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
> +	sed -e $(call cmd_munge_script_sed_shell_path_arg) \
>  	    -e 's|@@REASON@@|NO_PYTHON=$(NO_PYTHON)|g' \
>  	    unimplemented.sh >$@+ && \
>  	chmod +x $@+ && \
> @@ -3061,7 +3065,7 @@ all:: $(TEST_PROGRAMS) $(test_bindir_programs)
>  
>  bin-wrappers/%: wrap-for-bin.sh
>  	$(call mkdir_p_parent_template)
> -	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
> +	$(QUIET_GEN)sed -e $(call cmd_munge_script_sed_shell_path_arg) \
>  	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
>  	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
>  	chmod +x $@
