Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1F9C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 09:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356459AbhLBJex (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 04:34:53 -0500
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:64502
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240976AbhLBJew (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 04:34:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7EhfK6JgZNeAOM8po6Dy8lr+iskELdZD5sa/S1OeFMRJyQokdo61vTceSO1hio8mULmMSv0q7+dgCo+cla7zXfaIc1ZjIUhgX8svye7Xc2QpuHkU+0eZAHZlT7JA7Cjpm9HpPLC0FGP/d10lhj9eSAeerWBinETQOZJ0N5aohT4K+G8xCDjAcVHpFFciv3JCEN2+L4w6BOpjAwKCMWeNpsh3XjXU3KoPv+PoKU9snJEHq5EFFr4AWRm33M7FJ6jC1z3DzM/7o+iFrMosx04so9jMLn95/tds0o0Du+QC60hch050jhKZZ9hs4KAEA0eLC29O5SieSJM4AUeNZesZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6ecR43tZzOyDK7RZWttLp/oNwcxYhnfP3JMJdAeBzk=;
 b=jJUutOBbNBlAGv6W3w3++JAAQH/FmZidioTMFmiPKbOSXx6Ht1cksKdfiCf4PXMWKTCzIkRYVVmV66ciygu9t20NabFS8Vhlu1GVFn6JK81CF8abc7Co4eByj3vh11y4cxoqutQwD6bfbN6rOinZKAKs/HhLY7GqU0QpPk3D2RQyaHg/P5P0Pw0OI8q5zDn59Tn3VW5yDnySYzIwoCteee0R+I35/+G///nTp7Uv/LICbvMfx87q2VFZVGGaxw8S4OhqedE6HSP3p5kEu5CTJw60M/c9mQZgJRonxZYOHvuXPNbT+GIwtKB54YLJ7AV0UA7b3YLPrWdH+dUSvgTMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6ecR43tZzOyDK7RZWttLp/oNwcxYhnfP3JMJdAeBzk=;
 b=E3h639b5jUeWVpioJBjEFrTHRo+PnlzSFDkDsm+GUUml4ZxaDxWbZebXsmxgwDgSdW+kGA09fiZcA6pF//5R3r3f6GhF/+DxPqnfAxyQINLLs9rzA7xIWLsJA3vj7Xq8RdvRve7t4Ds/jJMc6heoHho1PW74B908i7CzV44kND4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 09:31:28 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 2 Dec 2021
 09:31:28 +0000
Date:   Thu, 2 Dec 2021 10:31:26 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 7/7] ssh signing: verify ssh-keygen in test prereq
Message-ID: <20211202093126.nuuvxjnhbkdu5pwn@fs>
References: <20211117093529.13953-1-fs@gigacodes.de>
 <20211130141112.78193-1-fs@gigacodes.de>
 <20211130141112.78193-8-fs@gigacodes.de>
 <xmqqczmfyi44.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqczmfyi44.fsf@gitster.g>
X-ClientProxiedBy: AS8PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::10) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8PR04CA0065.eurprd04.prod.outlook.com (2603:10a6:20b:313::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Thu, 2 Dec 2021 09:31:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 142bc1fc-98ac-4331-76c8-08d9b5768426
X-MS-TrafficTypeDiagnostic: PR3PR10MB3834:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3834134CE477679F1C6C0C16B6699@PR3PR10MB3834.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRagpCuZIljljEDRV0Z0w5jF2FTBlCENpyEpHHtStDclbL5CGACqn+Cn69r78d6jOhN7JblzxWhxGivXKyNJ2z445g+JCjcLEsHl+ozg1mt9W/s+dZ6jqqPFxw8PBgrJovgzsAMQZBgMMHrg9n8PWZmC5FXvMZKL9qEWZFjtVyfgmQNoe4YgRZR9ldAZcjL5lhTsBi4chuw9tIWyRXuIvPsT4TMAzlQ3PwGparMaISxb49tRWHE+I6QgQWwSLgQv8igNqyGq42QEGa5lur0Wy/KpFeNNGQx0w+GcNNgdVh8FhwJKVfaWwlTiTi+zYj026Wu74/9XfCIHWmDvwVQjfaetBxYVIzOQBxkQLNpiKFpxhPP0+VU3BndGAXb048yrSc4gMg7yehKFtoPRa93MczWDgjAB3KchTTbhKoBY0xZbppGXwWfSwLyl6nDLI9ltqA35Uez50v2iUfdEllW6MQu05Ef9zHImQNgDm3F3Fz8sEaAA7v5cW11un8KrYOHoo81ywHmNTaioq1v+jf2/Fc7OH9nUApKBy0eE2ocMTDGUevkuJzhruxrfYfo2j5bUnUc8qmKWsHRDpQLERA2Yqs50dVo1ErVXRAY7Tc9T6WkpEdSjKC/NwnYpJBL3HNK/63fZ9N2hDp31OYQVcSkWlCpF1FneZki8r9GCykwcs4wp+w6RcJ+Y/XNr/SNBOqrhTm4GipwkPFVJcv5T2rW2WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(346002)(376002)(39830400003)(366004)(396003)(2906002)(6486002)(5660300002)(15650500001)(6916009)(1076003)(38100700002)(66556008)(66476007)(508600001)(6496006)(83380400001)(8936002)(9686003)(4326008)(4001150100001)(66946007)(186003)(316002)(8676002)(33716001)(86362001)(53546011)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDF2T0cremdJUHMxTnRaaEdJeC9GK09WY3RGQ2NIWEhST0JhYzZOenBMNTJG?=
 =?utf-8?B?N2hqdTU5L3lVUjlQdHFzRmtrZ1FYNHBOcVlTK28zWnRPd1BkSElGL0hJRllj?=
 =?utf-8?B?RGJpQTNnL1Zka3hvdnRmUTlSdHBqdEpwMnNqenlWb2lKTitaSWNIQTljZXpX?=
 =?utf-8?B?TFM1Mk1RNmhETld6RVY1TmxyT05hUEFvdC9YUHZiM25kVms2bFFzS1hjNmJu?=
 =?utf-8?B?V2VxMklnWVlyMlJZR1hrVUg5MngxMysva0pRdE5LMlh4RG1Dd2EzNlZUUk51?=
 =?utf-8?B?eHFBcXFCSW1WY0Z1WFIrazRnVHg0L1Y1UndqSEhFN25lQ0p3WnRiWlpTZmRh?=
 =?utf-8?B?Wmk1dk5wQldFeXhGV3MwRDVpWkREc1Y0V3dGNit1bnpXWmFQWmRqZ0cwRVhU?=
 =?utf-8?B?RXlBOWs3TTIwTitjUVlOK0owbDZkYU1SSmdvQ3RDQU9GbWVnL3p3ZEs3L2pl?=
 =?utf-8?B?UTQyellpSThqOGRGdzgxMUNDMTRza1oxeExIUjJncFhENzZoRnVjcklCbHFE?=
 =?utf-8?B?Ym4rRnlKZ1VyWHIreVBlV081UUtreHpjVUg1UnVpaHJ6aTZMLzNYZU9uVUJ0?=
 =?utf-8?B?Z0FVZ2dxeVJWQW9HK2g4eWRSYjVBbTQ3c1h2RDdpNmdaQWpPdWRtaTdGOUtG?=
 =?utf-8?B?L1F0SmxqNXptNHBuQ2plZS9ETVhTallYSGlNN1phWEJoaU1hRlphaTQ4Qit4?=
 =?utf-8?B?NmM3ZTh1NnFKdEZBL3pKVWNaZWxERGhnclpxVitYQWxobEVTdVlyUndRaHkv?=
 =?utf-8?B?RWhRWVpoMWYxT21iSkJjSzNXZzV5MGdINDY0YWRpWjVrWktLdjZGTWxaL0dT?=
 =?utf-8?B?QVd3ZTd2SWJ0aE0vc3BrQU5hR0VRbFk2S3c5bGRQdlpla1hES2FUZ1ZObEJY?=
 =?utf-8?B?aUM3Q1hjZXpxZ2VYRUpPekVUczRLRlJkTVAzTDJKdkY2VlBzOUpQYUVncnpz?=
 =?utf-8?B?Rk9FUUIvT09KT2thaHJocU1QSzBibFVsb0w1SklXck1sOWpqSGoxSnZObHV6?=
 =?utf-8?B?dzFDNkJXR2M2M0FSR3pjazQwaHRXcUdHNWVSZTYxUUFsbU5LY1R4RnkxLzd0?=
 =?utf-8?B?blUzai9RUUwvQ2NTL0g0QWFMeEVBZW1Vd3VoVmRXMk9iOW10K21TQWRTS0Yw?=
 =?utf-8?B?QjRXZENadTNvaVduNHF2NFpEY05wTVdRbWpqZHZ5TUdpYU9JbnN3MSszZlRZ?=
 =?utf-8?B?dERqeEtmNWt2ZlpFS01XOGdzVEI2Zk1IWEh4VFlhRDBHUmQzNzRXd1ZramJF?=
 =?utf-8?B?bDlSbkI2OEVZY09XYXgvNVhUMHhyTEwwdWorSVRWRkVBb1dXa3dyWUh6Y0Vh?=
 =?utf-8?B?R0hUSGNVMGh4QWZ0TlFxVGllR05RR0VQbVdNa2N0MU02Z2luS05STFFEc1hI?=
 =?utf-8?B?K1Q1SktzK1YxQ1ExY20za0h5dHBEVVhlZHkvbnpsdzI1UzkvdUFKUkxKakoz?=
 =?utf-8?B?RlhjaDRSZXVmMlRXNUoxdVMxYktYeUFVaEV6ZWJTWHJjVE1BS3FYak1CS3lQ?=
 =?utf-8?B?Z0JsZ1N0YkFYYWZyVlZVZXFydTlNYmw1MTYydGFYVHZvM0VrZFN5VytQR2V4?=
 =?utf-8?B?bHhnc2xISkM4c3FLVDNCMWdGaEw5dS9qVEdlR1hkU0xtYUlXTEQ2TGkxaXEw?=
 =?utf-8?B?RFhpazlwNnBPUit3dDZSSHNZNjRORTNMUXZyeTJZczZHMmJnbys3QytZbWhv?=
 =?utf-8?B?OWx6QkJ5QVR5UndkakhLZ0V4WktzRDhEL3dxTmYxOHVpekQyNFRxNzVhRkpY?=
 =?utf-8?B?VDlOL25ZVVNGd2VTc1pxMmdxZU1WZkFZUit4NGlGYXpVK2xZS3hyRGNheEJS?=
 =?utf-8?B?MEw3NkFleE5KTW1aNzUvSEdqUzZPNzFXY28vRVc3Ly80YTdMWUllczFLRHZv?=
 =?utf-8?B?LzRHakFieDg3dmxYS1hyQU9KREs3L2U0cHUreUh2Z2ZhM2o5eUljaVE4eTdU?=
 =?utf-8?B?bm9tbmJ0YXRQWFZaU0VtTmYwbFlpeU45YTE2R2lUcUV2SldRNlZGaDdjSXlX?=
 =?utf-8?B?R1N5LzZoemFlRi9YU3hUdEJ3Y3BrbDJnbktjVXh1YzN6YzhaMUhBaEhOUmto?=
 =?utf-8?B?eXhyZ3VBZldGekJReWcwU3dLOE5QNVh1enpMNXlsTTgrZml2dy9NR3FlcWNa?=
 =?utf-8?B?c2l3dFR5VEVtcHRyTTJUVVhlZlF3djZwK2ZnZjNnb3YxNXVSYURjNVFyWWND?=
 =?utf-8?B?bUpyODQ2enpPRFd1RlJrK1RNTThUbVpRRTVqbWJyQnBpUVBhSC9WT2pMQmhz?=
 =?utf-8?B?eTFZNkVORjNiNmZVWGwzWE9HR3FtbThRWUNUY0c0SitrdFRPQU96dkNrSjdy?=
 =?utf-8?B?R0swaGFNRU5JMEt6SUFnTDFqM3BMOEY2KzY1b3YwMmxNZkZwcllEUT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 142bc1fc-98ac-4331-76c8-08d9b5768426
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 09:31:27.8921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBwKOtFBkbTox+Ca16vtVQKdCDP+ABvq3PmU8P+LpFXC9V9EKR0X601e94jwia55gEbW2fr9k0+PWqnp0NOdmGfdIl9wK7e/FHz0KnFQdaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3834
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01.12.2021 16:18, Junio C Hamano wrote:
>Fabian Stelzer <fs@gigacodes.de> writes:
>
>> Do a full ssh signing, find-principals and verify operation in the test
>> prereq's to make sure ssh-keygen works as expected. Only generating the
>> keys and verifying its presence is not sufficient in some situations.
>> One example was ssh-keygen creating unusable ssh keys in cygwin because
>> of unsafe default permissions for the key files. The other a broken
>> openssh 8.7 that segfaulted on any find-principals operation. This
>> extended prereq check avoids future test breakages in case ssh-keygen or
>> any environment behaviour changes.
>>
>> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
>> ---
>
>The way keys are set-up has become much easier to follow.
>
>This unfortunately interacts with the old way of adding a test key
>done in <20211119150707.3924636-2-fs@gigacodes.de> 350a2518 (ssh
>signing: support non ssh-* keytypes, 2021-11-19)
>
>Here is my attempt (which is in 'seen') to resolve the inevitable
>merge conflicts between the topics.

Yes, that looks good. In this case the conflict is rather trivial, but how 
could i prevent this / make it easier for you to merge these?
Especially since in this case the conflict only arose after a reroll when 
both topics were already in seen. For a new topic i can of course make them 
as "on top of XXX". Should I in the future rebase the "support non ssh-* 
keytypes" topic on top of this series and mark it as such? Or whats a good 
way to deal with things like this? (besides avoiding merge conflicts 
altogether :D)

Thanks

>
>Thanks.
>
>commit fa6c2973744b419c95b5eaf6a697c795ab7823fa
>Merge: 2a8505f6a0 3b4b5a793a
>Author: Junio C Hamano <gitster@pobox.com>
>Date:   Wed Dec 1 16:01:54 2021 -0800
>
>    Merge branch 'fs/ssh-signing-other-keytypes' into jch
>
>    * fs/ssh-signing-other-keytypes:
>      ssh signing: make sign/amend test more resilient
>      ssh signing: support non ssh-* keytypes
>
>diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
>index ff944f0548..3e7ee1386a 100644
>--- a/t/lib-gpg.sh
>+++ b/t/lib-gpg.sh
>@@ -117,13 +117,14 @@ test_lazy_prereq GPGSSH '
> 	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_PRIMARY}" >/dev/null &&
> 	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GPGSSH_KEY_SECONDARY}" >/dev/null &&
> 	ssh-keygen -t ed25519 -N "${GPGSSH_KEY_PASSPHRASE}" -C "git ed25519 encrypted key" -f "${GPGSSH_KEY_WITH_PASSPHRASE}" >/dev/null &&
>-<<<<<<< 2a8505f6a0 (Merge branch 'fs/ssh-signing-key-lifetime' into jch)
>+	ssh-keygen -t ecdsa -N "" -f "${GPGSSH_KEY_ECDSA}" >/dev/null &&
> 	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null &&
>
> 	cat >"${GPGSSH_ALLOWED_SIGNERS}" <<-EOF &&
> 	"principal with number 1" $(cat "${GPGSSH_KEY_PRIMARY}.pub")"
> 	"principal with number 2" $(cat "${GPGSSH_KEY_SECONDARY}.pub")"
> 	"principal with number 3" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")"
>+	"principal with number 4" $(cat "${GPGSSH_KEY_ECDSA}.pub")"
> 	EOF
>
> 	# Verify if at least one key and ssh-keygen works as expected
>@@ -166,15 +167,6 @@ test_lazy_prereq GPGSSH_VERIFYTIME '
> 	echo "testpayload" |
> 	ssh-keygen -Y sign -n "git" -f "${GPGSSH_KEY_EXPIRED}" >gpgssh_verifytime_prereq.sig &&
> 	! (ssh-keygen -Y verify -n "git" -f "${GPGSSH_ALLOWED_SIGNERS}" -I "principal with expired key" -s gpgssh_verifytime_prereq.sig)
>-||||||| cd3e606211
>-	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
>-	ssh-keygen -t ed25519 -N "" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
>-=======
>-	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
>-	ssh-keygen -t ecdsa -N "" -f "${GPGSSH_KEY_ECDSA}" >/dev/null
>-	echo "\"principal with number 4\" $(cat "${GPGSSH_KEY_ECDSA}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
>-	ssh-keygen -t ed25519 -N "" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
>->>>>>>> 3b4b5a793a (ssh signing: make sign/amend test more resilient)
> '
>
> sanitize_pgp() {
