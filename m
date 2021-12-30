Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED76C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 11:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbhL3LKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 06:10:42 -0500
Received: from mail-db8eur05on2046.outbound.protection.outlook.com ([40.107.20.46]:61561
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235057AbhL3LKl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 06:10:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHa0jbrgFaTWVbcClON0OVBpGc7vcILk6YN3nZgTdnPeO/n3yvkyD26NirHbiNIluAJZRNMt1YoTG2RMERixVKGFKsgFmClQKyTE78vsNLofEExeOK+ChgHhSV00fkAPwZho7lyjLJ15L2z/H8+UB6YpEglI7pHMiKCtTr778lfNuFPYUnbZ2N2r0X7dQbsZgskYl1tmibi/1SeYA9OkrRziNPU2QBv82l7e6viwPQu25zC5a0pH+EzsP7UZGiA/XCOvu7tFH3tWsYpQqFceS0oXAeuEm9Q8twHkbgdVe7ykmojajxHBMeO4oq9XLsZOXwLAXmrMfx0aKNq0D0AOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKlo90zIKl1tUmZWIK8vdb6257cEUT0bsS8NRIfU8YE=;
 b=mrrIFfoUNQ8+e1AuS8sRJafbtl3KujOhmjKqkFQzm1YBBLyHXU++6rZ6Tm5e6AB8nDWUeFzuXv5vQWH5NPNUVKmyYb6hSu6qZ3X5YeYhFT94RUyZ+g8dAv9/O/KTZa6KXZISCd9Jll054hIQ4G1IP9pmWp60nIH00/k7o9u6qRFpbvzSWBRHiUPOzd4h+Fi6rd+flXlVwyhworz4/0IIcpXnpFKHdZ0WMkZ5ObaYLjmJxTEchdMma2IxK84/OHd8XHaFaWVLZxgVwW/KMUsvaBd0qZWWOxVd1MGARw5kianelXT5ysOrKZ0jg4s15jAWbVTxIL7DWn/Arrg18nmg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKlo90zIKl1tUmZWIK8vdb6257cEUT0bsS8NRIfU8YE=;
 b=ifubV/GLWQxn9Stm3dWdOYYkBgbOfEoKf6FX3FZbm9zEsnIdvzvk0vPNpUEIRZW7ckfylXvsupLhoIqp7qkuNfILFcAJjXDgn6pkKZv8W1TwyLXkM4cu9YMLJnMBGoMfZU7x2M3nIV2xq43x3DdjcGU/E6GTo5mJ1tncJ6+EATM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4223.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 30 Dec
 2021 11:10:39 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4823.023; Thu, 30 Dec 2021
 11:10:39 +0000
Date:   Thu, 30 Dec 2021 12:10:38 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: t7510-signed-commit.sh hangs on old gpg, regression in
 1bfb57f642d (was: [PATCH v8 9/9] ssh signing: test that gpg fails for
 unknown keys)
Message-ID: <20211230111038.jtoqytdhkilv2732@fs>
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
 <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
 <07afb94ed8336d4ca9de7078d7a6c02b1db8a908.1631304462.git.gitgitgadget@gmail.com>
 <211222.86ilvhpbl0.gmgdl@evledraar.gmail.com>
 <20211222101326.fwl3wphr3ev6c7wt@fs>
 <211227.86h7avezrv.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211227.86h7avezrv.gmgdl@evledraar.gmail.com>
X-ClientProxiedBy: AS8PR07CA0005.eurprd07.prod.outlook.com
 (2603:10a6:20b:451::32) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d10a53e-53fc-41cb-1583-08d9cb850336
X-MS-TrafficTypeDiagnostic: PR3PR10MB4223:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4223C21203A6C6E33CB5258CB6459@PR3PR10MB4223.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWkq9ACjvQUOoT8W382SuXv/XAyCDzXXsCtK4mJsg/KxeOjefOFU+kBoVBUKzBB3eo9MW2wCWjLEis9bBhpmhqN1clWzWOvp6i4TzrHDrXf+DZcB4IjBe7EwSzHv1zgPyx+8Gq63SnKH8qHxgVPsnzd06xx7aEMb0LUOeDfmnczVgOGM0TW1Xjc8AdOF/DgcOthmB41EGk7lKxu4yXICcFnQRKFCM/AGwnjjcq4BsuM9bXeZ25+dKNB3yU7XBxGeIkZzkDLta3KDkj5OfTgJZxlPBZGxDcGycIcMbg4w7pa3sfT7DrEjdxhmVykLvvKOVOXqfG5rOOBPdtZntt52EtBpILClUCazEXexBzKsw7PS3upLput/WihGr+5p6SwJARUIEdkMdElSjLxLy5iPegE72vuJRVFhi7E+YdHf8YWjbGxhtcWRatJp1sosu+/b+UJI1w9t72kqzB0BtdHNi2kGeBHRW6wLqxcMctSabx282ztJ2IcxAD7yaWIiUXgR7+PagyFI/yl4UCtJTAYSySB0QwvP4Uo4/S6EnJBkK+Q4MheGvP9BhtuuVd0FLtkC9jIqdFN3rqIm/YpdGKh5TcbQkacjdFEY7u6CYjaAaoKIleFuJBFq4YjnD7b9a6enCpTceGOgxWbzc0QAQW/ftw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(396003)(39830400003)(346002)(376002)(366004)(8676002)(8936002)(83380400001)(38100700002)(186003)(54906003)(2906002)(66574015)(53546011)(6506007)(6512007)(1076003)(66476007)(66946007)(9686003)(316002)(66556008)(6916009)(33716001)(6486002)(508600001)(4326008)(7416002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRDMnJMYm1jMVNKalA3NWp1RTRwaWE5Q0xUc0pNNVRrRGQzZTE2UWJ6clZx?=
 =?utf-8?B?ZDByQkE2eVE4cTNmeDdZQnFWczRQTDZqbkZYV2JTaWZvaVBKMDdQZisybnpW?=
 =?utf-8?B?V0dxSGNqaFVQVmd1VG1Eb0ZMeitzY0xWaG1LcEtlWHhtWURKZWduSWg0NmhW?=
 =?utf-8?B?c042ZDVIWWJ6YlJONUdSczA1bFczKzZuTlo1QmdRcXozeDlDUTRSMEt0VWIz?=
 =?utf-8?B?SlBQT0J4bzgybG1pWkRLb1BRbmpYcERHR1B2Tmw3bHR4N3NVaHVBQzZ4c1BP?=
 =?utf-8?B?WWZzOTEyZEZYSUVLVnd2cmJ5REYvUE9laWZwNVg3dGtsTDFrRWZnYU9XRVVF?=
 =?utf-8?B?dWJPaEdYbGRWMzVRcFZtR0hxZnE4RmJvTWdmdVlDR0lpRUJ0NE1TeFgrWVR0?=
 =?utf-8?B?ZlRtYURBZDlWYS84Qk80b3JjWllydHdrdXdXMThJN09qUS93RjZHakhRam9C?=
 =?utf-8?B?WWZJUU1wd2w1aThuelp2RXllQjhGNEJ4WWJGLzdjdFR1c1lRMXZuLzBTYnBX?=
 =?utf-8?B?UmRSbVh4V1NSMVdVWHBtRVJSM0VsQnI3a0ZEVWRSTjR4T1BsRDBPdjlWRGl1?=
 =?utf-8?B?T2swNWdKUW9mU3hpeFpmUkd6dWdRMGRBR21RdSt4aEt4ZG9QSEtSQlRBMHhW?=
 =?utf-8?B?NVREc0NnTWJuZWYwMmRXbHYzb2N3aUxqb2ZTUzQra2hpYm56UGQxNDZEZ0tY?=
 =?utf-8?B?N0p3OHpLL2x4SldYWWZ4UGFLbk9zSmxYMGVLUkswNkY0ajVwTndLcXI2emRU?=
 =?utf-8?B?UjA0eTVsRE4vSUdoeHBMdVhuUTVyRkQzZ2l1RkowSythdTNIMWNtUWx0T01O?=
 =?utf-8?B?YXJWaVVnT0huQmJMdkpBUi9zYnptZXYrSXBuOXFyS3J3eGo0d2hOaG1WdXpE?=
 =?utf-8?B?blg2OHMweEExUXRrcXRTd3J3bC9iMExSaHVvemsvZENxM3BmRktHZjNNRW1W?=
 =?utf-8?B?eGFxZWZMT1ZGeFEzOUpoZkZITlZNcjJqNnRBMlNHZzQzV2lia0VJZFJMY2VY?=
 =?utf-8?B?ZHBQYTVUSVk2UDc1d1dxYmR6UFpZMGFTMXlNS0VaVG9Vc2NQNmNZSkxjdGtp?=
 =?utf-8?B?dEFCby96Yzd0bnh5WTZRZWd6MnhITzhNTE42MUFVYm5pTUJVNlhYOFNyTHVn?=
 =?utf-8?B?eEF4bGEyaXZSZ05yVk5XWUNjK3AxN3RmaVhwcGdHRkRnTzhFMCt4WkFJR2ty?=
 =?utf-8?B?YkpDNlkrTTlhWlVVSWpsejh1WTJVY00xYTlKeEVEaXd0VDZrODlDcVNuay9R?=
 =?utf-8?B?Y3QrN3V1cmZ0c2xWRzFGZUMvYmNZWWVMTFNsWmNkZ0U0Yi9BVVZyL2k5SHdw?=
 =?utf-8?B?cmRJM2lNdzA0ZDNFSFBpUkRodmJ6T0hVbzVnRldHMUdaYkpTdE9iMUlXRWla?=
 =?utf-8?B?VEJKM3gxWGhmWENBK1V1aWdVVElvMzZyOHBiajNlVDFNaC9BbFd3S2haUmZG?=
 =?utf-8?B?bG9laVV6Z1l5YWpCOTFDTi8zQ2lQTDR3RFkwcXNmY3ZXY2VablpWT1NsTmlv?=
 =?utf-8?B?eEJxRzZLejM3OFNEK1VoMEtHZVhYb0xici9VdXZTNlJocXR5SmZMUForc042?=
 =?utf-8?B?ak4zWjJLMzk5WWwzYnQwSG9NcWtERzBNLy90cGtCOTd2ZjJDdGJzYW03VG9Y?=
 =?utf-8?B?d0RGQS9SdzRLd2xTdWdSaGhYN0NTMVR6U05DUEZ4cjM4K3ROclRlSnRYUGVJ?=
 =?utf-8?B?U3I5WmZ0MUV6SmpNY2pBc1VGV0VWNzBRTFdDaXBxT0FGcGIxR0FTMDVvcHNP?=
 =?utf-8?B?dlNjaEdrNTh5cnZ0bWRvdzVtUU5BZnRPRzVjalVrUStGSGE2c2dSUnlyUHlm?=
 =?utf-8?B?R093aFdZYmRLdFcrM2JYMUF1T2t6VnRLbzB3Qk5zZFdrakk3azF2WS9FMFVB?=
 =?utf-8?B?OE9sVy9XVWExTEg3ZWpsOHdDbXRQRmlCaWZhUU15TW1OVTJtcFVRTzcyUS9u?=
 =?utf-8?B?QmRJeGo2NWp6Rnd1cnlPKzFNMHdxZ21WeEhJaG1MZ0VBaCtEVlVPaXNja2hD?=
 =?utf-8?B?L1ZmWkhtaGVOM0ZyL2dDMXUvUnVYNWFOcXBBd1gxV2RmZFZWb0hGWXc3UnAr?=
 =?utf-8?B?QWk1djhNVVE3Q2huSWZUcGlFU1I0ajNqT2VCejhZTjVhM3NibTFQVFdnL0NS?=
 =?utf-8?B?SENwQTVOVWtqVWRSSjh5cy94a3A3cjRrMUhXT0g4NDJOdDYxeGc4UmZ3NjJR?=
 =?utf-8?B?aXJ4R3N5US9QMGpoYlhoUzJkK2RRdWw5UnB0aCs2b0ZjTDRpZVJBMFpybjl2?=
 =?utf-8?B?ZlpxTGI2WXhpNGgyWmJYNkZwUWIzSG1wSUJMMDFYSEtYZlJQZFpkMy91NzZa?=
 =?utf-8?B?UHRpSHptaldDRDRKQmZEYkk2TnpUZzlzamZpL2UwSzNLREhrdUsxQT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d10a53e-53fc-41cb-1583-08d9cb850336
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2021 11:10:39.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RDOxmQmRbT4lA5eTDm6qo+eksD7cRHW7Bmb63oBxYXYK7PoQeKVUMbZamXUOSUhL4/T9Bo0KmsIUbtsCExFKdr4MOWupMVveB8RJHr3we8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4223
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26.12.2021 23:53, Ævar Arnfjörð Bjarmason wrote:
>>
>> Hm. I have an identical centos 7.9 installation (same
>> versions/features) and the key is generated without issues. Does the
>> VM maybe have not enough entropy for generating a gpg key?
>> Otherwise we could of course pre-generate the key and commit it. I'm
>> usually not a fan of this since over time it can become unclear how it
>> was generated or if the committed version still matches what would be
>> generated today.
>> But of course I don't want to slow down CI with rsa key generation stuff :/
>> If missing entropy is the problem, then maybe CI could benefit from
>> something like haveged in general (other tests might want more entropy
>> too).
>
>Late reply. It's not a VM, but yes. I've confirmed that it's due to
>/dev/random hanging.
>
>I don't understand why we need to generate a key at all.

You are right, we don't need to. I initially toyed with the GPG commands to 
disable/export/reimport a key but without success (I'm not terribly familiar 
with GPG though). 

>
>It looks like your 1bfb57f642d (ssh signing: test that gpg fails for
>unknown keys, 2021-09-10) is just trying to test the case where we sign
>with a key, and then don't have that key anymore.
>

It tests verifying a commit for which the key is not in our keyring at all.  
All the other tests only use present keys (with varying trust levels) or 
completely unsigned commits for the failure check. 

I think we could do the following though and simply point git to an empty 
keyring to be able to verify this:

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 9882b69ae2..2d38580847 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -71,25 +71,7 @@ test_expect_success GPG 'create signed commits' '
  	git tag eleventh-signed $(cat oid) &&
  	echo 12 | git commit-tree --gpg-sign=B7227189 HEAD^{tree} >oid &&
  	test_line_count = 1 oid &&
-	git tag twelfth-signed-alt $(cat oid) &&
-
-	cat >keydetails <<-\EOF &&
-	Key-Type: RSA
-	Key-Length: 2048
-	Subkey-Type: RSA
-	Subkey-Length: 2048
-	Name-Real: Unknown User
-	Name-Email: unknown@git.com
-	Expire-Date: 0
-	%no-ask-passphrase
-	%no-protection
-	EOF
-	gpg --batch --gen-key keydetails &&
-	echo 13 >file && git commit -a -S"unknown@git.com" -m thirteenth &&
-	git tag thirteenth-signed &&
-	DELETE_FINGERPRINT=$(gpg -K --with-colons --fingerprint --batch unknown@git.com | grep "^fpr" | head -n 1 | awk -F ":" "{print \$10;}") &&
-	gpg --batch --yes --delete-secret-keys $DELETE_FINGERPRINT &&
-	gpg --batch --yes --delete-keys unknown@git.com
+	git tag twelfth-signed-alt $(cat oid)
  '
  
  test_expect_success GPG 'verify and show signatures' '
@@ -129,7 +111,7 @@ test_expect_success GPG 'verify and show signatures' '
  '
  
  test_expect_success GPG 'verify-commit exits failure on unknown signature' '
-	test_must_fail git verify-commit thirteenth-signed 2>actual &&
+	GNUPGHOME=./empty_home test_must_fail git verify-commit initial 2>actual &&
  	! grep "Good signature from" actual &&
  	! grep "BAD signature from" actual &&
  	grep -q -F -e "No public key" -e "public key not found" actual


