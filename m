Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD83C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 08:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhLII4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:56:47 -0500
Received: from mail-am6eur05on2089.outbound.protection.outlook.com ([40.107.22.89]:26977
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235299AbhLII4l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 03:56:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKAkvHejO2D3CUDK033eh+q6npRZbA8XdB/UOrbAU8WaDy4OczP4xt3fIPbBj5RkVPNISx/7DtksUsS12BhfYL2L+aqdTBGfzCWw7BomOJzsZEbTWtW3bdp5QcFRg6FuTyVWKbliwLbWyg82mbl4Zfh/8EpPshf61DoM7hE7kEJtdyGmyw6jsg5cuBniRPKPAbMqEvcq8Tv9xKbBM1pdPDBOhk2eKUjDcAEuWAkTAXY246qQHy/SIrf2SGKX4zsySmkWou4apyupjlOijbRaJPM+1vC5YqLRqoBuYzYy/Shl4IXfCn4wVPJ+lk1EjIyYFWKHpOxYkFOZpBJzhYwJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GJazhYhjfKBtvvh1iR5lBPvTFZKmn7Fey6rbc/EDBE=;
 b=Nnw05n85fgw9+efBvN9GWL4oI2fzUPhYatmGTLLxrZStMNASnGJ3m3yO6khesmtFlO/rb9+HHxz4BY820LEsllvtjkwg09yzUVYwkRfDLhkkVuCTx46q6y0D3Ke333NO4TFsnsq2Tk0L9ha9TXoUCmrHGvHKyMuGsqKQo6gefNT7Fpeu2wVrkSZv1Q0+/FLagqKj6zcRLddpJ6B37ym0S2d/z8xiTze3Fljxgq8qhz7FnQ1oFLAnTfILsQ4+Zw0ZvJAFhYs9WjQ2dDEHfBBc1e9A+goQJQadsxzj8XaHGJWKqSfthepYFzowuTAj3YwboCMm5GNaODUfx4wIztFRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GJazhYhjfKBtvvh1iR5lBPvTFZKmn7Fey6rbc/EDBE=;
 b=XPXgI04aZIYYXboarAL5tWdt6j0NXCcuNybZiKz74K/mVV+E9ITX/FxK/4ra8iAMycYmlRhU8hS/UEkgmkOZMCjF6+oByxwsvJg54ZQlYGi0r3ndt0fikCrLe53IzOvWej52HUyYRpamte8hLMWAEDQoD6lA37kz9FtilybDqhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 08:53:01 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 9 Dec 2021
 08:53:01 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v6 9/9] ssh signing: verify ssh-keygen in test prereq
Date:   Thu,  9 Dec 2021 09:52:49 +0100
Message-Id: <20211209085249.13587-10-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209085249.13587-1-fs@gigacodes.de>
References: <20211208163335.1231795-1-fs@gigacodes.de>
 <20211209085249.13587-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR04CA0046.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::23) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AM6PR04CA0046.eurprd04.prod.outlook.com (2603:10a6:20b:f0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Thu, 9 Dec 2021 08:53:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 062156fd-4241-4c7a-41d8-08d9baf14e14
X-MS-TrafficTypeDiagnostic: PR3PR10MB4110:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB41107DD89786D663581940B6B6709@PR3PR10MB4110.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppq9MsDrU9V6TNdp7HY3AYdvxs4uUT3EUyBJBg8ATQWmZa/cUS5uTmQvHWtiuH0rRX931nERR2s2O6CKLf1qvowEv7Fw0hTwX+3ZwAnj5Na9jPyOzDRWTquW1eDTQvcxAkFqH5qfpuAIorbRmfuGFBYQWy1OLpICvH9stpmBZSH3Kz87iaEM+SsHuzgG2z9rAcvVXdfSvJofRqNqRv9WG1TJAM4i034wfUwQf5sDyz7fJC8EMYynsHnbVODusnl1ya4px3kCRMqRw1Yq3OM9UsKlPNfSV6tr4mcHNw/AUfPwv4reo+iwgQjWcAuAppaJWuzN3SrLCYzfOysJaUY6GyTk3fLkn61uctCkDGNIT9H4/wKpnCDAFRPYtCqFa1O+lxI/SlPj4YyAICUSew6RONZyhpjMNjUGuiazOgdHp7wtpluqe+FeIgNV1d0N+GzawzPOiKt4Mxgez+ucLTEu0pqqorcxiG0ojeuDNsyjX/gbzZnxa90ilrJqX9X/7IkTxhQgVDOM+I8r/40czplDQSyQko12TvKCw2oQvkdrTEldobPZ78jmvbU4wKPJ6RKBzsST/4Yzfxmwe6h2kZK0l+wTIxWBhtTerr/nXIwwbr/+rMcn9BY9o62+Lty6R/qBh8fsh+zLOSeg+iTzkk4i/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39840400004)(366004)(86362001)(15650500001)(36756003)(8676002)(54906003)(8936002)(316002)(6916009)(6496006)(6486002)(508600001)(66946007)(66556008)(66476007)(186003)(4326008)(2616005)(107886003)(2906002)(1076003)(6666004)(83380400001)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I4tj4LMCtvf6Lron4bXEca3igoVgHNqpSGKjKt+5X67FEo2H290AIFy9Mnpg?=
 =?us-ascii?Q?8lTyqqdgm0SnXHskv5zbXhHAbzfxxCHSMdot7lpqvrpDVLlOlKtukKU6nsiX?=
 =?us-ascii?Q?LhuSHZySyu3HXjteXQ3UrJtLcNkCeqetoGArou7J34ScXsLX19u90wdiCbLT?=
 =?us-ascii?Q?4jpzLqhb4QgcKZqHmbPVnPlYITxVEfTgqjmoQ5bcI1zXmRdODqTJq2ZK/MNF?=
 =?us-ascii?Q?5cUKhl/Idno59ziUhLIsDyXi7HEb5kn8ldBCjLPun7KkU9XGqdTtQ6JSrai2?=
 =?us-ascii?Q?zIobM84l1/77z6OSjSLD7VUgGxmTea95Y6t+fP3KM1lGhcHblHKF/Pim8INq?=
 =?us-ascii?Q?JeZ80imUKfaOasBVa+V/7GVkKxmqY1Q63b6pvTwNdsUCYO/1cWwS8SnG9JmV?=
 =?us-ascii?Q?UzwXlCdneqIenIywjRn9J8+jKjv4voMaWn/9Mw2ICWLXUUS+eHd21wrBkp82?=
 =?us-ascii?Q?C1hni4J24Cp87IuGjYaKXZLfbRv73/ZOcSbqV5lsm2qOlOF9jZk2Z/O4WnCE?=
 =?us-ascii?Q?Zsc1qLIFeRuVqv+JjMEQXMt3sA6Ulc1OR/3w2QCfgKGQ+KHUKhiYzBlUBfnh?=
 =?us-ascii?Q?lBrMN3bz+kqeztmzF/RoMdmVj1jjYDF3iWEdxEMm2zoeef0dM/Jrf1oZddoD?=
 =?us-ascii?Q?mMElpFPxRYg1VtqFQFAKtfnmrWT5dagciZSV4FDwi6FpZfhvFY9tMG1phszy?=
 =?us-ascii?Q?kxAh5oAIIzoJcRe2zRrZe3n9xuPXLqCDV5ONNLL5PLZU6tUnt0NLW+PtrV5d?=
 =?us-ascii?Q?lCuB9RuG24lqCr0/wWktdMYChadcFMbKrnrmoJVpHBWfRvl3IuOU/obB4MJS?=
 =?us-ascii?Q?TWy6lPOkrpMkEZD/CEwc0xtaeePaEuvHrn5cPL5LksJBtzn2eGH/GFCtRe9h?=
 =?us-ascii?Q?zVRSt3xkGUNTjTtmjFjil9gKSYZMMTQ7ALYiE7y82R81sRTSaSWDjtUzRd2C?=
 =?us-ascii?Q?3wI+t1ScTluhnR/XK0U8ImfScbFDVhWkqwIzgJZUCyp9G7PGd1rUwrKxP2eT?=
 =?us-ascii?Q?EWltjpDYUJ/foHU6RzkIzi+LfEPxGGV8u9KYVG2gUdnbTqlFzqvutEFeFHTa?=
 =?us-ascii?Q?CILAg4C9xmUbw6DrBSHxZO+Uj4oXqFlWOQrRcnlAxRnKYtQdILQytzM17JD0?=
 =?us-ascii?Q?PbeSkhVLn6BmgVE/07z9LL7CqI/1UdeZelT3PabS5cxZqiHMDikV6x6ebSEO?=
 =?us-ascii?Q?aFRahUfGxknVUNOEHuL8zheMoox0qeHSvVdx0w3ZzKSt+OXy6VLezrI65z+z?=
 =?us-ascii?Q?NWOJF+i1EkABJnXtESmpcLoHebxULOtkkpuQWQZkGZROz09m7Oa+tqy2JN7u?=
 =?us-ascii?Q?5PYWv3/E+eI+eI/19Rag2fb10hr78JERf26ppRXhzQMruHPVgYV25hb5Qrir?=
 =?us-ascii?Q?z1u7eMoDZWzETULNjW4S4j5qvbSOjyOhQeeT20rMiVRaj5U+lqnANuF3f8IA?=
 =?us-ascii?Q?NZjuNA5k5TOYUlTFijOcvSN0xt7Erbq1KX9NyAZKfuitwn/uyQfbHwWw1aBE?=
 =?us-ascii?Q?jdYW1raSHpnnO1Vllfueh8SHBJAPDIGa1F9fc76G3IEP0e0Ldhg5SwOKyzR4?=
 =?us-ascii?Q?ZC2E4jzsh0TVTQ14CJsML3YNEidmtPzyV8gDxrPg47ecpgDEYmNn+nz9GddQ?=
 =?us-ascii?Q?FbTtTodSx76K4szB2O6MTDHlSnJHZBwjS9iwbJ9d/XZ2prGjGuVs0duEc6xX?=
 =?us-ascii?Q?Df4VHvQjFUknA3CqFa5Jvj6UQOTu1kiOqMMsy3IRRFa6/vIJBIvcWIMRhU3z?=
 =?us-ascii?Q?rW+WmFdHs/Bu/4HVoou9yJFt4hss6YU=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 062156fd-4241-4c7a-41d8-08d9baf14e14
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:53:01.0546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZ5cXf0l3NkynA4DXX9cv1lWTfykz/aoPq4dQRshlGQVNyz+H1jacexmEiskBRUewwW7p7/SuIpCY9gKCvTyK4F9B9GeEJLM9tkqrujAWQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4110
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do a full ssh signing, find-principals and verify operation in the test
prereq's to make sure ssh-keygen works as expected. Only generating the
keys and verifying its presence is not sufficient in some situations.
One example was ssh-keygen creating unusable ssh keys in cygwin because
of unsafe default permissions for the key files. The other a broken
openssh 8.7 that segfaulted on any find-principals operation. This
extended prereq check avoids future test breakages in case ssh-keygen or
any environment behaviour changes.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/lib-gpg.sh | 53 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index fc03c8f89b..3fadfcb306 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -109,34 +109,61 @@ test_lazy_prereq GPGSSH '
 	echo $ssh_version | grep -q "find-principals:missing signature file"
 	test $? = 0 || exit 1;
 
-	# some broken versions of ssh-keygen segfault on find-principals;
-	# avoid testing with them.
-	ssh-keygen -Y find-principals -f /dev/null -s /dev/null
-	test $? = 139 && exit 1
-
+	# Setup some keys and an allowed signers file
 	mkdir -p "${GNUPGHOME}" &&
 	chmod 0700 "${GNUPGHOME}" &&
 	(setfacl -k "${GNUPGHOME}" 2>/dev/null || true) &&
 	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_PRIMARY}" >/dev/null &&
-	echo "\"principal with number 1\" $(cat "${GPGSSH_KEY_PRIMARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GPGSSH_KEY_SECONDARY}" >/dev/null &&
-	echo "\"principal with number 2\" $(cat "${GPGSSH_KEY_SECONDARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t ed25519 -N "${GPGSSH_KEY_PASSPHRASE}" -C "git ed25519 encrypted key" -f "${GPGSSH_KEY_WITH_PASSPHRASE}" >/dev/null &&
-	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
-	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
+	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null &&
+
+	cat >"${GPGSSH_ALLOWED_SIGNERS}" <<-EOF &&
+	"principal with number 1" $(cat "${GPGSSH_KEY_PRIMARY}.pub")"
+	"principal with number 2" $(cat "${GPGSSH_KEY_SECONDARY}.pub")"
+	"principal with number 3" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")"
+	EOF
+
+	# Verify if at least one key and ssh-keygen works as expected
+	echo "testpayload" |
+	ssh-keygen -Y sign -n "git" -f "${GPGSSH_KEY_PRIMARY}" >gpgssh_prereq.sig &&
+	ssh-keygen -Y find-principals -f "${GPGSSH_ALLOWED_SIGNERS}" -s gpgssh_prereq.sig &&
+	echo "testpayload" |
+	ssh-keygen -Y verify -n "git" -f "${GPGSSH_ALLOWED_SIGNERS}" -I "principal with number 1" -s gpgssh_prereq.sig
 '
 
 test_lazy_prereq GPGSSH_VERIFYTIME '
 	# Check if ssh-keygen has a verify-time option by passing an invalid date to it
 	ssh-keygen -Overify-time=INVALID -Y check-novalidate -s doesnotmatter 2>&1 | grep -q -F "Invalid \"verify-time\"" &&
+
+	# Set up keys with key lifetimes
 	ssh-keygen -t ed25519 -N "" -C "timeboxed valid key" -f "${GPGSSH_KEY_TIMEBOXEDVALID}" >/dev/null &&
-	echo "\"timeboxed valid key\" valid-after=\"20050407000000\",valid-before=\"200504100000\" $(cat "${GPGSSH_KEY_TIMEBOXEDVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	key_valid=$(cat "${GPGSSH_KEY_TIMEBOXEDVALID}.pub") &&
 	ssh-keygen -t ed25519 -N "" -C "timeboxed invalid key" -f "${GPGSSH_KEY_TIMEBOXEDINVALID}" >/dev/null &&
-	echo "\"timeboxed invalid key\" valid-after=\"20050401000000\",valid-before=\"20050402000000\" $(cat "${GPGSSH_KEY_TIMEBOXEDINVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	key_invalid=$(cat "${GPGSSH_KEY_TIMEBOXEDINVALID}.pub") &&
 	ssh-keygen -t ed25519 -N "" -C "expired key" -f "${GPGSSH_KEY_EXPIRED}" >/dev/null &&
-	echo "\"principal with expired key\" valid-before=\"20000101000000\" $(cat "${GPGSSH_KEY_EXPIRED}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	key_expired=$(cat "${GPGSSH_KEY_EXPIRED}.pub") &&
 	ssh-keygen -t ed25519 -N "" -C "not yet valid key" -f "${GPGSSH_KEY_NOTYETVALID}" >/dev/null &&
-	echo "\"principal with not yet valid key\" valid-after=\"29990101000000\" $(cat "${GPGSSH_KEY_NOTYETVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}"
+	key_notyetvalid=$(cat "${GPGSSH_KEY_NOTYETVALID}.pub") &&
+
+	# Timestamps outside of test_tick span
+	ts2005a=20050401000000 ts2005b=200504020000 &&
+	# Timestamps within test_tick span
+	ts2005c=20050407000000 ts2005d=200504100000 &&
+	# Definitely not yet valid / expired timestamps
+	ts2000=20000101000000 ts2999=29990101000000 &&
+
+	cat >>"${GPGSSH_ALLOWED_SIGNERS}" <<-EOF &&
+	"timeboxed valid key" valid-after="$ts2005c",valid-before="$ts2005d" $key_valid"
+	"timeboxed invalid key" valid-after="$ts2005a",valid-before="$ts2005b" $key_invalid"
+	"principal with expired key" valid-before="$ts2000" $key_expired"
+	"principal with not yet valid key" valid-after="$ts2999" $key_notyetvalid"
+	EOF
+
+	# and verify ssh-keygen verifies the key lifetime
+	echo "testpayload" |
+	ssh-keygen -Y sign -n "git" -f "${GPGSSH_KEY_EXPIRED}" >gpgssh_verifytime_prereq.sig &&
+	! (ssh-keygen -Y verify -n "git" -f "${GPGSSH_ALLOWED_SIGNERS}" -I "principal with expired key" -s gpgssh_verifytime_prereq.sig)
 '
 
 sanitize_pgp() {
-- 
2.31.1

