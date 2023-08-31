Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6975DC83F01
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 12:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243772AbjHaMr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 08:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjHaMr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 08:47:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF92BCDD
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 05:47:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdc19b782aso5161525ad.0
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693486043; x=1694090843; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4KLr9jmLOvFHT9mqBebxl/X5LXF0f1kQwldhTmYGadY=;
        b=ov6l1Wy9IuxOv/I3cNZMpR2nH5F3FNr6sZk17xa3wv7J65IvPVsPeImF4hnEBU+H8U
         akk7HVKzz6TV8zQFeznxxSHmi/rqe50aaqXM96JgMh5GswBu/5MQY90YRpbHK9lFiF8m
         0fpG4fnxSbKxA/ramsg9IVju5Dvb7wpUlg5xsgT6CgoyVqdxRjUfdmJCAXFz1Ii9n8G9
         UGQBkUFUQ5KrQpxsOAklX5YXAQNBOSghTCFB6yIRzC5ZLPAEmX210E3KKAAbCbEF/6rZ
         QiUD/djb18nEh1+Mfvti7xI/9T2B/IQXyTmLOdmzr+mMY225yup9i4InzmPl20Qro9gt
         hJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693486043; x=1694090843;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KLr9jmLOvFHT9mqBebxl/X5LXF0f1kQwldhTmYGadY=;
        b=XZ3mMTKSZpcvPnSgbZ1sLGGV3uMcKVRKYo6Psar/QaZCbj2cyuX609ZV/bvnzjhTck
         RaXhV5JrpJs+XvDbBPUu4xVXkp3JZtctveEfHYbtgh9Kf3BkV8mazJXTX4tCiU3Qi6cp
         SxNYsfJoG0EXdB4lTMbL8shLHH8g7jeXw70TGgRQE0otM544DyOJ2NO9pSq6F3oZS4PI
         zoVAKYi9+Ku7OAnVjz1SaG2SuKj0HRqrljr+y1SWUsIskE7rrW/hmNHiYEg1B0NLYTQQ
         awOtFWinmA0E1myZtWvR7aju8UC9iywmpz28G/+Wmn1mxfc93AiJT48kMU0m+WqitZ/r
         W8zw==
X-Gm-Message-State: AOJu0Yz+bfwHENqvLQDgaNjr2k5P5UCPya612nap5UpGAJbxPVIZ+XRV
        mfmrf/O/H3nGRAkhvGE+JWF9QuoVXmg=
X-Google-Smtp-Source: AGHT+IFuGjcUm4NdoFL0BQjzz77EYXFt0y0yU5dshbzmYW4iDGoBMAYTxcMIKBu/xAbfKadDTebzDw==
X-Received: by 2002:a17:902:d2cd:b0:1bb:994c:bc43 with SMTP id n13-20020a170902d2cd00b001bb994cbc43mr6292721plc.18.1693486043157;
        Thu, 31 Aug 2023 05:47:23 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001bc9bfaba3esm1193012plg.126.2023.08.31.05.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:47:22 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CDBC18DF487E; Thu, 31 Aug 2023 19:47:19 +0700 (WIB)
Date:   Thu, 31 Aug 2023 19:47:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [REGRESSION] Can't clone GitHub repos (fetch-pack error) due to
 avoiding deprecated OpenSSL SHA-1 routines
Message-ID: <ZPCL11k38PXTkFga@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yc4bsmYi7xTmWFYY"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yc4bsmYi7xTmWFYY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I built Git v2.42.0 on Debian testing, linked with OpenSSL (v3.0.10 from
distribution) with Makefile knob `OPENSSL_SHA1=3DYesPlease=20
OPENSSL_SHA256=3DYesPlease`. I tried to shallow clone git.git repository:

```
$ git clone https://github.com/git/git --depth=3D1 git-scm
```

All the necessary objects were fetched but the clone errored instead with:

```
fatal: fetch-pack: invalid index-pack output
```

This issue is a regression since v2.41.0 doesn't have it. Bisecting, the
culprit is commit bda9c12073e7 (avoid SHA-1 functions deprecated in OpenSSL=
 3+,
2023-08-01). AFAIK, the culprit doesn't touch `fetch-pack.c` as I hoped.

The full bisection log is:

```
git bisect start '--term-good=3Dok' '--term-bad=3Doops'
# status: waiting for both good and bad commits
# ok: [fe86abd7511a9a6862d5706c6fa1d9b57a63ba09] Git 2.41
git bisect ok fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
# status: waiting for bad commit, 1 good commit known
# oops: [43c8a30d150ecede9709c1f2527c8fba92c65f40] Git 2.42
git bisect oops 43c8a30d150ecede9709c1f2527c8fba92c65f40
# ok: [1d76e69212102c3373b552186590b76d6ad8d84c] Merge branch 'jc/doc-hash-=
object-types'
git bisect ok 1d76e69212102c3373b552186590b76d6ad8d84c
# ok: [914a353a128d4d885e138f189e235ad6094d436e] Merge branch 'jc/am-parseo=
pt-fix'
git bisect ok 914a353a128d4d885e138f189e235ad6094d436e
# ok: [e48d9c78cc00805660b83ac809188d0c413e4c46] Merge branch 'am/doc-sha25=
6'
git bisect ok e48d9c78cc00805660b83ac809188d0c413e4c46
# oops: [cecd6a5ffce2c35f18e8ac537c9e2f71ac99932b] Merge branch 'jc/send-em=
ail-pre-process-fix'
git bisect oops cecd6a5ffce2c35f18e8ac537c9e2f71ac99932b
# oops: [8cdd5e713d7ba54b9d26ac997408bb745ab55088] Merge branch 'ma/locate-=
in-path-for-windows'
git bisect oops 8cdd5e713d7ba54b9d26ac997408bb745ab55088
# ok: [a82fb66fed250e16d3010c75404503bea3f0ab61] A few more topics before -=
rc1
git bisect ok a82fb66fed250e16d3010c75404503bea3f0ab61
# oops: [cf07e53bae8492fc6ee8a8d394e2fba858daa0a4] Merge branch 'bc/ident-d=
ot-is-no-longer-crud-letter'
git bisect oops cf07e53bae8492fc6ee8a8d394e2fba858daa0a4
# oops: [bda9c12073e786e2ffa2c3ec479c7fe098d49999] avoid SHA-1 functions de=
precated in OpenSSL 3+
git bisect oops bda9c12073e786e2ffa2c3ec479c7fe098d49999
# ok: [3e440ea0aba0660f356a3e5b9fc366d5d6960847] sha256: avoid functions de=
precated in OpenSSL 3+
git bisect ok 3e440ea0aba0660f356a3e5b9fc366d5d6960847
# first oops commit: [bda9c12073e786e2ffa2c3ec479c7fe098d49999] avoid SHA-1=
 functions deprecated in OpenSSL 3+
```

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--yc4bsmYi7xTmWFYY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZPCL0QAKCRB7tWyQc2rT
CD7uAQDsjlMv7LySpGNeHBWxa1r6pPxT41bxAUVo1J3BULH9jQD/SQuHf+nz33YV
Eb9sMgxk5L9Hz1ZLzG9msEN3ULxAxQs=
=hanX
-----END PGP SIGNATURE-----

--yc4bsmYi7xTmWFYY--
