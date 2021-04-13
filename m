Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB90C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 13:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2AB61369
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 13:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345350AbhDMNO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 09:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345953AbhDMNOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 09:14:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1F0C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 06:14:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r22so19312778edq.9
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 06:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=2NjoPAo7CdlgS6htiXOWvJF7lUBrBo1O8DqOxouVhGI=;
        b=heOQZm/YEBw8C/mGTOUWE0WVQStltFYxIo4Lj6ofDKg0/ASHJw8XK2FtyYy1qdiiUL
         HGR+5yZTu3pbj/MmH+IzI+y32om/xCEN967pWKQrbj8uRF7C55BBOxajdfW517ZbwSfy
         bsOWNzUVkDeAm9rmTI6UmtWDEXwNzSvvhJUYFSK0YSqzWQ/buT7PVMnna1gixGHiiYr/
         sRIOgUOrLTtUWTlD3ZYwvQ8KEehC/bMlcHcRhgwRC1wAyWELGo9IuAFz+YSJT1TBgZuU
         0YL0i4ipaRjZV78JRmjnSCFih4XPAJKkWz7WJ0JBVETXNaDgRU8eMJxVqcvC4cdh2ba3
         B2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=2NjoPAo7CdlgS6htiXOWvJF7lUBrBo1O8DqOxouVhGI=;
        b=C9YHG7Nb6NrGGHleUFhD8ko9f0fvB1o2rD9iwZBMTf8sDJT/XmRcBpIfkmMFSgF4eZ
         VgnLsQJdDrKmIVHRJLeIiVp9C0rSuKnJk/sNjPJ+Jm/++6N3VnKImiKGfbYWJGf17W6P
         Lk3WD7WW2AOz4/zZIoDHisRqU5SHdxp2FDSznpeI4nJ6+CYW7Q+13TFhOLERcQbqvbwu
         3ndlhAp0y3BB8SBbtqRya5+ZDZBiOG/Wcluh12sZE8HSR0W59faYE+SeUaxC92AbyTN4
         VEo0WF57nifH42Tftjv9gjEz2l9pQugPb9pWZZYcNB3hWS8KlNIdqJZBs6SbfSN9IbAh
         QjKQ==
X-Gm-Message-State: AOAM533VZdC0dEJOLEtsfMJQhVdHwu7x4HmLL2PYkUL0TlMwZ9Ll3hhs
        Yme7YprQR40CxTi5KWnN1UASusfv2ns1IQ==
X-Google-Smtp-Source: ABdhPJzjGkOKFVuUiq8xtkc06BaHP0yl6XkFl0CpuvXch6KpQD3hpYrtFhq0UpJnjzxdHGmPQDX7TA==
X-Received: by 2002:a05:6402:1a31:: with SMTP id be17mr35717093edb.330.1618319642660;
        Tue, 13 Apr 2021 06:14:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d10sm924149ejw.125.2021.04.13.06.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 06:14:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 04/20] reftable: utility functions
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
 <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <df8003cb9a7d9e017d358251a2d22c0e72454e03.1618255552.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <df8003cb9a7d9e017d358251a2d22c0e72454e03.1618255552.git.gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 15:14:01 +0200
Message-ID: <87r1je2up2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 12 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> diff --git a/reftable/system.h b/reftable/system.h
> new file mode 100644
> index 000000000000..07277ca06273
> --- /dev/null
> +++ b/reftable/system.h
> @@ -0,0 +1,32 @@
> +/*
> +Copyright 2020 Google LLC
> +
> +Use of this source code is governed by a BSD-style
> +license that can be found in the LICENSE file or at
> +https://developers.google.com/open-source/licenses/bsd
> +*/
> +
> +#ifndef SYSTEM_H
> +#define SYSTEM_H
> +
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +
> +#include <zlib.h>
> +
> +struct strbuf;
> +/* In git, this is declared in dir.h */
> +int remove_dir_recursively(struct strbuf *path, int flags);
> +
> +#define SHA1_ID 0x73686131
> +#define SHA256_ID 0x73323536
> +#define SHA1_SIZE 20
> +#define SHA256_SIZE 32
> +
> +/* This is uncompress2, which is only available in zlib as of 2017.
> + */
> +int uncompress_return_consumed(Bytef *dest, uLongf *destLen,
> +			       const Bytef *source, uLong *sourceLen);
> +int hash_size(uint32_t id);

Related to the comment in
http://lore.kernel.org/git/87a6q2egvy.fsf@evledraar.gmail.com

I'd think that rather than duplicating magic constants & one thing in
dir.h we'd be better off having some leading patches splitting off the
relevant parts of object-file.c & dir.h, maybe THAT_NAME_minimal.h?

Or: why not simply include dir.h and object.h etc? The compiler/linker
will discard the unused functions, and if the worry is overuse of
git.git functions creeping in I'd think that would be better done via
some test/CI job that checks what objects were used.
