Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E117C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 14:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DBB62067D
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 14:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="ln3mUqf6";
	dkim=pass (2048-bit key) header.d=nyu-edu.20150623.gappssmtp.com header.i=@nyu-edu.20150623.gappssmtp.com header.b="i9I/SAYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgGAOWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:22:11 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:14028 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731202AbgGAOWK (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Jul 2020 10:22:10 -0400
Received: from pps.filterd (m0094546.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061E8LwK071906
        for <git@vger.kernel.org>; Wed, 1 Jul 2020 10:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=xJfx/BOc0Gm91TEdwua856wn7SykvLtIcvJH/KlK4Ts=;
 b=ln3mUqf6tiMOvk7WVqumLInabsdDJusl7UJ6V2NbKuy6eOtcJj0uqYeNwQdHtjfhcg8r
 Ja+hAHcv6tzjueA7h+LRmA6f5pEg1xvxaLOwRHUV151fzD04xnjpYLrk+RyL6tqFVjV4
 ClfHFVu67Oiohs3SjQ/TgLqMqFxUg1lvLongNIXGuKqkKJ5VHcyzBdZeKZ2YyX/TJBZ2
 1ls5PZ6ZZMfPxVMdJU9Pzvb6zIkyXZ61F0a7pC8xKSe56fOA4Qe7dqwUg7n15KVZOU5i
 1KxcGtQXJxgPN/818b8+sO8E0OLrj6KcJZ9JlAjkITi526+dhFBpzcT7z4/LDW/4vqMV vg== 
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mx0b-00256a01.pphosted.com with ESMTP id 320g6h7c3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 10:22:09 -0400
Received: by mail-qt1-f199.google.com with SMTP id c26so16891468qtq.6
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 07:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xJfx/BOc0Gm91TEdwua856wn7SykvLtIcvJH/KlK4Ts=;
        b=i9I/SAYJ9ThUSkSogEfnDPnGUtlvJwKNYUN3yZw/ebUFUM43D8MQ0WSzpMw5OMK2hV
         +MVMG/sohbge+DmCqO+N01nc1/Y29YMNz7r7jw9jsfblNY5sEs+vhF9PZHphbLcQYU1e
         NuJKGUSLfy77wJ/E4UlSwxZ65Ps0xuZDHDUP4+WaLyhaMc3r3AVHPe9T8jh5znAWLxEL
         YN7iwfg7et3ES+JlGnG7vB9SebcNsIfXcVBh0a1QfSTGgxzm5Z52nVLDPZXx/YOjfJtI
         8UqZpNGjOlNt2OV/BUeSIIV4+NisaUvU2k+sgTFA5opJgPi+6Y3wMEZdsvH5I0c2/Otp
         xOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xJfx/BOc0Gm91TEdwua856wn7SykvLtIcvJH/KlK4Ts=;
        b=sDjcZH3q283PkiweacI4+nmfSP5A4tR/uEXFjCRM5D8JMOSzNKRZbP6QW13TRXWfLY
         D/1yVF+2kS4luROM+trY0RtlwFre/gpRLjjzqzMVcVio4RNM8zSbrLI6ylq+YeDBMYLn
         waERxErUBBuBFK/d2BLsEjGBKkRZz/N2HSf+PaSFlhnkrvVIKAN8/AYz3pUo78uswDhR
         DYds+nWRvzkJq/pcy+nPvRzmcD5bPqHN3IgLhx+ZNVYI22lL8vyWr6/hcdMkv3andluW
         0upRWc6rEEEmo8LqL6DDJOxIsvnBKLHgFuDdt8HvUxkebFxzoG9gjuWB2ZwNc0B2VBJO
         0J0Q==
X-Gm-Message-State: AOAM533/Qo/Zp5gfCSh++Z8zSL5aSt6GvMIak1rJjeDjpTFrWxw2Lp0h
        gltc2A1mnlsUdV6k14t4xqH7rqT560fgunwyozTKSuXEJIJ03UXzYpdZeDwZcrH7ZmDkil+fc6W
        KyCIRhfR2eG0=
X-Received: by 2002:a37:e8c:: with SMTP id 134mr24497177qko.462.1593613328074;
        Wed, 01 Jul 2020 07:22:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqaqUVU9J5FpBoROp5arpQ8SEhSZA+DowHoqQXjIDdNo/4y/SVthQ/ADRZ4PYecw8a+TeJ5w==
X-Received: by 2002:a37:e8c:: with SMTP id 134mr24497165qko.462.1593613327832;
        Wed, 01 Jul 2020 07:22:07 -0700 (PDT)
Received: from LykOS.localdomain (ool-2f10876a.dyn.optonline.net. [47.16.135.106])
        by smtp.gmail.com with ESMTPSA id q189sm5923977qkd.57.2020.07.01.07.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 07:22:06 -0700 (PDT)
Date:   Wed, 1 Jul 2020 10:22:05 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     "R. Diez" <rdiez@neanderfunk.de>
Cc:     git@vger.kernel.org
Subject: Re: Interrupted system call
Message-ID: <20200701142205.3gwltulmkrd6iljk@LykOS.localdomain>
References: <14b3d372-f3fe-c06c-dd56-1d9799a12632@yahoo.de>
 <c8061cce-71e4-17bd-a56a-a5fed93804da@neanderfunk.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s5h65za233mii63l"
Content-Disposition: inline
In-Reply-To: <c8061cce-71e4-17bd-a56a-a5fed93804da@neanderfunk.de>
X-Orig-IP: 209.85.160.199
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 bulkscore=0 cotscore=-2147483648 impostorscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=680 priorityscore=1501 spamscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007010102
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--s5h65za233mii63l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,=20

> Nevertheless, I am surprised to get such an "Interrupted system call" from
> Git. A long time ago I learnt that it is OK for many syscalls to get
> interrupted, so you have to loop around them. See here for more informati=
on:
>=20
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__250bpm.com_blog-3A1=
2&d=3DDwICaQ&c=3DslrrB7dE8n7gBJbeO0g-IQ&r=3DyZMPY-APGKyVIX7HgQFZJA&m=3DJwtG=
1XJ8aqvchYKsbjW23-PqEl4qm4xuOrYLaF8MOK4&s=3Dk58MMdPdIRPl0kpuTohwZo_3GbW7elv=
ojU1wjTil2GY&e=3D
>=20
> As a result, users should never actually get an "Interrupted system call"
> error from any software, at least when no sockets or non-blocking I/O is
> involved.

I'm not sure if you can blame git right away (it could be an underlying
library), and I'm also not convinced that "interrupted system call" is
an error that should never exist for users (error handling is generally
very nuanced).

I'd advice to use GIT_TRACE_FSMONITOR or just GIT_TRACE to figure out
what component is the last one in place before things failed. You can
read about these on the manpage on the "other" subsection of the
"ENVIRONMENT VARIABLES" section.

I hope this helps!
-Santiago

--s5h65za233mii63l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAl78nA0ACgkQRo8SLOgW
IpXcHRAAmujs+2A4xwKNm2BllkkoNZW53/+WdU0bW3N6WSzdlctJyTlbBshyVh/q
Zo9doGdW6zMh0X8nTG0XsJw50JHy7JdRK6VtCFosklHX7q3lFg8VWZatB7y0ndjL
9EMXFkfDgviPbEQTQJWKcnWdHma/NlOZFtyifTW3jjCV5dO4JzWPTKoc158MbDWu
+iaGa0CllWWQqJFHY2iv7FAOsKHbaL3XLnYyST3KZWLKtgDmZye/GABoeSpEwo0E
uRQZy9qRqeRXmq7QlVv6ErFcxJbgV4baKhJEBz5mbREV6OiTHcD5KC20c+GLpBpY
SK/quyR8M6hBLFbxhvhxMdMZBkdjxYfhG+6Byphy/IEBES7yt8h6ZCbm8P2XCyUF
OhaeEgPCZd020e+rdW6ITlmBUVIc7gFwPIcdID9wZLrdyXBtx10juptVRTJU/T7n
9y3uaINTchIF3JrxPgW76RRj8pFERO+R4w8nQOXUV83V62pUZYR50RyFD6erV18U
t/t/xuKNos/glEycyWfrBAirv8wtydITy0WqTH3D6UcZw/QCtEaiHO+A7KY27Mzj
qiq7BCqIrDzpIKQCRBb3aLpUnK95eQgSh5QywPnb39qehMt7IjouaHZ70T2WoCrG
xOx5gDvEqTIWfLTSgpNwtD9kE/L+RhF6irjtd+akr1vp3KU+ZZs=
=u7AF
-----END PGP SIGNATURE-----

--s5h65za233mii63l--
