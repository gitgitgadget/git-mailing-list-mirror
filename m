Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE0C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 22:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5585207D3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 22:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN/r3mqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbgKJW2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 17:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgKJW2o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 17:28:44 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C916C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 14:28:42 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id q7so2925501qvt.12
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 14:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=5gxwIfC3wV47/ilCjycoklvKqsoLogdlTZ1PfORQ+BI=;
        b=QN/r3mqCxYNYIFdCPumsOAr8GYOmjkm7LgIM+EZdVojHvMEGhjUjiK81fGvqXllLfC
         uALxMm9mXmjzUemIKftn7Qk7FwIpcXOmriT3yw+Y3mbE6abCpz9UEO4KO3hPL8+Um7Hg
         0UGDb0ofdcEC4JoaMDLaQxqmO8Pmxuxk/Mw7SW91R+EMq87lanLzcKcUX0/RXMdvpwIT
         6iTuY7xeDOsW7i4JWNPf6QoHmDGHSniI0sPJilf/QoQ13Xfe/UGF3N/QW3ClVKX8Z9yg
         NxMaj3HlP34vmTZDh1GhU1hVuwxK+98yxaEcjNMSfD/EtP/k3sM7so+5BMQOw//k1kln
         g1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=5gxwIfC3wV47/ilCjycoklvKqsoLogdlTZ1PfORQ+BI=;
        b=JTp8yEPCRkdJoh1DOOVhPdPVcgCit96dvyA2P8nahakmet9Bu+VWEjNn+h9JmYQwfL
         E7SHLoxSxltWuPW7pQ2+MOCEo+MDqspOoDCFQfz3sf7AeufS/ZY3341LqHGpZnVeXIT5
         kYkk58fux8KdB+ZJaOvB90EH7EAuphVwOx/bA+O+ePHkor0EQacipS3xlYvnI4Zjl86W
         4Lado3D+C3YsFT9Z+6wZWHji21y6yAGcEWFAI0WGTVWTZJW0qEnM2phA6pwVHuLs71b6
         gZTHL4ceGSvv7Hf8q5SAfmZT93+//elruvn7ItsWwf+2wa2dS564A4sbiWURLwDPdjSs
         6D1g==
X-Gm-Message-State: AOAM530mt3ceXuKlJDiFpvPCCh4GxDKaSRosiIYSy4BElW8FZBFNE7k4
        B9NN22LhIKcc1Bwi9UUzDxd+U2hcDwRGVXB+
X-Google-Smtp-Source: ABdhPJzu61imKrlU1S9GIFasfjHLt3KMPmKFdKTLyUOxOZv32DGaHIdECXa8ha4xqAQsdFFDX53rUQ==
X-Received: by 2002:a0c:9ad9:: with SMTP id k25mr22050713qvf.57.1605047321391;
        Tue, 10 Nov 2020 14:28:41 -0800 (PST)
Received: from [0.0.0.0] ([66.115.173.166])
        by smtp.gmail.com with ESMTPSA id n187sm183119qkc.133.2020.11.10.14.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 14:28:40 -0800 (PST)
Subject: Re: [PATCH 3/3] rev-parse: handle --end-of-options
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>
References: <20201110213544.GA3263091@coredump.intra.peff.net>
 <20201110214019.GC788740@coredump.intra.peff.net>
 <xmqqr1p06ec9.fsf@gitster.c.googlers.com>
From:   "Demi M. Obenour" <demiobenour@gmail.com>
Message-ID: <f6736e4b-679b-437a-8768-2352efbb4274@gmail.com>
Date:   Tue, 10 Nov 2020 17:28:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1p06ec9.fsf@gitster.c.googlers.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ChZFerQx26BZhsmW45eYevgb9b3RJOMm0"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ChZFerQx26BZhsmW45eYevgb9b3RJOMm0
Content-Type: multipart/mixed; boundary="IXSkvA0IBkxhFGNuZ9OgukjoEro8aFquI";
 protected-headers="v1"
From: "Demi M. Obenour" <demiobenour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: Git <git@vger.kernel.org>
Message-ID: <f6736e4b-679b-437a-8768-2352efbb4274@gmail.com>
Subject: Re: [PATCH 3/3] rev-parse: handle --end-of-options
References: <20201110213544.GA3263091@coredump.intra.peff.net>
 <20201110214019.GC788740@coredump.intra.peff.net>
 <xmqqr1p06ec9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1p06ec9.fsf@gitster.c.googlers.com>

--IXSkvA0IBkxhFGNuZ9OgukjoEro8aFquI
Content-Type: multipart/mixed;
 boundary="------------1434441CC270EB4D952B1F2B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1434441CC270EB4D952B1F2B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/10/20 5:23 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
>> This patch lets callers write:
>>
>>   git rev-parse --end-of-options "$rev" -- "$path"
>>
>> and:
>>
>>   git rev-parse --verify --end-of-options "$rev"
>>
>> which will both treat "$rev" always as a revision parameter.
>=20
> Nice.  The only iffy case I can think of is that we can never have
> "--" to specify a rev, because with "git cmd -- -- path" we don't
> know which double-dash among the two is the disambiguator that makes
> the other double-dash to be either rev or path, but that is not a
> new problem with this change.

I think Git should at least reject refs named "--", since they cause
problems in so many places.

Sincerely,

Demi

--------------1434441CC270EB4D952B1F2B
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0xB288B55FFF9C22C1.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49yB+l2nipda=
q+4
Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYfbWpr/si88QKgyGSVZ7GeN=
W1U
nzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/UorR+FaSuVwT7rqzGrTlscnTDlPWgRzrQ=
3js
sesI7sZLm82E3pJSgaUoCdCOlL7MMPCJwI8JpPlBedRpe9tfVyfu3euTPLPxwcV3L/cfWPGSL=
4Po
fBtB8NUU6QwYiQ9Hzx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR6h3nBc3eyuZ+q62HS=
1pJ
5EvUT1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl5FMWo8TCniHynNXsBtDQb=
abt
7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2Bkg1b//r6bTBswMBXVJ5H44Qf=
0+e
KeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C9a1P1MYVysLvkLvS4H+crmxA/i08T=
c1h
+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nSm9BBff0Nm0bSNRS8InXdO1Aq3362QKX2NOwcL5YaS=
twO
DNyZUqF7izjK4QARAQABzTxEZW1pIE1hcmllIE9iZW5vdXIgKGxvdmVyIG9mIGNvZGluZykgP=
GRl
bWlvYmVub3VyQGdtYWlsLmNvbT7CwXgEEwECACIFAlp+A0oCGwMGCwkIBwMCBhUIAgkKCwQWA=
gMB
Ah4BAheAAAoJELKItV//nCLBhr8QAK/xrb4wyi71xII2hkFBpT59ObLN+32FQT7R3lbZRjVFj=
c6y
MUjOb1H/hJVxx+yo5gsSj5LS9AwggioUSrcUKldfA/PKKai2mzTlUDxTcF3vKx6iMXKA6AqwA=
w4B
57ZEJoMM6egm57TV19kzPMc879NV2nc6+elaKl+/kbVeD3qvBuEwsTe2Do3HAAdrfUG/j9erw=
Ik6
gha/Hp9yZlCnPTX+VK+xifQqt8RtMqS5R/S8z0msJMI/ajNU03kFjOpqrYziv6OZLJ5cuKb3b=
ZU5
aoaRQRDzkFIR6aqtFLTohTo20QywXwRa39uFaOT/0YMpNyel0kdOszFOykTEGI2u+kja35g9T=
kH9
0kkBTG+aEWttIht0Hy6YFmwjcAxisSakBuHnHuMSOiyRQLu43ej2+mDWgItLZ48Mu0C3IG1se=
eQD
jEYPtqvyZ6bGkf2Vj+L6wLoLLIhRZxQOedqArIk/Sb2SzQYuxN44IDRt+3ZcDqsPppoKcxSyd=
1Ny
2tpvjYJXlfKmOYLhTWs8nwlAlSHX/c/jz/ywwf7eSvGknToo1Y0VpRtoxMaKW1nvH0OeCSVJi=
tfR
P7YbiRVc2aNqWPCSgtqHAuVraBRbAFLKh9d2rKFB3BmynTUpc1BQLJP8+D5oNyb8Ts4xXd3iV=
/uD
8JLGJfYZIR7oGWFLP4uZ3tkneDfYzTxEZW1pIE9iZW5vdXIgKElUTCBFbWFpbCBLZXkpIDxhd=
Ghl
bmFAaW52aXNpYmxldGhpbmdzbGFiLmNvbT7CwY4EEwEIADgWIQR2h02fEza6IlkHHHGyiLVf/=
5wi
wQUCX6YJvQIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCyiLVf/5wiwWRhD/0YR+YYC=
5Kd
uv/2LBgQJIygMsFiRHbR4+tWXuTFqgrxxFSlMktZ6gQrQCWe38WnOXkBoY6n/5lSJdfnuGd2U=
agZ
/9dkaGMUkqt+5WshLFly4BnP7pSsWReKgMP7etRTwn3Szk1OwFx2lzY1EnnconPLfPBc6rWG2=
moA
6l0WX+3WNR1B1ndqpl2hPSjT2jUCBWDVrGOUSX7r5f1WgtBeNYnEXPBCUUM51pFGESmfHIXQr=
qFD
A7nBNiIVFDJTmQzuEqIyJl67pKNgooij5mKzRhFKHfjLRAH4mmWZlB9UjDStAfFBAoDFHwd1H=
L5V
QCNQdqEc/9lZDApqWuCPadZN+pGouqLysesIYsNxUhJ7dtWOWHl0vs7/3qkWmWun/2uOJMQhr=
a2u
8nA9g91FbOobWqjrDd6x3ZJoGQf4zLqjmn/P514gb697788e573WN/MpQ5XIFl7aM2d6/GJiq=
6LC
9T2gSUW4rbPBiqOCeiUx7Kd/sVm41p9TOA7fEG4bYddCfDsNxaQJH6VRK3NOuBUGeL+iQEVF5=
Xs6
Yp+U+jwvv2M5Lel3EqAYo5xXTx4ls0xaxDCufudcAh8CMMqx3fguSb7Mi31WlnZpk0fDuWQVN=
KyD
P7lYpwc4nCCGNKCj622ZSocHAcQmX28L8pJdLYacv9pU3jPy4fHcQYvmTavTqowGnM7BTQRaf=
gNK
ARAAvcp2SPS1PriZDHhCXickP/FRZAiUD0GRLCBszk5T58L1Z2tAEvOp9mfqyu0f7rGLOYiQm=
eef
ySElnfMQ+e7ntHgeO23Cb1ahpTmyNgxBvE8GltDtHbkYQ4MzBC+LdSnUQHqSBEgRAP4j6SOIH=
1G1
RCBELqnakMjuBgHvjJA9B8uSR/9KoBZm2knoDU3UIOYqmI0Wd7bYrMGpapdf4ksr9VmHgtTgL=
Ptg
SzgE9jRIIEolTrcRH4HsLELQlovB9UqIq2pCH6OOR89LZPwHfWVodj7zhrfeymvOaOEyycYCS=
ahh
J6nBVGZySa4sKGkSEvDdgvP5xDOd429bB9IGHXTFN0MWO3WDSyFK0SkHjZBd9HSu1eiUR+6ZX=
kZX
/sEHDX0QCFKzZWrY/U8cIr0KypwvWiBRRxMv9JgILa0EoXDEZjIFZUaDgOQfEU7pUSwppGn78=
Lob
OnQsTdBjQDkSFVRcY8fVZ+zqmD4MIqH2ekmxJdIYD8lgULxPOZJRS2S6I+6fo6A2NVzUM7Znw=
K5y
fcfmFeIoI1iJiDQGUpZhHGLXfscty4v/KHmAwKq7J6zo2/lrxoQspCZOLqwaINizbXMgo5E7O=
xfl
nlxlKNDQ4W3d2egMhX6nhe7idw+YZaV9pyPZ6P7oD6601aFWQIK65zc9ImRtg1ceOsfdd6VSh=
5eZ
pWEAEQEAAcLBXwQYAQIACQUCWn4DSgIbDAAKCRCyiLVf/5wiwcDSD/wIiBxPG6CKkXhUMmjM8=
aup
ROGGQmTY+uQf55Azr6HUosH8I41VRNld4hM8TB24MkwhgOu/gaP3eWkBo4J9Ez7bBs3pckB4q=
WlM
xMq7HHlBlmKCl2MlVihH8odHA353fXYgJt1XjanIbXDKaHoREx/H60R5yXQXI39ddj80EnSgu=
pKl
NENfenOFaeRwzkHzYg503+4GUo9Aa2hzgcsvSxAwi4UIgpq/thNK1uLQbQwJ9h5E/bn99mRqi=
Qp9
TvtrlXxYRrurzxOapKq20hPExvtNx/HnFNqudM4B1j3RzDgb8txIc3wIdlZjkk3ESvrUlHv7t=
8HS
0Qz8L/w08xiN+ioJMvTLAwuYKSMDWziT9hv6tcE9aBpMOCF31r9rn1ol6ifpOxxItjdbK3nuw=
8vS
gQqm/nGtbxYWDwyX4T++SP1Z8x1bLGf62Gffudcg6FAAaDXSTUhlGJfmIfT8PaRNyreBBc1JR=
WVm
xOMSi/zT56Ps+CfWlnpiy7M3GM/7t152zr1EkB0q5nzs193FeMn5ozOZXsIErLaMRsk8djPHp=
7JY
HV4T7YWZQ505zk/gvjk7IfPpubaLPB0I2jzNNTCgYgKnT4JLJtcLtg668FIugoUVU1AXI+vv/=
SCf
NR9j9oCZNy7NwFSMSH3y6GN+BPjGEn5BIwc9BPAiznAMOySMAGngUw=3D=3D
=3DjHHo
-----END PGP PUBLIC KEY BLOCK-----

--------------1434441CC270EB4D952B1F2B--

--IXSkvA0IBkxhFGNuZ9OgukjoEro8aFquI--

--ChZFerQx26BZhsmW45eYevgb9b3RJOMm0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAl+rFA0ACgkQsoi1X/+c
IsGX5RAAm07v/FLWTZaP4kCUYNfaw7j0+n4OKOCtdQFFayFZrJs/jnzDWXkjh4ik
rg+mLkuUWdUVEi6kdlKanNu4A2ceLwh2M/0+qI1jcq1uAbW91HtUvF8O9Y+Z+w4G
SnL6997cfQFQzbXjc+nDvYcaammlaQoOPz9KuiKxFSt2PW/gbLkoGqruwoif5yjS
58ZiJGXD6TCC5KXPIYu9QZQQYjqhqgbcfQf0CYvDDEJ6fwLbMGTpCug/Ma+jHeZ7
CzTyfWdpWKB1Qv72AMs7GVXO46yWHA7x3+OxVKocLiGMEIO/Cwg2n2eVLU27j/1g
XKgLJmeob6MOxzdhAglAhtMYTeSOeftUOJWbXEsYcW1neSEvTC9sw8p6BhBq5P1s
uhS2RJRb4mWUWLuiVpwTy5v6qw6GZ0MVBvJGjSRMcTAFGU9xrL9cB6apmui46mRb
Ab1FjsTqvhBjnqj9AcmhpYy508r/7kkTx7XcwbiCS9ffZmQfbC1Fz8NNZluSf62/
ySLAkxglfMtUSCMLuiikCVvlFZMKfxP2fgO3YrW2B0h+MWusEV8JYR75M/TcPa5D
9X9d9oOYmBxAtq/AQZWadgvfjKcJz2lyuBc0LYgVdar+w5HQ9gzOikYC0Xagf/id
6/7T/IRiRwyRfS2vuwpS2D4Y51G7YCMmitxDtjAI1Z5sq9YYRrw=
=f7Ev
-----END PGP SIGNATURE-----

--ChZFerQx26BZhsmW45eYevgb9b3RJOMm0--
