Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C84D81F404
	for <e@80x24.org>; Sun,  4 Feb 2018 18:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeBDS3a (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 13:29:30 -0500
Received: from lucaswerkmeister.de ([94.130.58.99]:48552 "EHLO
        lucaswerkmeister.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751767AbeBDS32 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 13:29:28 -0500
Received: from theoden.lucaswerkmeister.de (unknown [IPv6:2a02:8109:9a3f:f575:be5f:f4ff:fecb:74cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mail@lucaswerkmeister.de)
        by lucaswerkmeister.de (Postfix) with ESMTPSA id 0AD7D1A99A9;
        Sun,  4 Feb 2018 19:29:27 +0100 (CET)
Authentication-Results: lucaswerkmeister.de; dmarc=fail (p=none dis=none) header.from=lucaswerkmeister.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucaswerkmeister.de;
        s=mail; t=1517768967;
        bh=I0EUZVEfeBPHcuJIRvUxWhXZaALtZaizx6mdwcZRjt0=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:From:Reply-To:Subject:Date:To:Cc:
         In-Reply-To:References:Message-Id:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version;
        b=YW4xWnNHB7w4s/hCs36GZhT5F+n1r/I1Bj1KEcnrKwb6AJaPGbi7OWNnv9rZ1b6Fc
         UH71moWxPT57hz42Lic9TUqBK1bZiX8s2Qjca8mPraFkDTCJVRvHwLA7DFy0WOUyM/
         JzpKl9tX7kmYfCDVdoRgvF/a9loTJp2r0pbR8jcc=
Subject: Re: [PATCH v3] daemon: add --log-destination=(stderr|syslog|none)
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <CAPig+cR1VXtc-wZxv3mZGsbTAzmtPbhnRPtBX97-8Rm9b6rpHQ@mail.gmail.com>
 <20180203230801.30345-1-mail@lucaswerkmeister.de>
 <CAPig+cS8hqaqwrzw9GXY9x0rgksPrCm_deHHw-AL6Tj8-bf1Og@mail.gmail.com>
From:   Lucas Werkmeister <mail@lucaswerkmeister.de>
Message-ID: <772ae5fc-5f92-3494-613a-a44c0073e8d7@lucaswerkmeister.de>
Date:   Sun, 4 Feb 2018 19:29:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cS8hqaqwrzw9GXY9x0rgksPrCm_deHHw-AL6Tj8-bf1Og@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms010708000905010207020505"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms010708000905010207020505
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04.02.2018 07:36, Eric Sunshine wrote:
> On Sat, Feb 3, 2018 at 6:08 PM, Lucas Werkmeister
> <mail@lucaswerkmeister.de> wrote:
>> This new option can be used to override the implicit --syslog of
>> --inetd, or to disable all logging. (While --detach also implies
>> --syslog, --log-destination=3Dstderr with --detach is useless since
>> --detach disassociates the process from the original stderr.) --syslog=

>> is retained as an alias for --log-destination=3Dsyslog.
>> [...]
>> Signed-off-by: Lucas Werkmeister <mail@lucaswerkmeister.de>
>=20
> Thanks for the re-roll. There are a few comments below. Except for one
> apparent bug, I'm not sure the others are worth a re-roll...
>=20
>> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.t=
xt
>> @@ -110,8 +112,26 @@ OPTIONS
>> +--log-destination=3D<destination>::
>> +       Send log messages to the specified destination.
>> +       Note that this option does not imply --verbose,
>> +       thus by default only error conditions will be logged.
>> +       The <destination> defaults to `stderr`, and must be one of:
>=20
> I wonder if this should say instead:
>=20
>     The default destination is `stderr` unless `syslog`
>     is implied by `--inetd` or `--detach`, ...
>=20
>> diff --git a/daemon.c b/daemon.c
>> @@ -9,7 +9,12 @@
>> -static int log_syslog;
>> +static enum log_destination {
>> +       LOG_DESTINATION_UNSET =3D -1,
>> +       LOG_DESTINATION_NONE =3D 0,
>> +       LOG_DESTINATION_STDERR =3D 1,
>> +       LOG_DESTINATION_SYSLOG =3D 2,
>> +} log_destination;
>=20
> Doesn't log_destination need to be initialized to
> LOG_DESTINATION_UNSET (see [1])? As it stands, being static, it's
> initialized automatically to 0 (LOG_DESTINATION_NONE), which borks the
> logic below.

Thanks, I knew I=E2=80=99d forgotten something :)

>=20
>> @@ -74,11 +80,14 @@ static const char *get_ip_address(struct hostinfo =
*hi)
>>  static void logreport(int priority, const char *err, va_list params)
>>  {
>> +       switch (log_destination) {
>> +       case LOG_DESTINATION_SYSLOG: {
>>                 char buf[1024];
>>                 vsnprintf(buf, sizeof(buf), err, params);
>>                 syslog(priority, "%s", buf);
>> +               break;
>> +       }
>> +       case LOG_DESTINATION_STDERR:
>>                 /*
>>                  * Since stderr is set to buffered mode, the
>>                  * logging of different processes will not overlap
>> @@ -88,6 +97,10 @@ static void logreport(int priority, const char *err=
, va_list params)
>>                 vfprintf(stderr, err, params);
>>                 fputc('\n', stderr);
>>                 fflush(stderr);
>> +               break;
>> +       case LOG_DESTINATION_NONE:
>> +       case LOG_DESTINATION_UNSET:
>> +               break;
>=20
> Since LOG_DESTINATION_UNSET should never occur, perhaps this should be
> written as:
>=20
>     case LOG_DESTINATION_NONE:
>         break;
>     case LOG_DESTINATION_UNSET:
>         BUG("impossible destination: %d", log_destination);

Good point, I didn=E2=80=99t know about the BUG() macro. But putting the
destination in the message seems unnecessary if it can only be a single
value =E2=80=93 or would you make this a default: case?

>=20
>> @@ -1297,9 +1309,22 @@ int cmd_main(int argc, const char **argv)
>> +               if (skip_prefix(arg, "--log-destination=3D", &v)) {
>> +                       if (!strcmp(v, "syslog")) {
>> +                               log_destination =3D LOG_DESTINATION_SY=
SLOG;
>> +                               continue;
>> +                       } else if (!strcmp(v, "stderr")) {
>> +                               log_destination =3D LOG_DESTINATION_ST=
DERR;
>> +                               continue;
>> +                       } else if (!strcmp(v, "none")) {
>> +                               log_destination =3D LOG_DESTINATION_NO=
NE;
>> +                               continue;
>> +                       } else
>> +                               die("Unknown log destination %s", v);
>=20
> Mentioned previously[1], this probably ought to start with lowercase.
> It also would be more readable to set off the unknown value with a
> colon or quotes:
>=20
>     die("unknown log destination '%s', v);
>=20
>> @@ -1402,7 +1426,14 @@ int cmd_main(int argc, const char **argv)
>> -       if (log_syslog) {
>> +       if (log_destination =3D=3D LOG_DESTINATION_UNSET) {
>> +               if (inetd_mode || detach)
>> +                       log_destination =3D LOG_DESTINATION_SYSLOG;
>> +               else
>> +                       log_destination =3D LOG_DESTINATION_STDERR;
>> +       }
>> +
>> +       if (log_destination =3D=3D LOG_DESTINATION_SYSLOG) {
>>                 openlog("git-daemon", LOG_PID, LOG_DAEMON);
>>                 set_die_routine(daemon_die);
>=20
> [1]: https://public-inbox.org/git/CAPig+cTetjQ9LSH68Fe5OTcj9TwQ9GSbGzdr=
jzHOhTAVFvrPxw@mail.gmail.com/
>=20

I=E2=80=99ll send a new version shortly, also addressing your other comme=
nts
which I didn=E2=80=99t reply to here.

Cheers,
Lucas


--------------ms010708000905010207020505
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
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODAyMDQxODI5MjZaMC8G
CSqGSIb3DQEJBDEiBCAnVE71ve5zySjseVA/OYvpHXJJR3pinFnZKNUqJ7LaBzBqBgkrBgEE
AYI3EAQxXTBbMFQxFDASBgNVBAoTC0NBY2VydCBJbmMuMR4wHAYDVQQLExVodHRwOi8vd3d3
LkNBY2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFzcyAzIFJvb3QCAwKa/jBsBgkqhkiG
9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMGwGCyqG
SIb3DQEJEAILMV2gWzBUMRQwEgYDVQQKEwtDQWNlcnQgSW5jLjEeMBwGA1UECxMVaHR0cDov
L3d3dy5DQWNlcnQub3JnMRwwGgYDVQQDExNDQWNlcnQgQ2xhc3MgMyBSb290AgMCmv4wDQYJ
KoZIhvcNAQEBBQAEggEAnD+iixDhvxisLqCi0IKft2qu5g7pHE85YzjMujU+jr//AGExbudD
WicT/stp5evBuhK8uYimSqnYTX7yiyTyDNWccuKRA6Nw3677zkvdtRR1LzB3hlwiuTlDo5WQ
VxIWCLzzCy+op6Xnbb2WLwPY+umUO1Fh0MENv5KVBgmelCJ9TMCxvSEk0hIrGXkVSfGrnsb+
23Nzhpa373PDE+F1KBVV9boHD84r4v2u367HHyctnARiVylUQaB+sT+Mix175xxW0QUERB8k
gVntedHmlVeCeODsxHNZqu+NJFwa065W0H5I15pkO7ickzt+b94dE/w7PrpusmK3fDBYanaI
owAAAAAAAA==
--------------ms010708000905010207020505--
