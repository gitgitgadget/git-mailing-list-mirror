Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CBBC433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 13:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbiKQN11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 08:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbiKQN1W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 08:27:22 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA455F85B
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 05:27:20 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f27so5088787eje.1
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 05:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UokLNrlgLAv5UwecSwuHvHauBpFznMScegQIDwvrfUw=;
        b=JCQa0sQM4LQ0uNbHeajOaxf/YENWk6B3YHrBpiLutNGSaMImQ2fJvfKxOyIsioAyFx
         uAeFIdEqZVOHPkpWNd+f6JzvqF3sydfEt4YyCT7gWS9SxNMIxdeNc0dyv5DjoZY6HAQK
         H7/zsS/Y0MmoMY5Ty9Z+qkvDmJilbMtrideGKrwkiHgnaWKapJiDqNAgcIFcT5h7p2nr
         l9NvC5l1o7fsiwxUjT7xA/50w/4k2GbJW8VD6b0qC3LHA9uP34u8LM5MpRNplF2+kxgm
         5BXoJ7XCsf3KjuHqB8phQl2p10F+ewL8np4913TUNj8yduEEh/y/zXGxSPQeTkEnTs/X
         PDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UokLNrlgLAv5UwecSwuHvHauBpFznMScegQIDwvrfUw=;
        b=ntuWsNdsHpxZLxP40qZuWED/9NUf4HvoPbEn7rFe+yc3Yo3diAMDVQm2NlexKhMWZM
         Cgz3u8S9FhbapSJ99L5hs4kzaOYeg2so9hEhxwSTmEt/nSu2ipAa0AnyYoMhPOTTcug5
         lzsUHu6peJhCad1QB/mwqyrrg56KK//rzQ5bLPaeTeGBWnv4dKj34JPvdDbdWDELKYKh
         szL56DjH0Iy6m+5mnwrXfr1eEBP/98CkbMAtWB98+B3QMvdzxX+bXOs5FY/kkFrh2oAX
         AcD0A00EKfte48lDoAuKvlc7ZaoK+eufmdpyItCY54h7x/bzbGt8UM7gvHdeQAV3URam
         t9QQ==
X-Gm-Message-State: ANoB5pmWEM4+F8chpkjgINPTCWD6t7lxZ0uP0mGoBWn3WK0iA3lT1jc8
        m5Dy0WL2SDce6M1yuTmy14o=
X-Google-Smtp-Source: AA0mqf4OMsZzwHNIolBJOa7zgFdVKTJlnJcd40YDphron9jE208t1dDvVELYeLGv68RP/dHyKYebAQ==
X-Received: by 2002:a17:906:50f:b0:78d:ad5d:75e with SMTP id j15-20020a170906050f00b0078dad5d075emr2154753eja.172.1668691639362;
        Thu, 17 Nov 2022 05:27:19 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906310100b0078df26efb7dsm371127ejx.107.2022.11.17.05.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:27:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovevG-004oiT-0x;
        Thu, 17 Nov 2022 14:27:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: [RFC PATCH 0/6] ls-tree: introduce '--pattern' option
Date:   Thu, 17 Nov 2022 14:22:20 +0100
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
Message-ID: <221117.86k03tiudl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 17 2022, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>
>
> This RFC patch introduce a new "ls-tree" option "--pattern", aim to match=
 the
> entries by regex then filter the output which we may want to achieve. It =
also
> contains some commit for preparation or cleanup.
>
> The idea may be not comprehensive and the tests for it might be insuffici=
ent
> too, but I'd like to listen the suggestion from the community to decide i=
f it's
> worth going forward with.

I applied this series, compiled with CFLAGS=3D-O3, and:
=09
	$ hyperfine './git ls-tree --pattern=3D[ab]c.*d -r HEAD' './git ls-tree -r=
 HEAD | grep [ab]c.*d' -w 10 -r 20
	Benchmark 1: ./git ls-tree --pattern=3D[ab]c.*d -r HEAD
	  Time (mean =C2=B1 =CF=83):      14.8 ms =C2=B1   0.1 ms    [User: 12.0 m=
s, System: 2.8 ms]
	  Range (min =E2=80=A6 max):    14.6 ms =E2=80=A6  15.0 ms    20 runs
=09
	Benchmark 2: ./git ls-tree -r HEAD | grep [ab]c.*d
	  Time (mean =C2=B1 =CF=83):      12.5 ms =C2=B1   0.1 ms    [User: 10.0 m=
s, System: 4.0 ms]
	  Range (min =E2=80=A6 max):    12.4 ms =E2=80=A6  12.8 ms    20 runs
=09
	Summary
	  './git ls-tree -r HEAD | grep [ab]c.*d' ran
	    1.18 =C2=B1 0.01 times faster than './git ls-tree --pattern=3D[ab]c.*d=
 -r HEAD'

So the value-proposition isn't really clear to me, and the included
docs, commit messages & this CL don't answer the "why not just 'grep'"
question?

That's faster even with another process for me, but likely that's
because you're doing the regex matching really inefficiently
(e.g. malloc-ing again for each line), which could be "fixed".

But in any setup which cares about the performance you're likely piping
to another process anyway (the thing using the data), which could do
that filtering without thep "grep" process.

So I don't see the value in doing this, but maybe I'm just missing
something.

And, in terms of the complexity for git's implementation it would be
really good to avoid the complexity of a "--pattern", "--sort-lines"
etc., if those use-cases can be satisfied by piping into "grep" or
"sort" instead.

Some of the pre-cleanup here looks good, but it's unrelated to the rest
of the series. I think in any case that it would be nice to see that as
another topic.
