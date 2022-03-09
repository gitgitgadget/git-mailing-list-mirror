Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E307C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiCINiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbiCINht (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:37:49 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E5113CA09
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:36:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y22so2896728eds.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/VQ6gy3ws/PD7+U4ZcI2fwWn4V+zsl6Yi1ELMTk0AF8=;
        b=kmsPvWwuFJkpXiLqjadjN0Hys7hnKZnHd7HiM5p/qpIM99EkbV/ntsrBuZMEalMUar
         Oz16YUzZoajI1gROeKawzAb7N4hVVs0Ql0Cdhrpf5V82VMaMqpY2wN1PgagwhLK/JmbM
         g0szDQLU18qNnrN6MJF4Eisxv3Rd8uu6BDDUO0v3Le7OgoSDp+O63esPWzNt6/0Lkkv2
         I5zmkalgqea5HL1QbSzxFoNQxoe/rXabcA5bn0XufPqmnawAQjgNOUkMIULWkJopA80n
         pA7IDLiy0hkFrhivxXwFlNDDyi5LIGKRFhlxpAc8bGIgihgye45we8tEe7Vp+vYjcXHM
         FXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/VQ6gy3ws/PD7+U4ZcI2fwWn4V+zsl6Yi1ELMTk0AF8=;
        b=sSiMLguw8HScQOweQoqDyFN0BbXFJnLd0U0hH2aus6SO2YK6Blw1MJEaZVmI+gFMy1
         pFO/n/G3JRNWMvwZQLpedEYYFWA1RqmZxBg9Yv8H63eAesXdRz0usbx4l4zr8UfDuNmQ
         PpMjpRCwueh2kucybXUvmVpsfA011mlX/BDNacRcOoQl07IEUK+uDnVMVrcc1/4pTU3y
         8wKza68z4qfqKPq+w0OHSTEI49ZnnQRnXXc22rUZG8Bjw5ENceKTHBK146laIxAWRmiw
         yFypVEZlU4WQMF46FyCN4SLQL48JuWJKVEbqqai2HnAPLy9604gosiB3V7IV/CCuR4Oe
         nvFw==
X-Gm-Message-State: AOAM530VRoAld7bTpWia5WV/eza9Oz/ZcM8Gcqvvsse+8sXuQPnMbEby
        g6zuCrMXuKGj4M50kX0JJm/XReUH+5U+xQ==
X-Google-Smtp-Source: ABdhPJwcxLKi6r0TWAiBIGtuo3/RCnvLktSejJLSnIBCz1TqymDANurjZLctCk8e/LKsAjSdEtO0UQ==
X-Received: by 2002:a05:6402:386:b0:415:ead8:ced with SMTP id o6-20020a056402038600b00415ead80cedmr21154429edv.407.1646833008398;
        Wed, 09 Mar 2022 05:36:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u5-20020aa7d985000000b004024027e7dasm835396eds.28.2022.03.09.05.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:36:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRwUh-000ASe-AE;
        Wed, 09 Mar 2022 14:36:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 08/12] bundle: parse filter capability
Date:   Wed, 09 Mar 2022 14:30:10 +0100
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
 <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
 <025f38290f5a705c80854a42e1abcaba9a9f336d.1646750359.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <025f38290f5a705c80854a42e1abcaba9a9f336d.1646750359.git.gitgitgadget@gmail.com>
Message-ID: <220309.86o82fmemo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 08 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
>  static const char v2_bundle_signature[] = "# v2 git bundle\n";
>  static const char v3_bundle_signature[] = "# v3 git bundle\n";
> @@ -33,6 +33,7 @@ void bundle_header_release(struct bundle_header *header)
>  {
>  	string_list_clear(&header->prerequisites, 1);
>  	string_list_clear(&header->references, 1);
> +	list_objects_filter_release(&header->filter);
>  }
>  
>  static int parse_capability(struct bundle_header *header, const char *capability)
> @@ -45,6 +46,10 @@ static int parse_capability(struct bundle_header *header, const char *capability
>  		header->hash_algo = &hash_algos[algo];
>  		return 0;
>  	}
> +	if (skip_prefix(capability, "filter=", &arg)) {
> +		parse_list_objects_filter(&header->filter, arg);
> +		return 0;
> +	}
>  	return error(_("unknown capability '%s'"), capability);
>  }

I haven't tested, but I did wonder if our purely "check reachability"
(or equivalent) "verify" would be slowed down by doing whatever filter
magic we're doing here, but then remembered/saw that we only parse the
header, so it can't be that bad :)

I.e. this is only checking the syntax of the filter, surely, and then
spits it back at us. That makes sense.

I think that this hunk from the subsequent 10/12 is in the wrong place
though, and should be here when we change "verify" (not "create" later):
	
	diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
	index 72ab8139052..831c4788a94 100644
	--- a/Documentation/git-bundle.txt
	+++ b/Documentation/git-bundle.txt
	@@ -75,8 +75,8 @@ verify <file>::
	 	cleanly to the current repository.  This includes checks on the
	 	bundle format itself as well as checking that the prerequisite
	 	commits exist and are fully linked in the current repository.
	-	'git bundle' prints a list of missing commits, if any, and exits
	-	with a non-zero status.
	+	'git bundle' prints the bundle's object filter and its list of
	+	missing commits, if any, and exits with a non-zero status.
	 
	 list-heads <file>::
	 	Lists the references defined in the bundle.  If followed by a

I think instead of starting to list every header we might add in the
future there it would make sense to just add after the pre-image
full-stop something like:

    We'll also print out information about any known capabilities, such
    as "object filter". See "Capabilities" in technical/...

Which future proofs it a bit...

> [...]

I think it would also be great to have tests for intentionally
corrupting the header and seeing what the "verify" output is, i.e. do we
die right away, proceed to validate the rest. So just (somewhat
pseudocode):

    git bundle create [...] my.bdl &&
    sed 's/@filter: .*/@filter: bad/' <my.bdl >bad.bdl &&
    test_must_fail git bundle verify bad.bdl 2>actual &&
    [...]
    test_cmp expect actual

Overall this series looks really good at this point, and I'm down to
minor shades of colors on the bikeshedding :)
