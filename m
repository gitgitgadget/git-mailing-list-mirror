Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381CCC433FE
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CAD06108D
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhJVPMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 11:12:49 -0400
Received: from mail-ve1eur02hn2210.outbound.protection.outlook.com ([52.100.10.210]:57385
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233391AbhJVPMh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 11:12:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy87/TjM6eBlpwmy9KdDMN1QhMGzZap30iSbmytr7xZgQzRYe4c+SW8LFe53mz4xy9oU/JKAK3noh6h9OBIqFKVliSWqOry2voA+b84eN/kHz9BeBGnLKdfmBum75S4GluQmy2R4H7qJm6eSStZwv21NN4KtjnvxmlxnOtHjUsf6V5hmqxbswPCFPIabpb1tKQALLCpKD0vQP4kybQYHc+mRWVrUsC6BC8slXGNNlHmm3npN6+dF1FcH9eK6E4H0JjhLE2GCvwT3kcJAbs4qevjQLH8NhQJMA1PVVSAAIj/p6x4sLulfmvFmjr0610k/NkLXZmHazjoopf7j0vBZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9w/WM8vXUvBA0xdK5pzeG8DhS9as02TitdPOdQYk6o=;
 b=SneZvJ+TtE03U1oHlP0elrD+DxANwzHyRzFszZ79HpCdPuIUFQ2wQZb+j6l7J7v51kwBdE8PyYhqIF8qFUFc2P19SsF+U73dslJwWdKimRsfnwUXf0D/dikAPkfsr6TbpNoQ1+Cz8aoIlTXJZcul7O1WUy7AX8/rOyngKakj3TNf84Bsx93eAOGh2o5jG7FSHHczaTHENp+jhnLFWZ/ate2tgYG9zVlKXwCG/+u6G8xBgs8SjzhhfTfpFSYyhGitDwqnF7fnU/3/GLeI0pa2xQMnx4j7HtvsSCX1whFmTGL6TO+uMAvMK7PzEJjhn0lHyGhKu8WhGmrSVxy0OUfkHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9w/WM8vXUvBA0xdK5pzeG8DhS9as02TitdPOdQYk6o=;
 b=OIrK/rNA+MQUgwUHagn5pUf26/jGllSSvJUaREUeUufC/24YjuV5p5bi57OYSeDmavdzrkKUDPOiTYx85Jl/i3hZ2uX3xxxA5769vEPTeCnBuXuNG9TZl5+ZDalCUIVr4JzgXokYejzZY6VBgKPocZvK0WFsmfsrR7fPWJLfzFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4637.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 15:10:04 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 15:10:04 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        "Han-Wen Nienhuys" <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Hans Jerry Illikainen" <hji@dyntopia.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        "Felipe Contreras" <felipe.contreras@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Gwyneth Morgan" <gwymor@tilde.club>,
        "Jonathan Tan" <jonathantanmy@google.com>,
        "Josh Steadmon" <steadmon@google.com>
Subject: [PATCH 2/6] ssh signing: add key lifetime test prereqs
Date:   Fri, 22 Oct 2021 17:09:45 +0200
Message-Id: <20211022150949.1754477-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211022150949.1754477-1-fs@gigacodes.de>
References: <20211022150949.1754477-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P193CA0073.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::14) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P193CA0073.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 15:10:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfab00de-4415-45b2-1240-08d9956e06f5
X-MS-TrafficTypeDiagnostic: PAXPR10MB4637:
X-Microsoft-Antispam-PRVS: <PAXPR10MB46377A92D93C6D620FCDE9BEB6809@PAXPR10MB4637.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JQzw664pQL3X6BhU2F9/QgY9o3L2tucYRmV3gIAEfWhcq/a1TVtFAPZkLkCQ?=
 =?us-ascii?Q?mig2NNUVtMaeK8Hi9pBm8Lkufs4EKIQJUy2M99HanTgG3pHmb39P3SIN/wB0?=
 =?us-ascii?Q?VY8lQeWhqpTbMyKykJXglls1S7M8MW7TN6Fv71CH4LU8tFz7/6rb6buwn8NX?=
 =?us-ascii?Q?0K/ccdcj9tiN4taAkW7WvPJ1cEebwIs8KaKqex5nBUeOMniGAMYASsn+55yu?=
 =?us-ascii?Q?KMOjhvVDlR0UDGVOb+PSuRCFMb2Ew0ehmx4eSezjXUIx5PUGFujtgLOeM3DC?=
 =?us-ascii?Q?sIxkl+YNjGuC7M82qK57Y0aipu6K6zGMyQVyA2lgiFfvrOvawJJEPRRsyI+d?=
 =?us-ascii?Q?HjJ8eE1i4WI2BT37i5/Av/2Hl0HwWqWdQEj1WdrwyfQWnU+J+IbA8Gnksm0K?=
 =?us-ascii?Q?Iq/5zbdcWoULyQ/LSHIBTSNiLmqeDmuEWdtRIKl3WdTLbTRgymZ7fmy46jY4?=
 =?us-ascii?Q?X2Qw4cXnbSI1R6GwbF3UYZC0yeH8UOCg+0IT1gaZrjJua8kxIOr4Zt/+Og+i?=
 =?us-ascii?Q?71QOBTmwqBf+H5Gs1TgQbhmHxLtMFaJBDM0YPWqQ/2lAVw/71sHTOW0muAFP?=
 =?us-ascii?Q?3n2v1aOMIp2V6XX2fxuidfgybOsBkS4K7ObfaAIGCxzIRt1aEWn4W2OOmZxV?=
 =?us-ascii?Q?LdTDyrcWiXwYOcc08Hq6yU/KVer04AiMn5uStEfBcbY2UXupSl0FesItD1WG?=
 =?us-ascii?Q?lH8AkpHyVpkVe83W/oIMpvWy1kwMdqZuTXE/H/wGAy7ihlo5JIpoujQo7tn0?=
 =?us-ascii?Q?tset+/CDESAAquPhfd0b1ljGVCbY5jxiWtfqWamVvSphcZLU+vt9Nx1i3K78?=
 =?us-ascii?Q?IlYetnITERreCeQDkgmC14ZerVkhX243eguD3jEZk+aKVgEgin8WnygVk0lU?=
 =?us-ascii?Q?udh96jkOQOXWWgp972RsR0faAfVGkDh3LfjYFCjjdzki5MGnYym0m0DmqhoJ?=
 =?us-ascii?Q?4rCdxJ91LWeXgg5NUMo24fhJx7uMZRRkECHlbebNTI7I3jOIsw2QzG086nvj?=
 =?us-ascii?Q?V5jKO/9wAbloLHj8cImiJY0B1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(4326008)(7416002)(186003)(6486002)(2616005)(316002)(66476007)(66946007)(5660300002)(8936002)(8676002)(508600001)(83380400001)(38100700002)(66556008)(2906002)(6666004)(54906003)(6496006)(36756003)(86362001)(6916009)(1076003)(52116002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0D2pOZkVpZkI7H8YFPKLUPSbXk0CurWOaz4TZerwMwH8RFAlY9uYcc2tpmdO?=
 =?us-ascii?Q?nTCG4ogBLgMrzBUerl5vNBv8hM6icY2Ym49B3WGdycUgfKON1zVhjjYEl+s5?=
 =?us-ascii?Q?RQmsYtbJAASL7fXFhY1aWWz79LvKlza99ulvyNhhkpWwvIMSDQSmfyF/2lQp?=
 =?us-ascii?Q?nVJqwxziTdqB0IrQgMlH29WwYEIp25uGbKi2kaBbIj96S4Qi5PzN6WbVZW7/?=
 =?us-ascii?Q?7f6Yo1DwiUDg9acFojm/OFoUY0vuqIOI0PMN1/Cvj1I7UH7QIbYcGYnTPbJG?=
 =?us-ascii?Q?h8sVTYIIevE/WkuySwo6QDU/rM1+t8e08bylzmc11ycfhHVVJzWMsQ0KViOO?=
 =?us-ascii?Q?oPKwG02RmqZaPatmTYeI81njs7jgGC/UbvFq5vGF1HC7Uaegolj9rsz1zAjw?=
 =?us-ascii?Q?KnrT4yXOfXRsKMvVfgBf0rBNcf+gLtE9CFUVX5tdqfEr8QINwWa/isurmsCG?=
 =?us-ascii?Q?7X0A8s5e8v+zxWeCXCy96p/2Ex0sqRvI6k5G53rgKxlIj5GDPkR0bkyLiRew?=
 =?us-ascii?Q?BoqMJCa96kDaSAYY0XMt9InsLchGcv0ODbEm9vVcZMwJvRu+3G/NRD7dazPk?=
 =?us-ascii?Q?x4vP1uyWQfGAPBtVfoSyMH65A76o6tN3fAFgh+uCNplCzSqNIE8qVJ9QcraK?=
 =?us-ascii?Q?WHn0P1d6IVuoFpoDbNQmZQmLLaerAp2NtymjFoLbbBGist0H5SIB+DdZZiQr?=
 =?us-ascii?Q?bF4x10Br/A52riHFafEohGbdEiJ4IdKdNTEUPvjJPEhyqjnfusL3WUS5yK2X?=
 =?us-ascii?Q?quV6sYoHbsBwI5VHHL7I494GsB5cwYWNL4HVH3sMHhteNxDKhAOKni84gHCC?=
 =?us-ascii?Q?6O3SzNyV11ku9deFFsoIkKjtJ1zXjikLzk6MUTf1c2WoDptmlJ8jAn12oyLJ?=
 =?us-ascii?Q?4BzW1y4DNWDeaXy3EVXjjcmLmPtu0KP5ZCdzUPH5DstzLmuvL8T9DXLAeko/?=
 =?us-ascii?Q?kQMcymilxf1xzkOCf8L66X3cg4AWrgJaukwhIuPY60QmDu8liJBn/+5QUKR4?=
 =?us-ascii?Q?OD/peQrk/bSULUsnywwD7ep6A7nE1Zm6/EgXX8cn1hgVjlmf1fGnfZqtwMo/?=
 =?us-ascii?Q?cjdw+Kxi1UBir/FLm6qgvepqAHY6JOk0+mT0jjzu3dqc8nyM+Di9mwCUsIXO?=
 =?us-ascii?Q?fd2Lxj7RNOJ7DTARwL3seYhaCP780KNrV8o4d/aXcCGMogf74G4ayrNq6U0C?=
 =?us-ascii?Q?V/VEG+7RT+509s/LrolrHEqBIeWOtzIb/q+P0eXr1OUIk7qRb/NHXaUuuyPD?=
 =?us-ascii?Q?m8bE8RRJtKyC9cPuwu4HwiiyAlue+cHZ/kEwQWUV+XjwBSHxaMFJEwacjnMY?=
 =?us-ascii?Q?MFlR2k24A8GHvoVPFX8/xZQHrzqHAQmCbrWyk04P5Hs5BwJDwKpphmwSClDS?=
 =?us-ascii?Q?Y5KcUNpYitwr+JxhTZAbQtVA95bzl3wKM6jPvveYhL+kfvVEyFP7Cr1S294j?=
 =?us-ascii?Q?5hL2rbi7ASo+slgHpGTzBGSBep7vjRQESvjUtTEiWrsD5oahBmaj6DCNB/H0?=
 =?us-ascii?Q?YkYut0qIgmSELosWXXLdTcmVqpT4R7A1x5nJ?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dfab00de-4415-45b2-1240-08d9956e06f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 15:10:04.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fabian.stelzer@campoint.net
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4637
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

if ssh-keygen supports -Overify-time, add test keys marked as expired,
not yet valid and valid both within the test_tick timeframe and outside of it.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/lib-gpg.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index f99ef3e859..139e7a45ea 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -90,6 +90,10 @@ test_lazy_prereq RFC1991 '
 GPGSSH_KEY_PRIMARY="${GNUPGHOME}/ed25519_ssh_signing_key"
 GPGSSH_KEY_SECONDARY="${GNUPGHOME}/rsa_2048_ssh_signing_key"
 GPGSSH_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_ssh_signing_key"
+GPGSSH_KEY_EXPIRED="${GNUPGHOME}/expired_ssh_signing_key"
+GPGSSH_KEY_NOTYETVALID="${GNUPGHOME}/notyetvalid_ssh_signing_key"
+GPGSSH_KEY_TIMEBOXEDVALID="${GNUPGHOME}/timeboxed_valid_ssh_signing_key"
+GPGSSH_KEY_TIMEBOXEDINVALID="${GNUPGHOME}/timeboxed_invalid_ssh_signing_key"
 GPGSSH_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
 GPGSSH_KEY_PASSPHRASE="super_secret"
 GPGSSH_ALLOWED_SIGNERS="${GNUPGHOME}/ssh.all_valid.allowedSignersFile"
@@ -112,7 +116,20 @@ test_lazy_prereq GPGSSH '
 	echo "\"principal with number 2\" $(cat "${GPGSSH_KEY_SECONDARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t ed25519 -N "${GPGSSH_KEY_PASSPHRASE}" -C "git ed25519 encrypted key" -f "${GPGSSH_KEY_WITH_PASSPHRASE}" >/dev/null &&
 	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
-	ssh-keygen -t ed25519 -N "" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
+	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
+'
+
+test_lazy_prereq GPGSSH_VERIFYTIME '
+	# Check if ssh-keygen has a verify-time option by passing an invalid date to it
+	ssh-keygen -Overify-time=INVALID -Y check-novalidate -s doesnotmatter 2>&1 | grep -q -F "Invalid \"verify-time\"" &&
+	ssh-keygen -t ed25519 -N "" -C "timeboxed valid key" -f "${GPGSSH_KEY_TIMEBOXEDVALID}" >/dev/null &&
+	echo "\"timeboxed valid key\" valid-after=\"20050407000000\",valid-before=\"200504100000\" $(cat "${GPGSSH_KEY_TIMEBOXEDVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "timeboxed invalid key" -f "${GPGSSH_KEY_TIMEBOXEDINVALID}" >/dev/null &&
+	echo "\"timeboxed invalid key\" valid-after=\"20050401000000\",valid-before=\"20050402000000\" $(cat "${GPGSSH_KEY_TIMEBOXEDINVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "expired key" -f "${GPGSSH_KEY_EXPIRED}" >/dev/null &&
+	echo "\"principal with expired key\" valid-before=\"20000101000000\" $(cat "${GPGSSH_KEY_EXPIRED}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "not yet valid key" -f "${GPGSSH_KEY_NOTYETVALID}" >/dev/null &&
+	echo "\"principal with not yet valid key\" valid-after=\"29990101000000\" $(cat "${GPGSSH_KEY_NOTYETVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}"
 '
 
 sanitize_pgp() {
-- 
2.31.1

