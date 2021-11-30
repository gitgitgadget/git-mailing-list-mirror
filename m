Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48825C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242068AbhK3ORO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:17:14 -0500
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:8481
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242103AbhK3OPH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:15:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhIYfn58kox7Z3eHOjRGsDqioiSSANfv1PbxW3r/8pOAmVb1CYWmtAeEE6eVu4My1R49z/J9yF4cQOYTlNNQx8ZjIkO63RURYON62mmfOpI3h3TN5ugyD1G9cXrLQ1CCjnE+qputS98nWpaH83I8wEQ786Sj1Zx5JmkUT/JRtB0VLEzz7yTb1RC/meto+f1Qt5vWZCGp22IH3thWrCULvONgDGQ7Dx7LWhscpJRLOi/zxMtTNrCWN4V2dPW1Q42sX5qhuRt2S10c6QiOv9wOItrgf0LLcRaNRqzoYvtQKFtUjC/tx6FmK1lc9OyAasRUxBSo8czmz/3L1ytWZV79wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GJazhYhjfKBtvvh1iR5lBPvTFZKmn7Fey6rbc/EDBE=;
 b=MFx4A28XbGdW8zPCiA4NQn28i6quXPmSVnFxvZZmisEZKK63w+jmgujcWkEgjTlqqHEf/jwz6sZcXNyi0Hajv9WXx/qaleszGiQ/l5Sq6tRgZVKVX6IwxSMbbSZZfrzgCDCoebVKhlREuI3HpG5JLqHHRzfMWOlsvNjk+atjCSlryAqmGyKKbN2CECAuzJ3pQ0q1tAut61Of+WKWj4In/se0MGvewvputQyfrv/28yUujRi1x1YbEeZszfLpdcUAkROF/fIPECG4mGEY3GuEH9KmiOEW9prDQGZJWVMaZ39ZCaiMiHIQpRHGUF/wV41XZZC1EV+B7GJglBCqEI5F0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GJazhYhjfKBtvvh1iR5lBPvTFZKmn7Fey6rbc/EDBE=;
 b=jcCi8q2ZAua6mEu+QyQQrl+f+REVx/tc5TWvseCKZ+3kiwLgv5tygLHEezDUV7Cgaupj36bYYNLk8CKgyxg/igODN4SwU2RfJL2QJ9pGLKre5TR1nEMi+e/Ca7HXethLNHmYMCCqandeaTRmC4tLGl5QcwQWfm50ECv5R4tkrH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4590.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 14:11:35 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.011; Tue, 30 Nov 2021
 14:11:35 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v4 7/7] ssh signing: verify ssh-keygen in test prereq
Date:   Tue, 30 Nov 2021 15:11:12 +0100
Message-Id: <20211130141112.78193-8-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130141112.78193-1-fs@gigacodes.de>
References: <20211117093529.13953-1-fs@gigacodes.de>
 <20211130141112.78193-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0038.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::9) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR0301CA0038.eurprd03.prod.outlook.com (2603:10a6:20b:469::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 14:11:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35525d20-6ad2-4582-1b78-08d9b40b5133
X-MS-TrafficTypeDiagnostic: PA4PR10MB4590:
X-Microsoft-Antispam-PRVS: <PA4PR10MB45903ECB9E505559240A692EB6679@PA4PR10MB4590.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0Wifp/JA1Iiqm/JKk9pbMGocMJ4VcKfjriOFJ/XZcTjiDrNWYAPf1uM6wREPVOiYt9M7IrF3SWTvG139kfuebrRoShkdSb3+TR3471ofpRB9eLjwJnRz3B7ATGDfpv0rYqOC86YCm21c8RIoVbrouyc8rBw3ihTYhU4LXSw10A4+KZNY0xvpvZdBQtzVtsYziQOfce7JrITzQfVHDed9NfCU/PNoq6gwzXMGBc+k9b/q8e/Mny5G0X84bQ1JEWHOtu7NPcXoOyOZMIGa3OaxFObVuME+zcQuKwFgCCgAoWdxIqPsh9x380RPi8QJ6SFY/jPTyKD+RqLVO2hNzVddNtLtNhKLNAVZr7dtXpAcyd370C/FuoVkSaqyH2eeWujPsJ13R+tOhajoJJdlMAFVErzRhTqPDYqO0ElenLUyFKy/zHu4kwb2bNXUgk2QljaSBBb/OCvIdJbEl9JpomH7DR0cMKwr4AlTSVB5od0qnjiaAEcflNj3D+ZoogKaLFKUaK62ePINcQDmKZ2+Ox6PaKY/PaQyVs+qkpd1n4x4XYv9L3u3dqubXQ54UkidNiZhpxRp8qe6j9UGM5O4FIGvbC6TOZL2L/DONpWyb1+jIEOgf9jLiO+anB/Gf0aB4WUS72cP9oa7g6BxEwOmlZqNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39840400004)(396003)(346002)(366004)(54906003)(186003)(316002)(66556008)(66946007)(66476007)(6916009)(2616005)(38100700002)(5660300002)(15650500001)(508600001)(6486002)(107886003)(6496006)(2906002)(36756003)(86362001)(8676002)(8936002)(83380400001)(4326008)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qJD0/tzrFRNJELLRNo0M2ArHKaEfTX37rsYCky5KR0KVZdatDk59Nng5JrFM?=
 =?us-ascii?Q?+zIEbiuXhXS9xLYCoG2h2iKeqD69VYEuHlBhj/g7wypR8EGIbPV2sB5Pm/Id?=
 =?us-ascii?Q?dU69VALmn2P+aLA4QTBhskPwGJbgMKhnr5aKKayakFgIecJK7Auom/a8YkOq?=
 =?us-ascii?Q?4QoqEp/F3ncC8lfR01LRqULQcQak3tqubxV36N8KicA2ns9d4a9Pk7QcJ6i6?=
 =?us-ascii?Q?qp5+10jvQtbYhRKGaN+YYNbeXPF8xVVYKoCwaWRfzTkPA0xCONWw7Wd8d5DH?=
 =?us-ascii?Q?mEckxdWOwus+jyFY5xXRXas00MTO1DlOjBWjJB6bmTq375KwY5KBniOcL/Il?=
 =?us-ascii?Q?j1pi18kK9I1r8/nZQmXBSN5VBdFjHCol7SidaQ3uhES4OYTDx0d7+BmEb17d?=
 =?us-ascii?Q?T6zOGw8KAZV7dQuT6Ut2T67yA0RwhtbVeMbwvOVG3mavjpbiDBRVE0jKlW//?=
 =?us-ascii?Q?/sy5YVbs8SQeOp/2eY7zHIsM0H0FL+W6O4BqLTUtZXt8T4I2SVr+zo7z5M5B?=
 =?us-ascii?Q?dllwvbzekTZKex1c+kiYihYChzB44VG8TbJfIzM8cveaQH7zR5dXfusZ0TBm?=
 =?us-ascii?Q?RYN0O1ePaUzWJY5dACbXF7eM1AlblCNMrgT6iY49yd1SGe54CTDD8doNcNr2?=
 =?us-ascii?Q?SWQJHy3MRy+YtZcaUC9oaTW0+Z/XOw5yD78U+54INwHNOHmOPhlekKEJ004k?=
 =?us-ascii?Q?mEdkEsGsgbEGg7JY5iB5yk2t03QJkZVH13KkFKEVNrBhyHHu3PqnABIaFCHY?=
 =?us-ascii?Q?YXd9OnuO6yU4Ji6Gh2e/pKtzVuobTGKnk0I69seu8BQzWAPJcUyUF4/VTwN3?=
 =?us-ascii?Q?GoNTOAu5o1gTYTl6bs/ka8IYk+4IHkgYUk0sz5dkBWaNuUu6MC0BZaImj2lV?=
 =?us-ascii?Q?xddQ1PvITCdygcCiNve2h3+pXtfnjzRLe8AiCTh2XUBwsyoTJxJiMWOBmcTu?=
 =?us-ascii?Q?xgDg9dIMjSY+rUkc16KSuwFTZf3vpCderxcSCU7x5sX4NpPO+lEHj0dqoaHO?=
 =?us-ascii?Q?RFbENlMCNN8DTuyM6sT2FIDHOZSbQ91UXV6luZ+I1uIwUgDrDhS287qZwI4T?=
 =?us-ascii?Q?4fFl0e2+scs7f1o/EibfrdMcb6mfRyYwTntaR6gwi/DruZEUOeQ/yPmkY99t?=
 =?us-ascii?Q?wl3NjMgrtTJm4ts3UgzvRI9FTWbPJ8MqMO3YbHDqTA6gWaP+BL1CrYZcb7G+?=
 =?us-ascii?Q?jA2RwrTBIkCRceCsQL2tCg/WopDX9ntsSQaeANUSrbOAqgnPseEeyFQ7XSuU?=
 =?us-ascii?Q?X90mCMakaxCZvNbYZhtDw2Suu29UtL6ZxXzzVZ1Mklck/gxUIKCA8ggYsY+M?=
 =?us-ascii?Q?V/4rufbTn6neC1vOuWhZpGcBeP25LKkv4zomSGxsA8A2Vp8IvjbjxAqNahUj?=
 =?us-ascii?Q?1gYBrc7DsfAlMPl8aNTv7eV83h1B6uBCCsOVJdX7hS1s/Vi3SNxnGh9D9WWw?=
 =?us-ascii?Q?+8JkCtSD9VxTCyvQHrX+EP0doFjB0M77cCP4DwoEUd/VOdPsETULJ6edM0w6?=
 =?us-ascii?Q?RyLjyy6SBNhUkQwQ1IOGbQxEmgWtQanCd4HkbjnnTfN7nUnh9wNVsokFSkOM?=
 =?us-ascii?Q?7SSsvwXoLQPYa6rR/ElPI5n+njD/bBkk2apS2caEqzmlinRBrz2ifNb+rZQh?=
 =?us-ascii?Q?Mmxf6Eb/s7wmTqsSKZgzAJSXRJZF3WRn+wVf9sHPJEnq5R9BBrtWL/6zy7xa?=
 =?us-ascii?Q?YjJRCN5IDdeSgPErlRgo2VosyESNFZNYAsysqf/9BsAB854cJaYbTNH4plov?=
 =?us-ascii?Q?C0xYODp8JqfyOrg4P//ivGw3Ai7rtRM=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 35525d20-6ad2-4582-1b78-08d9b40b5133
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 14:11:35.0276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IIvAKGT5mM9GrRf5znXUAolPwFjz7b97EhtUYfwyHOMjPwH9AAkQpokCQACGzp2WUuIkHzmZj8cSsIYfd7kSEXwKbisLMkOv54Y9zDob5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4590
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

