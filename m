Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08453C3DA6F
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 21:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbjHWVDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 17:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbjHWVDA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 17:03:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ACF10D
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:02:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99d937b83efso786713066b.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692824577; x=1693429377;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jx8na+QOqElJBSW0n2lhO99oqqazS+hDXAIpMUpzAE=;
        b=EOTvXU4Rjqb7grMv9Iq2oPDgfHx4Y1uHkn74pkYMIPBqYBYFDSSEt8w0A2Gbpcws39
         or9qo8NVPR3685p+4r8jkq7BtxvGT2layA1UBXw+zQpJe5GkadZnQYqIqsmXBIaif5Xd
         YeqO0KKdyggw9mp/LdZqe+hTjld2IHRO0C0mddwG7btMSov5PY3sbdaU0dFm5j8CLJYC
         3gIaq8BCerfi+IcjsroD97I6xcnh/atZj7NQcrFxTDpSDt/dfObPbo+YhsXSaNUz+m1w
         eOJ60LLGXfbxkK0TdgGrIKW3z5GMSYhCEkewrDGeNYDkubaFgfPVs8QGrROaBWbgrTEC
         GN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692824577; x=1693429377;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jx8na+QOqElJBSW0n2lhO99oqqazS+hDXAIpMUpzAE=;
        b=ECjlvPi0tyQmgd6LztN+MQ+18l8jva5avI6scpZrtnviiGHrDeoXRw/S9iLG8psaLF
         HEhUhe86MzYZhbqab8iIuIIZ1S/VILEFQqymW3lD4k4J5VUfgovC9URpuZ8dSAbbN1/V
         61BE0NPnR3WZIbAGwjL92lZeRX/44CSHRPcM8MkmvGVnbzqtY1F4NryVRuHZxgPpKgdz
         3skFLbn/7kJDK3kdEmUjivJFbUPIjfLNEuHfLPTQ2YzEpUShAwcxZ39JJNo1LKQk6KJd
         5bmamYh8hZD1d97UBYAXPvsM1mWaQbXMo16jCqYLPiiwXkyrxINbfxLyLIjE8QQ2b3n6
         6VxA==
X-Gm-Message-State: AOJu0Yz7UpAPHhOWzvl6L4oirbphQt1i9rsqAg/Xz+BTNr2Yfw187fgp
        /mHCWzDMagC3aOjRxbC+iCiA7o+riQYU
X-Google-Smtp-Source: AGHT+IG5JRO+XichcekhXo1y2qRlqGIrDbR5/JHQQQAfS64xZoyDFQIlSEgdiX6KoSj2NXoA+bkG5w==
X-Received: by 2002:a17:907:2cce:b0:9a1:7919:d3d3 with SMTP id hg14-20020a1709072cce00b009a17919d3d3mr10285133ejc.51.1692824576519;
        Wed, 23 Aug 2023 14:02:56 -0700 (PDT)
Received: from smtpclient.apple (2001-8e0-2230-4a00-4450-2fe5-aba1-b176.ewl.ftth.ip6.as8758.net. [2001:8e0:2230:4a00:4450:2fe5:aba1:b176])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709063a5500b0099cbfee34e3sm10297871ejf.196.2023.08.23.14.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 14:02:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Ganriel_N=C3=BCtzi?= <gnuetzi@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Git credential-cache manager is not treating `path=` correctly
Date:   Wed, 23 Aug 2023 23:02:44 +0200
Message-Id: <14F3D856-6A3B-45F8-B5FD-9CD5D0CB7C47@gmail.com>
References: <20230823192207.GC2355007@coredump.intra.peff.net>
Cc:     git@vger.kernel.org
In-Reply-To: <20230823192207.GC2355007@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: iPhone Mail (20F75)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot for this informations.

What I did not get from the documentation ist that a =E2=80=9Cstore=E2=80=9D=
 of a generic (without path) credential , e.g https://www.server.com will
just overwrite the more specific ones already in there. (So that is the case=
 in my test, right? And the prompt happens in the first fill because useHttp=
Path=3Dtrue but there is nomore any credential entry in the cache which woul=
d match (only the generic but that does not match), right?)

I selectively applied useHttpPath for certain urls such that any other url n=
ot using httpPath
matches the generic one (urls for submodules which I dont want to add creden=
tials).
So I just have to make sure the generic ones are added first and then the mo=
re specific ones (with path)

I am not sure but I thought that using cache is safer than store because i g=
enerally dont want to have credentials on a disk.

- Gabriel


Von meinem iPhone gesendet

> Am 23.08.2023 um 21:22 schrieb Jeff King <peff@peff.net>:
>=20
> =EF=BB=BFOn Wed, Aug 23, 2023 at 06:23:36PM +0200, Gabriel N=C3=BCtzi wrot=
e:
>=20
>> # Add 3 credentials, 2 specifics with `path=3D`
>> # 1 with general host.
>> {
>>    echo "protocol=3Dhttps"
>>    echo "host=3Dwww.server.com"
>>    echo "path=3Drepos/1.git"
>>    echo "username=3Dbanana"
>>    echo "password=3Dbanana1"
>> } | git credential approve
>>=20
>> {
>>    echo "protocol=3Dhttps"
>>    echo "host=3Dwww.server.com"
>>    echo "path=3Drepos/2.git"
>>    echo "username=3Dbanana"
>>    echo "password=3Dbanana2"
>> } | git credential approve
>>=20
>> {
>>    echo "protocol=3Dhttps"
>>    echo "host=3Dwww.server.com"
>>    echo "username=3Dbanana"
>>    echo "password=3Dgeneral"
>> } | git credential approve
>=20
> I don't think we ever planned around this kind of "sometimes paths are
> important, and sometimes not", and I'm not surprised it doesn't work.
>=20
> The "useHTTPPath" flag is only read by the by the main Git side, and
> just tells it whether to pass a "path" entry. On the helper side, any
> omitted entry ("path" in the final case) means "match anything".
>=20
> So that final command translates (from the helper's view) to "store
> this, and delete any other credentials we have stored for
> https://banana@www.server.com".
>=20
> It might be possible to change the handling on the helper side to
> distinguish between entries with no path and entries with a path, and
> consider them separately. I don't know what gotchas we might see in that
> case, though. I suspect at least in credential-store's on-disk format,
> there is not really room to distinguish the empty-string path from "no
> path given".
>=20
> If you set credential.useHTTPPaths (so that it is applied consistently),
> I think path-matching should work. But then you'd have to independently
> store credentials for each path that could match the "generic" case.
>=20
> As a workaround, you could use two different stores/caches. Something
> like:
>=20
>  [credential]
>  # store most stuff here
>  helper =3D store
>=20
>  [credential "https://www.server.com/repos/1.git"]
>  # turn off the main helper, and use a path-specific file instead
>  helper =3D
>  helper =3D store --file=3D$HOME/.git-credentials-path
>  useHttpPath =3D true
>=20
> -Peff
