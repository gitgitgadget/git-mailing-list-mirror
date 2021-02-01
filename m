Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FF6C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 10:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57DD60234
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 10:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhBAKB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 05:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhBAKBW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 05:01:22 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B11FC061574
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 02:00:42 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id k142so3747177oib.7
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 02:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SmAAeMz20knL2ECHnwAluvZnPlYD6CxaNQbpB6LeXfE=;
        b=uGVo0GCCV//2FzQwRjKxLtOyJCpR9cfObrpw20kG/BgXktL4/d7VkQRbwBkNrBtZSH
         iZlm/PcI0AuQG0f7oO8yqx30UBoxTZWgPIAFalK4tVcPkspj0rNFfzU/j/nDN3ah/Vyv
         VZmkdSAXW0CynAUDiXok4rsVPZFcShdsWEU2a1WOYyxDHrshQPGJHwomVs0XqkjutwXF
         zOBuhQGNQI8Il4lIOBABwvW713bIcpQGDcziZCzS5W9DniqM7wUJ7ClnfH9W+W4iCrah
         zAa9UjvskAG7tZRiLCzXL2NoVu3VI4mHUMjDeXNgIh2LU9vzI1EJlSeLfIljxCvUYf8P
         I7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SmAAeMz20knL2ECHnwAluvZnPlYD6CxaNQbpB6LeXfE=;
        b=eJlDn2q2GKJjMGf417fU1N9W3Mb/+qNZX5ZHFE/72QNmyPolBIwHAcSUwx4Vca97tn
         Fnv9rOCghLKld99LNaE8u1v8qbK3n4ih5jDqUgRq7oOpR4S9gQ/T+72MEicEHUSSwfLK
         Hfoy2B2Jkkz52GkOMCXKZ13sfc8SiCu3iViDyfgcUxczQV48puQylC9GWta13YaWWJo4
         g/zsva/AQM7//zPvsZh7o1IfMnCPv2svEyA+8dISUQqQCjOL5jGqmkCWqJJsid4e475N
         4Dpy5zG0tMoVoh5yd+jMhG5ryvJ60jk3yqc4W1Q/Dn27hZkmb8DDIlIemwSo+kfQqSk1
         CD2g==
X-Gm-Message-State: AOAM533t42Ij7DCe7vK3Z2dnbkcxcDuwTJW3ZVzGRebdeomtZwFnPqYs
        545UP1mK6TRtGJxYGi6HVW6H8pbXD60HEwJ77ik=
X-Google-Smtp-Source: ABdhPJw4hwe/LRKyJ/rWVUWxMFzYw1K1A6OBKuwyJWVwCO1WldAdrmRqDm4YHAAMYLVqlrNyHnJyrKPeiVENxOmgFpk=
X-Received: by 2002:aca:5b46:: with SMTP id p67mr10746263oib.179.1612173641746;
 Mon, 01 Feb 2021 02:00:41 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POKSOaaq0A-L2RgQ+R+bJVo-KuZChEOcCuO8jP+Cm9QFPw@mail.gmail.com>
 <CAOLTT8SsmzNNvQHaP3+vQmuq0fdRbFNL8ukOvPW5Zw9+nPk32Q@mail.gmail.com> <20210201095143.GO6564@kitsune.suse.cz>
In-Reply-To: <20210201095143.GO6564@kitsune.suse.cz>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Mon, 1 Feb 2021 18:02:44 +0800
Message-ID: <CAOLTT8TPucR2PRUqE1C9a+vB_-vw=4caycwPixzmJTkkOKpXRw@mail.gmail.com>
Subject: Re: Recover a git repo after accidentally deleting some hash files
 located under .git/objects.
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Hongyi Zhao <hongyi.zhao@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek <msuchanek@suse.de> =E4=BA=8E2021=E5=B9=B42=E6=9C=881=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:51=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Mon, Feb 01, 2021 at 01:56:55PM +0800, =E8=83=A1=E5=93=B2=E5=AE=81 wro=
te:
> > Hi=EF=BC=8CI don't think so unless you have the commit
> >  in github or gitlab which include this file=EF=BC=8C
> > maybe you can use git pull to get it.
> How?
>
> fetch/pull complains that the hashes are missing.
>
> In this situation I just delete the repository but it is kind of stupid
> that git rells you exactly what is wrong but won't fix it.
>
Is it so? I thought it would work normally, and I hope git can fix it one d=
ay.
Thanks.

ZheNing Hu

> Thanks
>
> Michal
