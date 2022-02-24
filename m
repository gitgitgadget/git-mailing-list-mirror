Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF23C433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 10:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiBXKHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbiBXKHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 05:07:09 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150048.outbound.protection.outlook.com [40.107.15.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38E2DEAF
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:06:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acvGj/72lf7JIo5Dzmox+7VX/UPd/yYsQqWhYG6bI7pNi+o5/KIR2NUuw+6AW6SOm5R5tRw1V422ij5JJCEskiytlfeiNrIUuIyPr4utjCsCzIvTMcf7VysX5GkUukhXNHo1Nz0+L50N8oMleAApCFcQxJDQ6+8cvbICiHAyz1jWnrCxB45JEOlPAnkLySO4BClL0j4z3ZkSxg8774S27oZ0fgjjggAnDZizw3EOdKZcaMHBdFMPCkS68RvM059Sac8okRYgHXeksAO3oPcXoccmHHsHNhzBwzCsqcTdblET9gdtxwZPIefdlfo6ZGO7qdrPQ3nlBRzlDHV5p+2zUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAdKFi8RTdNTKKRI4zvahsi3wGL1jpYM2mdYZ/f3sag=;
 b=OC2QZNLkG3u1pA5P8KLQB4SArpPdNfNUh8ZUQb9/nEwf9Ohm52ZufweENzRM5iC1JtpCw81PfPdPEM9DJFrSW8cwoI0VQMMBHIFhk7w/EU5z8MXfrX2OOJGyMPEHfqB2yerSL+McBf89FI5i+dyJ060tyoi2LW1WZFsKGGu1IgxV2gzJUTD8TjdXk9tqzLPOtvU80VJGAnkMUzmNoL+HCWhpyuCNMwb0GetBmGQaT5i8Zrglm5LQsTeg26o3SMDxcFspxxExhW2ZUUGXrjjr8pWPgaSX0rmH5HWYq1cb6EpIrFlL8thQf+fo9BHsFUpQLWCR1HRXUkPsQk5/7Wwzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAdKFi8RTdNTKKRI4zvahsi3wGL1jpYM2mdYZ/f3sag=;
 b=EY/AtIkcHl2XOxgpmK12Z7PbLt+5ZNT+LnEp4DNqs9QMTA349xH3176W6ZQRzsGEHXwnSIwRHUvO7VjXRt2CS1RNmqHqkfgid8eMDLUZ6t3Oag2gPugTrvSydMSncj2v6lZQ64lliZX7NYIuI/aWAEw4KHw+6/oMx0+f21P+opI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by VE1PR10MB2941.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:106::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 10:06:31 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba%7]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 10:06:31 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH 1/3] gpg-interface/gpgsm: fix for v2.3
Date:   Thu, 24 Feb 2022 11:06:26 +0100
Message-Id: <20220224100628.612789-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203123724.47529-1-fs@gigacodes.de>
References: <20220203123724.47529-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P193CA0106.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::47) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baddc4cd-80ad-4f92-c2c3-08d9f77d54da
X-MS-TrafficTypeDiagnostic: VE1PR10MB2941:EE_
X-Microsoft-Antispam-PRVS: <VE1PR10MB29410C58CE572F242A27B53BB63D9@VE1PR10MB2941.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmLnSzrzjPEz1Uw5Ur/ey7o3iZDC4eZFqlPRqtignP+Sgz/eNUmSRT5l7fSoc1QELb5t6MSJOcqpwWswVyMl0XFLZMbPBL1LkxYAhI3v9G05YgEr9o3V8M3mSpICBCGVM0lmDh/v40hrnmaQKBLk48sZn9Qn9O/jAmxX3F0OTzLmg14EVotWALXgbzrUwxEYC9nH08nryXOiJvyj+kZUJ9nUZVkz06TJmKIXt1ktfchsOzvIn2SIwaVsRQ8GpzxqQCKmXA1l3eBaAUHdwTcGiHtb/4qUFVtvxuerMD5F/6601nL87Qu6xkPgUEEJEkMjiyPkuY7mKnqups6/RIoFs0HaJqanZkTWpneZ0mOkmVlReCa1RxYFEZpvz0WrNHOSpdeANxDb+fCTvShhEWltTqM+FafjqE1C41++y1V7VEeJXB0oNdADoWLKFRpWXM70SDh2z0VGDm4aOo4LHGeyPvCHkQ6NEoZzenA6su5SKtu+wnu/DWWHDLJVsfeHg0pbwRYnb5/Mm0j/lAU0Cb5lDUujJaijA6oHFy4yVmWP9F3yqPlwlSZwTjpQ20Kb9G0X2p5T/Lhw/9Icij2qGHTTJf12m7BmuK3cIMZy+sWAr0HBLZwP79CYvv8GDlmVpPVfr6bacCB+kB40TjVyZYFo7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39840400004)(396003)(136003)(366004)(376002)(346002)(83380400001)(26005)(86362001)(2906002)(1076003)(66946007)(66556008)(186003)(8676002)(8936002)(66476007)(4326008)(6506007)(6666004)(5660300002)(2616005)(6486002)(38100700002)(54906003)(36756003)(316002)(6916009)(508600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6hne+bYx3/TYUlzcowugWcJ3khmMNVuNXZdbRGOMI1SNASeKYqPaSVa+hKT2?=
 =?us-ascii?Q?EcMnQXzUKAWE+ixPUL6P539ykYlow2cG1i8e4KoO5uGoNrLGB/KlLMs/WKJs?=
 =?us-ascii?Q?FgrpGb1+sTEwwdMVFI+RkjLZBbFajwKs+uqnmtDmFze4y8uznQN+OvByjP6X?=
 =?us-ascii?Q?FM4cSI0znqQNhdfjSSj4wZYK0l8O4TKN+OvFRAWOaypqA3u1gPQySdKqZPRI?=
 =?us-ascii?Q?3IsEmy5w8bWB36fbmVPVfbA8zs9hkL5qg2N+g/79TnbDoesU8rcCD3jWwMHm?=
 =?us-ascii?Q?VIO9mPtAQu+4HaFNTjYD9SxrQcQZMeQ+If3ptiA1yZOOg8nFQwajs9NxD2QQ?=
 =?us-ascii?Q?e4t2KbitjsDttmkIMRxXb+7uaNTHA3AL6KESYNwd11SmM0YYwOOHCWLB/uI5?=
 =?us-ascii?Q?5RpSRrAuiKGUYZ8LW737jEqhcg3Hb1d8djo7YeSRtGXh0xPLxAArTrgKCIdp?=
 =?us-ascii?Q?Y9I11av143TWWeA/TbitmFcbixqQARYDqS6O2ds3NPDDTIHjjO4eY38IMr95?=
 =?us-ascii?Q?1D3Id8ou8+QJU4AfZ1J5WUKamALBNwzfiaR8UWSQ2cXdOZTMG2h3zVIBcLTO?=
 =?us-ascii?Q?KZMn6rRdlQZ/n2fYyqNE/GiANGGYo+QG/Op0DpwlSSje54AMbJKiC1DxoLvf?=
 =?us-ascii?Q?xoHPMIPhCF4cexcGaWgq0pNC+ZiNfvhj9+BToAahqXaFRTMHjDqFcCHUcXFd?=
 =?us-ascii?Q?HsbjREnxr83a9M/0bIlx24QwAa3PBOgBxdGMeQ5xQ3/bK64iXzEGaP7ZbivX?=
 =?us-ascii?Q?PbySGiN+4mBbXB/OEKxwDBap0LYVhVUtHZVOG6INiOLj6Y0TxrBvql10UUQ4?=
 =?us-ascii?Q?UaUfD5A08lXzqvUSTx5H+71m2tF9AnuavfgLX67aWELXtfUrpSHpt2EhfC3f?=
 =?us-ascii?Q?tM20BZModkxL1l1gvDleyP9j5bAdFqJ19v/gA7kidi3OW6RmlDWpNbP6eLcC?=
 =?us-ascii?Q?X03A8aG2zc7zn/ZsAzkak7GYCHqCUHBYx71ygf7xpoLIfVe8YibOxGp5gKdX?=
 =?us-ascii?Q?JcMIHaki4Er64vnwRFeQajHyUcEcff8PpEtKRFNEnWZV84hhaU+Z1dsFOVAs?=
 =?us-ascii?Q?Bc9lGYj3zMoMdXkwZVRfqFyBxun+UDBP0o+NlDlYW1JHemGat1qRVh3+5ZTf?=
 =?us-ascii?Q?3LkDEO9Hzr3jnVAiHEkZBK8U2CgvBdn7sF+eUEBza7zB8R82GY++gwX0D3AD?=
 =?us-ascii?Q?UbPPVp5d983rjTALWcInWHo2RdK6N9tsSsRfUmpLtW7O25Ppq6SbguIagODh?=
 =?us-ascii?Q?N5O0891SZiJt0pCaERA76QnMkwnH0+Y82+IHf1kfAOZcmKWZjvu9JJWT85Rb?=
 =?us-ascii?Q?pF5mUYy5D6IuzsVvSIdVGLc3MD92KZnGQhQOIJwzNwVK9vf72iwoQ0zKXbEH?=
 =?us-ascii?Q?ulibn1zleh8qQ6lLdCCvqBPvGLOtNKnMD4Mh8D+pDiwDNIpEF2utXYcvk1W4?=
 =?us-ascii?Q?btVN62EOoT5/P61O8TICp78J0W7MdoLmdALDVNYDXHtUFE7uvjlALeTP08Ji?=
 =?us-ascii?Q?HYCHltuej4vQ9b3nneqOqZS9UdXrvKJMqJSYd93ZuwOUccWL66GOxqQ/WzB6?=
 =?us-ascii?Q?JmIgnL4FYi3FwvfDyHAMrGzE/JimRtRq/QS8+ehTl9Fl/iZSA7Va72cwzqHz?=
 =?us-ascii?Q?q3HckE22CB7WJf/Bc/lWHA66HCqa70ulsGuh31QSxQ8nPc6svq6nb830N3g8?=
 =?us-ascii?Q?P70HVn0XC1eBwGtZaujYaP2Z+kI=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: baddc4cd-80ad-4f92-c2c3-08d9f77d54da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 10:06:31.7949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qjN7Rca5ZJ7JrSnNaOjH7+SObE2PaCxlNccbX/y5zx5u481ngch9Lnni56sz53ZUcEwR3lIlat4SB9qSw5Q2cucOGUY/bBaZbffeBELOXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB2941
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gpgsm v2.3 changed some details about its output:
 - instead of displaying `fingerprint:` for keys it will print `sha1
   fpr:` and `sha2 fpr:`
 - some wording of errors has changed
 - signing will omit an extra debug output line before the [GNUPG]: tag

This change adjusts the gpgsm test prerequisite to work with v2.3 as
well by accepting `sha1 fpr:` as well as `fingerprint:`. To make this
parsing more robust switch to gpg's `--with-colons` output format.
Also allow both variants of errors for unknown certs.
Checking if signing was successful will now accept '[GNUPG]:
SIG_CREATED' on any beginning of a line. Not just explictly the second
one anymore.

Helped-By: Junio C Hamano <gitster@pobox.com>
Helped-By: Todd Zullinger <tmz@pobox.com>
---
 gpg-interface.c | 9 ++++++++-
 t/lib-gpg.sh    | 8 +++-----
 t/t4202-log.sh  | 2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 17b1e44baa..94abb3090b 100644
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
index 3e7ee1386a..e997ce10ea 100644
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
+	awk -F ":" "/^(fpr|fingerprint):/ {printf \"%s S relax\\n\", \$10}" \
+		>"${GNUPGHOME}/trustlist.txt" &&
 
-	echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
 	echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
 	       -u committer@example.com -o /dev/null --sign -
 '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 544f0aa82e..493e376e73 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -2013,7 +2013,7 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 miss
 	git merge --no-ff -m msg signed_tag_x509_nokey &&
 	GNUPGHOME=. git log --graph --show-signature -n1 plain-x509-nokey >actual &&
 	grep "^|\\\  merged tag" actual &&
-	grep "^| | gpgsm: certificate not found" actual
+	grep -Ei "^| | gpgsm:( failed to find the)? certificate:? not found" actual
 '
 
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 bad signature' '
-- 
2.35.1

