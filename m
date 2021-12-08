Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA1DC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 16:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhLHQhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:38 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:45379
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237126AbhLHQhe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 11:37:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur56WFyJqOwR45T1Zus5zLEeAa1j3C0fkI5Ahd3eNtRai3MRSA/K1IiXpBFO+ApRiVeYWaDs3chqMMWRyvm2pxrr96z37+SHXSky2I8F4Dm5IJOZshW0/kM5jGRoc46YMgQcyD+BCztEvWw5BsaW76Qa8AEFRHSjX6yZGHiH2EbkKzgAQp0LBeO/RIgF9WH37dlVHEt5q86wevqZRnSz2ZzLUfiURTUClRLi4PvpwU30caJrOWXB+ya67KxvrRRfG0dhJhVsteLz9u0SxSGLPKWdw6hbEMMeX5g+8YoV7FJhPvmjogt1X9gexkzRU49s25GLuu3+q9bLKyrRsP1K9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GJazhYhjfKBtvvh1iR5lBPvTFZKmn7Fey6rbc/EDBE=;
 b=fvT5ceVmA5EMGTbaw/AUgFsXzfPiEgi51yFAVcEJHCPykSCe2f/0eo3ghODdnDuu6+FcjwGJ4GfTfaW8pBwU70dA7g7Pl5HjbrzSxbmq4dwaCjKpMIwsCXrS7Q9ydIWLWpuCxqDWEIIrZC/zkPg94eXAG2/4TgV+XIg7gJpOTim/VL8eOKCCDso3o/d03W/AB/a2pyaMvT3IIlV4p1TEH/CHU4f+j181Qw8qCn7lyrrz7UNt1TekyxNrQt36MxYLtFx2hiMjhn3DLO4Fo0Z06M6NQkXQbJfyE07xpyy+07cECPAUwTjBDjYWFMAbAKYm/UfGRMqixeo+up9RpeXJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GJazhYhjfKBtvvh1iR5lBPvTFZKmn7Fey6rbc/EDBE=;
 b=bPWavHLeKq+AN8uIR2ryhPyCbenadrv9kcViwpGao//nm21xxcmqxSSB2MwhKJyuEVDDDu6A0YdeTP9YlPvqisQ64VNf/DHeiq5ph2bSG7k04/ws2QpMn4/KHUPUdQbXCseLCtb5Y7BuDxbVvsTdcrnBJsGfJcKuALYKZyX+c3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 16:33:55 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 8 Dec 2021
 16:33:55 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5 7/8] ssh signing: verify ssh-keygen in test prereq
Date:   Wed,  8 Dec 2021 17:33:34 +0100
Message-Id: <20211208163335.1231795-8-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208163335.1231795-1-fs@gigacodes.de>
References: <20211130141112.78193-1-fs@gigacodes.de>
 <20211208163335.1231795-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::29) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS8P250CA0024.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Wed, 8 Dec 2021 16:33:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee18b049-7d7d-4212-c9c5-08d9ba688728
X-MS-TrafficTypeDiagnostic: PR3PR10MB3914:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB39145FD8206CFF184AEC30BEB66F9@PR3PR10MB3914.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ay3gyja871qU5KHGefIu0ow9Z+H/NsOqMYJgiNOMVpyDxsQpkJ4lSdyD18k3VbnyarKSfpiVE6eWZxLDb1c3SuaXSOH7pjSIe4JHFxv3H2C5iuMqs9TKNsHN7FGIqjMOVFuLeBhy/ly/GdlvNAVYY/oYNw3Fsi53tGEwS50vVFkUutnJ38dnl1G8YJJkaphNE2p2+Ip3aIX5HZSVHhR26WwHplJvovMcF8cjrsSEkXah400o+MvcVzr/YDaUJ81+EvgSEmZMXsBUw6y5Vc5pGS3L01cy2MgGmcLkTKqZ+4rxcqxFBjbVyKn3AwbIOmFzjc90vsxnCp4kUHKEPSquufHbmWfd80chKNeLb6PxUl3l9RteCqsBSJHZyY+Ch5eibWN0uJfPk1zMZ+mmUeO9MqRy/KY1ktCupqB7UzRjVT1WAr7TkpCWV84ZJAHqD2jKYurN75WBTuwFjU13T7ijdSYALoBx+Tx346VPqzojwdMgFjddsB6o1uIldC+4mmYTkijN/KayDjHxwZH/Aj7P2anuBr2p3cueu5pw10VaZPyLglPJGi+PL49U9OT7KAo20qZJozLK6o0pn07ujeADxz8AtTESNdoEJRkHyvdL6uZvTomyxkI6bKR9j89QyUx/W6FkY3FlYWposzdxpwOWsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39840400004)(508600001)(2906002)(6916009)(15650500001)(2616005)(186003)(6496006)(36756003)(38100700002)(83380400001)(66946007)(8676002)(66476007)(8936002)(6666004)(1076003)(86362001)(66556008)(5660300002)(107886003)(54906003)(4326008)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WVLCiFIyfEpcdIe39eC9BLgP1K4tBaEEj1I0Jf0yQ06xdkfKZeCiKEX/kkOP?=
 =?us-ascii?Q?35hkYV7kBvbhp2EV2OG715ccyme8xdggKIq3izXD+nYNqevk29j3+ZP6Abf5?=
 =?us-ascii?Q?h+sYY7U1oSNHP+cUTFmfixsZgzd+kW4GhrLsMm0MLRmD1S1kf3CQ5+MKiMWq?=
 =?us-ascii?Q?Atc9WMzP4R+kv+bQ6BKRPkTL45Cm93GuCavxbZXaKkXR0M8IXa7Gla+rthjC?=
 =?us-ascii?Q?9ZNEFtts8ht3nORUqcyD/b9DAvQAAmB713dwXNPL6nbufL1PCN9ank1Ut0bw?=
 =?us-ascii?Q?MrEFAgDwMvvcqBBOWdjCyV2rUgQnZGVEo455N0joF3L69OtgjqPJ3iiWB3dx?=
 =?us-ascii?Q?ft7TDc99CvCaP2fcJ380PgFbSVEK9z2bfEev+RYbVs3tg1t24OENj4KQBOzA?=
 =?us-ascii?Q?k8QYiV8y565TtjfftdKKaWOVcKzSgKpkmWGg5ij3Y8zQ5jBFadrUSvc2AA/V?=
 =?us-ascii?Q?oLXm+s/JoIzRHtxgXgi7YUo8EtxhI54vguHyxSpC7DCTv+tWZjms08yMqyEw?=
 =?us-ascii?Q?W3BWqimFSMpbND0h89AwLDtHBFgJxlUQbx988X3Bhqd1dZTxPxoze7jnyZXC?=
 =?us-ascii?Q?ba0jmAb/3l0y9pcltBDrfEqe/y+PR6eSOy0NcOozX0bPFtn54GBqmXok6/iy?=
 =?us-ascii?Q?SIoChCfCZNsNhufIcJefO2SeYjlJGHtM4Ji0DkAMCDqJUiRzmDhmr32dYYzI?=
 =?us-ascii?Q?r/bWZ6hdXugLFzy4wKF/cohGi1ICxTT35bTNsFFmXisuvzSCXIRJUR1cGSeR?=
 =?us-ascii?Q?GLP+AcGE5e0EhJFTppubYxAE7gGL9W92242gG39iyej9QL0WLOLOVwfKGKPD?=
 =?us-ascii?Q?ppfVTc6Q573J/MgKEXsI9ddaViZ3W6KY6HypiYbUr0fzpcRXfrCa7PFFloMz?=
 =?us-ascii?Q?6hXwwR0zgscj3qWHQVXSCjyUXjDjYDNQ7lRB6BClujZIMLYEuNvleMkAYB/S?=
 =?us-ascii?Q?RBjJ1gfuRs4A5GXuqgXdRUQ17EA/y/fQvQDVFEoLA3MA2lj1bpKKtz4nDRUg?=
 =?us-ascii?Q?eeZ6DueBONVI7QVvkSQSwf+YkaCNiMUK31nyfAuFEyKXLHwjlLfPo4TwOq6o?=
 =?us-ascii?Q?1i8O+Xazdw/kZAVIkwK+IanEu1mUXMJhL6vKo0CfugjE6QR5D7UQVCu107ww?=
 =?us-ascii?Q?FJFrc/m1IT60vOikYJZOfrDLE2jAeLpe6b64H5BIxulxrEYn4eacOd39ZvIv?=
 =?us-ascii?Q?8iKd0Fdx9S3b1Wo/IPAUPfW+6l+OgyLX/Xb+c0uiA44ukGqyekSQq1AHq1xf?=
 =?us-ascii?Q?86faABLqFWwdyiT2xPKJMXDUn7RkZcmYW6aAS0wy2oqv9mMRaQnN9FB6cc0I?=
 =?us-ascii?Q?1ueNkzYsxcQBExLk8NJPqKpff4OFeE2TbVzLSTLaJRcMlSkAPwIYRQEj5Mxd?=
 =?us-ascii?Q?sMPzkAzHmZ2Af/akvc65x8cyarmUm2igzKNceh8Mo3PiyOkfSBGMVveGrdQF?=
 =?us-ascii?Q?ezGo0O68NJQCd08PmG0K1PmPDcyj/miF4HyVsg0kJKv9lKApsuuTzUv1tILa?=
 =?us-ascii?Q?O5Dv1jY7L9xJHNW9Cg8/9d+wmpexpoQvu/8E+4QuLmzWgjAh6rUpSTQf2lHb?=
 =?us-ascii?Q?m/h0D0EVjLIxnQB1D0c6sHQzQPdDlFJZdrE2vpeiS2NOhLYP8LDLUqsQbjo1?=
 =?us-ascii?Q?ln9UUSN2v8bYenJ6iOPsaNlbjMRAkTP2DSNLmw/i1OGwxRFjJHzMKgUa+5Cp?=
 =?us-ascii?Q?e9rBxZhrvu+duWEfioYzm7V9h98lxOrDXB+9u7aB1ftoFPUOXZr4WkG27F/Z?=
 =?us-ascii?Q?Lo287/hFUQ=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ee18b049-7d7d-4212-c9c5-08d9ba688728
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 16:33:55.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehvFA4xl6Nj8/0JmjoPetSzDqT8ptuPjIjAegZbSY5XAr1hQ+Wv81uvnKVT4Vsw+OH66HOIQ/jzilMgb32nsEDDSd6RUOc7SU0zb4vJekOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3914
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

