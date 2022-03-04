Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6328DC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiCDK0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiCDK0N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:26:13 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B2E195308
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:25:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjZT8rAyg/CEyCXFMKsL/4WsirQWtVqxvvnnCkNqhToi7KEjpMYFLe7efQ6mquWzSY/YppQyeoIHErXN4gHFLWudmrFey/7xWLkN9ipywEkTSrGm+DRQ5VrNemhCKQZMfboCHWvVJdo5Z31X4w5BNuzA98iJ7WP2EHaIj3b3mN3iLz+Anl1LVx2ufwRb0E9h4jdYEM3w1oanA9Oni/Nt7Wn46lDbpQWCH65miGU3JmR7QA3IDHk2CLrU8uRh78S8mX52Y8PjJWaSpgEFYZXmCgXPJjTBtSXHSBTGc6r1wmehf1uskwSLBq2ZuSMBjF+4tiBATSMeAjiRoZM/Ptfdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPw5ux++LwsikNYaj+gT3teygmlMvhDEUJ+NYBf48vg=;
 b=KvMBEzHIg8U5E4k36/DvffjS2KnSzlJ18/kZH6+X8KEHNo0nquLzlIKoeKCXnZJx5qoIoexgI/i5/2HXRdNTMp6GPrG4nEr6Ok/LUJuXJF2LYlWDCXCjEj1Z0OHl6/ZMSkk+1j9+OTeaYtk3CDbh9c28y7Vfm1iUdjilCj7ZFXsDLR5ViEerN74tZt8CGiNpAVUtT5VffHuhnEvM1WvwIJmG8AIxdrJVxQiZAJVmvdmeIdfcs5toB7Wz+hyQI9LGqFg0VYCk6gAegbEUzDrloDX3A6EAqmzH6EP7IEY2catqVky0qnnxhhPOPQrGGMjOiEd1F3Z6N4JSzsw76vDnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPw5ux++LwsikNYaj+gT3teygmlMvhDEUJ+NYBf48vg=;
 b=cnf/x63Wa5tleGltU/gqZudRV7uix+f4oYmWpazB//SSh3PCIv6q+RysN2ImGQ+Ry9vEf6qaNWkxULBVjz/LLoIRcMSQb7g0qwbzwJPnhdyIdcZ2XO+cYVlsBWrvVKtma7J/ArQhucohpySL+QkAeeQgQ9sWmee7juv5FulhHk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by DB6PR1001MB1222.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 4 Mar
 2022 10:25:21 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba%8]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 10:25:21 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v4 1/3] gpg-interface/gpgsm: fix for v2.3
Date:   Fri,  4 Mar 2022 11:25:17 +0100
Message-Id: <20220304102519.623896-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302090250.590450-1-fs@gigacodes.de>
References: <20220302090250.590450-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0061.eurprd07.prod.outlook.com
 (2603:10a6:203:2::23) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3847ec84-fd62-4489-7295-08d9fdc94986
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1222:EE_
X-Microsoft-Antispam-PRVS: <DB6PR1001MB1222592B169A29D4E0B6C984B6059@DB6PR1001MB1222.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWs4AxjTr+Ra0GueLlEGT0zlHndyiF3Q5jKfF1Hh87FcHnLnxP+3EWEeHGG7rsI4No6d1IfRRM1w66yyA6A3AS+KO7M38Cr09LfRbdVoCUkFGfqYSpIqew8t7elknFHWbGDZxdztKGwL3vKgkvRc1wO1N4/ZQtP+Z8QGyVKuW7T1OQ1XghhnACpWy0WWTn4IcWKzRes5VWrYxxG6uNKdyPU76M3CkrNJudpv0XZcg1RCHyBs+nyMH3ugOu+dwJeZt/K4kY4E85nrUgC1OQs1f2luC+lOCBgWlAR/GBnJJQpLHHpDLfriLpB29EpYga12WWlPfoeHWEXpHV7qheqzfWSGTZeFNgHlto2IWvZAQtu4DpOKvI8/zXKACxN3hs5TYnnK4RcNiljNJs5rEymGl6rcKkHPTh+8lxMtCVsaKXeoqtNY5/Cxtf/z5jLVEbHcpAe6/kpGoisHfUNHyt8qfIBQ2ycJxp7XyxVnLW1p9cnKF/suTuN9wzeWGy+6V8YcibYj4pIYdWvnBxbMj5MF0sGQmdC170Pyb4rMO00sSVajiW64i/thJTP3rkUOp/FcHiQbcSXjswnqC3BjpwRPDu2mACa26xOS8ZXBQTCHKXQ6Huu+0gpLEB/8aDKTW9Um3IaUhI99ibWBcmfM36zHeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39830400003)(376002)(346002)(136003)(366004)(396003)(6666004)(54906003)(6916009)(38100700002)(186003)(1076003)(6506007)(6512007)(2906002)(36756003)(508600001)(6486002)(2616005)(83380400001)(4326008)(66946007)(8676002)(66556008)(66476007)(26005)(5660300002)(8936002)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tdw/39vo8QV4Pgfv46nJ+PHpch7r7LP5wW4VnA/cc+UfioRAMAym/LIAEhEa?=
 =?us-ascii?Q?GeaFIWKWfAGAEy1T4VFKaEeRdAEiuY8vHBEoSTPQU6P6ZJ3qUd06RYW7VHli?=
 =?us-ascii?Q?F25D2j0FLxEW1tH9mzy533LQjfZ8JKsZUorFGc1mNAXIGm610d4vUknyAlxv?=
 =?us-ascii?Q?MffYQ7NgvlqcOE6n0VivuYUae+Kt1LHqObAhILiSCGqCJ6LkA1GvKZH/dQiF?=
 =?us-ascii?Q?QgC1YyjYav3r+AU5ybUz5qWMFnvUm3BHDhuv9VeWaAf9ArS4wQ7Ak8wGFq9z?=
 =?us-ascii?Q?Ze48vr8HA3Waiaf7dTEnSV5AEHsryfz5w2bjfZd+kfSdYpMqgM0PnOomrM5t?=
 =?us-ascii?Q?Jv7A8NRkp8CZC6NfizYdrsLaFyxbuvsNafVHgepajaeo4UpUtKxrSklGko5Y?=
 =?us-ascii?Q?XTYxdVkUi2fSC0EO/LKIbkmUbpB9bbxAr2voApL8jLIEDGNSq3r9VQYGIAJe?=
 =?us-ascii?Q?Q7AxHUsOydWWlDnBgFuSF3md/XlwEnlDLtoTMfm0fppTZWx+zvWroCj0UWZn?=
 =?us-ascii?Q?8Ayj2e0VWDgwoe4SA5mdDXaOavqgTCz+7rvaZ2+PlsqZhDXYg2ITTt+cbnxO?=
 =?us-ascii?Q?iOzD79Tt7QkTgE6/2YtqJP1UyxHUi/SHppmPCwK+d6O3Y6PtthJIyk247vRn?=
 =?us-ascii?Q?4bBsaxjuiIq1cXs1AJQPghIxfv/5Y2VkzlhIt9S7VFer4zvdjMtHS+QbUN/g?=
 =?us-ascii?Q?sPgf552Rfebtfj6IlwRmXL0qxEgvldWfBL/jM9b/U1P9vjH+4JBw8INapWPf?=
 =?us-ascii?Q?TKpIcgR6iC2guZH8Qsk8uzdk/ip1M8CIrBERF3ZqzQrhUTO0d/Dj2lopTrRC?=
 =?us-ascii?Q?FNm8uOjWLpORmDcgUdrnsANKPBCP2VxtqKUSbEJds5/SSnM8jEV+00sl33o1?=
 =?us-ascii?Q?B3R2YJ6yD0aWYwHZ+neHPG2Q0cMll/v1VejT/7uP8jtkx+8EmWyObn4q+2Ol?=
 =?us-ascii?Q?pI7QFPOKZ6Zzr2stnv9AZ8HqxlTkKjYvelqCNokFcBO+sOoKqLMelcCEDm7e?=
 =?us-ascii?Q?wDKoqaclK9RF65YaE+x+UFDV9BBNcP12E95z/DgFfxbDi5oBHg7Ux+mB4z5i?=
 =?us-ascii?Q?ns9cS1Qv4XnfdNFukWy9dcw9CN4hUbzZ/XBSW68I0xDrxqSHaDhAPpm8vO+X?=
 =?us-ascii?Q?ZFioouoA9oPN4ucP2YEPtlMrmmFXWuMUftkAHXsPuVbNnVHtJxRbZw8efQJV?=
 =?us-ascii?Q?xrYBOabnH1VRUXT9Cn/Pd93o0qK4Y09RjaEVUxZFrgigQOv+1lCmXLhxbV2l?=
 =?us-ascii?Q?HI50uuFrDmJKE/KRAeg/x3NElDJS6CjQUUNo+oe3PZQrjM7jtfY8W8rzjVUJ?=
 =?us-ascii?Q?qmLbfk+gE9bZXDRKIX1adIPj0WwmzmauLzcQNxBIm7T6Zh6a+xu6/fLxMh/G?=
 =?us-ascii?Q?NQ+gwo3EknSTZhLrx9fqwfAN9K6bJgKYm2rTdYi/Um3Dz8ya72+cdglpIVUm?=
 =?us-ascii?Q?Ej+Y98X+zHoHAI3VoTmDalXpEFn54yanazL/93v/pJXGQ3bRmlo7CpMrIUDM?=
 =?us-ascii?Q?scX4rCXT4JZSGET+ApWS4UUlK/KEtS/x1Fa/c72BV+WkdAw+5Ru1lmf0Tjnc?=
 =?us-ascii?Q?Fz54IWleYvw8Lb4eGg/cizWNq2g6nU0jt50SiMh3B9EXbQ3QN8iH/wyeeGpQ?=
 =?us-ascii?Q?BwPZNPtItvju0z0OuWAB7v/2A9ZWe0lbCn0eqXhcbcw+Gl//Vb/W22Ii8KjD?=
 =?us-ascii?Q?2nRTGyESGDXjdl/3W1I16DrpcN4=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3847ec84-fd62-4489-7295-08d9fdc94986
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 10:25:21.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhhmmWUn/R6yvnasrmk253G7zh3fmtFhgSGcFDx7sSMIyk6dwEje+e7YHtTVM4zJS496KZN4yiyuwj19NvgXRO8sV6nrtNOyi/29Ktq2Fns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1222
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Checking if signing was successful will now accept '[GNUPG]:
SIG_CREATED' on the beginning of the first or any subsequent line. Not
just explictly the second one anymore.

Gpgsm v2.3 changed its output when listing keys from `fingerprint` to
`sha1/2 fpr`. This leads to the gpgsm tests silently not being executed
because of a failed prerequisite.
Switch to gpg's `--with-colons` output format when evaluating test
prerequisites to make parsing more robust. This also allows us to
combine the existing grep/cut/tr/echo pipe for writing the trustlist.txt
into a single awk expression.

Adjust error message checking in test for v2.3 specific output changes.

Helped-By: Junio C Hamano <gitster@pobox.com>
Helped-By: Todd Zullinger <tmz@pobox.com>
---
 gpg-interface.c | 9 ++++++++-
 t/lib-gpg.sh    | 8 +++-----
 t/t4202-log.sh  | 3 ++-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index aa50224e67..280f1fa1a5 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -934,6 +934,7 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 	struct child_process gpg = CHILD_PROCESS_INIT;
 	int ret;
 	size_t bottom;
+	const char *cp;
 	struct strbuf gpg_status = STRBUF_INIT;
 
 	strvec_pushl(&gpg.args,
@@ -953,7 +954,13 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 			   signature, 1024, &gpg_status, 0);
 	sigchain_pop(SIGPIPE);
 
-	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
+	for (cp = gpg_status.buf;
+	     cp && (cp = strstr(cp, "[GNUPG:] SIG_CREATED "));
+	     cp++) {
+		if (cp == gpg_status.buf || cp[-1] == '\n')
+			break; /* found */
+	}
+	ret |= !cp;
 	strbuf_release(&gpg_status);
 	if (ret)
 		return error(_("gpg failed to sign the data"));
diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 3e7ee1386a..6bc083ca77 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -72,12 +72,10 @@ test_lazy_prereq GPGSM '
 		--passphrase-fd 0 --pinentry-mode loopback \
 		--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
 
-	gpgsm --homedir "${GNUPGHOME}" -K |
-	grep fingerprint: |
-	cut -d" " -f4 |
-	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&
+	gpgsm --homedir "${GNUPGHOME}" -K --with-colons |
+	awk -F ":" "/^fpr:/ {printf \"%s S relax\\n\", \$10}" \
+		>"${GNUPGHOME}/trustlist.txt" &&
 
-	echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
 	echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
 	       -u committer@example.com -o /dev/null --sign -
 '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 55fac64446..6306e2cbe5 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -2037,7 +2037,8 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 miss
 	git merge --no-ff -m msg signed_tag_x509_nokey &&
 	GNUPGHOME=. git log --graph --show-signature -n1 plain-x509-nokey >actual &&
 	grep "^|\\\  merged tag" actual &&
-	grep "^| | gpgsm: certificate not found" actual
+	grep -e "^| | gpgsm: certificate not found" \
+	     -e "^| | gpgsm: failed to find the certificate: Not found" actual
 '
 
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 bad signature' '
-- 
2.35.1

