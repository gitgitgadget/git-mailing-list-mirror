Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDCCC4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 09:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKYJKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 04:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYJKV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 04:10:21 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E59275FB
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:10:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso2910819wms.4
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6AYkdKjJRjTL/RO/3fWaPGbphnqiA2Ca7XVERdasXC8=;
        b=RhRl2tb5gUulCtBP9RO1oM+ukkBfhLFXdqgwC4akYIhA4pyxgAb1JQHebNJjxOJYA1
         GTZHNgr+twE33eYGK6Ev6CZdfpyTFTWpapgtVBbRPlKt46j/pPn74KcBo/XO/PUgcwEV
         bDdwzpE1tfXWCGSY4gqJX1Kbg3VXLquQNIvNjzbJoQZls+KnH/VFHHZInPXoHKQqCUIm
         evQwehhN4DWU+MYv3aU76wmq2cC86rFCQrlvqdOCVZRXeXc4E8D6ahdBosQXC55fEFAy
         5nfXAIK7qQ8ClfKc0j5/Iv0HYPu+wED9iaIApRbxFsKPPl/cCzAGRYMG2ED4tphZdfUv
         lrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AYkdKjJRjTL/RO/3fWaPGbphnqiA2Ca7XVERdasXC8=;
        b=1Jvmf722XV3tj88vSXsz+SSyyN2Pv7cSBuH69z3UeUiwaoXt9Jvk+Y1PUBzXpfvudT
         qLecfK2U2GEKLjwyPPhw4oVYqCTWd7e1ytIpx0XJnC74v+IGP/M0ObNQEkt+VPZj9jzp
         Ig9KWBekBjHTJxBxt/J4NsEM8dvM3p8/mTGYttmwuEKhC1BHjycD6Bst02kZRXtle81p
         kMBaA1Bf9ArnQYtrCOqxHBEAgWMOWdOv5tc/chTa9vcq2LnYTGU4f1MBKTHh7VLttHpN
         ohNT1nvNG2/MavBaUwVYAHuPgsy28rum8YJ/rlW8U2+sHTc4alFvqoJi7Kly6lptuQC1
         TGYg==
X-Gm-Message-State: ANoB5plnNDEbBOpXXOa4CzdK2qxa7m5zK/RllCcGyi+uVQ5KOLmyqdl1
        crvtwZqnxYSFeIuD0BfOuKVM869ubwm2T6I5
X-Google-Smtp-Source: AA0mqf77DdhAV+Z7bExLLHLfEp3vYXkPnTWatRLni0Y5mfG51Au+tFidageZ0LFGpgBXvR+3qCdgPw==
X-Received: by 2002:a05:600c:4e12:b0:3cf:d4f7:e70d with SMTP id b18-20020a05600c4e1200b003cfd4f7e70dmr15758168wmq.187.1669367418144;
        Fri, 25 Nov 2022 01:10:18 -0800 (PST)
Received: from gmgdl ([149.38.4.46])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b002365b759b65sm3218484wrt.86.2022.11.25.01.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:10:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyUgp-000S6K-1w;
        Fri, 25 Nov 2022 10:08:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Yoichi Nakayama <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v7 1/3] git-jump: add an optional argument '--stdout'
Date:   Fri, 25 Nov 2022 10:06:50 +0100
References: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
 <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
 <446777d300d73498bd7da709fad75731a13d0d59.1669347422.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <446777d300d73498bd7da709fad75731a13d0d59.1669347422.git.gitgitgadget@gmail.com>
Message-ID: <221125.86y1rzmmfc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 25 2022, Yoichi Nakayama via GitGitGadget wrote:

> From: Yoichi Nakayama <yoichi.nakayama@gmail.com>

> +use_stdout=
> +while test $# -gt 0; do
> +	case "$1" in
> +	--stdout)
> +		use_stdout=t
> +		shift

Put this "shift"....

> +		;;
> +	--*)
> +		usage >&2
> +		exit 1
> +		;;
> +	*)
> +		break
> +		;;
> +	esac

... here instead, as I showed in a comment on 3/3 you'd need to to that,
or copy/paste it for every option once you have >1 option. See
e.g. "test_commit" in "t/test-lib-functions.sh" for a function with that
pattern.
