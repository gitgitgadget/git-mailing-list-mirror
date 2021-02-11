Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF62C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D18864E44
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBKT2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhBKT2I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:28:08 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FF8C061574
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:27:27 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g10so8189927eds.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bD4WRRiZ2j+wkL4rPL9282KS11vOYLtV6ZOVgDh+ccs=;
        b=R2US6nn5JyegTGoxFHMwCRAd4TjYzBlG31qTHWIvuQEBDvWQw8iEbi8J7l9/i+ez1c
         vcmcgdnjVP6Ns5pGSVcnMAkPv6Gs0lpSrKQJwvw2htkPpN0XufuQ6xcL1y+Rgtbpw5Pf
         WRCYqiK2GOJGZpAE82KUH/YrwlZ/wDRhJxIpuEob/VhVwK8hizQ2b+6r/MNwHTmIqFj4
         T2TwxgGOqNlvze7eF+woyTWzYB11zDXLdU87WxTJCiZysVK09d9AOwiFauObgmhDpHLH
         RThGtQEE+P5tH+Uzvu7CbtSXt1a6ipkvUf5gtC/E32uRHcFj+9GEDJDmLNUdS5N1+j+0
         756g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bD4WRRiZ2j+wkL4rPL9282KS11vOYLtV6ZOVgDh+ccs=;
        b=iTCMFCkmQ8QWFUlNqKDsH9Ym8EP3UpKD62UTjdyG0P4oLgJc/dwH0QjPiB6DjtTrDT
         Xnf6K+VmGjmrl9SXNGuKifKJNE862xik8B1U+WLh8CrJr+nrHCOtiuDpCeTozqUcIIAk
         4CbvWh8N3VPYGab6NM/ak71gOkoq1yNToLt6ukHJMxa0GWuOrYd9eexLLuRCUwPFgsZ2
         Mz+fwmdKJNbehu76PDVbpvzoeNomBYSkrJZHcxRsG4bm3ivGRw5TWF70Z3YVG/cK7eCi
         UixGdxFp0b3qinAIGKs0JhzzC/jZ6IyYZozKE+7y9V0vt4s5sj3sTw3Vu37+1SyRIZXw
         Cs6Q==
X-Gm-Message-State: AOAM533e/9ICPwtWXjas1LQepoiyBN6MuUnaIRsH4k56BhxgWNvId2vf
        esaLQa6DwEw+KYKr4G3NcTk=
X-Google-Smtp-Source: ABdhPJz29t7k3a8QDF7AUepS4o+M1/EuDsyUZVYU2QnnXCBk9f61KSNQ54wfApOBp0MldtH0Ec0ZLA==
X-Received: by 2002:a50:8a90:: with SMTP id j16mr9631169edj.334.1613071646643;
        Thu, 11 Feb 2021 11:27:26 -0800 (PST)
Received: from szeder.dev (62-165-238-147.pool.digikabel.hu. [62.165.238.147])
        by smtp.gmail.com with ESMTPSA id t11sm4675553edd.1.2021.02.11.11.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:27:26 -0800 (PST)
Date:   Thu, 11 Feb 2021 20:27:24 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 12/12] test-lib-functions: split out {debug,path,text}
 helpers
Message-ID: <20210211192724.GF1015009@szeder.dev>
References: <20210209214159.22815-1-avarab@gmail.com>
 <20210209214159.22815-13-avarab@gmail.com>
 <xmqqpn18yee4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpn18yee4.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 09, 2021 at 04:06:59PM -0800, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > Split out the debug, path and text miscellaneous helpers into their
> > own files. The "test -[efsd]" etc. helpers were not all in one place
> > in test-lib-functions.sh, I think moving them into their own file
> > makes it easier to follow the code.
> 
> I'd prefer not to see this done.  It would be fine to move them in
> different sections but still in the same file to group related
> helpers together, but I am having enough trouble when deciding to
> look into which between test-lib.sh and test-lib-functions.sh in the
> current organization already.  And it will make the situation even
> worse if we did this, no?

Indeed, I'd rather not see this one, either.

