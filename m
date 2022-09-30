Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BDFC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 13:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiI3NyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 09:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiI3NyP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 09:54:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28091157FD2
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 06:54:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l14so9153736eja.7
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=cYN82o5KeXX8QAlh5uQjpuinf9k0XlU7JvuyOyuIJkU=;
        b=fEy6EBSNol39rlF+XJXjuyusWwdnslTrgPsHd2FIyuYrXrjDfUdU8C37VLS2RmvNJU
         Uimxodufka82L4TLSGIGhwqOrW8PtUUFwVclIocCECv2eKcJ7iuAzVbkd8ySYmmiCtO0
         7ELjkOo2VRcn/aRrEPY8ZqLKmT3T4WDeNiEJ1fglDE/tNkg3BnVfp/mS67jjAfgH+WuV
         BYcUbSCwNUmrsUc1dBGAS8694kaa4UazsSlW0HQM8zmMT0hvYdy4RTgB5HCFSLO/XypP
         QTENUsOVMuCwho4kvn+VgXKI3DJxqEqCATz1GZ7ftVfCjZxZffOOQgm0wwQlyVD8lZvh
         mu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=cYN82o5KeXX8QAlh5uQjpuinf9k0XlU7JvuyOyuIJkU=;
        b=KVFczKnmH228s5UAC4y0+5z9KQq4+qFAJiiUJ9TH7AD2OB3KkZgdkT3fFZX9J8GPHt
         OPJqJZS4pb+gFnWMcpci9vNca/ULYmOxlIJjyAt54ToIu+zoG/eCsQoShDv/cxLm1Ykz
         PBGEq9CeBxQyzjMGDhMzed+uILs4zsGxXb7cdZowSQ2xxKHsIYOeQD/GY7Q7Rqfmn+es
         4WYk5doA78GujC7o6PxizjXeAXTyc5TJ/RBZsQlfZB1fnzbOW4G5ZW9Epm6t4Rtw6LXx
         M0b2J7bmBmfm+4PcQV3r1DDojHNkPRT8onviPrXJoiH/XWLMd6S3rb3+Asdrm+5ztZqY
         jtxQ==
X-Gm-Message-State: ACrzQf0N2WMX+o5Kh28ckT3upzVsl+rDIXlNV5Ibd3isrYuiu4J2AnUA
        Xmjc+sxMcAeijVuuaWGsJcMgYfLA6Ho0EQ==
X-Google-Smtp-Source: AMsMyM63ENDEEV5DXwEZz9SizTKU41476ySM6kB5d9PlLgJ5kKnYmGsnLwwthIAbTQ3ollvo1tgaQg==
X-Received: by 2002:a17:907:8a13:b0:782:5146:dffa with SMTP id sc19-20020a1709078a1300b007825146dffamr6460175ejc.538.1664546052521;
        Fri, 30 Sep 2022 06:54:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906328e00b00787a6adab7csm1220113ejw.147.2022.09.30.06.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 06:54:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oeGSw-001ktD-2h;
        Fri, 30 Sep 2022 15:54:10 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Subject: Re: icase pathspec magic support in ls-tree
Date:   Fri, 30 Sep 2022 15:53:16 +0200
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
Message-ID: <220930.86r0ztufwd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 30 2022, Tao Klerks wrote:

> Hi folks,
>
> I just found out today both that icase magic exists (awesome!), and
> that it isn't supported in ls-tree (boo).
>
> As far as I can tell, getting it supported would be the only way to
> *efficiently* prevent caseless-duplicate files from being created in a
> repo, in an "update" hook: I'd want to call ls-tree on the new head
> commit for the branch, passing in an icase pathspec for all the files
> being added since the previous state - and then sort and uniq.
>
> Of course, for entirely new branches I'd have to do a full check of
> the tree, and for very large changes that might be the fastest/best
> thing to do anyway, rather than creating a silly-sized pathspec - but
> checking the full tree costs me about 1 second, a price that I'm loath
> to pay for everyday commit verifications of a handful of files, vs a
> 200,000-file full tree.
>
> I tried changing ls-tree "naively" to just permit the icase magic,
> without any logic changes, and found at least one case where it
> doesn't work: when combining wildcards with case-insensitivity, like
> an icased "T/*" patchspec in the git repo; ls-files finds all the
> tests, and a naively updated ls-tree does not.
>
> I think I see the last person to update this was Nguy=E1=BB=85n Th=C3=A1i=
 Ng=E1=BB=8Dc Duy
> in 2013, giving a hint as to what would need to be done to make this
> be supported; is this an area anyone else might be looking at at the
> moment?

You might find ASCII-only sufficient, but note that even if you get this
working you won't catch the more complex Unicode normalization rules
various filesystems perform, see the fsck code we carefully crafted to
make sure we don't get something those FS's will mistake for a ".git"
directory in-tree.
