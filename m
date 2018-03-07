Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046521F404
	for <e@80x24.org>; Wed,  7 Mar 2018 17:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754704AbeCGRbC (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 12:31:02 -0500
Received: from mail-by2nam01on0135.outbound.protection.outlook.com ([104.47.34.135]:46532
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751189AbeCGRaw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 12:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=a0rMF/+Xu65sSTjAO3FZ74zcKIR/kK7c2Nn++hEUVtg=;
 b=Ph+xJn6oQ0O03TeikweTwwHENeBx5ZcQNbOKowQXWlNeACb5Yb1nHpoP0K82WjpiNvaQhEVc3T5VbhxGHRS0G/RVyknGFmnWEE0r7IFrjWFVNL8z4S/MM3POATxGUkqvNR8GmwP+NalowxuqqzO3hkpseG4kX5G8L8c46a5W2gU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from neu8r3hm32.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Wed, 7
 Mar 2018 17:30:44 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 0/9] convert: add support for different encodings
Date:   Wed,  7 Mar 2018 18:30:17 +0100
Message-Id: <20180307173026.30058-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0083.namprd15.prod.outlook.com
 (2603:10b6:101:20::27) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48e94303-0c84-460b-222d-08d584512af7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:3mDU8WsfktGKFTqPlzj6He3we7lcg4Q/yNI7ia3L/oztOcADdALts/4LcXfPyEXxWyjoDQvdLwM7RH1xgC9skaYCpXN45tnaHS3n2cClfIQKl9NPFuL8zRha6uef6RSSTHX7DLXyMDk4/L8VCNzdLoDOfClCGutEO9tfGZkb1cVVFuQ256+r7FQT8njtHuXJe+8wAbnVpSQkeEsKsg2ylryJhFJOLDdLF2bf80JsK9kNnUAhlpZGTtCoU/Yw6RQg;25:jWEqkT1E9f0Iij7JGCUvDsgp3QNlRn9A+WY/mM4tC3G/ziVvHEL35tXNQb6xOTl2G4JO8p+EeGZkL5FF1HWJ6DC7lQ2GNP1jPDvWjT3CO+Wva7Oc2XVr6O8qN18jqCcmkTgZAbKVG9KRZkdQX6+kM5tYeB07R5apwLajkrZI/pjp02SWUCf38eucvIdmmjRAy8xwAstX1FZx8yoUER4+RG4JAJzYYcs126V+2+qKvF0qgZKlDihpbvM2ie31PF9qXG3iI27fddmAlW1+GNXIjYOUM1HhQgfA8xUD+QzdVTsVK0h4sf+RzVhYfvIMHOQ1UGent0a9zeOIACRAqOHOPw==;31:ArMY8xNEtyeyLIl3n5XLOHfolMMMg0Wes/xls3PV3n7AZYpQ40YxvLizIp1Ek8vFM1CsYKAFFAGdsNmtMONRdTA+4yB34xAJGidRWE+jDG4XpZ3DhUlhLBSL4ng0a+ZOBGGDfCmf5mZJ2BLFCFpQT/IK1AsajNxU0pP2ZrRmZ+bLYU2htKaaZHDzDzwKUmP5820FcSapIbMMrTLq4kgKW8QBByIx4YnllWiFNJvQRqU=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:dn019fsdcZazF44fyOdip0LAn0axrY+E/3Fmz85EsRp395FfB1Y0JGc8jUR1AWa7o3kCeMM9Agr3TewkJMbyQm8i+3SD13xHBE46FCsyu60uw/C9RVnTA1+94SI1ld+IH3Gn0wOBJgZ/pY0O5DuG7ThatJ+gPnJCnE1aKlvIK5Up+BI7sUpGuuxf1ToQhg2lD2ug6oHc1wzaWrFKhEIAExa+aqWCSa6wleK0wQ3duNzgzm8lw/OR6HIxLKcGVf4FnkH+aneH/sVoehahM2XolqbfsBYXdAptxILnk0eXc0V0OStDfM29HB17Bd9GnA1nUPJjy2D5oqaV99ZvWqmzCPparJ0MheLTDn6kZRILw5m5trjdeN/Al8GdC8ILefcnrJpL5igynIThTmIve6EOQxrth0OJSGqQax/WefY0pxjv7i4eXWco0jehxVIgxyi7YOKFCEuSKnkpvFG4o5gEU709uwTy1UFFOlQddipzZrtzJyaE2vW440fHOHQcXpnYA01D9kE1Utah5xnzXs4Mqe2KRs53M9Okcba4OfPIMANJItjN9Bwh3ZeNrrBcaUw0qFhNAXFNotkaTY3FlkFdFl0c0QgBRX1yn6vxDNtRe7I=
X-Microsoft-Antispam-PRVS: <MWHP136MB00148557B4527FD97AB06C9AE8D80@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(85827821059158)(788757137089)(245156298449039)(61196332173343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;4:vbm1kNXQv6sLu99rd+/+gOWsThNR8AiMJ/Q5OH9V8cCdf7ttnlr03JwBpL1ftdFYq6W/31bHyu4K49rFISOEeV2PtcqShbRiQg1iYMb4myayVENKHFe8hpy4iide7ptVB4nd7iDzkQ7Bt6ituwkFMpqEIW8tX+8RhA+Gwy1ikZcKbPMdcC1bmn+8CWVIhwF7i6s/3SIab9JPmIfxOtmS+2zOhRJxRiM6vdISxiWdwgxTwv+Hse5L1nlNUBUmU75e2yaCUF1TjQ5/nuy0EshDTslpbRuO3yhYmFociz8KxCD7XM4H5j9F4yJyVOR5fbBZNRVKAdXD2Jt+s2eoKJgO37C8MsGu98YR1bYmfywK4j7UQouoRxEmTOuK7g/qFlfmAQxGT3sOJVP34PeJ7x/dlpOC8lvK6gH9ySlih2RkKvhua4afjrm5NCht8L2/Ykea
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(377424004)(199004)(189003)(68736007)(36756003)(53936002)(9686003)(16586007)(16526019)(186003)(59450400001)(6486002)(4326008)(26005)(6306002)(316002)(8666007)(386003)(8656006)(53376002)(39060400002)(52116002)(7696005)(51416003)(97736004)(25786009)(50466002)(2361001)(2351001)(966005)(105586002)(85782001)(50226002)(575784001)(86362001)(478600001)(6666003)(6916009)(2906002)(8676002)(7736002)(48376002)(106356001)(5660300001)(305945005)(81156014)(8936002)(81166006)(66066001)(47776003)(3846002)(6116002)(1076002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:neu8r3hm32.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:8khllZreSNZIHlCbo5PY+VYbWeMY6stwsHu6jjUqP?=
 =?us-ascii?Q?qQeCrzuvhHjPZnz/gyr0z+27icKe0sQuylzxzUHRt41RaISlYEOAtSMxhOxa?=
 =?us-ascii?Q?KBjAaXoEyXXGbpNdh5Vf4nNco6r31k8Sfcv1UztNH3vLJLUN0V+WJQhxJ9Fy?=
 =?us-ascii?Q?6T4if8oNk4o6iHbfvMBaVAjIm5ed0I4YZT34ZVopbp+PcBg2cyg2CESPNDz+?=
 =?us-ascii?Q?CUIDUwhkQFM8fUoFzOee/ughrzRd8tHV3Xrx1k/WAi8he2mGVJ5BzCbiR3cj?=
 =?us-ascii?Q?jV1VbAlt0tvFvbQHCR/oDaFi9lvFfTnui/3dR5wQrEKy0xnMGLXy2RWAp7qI?=
 =?us-ascii?Q?YF9eKIhVjiL+f1/4ITiqUq2FqE+/7Cm/UHo6xf7Ebsr24H4LSqvuGulBEQo3?=
 =?us-ascii?Q?XYszKjV8MgSPhyWPHnveGFtXRFwOI8ZDXCgUbJt+DX82Oj7K4fXh7KSB4RRq?=
 =?us-ascii?Q?AX/WbNPI+5H3CfG0P70jUk4U95tvNUtItabcDdQ8LTrI7AIc1hPxVUGN6vF4?=
 =?us-ascii?Q?2XrPnrJrkYp9Enf3WVVdTeGLyBytMaTEg9hn/pRaSAdS0Gb5HqDheIoRl1Xz?=
 =?us-ascii?Q?yjgK2B0l6VgnQMttFLRtD8z0mtK/Wf6NFrfxVPS/nEJbySjkvb0CFArGUJmv?=
 =?us-ascii?Q?Vtte0hn6KGamr2mHqDfMiDNAz0dpfRkq0Fpaz2GkjY+EydOnkB06EIOoVZxI?=
 =?us-ascii?Q?aOgFFRh7k45uOPFp3qZOi9ChHTUyjnwz5EMoOuW5eFSfYRyFoy5M1YgobVwP?=
 =?us-ascii?Q?zyyjzKGDzzK5qM1YsPjkRxvHIKpS9Dg4KDZ1B8TGyQQoZufzJoxLoVBTOkE3?=
 =?us-ascii?Q?peKMwk/AH5B8ruPYIyb/oqCSlS73NgsUGw87DFRALpGxFddE2XZWLFujdQ0g?=
 =?us-ascii?Q?9uj4NLe2MOmDb1oQ7N1H3SswjOSh+l9P8vyfYWkGwxq87ZH0uyRWYDBbgfp0?=
 =?us-ascii?Q?oyWbrGz5NupANL0rKwo0l+armj2A/TlCBPqmNsXXim/CUvB7Svr4OqN4znmd?=
 =?us-ascii?Q?RS8c639ECbFGmJ4YiCniTaQ4R0AhLBT6rb7/UwFuB7ed5DXS/7Rya/o0IwM0?=
 =?us-ascii?Q?AfTu8L6AKY88hpXtz5nH4Bq+B7tE9Ld1LiPz4/zEoZGaN8Kp6RiMvB5IUWu9?=
 =?us-ascii?Q?KkNbaRkyYFpkgEhBr7NbBW/Opt9RPPuxAWr9mrZvbZUFz/SH4tyvkdF/Vvml?=
 =?us-ascii?Q?cdcFRe5+KMajUOYVKEnWO0AgETomWbx1+uZgTWJbMSqdJtjPNNhQg7gWdQrc?=
 =?us-ascii?Q?lzm//0PVE3mZUdXmswd6woDHn8YumiWHlvtzWS1nA6zYioim2p4bwEaqedkZ?=
 =?us-ascii?Q?F2164/6lZmpwAS1uTdInXbHQk7C+3jtD22WTCy6vg1tsRjrVgX3PlUtm+gcD?=
 =?us-ascii?Q?V4ykw=3D=3D?=
X-Microsoft-Antispam-Message-Info: Ci7QPK6n58p/CoNJ1fLh8wP3v7guR2s66bfuIYj+6bJI3HmDHUDwP4WKsxkdN9ojeaoQOwFYvy2ROEDuCKouFGjQdkUr2cXu5GuQs+x8530kJSX6zECMCQjPD287pws0NrdxP8izXsJReiDg3r7tkrvfYQ/cvGFeeY8hHw7ckEw4N4SBn/vq7SmPgIG801FK
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:pt/Nq5a0t052jEaNqYewODoOwaWn6UdYDIQXYBYlhRuT3E9YJqZxJFSL2JLfvGbeGI5a5PPQ8Mqkny/KYbA9lKTFjDmzTrExXmTVQGJ9xRY52bk11p586FaYpKZfjNB+rw+fblZg9NUk9KbLnF/ovZT5xMIPuPHTYQuamdE4jm8kKi453KwI7jTmIitdXEhzYZE37Rriwp+XN3g6fQGYicI8gK5zeAXLwA95Fz7IEZzDF0kWXqg/L9ZODSvGKpInIL8ujLB78/Ln79L3U60F+IKsRwkxUOKl2t3a4B/MTWB9YGticPMz0AzP0cDlErwbvpHJYaSz8QcvtZPHfgQeDtO6j32DAwleNjIgu/5t7hM=;5:z10jOgnObkhXqt/uM2ft7J+92G5BLZ6aGrVITD3HU3VRO4RZ97l6sgpgoflYO6baLOF3iaae3RLF7NJrwpg1WTZn+fLByQ0bN2nu446IcV4ElBF+6kgV7zcGoNMaJoKNjuuw+xTJ0e9UKA8wMWBF0T6DWlChW4ZZK/1KuKQBvKw=;24:fJwWjFZuLufZtwiZ7OewwVDIjMjFgkOrzCQp+fVX2c/80OEiwrxdiKsEgfiebneN+yCenNvCCTc/GQhdzjQ3KtWDsRQV8gdMyZ+YQfjRDjg=;7:PAVufNxCh1Gx129R3Fe0NH8sxpjZRQx6D6eFH2kJVHPwXvafPnL1nFNh+pSzs4zziuOmeF2LZ1QIXOtJUzqKI2y6VIpkDBtcDnKJ+7Yv/k/lnrIc4zMVkHcuwGPELwxvdqV7Ld3GfoCPfjWTVvQdOfeo5PNkEa7MmJDB6nK5otY0GrQ8Y6UwLgdpMF0gu0pve3cvjaRl7n7mowtdZi67PZ4eJN4diz77SuhsyhNs0OLCyEFlp4HGN186JQbQr0xO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 17:30:44.9755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e94303-0c84-460b-222d-08d584512af7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

Patches 1-5,8 are preparation and helper functions. Patch 3 is new.
Patch 6,7,9 are the actual change.

This series depends on Torsten's 8462ff43e4 (convert_to_git():
safe_crlf/checksafe becomes int conv_flags, 2018-01-13) which is
already in master.

Changes since v9:

* make has_bom_prefix() / is_missing_required_utf_bom() more lenient in
  what they accept (ignore casing, accept UTF?? and UTF-?? , Junio)
* replace memcmp() which does not check the length of the strings with
  a case insensitive variant of starts_with() (Junio)
* do not convert encoding names to uppercase
  (this fixes a leak introduced in the last iteration, Eric)
* do not cleanup test files that the test did not create (Eric)
* do not cleanup err.out files in tests (Eric)

I did not address Eric's feedback to make validate_encoding()
cleaner [1] as I want to stabilize the series and Eric wrote
that we can clean this up later:
http://public-inbox.org/git/CAPig+cSoka-yBTYBz42JGQTyCH7LDWnToeOvdZfG0_64o9QnBQ@mail.gmail.com

Thanks,
Lars


  RFC: https://public-inbox.org/git/BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com/
   v1: https://public-inbox.org/git/20171211155023.1405-1-lars.schneider@autodesk.com/
   v2: https://public-inbox.org/git/20171229152222.39680-1-lars.schneider@autodesk.com/
   v3: https://public-inbox.org/git/20180106004808.77513-1-lars.schneider@autodesk.com/
   v4: https://public-inbox.org/git/20180120152418.52859-1-lars.schneider@autodesk.com/
   v5: https://public-inbox.org/git/20180129201855.9182-1-tboegi@web.de/
   v6: https://public-inbox.org/git/20180209132830.55385-1-lars.schneider@autodesk.com/
   v7: https://public-inbox.org/git/20180215152711.158-1-lars.schneider@autodesk.com/
   v8: https://public-inbox.org/git/20180224162801.98860-1-lars.schneider@autodesk.com/
   v9: https://public-inbox.org/git/20180304201418.60958-1-lars.schneider@autodesk.com/



Base Ref:
Web-Diff: https://github.com/larsxschneider/git/commit/a602b8dcef
Checkout: git fetch https://github.com/larsxschneider/git encoding-v10 && git checkout a602b8dcef


### Interdiff (v9..v10):

diff --git a/convert.c b/convert.c
index 6cbb2b2618..e861f1abbc 100644
--- a/convert.c
+++ b/convert.c
@@ -269,7 +269,8 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 static int validate_encoding(const char *path, const char *enc,
 		      const char *data, size_t len, int die_on_error)
 {
-	if (!memcmp("UTF-", enc, 4)) {
+	/* We only check for UTF here as UTF?? can be an alias for UTF-?? */
+	if (startscase_with(enc, "UTF")) {
 		/*
 		 * Check for detectable errors in UTF encodings
 		 */
@@ -277,16 +278,18 @@ static int validate_encoding(const char *path, const char *enc,
 			const char *error_msg = _(
 				"BOM is prohibited in '%s' if encoded as %s");
 			/*
-			 * This advice is shown for UTF-??BE and UTF-??LE
-			 * encodings. We truncate the encoding name to 6
-			 * chars with %.6s to cut off the last two "byte
-			 * order" characters.
+			 * This advice is shown for UTF-??BE and UTF-??LE encodings.
+			 * We cut off the last two characters of the encoding name
+			 # to generate the encoding name suitable for BOMs.
 			 */
 			const char *advise_msg = _(
 				"The file '%s' contains a byte order "
-				"mark (BOM). Please use %.6s as "
+				"mark (BOM). Please use %s as "
 				"working-tree-encoding.");
-			advise(advise_msg, path, enc);
+			char *upper_enc = xstrdup_toupper(enc);
+			upper_enc[strlen(upper_enc)-2] = '\0';
+			advise(advise_msg, path, upper_enc);
+			free(upper_enc);
 			if (die_on_error)
 				die(error_msg, path, enc);
 			else {
@@ -301,7 +304,9 @@ static int validate_encoding(const char *path, const char *enc,
 				"mark (BOM). Please use %sBE or %sLE "
 				"(depending on the byte order) as "
 				"working-tree-encoding.");
-			advise(advise_msg, path, enc, enc);
+			char *upper_enc = xstrdup_toupper(enc);
+			advise(advise_msg, path, upper_enc, upper_enc);
+			free(upper_enc);
 			if (die_on_error)
 				die(error_msg, path, enc);
 			else {
@@ -1216,11 +1221,7 @@ static const char *git_path_check_encoding(struct attr_check_item *check)
 	if (!strcasecmp(value, default_encoding))
 		return NULL;

-	/*
-	 * Ensure encoding names are always upper case (e.g. UTF-8) to
-	 * simplify subsequent string comparisons.
-	 */
-	return xstrdup_toupper(value);
+	return value;
 }

 static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
diff --git a/git-compat-util.h b/git-compat-util.h
index 68b2ad531e..f648da0c11 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -455,6 +455,7 @@ extern void (*get_warn_routine(void))(const char *warn, va_list params);
 extern void set_die_is_recursing_routine(int (*routine)(void));

 extern int starts_with(const char *str, const char *prefix);
+extern int startscase_with(const char *str, const char *prefix);

 /*
  * If the string "str" begins with the string found in "prefix", return 1.
diff --git a/strbuf.c b/strbuf.c
index b635f0bdc4..5779a2d591 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -11,6 +11,15 @@ int starts_with(const char *str, const char *prefix)
 			return 0;
 }

+int startscase_with(const char *str, const char *prefix)
+{
+	for (; ; str++, prefix++)
+		if (!*prefix)
+			return 1;
+		else if (tolower(*str) != tolower(*prefix))
+			return 0;
+}
+
 int skip_to_optional_arg_default(const char *str, const char *prefix,
 				 const char **arg, const char *def)
 {
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 23e89ae623..7cff41a350 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -52,7 +52,7 @@ test_expect_success 're-encode to UTF-16 on checkout' '
 '

 test_expect_success 'check $GIT_DIR/info/attributes support' '
-	test_when_finished "rm -f test.utf8.raw test.utf32.raw test.utf32.git" &&
+	test_when_finished "rm -f test.utf32.git" &&
 	test_when_finished "git reset --hard HEAD" &&

 	echo "*.utf32 text working-tree-encoding=utf-32" >.git/info/attributes &&
@@ -75,19 +75,19 @@ do
 		# In these cases the BOM is prohibited.
 		cp bebom.utf${i}be.raw bebom.utf${i}be &&
 		test_must_fail git add bebom.utf${i}be 2>err.out &&
-		test_i18ngrep "fatal: BOM is prohibited .* UTF-${i}BE" err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&

 		cp lebom.utf${i}le.raw lebom.utf${i}be &&
 		test_must_fail git add lebom.utf${i}be 2>err.out &&
-		test_i18ngrep "fatal: BOM is prohibited .* UTF-${i}BE" err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&

 		cp bebom.utf${i}be.raw bebom.utf${i}le &&
 		test_must_fail git add bebom.utf${i}le 2>err.out &&
-		test_i18ngrep "fatal: BOM is prohibited .* UTF-${i}LE" err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}le" err.out &&

 		cp lebom.utf${i}le.raw lebom.utf${i}le &&
 		test_must_fail git add lebom.utf${i}le 2>err.out &&
-		test_i18ngrep "fatal: BOM is prohibited .* UTF-${i}LE" err.out
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}le" err.out
 	'

 	test_expect_success "check required UTF-${i} BOM" '
@@ -97,11 +97,11 @@ do

 		cp nobom.utf${i}be.raw nobom.utf${i} &&
 		test_must_fail git add nobom.utf${i} 2>err.out &&
-		test_i18ngrep "fatal: BOM is required .* UTF-${i}" err.out &&
+		test_i18ngrep "fatal: BOM is required .* utf-${i}" err.out &&

 		cp nobom.utf${i}le.raw nobom.utf${i} &&
 		test_must_fail git add nobom.utf${i} 2>err.out &&
-		test_i18ngrep "fatal: BOM is required .* UTF-${i}" err.out
+		test_i18ngrep "fatal: BOM is required .* utf-${i}" err.out
 	'

 	test_expect_success "eol conversion for UTF-${i} encoded files on checkout" '
@@ -141,7 +141,6 @@ do
 done

 test_expect_success 'check unsupported encodings' '
-	test_when_finished "rm -f err.out" &&
 	test_when_finished "git reset --hard HEAD" &&

 	echo "*.nothing text working-tree-encoding=" >>.gitattributes &&
@@ -156,7 +155,6 @@ test_expect_success 'check unsupported encodings' '

 test_expect_success 'error if encoding round trip is not the same during refresh' '
 	BEFORE_STATE=$(git rev-parse HEAD) &&
-	test_when_finished "rm -f err.out" &&
 	test_when_finished "git reset --hard $BEFORE_STATE" &&

 	# Add and commit a UTF-16 file but skip the "working-tree-encoding"
@@ -176,7 +174,6 @@ test_expect_success 'error if encoding round trip is not the same during refresh

 test_expect_success 'error if encoding garbage is already in Git' '
 	BEFORE_STATE=$(git rev-parse HEAD) &&
-	test_when_finished "rm -f err.out" &&
 	test_when_finished "git reset --hard $BEFORE_STATE" &&

 	# Skip the UTF-16 filter for the added file
@@ -219,14 +216,14 @@ test_expect_success 'check roundtrip encoding' '
 	# ... unless we tell Git to check it!
 	GIT_TRACE=1 git -c core.checkRoundtripEncoding="UTF-16, UTF-32" \
 		add roundtrip.utf16 2>&1 |
-		grep "Checking roundtrip encoding for UTF-16" &&
+		grep "Checking roundtrip encoding for utf-16" &&
 	git reset &&

 	# ... unless we tell Git to check it!
 	# (here we also check that the casing of the encoding is irrelevant)
 	GIT_TRACE=1 git -c core.checkRoundtripEncoding="UTF-32, utf-16" \
 		add roundtrip.utf16 2>&1 |
-		grep "Checking roundtrip encoding for UTF-16" &&
+		grep "Checking roundtrip encoding for utf-16" &&
 	git reset
 '

diff --git a/utf8.c b/utf8.c
index 5113d26e56..81c6678df1 100644
--- a/utf8.c
+++ b/utf8.c
@@ -552,11 +552,13 @@ static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 {
 	return (
-	  (!strcmp(enc, "UTF-16BE") || !strcmp(enc, "UTF-16LE")) &&
+	  (!strcasecmp(enc, "UTF-16BE") || !strcasecmp(enc, "UTF-16LE") ||
+	   !strcasecmp(enc, "UTF16BE") || !strcasecmp(enc, "UTF16LE")) &&
 	  (has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
 	   has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
 	) || (
-	  (!strcmp(enc, "UTF-32BE") || !strcmp(enc, "UTF-32LE")) &&
+	  (!strcasecmp(enc, "UTF-32BE") || !strcasecmp(enc, "UTF-32LE") ||
+	   !strcasecmp(enc, "UTF32BE") || !strcasecmp(enc, "UTF32LE")) &&
 	  (has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
 	   has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
 	);
@@ -565,11 +567,11 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 int is_missing_required_utf_bom(const char *enc, const char *data, size_t len)
 {
 	return (
-	   !strcmp(enc, "UTF-16") &&
+	   (!strcasecmp(enc, "UTF-16") || !strcasecmp(enc, "UTF16")) &&
 	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
 	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
 	) || (
-	   !strcmp(enc, "UTF-32") &&
+	   (!strcasecmp(enc, "UTF-32") || !strcasecmp(enc, "UTF32")) &&
 	   !(has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
 	     has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
 	);


### Patches

Lars Schneider (9):
  strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
  strbuf: add xstrdup_toupper()
  strbuf: add a case insensitive starts_with()
  utf8: add function to detect prohibited UTF-16/32 BOM
  utf8: add function to detect a missing UTF-16/32 BOM
  convert: add 'working-tree-encoding' attribute
  convert: check for detectable errors in UTF encodings
  convert: add tracing for 'working-tree-encoding' attribute
  convert: add round trip check based on 'core.checkRoundtripEncoding'

 Documentation/config.txt         |   6 +
 Documentation/gitattributes.txt  |  88 +++++++++++++
 config.c                         |   5 +
 convert.c                        | 268 ++++++++++++++++++++++++++++++++++++++-
 convert.h                        |   2 +
 environment.c                    |   1 +
 git-compat-util.h                |   1 +
 sha1_file.c                      |   2 +-
 strbuf.c                         |  22 +++-
 strbuf.h                         |   1 +
 t/t0028-working-tree-encoding.sh | 230 +++++++++++++++++++++++++++++++++
 utf8.c                           |  39 ++++++
 utf8.h                           |  28 ++++
 13 files changed, 690 insertions(+), 3 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh


base-commit: 8a2f0888555ce46ac87452b194dec5cb66fb1417
--
2.16.2

