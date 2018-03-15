Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DC5D1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 22:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932675AbeCOW6K (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 18:58:10 -0400
Received: from mail-bl2nam02on0118.outbound.protection.outlook.com ([104.47.38.118]:45027
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932670AbeCOW6I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 18:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rupQgFN9SA1yHLnTEn7SiP2BqdvnAo+RgrUpsyJm6yo=;
 b=Yjggz35cpPRdGuNMWcViUHBsFpHw91p0X9WbS+A5E9kbHrdQQnITMM6+dzfm0lC0mFHVkDEyuoaDGEpHtLlRtTRmw8pkoZlPU9n8SHN6HBjnWhXcWUtug57b2bVn4RQ5cloMVps3pH+mZYX7LvBlRy+quFvP+8exdIJl41P4iXE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from rem2ua0031cfw.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Thu, 15
 Mar 2018 22:58:03 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v12 03/10] strbuf: add a case insensitive starts_with()
Date:   Thu, 15 Mar 2018 23:57:39 +0100
Message-Id: <20180315225746.18119-4-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315225746.18119-1-lars.schneider@autodesk.com>
References: <20180315225746.18119-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:104:6::21) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11d8914e-2f09-41a3-618a-08d58ac836b9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:DDVd6Ow9rjrkS0SBaLVxzAkv869ZmapsFmY+gb8Mp173ARxcjHBWfg9HTlWVUtw1uJMr4gHABiW//26jXQyqWqLJMabSnAaqArZMKWl/rc4ChtoVSVz+X0oeAjem8+BOUCwRf1ypMXxRbBG6IbK+/0Gal+RJ7X7stUaZjtZarj8Gz/shhhQ4j5sSgYMhxAhL3HYewj0DJ3/yNWd8z/Tu+cQPO6oIrVaMYupHnk7yp+lGLGmKXSIDwd2uJw9PBAGe;25:3W9b9I+RQR1dbzAJJnK64SNP74aGCg1pT9Z+KwMxm9hbM3gMp64nekf7WmCRxou9PhHornpwf0BdEWo1Bgd4KV9av7gl64cAa3W9kTYC83XV4FAZH6qmg63UY8jKvLrHXXloQf3R3wh51gbWkQc3wt6n7XsXA5LhttzN6oF3c9ypf8BqVl5/3LjJx6Y++s9MEIIboLV66LO45958QV224PaCSC9Y0PEPgCkByGVm3ihKtvDNbUIIwykqlx4ioc88DDXTFil4U8dfzPmfjHK1a2kaJPGC9xIZnHDKaFXmsGLCbb1iPbfCuF1HfANPeZc2OY/S9s0BgFiH3pe5LqPGRQ==;31:qYZ8DyR8/4oS9R+ab7k2ZrPt+RM2nf4RLb+maPvfcMe51FRaPQvwqnHLe6L9MAwVDYMLIlXeIybvUOX8xffwGM4LvRsE4nBC8ydtwSLzCVeazze3eI03oqEylXSqEhDIeLPhLnBlUp8Wy3YY+89daJZevs2RyB+e0HOk3quhSWjGkcuCu6igHKY1LM/BPy6ltSxESMN7MeWq6hDkqXN/5Jyx5BTcuBK7Pv9/KEbSwoI=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:A9BHqRxAzkEyn4Ko3s5pW0GRsSlkzpq/W1WycXpSZ1CAq1JNQBcHmO+HPetxuMPz6b2GNXRHjfBD/Nw7osc7JAv5rWpjzUWunvIUFO6Yiqfu+y6mT4s2gTMn1HxD02vYtfSSt92AIkVlaLGHxD/9nf9uv3ez2N/iXKm8nhMVpXYHAkNF6JBeWEKG2oZ8PNubbLek2ZtvfhYmATFYW6Dkv3nAr8rlXQ1+F9EFFTlWQb43YREzC+Iwmg83JoG0puoPZsMr5rcU6hlOkS9kwAreDBWfRbj+s5HM0a/00StRQfUcqLbHnA3VoIIda4FEbxBHETs/SropfElCLWmKu+2sAjpEHfQLDd04iEKVlbLgkJC639ncxnKPf9OFBQ1xdyc/zn4BAfrePeNpN7NDNcND6ZJslKhBv8jb0TSSKdJRXUu3aOBgF5ppN5cTPypUEdfnejUeOxPPQtAZhib+YoZXNZh23IZ4KxdzIT9EFuvYMcoDHD/pIY6subIaRSIyEakTXqkQZ8ihqBBPTR53ozvHu85gPB8r2V6AIGLrZiP+YC2T8+l30fLFvtLdRsX9adbEymWKbFEnD00mF1h5OH2IzsOM9gdnNnY6ZFiJ68cXSOg=;4:TDfIseryYFGJY2uqDuaTwzyLTqtLUCe/PlEurehDx2UXB2Wre735wVy0PviiajJ2qRRn+Qzs/i8TxeKfm8+gVTiKF9gCAeT/2KSzPDHPqVavvvxFNW7PuyXZU1tFGLzxTMAKfDXa70fHCEUIIJon7gYH30MNTQQty2rw0dDQ6yT3/eYHAYgTYEeARzN152WObsMZjgQLcU6hnRJCH+2wjvvy7XDa0BWr/FgcSsUjvpkWsUMdOeoM1XsUBmQTF9tIrR0/ZmvlqKnrc3Icztll4mSu43yLqIZRw8ouhnjHrOlzXKxZEz/TDsytCHOjlOp/
X-Microsoft-Antispam-PRVS: <MWHP136MB0014B1306AAE5F8B6F33278EE8D00@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501276)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(48376002)(386003)(86362001)(8666007)(25786009)(36756003)(6916009)(7696005)(6666003)(3846002)(68736007)(6116002)(2950100002)(186003)(66066001)(9686003)(50466002)(8656006)(97736004)(5660300001)(316002)(16526019)(7736002)(7416002)(305945005)(39060400002)(1076002)(16586007)(53936002)(76176011)(51416003)(2361001)(81166006)(85782001)(52116002)(4326008)(8936002)(47776003)(6486002)(2906002)(8676002)(105586002)(2351001)(26005)(50226002)(575784001)(478600001)(106356001)(81156014)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:rem2ua0031cfw.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:aVeS8rFK4spz6yHXFsRpYLGjwoIOAAlKMmkCpHudK?=
 =?us-ascii?Q?tifdxMJ6g4PxaEnASfqTKVDI0Jzg1oy/hyBfThay8fnf/TYwRgSKikTR7R7j?=
 =?us-ascii?Q?s10pCqsuuCIlRga3bu7Wkk9WlM5niAkgse5pU11hVpnfo4hOJ9LeUyX7VYlZ?=
 =?us-ascii?Q?76eRwStO+GxrJlaDk30i+lYn90tbBY1phLcQ/Z+ME7QqG6RXKOVvT+bSCuTI?=
 =?us-ascii?Q?0fb2EWptnzRhMGKPhnDwe+8Oz0pcSHJSBNlePzer7n2wXGDQzAgOvs0UMqfL?=
 =?us-ascii?Q?BxoDKTmJRH3oQLv9ouXvbwTkc6Wsem2+0zpTJ0sDkoNIo4jrX+rXpHEDCoPG?=
 =?us-ascii?Q?O9FMm6+s9kk6MR3qPsPemDYeUOD9hrbe3eMNnZnCkxPLa6/rtSM64Oyb1ebW?=
 =?us-ascii?Q?JRh3VAIAMVVf/tTMxEyp9atQ2LpQqIm+sO31X9KCSkFkhr5Nl2tDSWt9xtiI?=
 =?us-ascii?Q?wiuwJpoyY4I5yHcbb+SiQUKD1x394g0E+L45GFCU4/oIQGv5P8WpVNvc3Fdg?=
 =?us-ascii?Q?NyZJEFCOlJjnX8xKACSbzAvwJNHOM1CZHMycztRTzJ1a1YyI4uJMDgQP784O?=
 =?us-ascii?Q?z3k5sxw3igqzl4pur4am2UZto+gTT6pxDAYkwZUP9eveThrEU6JtrZojPUVB?=
 =?us-ascii?Q?JbiAH9o053zzg0fAW/O2zPauJXnLWLITWI+5UIDEiai8Ry2gcQJXawbJt18u?=
 =?us-ascii?Q?RLVkiTtmUJo1W8eZ4uBNqRf17Mc9FkQ8nLUN2yQorXN10NL1vDHnMGiMOZ8v?=
 =?us-ascii?Q?+LN8eDDfjDqh5mYRCxLQj84OmfNgNxo6eQSN5l/vT+61Os+R7bao338BUBqZ?=
 =?us-ascii?Q?foc6culXbeeP+D2YU6Bb3XuRB/pToEndwCk1gzOS9C6DxqyIr8YIAYSNv2ae?=
 =?us-ascii?Q?fsT/SmX78KiO0GhCvdP32Rrpwd92aW9pxfYZP39lRYjFFLd3Th2m6jd14BX1?=
 =?us-ascii?Q?4kpeuimxEbWE4IqsW4Pb99/PsQtyYeYqrPIF0apTuYEU+KqWMu4QRAJwEVwe?=
 =?us-ascii?Q?zE/S6LKnmffXGGTuakjAM4XqXf6YnYtP2Wm16Pu/ziOB4DCiJI2Bu9qmvRi0?=
 =?us-ascii?Q?39bE/qwNfBN6JfFiycqXwPtmpCNqSh9F7YwVAIopOY/M5kkEyx4SofyT4/7f?=
 =?us-ascii?Q?AgSNbP9qCidO1ak2fz1JfgeAnYvfpOZNiOAqEh29S6pqESzF3205h9RUc3bf?=
 =?us-ascii?Q?t4CFcGHOKSR3pIg1mzJ9QQfnbzevs7kHatK9S9+PNgqGA64VVJhLrVyfRYk8?=
 =?us-ascii?Q?oDU2NzzPIv9RNv2fDIJwW3hFseXwfU+WytEl1bG1Nsuybhow2lvsXu73iAWj?=
 =?us-ascii?Q?IjvgqUm3SQpUFYslBBIMCk=3D?=
X-Microsoft-Antispam-Message-Info: exazOxaxX1OJD8qiT37IL5fleFxsDejGjZgFADktgc7jBIm1xz3bsgAl72xwe1pTiEO9SBmaF/dm0sseoOsthb5tZq9Kog/ZzHu9heiIwRTyy0PlGJlYZt3LpMQfAVfou1a0nm5onNBlL4gqF5cEp75PafIwKFwbrKhlEHmBoI2S58uBCZqrKWQXJwAjwd9G
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:Ilr+U6ZDshaN49CqYjanqzvpZSSGwKNum15TxbL+btsrJT7kqL3hJFYAm8L2HRcf1+FdxxB2B0LXoKfOwEdsW/uVD9bqd2KtiXPelfLELXqjm8YS7dOI52fsyDbBgd+v5+lGHMMpbE81MK9LKkhEKc7NK0IbWQaQyk2e3qZeh5NevVnJnmLeraVZSb68CAUhjhrM9zt4KESzRAO5VAaPfc4NhJPcKCWfr8vaMHiKyNdcqJ5MT5RocodiB8uU/0W/AVUae5ey7JU/37t624+qoxMfQekaxg+TBxD81xlW6Q7qW10jXTssg2aL3MpEXLTgihrU6U9clMfFIFk83i5VbP/fYEmtVzqeJzoHCcgNKXc=;5:UOIGFUct0+mXqNs90/aJPECtjqPEug2480uRLvyRDxz90APOMA+Q0RkEXyDitENs2WTRbkN2UlgDndlPTDh4v5lF+Mcg57cDha99fnGbpuJkZH6/Gmsq1MsYgf8oBdMygWmaT7cxOhGud+0TLDcdlEVsxnQDomZU5zowWZ3Wnhw=;24:cqYdyDsHlbtMvt7c4LTTytp0p+tDIMbyglOzgSBPsjuOslX1o5xiQz1fnD02J0xa3LQQ5Gn3/z2WK6A3CJyZZ70n5E2e+CT+py7gRd3w9Ws=;7:rcXZ88U1thl6t38ONhXE0EGnx1dDFwDrbwELGuJg0H+uWQFMRSGjPGbl9mDhNXE1qgBFX+sbFiXy22rAuRjUuJb9WleMHl3Pf8m79TgJgYoeL/M/T/DFfO+Iv4KUN5RHvrw62giayvybv9M4e8xxpV99XPo6tEbOeMaty0T29balflkW/GtIdBIkyeAzrnmXU1mkkdDQCqDfBW9ClXi55Bp4Fl2Qjalx5VeFQf+g0DPHAea0EOdKtwThhH3SE4YT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 22:58:03.3691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d8914e-2f09-41a3-618a-08d58ac836b9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Check in a case insensitive manner if one string is a prefix of another
string.

This function is used in a subsequent commit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-compat-util.h | 1 +
 strbuf.c          | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 68b2ad531e..95c9b34832 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -455,6 +455,7 @@ extern void (*get_warn_routine(void))(const char *warn, va_list params);
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
 extern int starts_with(const char *str, const char *prefix);
+extern int istarts_with(const char *str, const char *prefix);
 
 /*
  * If the string "str" begins with the string found in "prefix", return 1.
diff --git a/strbuf.c b/strbuf.c
index b635f0bdc4..99812b8488 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -11,6 +11,15 @@ int starts_with(const char *str, const char *prefix)
 			return 0;
 }
 
+int istarts_with(const char *str, const char *prefix)
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
-- 
2.16.2

