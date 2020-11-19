Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AE9C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 09:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42587246CA
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 09:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsuDS2oL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgKSJBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 04:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgKSJBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 04:01:12 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D57EC0613D4
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 01:01:11 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id y17so6768940ejh.11
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 01:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=up9tAGZjuGBAJrKyoPM1B9iVYt/FgDuEsB3apeGCNvY=;
        b=MsuDS2oLlgW4aacRVUsa7b+lSIyAnDoVIG2KjzcoCAKDqDUB2q9XUzQnkrtYjiFrSO
         QCEIEtM5EIJV2xXQdtF9xElpLT1nMhAFaCatmeuzALB9Zara61i6gc00kaZkj7ehaFzp
         4M/Q8hsYm+0rCNaRbiK24/28/WzYSfQM0Ga+gNcc4pN8IBX0kLFMUjtEk93C0ObXWISC
         B6pG5wy/KAAjAg+qtqlSN5SSGtaW7lmrPWhzERNqVkXFNeKwwPHQPqRwexYllbvVvEou
         9GPcpa+92JzFSddBFg9GDqQV2bM6fkt/gJeT05fPaaC/WF2nXdsB3GjAQUt4mwhlEfBk
         1+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=up9tAGZjuGBAJrKyoPM1B9iVYt/FgDuEsB3apeGCNvY=;
        b=kq/79iyTyAv/oQOr44DgyxxsW/f8nhOTT2wL558beHcFBM0BW+Rb60xDF+tY5XYMft
         rZsNiDYEIfSmzhD5eeUCh5/HhHj9pWQmfPj/FpUAXTCeFHTsh12D+5Difsumf9pj5E1f
         Rg3YJ1T8f2NUOpyi+79DWiHAg0FHYZyH3/3+mfH96zUeOVmQX1M9kl9YpQs2Vd/fv8lg
         ivISNCIPs/nz1AG/Q9bOzKWYtzcf6k4fHh7irBwj+VURDFSmgnftfJt5GLiAqIlnwDs0
         zqBVrHxphMfPOanDSpp1JdkELENYgT792UA1kKTfhYglt5dkjjhYqSdPJS23q5VGvxB6
         1qFw==
X-Gm-Message-State: AOAM531V4UzXPfRVCgdvdpgzs615JYZ2MmAGEq2lsEgBomozHsDzlUc2
        Bwcv7uevjNh78SLOk0uACXhSs/8Lf+++DA==
X-Google-Smtp-Source: ABdhPJyb5VQt+gWyK8o38Ut8hH5+bb6u5WUKdt/V3PjgoM4d9fIjmOQgkxaCZkPBk8aU/tR/WGcbuA==
X-Received: by 2002:a17:906:5793:: with SMTP id k19mr28546565ejq.410.1605776469586;
        Thu, 19 Nov 2020 01:01:09 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id n1sm631713ejb.2.2020.11.19.01.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 01:01:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gerardu@amazon.com,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: RFC: auto-enabling parallel-checkout on NFS
References: <20201115194359.67901-1-matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201115194359.67901-1-matheus.bernardino@usp.br>
Date:   Thu, 19 Nov 2020 10:01:07 +0100
Message-ID: <87y2ixpvos.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> The major downside is that detecting the file system type is quite
> platform-dependent, so there is no simple and portable solution. (Also,
> I'm not sure if the optimal number of workers would be the same on
> different OSes). But we decided to give it a try, so this is a
> rough prototype that would work for Linux:
> https://github.com/matheustavares/git/commit/2e2c787e2a1742fed8c35dba185b7cd208603de9

I'm not intrinsically opposed to hardcoding some "nr_threads = is_nfs()
? x : y" as a stopgap.

I do think we should be thinking about a sustainable way of doing this
sort of thing, this method of testing once and hardcoding something
isn't a good approach.

It doesn't anticipate all sorts of different setups, e.g. in this case
NFS is not a FS, but a protocol, there's probably going to be some
implementations where parallel is much worse due to a quirk of the
implementation.

I think integrating an optimization run with the relatively new
git-maintenance is a better way forward.

You'd configure e.g.:

    maintenance.performanceTests.enabled=true
    maintenance.performanceTests.writeConfig=true

Which would run e.g.:

    git config --type bool core.untrackedCache $(git update-index --test-untracked-cache && echo true || echo false)
    git config checkout.workers $(git maintenance--helper auto-discover-config checkout.workers)

Such an implementation can be really basic at first, or even just punt
on the test and use your current "is it NFS?" check.

But I think we should be moving to some helper that does the actual test
locally when asked/configured by the user, so we're not making a bunch
of guesses in advance about the size/shape of the repository, OS/nfs/fs
etc.
