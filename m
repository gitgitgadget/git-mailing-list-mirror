Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A692BC35240
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732FB22522
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYxcNdcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgAXDis (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:38:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45235 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgAXDis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:38:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so406412pfg.12
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WA52tRk0FG+gbXC5oU5P4Viee5uwsLc9f7MjHO/2K64=;
        b=VYxcNdcB1U6J5vo93Hywtzap8ALa5Jq8NLcVIc0bQglERhT4b2AzC2WNUPpsBUhAb4
         DyEkG/Gs3r/QCBzIKrgE45SV6Ne+FlyZ25JRrt29SAUZe05jwlLhNtxFc04YWMumFtkI
         gWPdiqb9pXxDoA3wrxZ4TFCy9E6dwH7Q7jtW9D1Z9ZMFxaR545zaGukdCC0w30pAk+yl
         rLmtX60IdC5bkA9jEagzwODeaPmdLZ/Lq3xZZwpJ+2r46Ulp9WXkEM/Y0tkEzDgE1EHF
         iuNt3zK6Rz8lr7GoB1EW7urvm66iFe6Pza2trt0GwQUB6WMx9/oJZrxAJmVBCDwGn0Nz
         lmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WA52tRk0FG+gbXC5oU5P4Viee5uwsLc9f7MjHO/2K64=;
        b=jnUpovaEvnIvsuYfPHzGIe86AD2zZe7uVZPkO8Nc4OwDFMEp8j6fsSj1aR0EAyCWEV
         gw3LLDiq39ugy7vt9qLk67QHaguIahxD8eWVf1c3AGdeo0j4VmZGBSQzyvEsAXhFaWVc
         ATAaqhDICTbvKNGAjx6FkszfVFEr7hZDsRDjdRJvHvWzw/lhwIqzH7aPDE/g0zpYltO/
         eTf8ZpiF4eWGdAl164tSovtWuogd0v9xq1U52O0W9S1LsxqRXPAFL98iPMrxbAchWHgp
         ioxw+wuOS/gZMFVJljFLt89y25XjacDx7NCRJzGCMWSIGO1QrVkzfX6p8VSlCFNkuUcF
         b3JA==
X-Gm-Message-State: APjAAAX84/hpTe/b55PRPvH5cNEz9t+AzQjsNFIRbT+UOU6v7ib6EfNu
        279epPGMlkHv69lIlEFLvvCsK3sQ8tE=
X-Google-Smtp-Source: APXvYqyjB+FTxqgPWeM7jLRKZpsqnwa8TZvUdO0+e4Ip8VpdtEKT/3vRq5koPX9xl+PbRXJNbQHJ4g==
X-Received: by 2002:a65:645a:: with SMTP id s26mr1713009pgv.321.1579837126899;
        Thu, 23 Jan 2020 19:38:46 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 199sm3911496pfv.81.2020.01.23.19.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 19:38:46 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:38:41 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH v5 00/15] add git-bugreport tool
Message-ID: <20200124033841.GB37541@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20200124033436.81097-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A sample bugreport generated from this patchset follows:

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

What did you expect to happen? (Expected behavior)

What happened instead? (Actual behavior)

What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to send.


[System Info]
git version:
git version 2.25.0.18.g682ab0d3eb
cpu: x86_64
built from commit: 682ab0d3eb8b84f8af4db1a161d24ca53d2f39fc
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname -a: Linux 5.2.17-1rodete3-amd64 #1 SMP Debian 5.2.17-1rodete3 (2019-10-21 > 2018) x86_64
compiler info: glibc: 2.28
$SHELL (typically, interactive shell): /bin/bash
git-remote-https --build-info:
git-http-fetch version: 2.25.0.18.g682ab0d3eb
built from commit: 682ab0d3eb8b84f8af4db1a161d24ca53d2f39fc
curl version: libcurl/7.66.0 GnuTLS/3.6.9 zlib/1.2.11 brotli/1.0.7 libidn2/2.2.0 libpsl/0.20.2 (+libidn2/2.2.0) libssh2/1.8.0 nghttp2/1.39.2 librtmp/2.3


[Safelisted Config Info]
sendemail.from (global) : emilyshaffer@google.com
sendemail.from (repo) : emilyshaffer@google.com


[Configured Hooks]
pre-commit
prepare-commit-msg


[Loose Object Counts]
2549 local loose objects
2641 alternate loose objects
5190 total loose objects


[Packed Object Summary]
60 total packs (591308 objects)


[Object Info Summary]
.git/objects/info/foo
.git/objects/info/bar
.git/objects/info/bar/baz
.git/objects/info/alternates


[Alternates]
2 alternates found (1 working, 1 broken)
