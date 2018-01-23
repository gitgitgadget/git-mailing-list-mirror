Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D3D1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 22:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932187AbeAWWGV (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 17:06:21 -0500
Received: from lucaswerkmeister.de ([94.130.58.99]:60152 "EHLO
        lucaswerkmeister.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932071AbeAWWGU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 17:06:20 -0500
Received: from theoden.lucaswerkmeister.de (unknown [IPv6:2a02:8109:9a3f:f575:be5f:f4ff:fecb:74cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mail@lucaswerkmeister.de)
        by lucaswerkmeister.de (Postfix) with ESMTPSA id 8853F193F1A;
        Tue, 23 Jan 2018 23:06:18 +0100 (CET)
Authentication-Results: lucaswerkmeister.de; dmarc=fail (p=none dis=none) header.from=lucaswerkmeister.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucaswerkmeister.de;
        s=mail; t=1516745179;
        bh=06w5KmGrsK/3YnxqT1r72wdK64v+O0jPwovjVbDWJMo=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:From:Reply-To:Subject:Date:To:Cc:
         In-Reply-To:References:Message-Id:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version;
        b=XpRTcRNXkivZiQ/74xMvhBL4FQpFmcM68NPcvxOYU+e+T97edGy2U2xob823ifuH6
         CKK8yf1giaiFAPZxqf2AzF/dSjE+9YsbTSXMBS1vLj8ArAo9RAsT1cshZmh0qgxHMd
         mkJLKU0+Gbys3hUWNLzGSvE99m0xc2wFDG6RYd+8=
Subject: Re: [PATCH] daemon: add --no-syslog to undo implicit --syslog
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <20180122232304.4863-1-mail@lucaswerkmeister.de>
 <87shaxh2b9.fsf@evledraar.gmail.com>
 <xmqqh8rcig0x.fsf@gitster.mtv.corp.google.com>
From:   Lucas Werkmeister <mail@lucaswerkmeister.de>
Message-ID: <18ef807d-a642-17b2-fc32-af0c3b963a71@lucaswerkmeister.de>
Date:   Tue, 23 Jan 2018 23:06:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqh8rcig0x.fsf@gitster.mtv.corp.google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020501020808010602050101"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms020501020808010602050101
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Thanks for your responses!

On 23.01.2018 01:00, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> This patch looks good, but I wonder if with the rise of systemd
> there's a good reason to flip the default around to not having other
> stuff imply --syslog, and have users specify this implictly, then we
> won't need a --no-syslog option.
>=20
> But maybe that'll break too much stuff.
>=20

That seems risky to me =E2=80=93 even with systemd, the StandardError dir=
ective
by default inherits StandardOutput, so if you set StandardOutput=3Dsocket=

without StandardError=3Djournal, log output in stderr clobbers regular
output. (Also, stderr is apparently closed with --detach, see below.)

On 23.01.2018 19:30, Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
>> On Mon, Jan 22 2018, Lucas Werkmeister jotted:
>>=20
>>> Several options imply --syslog, without there being a way to
>>> disable it again. This commit adds that option.
>>=20
>> Just two options imply --syslog, --detach & --inetd, unless I've
>> missed something, anyway 2 !=3D several, so maybe just say "The
>> --detach and --inetd options imply --syslog ...".
>=20
> Correct.

I respectfully disagree on =E2=80=9C2 !=3D several=E2=80=9D, but sure, I =
can repeat the
two options in the message instead :)

> Moreover, --detach completely dissociates the process from the
> original set of standard file descriptors by first closing them and
> then connecting it to "/dev/null", so it will be nonsense to use this
> new option with it.
>=20

Ah, I wasn=E2=80=99t aware of that =E2=80=93 so with --detach, --no-syslo=
g would be
better described as =E2=80=9Cdisables all logging=E2=80=9D rather than =E2=
=80=9Clog to stderr
instead=E2=80=9D. IMHO it would still make sense to have the --no-syslog =
option
(then mainly for use with --inetd) as long as its interaction with
--inetd is properly documented=E2=80=A6 do you agree? If yes, I=E2=80=99l=
l be glad to
submit another version of the patch.

Best regards,
Lucas


--------------ms020501020808010602050101
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DMgwggVnMIIDT6ADAgECAgMCmv4wDQYJKoZIhvcNAQENBQAwVDEUMBIGA1UEChMLQ0FjZXJ0
IEluYy4xHjAcBgNVBAsTFWh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZzEcMBoGA1UEAxMTQ0FjZXJ0
IENsYXNzIDMgUm9vdDAeFw0xNjA5MTExNDE5MDVaFw0xODA5MTExNDE5MDVaMEUxGjAYBgNV
BAMTEUx1Y2FzIFdlcmttZWlzdGVyMScwJQYJKoZIhvcNAQkBFhhtYWlsQGx1Y2Fzd2Vya21l
aXN0ZXIuZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDc0Z+cNtJrrj27JiZL
om5JsgGypjrFuBpvRJYjXVzx4gXYZcqAvTuHcQMZcBXItvZEE6DNbsKoFFl/DEpRxbnD3/uI
SEcrpQVqYu3iXcbvk7yA5IBG2HorgWVEA9DQROJD1qwxmS0sN76PtK5cWFPfUZ2A/UM+gVEU
WkWY+DSdO0nmWAyuvP3ArDHgAuZxf/J9HYzv8pRx6fpsqCLoauP6gHTA6hHApcjpUTRNX+Df
GGyDVhOaCp0lVDgtTxa1licpXwnDwFJVgX3F2rdxzISLwf3qi1775XiyFtqTX0jPB/YHHQD+
N+1lPNIPrXsBcUNXUxkwKMXNn5kUS5owIbg1AgMBAAGjggFPMIIBSzAMBgNVHRMBAf8EAjAA
MFYGCWCGSAGG+EIBDQRJFkdUbyBnZXQgeW91ciBvd24gY2VydGlmaWNhdGUgZm9yIEZSRUUg
aGVhZCBvdmVyIHRvIGh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZzAOBgNVHQ8BAf8EBAMCA6gwQAYD
VR0lBDkwNwYIKwYBBQUHAwQGCCsGAQUFBwMCBgorBgEEAYI3CgMEBgorBgEEAYI3CgMDBglg
hkgBhvhCBAEwMgYIKwYBBQUHAQEEJjAkMCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5jYWNl
cnQub3JnMDgGA1UdHwQxMC8wLaAroCmGJ2h0dHA6Ly9jcmwuY2FjZXJ0Lm9yZy9jbGFzczMt
cmV2b2tlLmNybDAjBgNVHREEHDAagRhtYWlsQGx1Y2Fzd2Vya21laXN0ZXIuZGUwDQYJKoZI
hvcNAQENBQADggIBAD0u0rjuzABHKM1fpWqrgq+h+vhCZFA/bzVuNvfHt45pN9vLJE4UzZf2
c9n9eui4yv8eCgevq+NMmckF8jqFpz3y8jPtNTzPvEA4jQwByAUoR8BkLLwpnRZhq/tgu1ZV
6csJVSwqBe7HsgTtdwg3+n0neOap/xuJV6FkDsM3ODdnP1otn2F8LXCFhHMo4KdnpqnKTc2C
Zhrm6NXkGeJ6G3EbGihnb+RLNs9NrF4h6X5R5jiXgEPE/Ln8CdQoz0PfXantJwoedwAUyJa1
EThxc9i6RCx4FdUaic6mbgsGWGZS6/URg3B68AEmjg+EUxjtRk8TGPlK6r2Uly8zjpLkioq0
e2t4c14Eu/+CYfCVA6wY6sqcfFjdAzg/qKcM7le8fU6rkQNwGHIAA/APi3yTDXc1vUEmSogG
qTnJkm/IFxRBJZPnpsXlhwXsJZdMxdY1TYarVeu+a93k5Gbgg9zfH0RYDW1cxY7iWEgMBOql
b/U73cT6T40PmfwDfu7O36qB3yZhMjDPOr061bToqoepV1BUVyKUmLWc2nCQtv5kHeow7Rgt
ZMbXIROSsTHiXgobAAy+K9U93GEG+hDN1JEBLQhpYFS7P40R99tvZtm3tym2t7qBeHCZcuMl
br9Fi/IymEyyKZaqOQjLRfUZqGMYLCnLu3ZXRB9I7u4FOtLEEE8+MIIHWTCCBUGgAwIBAgID
CkGKMA0GCSqGSIb3DQEBCwUAMHkxEDAOBgNVBAoTB1Jvb3QgQ0ExHjAcBgNVBAsTFWh0dHA6
Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhvcml0eTEh
MB8GCSqGSIb3DQEJARYSc3VwcG9ydEBjYWNlcnQub3JnMB4XDTExMDUyMzE3NDgwMloXDTIx
MDUyMDE3NDgwMlowVDEUMBIGA1UEChMLQ0FjZXJ0IEluYy4xHjAcBgNVBAsTFWh0dHA6Ly93
d3cuQ0FjZXJ0Lm9yZzEcMBoGA1UEAxMTQ0FjZXJ0IENsYXNzIDMgUm9vdDCCAiIwDQYJKoZI
hvcNAQEBBQADggIPADCCAgoCggIBAKtJNRFIfNImflOUz0Op3SjXQiqL84d4GVh8D57aiX3h
++tykA10oZZkq5+gJJlz2uJVdscXe/UErEa4w75/ZI0QbCTzYZzA8pD6Ueb1aQFjww9W4kpC
z+JEjCUoqMV5CX1GuYrz6fM0KQhF5Byfy5QEHIGoFLOYZcRD7E6CjQnRvapbjZLQ7N6QxX8K
wuPr5jFaXnQ+lzNZ6MMDPWAzv/fRb0fEze5ig1JuLgiapNkVGJGmhZJHsK5I6223IeyFGmhy
Nav/8BBdwPSUp2rVO5J+TJAFfpPBLIukjmJ0FXFuC3ED6q8VOJrU0gVyb4z5K+taciX5OUbj
chs+BMNkJyIQKopPWKcDrb60LhPtXapI19V91Cp7XPpGBFDkzA5CW4zt2/LP/JaT4NsRNlRi
NDiPDGCbO5dWOK3z0luLoFvqTpa4fNfVoIZwQNORKbeiPK31jLvPGpKK5DR7wNhsX+kKwsOn
IJpa3yxdUly6R9Wb7yQocDggL9V/KcCyQQNokszgnMyXS0XvOhAKq3A6mJVwrTWx6oUrpByA
ITGprmB6gCZIALgBwJNjVSKRPFbnr9s6JfOPMVTqJouBWfmh0VMRxXudA/Z0EeBtsSw/LIaR
mXGapneLNGDRFLQsrJ2vjBDTn8Rq+G8T/HNZ92ZCdB6K4/jc0m+YnMtHmJVABfvpAgMBAAGj
ggINMIICCTAdBgNVHQ4EFgQUdahxYEyIE/B42Yl3tW3Fid+8sXowgaMGA1UdIwSBmzCBmIAU
FrUyG9TH8+DmjvO90rA67rI5GNGhfaR7MHkxEDAOBgNVBAoTB1Jvb3QgQ0ExHjAcBgNVBAsT
FWh0dHA6Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhv
cml0eTEhMB8GCSqGSIb3DQEJARYSc3VwcG9ydEBjYWNlcnQub3JnggEAMA8GA1UdEwEB/wQF
MAMBAf8wXQYIKwYBBQUHAQEEUTBPMCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5DQWNlcnQu
b3JnLzAoBggrBgEFBQcwAoYcaHR0cDovL3d3dy5DQWNlcnQub3JnL2NhLmNydDBKBgNVHSAE
QzBBMD8GCCsGAQQBgZBKMDMwMQYIKwYBBQUHAgEWJWh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZy9p
bmRleC5waHA/aWQ9MTAwNAYJYIZIAYb4QgEIBCcWJWh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZy9p
bmRleC5waHA/aWQ9MTAwUAYJYIZIAYb4QgENBEMWQVRvIGdldCB5b3VyIG93biBjZXJ0aWZp
Y2F0ZSBmb3IgRlJFRSwgZ28gdG8gaHR0cDovL3d3dy5DQWNlcnQub3JnMA0GCSqGSIb3DQEB
CwUAA4ICAQApKIWuRKm5r6R5E/CooyuXYPNc7uMvwfbiZqARrjY3OnYVBFPqQvX56sAV2KaC
2eRhrnILKVyQQ+hBsuF32wITRHhHVa9Y/MyY9kW50SD42CEH/m2qc9SzxgfpCYXMO/K2viwc
JdVxjDm1Luq+GIG6sJO4D+Pm1yaMMVpyA4RS5qb1MyJFCsgLDYq4Nm+QCaGrvdfVTi5xotSu
+qdUK+s1jVq3VIgv7nSf7UgWyg1I0JTTrKSi9iTfkuO960NAkW4cGI5WtIIS86mTn9S8nK2c
de5alxuV53QtHA+wLJef+6kzOXrnAzqSjiL2jA3k2X4Ndhj3AfnvlpaiVXPAPHG0HRpWQ7fD
Co1y/OIQCQtBzoyUoPkD/XFzS4pXM+WOdH4VAQDmzEoc53+VGS3FpQyLu7XthbNc09+4ufLK
xw0BFKxwWMWMjTPUnWajGlCVI/xI4AZDEtnNp4Y5LzZyo4AQ5OHz0ctbGsDkgJp8E3MGT9uj
ayQKurMcvEp4u+XjdTilSKeiHq921F73OIZWWonO1sOnebJSoMbxhbQljPI/lrMQ2Y1sVzuf
b4Y6GIIiNsiwkTjbKqGTqoQ/9SdlrnPVyNXTd+pLncdBu8fA46A/5H2kjXPmEkvfoXNzczqA
6NXLji/L6hOn1kGLrPo8idck9U604GGSt/M3mMS+lqO3ijGCAzswggM3AgEBMFswVDEUMBIG
A1UEChMLQ0FjZXJ0IEluYy4xHjAcBgNVBAsTFWh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZzEcMBoG
A1UEAxMTQ0FjZXJ0IENsYXNzIDMgUm9vdAIDApr+MA0GCWCGSAFlAwQCAQUAoIIBsTAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODAxMjMyMjA2MThaMC8G
CSqGSIb3DQEJBDEiBCDHE0FmpmSyiWn5kgQX2QJ1u7/BpTAEJc/rS5/NXdipCDBqBgkrBgEE
AYI3EAQxXTBbMFQxFDASBgNVBAoTC0NBY2VydCBJbmMuMR4wHAYDVQQLExVodHRwOi8vd3d3
LkNBY2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFzcyAzIFJvb3QCAwKa/jBsBgkqhkiG
9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMGwGCyqG
SIb3DQEJEAILMV2gWzBUMRQwEgYDVQQKEwtDQWNlcnQgSW5jLjEeMBwGA1UECxMVaHR0cDov
L3d3dy5DQWNlcnQub3JnMRwwGgYDVQQDExNDQWNlcnQgQ2xhc3MgMyBSb290AgMCmv4wDQYJ
KoZIhvcNAQEBBQAEggEAsauMg1qijNqVC+gMcNVH9zqbC5JFgRRPx4KMdrqtzl1ZFo1R+gov
YDeTaamNRmnEq8o4Gvn9uE3wbNyMhdmk1peOM1h42QbmY5T/WjrIWA8RwWeV9HdJOZd7gp4i
/3HwTnkcUhMcUbG01s1pSb4hs3RqabONgBmmBgkNj6MgGFZbIttgHap8Q1wgK2ZWmRi7ti7d
xPGC2pk4eBR4nFyH9Vh4X44tLCsJAkU5PwO+0Xr1oIY53D3OTjKax2Fx6TyieYj7bxx4IaqY
7LFCUckgJQmuUgITXa6suQcftFAJNjb9QvBanXejEImQTwkc0GAUw3E4GL4QjJ16ZyWfoSvT
hQAAAAAAAA==
--------------ms020501020808010602050101--
