Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C09C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 11:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356B961139
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 11:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbhH3Lnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 07:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbhH3Lnl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 07:43:41 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB0AC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 04:42:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id q17so21181546edv.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=lA+sVEOiLUd0doLEPm7YUb42tWv+MW64eYpeaWHq9Sg=;
        b=u/3lroA2aOm32Z8b7hWT4oP/xdhglk7ah0EoNQF1vGA/v48Ennd7Lj++Ft/lRZqmfh
         s3mufqnu4Ky0Oywy7onKmVyS2at/IdCZdjqjBXBw8JM35lg0ruWxf1cDGGxKL/0Fk8bq
         TtV4/y4GgKPXcrhPE+DtdZi2eWj1c84eWAjP/ks1TfWR/AyMWOktM8DvUn3Uyic8nd7f
         hFimC12tEO3Lbm+Mulg7Q2KG/cfBvE4ATj3vRqrVt9B9NTWUtemsbWdtp4hpuQY7E4QD
         /YYQxYJQpWUOu0ZSiv4bL124rqO7whg7LPV/ma+uczC881uaghTuWWw17eL8zkgGmBBV
         o0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=lA+sVEOiLUd0doLEPm7YUb42tWv+MW64eYpeaWHq9Sg=;
        b=MrWaYOTuNXaxqt72XL7HEAeilWRQN3a/CdLG07OIVbyREsG8ttpUAzLPvDTv2MXyHU
         U6t6ToExTSCT+2dyTQAxwbsmlYoQsKrmgLYaJrLUi+0CiOvhYLsdQ3Eb9lB3zwVYw9Oc
         Zy/6CRNH6DrORwlNLeq9+aoCZwaxmcseRNvN9B/BzHGu53mKsUt3Snxgo2nEj3h94C2t
         4FtZ+E44H3PFt8FudCKCNDt/w0IEgVIY6yNWDLf4FNMkdQ5o7CsoYP8qt70YFjeGDvjj
         /NV0rB48IT0V4ddW7MAdsLV4I3e7oVz4b7iHnRtSH1RklD4Mw3QYwZ/xJ130HQDNkHnT
         Db5w==
X-Gm-Message-State: AOAM531JLstDhamSfPoHDSy5CvBOI6plDXKeFwA/yYw3R9e56fEBFE/l
        nbrpDzAKRm4WYU0KXOfZF0M=
X-Google-Smtp-Source: ABdhPJwgv7lNtseUy7c6O/Ohut/q/Rt63UKDqWexn3h1gC6RdcVFSI8ySYkzrSNqEaSFddFJnPcrwg==
X-Received: by 2002:a50:c31e:: with SMTP id a30mr23624776edb.123.1630323766126;
        Mon, 30 Aug 2021 04:42:46 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v1sm6856107ejd.31.2021.08.30.04.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 04:42:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH/RFC 3/3] ci: run a pedantic build as part of the GitHub
 workflow
Date:   Mon, 30 Aug 2021 13:40:53 +0200
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com>
 <20210809013833.58110-4-carenas@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210809013833.58110-4-carenas@gmail.com>
Message-ID: <87wno3xioa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Aug 08 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> -linux-gcc-4.8)
> +linux-gcc-4.8|pedantic)
>  	# Don't run the tests; we only care about whether Git can be
> -	# built with GCC 4.8, as it errors out on some undesired (C99)
> -	# constructs that newer compilers seem to quietly accept.
> +	# built with GCC 4.8 or with pedantic
>  	;;
>  *)
>  	make test

Aside from Junio's suggested squash in <xmqqeeb1dumx.fsf@gitster.g>
downthread, which would obsolete this comment:

I think this would be clearer by not combining these two, i.e. just:

    linux-gcc-4.8)
        # <existing comment about that setup>
        ;;
    pedantic)
        # <A new comment, or not>
        ;;

We'll surely eventually end up with not just one, but N setups that want
to compile-only, so not having to reword one big comment referring to
them all when we do so leads to less churn...
