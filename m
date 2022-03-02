Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D1CC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 09:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbiCBJDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240312AbiCBJDp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 04:03:45 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50069.outbound.protection.outlook.com [40.107.5.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBDA1A3A6
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 01:02:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdhTXTWJrF/9Jw4speVxDP7DxwcZ2/zM1t3gZLPklkK2ZQhUb8RpY8JsMjtcFYMiIn7ciY9N0f6mx050XXNFkiQD9r69LCpY+gpcekVJYzGVVKUQqepHixE00VyxlPYt3jahvM2hHUor/frVizbAINEeSOzNbR7utoQLcR3gn54mPQNJn7UqYEPHXDxnH01nijaP+/vopreTv4CG3Ho0X6UMopRzAnpc4rfrYxzIZjb1YGwqMzGhdlolZaWbMkqYS8WrNwJxIdQkWqb3pwRYcZGf7qF1DiP8s8Kdo/l45xrkFoMlXC2qFrHpv6tv6ZrThdhoryQK5iWttUlulJ1f2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/Bn7V5PHkNUoIVQLooEWN9ExGJFGOAEtL/6M5bIJhc=;
 b=khJC+4NxZqD7DCzchQVCVG+Oe7ikGp2/fecuXPNuKXU9V40VlNrpQxlZnqg6PcEjV5CE3U4ug8q+2qbfZxipBeB1qSgIrylUqrIdn6K89IWEF5JuLmk0kKijzBX11iTwFmVd/8CDUt7PldcWsqSA4QiBA9IGbDIFf8Q3ppg/qif/f0TaOpo+m0eMyoHvzcCHqaf3DXLjTd0r+FTyJD6iUAV7n8QjosJvnS2HbnZMcSyuNUQsU9xyQVPSEivRPjRY6GGUVnY8hJr4ssizcupYuiPWVaGtrC3mXiuTcyo1nXWg+izB5VqHxFxXYyiaYm1qOKvH8QcxOF9BximTymH8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/Bn7V5PHkNUoIVQLooEWN9ExGJFGOAEtL/6M5bIJhc=;
 b=DU/Tcb6SDDO60WNBvN8FnMwyMchr69Pla/+MEvciXFutHjai2Wh2HvPYRyGPaFFoU318lqtRY9+Xd7huMFwEP8KTYIYSrKnK6I1pCfRicKBKBEeQpETZfXtbEhKOL2sfTPJc6qOaKozqtFSqgXzLyHQeJRgpzAvLvGM/7plIAyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by VI1PR10MB2015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:38::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 09:02:53 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba%8]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 09:02:53 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v3 1/3] gpg-interface/gpgsm: fix for v2.3
Date:   Wed,  2 Mar 2022 10:02:48 +0100
Message-Id: <20220302090250.590450-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224100628.612789-1-fs@gigacodes.de>
References: <20220224100628.612789-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0071.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::22) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 349744a0-3fd6-42e2-2282-08d9fc2b6f2b
X-MS-TrafficTypeDiagnostic: VI1PR10MB2015:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB2015019F48903CDCD6E097D1B6039@VI1PR10MB2015.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+z7vlc9sr8nqMY9SIta/dZOOYDjTjHywXigo0W6+UH2p4bTGvVJZc2LVej8uPMEJGi525Vyy9Bh3Pea5wx2MbfD0qFbuKJje329uxKuEOSJsC0pXtQnn+dqFVv5cWBgHuGeZ1f+LdKcb+wFxZX+DNpBIcy6VK9i7hpysJeZry7zbgLoBpCD8cQvD+aPT+bxV7gcF5Wg4CP47gnZlVE9tX0iImKKyGED6u4GlmRKnd4WrewY09L6UQFPOi8FRHfLrgrBdvUvW3a5UQT93cmc82Ki6byVspCsO6ckuSWpTnMJs0GlHn6PD9YZDJh6kf02HUQ49qdMFOThKtUt4uvgnGOXuAuSXQASb4YiBtHpXvZTgkNx5SxE/g7MCfAk6CJxOxZAYGTklWURVgbSn37GVnlUF2kaj9uGR1UIoRrBs4ysGYigxl/cQSZiqGdAiWEREZ8UgX4BjSIUX1JIq0pg+quV325nkZFTeka96QIbeOMzqCoPs4xyK0BiEDOvwaG8Gvfq8cmbHod2HIlIaKNXA7G9Ed9B9E8ZjxAnkiH6Whuy8zGbt7gXLFNgwyB4QD1cEOchE7hjlsyB1owGFZeGwmKfo1qP91TDtgpdJJQL6UEZS5AN7ozB+D7K4Cj8IdzSrkNwWjxixs3xD+1OCgilKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(136003)(39840400004)(396003)(376002)(346002)(36756003)(83380400001)(38100700002)(186003)(8936002)(5660300002)(1076003)(2616005)(4326008)(6916009)(8676002)(316002)(66556008)(66476007)(26005)(66946007)(86362001)(6666004)(6512007)(6506007)(54906003)(508600001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o0MFi7dZxlDoG0MQ4WOD3/g2kUliLJfT4sMJWxrH9GEENPY/s3Qy3CT+MPh6?=
 =?us-ascii?Q?xQdFUBFj0Ygawr4ubGQWzqjS/+8MATBJU26++3cmlZkovisAi0tdFmw9yzwy?=
 =?us-ascii?Q?NybR6g12LyxYOhlZkE1gEv02C71bim2K4P9uSU2byhUigdTxCHdPUfmGvEUW?=
 =?us-ascii?Q?+Utu0xAes8vfv/DozGXpqgGPTrovniVZpZII/BJP3tjljuUjr6emp8OyO/eA?=
 =?us-ascii?Q?ZhQ8+0tes8anrsFGEGLMErRF1HoSBhmoHRIs8XyV2jjwfsn6gA16GTTKqCIA?=
 =?us-ascii?Q?iq1NmBjBqg+cHlSEntFVwkqhcON8NkWYYuRA08CeipNU57ioZ975uPF8C6Lt?=
 =?us-ascii?Q?/kn9BwUniEr976wkB4id0TLRmUmUpf1Ek5mrq5cMOwVW/dXc1OJViEwVm2Px?=
 =?us-ascii?Q?O/BtmHttIreGaLc8uXoDa9XieEJG0/JdaRlCYR7mpI4Y4ayoTVY7fE6h9IT0?=
 =?us-ascii?Q?oSOeYQDdQ7RW1AlOie1SD2HKt8kCIbT+iAJVPILZDccAYtptEsTXzMC5aJqh?=
 =?us-ascii?Q?nOoJqJkYmuFaRtBQKEiUKBwWdT70IBdoqPdZ2/YGj8ePtNBXsqK7b4/2T/lJ?=
 =?us-ascii?Q?1/i9POf57rrBGY5dMWBaoluUsiZXJ9NDvF1p12Sgg4H15VKmhZOxyK/4rjff?=
 =?us-ascii?Q?mebcDs3Rf3u5b1rNYWyi/lNMx0XLEcXzRMXSG0o8lqbcH7sMSXCQ73v0GjsO?=
 =?us-ascii?Q?YmeWd8B0tj6GYSrNDpwAXThJXh+ioyre+m1DkJL2FD5nDvPz0QRGXD1/6lg4?=
 =?us-ascii?Q?X6dipBgnAv1VtYGPil+lPownZjtoVMqL/u0lc0D10jLxDtKNOcXPPq24C+4b?=
 =?us-ascii?Q?C8+HYNcuZIhhJSlMcAyct42pWQIjvWONVZE3l+LUrmjZqj+LESAAi7ST/xVg?=
 =?us-ascii?Q?s6t+KPr0RrK72hFyBkrpsr2IWARqiqeYJmkJLMd2Eypcb29E7fmAHvVvLbDE?=
 =?us-ascii?Q?aUNEEupYkRw1ftRNlKk+acQlZQb2/+bKDDBukvZlA1RfqiNeQEhOuLTGSlZf?=
 =?us-ascii?Q?QhRdRbvxCsz0T+1CFtWkW4gSjHi3n2CSEDy2Ely3LJNYT+fj9XCCHsdGqts7?=
 =?us-ascii?Q?J5uJPezWw5GGLoF+DfIP8rAFvYNCFDKAJfBdu5Z46CacO3nBEMKVCaPCxikt?=
 =?us-ascii?Q?GSoMQhErOYf2yEMHgVVQS1nLAFCU2CINizEjKFRG60CHv7t+UlxzMC0a74zS?=
 =?us-ascii?Q?2XMBt4vnj99rcj+WD5aGTA5JZDlcYF1ni/26N+SPIeTwGcBbwaPLTcll8O+e?=
 =?us-ascii?Q?0Du5qUOmzSdPGYYg/AhngBpc/YDsYVmiVmJQzaerjx98BWC7d3scWoc1KrvS?=
 =?us-ascii?Q?KayiySsXR1rYkYhB3VdznniYWb5R0RnSlndmAngdnzXjJ+0AtMVteDJyOJgC?=
 =?us-ascii?Q?o0p1vF1gZLT32lEQIayCL4BgYU6yIwREcFjZeeSOEGxicEQanfd63tpbXNvk?=
 =?us-ascii?Q?TDRQNxKzW798C6RFICBDXSFR2NZSKxh7o0YbHrPN5fQnEzKfbbupYty+7541?=
 =?us-ascii?Q?mwV8+O9so2aHr/EiFu2d1uZyU/jsQKnUa2KUT1DJ8ZqRDeMi0uMatY65zNnt?=
 =?us-ascii?Q?fbGgPNDxqmFgeRUAmc2b+cYvlx5tkHzn7psdbxv2Wc4F8yp7DJfDi3i4ikDD?=
 =?us-ascii?Q?gggJYHGABYdUgEnN+6TcizOWywe8wEfrnN3Z4Fhw+AbvRLiIYMmRwmN/nhwm?=
 =?us-ascii?Q?8+96FKyfxaWbJ8JbINvAPpGS62c=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 349744a0-3fd6-42e2-2282-08d9fc2b6f2b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 09:02:53.1495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REfFRBIjoNvhmCtYJftKhhfey7vvgQ+S+KSYern0Jf46/Fc7SmQlHHfbl0KP4yHbc8C1Exe+dJjBRjIL5F2VFu42Klgndc2pQQ3511MQEgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2015
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Checking if signing was successful will now accept '[GNUPG]:
SIG_CREATED' on any beginning of a line. Not just explictly the second
one anymore.

Switch to gpg's `--with-colons` output format to make
parsing more robust.  This avoids issues where the
human-readable output from gpg commands changes.

Adjust error messages checking in tests for v2.3 specific output changes.

Helped-By: Junio C Hamano <gitster@pobox.com>
Helped-By: Todd Zullinger <tmz@pobox.com>
---
 gpg-interface.c | 9 ++++++++-
 t/lib-gpg.sh    | 8 +++-----
 t/t4202-log.sh  | 2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

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
index 55fac64446..d599bf4b11 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -2037,7 +2037,7 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 miss
 	git merge --no-ff -m msg signed_tag_x509_nokey &&
 	GNUPGHOME=. git log --graph --show-signature -n1 plain-x509-nokey >actual &&
 	grep "^|\\\  merged tag" actual &&
-	grep "^| | gpgsm: certificate not found" actual
+	grep -Ei "^| | gpgsm:( failed to find the)? certificate:? not found" actual
 '
 
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 bad signature' '
-- 
2.35.1

