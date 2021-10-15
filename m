Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DC5C433FE
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 13:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CECD611C3
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 13:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbhJONRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 09:17:21 -0400
Received: from mail-cy1gcc01bn2023.outbound.protection.outlook.com ([52.100.19.23]:25729
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239251AbhJONRT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 09:17:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcZz1/A1ONYIxltM7GIaHeo8397P03OsX4kDw6Wwpa9sY4MyR5hBAp4TzycyRRbh8AIUB3R/rISnd/nK2M0NfjxhceG3dC2xfHQ5k1xhzsY0AnANwTPHWpELknpHJ1wE9Vts3lzOGDdJ/ZdI9SH0PfFvfA2kZeR9ImzbcvsiImvWY7uTVX7/pn5GcINrRrZ2iH6fzf1KmzaXq/adfY19txtLkdovIFbZoRI8R3oFYAYbvWvUl2c8gSOWsGHwcqnKOG1DupdX/bq2SC6Mp0VNFaw04Lc6+i9FHJTk9f6kW714s9iuPbxehPxm7Nsxtm66WB+fJPUU48/NRxEPkgrPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9w/WM8vXUvBA0xdK5pzeG8DhS9as02TitdPOdQYk6o=;
 b=OUly4H48BBvsZtFY0wMXqb6Um/86fRtJ2JaDqk8VTzDmfQA6fGzzwyiEFmbfD/jA1tyMsyxElWdEKYbYC/368k4zuHqsEaJZ6lUoy2LEBYDoRI+ptsaDO6CFRRlftrsrHzqeHc5Gq5NAVv7z0Gb6Z4Vgx9ZK2ElDjFYYXT0CmEEdphkSEaFHXbnUtMAUmBDFA6faOjsVtFH0VasyOiZOVtqjwRPJSbmZy+oZBm3bAy0FSWDsaEGRPdyDnRvZ0sWi9gGexEviLsBlgXDQZC+MDVMbUf8yfSoNjig7n6GLzUB9q80ms0uZxpewlk1fg8fDP5vL8PBz381JUpep+rXIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9w/WM8vXUvBA0xdK5pzeG8DhS9as02TitdPOdQYk6o=;
 b=n0XPWLXe7ZCMj7f/wqah3yqBH3cwnVkjVnA7huQmXzcfOUtu/GNx34/zubvPueCYSXwKOCbi6/J3Dxtg2tvuHQwm8SSiIpeC4stOXW7lW4Z18Pk+kD/g2rb0wSqyciGZjMsLZcVmZtXFe0TgW0KlnWA/QUaPjJQvn7YgELiAaIw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 13:15:10 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 13:15:10 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [RFC PATCH 2/6] ssh signing: add key lifetime test prereqs
Date:   Fri, 15 Oct 2021 15:15:03 +0200
Message-Id: <20211015131507.1773153-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015131507.1773153-1-fs@gigacodes.de>
References: <20211015131507.1773153-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5P194CA0006.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::16) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM5P194CA0006.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 13:15:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23e3573c-97c2-498d-f319-08d98fddd0fe
X-MS-TrafficTypeDiagnostic: PR3PR10MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR10MB404695A543A51B5177D8BD4EB6B99@PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dS7A9eFcAFEOo+lfolApcqAav3ivGVbR6XuJLJ5JxuoTng8XlB+I+wH4RvBc?=
 =?us-ascii?Q?DIbNKfpzyRdyc6B6UxeSoT08gfVwpON7zvrBXeOzgRcEIENNCciYRB48XDEd?=
 =?us-ascii?Q?G/i+WGuB0rVqo6SW2TDzk2cH/qAgMSw4dZAqEvtgi3tZdEIho+dygAoqV1XC?=
 =?us-ascii?Q?GszKAYJ1tnbt7Yn78ZfyMsPsZvksJLOYPey3nyttFnRvvShvRFJILE4j45gJ?=
 =?us-ascii?Q?ylDB22hY0D58z0hssoY2jFYCtBdFWvdVrZI01OB4AF4DL/rvLdPtED78B5f+?=
 =?us-ascii?Q?UKtXh/fGRcJyRhsk6k655XBMaQCXE2Vb0GiWyv9szwfjEDy82aqq45QdaW0k?=
 =?us-ascii?Q?rtPA9RzcoPUwC6KlfOqCd9LZYekxA2IK7Up4n2ZJbsDA4oOtcQkrxyZBseks?=
 =?us-ascii?Q?q6t3WfpVHophcp+sJuK3Tv3RFbw4qxW/t8/ZyP7g5vFHX8/KZu5YHWTCRtfi?=
 =?us-ascii?Q?ZZt/rp8dHwNB8Hps4KxiglnRzAhVaKj2jcOXUU6Jbu0N4LaRSibckYDsVXw0?=
 =?us-ascii?Q?WZ2NEOB2ScW/Qs8rcbit6veDA/DrJqyRPsEQTQmBfybVWiOJNdkiMsMS2XK+?=
 =?us-ascii?Q?CPo/bmzZ52ce/zHIYcWkC75dRBb7gxhI8SiYbAC8BjwvKzbusurxKfs7KKps?=
 =?us-ascii?Q?c9/dhXyrdeX0ikjLbU6XkF90TBrV7ZptouJpsdETJyUXqFsq0RwZnn4hbPyH?=
 =?us-ascii?Q?QWkg9AYnQ9uFDJrEVQJtiDs18JRhKlgu13p5V0SEm/u/IfOL/0/tGBRQdAmd?=
 =?us-ascii?Q?P2qqzyKz52+4Lfrzvzkt7vsSjKzZsUfAms2mtO84uNwTMQ0eCbw+PQphIrQS?=
 =?us-ascii?Q?gc8ffanwzt0pKrbYMUl0S4eHA+jU/IShwHd5ItKcU6HCPA8fuj+0yW6iuY61?=
 =?us-ascii?Q?NjXw4yiGbe+NQha0W+EcjJwFhGBtxuiNKyTwppAGdwKe7NwZ5RE8H0cC3uCX?=
 =?us-ascii?Q?9dqee8yTDQ1HtblrMVeVNPukIs1gIEAOE1nlKkPmX6u74guwpsLXu3wo7Bt9?=
 =?us-ascii?Q?Medt8quYGr4p5RuSpMvl4RTfBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(366004)(136003)(376002)(39840400004)(396003)(346002)(107886003)(36756003)(2906002)(1076003)(83380400001)(6916009)(316002)(4326008)(38100700002)(6496006)(8676002)(2616005)(5660300002)(66556008)(66476007)(66946007)(86362001)(8936002)(186003)(52116002)(6666004)(508600001)(6486002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xFJlikwKQkenF7vBOa3RW86H9KJtc6Q6U+YLqT6JHyzZfqzpFTEM3pxnPn3W?=
 =?us-ascii?Q?owUjqV7L7CNOLm6vGZmPFXbC9VD/MbhJvhIlz7EmWenyZ/qCIKa1eOUdLvbT?=
 =?us-ascii?Q?fz3W+cf8cQjlA82mV/GWY9gQIMfHGKRMilsOPKn4ZaNkFQU9Ri39oBPdLJfQ?=
 =?us-ascii?Q?IWJXdGbmjMux5ivP/UmQ599bdyVFSgeuzYWCfYGhsZPQolhOzH9IKIxryg8z?=
 =?us-ascii?Q?IWlWkJMY4zjwQNr5cfs6+2i54+tskYKRmSKHoGpc/nTIrzAYj0lIfdxlS+4/?=
 =?us-ascii?Q?HNTFV+9i9tH5E2GEJVhZOMOrj/N5KtSrEmlBJ7uGd5BEJZqBHrvirmfWpI8H?=
 =?us-ascii?Q?4yrVfXpbDMnawT4c+OVUqg441gfn2pv4mJnfN/pbJNiVtBz6rc7o/lzKwMqg?=
 =?us-ascii?Q?Y7PRMjSS0eGLctVtkIc26Tmhjiox5XAtsIrYysDoJ3n9uzoBx+5zoTGqpFkE?=
 =?us-ascii?Q?XOx020mZ92T6IKJYI06AKgX69eVqPbDz4X1HypKkX9dfx9WRQnQNhDIHaDs2?=
 =?us-ascii?Q?RKOlkLqkuUT/BMLeEoafJCSqcuWTyyTJk9I4G1gcHGpv1/gHCQmrIN+d1MFd?=
 =?us-ascii?Q?LJ4ALA3zDUdevt+W0OYAfI8Y7lSF1X6ZagUj0EordqNwM60l6EGlsqkJUanw?=
 =?us-ascii?Q?ZFhc/2CMsuCIR5NJZffqGSAMmx1EAGbqzoc9d5CTJhu6TWN9oGQqyv9jLEUD?=
 =?us-ascii?Q?qx2mVMdDdu5buIhh0fb9+U2fm4KaDIB6r5tFMB1q0tS8Zx6E8p3L3sn2Vc+z?=
 =?us-ascii?Q?nkXRkX9NabSd4YLWPgwOtQ6N3vUaFh0oNwv2pT45C0jbCjK6nOmsYRbzYUev?=
 =?us-ascii?Q?cDUcYwApYb2bP269R7rRX+oxNQzEQ0m26Ta8Kv2kGXwBFq2+DVrGGQmGJ9Ml?=
 =?us-ascii?Q?glK+LsltmY172vFwe+1DKaIGHjoCq5mdJr4eZqW3Fv1X7SC9j2BoN3+HEpHv?=
 =?us-ascii?Q?6+OZwwFC/p4qKcmoYDJbKFe+hMJe/g6i5n/8XsU3tVJtKpa+/K6SkrsflCs8?=
 =?us-ascii?Q?L+F0pfi4th+dUg+dfZ9FWkgZMfkAFb6fTihZyt9GF88pEVesIrw9IaIxHaDO?=
 =?us-ascii?Q?UOkJDjHkkkEWmEFSbvrWBi9JuOjMKELXuNHaUqSDpDO9ebEyDP3PUUNrv2FS?=
 =?us-ascii?Q?7YUQsLCxkkUOWyl78LvfXAPxv79DoR3JtX1ZxAd8xSqLTNvKcPJny97HKS7f?=
 =?us-ascii?Q?6qZRq9Y9RyEWya0vKGx9aQAHfl+KSXI11X9VmHST7gtMFUJDe2IjjkndkNCG?=
 =?us-ascii?Q?iQdGaTQOyJ58xli/JK/VZuts3IBh7gxwQsD/XOvE0jeg7RwpbnzfOI9Qkpr5?=
 =?us-ascii?Q?Or3Bn+YAImlsXO6iS9X/8A7YNNVrhK+WAfOIp90ElOdPmQpkEwm3h2zYIDws?=
 =?us-ascii?Q?U/vI0WVnNyG9tFhwLTs3hBFKTLKB?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e3573c-97c2-498d-f319-08d98fddd0fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 13:15:10.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mThGWUoXQsX7EX6KClOpVIJ3JBT2WSUQUKqoTAbC6e1fXHzwTzz5cqYng5UY3+NLq50E+fTM8KJdo5fRuTBcVbqx4hctV0Hw32KWs1k07xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4046
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

