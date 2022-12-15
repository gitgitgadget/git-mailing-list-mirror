Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE95BC4167B
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 16:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiLOQUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 11:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLOQUa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 11:20:30 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CFB33C13
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 08:20:28 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id vv4so53465567ejc.2
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 08:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VRKn6lITYEJiR285FiWpm4qlLh4mttnvAIbrbFKA6EE=;
        b=PsZS4GVX9d8mxKprk3I12nAQ+GSHGG+FrksvSYiGzmyxryWrZVGWp2wha9m4pem5BC
         gLbmPuqYH6ZnWp5tQs4FJE9yCRJJzlWGyPNsW4F+eTm60H/jQ3OWUmFCou7G4ZodCrJS
         SNzCshnekPFf81lNJd8kLCGZML85oARM3p8n3ny5dNLSjrKGnPIlbGVs9W9Y4yRfBV/Y
         WiFXmnLyhr725VbRiKaZAWRv0rqswAuwQk3wBEcRypXDjZEXaVcFHQs0sgLfDwXu74rM
         8jcMrf43hPj0O9LFlS8u/nN+GejVFbbSIW/J8fy8m3z8Evshm9qEEwgtY7KTBseWRIdi
         D2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRKn6lITYEJiR285FiWpm4qlLh4mttnvAIbrbFKA6EE=;
        b=dFNYjLXbWrZH/ed70uTA2V6/t2uDhM3Gkipn18lLJ2T+eDlgw9GN136IVAQhrKimCO
         IgcaWY1vw4ZvU+YZ2VGqR0kk1vvT1K9rHzgYhD7Lqr/yQGDlrd7qbIxgD8gslJtCV1Wc
         dRE0OR4ShZAlThR+uum3ODt1h9pICSFYEHFm0/PXEb2UX1c45u6vXoNBvzgeTMTGVFD2
         k+wZGij5kN42K6J6ozSM0hcQSEGwsIL/+ejNa2yeOQTNuW8F7HJ4HhmoAp7VtMU2JBID
         nrrLPCi5YTfiHxxJVCiRSz1g0n4f+V352fF3uyu6N3pLAm7NcrFYZ4nHWRwdTkfQw6cQ
         0HKg==
X-Gm-Message-State: ANoB5pmgH8027rzST5VLMdka2ZA+KNWHUxQwI0od9DMzGKDFnhDX3RrA
        GJ9TTuV3yx7NIV9HyHpe276k7ifbCtmafg==
X-Google-Smtp-Source: AA0mqf6H/TqUSAMdodQ3h0s3nGPL7vX30RkTPuxfgklnSIYgdUuY7YG4dPfalOpwAl06TQbjz2LKag==
X-Received: by 2002:a17:907:7d88:b0:78d:f456:1eb1 with SMTP id oz8-20020a1709077d8800b0078df4561eb1mr30776330ejc.2.1671121226732;
        Thu, 15 Dec 2022 08:20:26 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id y1-20020a170906914100b007bf71053d97sm7212597ejw.40.2022.12.15.08.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 08:20:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p5qy9-006O8W-1w;
        Thu, 15 Dec 2022 17:20:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 2/4] read-cache: add index.skipHash config option
Date:   Thu, 15 Dec 2022 17:12:01 +0100
References: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
 <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
 <00738c81a1212970910da6f29fe3ecef87c2ec3a.1671116820.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <00738c81a1212970910da6f29fe3ecef87c2ec3a.1671116820.git.gitgitgadget@gmail.com>
Message-ID: <221215.861qp03agm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 15 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>

> +	end = (unsigned char *)hdr + size;

Commentary: The "unsigned char *" cast has moved up here from the below,
that's needed (we're casting from the struct), and we should get rid of
it from below, good.

> +	start = end - the_hash_algo->rawsz;

Okey, so here we mark the start, which is the end minus the rawsz,
but...

> +	oidread(&oid, start);
> +	if (oideq(&oid, null_oid()))
> +		return 0;
> +
>  	the_hash_algo->init_fn(&c);
>  	the_hash_algo->update_fn(&c, hdr, size - the_hash_algo->rawsz);
>  	the_hash_algo->final_fn(hash, &c);
> -	if (!hasheq(hash, (unsigned char *)hdr + size - the_hash_algo->rawsz))
> +	if (!hasheq(hash, end - the_hash_algo->rawsz))

...here we got rid of the cast, which is good, but let's not use "end -
the_hash_algo->rawsz" here, let's use "start", which you already
computed as "end - the_hash_algo->rawsz". This is just repeating it.

I wondered if I just missed it being modified in the interim before
carefully re-reading this, but we pass your tests with:

	-       if (!hasheq(hash, end - the_hash_algo->rawsz))
	+       assert((end - the_hash_algo->rawsz) == start);
	+       if (!hasheq(hash, start))

So, we can indeed juse the simpler "start" here, and it makes it easier
to read, as we're assured that it didn't move in the interim.

> +	git_config_get_maybe_bool("index.skiphash", (int *)&f->skip_hash);

Aside from the question of whether we use the repo_*() variant here,
which I noted in my reply to the CL. The cast is suspicious.

So, in the 1/4 we added this as *unsigned*:
	
	+	 * If set to 1, skip_hash indicates that we should
	+	 * not actually compute the hash for this hashfile and
	+	 * instead only use it as a buffered write.
	+	 */
	+	unsigned int skip_hash;

But you need the cast here since the config API can and will set the
"dest" to -1. See the "*dest == -1" test in git_configset_get_value().

So, here we're relying on a "unsigned int" cast'd to "int" correctly
doing the right thing on a "-1" assignment.

I'm not sure if that's portable or leads to undefined behavior, but in
any case, won't such a -1 value be read back as ~0 from that "unsigned
int" variable on most modern platforms?

Just bypassing that entirely and making it "int" seems better here, or
having an intermediate variable.

I also wondered if this was all my fault, in your original version you
were doing:

	int skip_hash;
	[...]
	if (!git_config_get_maybe_bool("index.skiphash", &skip_hash))
		f->skip_hash = skip_hash;

And I suggested that this was redundant, and that you could just write
to "f->skip_hash" directly.

But I didn't notice it was "unsigned", and in any case your original
version had the same issue of assigning a -1 to the unsigned variable...
