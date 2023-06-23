Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D05BEB64DD
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 09:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjFWJp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 05:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjFWJpz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 05:45:55 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CFA294B
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 02:45:32 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b479d53d48so7610571fa.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687513528; x=1690105528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zX5MvX69IHaLZ25vYVmTvuz7O0vrZaRkffFVHYP+gp8=;
        b=SVPuH4Wq3d8Cd9etuqWpAk4CFDGdfIv7cdfWUFtgXLXYRNRDjQg2Hu+O5tiSWgzX30
         8Vrk6hls43ZkwCDz5awq9Em6PBWWqnXZv4qbHiV13glGfPIlXHkE7hNkj26b4lHgZHkg
         buGxhXbdTRuOTZ9oI/7O3uRHcaKUDh3OS3fNUdYFIJjDMTHnxrNdusvdy2z4nvc23ayT
         xa/mA6ILll8B+2aqDGSLK6Cw7SMfl/h377jhTE27yLsmMty5MWaEagbEPLMA8xYUKCEQ
         qlWwt3bzykLLC0AhQtzJId/D02pfr3qdPFFaA222kaUp6hHfgeInsTfrQc8piX/3DyhS
         V0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687513528; x=1690105528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zX5MvX69IHaLZ25vYVmTvuz7O0vrZaRkffFVHYP+gp8=;
        b=Q3sXpiDdipYVvjZi5Os9dd+hgTLKyn+ouOCuDqPWA7+syPygqpfo3J6xhkvvbsiwQz
         9YsNKOEp7vKeg79yjvv73Q3GEVeJVACy07miD9mWTSXMFIwuxa/ysBA2B6gVpbUK9uSM
         liKyu21kd00NEiqQnZltePiCKqlpZDesyD/GL8C0a/SLlJZZ+Ef5jObAmDA3LgL8ODHF
         KhH9giCYX0E9K/q1Vxmr3YE6vnWv4WYoVqzzn3vo3Yo+S1fXOHYmKagMMnIgHLzmKANy
         tmACcJ+tIsJ9ZDe9lG2bqMtR0ia1D2RjUwH/F+vMSMaYK3OqnIs3hXJQEkxtm8og8cBE
         B0Dg==
X-Gm-Message-State: AC+VfDzlzJo+pjmVD/fB4/OGhrquGxnwDgNX6VxDmxmY3gEkvywsLCLm
        ITWLtfDmB5F9ylT0KimP3158kPqbnOc=
X-Google-Smtp-Source: ACHHUZ5+JbeVRIeYAPq3Lhw9cyaij5S+EY0gyPCnxZUaakxw6/6xmHgGpzHa5N+AljyMCvknkHhrbQ==
X-Received: by 2002:a05:651c:1031:b0:2b4:5b65:c914 with SMTP id w17-20020a05651c103100b002b45b65c914mr12450988ljm.24.1687513527611;
        Fri, 23 Jun 2023 02:45:27 -0700 (PDT)
Received: from localhost (92-249-246-82.pool.digikabel.hu. [92.249.246.82])
        by smtp.gmail.com with ESMTPSA id q6-20020adff506000000b00307c8d6b4a0sm9091180wro.26.2023.06.23.02.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:45:26 -0700 (PDT)
Date:   Fri, 23 Jun 2023 11:45:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     git@vger.kernel.org
Subject: Re: Getting path to a file from arbitrary project directory
Message-ID: <20230623094525.GA4204@szeder.dev>
References: <21c8396c1441dd4f74cd2097ac970a2033b81da4.camel@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21c8396c1441dd4f74cd2097ac970a2033b81da4.camel@yandex.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2023 at 11:52:58AM +0300, Konstantin Kharlamov wrote:
> (please keep me CC'ed, I'm not subscribed)
> 
> Hello! I'm trying to solve a simple problem: while I am inside an arbitrary project directory, I want to get a path to a file `filename.c` located elsewhere in the same project.¹
> 
> One way to implement that is with a command chain:
> 
> 	cd $(git rev-parse --show-toplevel) && git ls-files --full-name -- "*filename.c"
> 
> But it is pretty clunky, because that requires you to modify state (changing current directory). It may not matter though, but I'm just wondering if there's a better way to do that, something like `git ls-files --top -- …`, or anything like that? Haven't found nothing similar in `man git-ls-files`.

When a command expects pathspecs as arguments, then in general the
leading ':/' magic means the root of the working tree (not sure where
it is documented, though), i.e. you could try this:

  git ls-files --full-name ':/*filename.c'


> As a separate note, this doesn't work:
> 
> 	ls-files --full-name -- $(git rev-parse --show-toplevel)"*filename.c"
> 
> 1: the usecase is I have a Emacs helper function to pick up a an aribtrarily mangled path to a file in the project from the primary clipboard and open that file. It's often "mangled", because gdb prints it with `../`, then logs print no path whatsoever, just a filename… So it's generally useful to have.
