Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961101F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932478AbeCIRhH (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:37:07 -0500
Received: from mail-bn3nam01on0113.outbound.protection.outlook.com ([104.47.33.113]:10015
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932479AbeCIRhB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Tndy7DKAGVhUNfxXywm+/P11cb1rJLoekm8PDF9JtA0=;
 b=Ar53uNh2UYXYLfCr67XledvTg3q/tcVkkPCXP1Ke1agTi3GoMvk+HPArpZ9Bwpn+HU6kBAUfSIoVI4O+o1tRIsiT79jr0dIR6vMCIPEd0zMqr/nv0L7TlVPRO17XfW97+a5W1HGaGXOHZtxyrKug7iR7gm+nemR6hPk8+KAKYkQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remr90mpm73.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Fri, 9
 Mar 2018 17:36:21 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 09/10] convert: add tracing for 'working-tree-encoding' attribute
Date:   Fri,  9 Mar 2018 18:35:35 +0100
Message-Id: <20180309173536.62012-10-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309173536.62012-1-lars.schneider@autodesk.com>
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:104:7::21) To MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0bc82d3-c19f-4d32-bae8-08d585e44802
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0015;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;3:aZRkEq0DmJaEgITnqlNTEreirUBHAm0wjhGaSY3GvcNspdQUMGK48gDDSmLisBMgFM37gu5nvABGuiuK5EEptkBylpmMXy5QQRRmys3Frrp4Mg427CR7nWsWH1lAG7GrrlXVQQhi7FqsJZx5zv+YmNAYr8pOOO9bUqSRVBNAeQxsc67WUFCAh0IsywOnwSVhtdkt7WHDK4v4te5aFJ+JXvSe5ITqJuoJ7u2cA6uMYVFrTSsCImdpzXPaPgdBaa3/;25:1XbpeVjtOAi8pGOke/5oxsFfkgjZ9xq0Q1ZXtQj/50IwVj7eP4mcMNmRhPN0gXuNMxbwLo9TSNPPdULUJPO3epiM83+TCeA4GDw6lWO6ALTgeSsuNRD2NAN0DsxbJ2fxrJ2bxYczcgCGHJBN2rWg6qZR6h083fgQtrgQUXHoGYGkNg1syvuL9DdLVbz3vRaB29CiGQx+rdMS2IO5NKx4gKEaAlYGQXJ92HDXqUWOBrhXXQeEpFQl65p6osCcCyVfLwPYPeV4ZqampbjrAdm4sdrXIMl2A42yr5ba/UWb6VTKrfBr4DhSVYdIjPyx05/9/VMY+NNPd+J8aYN7P71aVA==;31:r5dmvljQnmpCni1WmhwlTjUYplSmBZ0VV35YC5lySNgOqPar4d4G/OJSFOf41bWHqMFLQ3ndUhvPlzUKn4b9i0G2Vxl0+tbWV97kVPKYVz3nvRDdx8QV0wCH4Z8SeNd/I8Ca3Kn7E5of7TN8cJTVS5QesOq/8P31LDmSDbgnLBplarOZRe1pyCg3IWY20NQ2aDcBefQ9Tz41Mg7BC0UlYFA+SQHlxjiuN6rP9LDZ6XQ=
X-MS-TrafficTypeDiagnostic: MWHP136MB0015:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;20:+TqgMJ4Ar27pvW0cq4lazdvPCDKFJzs8P0zM44W1CUlF1OFMjzKrnG2J2JPTJ4Km4LVlLAdPW72cYWxbjaWUYFnXNLa26WHGQHWYSXBv+ZXpNPuX02938On3AGJ02SUwxXDAujKILdMceftI2hUGPdYDZd3llIjAKBB5lVGsaYiKlRLthd0nZSXAyPVXwfrKg5yYVZAiiQIyRgTA/uXs/ePyTB1iy2E5oRsPVYz3uaeI8H13T77I0muQ0kfICNxikEu+fYkM5KWKpdS+JXotXjcPAEPGwP/VOeG3Vseyka6qeLy1ArDh7+rdOgespzhzrCF0nJA/KSVtGtp0mdj2wwyygA2gIvZbJgx/fwNovGEDsnlDvpcMHhu1Ybva1oZmKHY/C7wWd86UsGmlJPkeKUEXGTZ/3JhExeGeGvhWKSPTTXh/feB3KAmCygiK4DtqkkMQMzFfeZiZa5NRPnY+TBV57VZOMXe7R+DHq1RmhkToT14dNaDmL9l+yt7NfyITLyvHHYkVTrWTxINSRE6fm3c2UCWub+B4fEeRbkNB2g7J2/+NM6JEvI0AQ5ij9eNUuswnNDpvyi9W/mgRkwFJT9qItr+HHYS2Chn2GpXaoKw=;4:ckTqZOi8zTto659vhz7XXWKBBlKtkX2ZiuFnH5mEFVIm67YYouRlY8OXrsmUchvPxmk7trhpDU64w1DDI1VFpyTRBysxUdXNyienc5oyBiGjMPE2Ox1TCNCsbsz5M65WiunqUXmrUmPYq41XndHtWkwWuhOSAxqaT1C54QbmYw116kI1+BLoG7G++ufT9/KXnXtxHhOAm4gokRl+6+4xvP55JURNE1/Ylt1/Ftp9SvbSxsyuWrhBE791djjG99ZxjPsjgXnhE3xc4hUr//UDCJhgxH7zdgqf7GcP5YGE2He4D75PDepSTwWpfHpJXV5J
X-Microsoft-Antispam-PRVS: <MWHP136MB00155135D9B7031EEC5B2B0DE8DE0@MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHP136MB0015;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0015;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(39380400002)(346002)(189003)(199004)(50226002)(76176011)(8656006)(7416002)(5890100001)(25786009)(106356001)(51416003)(8676002)(2351001)(6486002)(2361001)(386003)(105586002)(68736007)(8936002)(5660300001)(39060400002)(7696005)(52116002)(59450400001)(4326008)(50466002)(2906002)(48376002)(81156014)(81166006)(16586007)(6116002)(86362001)(26005)(3846002)(85782001)(316002)(9686003)(186003)(97736004)(16526019)(8666007)(1076002)(53936002)(2950100002)(36756003)(6666003)(305945005)(47776003)(6916009)(478600001)(7736002)(66066001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0015;H:remr90mpm73.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0015;23:tcsAfXqyy/Ei7A/i4uxNw5dyTeAEt8SdFj7hVHb2V?=
 =?us-ascii?Q?trZ39aalcVnhFlELNlVlttaXpHElljEkSe/X1mraVOdhvo42kBU8NeAhwPKr?=
 =?us-ascii?Q?115BclCpltKb1BvEsurkA+Hx+Eb2N9bJFLj+rPcs4Jc8ZFXLvFbHjW6dMB6W?=
 =?us-ascii?Q?gjreUroqsOIEYOGrDdIijfw+nATzIh0sJSsstJBR+f+X4zI3m+vIdFIo9/bc?=
 =?us-ascii?Q?wj7lREpzrjbtO97X0ETlh5IbcBhxjAoQl8Yd1dN+yKjZXO7ngnNDRWvprRq4?=
 =?us-ascii?Q?oPKEk1rUgiBfwLvSDnHcmeSPff5TrZINbdEQpFBhg8MIuhwOGvrf7SziaaDX?=
 =?us-ascii?Q?SIAH9mrNtzB0pqA1qhTaQ+rsaqRbqYLRfSj7vyjbGaYuUp2vILEe9snzr8OP?=
 =?us-ascii?Q?a8hrsKoZ4QnOtKriQ3PqMaBc8sopyJ5xV3y58Lo9pdeSsMatlw5sQA7NJ9qI?=
 =?us-ascii?Q?VCaaCsCfc0EYicUIdLlTuu24mQs1U1ilqLll8MZfM9cZZVWBK0FJl8jU55T/?=
 =?us-ascii?Q?DSiwOCoPfixLUJMES8YYxB7LP3RB2J73Bfc1vsEVM8+gf2YUvwLdpeTFA6JF?=
 =?us-ascii?Q?+0QXMHUWCSolnA6u/yCdGR4IeqxcePogmhkoYmi4e8eLU+fVZpjDIbxmx6QD?=
 =?us-ascii?Q?QyXFM8BCSqud7HzFvJmN0Qw6P1NxNDzaWb1RIN9gWc/KjaAMLTDpygd1g6q0?=
 =?us-ascii?Q?8ZXs8ou45rTAHW4R6WhiaeaMx/fnpdFnMqWCO8ry57lsukChDOvMLCcqAGgi?=
 =?us-ascii?Q?2iHWXmEmS0FFaVMSxXp79LmkMt40PMzlYZqvxg6pvGSfjbkv0ruI3tZxRJQ+?=
 =?us-ascii?Q?Br2dMjkvWRtaFHDA5MHASiaW3FFf2zP2muODHw5taitgoIggeQ+Oxa0OneYl?=
 =?us-ascii?Q?FLVeDPZQ3f2BPfvfqhdYZMM67UJn9wKfy5k9RrCxgdq9a17JD6SgcCgaDMlH?=
 =?us-ascii?Q?EXwDL03b/RnuhYv3oNXHbgB+GlQsxjfOsCOasNR0HT6JhKEzqOhXFMEXjMt9?=
 =?us-ascii?Q?FKvgjERH+CNWGp9q2IChBKrswNuC3FWh7/unYAosHOCyW67JEsnbrcDMjuM2?=
 =?us-ascii?Q?Euh0Zb0ysVV1q55dASglCsx7UpVhnoaUYwhANJDPUGdexiKK/cFnjTpWcACp?=
 =?us-ascii?Q?AhBINRZpAwyBZxvzPIYEHIEjZxQPQL0hxIczcG4ReJNuwLAspJmqDYBb5q60?=
 =?us-ascii?Q?cO5xZTXybcV3T1OUbanMLBLWlqZUNaTAlS0MX1x0Oo5S2bxRCKsUb75Cvd42?=
 =?us-ascii?Q?8kHTJNxSVIeLp9kyIyYsI2VO+PI/oE4U/wwn3Src0JCxM5LLeNtjnfhDitQc?=
 =?us-ascii?Q?QYCtS7bMH6IVWKmxHd21gpo/8Cb2fTUp1kxAXaKpK8p?=
X-Microsoft-Antispam-Message-Info: R0ak3elG4I8gx+QCbkVX5T3Tos36CIQLxl47QP8ItZQKHXjJbSUf5bYWFeSSBt2Chy+93Jnrh4BO8xzh+yyqi2jNLGhCncelxK7dt3TsgPUs8XsxM50ne8I7DpWGGYBbDjI0ohw0RihYpU92LJg2cgHRukKywNFlbyTyHJrucWs0M0HhEYhRCXER4jxIenu3
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;6:Hconl/uzPgPS7JUHVnZP+vIyMrUrpen7i4Ld7XpMxVAycWGodkZkEaWOIr9SQqQQTf+iFF91TC/U69170RvWLsq68E7YyQ5CgHxSdwrcezxo3L6GZLlKo/+5b5h62G1AE1FENB6CaLqWBKfmfk8Bj5K5X45WrMvdx5Kr+VprhSRO7wj9VEOYQcxFRQpIo/foXoW5x+YpxE7EK96FGvZwwGHHL130HQr16RdfBC/OGwFKTXMo7519+OKE6Fp7MHEravMQGyzu+fsEKJt5AIx42IXiLaYFdNZTycVTpsP8HBq1G5+7gHGPSDFdR4rFE64DblIds0YN0G1JNVLVehqNa+33XLVI77Wer3GrUhlHp4g=;5:hIcJ+EGEzSk5vHFu0tFO+Wh5DBLpPKXihTwDeo+fB9Gr/chpwEZjyLO6NVzCeLrg+xRWdeElz3Bz2O90YjsLl2KVmxdPJJ46+hftdmAwZAi05aRsjsow/533w8UkeCnnhnIWBlIRB3cixyE00ZKpKSa/cGdL42YSp3qw7uoeJWg=;24:/fC6e+2SXkRF+ldsTudOztE3gfa/oZIHlRpyu74tuyjHvJtNqJN0z6xDiyKf5wuMb8Cwj/O4N+5hN4Zwnqd68uaoQcAeSaPihO25sWINaCM=;7:vbpMH9mv2ODnbNbNi/r7GnLIDXJySw7EuyhmnxvIEAYNeJJXv7OYCHBSyg9XncAdCAGSbtmQbq5/5i9d514j7UY48smFvye9/rA3rJjh49NpcqIcMGLA6+747PhcStauXA/C7osE8TrLPvlp3TTWfVuYxOfEvFACDPX8zHhjaYJr7DhgCYnz9feB/FrpFeXvnaTbcWnfZrI17qcc06p4ExXZ/Um8nI7a9fnuHYBPofwi0NTIYq2Eb3svvoj4JPJA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 17:36:21.4500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bc82d3-c19f-4d32-bae8-08d585e44802
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Add the GIT_TRACE_WORKING_TREE_ENCODING environment variable to enable
tracing for content that is reencoded with the 'working-tree-encoding'
attribute. This is useful to debug encoding issues.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c                        | 25 +++++++++++++++++++++++++
 t/t0028-working-tree-encoding.sh |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/convert.c b/convert.c
index 9a3ae7cce1..d739078016 100644
--- a/convert.c
+++ b/convert.c
@@ -324,6 +324,29 @@ static int validate_encoding(const char *path, const char *enc,
 	return 0;
 }
 
+static void trace_encoding(const char *context, const char *path,
+			   const char *encoding, const char *buf, size_t len)
+{
+	static struct trace_key coe = TRACE_KEY_INIT(WORKING_TREE_ENCODING);
+	struct strbuf trace = STRBUF_INIT;
+	int i;
+
+	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
+	for (i = 0; i < len && buf; ++i) {
+		strbuf_addf(
+			&trace,"| \e[2m%2i:\e[0m %2x \e[2m%c\e[0m%c",
+			i,
+			(unsigned char) buf[i],
+			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
+			((i+1) % 8 && (i+1) < len ? ' ' : '\n')
+		);
+	}
+	strbuf_addchars(&trace, '\n', 1);
+
+	trace_strbuf(&coe, &trace);
+	strbuf_release(&trace);
+}
+
 static const char *default_encoding = "UTF-8";
 
 static int encode_to_git(const char *path, const char *src, size_t src_len,
@@ -352,6 +375,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	if (validate_encoding(path, enc, src, src_len, die_on_error))
 		return 0;
 
+	trace_encoding("source", path, enc, src, src_len);
 	dst = reencode_string_len(src, src_len, default_encoding, enc,
 				  &dst_len);
 	if (!dst) {
@@ -369,6 +393,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 			return 0;
 		}
 	}
+	trace_encoding("destination", path, default_encoding, dst, dst_len);
 
 	strbuf_attach(buf, dst, dst_len, dst_len + 1);
 	return 1;
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 1bee7b9f71..f68e282c5e 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -4,6 +4,8 @@ test_description='working-tree-encoding conversion via gitattributes'
 
 . ./test-lib.sh
 
+GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING
+
 test_expect_success 'setup test files' '
 	git config core.eol lf &&
 
-- 
2.16.2

