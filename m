Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B8EC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 08:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJNIbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 04:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJNIbU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 04:31:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976401C25DF
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:31:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y14so8903525ejd.9
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F2zrevw1u/wYABsXeQVGlCw3XtbLCj7HEImzuD90UA=;
        b=GlL8LYXqVfZaI9eZyNhF/NBflEUBbtrPYa3kpav/5Q9bHvtbueOQOf5PfWMYqNp69j
         gFCpM/NXwT6hrOEaR48OLuiDgIwzHbTMKSZJvugv+hCbzBSRhzmiwFxvFFxJnYi7iYwf
         RAcehXB+HutDCvVkgBMpVRdrtjQVyRZKVzt9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2F2zrevw1u/wYABsXeQVGlCw3XtbLCj7HEImzuD90UA=;
        b=S7GKJxBpAtq7cFx9ZSxfaJ84yzyeAGZIL6EkUpviO3QBseRrbs2yYzOCuuovjmZYjo
         8xBXClh3VZKZPfrTj3/67WmHj0PZeMMXX/vufp4qUokYu0AQws25sN91dfyWqK8FMfN9
         4DeW5OFvHBKGs+rggn0+wr3twed95Khim5JhVEzfo92Nw558eeeh5VKc01mCyjMqaPJG
         OTLS2Qz/Iql4uDkS+TKJOusmUCEqte7T0stTspVB0UekpFmbA0bzlSF4vH4olRmbae3K
         lCA9PEkhOpIpE3TK7YngIjVCm78X9HFDNWRZ5QJOlGBaKHjS+fauSrjuVdtl0j7EZOET
         nOxw==
X-Gm-Message-State: ACrzQf3UpVyztRytHuhP6O6L3mx2Er362qZv+bN9kzfSkV8WT7Js6TSf
        gqhCpfmx/YlHIMMeG+Hx5zLmbT919ES6smxBhqvs92qkfhMoEkEI
X-Google-Smtp-Source: AMsMyM6btkkLU2Y2fSDEw7ezuex6c0MVwbj533SJNnxj2SV10TVZndo26mcEUG3o+TI6VSSGdGVokFR9gZMQikHETlw=
X-Received: by 2002:a17:907:6e93:b0:78d:dff1:71e3 with SMTP id
 sh19-20020a1709076e9300b0078ddff171e3mr2670515ejc.94.1665736278101; Fri, 14
 Oct 2022 01:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
 <220930.86r0ztufwd.gmgdl@evledraar.gmail.com> <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
 <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com> <20221014045140.7ibix3632w4uset5@tb-raspi4>
In-Reply-To: <20221014045140.7ibix3632w4uset5@tb-raspi4>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 14 Oct 2022 10:31:06 +0200
Message-ID: <CAPMMpogoX+R7eHkTZQKkx6HiS4ksk_sjryyuAufD_xuLfCVD+A@mail.gmail.com>
Subject: Re: icase pathspec magic support in ls-tree
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 6:51 AM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> On Thu, Oct 13, 2022 at 08:35:11AM +0200, Tao Klerks wrote:
>
> Did you ever consider to write a shell script,
> that can detect icase-collisions ?
>
> For example, we can use Linux:
>  git ls-files | tr 'A-Z' 'a-z' | sort | uniq -d ; echo $?
>  include/uapi/linux/netfilter_ipv4/ipt_ecn.h
>  include/uapi/linux/netfilter_ipv4/ipt_ttl.h
>  [snip the other files]
>
> The GNU versions of uniq allow an even shorter command,
> (But the POSIX versions don't)
>
> git ls-files  | sort | uniq -i -d
>
> I think that a script like this could do the trick:
>
> #!/bin/sh
> ret=3D1
> >/tmp/$$-exp
> git ls-files  | sort | uniq -i -d >/tmp/$$-act &&
>   cmp /tmp/$$-exp /tmp/$$-act &&
>     ret=3D0
>     rm -f /tmp/$$-exp /tmp/$$-act
>     exit $ret
>
>
> ####################
> The usage of files in /tmp is probably debatable,
> I want just illustrate how a combination of shell
> scripts in combination with existing commands can be used.
>
> The biggest step may be to introduce a server-side hook
> that does a check.
> But once that is done and working, you probably do
> not want to miss it.

Thanks for the proposal! Sorry I was a bit vague in my "I suspect I'll
have to do a full-tree duplicate-file-search on every ref update", but
your suggestion is almost exactly what I meant.

On my machine, on this repo, a full-tree case-insensitive duplicate
search costs me about 800ms for 100k files, or 1,800ms for 200k files:

git ls-tree --name-only -r $NEWHASH | sort | uniq -i -d

I need to use ls-tree rather than ls-files because this is indeed a
command to run in an update hook, and there is no working tree - no
(relevant) index, in a server-side update hook.

The 800ms for 100k files are composed of 200ms of ls-tree, 600ms of
sort, and about 10ms of uniq.

My intent with supporting icase pathspec magic was to do something like:

git --icase-pathspecs ls-tree --name-only -r $NEWHASH -- PATHS OF
ADDED FILES | sort | uniq -i -d

Which would be near-instantaneous in the vast majority of cases (and
I'd have some file count limit past which I would fall back to doing
the full tree, to avoid excessive command lengths). Unfortunately,
"--icase-pathspecs" is not supported in ls-tree, hence this thread :)

But yes - ultimately, paying that "full dupe search" per-update server
hook processing time cost has seemed like the only sensible way of
doing this - until I thought about Elijah's suggestion a little harder
that is!

More in the next part of the thread.
