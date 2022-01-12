Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31B4C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353073AbiALMKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:10:49 -0500
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:30343
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240575AbiALMKs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:10:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUt/sMtyJHtE1AG0Bf7nOrQbofKUmf1jv/+atPRp9RJg6HMP2EV/LUsqLMs/IYowDjVZ5gDIYO2YTBTjmtG/PvDYKciDZI78tvsQsw4hgj/6797knA5rct7ES5xw6EaYfR1kGa2bNbgRzEx1w5GlgJDic4n10RxKhStlJzIF7vrKfgIQdY1gAXIfGEMEZrQxygHgZYxuhqDS5/9HRX9ykawYPDi1KQmKsESWBbNQVzqHMpiqi/wQgNrfFmUDU1Uvl262uqbyWK9fbuMLKP8pfPi8Ro0DNH6YDaU1xRFDVCZqBluMDc0NUcfgauIA5DqecEgMt6AxwF6x6+C79X6mmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frSyMFniBV1ndWHCibxk9eDZFiSjbydvorP1woBRp9Q=;
 b=S1YdmQNnXyTjMl2V7KCbHjGzKINo0D6nd5fBu5/yeDAI5zBr4OMrWtDdZM90r4c2Tt4SVymlI8lpB5ouglshP3ed5Ml9Ff0F1aQsY4tWp8t54aN67tZPT5epboEJveHFhlem5h72Wdk7qG4rTNl5l1H1x4rFft78S9wgBHmakm7zVKYg+fk/z8jPc51tjRNl5D6ESvM05RDCUYI4aU3sM9nA/WJJF85HVFMMGpDDppJu3KTPidjWOdwDRY5c91Du47yiT5QVfeOaD6Ae1pYxMJmXlRylp1vB4IoGsWZsQPN0EfzrfdAqqf15VOHfq1NlRTQldZjf0AQJUHHLCVjNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frSyMFniBV1ndWHCibxk9eDZFiSjbydvorP1woBRp9Q=;
 b=hkIkHmp0D55LQwXPE9KhdxeMtTvR8B9Cdsl7/bmhL9PVMQu89bh6musZJHPfMcT1+5pUlsS57c2b5JNBiTUq9Ll/mEb08OYzs/ZYa5hIFach4I0nW7DFRsuJ7uWfiJAGDDTXaKzCo1TMjZOrI5fk3PHvfTKjIk2VyCJTfTMavgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB5088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:217::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 12:10:46 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%5]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 12:10:46 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: [PATCH v2] t/gpg: simplify test for unknown key
Date:   Wed, 12 Jan 2022 13:07:57 +0100
Message-Id: <20220112120757.874714-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107091432.581225-1-fs@gigacodes.de>
References: <20220107091432.581225-1-fs@gigacodes.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::35) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1be7dca6-8bab-48d3-96fe-08d9d5c4903b
X-MS-TrafficTypeDiagnostic: PAXPR10MB5088:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB5088B6008E776535E95BD243B6529@PAXPR10MB5088.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lw4SxMsnRq04nxcH9Z488iAPVosRFTJTGUtgv7fvp8yZlu6BCR5foL6qwvSeIw5Wpjcik2xgvVdXoO6XNlahBghWlohRXWfzdT1rTlIiPHQ3KhGwpC8s4x5xw0ZG7eicyRPJYvTQuWmGr79MQotq27P+sMuFMe03WR6ug/Pk2qTaxVvQLCJ7IOn4mwRqhBbSVI+U+TLWju93geS9ccJakCU2UP2gaUT4GcW3c2qsBpQ41bHqnKRC3yLBuT+SyXqY3pqk5SvjR8oAhg01Be/i/3qidp4ATCu38TUpuyANajCRCc6Kz/huTjnjcE7k+a1fDxdgac04wo6mFlQMnqk1Yy7roNKHnF4JD6JG8vstgGp8I0eraYOVdX2DSvfrg9kDlSzPu1VkuHyEVgJG9QpQ11kWSCbvbR2EPu2IE4efSS6egwlzP2RfE1Zsghs/Nfyzy45BvojCdROWZWVUPHPJfPqWYMirGWgdP+1yBEsIF3zetGns9IgIUX/N+uuudgpAken5JiIlM/XocCnnHymwVbfJab1ovIKOmeeKm86XNwwwhgsWiUcD0PHJJVMBEDETO9s8n+RCAe+oUn1dYaJ5JRrnqIGPqd/KhlvGCeUDcCPVTIYc0l+kDCU6kLdWeEYpo2luWpSb3t0vY19Fz125NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39840400004)(186003)(6916009)(6486002)(8676002)(2906002)(8936002)(66556008)(66476007)(66946007)(6506007)(2616005)(7416002)(86362001)(4326008)(1076003)(66574015)(54906003)(508600001)(83380400001)(5660300002)(316002)(6512007)(6666004)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3YxQmtHWmljZC93bFVycStjN1A4NzRlN3c1QXZZeStUMVhlVWhJYzZYVU92?=
 =?utf-8?B?d3g3Wm5tZkQrRkdBd3cwRTFKUXJ6enRKVVF4WlR1aUdHNUhqMW9pSHM1bnJK?=
 =?utf-8?B?NVJiOWlDa3R6TGR4eHBROVhZdGhYNFBTUFhTY2NnVGRROStMYk1HSWJScHls?=
 =?utf-8?B?OU9MamhtM1VLZFBqVzd4Qm1ObUxVbXFQRk8yZ0dLSlcyUUpMYmlDYWpqdVpJ?=
 =?utf-8?B?OHA0UkZWeE1vdGxLMVR3ZGtlZmUyVVoxSVAzRVFqOUF6VXF6Qi9NaTdSMnQ2?=
 =?utf-8?B?WUhGTmczZTA2VnlRUFZyeU9NRVhYMlhXZ21YWFZyUUs3TjFnQ0I0djJtZ3RL?=
 =?utf-8?B?NkIyRnJVbFFqZGtPMEJpcmlqSEN3K3gxemIzVnVMWDhhM0VQU0w4Y1RleC8r?=
 =?utf-8?B?VnR0Q2Nidm9zS3poUDA1SVNCZ1ZMWDUwMXA1TUt0QVQ3WkY1eFBJV2ozMFVm?=
 =?utf-8?B?WlkvTXFiWHpqdG8yNFNJaDJOUzhZYUtVVTUxZDEzNUZhSTBZTHNGMi81Smdi?=
 =?utf-8?B?QzN3NTRMd2VGVkI4Tm9POCs2YjVCTzhGNGJXWjl3bks3b0VjcUF5YmxRQmRm?=
 =?utf-8?B?emhMaVVDaGQ3YzRYeHd6LzJOUDY1QlQ3Q3dlY0lDdVplVVhZeDNIZGd4VWR5?=
 =?utf-8?B?UGFMcWM1dE1aZmJEd2NNbzVkNlJ4NTFqdnVNZGVmWFFoQi83dERIOVVaeUUx?=
 =?utf-8?B?ZFV6WHlwMHlzaXVDbkFSczRsUUFKZHZGV2NyblQ1TjdkTFZlS3ZaeTlzcjFj?=
 =?utf-8?B?Slh5WlNUY0JDNFRmK29TV2xNU21OanlFWkJjQTR3OEttVGhWN2dnSFk5QmIv?=
 =?utf-8?B?MS9CVzhwSXkxQjFHb1hmTHB6dHk2dndyMm5LUHc4UUNaRTBPV3FZUW9hMXlR?=
 =?utf-8?B?Q3VycEZTUUhIalJQLzQwMURnYXIrWFJrTzdMVVhNYlR4UXhiclZJanlJcy9k?=
 =?utf-8?B?K3VURitPcU8rZVRHbE8yL0hiWmN2ZVN0V2lvRlJTSGloM1Z6ZUJwc1VsWU9K?=
 =?utf-8?B?VTRZc0xJc1A2UXhxc1ZQK1UyamdRTFNNZGlZUlE4SGpoRkRmTkl6S3IyckRP?=
 =?utf-8?B?ZTRsbEVlcUlDZStNZXNyNFo3RXBzSlJxWFprL0pzTXNZL3daMHUzYnVDanlD?=
 =?utf-8?B?TjZpdU5JV1hZcUtITlkzWFJjcjlucXdLR1pnMmNqZzVvU1RZcnFLS2lSN1Vv?=
 =?utf-8?B?V1hoc0RaQkZsbzFOcis1T01aUE10T0QrcWRuVzJIb3FPUmswNkxsODdOd0Yy?=
 =?utf-8?B?eTk3cmE0OTJiMWlESWx4Vk9kRExab3c1eHQ2VkFETkI1QUI2RFlVbmdWNDJU?=
 =?utf-8?B?ck5ERWdnSnRHMGgzb2ZmRU9Ga09vRWpGTjhKYnRwdjE0WGRSRmVNRHorVk0y?=
 =?utf-8?B?UzA0aXlPYjFKUjIvN3p0UjZJQ1ByVTlTbDlOYXZPNFppRXpHVzNFNk9tcmtM?=
 =?utf-8?B?TlZEMjlBVHM3ckNiTlJPRktwTUVUKy9sRk1xMG5TVWpmRzJZTTNYeHNrNkMv?=
 =?utf-8?B?ME1ReHJxUExTU05lczdqYmpzUHJlMS95WjEwcWF5Mk1RK0FRNi9Yd3cwWldM?=
 =?utf-8?B?WFRnMWpydW1iei9jR2ZLS0pxNiszTEN0QW9HNWZHdm5pUkdvOUc4a3QxRmdQ?=
 =?utf-8?B?YnhabndibXFSQnR3UHU2emNoUTZmKzFNQ2NjTnh6enpXc0Uva2Y5YjYvSTcy?=
 =?utf-8?B?S1JlR1JjRGRmY20wNGY4Yy9YQWJQTFMvR1hFSGdwREJ2ZWlSYWdpQ0hFbDhG?=
 =?utf-8?B?Y1B2cUN1TGFNcW1tVVJacWc5Y3M3RW0ycmUwTUlBUm4yZW5jcUsrNVEyblph?=
 =?utf-8?B?Y1phRmtGZkVvNkdhL1lJRmVDVkQxbmhjWGxvb3hWQWg5dUd0WmJkS0FjTGpx?=
 =?utf-8?B?QXZzR1N0dWw3K09OTFcwd2pZWUs5dzVMWWhRcE5FQTJlOWtMeUhqaHdEeHRm?=
 =?utf-8?B?QTdNMHBLY3RQRzcvVytWWVV3TnVZQkVMczBmVURZQ1BHY1NiSVZUZXlCalp2?=
 =?utf-8?B?akNwaW4zNTlsRUt1c3VEQjRNaXJxclc0b1c3WHF0TWpIMmlIZGZwT2F4Ym1L?=
 =?utf-8?B?T0hkd0ZpTjdBWWNKWVNmb1RmU0d4RWg2cWNMdVNsMVFUZk53KzVsWEQralpu?=
 =?utf-8?B?Z05EdktHYzF1RE0vemtQR1NiYnJ4ZmpoZndnKzJodldzUHNHcnNKWVplWkxa?=
 =?utf-8?B?cHkySTZXdHpVbENRUFRmTFRWS0tIcXlocmpsT3h2R2dIRi9DNmhHeExHRjNI?=
 =?utf-8?B?bjZjTDN3NHpEZWdTQW1yL2tZcFN6bkZ0V0h2aTZnUGZMaTg4N2E4VktmMlZj?=
 =?utf-8?B?NjE1Q28xVGszOVpBVFZ3VmJIYWJNZE9wcEJzYXRCeTZXVG5VRmFaUDZnTnlR?=
 =?utf-8?Q?iJn/w7yLDyvSxhgo=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be7dca6-8bab-48d3-96fe-08d9d5c4903b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 12:10:46.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28f/n9990QzUZ09SeWe5UqWfdnw6wSCpeV0azTGeo33MbUviMqqhvZRNYLcKo/ZMCV5bpWkH/RLiFXfLPuAFc+/EKwSmTkkV9BuEpwocCoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5088
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To test for a key that is completely unknown to the keyring we need one
to sign the commit with. This was done by generating a new key and not
add it into the keyring. To avoid the key generation overhead and
problems where GPG did hang in CI during it, switch GNUPGHOME to the
empty $GNUPGHOME_NOT_USED instead, therefore making all used keys unknown 
for this single `verify-commit` call.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/t7510-signed-commit.sh | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 9882b69ae2..8593b7e3cb 100755
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
+	test_must_fail env GNUPGHOME="$GNUPGHOME_NOT_USED" git verify-commit initial 2>actual &&
 	! grep "Good signature from" actual &&
 	! grep "BAD signature from" actual &&
 	grep -q -F -e "No public key" -e "public key not found" actual
-- 
2.34.1

