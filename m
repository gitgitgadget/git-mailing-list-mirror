Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85266C61DB3
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 15:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbjALPFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbjALPFG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 10:05:06 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34915BA0E
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 06:53:58 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c17so27124028edj.13
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 06:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1VdZ2w1QCJnCHvd7kDyVbIX2A4/+as6qDFSMQ9sS2VE=;
        b=GzVbzTHM5DteuquTbKLFxD2/lbBQn0tsQ1/NCdI6nYfdnpn0+sGhd/Pwxjy9498PY/
         MCkD6cZiiOfpj4M/Scdc4JKY+mdPpANfnUgn8xrzi7Idlr3JfbPAx/feOmpZTvtgQsSd
         BZmYUaLrZTIJ7t3bdZ9DQmxkmtr5bGIGA8ZnuxcbghidIowv6Ab6r1at0W+qfrOkjMaF
         NLAX2qLcJrOt1F9iAH2LzPs/If/GXXJCc/T6toVkWo/Bk9VpGHowPu3yfu5Yv7PwS7j9
         dhrnQmmelbz7lEoTr12O/NWXVAVVtyYTnhguIEMsB2HnprtHKsQeH5q4qpuLxe+I8l9N
         hlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VdZ2w1QCJnCHvd7kDyVbIX2A4/+as6qDFSMQ9sS2VE=;
        b=5UXFrlo3kQzx78p8d8W6U2GsJ7sJDR2Q5wQCej7KnAkZflkFU4p5TaoPXbqlsdwHxT
         JT/sHPntxFV/Gz1ZNqKBeylCp53Zax8VoPOsx74ZFHVK9XKseVnDsaxD8FejoAXibqxd
         Gq1A+M5JcY3sijAKeUISOtodHpuOqScLHpqZjIARykRQkQobjGczNyaAImrR6+GQgBBt
         d6oHvEJcobjo8Efo5KGOieNZUOq0Vt5TK496mNUkD40O8dDEM5WQxptrYmoMv/tPcXkP
         tlc8ZykPf/z/H/i4/vd6VCkUJFxdIunHuF8N6ZIO77QlsJckSkYmG+d+x1ReKIDHuYxp
         8tGQ==
X-Gm-Message-State: AFqh2kq0QEZuIfFRbKVsAlh/baIv+o3HjwKOrP7xEVYec6ThIOAUzzUv
        Sb28ITCtaNTD2hUqPuPtrGtcS+0VxV1Geg==
X-Google-Smtp-Source: AMrXdXvDbJuW3bQ4dPcGe0xmtitR+k0gcHC4d0+qW0g3bNnBJTVROTWj4YvXCVEaq8T9TVqp1lSJuQ==
X-Received: by 2002:a05:6402:229b:b0:499:b415:bb27 with SMTP id cw27-20020a056402229b00b00499b415bb27mr13549059edb.4.1673535237236;
        Thu, 12 Jan 2023 06:53:57 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id fj20-20020a0564022b9400b0048ee88aa4d0sm7182451edb.56.2023.01.12.06.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 06:53:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFyxo-000HBs-0h;
        Thu, 12 Jan 2023 15:53:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 5/6] ls-tree: cleanup the redundant SPACE
Date:   Thu, 12 Jan 2023 15:53:07 +0100
References: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
 <20230112091135.20050-6-tenglong.tl@alibaba-inc.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230112091135.20050-6-tenglong.tl@alibaba-inc.com>
Message-ID: <230112.86h6wv248r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 12 2023, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>
>
> An redundant space was found in ls-tree.c, which is no doubt
> a small change, but it might be OK to make a commit on its own.

No need to update this series for just this, but if you're doing an
update it would be nice to mention that this minor typo/unwanted syntax
has been there since 61fdbcf98b4 (ls-tree: migrate to parse-options,
2009-11-13).

I.e. to clarify that this is rather ancient, and not some fix-up for a
recent topic (or fixing things earlier in this topic itself).

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/ls-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index a743959f2b3..72eb70823d5 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -14,7 +14,7 @@
>  #include "parse-options.h"
>  #include "pathspec.h"
>  
> -static const  char * const ls_tree_usage[] = {
> +static const char * const ls_tree_usage[] = {
>  	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
>  	NULL
>  };

