Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A97C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F563619EC
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbhKQJix (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:38:53 -0500
Received: from mail-db5eur01hn2234.outbound.protection.outlook.com ([52.100.6.234]:20915
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235103AbhKQJit (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:38:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfS6QSOy7nktcUzGFL0zd3AfWXVzvntOOcYOKX4QhwmfrTOEgQEAkZGYCtq9COwqKnyGWwDlhkfW/sh8R5DhG/SKILBY+C8soroZirqhakbeZClDotlUbbFypD+wa2IDHntPUHY/pyv3J5f23se6sIrIpB5fdzBdQ2aPKK5XIs5N+pFPiY4dquSaMrh7k/KL6Jy/oEcZHmttnQ0Uh+UDTCXWtjzuvoE1ChzEV+3tiza93qP8I0l9fTEFvHC8xTwLDw4Ig9radyFoMLuoIQ0kDLGLruSme5F75b0E0lt82IKGoRboVNtlGBzLoJWqo9v8Xe8UlENoEE7+48xnlEtWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3sccrQyi7gwNykk7BAg8YyNI3Nho2xKTBAsNPAwDAE=;
 b=NeKrE7LbdcFHoKHjC6Z0q5lMdw0byMDHnSnK58SBIUzQqGAAn1BggxZCnhzV4h/wT/8ZT7brsG3dC/Kfhy6vGF67JUXJgrbnSggbw7KfZyhMcm9BTVBo5FYLJDtSJH/vhI3o9Ww/ZpMlwuG9VbOpsVTvln/5DjR6SPPnhf5qVXJsJ9sIuGGv1CKXV+WD0Jtj/lOCdQPtMYeEkjyQOndlP6/7xIpZfMioQPtFxMRcQnjHw0TMaHgc63KDOuqZD13JGa1r8n9R63Qt+wEHwRmlzZOiFODcW6sEzXKQr7RkaO1NDWl7pcseJpF012WwfFuRo8f2PUUD1rVu6mmn2uksLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3sccrQyi7gwNykk7BAg8YyNI3Nho2xKTBAsNPAwDAE=;
 b=v8kIbqmM49RAzuhge00bmIrNwix+tFx8cb7W+AV6ibkwhrE+3gybii5CHc2MMWKBfomrNMqbC3Ysh7AFauOfdteKQqzmAhI14nfXaQTJCdS+6ZUyoJpSt8784h3aZCKnxUxQj35sfLwD9PGPkbUhVOaw2MR8OJBkrraQvtl2DfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3820.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:49::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 17 Nov
 2021 09:35:47 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Wed, 17 Nov 2021
 09:35:47 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 2/7] ssh signing: add key lifetime test prereqs
Date:   Wed, 17 Nov 2021 10:35:24 +0100
Message-Id: <20211117093529.13953-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117093529.13953-1-fs@gigacodes.de>
References: <xmqqsfwmus5g.fsf@gitster.g>
 <20211117093529.13953-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0045.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::13) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR0301CA0045.eurprd03.prod.outlook.com (2603:10a6:20b:469::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Wed, 17 Nov 2021 09:35:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bec2daa-dc42-4d9a-4776-08d9a9ada270
X-MS-TrafficTypeDiagnostic: PR3PR10MB3820:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3820E5FC50C68217E0E292EDB69A9@PR3PR10MB3820.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ty/LT5Cb1o8SP8Lh8oYmDByIwDG3xLIud94EI6Yh+6g7GVzThCVixVuZBZPZ?=
 =?us-ascii?Q?g/SakBjd8m1RWqbk0kmvVrqwnvNMzoyQy7EtZLK4UzCmXVIuCUcOs5jdH8n3?=
 =?us-ascii?Q?LArR3ETe84JD9s1zzpOhAgo3cvJt+tfO+2QDrKrq2uZiizXegzYl/JSkrbHI?=
 =?us-ascii?Q?wjezHsHaYKNlpTOyYsZdhKFHgBi9SczKTlOVrYMZWYowBoPT5My3z8RMH19j?=
 =?us-ascii?Q?aHq4rgPr9Wz0FXouhnWi5nbrJ+QD0G/sVZMXgTTFvfAjPz1kKpKx4iACLj1J?=
 =?us-ascii?Q?47p9aEHY0FwwzqKhIRTra5oDvtIsYlO1vvizczbO17MNVw8/iRvGxwy+PobS?=
 =?us-ascii?Q?MLoFTZe7oT1Wn8CWL5P95O6OtBQWHKi8RmQt3cqniqH7Zl5NwmKCAkTauPFT?=
 =?us-ascii?Q?2sQvLsd7CDaCIlIIFPj8yRv7kAON9Vv3IRZEaeAr6SAGqM6plfOx3GyQnSM3?=
 =?us-ascii?Q?gUkCC2Fnl9iFokfxIjVhBhaDvh8/eh/BtrlFFZYsJxPFXQzqvpCyLbomx/o/?=
 =?us-ascii?Q?rviKcvuxFaZjBhtavajWG1kk/LaMAmyBqzt31jmBThu6RB3SvqpsR+IvPgpD?=
 =?us-ascii?Q?2paRAOrmEBKf1VFd3ivgSxGzWCTSukRA7+DtQEfYHwnV6uvLFe9oaSVuAiKm?=
 =?us-ascii?Q?kxNiz076ASAz6Plbu+pNKkOR3wksmUwQeMyrQuLa+FVbQ/xP9BgUJSViEwda?=
 =?us-ascii?Q?T56xueupz2jMYXRZPK4jZi+viCrz/AZ0okgTSP3BhqIRb++JUHoujsxXwiQh?=
 =?us-ascii?Q?+Zs+iXY7+r9NlexSyvzVdPmImivfWUtIqxpxuI702V0eqD9ENBe9oLvoxHoI?=
 =?us-ascii?Q?754GVm3vxuB38v0dxpvrR2E7QGDUsyNlj81/JflWk+3e7+lfp9iEmTRax3mc?=
 =?us-ascii?Q?ENioC8cP23BAEWCV7BSQKrhqMjeKURnWjKNbcbVg16ewVhKwoN6H85Q12uU5?=
 =?us-ascii?Q?LV4jirPS0dUUeYcSQx3xBhnsRoMbdbExoBjfeYo8e7no+B7sfR9XOyzKLJtf?=
 =?us-ascii?Q?Gdgk77qvDn7NEhzNcRZQP0Y28A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(136003)(376002)(346002)(39840400004)(396003)(366004)(66556008)(316002)(8676002)(1076003)(66476007)(66946007)(38100700002)(8936002)(83380400001)(86362001)(5660300002)(36756003)(54906003)(186003)(2906002)(6486002)(2616005)(6666004)(107886003)(6496006)(6916009)(52116002)(4326008)(508600001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xCXR6V2FlE+XtPxZUl5QGRNXByuXyTdg7IQ+9JiolHZF39YopWay/yYEJjz6?=
 =?us-ascii?Q?gFyFk2qMoYh2sSS5tAB4/bpC71PG15pDdeEqTcKTG19lzz89XIkg+Q6/+IU2?=
 =?us-ascii?Q?uo6SK8wF2Wy8N1ginB6pqeoRj+iFWbANlEFCqoXKe0jK1PERUmfKCirQrqeo?=
 =?us-ascii?Q?gK2mdlgoC5FvI0PwCFCTLu7TYdWsX7tw05e4mKTDVw/j7AhdBvn3jro3o/Wp?=
 =?us-ascii?Q?wjoLBEXHMGbx36F84ACLkGjFCh/PjXKcj/bo9DN3AF7SHc1Dd6zxZ/Wb3xVZ?=
 =?us-ascii?Q?i+iajXymDPkmhHdFJt9XIb5H7phI5obflp4CWbddGp43mGnpQSQv70x29MbI?=
 =?us-ascii?Q?ztiYFRL3SxrdaGBqn4hkn61T7p7ZZpr/CKQPXTQnZba4GIp6rCnXOFzzTwaC?=
 =?us-ascii?Q?bbzos8VniapD2N9xYZJOWbj5RtUQpbAj2s4uHoKLOeE1eWTlcddryVftDL+L?=
 =?us-ascii?Q?ELyHEJpru1rtRO8NAfH5PwMoAK2CvKEVJZIeMDT99ikgem5yOw72vUZzmWko?=
 =?us-ascii?Q?+a/AOcRfBIpYO4Le1bskVqi+3NwCybuuypUT7aMOV2fRNzgix3/CrSvyk08S?=
 =?us-ascii?Q?LvxuseX+rc9vDM8/oKh25Bjd76r7rXMcus62DnkA9TnfN/RYXzltVsKoWr2z?=
 =?us-ascii?Q?tnMx0K/ZVjXSFnpQU0QE19jR+2rVpIx2CHx17d5l7AS/cgGs7Q+s8b9vKIiA?=
 =?us-ascii?Q?grrz1D/JlwhWrEtH/hTONX1MuDI1xqY0QP+kChN/V9Ykf7L1+4+x22X/kAaK?=
 =?us-ascii?Q?iLmBKZINPlGhMqIzRN/vNdKMcpr56zpvuaN0yiX4oeG1qxYBURIFP3How6t+?=
 =?us-ascii?Q?aaaPtdAiB71DCWoU9aSnYfZfHcdQ/R3gHNfxF902giYkAnqfsF0+pCdCjl+m?=
 =?us-ascii?Q?5t5Re6ctZLG9TizBh87lQbGnpfJv6rWy+rw2pWfdIAKyFd5pWKFIm3otrnTB?=
 =?us-ascii?Q?nOLGgnYT0e12zn7tYMtHLR9fPSrzxL6Rpu2/lQWW+7wOQf1DW2vrG3aedrFb?=
 =?us-ascii?Q?GeunWDeiYdE2q0007g8freg3PIqSekZsIK/IEsIWWPZNOMrAb7I+VVmUgb+5?=
 =?us-ascii?Q?dYeY3JHS8k5ucSsATBmF2PlpYFrn8N8gt2Ou/wEmkUKtvzFTYKi4bGg/Ty9X?=
 =?us-ascii?Q?a9TabKzeJN0P/1F1GFczvW568lXWBoCA4nVqj8JOfyaLvrgruP6UqGSGX4Om?=
 =?us-ascii?Q?3WW2JqpE8MRkRv4m2r1S+AVPUctJo3VcDG+lbs4VFM+SDXU6aHcuVSxp3oAo?=
 =?us-ascii?Q?0jpXy7L2joDEFg1b28OgArr25CbCEcNlRjbwdTI+iYpkegHVLYG6PeNU/diE?=
 =?us-ascii?Q?C8ZauTym/QCps2sklWomUgR81ftI/uaA7WCPCj5B6grBIgS2weoO5U/UTzCb?=
 =?us-ascii?Q?T9PTvzyOB/ZAN7wN7FN8aX6C1SFkVwRHx2rWb4iKkPmuIdvmXQWbHZf7AZMJ?=
 =?us-ascii?Q?GXKR4GziLix1/VGxF9pOeVtuUb2Vcs/rBI4b+x4m8V6W6bKRVdwqAMe8tcnB?=
 =?us-ascii?Q?z9OzXsiLeU4Hm2zlZih8jziBwrzgXNLRjLvoq1AqW3DAgOWUHp3M+6CoOHlE?=
 =?us-ascii?Q?xPedsC3N7UJqzABP5qy03L+2WWB3C2m5Xsr8Ir3eUqOdL/RGQLySg3kUzHTY?=
 =?us-ascii?Q?sZVIVrstCJneSlwyppnq44IGv3g40UfKby2omCCl92X9R9u78zoExFAKNtGd?=
 =?us-ascii?Q?oWLFy6pw4Xfzhz44HqVvrZLZgjSr+f3X4wpXVWCsMbdGUXWnzKwPH606um8C?=
 =?us-ascii?Q?TznkW2EY4dQjEowMBozvryhH0FuRGig=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bec2daa-dc42-4d9a-4776-08d9a9ada270
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:35:47.0086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jR0BDOMQ4x6rxrHZbLVkuE6YW3vWONwU+wlm4KitgRmQ5fDUxlx0Ay3PvVGniLblDqHlvJrv2yejstq/ycbAaRLpP0VnYC38Mp3fX6y5IE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3820
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
index a3f285f515..fc03c8f89b 100644
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
@@ -119,7 +123,20 @@ test_lazy_prereq GPGSSH '
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

