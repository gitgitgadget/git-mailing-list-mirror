Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DECC11F6B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 11:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A744C61DA4
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 11:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbhGFLhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 07:37:13 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:29870
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233730AbhGFL0R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 07:26:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBACeojnuLfKyC7AGxCznSAU5NDlcQ+aWyYdonh3+V8Yy4HdS36lk+wLhuNfjS1YlrmN9uPSpKFattLWeNdClgR3XWraVm4QYGGk1XX1fXe0rn9VZUGAETLZerxgPTNt7gsUt9vjXJwrgMMVjIuud8I3Dxs0VphFdgqIOFKYd+x9G29nRQlyB3IxaywMfywVz/9cezm6LKO4uuFshk9GnLdKURChCegweO9ufRrCiyr/4qgHpz+59jUmPMqQ1FKUNSkqjCcZZIbVqUvMDkyqCEUnm67H8IxkICZVqqdQht0d49FR69a59a6nSpFAvk/1UZ9aQID8Lgtd7CsUQTDIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeNHP4NfuEzKsO0AW5cfpNBHP5MhwWVMogdD8Nfzhng=;
 b=M2XGqBCNdCN/pOVGrBKWJabE10NIZTh2qDsaumEqBHqERV1sfJmUatUrAh9xRkOzO4nUt6JkPmnLxsoh0Af/cIA4kt7fby42KH3yO9hev/XEmzKjoPSsZKGc29SXrbxmPl28pEkP3wqWYZ5bFC+w2Kldy505WeHbTobFcFQ/DWVVGzNi59ieyaHmR9p8WjEqTuY6A3UIlNn7nOlN/OAuj02wk0o7cv6skWo4qmJYnjn9oNWxJYTwKrMSDn1QqLF9G8PXUbIQ0fFObz8Q1+9OWv9l9n06owfryC7sDhJD1SH6PzMAT3pzHIf7nDJmLtt7Qt7m5g3ASaxs4ZXa51QKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeNHP4NfuEzKsO0AW5cfpNBHP5MhwWVMogdD8Nfzhng=;
 b=UFSDR+/oCr6W7kQ3JMy4NWFNOO6VzDPmBn1HDIE+ydiItss2XNorofW3sTy3q4RXHhS7scc6bamvqRKde5BXfRNvMP7rl7iUdJqYRLShIUEczMz+L+AiZIpLn+OxFqhocgOlVUOMCuVf+gtknO975cAvcLLbJutW+xK6yZq606g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3866.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Tue, 6 Jul
 2021 11:23:36 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 11:23:36 +0000
Subject: Re: [PATCH] Add commit & tag signing/verification via SSH keys using
 ssh-keygen
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org
References: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
 <CAFQ2z_O8fQ4eaCL30jpe8-_q5Cez4jH_E3v5WbgZ0ZgVZYZcyQ@mail.gmail.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <b5a5cf87-afca-aaa9-b309-da702b3b18de@gigacodes.de>
Date:   Tue, 6 Jul 2021 13:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAFQ2z_O8fQ4eaCL30jpe8-_q5Cez4jH_E3v5WbgZ0ZgVZYZcyQ@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020402090403070300090509"
X-ClientProxiedBy: PR1P264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::11) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR1P264CA0024.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Tue, 6 Jul 2021 11:23:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d55a13c7-9e37-47c7-0ee8-08d940707f0d
X-MS-TrafficTypeDiagnostic: PR3PR10MB3866:
X-Microsoft-Antispam-PRVS: <PR3PR10MB386637431DC9652850F1A913B61B9@PR3PR10MB3866.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjc5lmzfRPSq2sK2Ia+NUUVOH8gtv1zMpY9c7zL/2ygucYIJCMle28D2b2+lK12FYBd+BvHx6ey6XptFD3KfeAddya1Fk8RoJoaLTGbBlMkFmudgtzGh06E2OdmceHHnnzrKYcjwNnKr37Ep+6KzbOWdoYrpBdEBk/C9Dd8hRHRpXTm4eo2AVxt98SKtKAlzSZFEYiPUMgHGIFzRksiiE1ChJXLx0g4sGz5u/Kpe9k/X/VpaLiXKDMjgBdChaysi1TGbn3xcZqOxNJAKIh+cS6Xz99Ng9L2/wmuwqAcWbNQc7axTUzIeG+YrB3MHKMOyWjNBiWyiN452j0R9P4K2hs5usJOZ2tYjITpJ5Qj2KfA7cibubHBKQHnrG71pfSgDEBOcolQFGeDSGSWIU/6PeHs90ghoE3uWj4AaOkK7dGacXUC80yvImi7/xxYesNEyXepT2Ea6/2hfN8vIOPxEwEGgFo2qmRh1DK0TexUBiUPY/6AWITJV+gjAvpVgOLc5BoSURW0B14NgdFcZZwSI2QVbvP6pOmAloKTa3neek0qvSH9yxP6lLOWme/i1tWxhDvGdKurVOl8baO6IgwOckcgpHKjLuMgnKjzoIRMvWaqpye8z96kGKA+l4TJhkSZ+e3k/iCDCqClaDzYTKLakbi9yQ9i3GpwsgDytb1f9hh+D+1g0QM7XK4EqrxxwKES1ui0eqz5dZo5uUQehyGRUmHsnRro8RJrbkVKeLl/f9Mo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(39830400003)(376002)(2906002)(6486002)(83380400001)(31696002)(8676002)(38100700002)(235185007)(36756003)(8936002)(186003)(31686004)(5660300002)(478600001)(52116002)(6666004)(86362001)(6916009)(4326008)(66476007)(66556008)(66946007)(316002)(2616005)(15650500001)(33964004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3BhTlQ2QVRkSjNHazlncVRldWdkVDU5QTUrUkg2cUVyeVR5eGV4bEg0Smpa?=
 =?utf-8?B?VjlXTUNrSkp2VFhLSkJrN0E5NHEwOHhSVzYyMkJzeDd1eXRjYXRLTDNOdk0x?=
 =?utf-8?B?YUtkc1Q0VC9Vb3dFNmtTajVYVk01TmdVbVJIcmI0RXgrWmhFODRYTmJLQTA5?=
 =?utf-8?B?TFBzM3AweHZ5ZCtLYitsUC9PYk91bEZHMGJGSG9PQWV1MUo5TGVyYnBiWmEr?=
 =?utf-8?B?YkoxTm9tdUVueXdrMkxJdm1QNStMdGg3c1JFaExLcERhaGtKeHV2enNjK25u?=
 =?utf-8?B?TERoSVE3b2dFUHFPZm12ZDFRcHR4bTBRRHM5dW8zVzI3K085OTUxQk5nQVU5?=
 =?utf-8?B?dmVkVC9kWFpnNFlUVC92dkIweWdoc1c0RGxueng0VEJ0SCtteCtJUkt3ZkxV?=
 =?utf-8?B?ZFVTcUkyUlZZMHE1N3R1RUlaemd3QmloUW9yWmt3QXJ1TnJaYnFVdzlqbTdD?=
 =?utf-8?B?VnJvV01oQzFoVW55bkRTMzlZdExyLzBUcXhSWFF4VTVzNkZOUnlSeXEzdkNP?=
 =?utf-8?B?TXlueXhBTmhJL1ZuV0c1YzBJQVlrZDZ1d2ZFUHlsamJWV3FqKzMrZVE3RVVW?=
 =?utf-8?B?VUh2VXRML2kreGVjbm1pWHo4WFBXbnRJOVc4T1pnNEtBOXo4YlN0Wnk2bllh?=
 =?utf-8?B?bUNTUFNudzZIVnFROThEalJpNXJEWk95QUtzWEE2MzZrVFE2eWdaRlY0NW5o?=
 =?utf-8?B?NENWamhoS2ZnbzlveEVQMElidFhmTm5ycTlkTFFQZlBFRE03V256OStrUmkw?=
 =?utf-8?B?dG55U2RmQm9jcVZ5c0tmc1pEV25xYUwxWVRoUkRRRU4wY1FpY01ZMzJFUTB2?=
 =?utf-8?B?blpXSk41emI3UVFIbFFGcEVhK3YvRTY2QzM2MG9HaGphSTZEWTVSeDFGY0tT?=
 =?utf-8?B?Rk9TWlVSMGhKd1kxVCtYSlRucU8rb3k1eDIzWWJ4di9ZRHQwNGR3cHpPNkZV?=
 =?utf-8?B?SWlvNlV6ekZqaG8xMlltK04vSzRxbjhsT2N1aDdFUEUrYWZzcVJiRDhEYlkw?=
 =?utf-8?B?KzRtQm5FMWlydngyQ2o3V3pZdEhJNUtoUE44R1VnUCtlSDM2L2RjK042eTY2?=
 =?utf-8?B?OU1DNURrN3l0TVFVbytLRWxGTWYyV1M3SXZIcDV4QVpLU2pHRlplRXNRNUZv?=
 =?utf-8?B?dmtkL1grYXlpSzdRclF4T3ArakJjZlRiZHlQYUkyVlBINWxjM2oraFJSOTAr?=
 =?utf-8?B?NllxR21hZlg5ZWw3dzdQRmNaTHYyQmxqYTdNUTI0VEJ1em12eWVUbXYwVC8z?=
 =?utf-8?B?bzhya0xQQmdGZkdtZGltb2Z3QTQ3L0pwRnBkbFVxNE9LK2RwSmZNa2FJdVRI?=
 =?utf-8?B?d29KbkwwbHdCUG9Jb0Z3SlN2eEpwVXBaTGpwN01KeGtTWTlpUGZpUVBGVmVr?=
 =?utf-8?B?WlhlVHFrWXZTODRUUkxWbzJPSURzemI1V1Z1RGhWUGdWd1dVdWttaWg2czU0?=
 =?utf-8?B?aUdUbWU3ZFdPVFpWSzVRbGJJand5YnVsVWh5Q1hheTlMbkhRN1UyN2RCa2gr?=
 =?utf-8?B?aDVTRzJ4Tjk5eVk0SGExWUtRUlpPeGlvOGFHZVhyejdrM1p3Z0Zud0RpSDdF?=
 =?utf-8?B?M2FRMWJxdVBEQjNXYmRheW9pSjlJN0VKNzlOTFgzNU1FbWJ2MVJjbnp0Umoy?=
 =?utf-8?B?dytUbUg1RVBqMWxZK3hwUWxGRTQxcnpFanZPUm5HS0lTVStRTWxQcGtvZzRM?=
 =?utf-8?B?ZEdQSW4ycmZVSjVIakJ6Y3I0ODhnckV2Z3VyaitKNVpZa21NbVc2enZBbUhh?=
 =?utf-8?B?UkFQOWFiYXdVNklSYVZweGhVdGdVUjkrQnVmN3U3ajh1dEt2ZGU0SWJmajZR?=
 =?utf-8?B?cDBYTlZqNmJzQm5yTmEzKzB2SWI5S2JubGhLZTZrU0x4UUN6Q1plb0lUWFBF?=
 =?utf-8?Q?MlOnn0Ck440l0?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d55a13c7-9e37-47c7-0ee8-08d940707f0d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 11:23:36.3714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2f2vIx2zC7p+rO2nFBkdTtTV6fMiOjKeUY5f0CVSUafeMY3usOkIuz5KJ+RAGGjQzf5A1r569auS5Cy88PdnDzu+ey1XBallZhJHNr9Ux+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3866
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--------------ms020402090403070300090509
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

>> From: Fabian Stelzer <fs@gigacodes.de>
>>
>> set gpg.format =3D ssh and user.signingkey to a ssh public key string =
(like from an
>> authorized_keys file) and commits/tags can be signed using the private=

>> key from your ssh-agent.
>>
>> Verification uses a allowed_signers_file (see ssh-keygen(1)) which
>> defaults to .gitsigners but can be set via gpg.ssh.allowedsigners
>> A possible gpg.ssh.revocationfile is also passed to ssh-keygen on
>> verification.
>>
> ...
>>      In our corporate environemnt we use PIV x509 Certs on Yubikeys fo=
r email
>>      signing/encryption and ssh keys which i think is quite common (at=
 least
>>      for the email part). This way we can establish the correct trust =
for the
>>      SSH Keys without setting up a separate GPG Infrastructure (which =
is
>>      still quite painful for users) or implementing x509 signing suppo=
rt for
>>      git (which lacks good forwarding mechanisms). Using ssh agent for=
warding
>>      makes this feature easily usable in todays development environmen=
ts
>>      where code is often checked out in remote VMs / containers.
> Thanks for working on this, and I support this initiative. I
> coincidentally have started proselytizing something similar just weeks
> ago.
>
> My interest is in signing pushes rather than commits/tags, as that (in
> combination with SSH U2F support) provides a simple mechanism to
> require (forwardable!) 2-factor authentication on pushes over HTTP. I
> haven't looked at the signing code in detail, but I had the impression
> that adding SSH signatures would automatically also add support for
> signed pushes? (aka. push-certs) Do you know?
>
Up until now i was not actually aware of the "push signing"=20
functionality in git.
I can see that the send/receive-pack use the same api function calls as=20
commit/tag signing.
So this should work just as well. Especially if using an ssh agent the wh=
ole
process is identical to git. I still need to try private key files=20
directly to see
how user interaction (like entering a passphrase or touching the U2F=20
Token) would work.



--------------ms020402090403070300090509
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
FAowggVwMIIEWKADAgECAgZIjQJd1vQwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYTAkRF
MSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYDVQQL
DBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFsUm9v
dCBDbGFzcyAyMB4XDTEyMTEyOTExMjM1NVoXDTI0MTEyOTIzNTk1OVowdTELMAkGA1UEBhMC
REUxJTAjBgNVBAoTHFQtU3lzdGVtcyBJbnRlcm5hdGlvbmFsIEdtYkgxHzAdBgNVBAsTFlQt
U3lzdGVtcyBUcnVzdCBDZW50ZXIxHjAcBgNVBAMTFVRlbGVTZWMgQnVzaW5lc3MgQ0EgMTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANEw1E1Ew+RLWrQYng5RJ7WpYkl6GgbA
cywRiVWSrA7L/kgvu13j9KmIuoFr5Ps3HSxX60WYVUFGicfnpzFke554CJ/AGD/pSmKxhPzg
0MytlS67gGr1p2TFN/vePeegzbGidDWjz+/tTXRtuo0kGrSf/FpVRjv/98LxeXp2d89P68oi
jXbYBZn3BPE8n3zbqGnwVd+jQahJS25dIHENuosJbmsi8KSd81aJwNbAWDAIV+Zi3Y4/0L3j
ujhXX63SNVK7q67Gtp8hEpOvRYtWNtXMpEw2LzPhtILmZEVd7urX3KBNQX/eZpmK/V1u7EXr
dOIJE/aK6qhnKGpOn/gSrLUCAwEAAaOCAfYwggHyMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4E
FgQUhoiTH4vrVZZl1UcBvTeMfM2ox6MwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzL
gkowEgYDVR0TAQH/BAgwBgEB/wIBADBTBgNVHSAETDBKMD4GCSsGAQQBvUcNGTAxMC8GCCsG
AQUFBwIBFiNodHRwOi8vc2JjYS50ZWxlc2VjLmRlL2Nwcy9jcHMyLnBkZjAIBgZngQwBAgIw
gfoGA1UdHwSB8jCB7zA6oDigNoY0aHR0cDovL2NybC5zYmNhLnRlbGVzZWMuZGUvcmwvR2xv
YmFsUm9vdF9DbGFzc18yLmNybDCBsKCBraCBqoaBp2xkYXA6Ly9sZGFwLnNiY2EudGVsZXNl
Yy5kZS9DTj1ULVRlbGVTZWMlMjBHbG9iYWxSb290JTIwQ2xhc3MlMjAyLE9VPVQtU3lzdGVt
cyUyMFRydXN0JTIwQ2VudGVyLE89VC1TeXN0ZW1zJTIwRW50ZXJwcmlzZSUyMFNlcnZpY2Vz
JTIwR21iSCxDPURFP0F1dGhvcml0eVJldm9jYXRpb25MaXN0MDoGCCsGAQUFBwEBBC4wLDAq
BggrBgEFBQcwAYYeaHR0cDovL29jc3AwNC50ZWxlc2VjLmRlL29jc3ByMA0GCSqGSIb3DQEB
CwUAA4IBAQCThdHrhHoZWcglgDokpbmWcQab/tYOdOBA3dXNXR0ggBlDSQ94dt4j3lzMN+2j
ynxKIQTZJZGZsT8HsmRC3BTnpY/T7a0gbXkdUiwXspLQs18wL0Q+Vu80V7aHkKm8R3WIMpM+
72lLGkowDbHnDUMBZYd8N4+bStWrUcn29ZfDHj9eFJSutg1yWfzl1xdfxOJmTtpmjSjRCtc7
tixaok7W2O+SlS1lmSRoMIqCDWLO34f//Dj1hHrOx4xxRnojKX2s9lYoAqyAi69XoEgdiGGf
Sj7/37yhZp0aAYbzHBFVy1rS/DC5FNYrCQfsauP2jVEaRClHbpeOwTHWNQj4HiRPMIIHRzCC
Bi+gAwIBAgIQGcQYOJIYjQ3VtN/uupEfjDANBgkqhkiG9w0BAQsFADB1MQswCQYDVQQGEwJE
RTElMCMGA1UEChMcVC1TeXN0ZW1zIEludGVybmF0aW9uYWwgR21iSDEfMB0GA1UECxMWVC1T
eXN0ZW1zIFRydXN0IENlbnRlcjEeMBwGA1UEAxMVVGVsZVNlYyBCdXNpbmVzcyBDQSAxMB4X
DTIwMDIxODEwNDg0NFoXDTIzMDIxODIzNTk1OVowgbgxCzAJBgNVBAYTAkRFMRQwEgYDVQQK
EwtjYW1Qb2ludCBBRzEVMBMGA1UECxMMY2FtcG9pbnQubmV0MRQwEgYDVQQLEwtFbmdpbmVl
cmluZzEXMBUGA1UEAxMORmFiaWFuIFN0ZWx6ZXIxDzANBgNVBCoTBkZhYmlhbjEQMA4GA1UE
BBMHU3RlbHplcjEeMBwGCSqGSIb3DQEJARYPZnNAZ2lnYWNvZGVzLmRlMQowCAYDVQQFEwEx
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzbHjTTbD/7OTER1JcFv2dsDtVRxg
fkbZlLqcd1u0t5W2rVt1a31rXY7smiTfy7dSbdj0mCHu0ud8WgjU/+i1NveWsmX1pKZ6hNEa
2yvTRC8DRe+U6+ba/uTbhQmEngvAU8EPHZPcGfilaGoSMot5bwh43XTe6hiPaZknZPa/6BqY
RXNaEvlJpVHC2GISNXWsARHpwXQRhd3rcqI0Y2sljnfpWbc3Aq5tydC6No0ftLGJK9Mqyqpy
B0LZQfkUeKlFMBmfPRuqQY3USQHbmte+ubSTASbOt2kmz34KzHF9Tpc659M5LMea13RKy5GT
L9gB3caeGbYHOIM6hysy+DSPLwIDAQABo4IDjTCCA4kwHwYDVR0jBBgwFoAUhoiTH4vrVZZl
1UcBvTeMfM2ox6MwHQYDVR0OBBYEFG5COl6QaEu+ziQIm+nfntcMBPfFMA4GA1UdDwEB/wQE
AwIFIDAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwWAYDVR0gBFEwTzBDBgkrBgEE
Ab1HDRkwNjA0BggrBgEFBQcCARYoaHR0cDovL3NiY2EudGVsZXNlYy5kZS9kb3dubG9hZC9j
cHMyLnBkZjAIBgYEAI96AQEwCQYDVR0TBAIwADCB8AYDVR0fBIHoMIHlMD2gO6A5hjdodHRw
Oi8vY3JsLnNiY2EudGVsZXNlYy5kZS9ybC9UZWxlU2VjX0J1c2luZXNzX0NBXzEuY3JsMIGj
oIGgoIGdhoGabGRhcDovL2xkYXAuc2JjYS50ZWxlc2VjLmRlL0NOPVRlbGVTZWMlMjBCdXNp
bmVzcyUyMENBJTIwMSxPVT1ULVN5c3RlbXMlMjBUcnVzdCUyMENlbnRlcixPPVQtU3lzdGVt
cyUyMEludGVybmF0aW9uYWwlMjBHbWJILEM9REU/Q2VydGlmaWNhdGVSZXZvY2F0aW9uTGlz
dDCCAScGCCsGAQUFBwEBBIIBGTCCARUwLwYIKwYBBQUHMAGGI2h0dHA6Ly9vY3NwMDMuc2Jj
YS50ZWxlc2VjLmRlL29jc3ByMEQGCCsGAQUFBzAChjhodHRwOi8vY3J0LnNiY2EudGVsZXNl
Yy5kZS9jcnQvVGVsZVNlY19CdXNpbmVzc19DQV8xLmNydDCBmwYIKwYBBQUHMAKGgY5sZGFw
Oi8vbGRhcC5zYmNhLnRlbGVzZWMuZGUvY249VGVsZVNlYyUyMEJ1c2luZXNzJTIwQ0ElMjAx
LG91PVQtU3lzdGVtcyUyMFRydXN0JTIwQ2VudGVyLG89VC1TeXN0ZW1zJTIwSW50ZXJuYXRp
b25hbCUyMEdtYkgsYz1kZT9jQUNlcnRpZmljYXRlMIGUBgNVHREEgYwwgYmBD2ZzQGdpZ2Fj
b2Rlcy5kZYEbZmFiaWFuLnN0ZWx6ZXJAZ2lnYWNvZGVzLmRlgQ9mc0BjYW1wb2ludC5uZXSB
G2ZhYmlhbi5zdGVsemVyQGNhbXBvaW50Lm5ldKArBgorBgEEAYI3FAIDoB0MG2ZhYmlhbi5z
dGVsemVyQGNhbXBvaW50Lm5ldDANBgkqhkiG9w0BAQsFAAOCAQEAA/gvcSSSg+3Fv/zQ5W8Q
NqZ7e+o2gvAAK9/m13ZZsffXma0MlVxnszHSecBWNWIGaMsnorfs3UOBtvNKi071OSZHIRdt
01R/BeIs1THloF5i93LxJht8L9YhUPLVFpLyXSJpAeZeBgmgxETjZ6NxMPvDGTowJbXuoghl
Enffv2OZ/eqyQfloJhs0GedD+ywRcHRtgdebhmdAIND+0wvEwb4orZYpVMC1Iif5YQoRoppy
KhFBXM7umYzm3a3o9F1xsdCZtH8pcsQbxk6++rFdwATjRXPdqx1nrJc/7KTPFpPiAXNLn8AE
FxntRDmy+kAHAqGOvPr7p6ZoCuLjJxc8mDCCB0cwggYvoAMCAQICECqns9Gy7hp/JP/uYPRZ
JCcwDQYJKoZIhvcNAQELBQAwdTELMAkGA1UEBhMCREUxJTAjBgNVBAoTHFQtU3lzdGVtcyBJ
bnRlcm5hdGlvbmFsIEdtYkgxHzAdBgNVBAsTFlQtU3lzdGVtcyBUcnVzdCBDZW50ZXIxHjAc
BgNVBAMTFVRlbGVTZWMgQnVzaW5lc3MgQ0EgMTAeFw0yMDAyMTgxMDQ4NDRaFw0yMzAyMTgy
MzU5NTlaMIG4MQswCQYDVQQGEwJERTEUMBIGA1UEChMLY2FtUG9pbnQgQUcxFTATBgNVBAsT
DGNhbXBvaW50Lm5ldDEUMBIGA1UECxMLRW5naW5lZXJpbmcxFzAVBgNVBAMTDkZhYmlhbiBT
dGVsemVyMQ8wDQYDVQQqEwZGYWJpYW4xEDAOBgNVBAQTB1N0ZWx6ZXIxHjAcBgkqhkiG9w0B
CQEWD2ZzQGdpZ2Fjb2Rlcy5kZTEKMAgGA1UEBRMBMTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBALzoNe796N6LfGhYkcCF7XtOjZiCfLDwx1L9QhDv0DwGp+dLo+5n/iI+/rlA
wwBgqhtLvaaWNE2vJuXYMVZXVyUgz4Wq1FvX9lXd7J4IiHhiHqcY1r0GB8IrY6kpiRaH5iyt
fOexvsVW9ddo3FzUGjjGMDYsyd9ppzqWXE9Q3Nbc7U9orhnGGp3xh20HTdP+iIDEaUhHkJIl
Rpni14oY+kSWq1WSw2m+qKsWux6KcQS3wKuoO3AAi5DX6vDtp5xztnffqI+SmCeT44CyCwrK
uZk5JBMsOaeaWYr8UiTNzS26Y46f2KeXnss2qc85i4p0hxp/qj7q28UwV5gE1w2La7cCAwEA
AaOCA40wggOJMB8GA1UdIwQYMBaAFIaIkx+L61WWZdVHAb03jHzNqMejMB0GA1UdDgQWBBR/
VPCB1rrm9xWvIhb2q8u5gSXriDAOBgNVHQ8BAf8EBAMCB4AwHQYDVR0lBBYwFAYIKwYBBQUH
AwIGCCsGAQUFBwMEMFgGA1UdIARRME8wQwYJKwYBBAG9Rw0ZMDYwNAYIKwYBBQUHAgEWKGh0
dHA6Ly9zYmNhLnRlbGVzZWMuZGUvZG93bmxvYWQvY3BzMi5wZGYwCAYGBACPegEBMAkGA1Ud
EwQCMAAwgfAGA1UdHwSB6DCB5TA9oDugOYY3aHR0cDovL2NybC5zYmNhLnRlbGVzZWMuZGUv
cmwvVGVsZVNlY19CdXNpbmVzc19DQV8xLmNybDCBo6CBoKCBnYaBmmxkYXA6Ly9sZGFwLnNi
Y2EudGVsZXNlYy5kZS9DTj1UZWxlU2VjJTIwQnVzaW5lc3MlMjBDQSUyMDEsT1U9VC1TeXN0
ZW1zJTIwVHJ1c3QlMjBDZW50ZXIsTz1ULVN5c3RlbXMlMjBJbnRlcm5hdGlvbmFsJTIwR21i
SCxDPURFP0NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3QwggEnBggrBgEFBQcBAQSCARkwggEV
MC8GCCsGAQUFBzABhiNodHRwOi8vb2NzcDAzLnNiY2EudGVsZXNlYy5kZS9vY3NwcjBEBggr
BgEFBQcwAoY4aHR0cDovL2NydC5zYmNhLnRlbGVzZWMuZGUvY3J0L1RlbGVTZWNfQnVzaW5l
c3NfQ0FfMS5jcnQwgZsGCCsGAQUFBzAChoGObGRhcDovL2xkYXAuc2JjYS50ZWxlc2VjLmRl
L2NuPVRlbGVTZWMlMjBCdXNpbmVzcyUyMENBJTIwMSxvdT1ULVN5c3RlbXMlMjBUcnVzdCUy
MENlbnRlcixvPVQtU3lzdGVtcyUyMEludGVybmF0aW9uYWwlMjBHbWJILGM9ZGU/Y0FDZXJ0
aWZpY2F0ZTCBlAYDVR0RBIGMMIGJgQ9mc0BnaWdhY29kZXMuZGWBG2ZhYmlhbi5zdGVsemVy
QGdpZ2Fjb2Rlcy5kZYEPZnNAY2FtcG9pbnQubmV0gRtmYWJpYW4uc3RlbHplckBjYW1wb2lu
dC5uZXSgKwYKKwYBBAGCNxQCA6AdDBtmYWJpYW4uc3RlbHplckBjYW1wb2ludC5uZXQwDQYJ
KoZIhvcNAQELBQADggEBAKhFKqWHnQ+41OcsXr/96UBOGPo5B8NT4FZy1o6QY5NVicS+y2Kz
8pOoeJbhg4nCc9FdSfYvPp6z1KboYSGusM5NNto4qdWqWDZ/+25lWrlMYsCtxKyD9Smtsu/7
uwikJ5NO8rOP08JoznvwWZ2INq+sRyJ57zwNoNVs/65v3xyYyrC+BFOAGIg3B3J1Jw2wmoM8
lDsnoGUjh7R9FstuY2CK29RaVCO2w35Vvd9cwqQzOVURq0t+2MGh0RItXH7450gfR7RZVoYG
vNTXsR6/3RzcM+YbYZMBCQuAH4ibFmIw3TjdShpjQiAfc+cCPNSbnrenvzhgKcEH4ZiOz4cS
RdQxggPMMIIDyAIBATCBiTB1MQswCQYDVQQGEwJERTElMCMGA1UEChMcVC1TeXN0ZW1zIElu
dGVybmF0aW9uYWwgR21iSDEfMB0GA1UECxMWVC1TeXN0ZW1zIFRydXN0IENlbnRlcjEeMBwG
A1UEAxMVVGVsZVNlYyBCdXNpbmVzcyBDQSAxAhAqp7PRsu4afyT/7mD0WSQnMA0GCWCGSAFl
AwQCAQUAoIICEzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0y
MTA3MDYxMTIzMzNaMC8GCSqGSIb3DQEJBDEiBCC8OiMdsH4nALjEA9weCbU1E4N5zsh53rSE
3vhbSJ88EjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqG
SIb3DQMCAgEoMIGaBgkrBgEEAYI3EAQxgYwwgYkwdTELMAkGA1UEBhMCREUxJTAjBgNVBAoT
HFQtU3lzdGVtcyBJbnRlcm5hdGlvbmFsIEdtYkgxHzAdBgNVBAsTFlQtU3lzdGVtcyBUcnVz
dCBDZW50ZXIxHjAcBgNVBAMTFVRlbGVTZWMgQnVzaW5lc3MgQ0EgMQIQGcQYOJIYjQ3VtN/u
upEfjDCBnAYLKoZIhvcNAQkQAgsxgYyggYkwdTELMAkGA1UEBhMCREUxJTAjBgNVBAoTHFQt
U3lzdGVtcyBJbnRlcm5hdGlvbmFsIEdtYkgxHzAdBgNVBAsTFlQtU3lzdGVtcyBUcnVzdCBD
ZW50ZXIxHjAcBgNVBAMTFVRlbGVTZWMgQnVzaW5lc3MgQ0EgMQIQGcQYOJIYjQ3VtN/uupEf
jDANBgkqhkiG9w0BAQEFAASCAQAoMEysuBnpK6Z6VcqJeSLewtsSmsw7I4NFnvEF3x6qLcfo
PU9FFYEalE/3J7r7DTdGcnySTnSqzdmEfwsnsXkFazbyrEesQ6TID8wIM3sMnADF4Wch4KS2
pL4r/JZEYHJWaJ6wTbvZShR35xI7U1aceAViywxvurWaeRsnfdsCRuwRnz/KszhcWbBaFm8M
oMLIlnZtke+ugKfXPPW0FX/byGaVNdQQZOvpWo4KIDo94WLnNKBt++TN0RpgZ9cVu24lHy7Y
DvQsWy20ib5bdMoNlA2ylB2STNek4YeCQr7CfLJaORo0AR6/da4V/jZNJ37irNp1j38WL5Nu
MyNVL5qBAAAAAAAA

--------------ms020402090403070300090509--
