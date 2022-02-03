Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A8FC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 12:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350535AbiBCMha (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 07:37:30 -0500
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:24199
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230213AbiBCMh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 07:37:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dikf/bIFv67tCCxcLCpMwl384laElTvX0UYQSnAiexsChBMOGl4PaUUyluF3i5adaqwMB43LrlrFbtuL9YvdlqURekfEoVHLfeqln6HpOaS4A9DZ2kBkrO72oeoSaZZNHYEbyEqPIu71wu4jE8X+I2FQP6HaFBxIRwy/L6IhimKn6VV+UjYQtONvIXtQrlpFjvDgeGaLgiGyIkoIxNQ8Xy8eg86Lx8WK/apYmuVSh705V11Pw3B3SYLyhx0Ls8ZtGJ/REkf5UW5GC43Jbozu04QQS6Ti/QIdPLKyrsP6MJ8CSZyHyWAlxepULdE2nyILXkD0nQcOONV99tN4po3qbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LShF5t8k8rDPTOOfvwx5x7n+lufAF53Dvhu1avfc4iE=;
 b=bjBEMSXi3OfpTJ5vSuRfyXHzwx37/RTRbjGtWg/epIZ+t8GGpsEycdWqiT2TG4UnpYxMzilMyRP73oszmh8tjfkH3jZG/NJzeooGFdgaMQ1Z27rc4dsaGQka4xnbyt4M1a7uCawVxjme8wlRTS2HMFixtBLerEnEhiyOR18Lc2D4/EI/bcEWRIdVM8AUffiUMAQZrJPvgsXyr0B0pB7aUpQg9nDzuy/R+ilBuzJWnC+RsHUNcpD5xGWIVjX+5yAwIPSKRV0qTz6h7zcTyCY5DS94vikcZNWgOuGnVdwFrX2hM0CEf/xNdoSx3rCpS45WArLT2BDhEff544JlfbS6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LShF5t8k8rDPTOOfvwx5x7n+lufAF53Dvhu1avfc4iE=;
 b=OotMpex7gfPNj8fZ2kDEbVmsmonMqzl1O7vnV8hYGQ/RvAPTTMVERJzbr6y6x7HC4jqMz50p2o177xjKo2to9CfWxV4HWj+8+Gab6UdZfgWPrHEvFBBuWBrdpYo63+70pBhJa/8JBZ4eBt1o9aQ8h0SSgxFz9raNAXPKgQrfO2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by DB6PR1001MB1398.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Thu, 3 Feb
 2022 12:37:27 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%7]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 12:37:26 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH] gpg-interface: fix for gpgsm v2.3
Date:   Thu,  3 Feb 2022 13:37:24 +0100
Message-Id: <20220203123724.47529-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f28f79a-7586-45d3-1a18-08d9e711ef6e
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1398:EE_
X-Microsoft-Antispam-PRVS: <DB6PR1001MB1398D15FBB82E9DA1E9FB244B6289@DB6PR1001MB1398.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8iSoNJTm0E7hezXJol+iIIryR08khlAn/vV2y9MlywntWpF04JO7jQOfGbopO1kAiDDet7efBXQixaTVDc+Yg7k3uaModsD4NNGnNzVag7uJJDl4bmf9mZKA2gw+WlvgGKQTFpZeqS2YOveqF0KvAduY8jhZaxuzWcdgOdPBWQlnA8B8/s4H8jnGzNfEw8pT4iUPkq46Js1sL/h94p+psJefwf1rbf0u+qyMOZF2J5jvBz5pn4oPftKUNsFY5Ru6mfVeDXWhDbI9puSltXOqie8qOwWmDrRyv6PkRK2NMQ53hacse/A9yt6VOFgI8Z+shzKCF4EZEd3aQgqEYx3nyWEDP/fBXQ3csdeDDKdbzAeERGU+GXuoMCv/8CrdDKer7H5jb9S8sSgYgaI07I9cK5Ie68AtVI4c3ISQEclLWPoJYfUVp8y0KyLWaszBsp/OX0l3Upg5Ogso9eypkatX/g3twaEbFT7QicKaiDl5cgkY3VYVFMxViAA02uAa7zZTBTMm1HFt/zoGMpoG5Geg0yb8GxG7SzNlPJkpUahwqsQD4y00RH7fRvxF3caFwh8/kF7GxiyZHh1KDW71olHiLVxTjTf8N8rvrKQeYti/GmkFvr8wcbK3oUUD+vY0UOPAfMxzAhs+enmMypsE3gXHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(136003)(376002)(366004)(396003)(39830400003)(86362001)(2616005)(508600001)(1076003)(4326008)(5660300002)(6486002)(6506007)(8936002)(26005)(6512007)(6916009)(316002)(54906003)(66476007)(66556008)(8676002)(2906002)(186003)(36756003)(83380400001)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i4G8Q26CHlKICazOGWLAwBD5D4nzrJKu/TiilwPCkDpAQxxwnnkBI/gKBY/L?=
 =?us-ascii?Q?8vyNS/m4MP9UAdBJcgccvPmNOcyWFl3Cerf4fdtXOH2OXwR3KO3HfIvrEgDE?=
 =?us-ascii?Q?u7T9P7UTBADyMS6iKblozxEqjssZIK56UzIvds8/qvGmV59RGrALm8kA3389?=
 =?us-ascii?Q?4T2w/Yw2xVF4l3wFz66nups8yBxhBAdlU++S6c4uVVtiEraBjVBJ657FvRhs?=
 =?us-ascii?Q?TYE4ih+nhcBAfH+98eW+U9Sc81ZbpJEOWUiyOb9xqubVxvSv9m5fryDr6NaE?=
 =?us-ascii?Q?IdvQ6i7PiBVE6o7AMfv0Jfp5z0885P2nSAqkLw1NYaFjA2mhVQW4zmTaNaHQ?=
 =?us-ascii?Q?I7xqGa9eaAywVX55LiEnzAUliJ4AZ+Bo3/ECF5aYWf41DSPc8vlwEtpFZ66r?=
 =?us-ascii?Q?GE1MA2tYFyWqh/sx2Jemh5UGP/IFBTTU3o1xigR+fqUxkY/ytWHc9Fo4VuvB?=
 =?us-ascii?Q?pI0Z0sdJeLCMY8JxQcWBg4PZmY/eVZP97t2NcV8mW0DbFOHQssXcTgrIPUAR?=
 =?us-ascii?Q?vYl37w8A+8FUh812mHjsH77U3BVVNr56YO6TGbwiQdHu7C1GKstJAlbY0ghs?=
 =?us-ascii?Q?Z91Z0pLaDKZuKoyP21/6FYoAXmFL/hTOvDWEkIc2yot9tUalBNRol/BIYCb3?=
 =?us-ascii?Q?S9tl0VqZvAEcohkMe6lHav8bhx7o9z5KMuxUFlx+JxT6Kl3tEXF+luEyrbij?=
 =?us-ascii?Q?g52Yj6nD9mtYWB/3iq4xTHgw0FBMKX/QYPyvKC+UVYDwZk+Za1N+ZtYSDTlX?=
 =?us-ascii?Q?hn4nK0T9TfIposA0KmYqPj2UcnSk8WSlaL1s1aNMIYkkVlDBuHa28rrPJ8JL?=
 =?us-ascii?Q?lPKZxFAT50+sPjy9cxyygI5+BgmSg9aNGZmW+0mpL3ntzfIt6oqAVQb2GCYz?=
 =?us-ascii?Q?g94PCLRg80gUIVR1UgHwJarFUDYcF44ZCISWB55Jjc/snLJe5/D/Qjg+J8vH?=
 =?us-ascii?Q?9GTDyMsruNeRkO3mjwF3upeSUzCDJCl904RBu+LtzLwMm5JsOTAqmhta+Me3?=
 =?us-ascii?Q?HSqSkZy7eL+ByWITYxxu2nRAcTS2QMGpDPz/xQXfuF2Vc/Lf41Fq6As3lQ/W?=
 =?us-ascii?Q?NIQrS+yaoV4dM3dAtd5shLA8wg2vGUtU+eAdATYIHvZzvFne4/fnglkXxlRY?=
 =?us-ascii?Q?mt1ABhwpzJzj9mZAkFkUegwslOWSQycpGyglvFrTjb3lCB8WomGHDrVifdnK?=
 =?us-ascii?Q?fkGqtmEct4eptacfbnIBQaH2yE1GYm/XfD5EnBgP3ZtCeJ996KskXJXYSinq?=
 =?us-ascii?Q?bi8fYTSfJlW25YFbnvP/N53BcDLAaB8eEqPqa+M1FHdTARP1AaepkzCqePDZ?=
 =?us-ascii?Q?EiTPkC+8dckcITNj8lfsMTOvf0JkiA8Peid8fRrArvkqjYbUS+f1b6ilIrIF?=
 =?us-ascii?Q?InZ2EMn3XhBvApW1vocSOl677RPdfjN7C7abVjCMKUdW7lsRkTMMH6iu9HxU?=
 =?us-ascii?Q?OYT+1u/JeJCZCmgv+f9BfvbdnMAfbaLibVSL2OuJEiKt8kW2cd95znWabUfa?=
 =?us-ascii?Q?WAsX8anCoIMWth/QXj7w1T+OIoRoKjlIEI6WwEcHOOB84YKQN3zewSzxONqE?=
 =?us-ascii?Q?4c4+f+GGngbkIGUMs/jB/RjZjVbh57ou3sF3lXlFdDkQYh4+rcPPI0zmUy/n?=
 =?us-ascii?Q?+oNgN0OV8FIAZ+px2MnKXeHBVAUcv2FFf+HnAXPl2eXdBccJmdZuXBnKiAgf?=
 =?us-ascii?Q?/HGWI0bGy+veF6wI1rU/J0pDcoE=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f28f79a-7586-45d3-1a18-08d9e711ef6e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 12:37:26.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72eHELQy0jPcsb2PftrgYy7hitcpeRgA24RL0zEgv24zUwmwSfddjDXDVsRrnoQqWoZ0RLtNuS1EjSAKgqaG7NV3Y2qUhIkEnR8V1V7PpRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1398
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gpgsm v2.3 changed some details about its output:
 - instead of displaying `fingerprint:` for keys it will print `sha1
   fpr:` and `sha2 fpr:`
 - some wording of errors has changed
 - signing will omit an extra debug output line before the [GNUPG]: tag

This change adjusts the gpgsm test prerequisite to work with v2.3 as
well by accepting `sha1 fpr:` as well as `fingerprint:` and allows both
variants of errors for unknown certs.
Checking for successful signature creation will omit the leading NL in
its search string.
---

I am not a user of gpgsm but noticed that the GPGSM test prereq was disabled 
on my runs so i investigated. The `fix` seems rather trivial and I tried to 
test this as thorough as possible. I ran the test suite on machines 
available to me (fedora35, centos8) and did a full CI run on github without 
any issues.
But if you actually use gpgsm with git please give this a go and let me know 
if I missed anything.


 gpg-interface.c | 2 +-
 t/lib-gpg.sh    | 4 ++--
 t/t4202-log.sh  | 5 ++++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index b52eb0e2e0..299e7f588a 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -939,7 +939,7 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 			   signature, 1024, &gpg_status, 0);
 	sigchain_pop(SIGPIPE);
 
-	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
+	ret |= !strstr(gpg_status.buf, "[GNUPG:] SIG_CREATED ");
 	strbuf_release(&gpg_status);
 	if (ret)
 		return error(_("gpg failed to sign the data"));
diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 3e7ee1386a..6c2dd4b14b 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -73,8 +73,8 @@ test_lazy_prereq GPGSM '
 		--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
 
 	gpgsm --homedir "${GNUPGHOME}" -K |
-	grep fingerprint: |
-	cut -d" " -f4 |
+	grep -E "(fingerprint|sha1 fpr):" |
+	cut -d":" -f2- | tr -d " " |
 	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&
 
 	echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 5049559861..08556493ce 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1931,7 +1931,10 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 miss
 	git merge --no-ff -m msg signed_tag_x509_nokey &&
 	GNUPGHOME=. git log --graph --show-signature -n1 plain-x509-nokey >actual &&
 	grep "^|\\\  merged tag" actual &&
-	grep "^| | gpgsm: certificate not found" actual
+	(
+		grep "^| | gpgsm: certificate not found" actual ||
+		grep "^| | gpgsm: failed to find the certificate: Not found" actual
+	)
 '
 
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 bad signature' '
-- 
2.34.1

