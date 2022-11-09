Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B18C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 15:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiKIPGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 10:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiKIPGB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 10:06:01 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6651A22B
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 07:06:00 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v17so27673703edc.8
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 07:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qsc1zPn/0H5Wkfy/aFZSYpbrNSq99GTC40NP3daZWQg=;
        b=Fu+gWvytOxNuqdFGRBFndcG+68bvq7X0edO6TZNwxT5W7A5FNBt041yuMaFFBktork
         PXH02vR9vwMXifZHXysVzfry7tyAQZMnC+Nid9BI6nLIyQLIEMjD6Lk5dZE6nSNdmf2n
         ewwTdT7WZ9BGzvqR/vCCQwainKeL8ic4iiu49/bHAHxc+nZW4WLwgK6+cfkhCQyDp7wt
         3Twr4VNfIZvzw/VDpJR5sT9m5jmQx8LdtScBldKDiZekbs35y1lRIWv4kv60LPYaM3UR
         vGbDNO8tmfVxWlzfajI2U9ALOJ4SiVhPulT3oul5K4wCvibXHgH35IVGcsOLhZU5SFEc
         h+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsc1zPn/0H5Wkfy/aFZSYpbrNSq99GTC40NP3daZWQg=;
        b=KvtmPOf1Zcql4YMHb27ub0ZmOab/yZMKmzOnUJ8ONHn13MFnkwTI3L7lR/UfgsR6uG
         0Bc8i+7hAMt3SQgKZrWjjT0Ibt+3h4YhGOqgUFs8sya9YR+oHBDJ+ANPq7BeqgcT3voG
         Oo31KgJJlVukP5yQISgx23z5e6ibFRxdyujwnHxrlv5BMjT6N9X5z0g8tU0xgi2jTTiU
         HQuuLkcrlRzV5MdlwdB0ZCKJuFmyU8BUjJ3GXpm4NVVSF5pD7tqirGtJXIO8o23G8SKw
         e6qHPhTFG6/LLy0Wn6El/8tLZY4eomGzJ7+vnKlaW1okiZFVYH+4VDmX3Yvv7DhHuumq
         y7eA==
X-Gm-Message-State: ACrzQf3lkIdr7xuNwL+JY4d/66EFa3yb/+F6G1bqLmwc0aj39vsesVm9
        Wqh8srVkNqcwZn8C9osJWw6vUFX+i58=
X-Google-Smtp-Source: AMsMyM6n7FP5PHcIN8K5qDNlqAID3ZMgL/rZVr6U4ol4t3HLjQ0BXRf/6XkzJdvhYkHScmHX+apawA==
X-Received: by 2002:aa7:cc8a:0:b0:45b:f851:2943 with SMTP id p10-20020aa7cc8a000000b0045bf8512943mr61594038edt.103.1668006358549;
        Wed, 09 Nov 2022 07:05:58 -0800 (PST)
Received: from localhost (78-131-17-60.pool.digikabel.hu. [78.131.17.60])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709063d3200b007aea1dc1840sm55113ejf.111.2022.11.09.07.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 07:05:57 -0800 (PST)
Date:   Wed, 9 Nov 2022 16:05:56 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 10/13] Makefile: copy contrib/coccinelle/*.cocci to
 build/
Message-ID: <20221109150556.GE1731@szeder.dev>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
 <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
 <patch-v5-10.13-56ca8f5720a-20221101T222616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v5-10.13-56ca8f5720a-20221101T222616Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 11:35:52PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Change the "coccinelle" rule so that we first copy the *.cocci source
> in e.g. "contrib/coccinelle/strbuf.cocci" to
> ".build/contrib/coccinelle/strbuf.cocci" before operating on it.

After this patch the output of 'make coccicheck' looks like this:

    CP contrib/coccinelle/hashmap.cocci .build/contrib/coccinelle/hashmap.cocci
    MKDIR -p .build/.build/contrib/coccinelle/hashmap.cocci.patch
    SPATCH .build/.build/contrib/coccinelle/hashmap.cocci.patch/upload-pack.c
    SPATCH .build/.build/contrib/coccinelle/hashmap.cocci.patch/merge-ort-wrappers.c
    SPATCH .build/.build/contrib/coccinelle/hashmap.cocci.patch/unpack-trees.c
    SPATCH .build/.build/contrib/coccinelle/hashmap.cocci.patch/gpg-interface.c
    SPATCH .build/.build/contrib/coccinelle/hashmap.cocci.patch/linear-assignment.c

Notice how there is not one but two leading '.build' path components.
Surely one would be enough :)

This also breaks 'make cocciclean':

  $ make cocciclean
  rm -f GIT-SPATCH-DEFINES
  rm -f -r .build/contrib/coccinelle
  rm -f contrib/coccinelle/*.cocci.patch
  $ find .build/
  .build/
  .build/contrib
  .build/.build
  .build/.build/contrib
  .build/.build/contrib/coccinelle
  .build/.build/contrib/coccinelle/hashmap.cocci.patch
  .build/.build/contrib/coccinelle/hashmap.cocci.patch/upload-pack.c
  .build/.build/contrib/coccinelle/hashmap.cocci.patch/merge-ort-wrappers.c
  .build/.build/contrib/coccinelle/hashmap.cocci.patch/unpack-trees.c
  .build/.build/contrib/coccinelle/hashmap.cocci.patch/gpg-interface.c
  .build/.build/contrib/coccinelle/hashmap.cocci.patch/linear-assignment.c


> For now this serves as a rather pointless indirection, but prepares us
> for the subsequent commit where we'll be able to inject generated
> *.cocci files. Having the entire dependency tree live inside .build/*
> simplifies both the globbing we'd need to do, and any "clean" rules.
> 
> It will also help for future targets which will want to act on the
> generated patches or the logs, e.g. targets to alert if we can't parse
> certain files (or, less so than usual) with "spatch", and e.g. a
> replacement for "ci/run-static-analysis.sh". Such a replacement won't
> care about placing the patches in the in-tree, only whether they're
> "OK" (and about the diff).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Makefile   | 27 +++++++++++++++++++++------
>  shared.mak |  1 +
>  2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index c7c96d284dd..44c906b65d5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3164,8 +3164,11 @@ check: $(GENERATED_H)
>  	fi
>  
>  COCCI_GLOB = $(wildcard contrib/coccinelle/*.cocci)
> -COCCI_RULES = $(COCCI_GLOB)
> -COCCI_NAMES = $(COCCI_RULES:contrib/coccinelle/%.cocci=%)
> +COCCI_RULES_TRACKED = $(COCCI_GLOB:%=.build/%)
> +COCCI_RULES =
> +COCCI_RULES += $(COCCI_RULES_TRACKED)
> +COCCI_NAMES =
> +COCCI_NAMES += $(COCCI_RULES:.build/contrib/coccinelle/%.cocci=%)
>  
>  COCCICHECK_PENDING = $(filter %.pending.cocci,$(COCCI_RULES))
>  COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_RULES))
> @@ -3173,6 +3176,9 @@ COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_RULES))
>  COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
>  COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
>  
> +COCCICHECK_PATCHES_INTREE = $(COCCICHECK_PATCHES:.build/%=%)
> +COCCICHECK_PATCHES_PENDING_INTREE = $(COCCICHECK_PATCHES_PENDING:.build/%=%)
> +
>  # It's expensive to compute the many=many rules below, only eval them
>  # on $(MAKECMDGOALS) that match these $(COCCI_RULES)
>  COCCI_RULES_GLOB =
> @@ -3180,10 +3186,16 @@ COCCI_RULES_GLOB += cocci%
>  COCCI_RULES_GLOB += .build/contrib/coccinelle/%
>  COCCI_RULES_GLOB += $(COCCICHECK_PATCHES)
>  COCCI_RULES_GLOB += $(COCCICHEC_PATCHES_PENDING)
> +COCCI_RULES_GLOB += $(COCCICHECK_PATCHES_INTREE)
> +COCCI_RULES_GLOB += $(COCCICHECK_PATCHES_PENDING_INTREE)
>  COCCI_GOALS = $(filter $(COCCI_RULES_GLOB),$(MAKECMDGOALS))
>  
>  COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
>  
> +$(COCCI_RULES_TRACKED): .build/% : %
> +	$(call mkdir_p_parent_template)
> +	$(QUIET_CP)cp $< $@
> +
>  .build/contrib/coccinelle/FOUND_H_SOURCES: $(FOUND_H_SOURCES)
>  	$(call mkdir_p_parent_template)
>  	$(QUIET_GEN) >$@
> @@ -3197,7 +3209,7 @@ define cocci-rule
>  # $(1) = e.g. "free.cocci"
>  # $(2) = e.g. "grep.c"
>  # $(3) = e.g. "grep.o"
> -COCCI_$(1:contrib/coccinelle/%.cocci=%) += .build/$(1).patch/$(2)
> +COCCI_$(1:.build/contrib/coccinelle/%.cocci=%) += .build/$(1).patch/$(2)
>  .build/$(1).patch/$(2): GIT-SPATCH-DEFINES
>  .build/$(1).patch/$(2): $(if $(and $(SPATCH_USE_O_DEPENDENCIES),$(wildcard $(3))),$(3),.build/contrib/coccinelle/FOUND_H_SOURCES)
>  .build/$(1).patch/$(2): $(1)
> @@ -3225,12 +3237,15 @@ endif
>  
>  define spatch-rule
>  
> -contrib/coccinelle/$(1).cocci.patch: $$(COCCI_$(1))
> +.build/contrib/coccinelle/$(1).cocci.patch: $$(COCCI_$(1))
>  	$$(QUIET_SPATCH_CAT)cat $$^ >$$@ && \
>  	if test -s $$@; \
>  	then \
>  		echo '    ' SPATCH result: $$@; \
>  	fi
> +contrib/coccinelle/$(1).cocci.patch: .build/contrib/coccinelle/$(1).cocci.patch
> +	$$(QUIET_CP)cp $$< $$@
> +
>  endef
>  
>  ifdef COCCI_GOALS
> @@ -3254,11 +3269,11 @@ $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinell
>  coccicheck-test: $(COCCI_TEST_RES_GEN)
>  
>  coccicheck: coccicheck-test
> -coccicheck: $(COCCICHECK_PATCHES)
> +coccicheck: $(COCCICHECK_PATCHES_INTREE)
>  
>  # See contrib/coccinelle/README
>  coccicheck-pending: coccicheck-test
> -coccicheck-pending: $(COCCICHECK_PATCHES_PENDING)
> +coccicheck-pending: $(COCCICHECK_PATCHES_PENDING_INTREE)
>  
>  .PHONY: coccicheck coccicheck-pending
>  
> diff --git a/shared.mak b/shared.mak
> index f437073e48c..a34b66c926d 100644
> --- a/shared.mak
> +++ b/shared.mak
> @@ -60,6 +60,7 @@ ifndef V
>  	QUIET_AR       = @echo '   ' AR $@;
>  	QUIET_LINK     = @echo '   ' LINK $@;
>  	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
> +	QUIET_CP       = @echo '   ' CP $< $@;
>  	QUIET_LNCP     = @echo '   ' LN/CP $@;
>  	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
>  	QUIET_MSGINIT  = @echo '   ' MSGINIT $@;
> -- 
> 2.38.0.1280.g8136eb6fab2
> 
