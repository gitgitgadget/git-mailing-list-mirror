Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD058207EC
	for <e@80x24.org>; Mon, 10 Oct 2016 03:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbcJJDqM (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 23:46:12 -0400
Received: from tc.outersquare.org ([75.144.255.93]:45653 "EHLO
        cid.outersquare.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbcJJDqL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 23:46:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by cid.outersquare.org (Postfix) with ESMTP id 35590678BD4A;
        Sun,  9 Oct 2016 20:46:10 -0700 (PDT)
X-Virus-Scanned: amavisd-new at mydomain = outersquare.org
Received: from cid.outersquare.org ([127.0.0.1])
        by localhost (cid.outersquare.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HZ3g0oVpDiwS; Sun,  9 Oct 2016 20:46:09 -0700 (PDT)
Received: from [10.0.30.3] (tc.outersquare.org [75.144.255.93])
        by cid.outersquare.org (Postfix) with ESMTPSA id E12EC678BD31;
        Sun,  9 Oct 2016 20:46:08 -0700 (PDT)
From:   Jeremy Huddleston Sequoia <jeremyhu@freedesktop.org>
Message-Id: <49BF26B2-8E6D-40B1-87A2-1FDDF9A76B8E@freedesktop.org>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E60BC6C5-EFA4-4C95-BFC3-319366EC884F";
 protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3249\))
Subject: Re: git 2.10.1 test regression in t3700-add.sh
Date:   Sun, 9 Oct 2016 20:46:08 -0700
In-Reply-To: <6CA5F44F-38C1-4C15-9B85-FE84FB93E616@freedesktop.org>
Cc:     gitster@pobox.com, git@vger.kernel.org
To:     t.gummerer@gmail.com
References: <A433322C-2B75-4B4B-A8CC-BAC3179EE7A7@freedesktop.org>
 <98EB348E-221D-488C-A466-1FACB1C768FF@freedesktop.org>
 <6CA5F44F-38C1-4C15-9B85-FE84FB93E616@freedesktop.org>
X-Mailer: Apple Mail (2.3249)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_E60BC6C5-EFA4-4C95-BFC3-319366EC884F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Oct 9, 2016, at 20:22, Jeremy Huddleston Sequoia =
<jeremyhu@freedesktop.org> wrote:
>=20
> The issue is that the whitespace before the filename in $(git ls-files =
-s "$2") is a tab, and test_mode_in_index only looks for a space.

Actually, looks like that as just a rabbit hole.  The real issue looks =
to be because an earlier test drops down xfoo3 as a symlink, which =
causes this test to fail due to the collision.  I'll get out a patch in =
a bit.

>=20
>> <
>=20
>> On Oct 9, 2016, at 19:51, Jeremy Huddleston Sequoia =
<jeremyhu@freedesktop.org> wrote:
>>=20
>>=20
>>> On Oct 9, 2016, at 17:15, Jeremy Huddleston Sequoia =
<jeremyhu@freedesktop.org> wrote:
>>>=20
>>> Hi Thomas,
>>>=20
>>> I wanted to let you know that this patch of yours, which landed in =
git 2.10.1, introduced some test failures, seen on macOS.
>>>=20
>>> Let me know if you need any additional information to track these =
down.
>>>=20
>>> Thanks,
>>> Jeremy
>>>=20
>>> not ok 40 - git add --chmod=3D[+-]x changes index with already added =
file
>>> #=09
>>> #		echo foo >foo3 &&
>>> #		git add foo3 &&
>>> #		git add --chmod=3D+x foo3 &&
>>> #		test_mode_in_index 100755 foo3 &&
>>> #		echo foo >xfoo3 &&
>>> #		chmod 755 xfoo3 &&
>>> #		git add xfoo3 &&
>>> #		git add --chmod=3D-x xfoo3 &&
>>> #		test_mode_in_index 100644 xfoo3
>>> #=09
>>>=20
>>> commit 610d55af0f082f6b866dc858e144c03d8ed4424c
>>> Author: Thomas Gummerer <t.gummerer@gmail.com>
>>> Date:   Wed Sep 14 22:07:47 2016 +0100
>>>=20
>>>  add: modify already added files when --chmod is given
>>>=20
>>>  When the chmod option was added to git add, it was hooked up to the =
diff
>>>  machinery, meaning that it only works when the version in the index
>>>  differs from the version on disk.
>>>=20
>>>  As the option was supposed to mirror the chmod option in =
update-index,
>>>  which always changes the mode in the index, regardless of the =
status of
>>>  the file, make sure the option behaves the same way in git add.
>>>=20
>>>  Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>>>  Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>=20
>>=20
>> This failure looks odd.  I'll dig into it a bit more as it looks like =
something odd is going on here...
>>=20
>> expecting success:=20
>> 	echo foo >foo3 &&
>> 	git add foo3 &&
>> 	git add --chmod=3D+x foo3 &&
>> 	test_mode_in_index 100755 foo3 &&
>> 	echo foo >xfoo3 &&
>> 	chmod 755 xfoo3 &&
>> 	git add xfoo3 &&
>> 	git add --chmod=3D-x xfoo3 &&
>> 	test_mode_in_index 100644 xfoo3
>>=20
>> pass
>> cannot chmod 'xfoo3'fail
>> 120000 c5c4ca97a3a080c32920941b665e94a997901491 0	xfoo3
>> not ok 40 - git add --chmod=3D[+-]x changes index with already added =
file
>> #=09
>> #		echo foo >foo3 &&
>> #		git add foo3 &&
>> #		git add --chmod=3D+x foo3 &&
>> #		test_mode_in_index 100755 foo3 &&
>> #		echo foo >xfoo3 &&
>> #		chmod 755 xfoo3 &&
>> #		git add xfoo3 &&
>> #		git add --chmod=3D-x xfoo3 &&
>> #		test_mode_in_index 100644 xfoo3
>> #=09
>>=20
>=20


--Apple-Mail=_E60BC6C5-EFA4-4C95-BFC3-319366EC884F
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIM5TCCBeIw
ggPKoAMCAQICEFy2SG5HDJjGf/aA22RK4o0wDQYJKoZIhvcNAQELBQAwfTELMAkGA1UEBhMCSUwx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmlj
YXRlIFNpZ25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4X
DTE1MTIxNjAxMDAwNVoXDTMwMTIxNjAxMDAwNVowdTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMw
IQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAO4PUIyVCSOErPVQao/WN6JOIf0yCWVHPq84+tUb94TQf8nhBAtX894vxFPjFzjh
sTOygm7QiHCcRyFv5PET+rDzzDuHE4O7Dc3wVrGLHprWOnzf5Fa9kdl/vz477cZgGl6Rl9M570D8
WhNdtyDBl8tMxCh2f5yQ2dffUz/UzZ/b/tUDtAGW+KGie3IdA6UiWvJBecYjRQwIPbWiikq1bjxy
S/TBRWDyKsEoYx4PrmBM438WzD9kFsGpp2gPWO3zkUgzWqXbhZQEQHA7V3TKQIo4huByp6zd9tyN
Cmu5Q0wFsi7UwwhEyrCPH8zsi9IpxLtVhFaXT8rZvLNa8EAeH/UCAwEAAaOCAWQwggFgMA4GA1Ud
DwEB/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB
/wIBADAyBgNVHR8EKzApMCegJaAjhiFodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmww
ZgYIKwYBBQUHAQEEWjBYMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5zdGFydHNzbC5jb20wMAYI
KwYBBQUHMAKGJGh0dHA6Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL2NhLmNydDAdBgNVHQ4EFgQU
mZerGDU6i1lFQ5iycnHI9PsJzxYwHwYDVR0jBBgwFoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwPwYD
VR0gBDgwNjA0BgRVHSAAMCwwKgYIKwYBBQUHAgEWHmh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3Bv
bGljeTANBgkqhkiG9w0BAQsFAAOCAgEAmUFBBM72JPVOMDR4Q7tX/UBsG8wB+JuMCCh/GYnTWMGY
cqDSltONYidNNijFvcsGDPeZ+O+9LU+Och9vb0zJWbQb89IeOCrsTCzV0Qkw8L1dO7E9/Zz4xYuT
KcGWi1bnjYmmtb6JNZ9lp/JS3MgpbWGTRgBInzNJKPwP773JH7RSGRu+UQImR2LX563QRojschfp
xyPWt9wUV+VZf989Prh2f2OmD2zSe4m6DhaxWQQrbfpad1mgwetmaAXsIjJndPSa6pjCQBIMNxG3
0DbWj8xz4PxDoZWYpEYHeAQq862yKgdkSom/oJ0CbdrqCWijmlfdEvV4LNzwvN+zhPQhJmOvzE0x
tMaWy4doUf6y0N7Aqx+emjg3rg60AavOZV8UWwwhEQ1EexWVIR7/otWkGmOfTT7tuoQ3ep6pLEg6
tpgnXaYnTwbhic/ZTV9p0chpLnQ7lleoCK+gGX2mL/oIE1znAgyWRczIVnSwuwj70SsUO704mFfu
JYKjr1fTJ2XNePTz7YrU8rKv6Dr+9M8e6vrcmi02uHKhYQnJYSMEsDhCYld8akHm75sLA1+wWlxg
CWSIW3VGza96aBIHLergMcNs8q+vVgiZk1FIc/5Nf00/3glGSapzIP+po3u7YlXWlECXAbSenKuf
plAzVAdX6IVvBDhWosxaT/9BWj+tnLUwggb7MIIF46ADAgECAhAX8MOmbUCDPWU+X4TKPzSUMA0G
CSqGSIb3DQEBCwUAMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYD
VQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20g
Q2xhc3MgMiBDbGllbnQgQ0EwHhcNMTYwMTI4MDUzNDA3WhcNMTgwMTI4MDUzNDA3WjBzMQswCQYD
VQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTERMA8GA1UEBwwIV29vZHNpZGUxGTAXBgNVBAMM
EEplcmVtaWFoIFNlcXVvaWExITAfBgkqhkiG9w0BCQEWEmplcmVteWh1QGdtYWlsLmNvbTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANJQpjXCVgn9Bf+x34nMseNlpLX3qKn9mGqv2uh2
gBPf++z3kXVI2c92FN/lEicsvvAnuo3q0RwJvh/Z++8dW+RRuAm58adZmXEJWwf90vLzH3hFDC4W
V6slcg3e5KvtcJ+u6BzT/WFRdDGEPqsYENI0OpEJK2NcfmRzkZ+CTitMp379Z7vV3ly3l72Y/I4E
UZgYSluez4qqwlljdOVgL7aTmrJuw2ZI5CoDpj2xiwvFxFm9vyfgyyh34p2sFhSR/AWZR5rsfyoM
fw0uJ7s7a5EgdOf/dS0eeqpohBAXvfHQ0AFq4Gx++bAxWCaogskAhTxGBoc9fn85CCyiwlrfNcZZ
6+L5rY+n7JoUHRYZjwYIBieI5YQ247GkN8R+fBjIrMCDl/+7uI/1Vg/hxstsrvUyLouuOl9k3WWu
PSiSHjKZGuNnZS4z1LXDBnOtUCsyjHs79L617AyFK3Mt+W5qdUK5ChPzNYL5IcNLkkLduy6WGsZH
39n9Lruemd6qr+T9Syd1x+Zz7+4xog6DFyML89nJT7mQ1MDUVEpyX2N1GvDCgnVJ7iOQB1mL7fKg
qEdLYkihyWy3SkJrmw/Ga+GOjr0DkmrUUWIYkAOF8mWKGoigayR3RMZhWDyRxpXyFF7jtphX9Fob
Td96tP4RWs9GrfD5BGVtdhVW97SW0A3D8UkxAgMBAAGjggKHMIICgzALBgNVHQ8EBAMCBLAwHQYD
VR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAkGA1UdEwQCMAAwHQYDVR0OBBYEFMXHiWE0gVse
XU627q/t4qVnbDu6MB8GA1UdIwQYMBaAFJmXqxg1OotZRUOYsnJxyPT7Cc8WMG8GCCsGAQUFBwEB
BGMwYTAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDkGCCsGAQUFBzAChi1o
dHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9zY2EuY2xpZW50Mi5jcnQwOAYDVR0fBDEwLzAt
oCugKYYnaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2NhLWNsaWVudDIuY3JsMIHjBgNVHREEgdsw
gdiBEmplcmVteWh1QGdtYWlsLmNvbYESamVyZW15aHVAYXBwbGUuY29tgRFqZXJlbXlodWRAbWFj
LmNvbYEVamVyZW15aHVAbWFjcG9ydHMub3JngRhqZXJlbXlodUBmcmVlZGVza3RvcC5vcmeBEGpl
cmVteWh1ZEBtZS5jb22BFGplcmVteWh1ZEBpY2xvdWQuY29tgRRqZXJlbXlAamVyZW15aHUuaW5m
b4EUamVyZW15QGh1ZHNjYWJpbi5jb22BFmplcmVteUBvdXRlcnNxdWFyZS5vcmcwIwYDVR0SBBww
GoYYaHR0cDovL3d3dy5zdGFydHNzbC5jb20vMFQGA1UdIARNMEswDAYKKwYBBAGBtTcGATA7Bgsr
BgEEAYG1NwECBDAsMCoGCCsGAQUFBwIBFh5odHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kw
DQYJKoZIhvcNAQELBQADggEBANa+oip18OvH6LflykKaMt8qN07CwhNKYvWcCeTCR2IDJsDUbVXB
9H8RqqAgEs7pEjRY+gdJSzf8wqPzJ5n6zpyeJH7p1Rsvdx9UEknqgJlmKjzOJ15GFWMjhWjlg05n
SKJsGmJrpIHVjxSeq+q5RVizyxYh1OyRisKmSrJdrmqHeBcKjlfQjFtdEt/LZrJ/qzH4WaRohdoN
C5vXwIxdczlEnZc1+ZfM5j39unU1GAskIgQCHrUJcublS53ysYKo6JhidGUytVB5O0k6J1J73dCZ
DOhlN/np0KmCWDYx8UgdJHhEyhyAKSWWltf2U4bPpEI4BbOKwegeRJJqK1oRW9cxggROMIIESgIB
ATCBiTB1MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEpMCcGA1UECxMgU3Rh
cnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29tIENsYXNzIDIg
Q2xpZW50IENBAhAX8MOmbUCDPWU+X4TKPzSUMAkGBSsOAwIaBQCgggGZMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE2MTAxMDAzNDYwOFowIwYJKoZIhvcNAQkEMRYE
FGToJ7bN7jp4WzzvTh7revcWZioqMIGaBgkrBgEEAYI3EAQxgYwwgYkwdTELMAkGA1UEBhMCSUwx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24g
QXV0aG9yaXR5MSMwIQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1l
Pl+Eyj80lDCBnAYLKoZIhvcNAQkQAgsxgYyggYkwdTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMw
IQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1lPl+Eyj80lDANBgkq
hkiG9w0BAQEFAASCAgCImEnhGqJORYbfPZObYP2mRbYk1jbWsCTagOSUpH9nZZV6oRXSiKHZNy9I
K4DyGaQLOGeL3vB5F/61MxnkNkNDZsZqRppUs+MllXZuv7KHohUkrPRZqTdinBtgtx2Hg0CM4M4Q
Azt0uGzWvX5vs9RKchSwstdmVZT7L/Khlpp2M9hiiY6iSd1qiv8AcVIO+tUsAJ1J3veogSGkzuml
iR6JULonkyMV2rTMJZPq2mFs/k2OOeJBWi8OvogHIDdemdUKzhgLERzD5KEeB+UnMX5exDmdBTQ8
t1ATYY9AFnr+VV4ILWMCytWx3HBTGFkvqkjdJdRDenl962wERYdCmxlEXLtPQbVSPhls3LcRjIxW
8XuICCboM8/kG9x2jxDdPzvITBMVHMN45MIT6blLc30HTK/zoNYSQdMhuMIeHT8Sbn/QLZZq1DVS
mV9Xvj4Lc1bZqEUnJ2IDIZFFer/RlQ4BANTge6IhAlxGZ4/BzdIF6lvjS7m3gFbUSMx/d5DWb/yg
JxzKg/E4XQHwY0C5ACRl3YCSrxdUsfntr5mK2OHGsj67FtqKde0Gd5/iOO6fXAIII1RFxT7ET4uz
jSzorO0MP/UIsQt81q6wUZT6egkhblZMiSX33K5rDfq+azcJt1+yzntFJiHiyGcvYmn+BjrfeJF2
GJq5a3VtUfU6ZpuSnQAAAAAAAA==
--Apple-Mail=_E60BC6C5-EFA4-4C95-BFC3-319366EC884F--
