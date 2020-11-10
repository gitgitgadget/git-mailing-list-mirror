Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFCDC56201
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 19:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93D720665
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 19:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbgKJTcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 14:32:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55001 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731597AbgKJTcL (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Nov 2020 14:32:11 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 067195C02B9
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 14:32:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 10 Nov 2020 14:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=MjgsnhpIv9eg4UkycJXxPISYCzakR
        52oFF0FnpsZYcU=; b=daqsMzqbxkN6IR7lGl0Mtmu/k+J0TR8vLTldNersnJi23
        Z5LpTm0lbyfzr7cLcFAyjI7jbeAe+lXwdsuDJVs18c0Jwm7FuxJSoE4CjUDDjF3P
        /GcyUPnzWTbis32h+nvcc45FTPtMTktJbQyecnU2S44GLBDASsKorBaRSV7Wyicb
        yY62lYeD2NcZJYQYfUc21aZfcS6Es/CG+O1ZFK77+U9C60qANU/Jn2IQpBFDm/uC
        +nzeqiIue9f85C1aMXcwFC65jdz72AxQF6y7wYVPhrkWEJahB8xtwK4n2dFpyQgS
        Cw7kcOUprkJZUI/+Y+wqD5QsWpXRB/HCrT0ry0DtQ==
X-ME-Sender: <xms:uOqqXxbDnjcFOnRaeLCStNOwfNgViLE8p5o2H_R1Jjo_5KSRJ6SOLw>
    <xme:uOqqX4bwHIYnBiOPSwCJCs_8q3Y0hXHvWUAhakPxsysdpJfD4vmLOyYQ5BA1yZf9Y
    Tg7HGbh5I8A_BU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddujedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepvffhuffkffgfgggtsehgtderof
    dtfeejnecuhfhrohhmpedfffgvmhhiucfordcuqfgsvghnohhurhdfuceorghthhgvnhgr
    sehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnh
    epkeejvdduheffkeduudeuveeiheffgeeltddugeefudegueetuddvkeevffdtgfdunecu
    kfhppeeiiedrudduhedrudejfedrudeiieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrthhhvghnrgesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:uOqqXz8lUwGB0uwpY_b5S7p9dlE274KhyYVhpTkixZJDD8YkpKKDoA>
    <xmx:uOqqX_rh1IDfBeSeV-IhrCQXq8NXp6WcErn6-5JebCkC_SZ4lXmu5g>
    <xmx:uOqqX8qXZnhNfMhDqEq3rsdmJJ7ygEnxap1SdybIWlOQe8OjxNwyQw>
    <xmx:ueqqX15yI6Y3qeY66pAS2pjW_iPJCAusfklSw7Q9wfeiYJgf0hHT3Q>
Received: from [0.0.0.0] (unknown [66.115.173.166])
        by mail.messagingengine.com (Postfix) with ESMTPA id AFB21306307F
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 14:32:08 -0500 (EST)
To:     Git <git@vger.kernel.org>
From:   "Demi M. Obenour" <athena@invisiblethingslab.com>
Subject: check_refname_format allows refs with components that begin with -,
 even though `git tag` does not
Message-ID: <c926193b-a328-7562-6d4b-1ab2765c8cca@invisiblethingslab.com>
Date:   Tue, 10 Nov 2020 14:32:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rwYrjGYnJpu84f8wmPWW73X4LAzIMcGYC"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rwYrjGYnJpu84f8wmPWW73X4LAzIMcGYC
Content-Type: multipart/mixed; boundary="lkwwXRnG3fVH946rS4vUVyA8SSsAhpJOK";
 protected-headers="v1"
From: "Demi M. Obenour" <athena@invisiblethingslab.com>
To: Git <git@vger.kernel.org>
Message-ID: <c926193b-a328-7562-6d4b-1ab2765c8cca@invisiblethingslab.com>
Subject: check_refname_format allows refs with components that begin with -,
 even though `git tag` does not

--lkwwXRnG3fVH946rS4vUVyA8SSsAhpJOK
Content-Type: multipart/mixed;
 boundary="------------22BC6454D8C5503319DE83DF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------22BC6454D8C5503319DE83DF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

If I try to create a Git tag with a name beginning with `-`,
Git complains.  However, Git does not check that a repository does
not have tags containing `-`.  This almost led to a vulnerability
in the QubesOS `verify-git-tag` script.  Fortunately, this was not
exploitable, as neither `git tag -v`, `git verify-tag --raw`, nor
`git describe` have options that are useful to an attacker.

Since this could cause vulnerabilities in other programs, I initially
reported it as an embargoed security bug, but was told to post it
publicly.

The best idea I had for a fix is to print names beginning with `-`
using the fully-qualified form, such as "refs/tags/-a".  Also, `--`
is used as a delimiter in many commands, and can=E2=80=99t be escaped,
so disallowing it might be a good idea.

In the long run, I hope to see leading dashes banned entirely, but
backwards compatibility might prevent that.

Sincerely,

Demi

--------------22BC6454D8C5503319DE83DF
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

--------------22BC6454D8C5503319DE83DF--

--lkwwXRnG3fVH946rS4vUVyA8SSsAhpJOK--

--rwYrjGYnJpu84f8wmPWW73X4LAzIMcGYC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAl+q6rcACgkQsoi1X/+c
IsEyoxAAgKNcYi61LSN5aLl18eSvYDpJIEhZk9wArDj83KNrD+T96o9Aw9qcP7hF
biL8akDW9AP5Vt9BHl5pns+wzBChfGZoXYPAc1hM8dReKbBSAcyvY2o0WASIyWBq
qCQxvPyKmOdJNaaFh+mW7xRebdB80A0+oJ9yKc+Pnbl8WiIwaPgRpnuochi5/THX
cZ1Kjt3URPkn1zaS2Z1M4vrEUz4d5qBRjbL2VEUlFXW6pFRLHG+bexozwdhNwe0l
U2d9vd9aXDgLkdG4MAak4cfu19+tQUTdRON/HP0Z5NqyldVKkx6G0K89kspCtt3J
wbz3klHzhCDgHPnvKA1YADIclDHznrhK7IqeSH6/HpMZMp0RlaT/uIDHQzbZsVab
K9w+Hx2ig8VWki99Ii4P0Q3iVQcuHvSKZlvYl04bRrM396UaZgpeWHpAA8ff5/TG
5CYCjdfhBkNBvE/iOrQ2PMb3BwjukA4r30pTAcq9mNBGuUQzkSvxAA8NTT97w7Oa
gfQNIWnDw6/YcuAa/6RZTPXKt4QIwFjwwtjJ2KM33i4Lak4umYbWQiE0gJ8c5sVh
f79JgDrFo9HJoh6D2MWQcX9GWqOIfadBNWVQcLFjTS08qFgCb1s1KI8KG1BaHp/B
Et94Ym2nwJrUnU7JWa0TGdxfXTEjUoBgut3R4U5hOxmXy0maLUA=
=pmAT
-----END PGP SIGNATURE-----

--rwYrjGYnJpu84f8wmPWW73X4LAzIMcGYC--
