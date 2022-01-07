Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ACBC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 09:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346405AbiAGJOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 04:14:39 -0500
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:28642
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346421AbiAGJOh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 04:14:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIPrKErII1gvV5i+PLAONB+0IdSlkOAGCbm6M4rQCfG0TSh8TiHXvAErj9Vkh5iqzHQ35X4EAYnrrt751zRBYWdlhnkBqPCXxxpZxn2a9Ry+waHc8vLpnI14Wy5etQrqC41DpT4rHKo4cOjqeBYrmBFciecKb+ao2Q3rlq8A7M8/FB0+G4pV+kiJ8r0g9U905qZdTlj1NWblMM07t4rq319WfKncO7PiQiad3ywwUG5JrkZjFyjRd1uKOGDpqcQfBGSV5MARBfdD9A3SvW+OgfzxcTB7b5Np4BUE4kWEU+xnVxmbgwxXpC43GTQKNFQd89qC+TMllbVs2IRQDRQYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNyFQ5Nfmg0AbpA4CKJ1g09ikpLnHpy4ZpE0pCwDKW8=;
 b=m2jSwIbkyINRa+//i8NnAdaKjL1KWeDoYRX1O++BGo3Wi1a0jDkNg06FhcbscBk5Rynu9CBrOd4az6/Of7p1m+fKTKreHoHLNFeocXAgGx0MR3LH8nnVx/YDKn3mbrOO+3OkXBy+geF35yzcU8DML4pR+Sr/F6N3Hsq2O8sMAaATsBohRt8MBUGvlp6bw6Pqw7Y9dSlcvlrdt91mZpa73WLZzoAcgbDGjl2ywEAOw2+evdzcAaMw/khL16l1dd/zs14CQMpAEcY6s2dlCfnAlMk9f6cH6FWybvKiAFUqIfZKdtEOjqroNvJIS4XdroeE5w4JufV5PHtAtz7QD1kAYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNyFQ5Nfmg0AbpA4CKJ1g09ikpLnHpy4ZpE0pCwDKW8=;
 b=fYLjzOEpXp14ee1/CL5phxacIBTGMPlIGQH0FIz+0alTP+c+QKhYEg52pe7f7ZEKdbMsilwgsAs2uSx7+zn0QYOgMwSj062e2BLbU4IXHegyW0ZEKw5c3BKuCcyr1Vyn5zOfRhPcgpaKMJLvDVhGm8hGOKY+sZt7VSJTzSZkoR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4078.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 7 Jan
 2022 09:14:35 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 09:14:34 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] t/gpg: simplify test for unknown key
Date:   Fri,  7 Jan 2022 10:14:32 +0100
Message-Id: <20220107091432.581225-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.33.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0202.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::27) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8a88ec0-7f72-4a6c-c193-08d9d1be1f40
X-MS-TrafficTypeDiagnostic: PR3PR10MB4078:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB40789A9D3F6C328848103D63B64D9@PR3PR10MB4078.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vskm1EM/qrKkCKwdVQRIg1I2qg2IplzN2snNwnJO2f23dermmFS5uqzUdY6ZM0v3RY9jFPxsq7Of0FzLt6UYL9HpUI9+g4rtP5Cldlob/Cgztk/ZBfXplCypLfCcVvyB3Dj8jxYFbsU5I28A62xYdKk6Q4b7Y87SQYy7aETMWiTDvrCrIuoStuo6YefZ+db2TvbOOy42wMC4rJdafMjt/votP164G2JvjoBkWXHJdN2era6BRpvOVi5wsg79O+Jf6TRktIdHYWC4LIPea4xAiQLpjMvuUSjG/TUa30x5sj4XENdhLjlf7u3qHfZdM6j0ZZUt1on8+eVkblYXXvFAdzYYIB8qcP0F4K0PYl7F9MkB10rV4USUs9zUH9fGXfcC9niW86uMVqRYtJQ1VmaeeW8a/wZWpGFQVYs7KOOAi5zASM2RmxtQJ5tgrn92RuIJ8jRakMJVVMBh1RRZz2DOopXlusqpi1GwmJjAWqnNWKBfeyjUeLoURXcKS+0yGccTAVcYYxkBz+ktt04QaXpi2/jfoTAHTXyVU5gBp/2Sv74LIPqkocmHn/3Rsn0bn6Hp1bXKJeSGkvm8tBlVezecGx6pgcFR+qLflJ4Y2pV3KfeeT1Ctr1Qk0FghBhU/7VuHYxIvxWsknqsEzmPkKCCLJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(136003)(396003)(366004)(376002)(346002)(83380400001)(86362001)(2906002)(2616005)(66574015)(38100700002)(316002)(6916009)(4326008)(54906003)(8936002)(8676002)(6486002)(66476007)(66556008)(1076003)(508600001)(66946007)(36756003)(186003)(6506007)(26005)(5660300002)(7416002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVY4QVM1a1BWWm9MbFo0cHl2a1RSbFREWEJaZ3U1VlYzNmpLajV5L3JRWW9W?=
 =?utf-8?B?UEJ3SkNtdi9CeUEzQklLbEE4bHVUQXpFeC9jaFNEWVhncGVzcFlKaW9icm5a?=
 =?utf-8?B?WUc0RTdmcHkrbkZkZ1RISURhemRKV0pMNjRuSmxTRUMrenRncHVtS2pjRitt?=
 =?utf-8?B?Nnp3SklDNHhpSDhyWUVZNFBvTEVRWkFUK3RRMzUxclQ0ZTljdzUweS81bU01?=
 =?utf-8?B?dXZ2U1czY0ZXb3JvMkNKREhqVElOQkFha2RYT1pIbHFZY1NZaUxuYzF2UVdC?=
 =?utf-8?B?MXNId2dlL1dDUElhSmM4Vkl4ekE3dGFVTUNOcWtxd2xEbGtVY3JDS1JicVQx?=
 =?utf-8?B?dEZGUGg5QXJ4OVB4TmtLQ3RKQVpBYU1LNUtWcmppcUFBdXlKVk5kSnl0dXIr?=
 =?utf-8?B?QVllVjZRS0NIMTFrMVIvdy8rVW5SRU1Zd0V4dFoycy9sT0J6d2puR1NBL3Bs?=
 =?utf-8?B?N3JwcTVwV0dpMFhFZ1dYN2h6V3NUelZjdDA1QTU3K2QwbnBhSHo5ejd1Vll1?=
 =?utf-8?B?amZNcm9pRlFteERuMW02bW1Fb1VreXo3NnVuUC9YbzRyelJNdjNPNmlyeUI1?=
 =?utf-8?B?dE5mdXI1bjNwZ0l0L2x6R1J2VjdKdFFqcTRBWEY4VVpZTGhKTk84MlhoSElK?=
 =?utf-8?B?U21OQ0hBUGFaNjBxRlZqNHQvck1HTVkwUkI2amdWMkJ5MFYwc0k3RTNVNFZB?=
 =?utf-8?B?dzNNVXBka3ZSQzJuNEdlenFERk5ZdlRVQ242WWpaYlNOTHczaGNSZXBIMStP?=
 =?utf-8?B?S0taSUNvZHMwUm8xb3R6dENJalJXenNuRndFZXRuQXlGQVZpMndqc1ArWW1S?=
 =?utf-8?B?U0VCMTA1dUp0Rm9BbDRNb0xTemJMQXF0QVQ4MElBcXAxbVBVSlNXSk9Eam8y?=
 =?utf-8?B?Y3JJQU1oWmtYWWl3LzZUZlQ2L2ErYjkya0I2K0ZWV29BU3JzK3FlK1dSVUF3?=
 =?utf-8?B?Zjc0REdtZG04bHNQN2NBOTdJdGFEZGpaQUZtSTk4bzUwdzAyQWJ3RjdXTkpp?=
 =?utf-8?B?cGlYSFdiMkpRQnM5cnoyZExqV1NYdkdVMU1OUEUvRjY4b2N0ZVU2ajZNeGhw?=
 =?utf-8?B?VVdBWElXYlBlMmNkRjVEUWQ2bFF4T3ZCMEtvcGlJdU1ObjJkQVBDb210Nmpp?=
 =?utf-8?B?akhZYWtlbTV3T1JqUmpicXpOMytQZXptTEY3MkJEaVBPeU5KOC9EaVU5azJu?=
 =?utf-8?B?RXRrOVFOTUR3TjA2RFJpak8xMHhMYjZ2N2p2WHlYYkFaNVcwMEtHSHNIMU5r?=
 =?utf-8?B?RCtFQ0JDcy93anlSVFN6Qk1JTTFZb1FoSXkxblN3a0F5cDVXN3JZaE1Id240?=
 =?utf-8?B?aXpzZDIyS3RiM3BwYm01U1Y5NXl4cUdpN1R4d3c1VVpmWUdQWitqbStGd1NT?=
 =?utf-8?B?anhGaG5xQ0h6N0pRU01RUDNHVzB4dVVQNmFMamtBbE9VUU40U09aRW16ZzVC?=
 =?utf-8?B?ZFlLQVZvRmJCVUo3WFJ4cEMrT0VwS1ljVDlqQitON2kvSVE4RGFnTElURE5S?=
 =?utf-8?B?WjFnS00yc0ZLWmlGODVFa2xpQVd4T05xc2lCakh4UktyY1lpMGplYlEyM0hO?=
 =?utf-8?B?cGhtdG56RU8zLzc1Sng4QWlwS2Vaa0xPOXNrditpU1pJOVhwK3NWOC8xU3ZF?=
 =?utf-8?B?T2VRUHlNV1ExQnBCb25pSitTdlpUSmJkWU4xcTFxZVNXUmdaL1gzTzV1bnBx?=
 =?utf-8?B?R3c5ekpmMXhuZUhtRlJNV0N1MStCUWM2UlpqT3VFN0tyUE93ZWVmdnQ2NkRM?=
 =?utf-8?B?WkVyYmdhVUlTTjQ4S0FXQnU0emdHdUZ5VWRHbE1CYTlTb01VRDQvKzgrTEIy?=
 =?utf-8?B?clJwMFZ3TzRzUlZGZ2JSM05ScjByaU11WGJWR0JOUEx3b0k2UGhZdUhUOGRh?=
 =?utf-8?B?RFF3YXJDZ21LMDZyblgwdUY4Syt2bUhpSnUxVVZkaWFDSmQyVHEyL1hzeFNl?=
 =?utf-8?B?NGs0Z0ZJVTFKUGlGZ0tvQ1k5ZkVEODJaTTBJTWN2VzBQODZRZnNVV2xoSkdD?=
 =?utf-8?B?bHNxKytndVRXVGVoNDQ2QlV4bnUyVWVkOVBKcWFRK05PQUMzZDk3M1NQN2hD?=
 =?utf-8?B?WStzcHhnMHJWaUc1UWk2YVpReURtMGpaMUZkQ0pEWVBIa3R6QktNTXFBOUJQ?=
 =?utf-8?B?R2VNYWcrRFNuZ2dMQkl1MDl2S2NZdjdCcktqdFp1YnJnU3R2WUtiRGFtVTh5?=
 =?utf-8?B?RDFIUTA5UTM4MkJ5ZkorV3l6S2FDOXFUSlI3bEtobWFMdVlHRllPZ2dpY2ow?=
 =?utf-8?Q?x+NsGxxG4Bh0Cao3odN5TrvHe3PYwfN+fDmvKlkt8U=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a88ec0-7f72-4a6c-c193-08d9d1be1f40
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 09:14:34.9227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GprrjoF9KfC5kkjs2PQb/Hub0GzeBN6ebr+lP+NVzY5gDFPddD0oE4OKxBn7E9dvqSsIzAdyEGlgJWF7PnW2q9owVH6u5p5YIpjNXflSuDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4078
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To test for a key that is completely unknown to the keyring we need one
to sign the commit with. This was done by generating a new key and not
add it into the keyring. To avoid the key generation overhead and
problems where GPG did hang in CI during it, switch GNUPGHOME to an
empty directory instead, therefore making all used keys unknown for this
single `verify-commit` call.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
This was reported by Ævar in <211222.86ilvhpbl0.gmgdl@evledraar.gmail.com>.
Just using an empty keyring / gpg homedir should achieve the same effect and 
keeps the stress of generating a gpg key out of the CI.


 t/t7510-signed-commit.sh | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

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
-- 
2.33.1

