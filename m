Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE4D1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 18:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163752AbeBOSQM (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 13:16:12 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:49632
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163633AbeBOP1h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 10:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MWxvvI4gll5jVEoBK98Fickef1jnHbMq3u9uiqOu5sU=;
 b=kbRuojzHWPX6jvz3dBsm4UEDse1SdZnTFtJZaRSlLIwNI0vf/lfFL3DShUD8aXMUZPpDqSXDlcxB5o3GBsuBP/LFFMme3X9BmxE4lWvHKWfXLVEZWXyegAN5IxEOnyfj6hp8249MsYE/gh+trGfaZ13MsHGtlg7MWONAB3QpINs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Thu, 15 Feb 2018 15:27:33 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 4/7] utf8: add function to detect a missing UTF-16/32 BOM
Date:   Thu, 15 Feb 2018 16:27:08 +0100
Message-Id: <20180215152711.158-5-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215152711.158-1-lars.schneider@autodesk.com>
References: <20180215152711.158-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: DM3PR12CA0049.namprd12.prod.outlook.com (10.161.151.17) To
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb0f1afa-4e94-4ae6-6822-08d57488a374
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BN6P136MB0020;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;3:nsvRHepDzbCN+nh9x2Lz5XVNTxBQhwCPUD77WGGBAb0/jGkabpBQCWXlvrxGgJCJ9zgKJQPtzFCrjQ4ZyvofDU8QmoSCjwW5hv6m6bAjAzJBGPx/e1lX8yJu0BBo9NtIQaLcg1lxAbAvswQRwE2XEt0SrrA8z54RsMbWt0VEeM2LUvsQbpRS3wxMpaLBZkqtqc7LHt47jtqmSWA1JNIAlYFM1ykMf4g6Q/kEJrfSoVPo3z+AX66GLYTtz/8CUT2t;25:gqFvDuhWhZga7i4wWGRAmQx631k7UkSjQi6Jm236/quw3Ilgse+aPKVUgUg5S3AV60I2v5B34rzAXM7qrIPNVcTjvUAQ1s6XJFjqhaUwk8kXXRIJIklAJUldfldiA+SGLCppsmLtkI4MEJaweQO9wJ1nXrwoVFftj0iBfihmU1zpVrt8w4qOq7ZE+JmIEja8UYOqeB+k5pTkn1vFGFk8OSDEXrzikgIsNCOjKwLVS7MualH++z9PiilJnUELic8rRskaQqhtn4UicxxUuqqWlHECrfSXRwRmg+niDxRN73yxc0zZgA9bp1B1jVZg6sKZrooGI/Al8mYptapslRnUSw==;31:SqNHxHfsuooKwr5oaj/shwJnOW9JbjSakBzzOOPG8SFAR8kBXbqMjTgSuG1ZAtVilJwquK3/Q5vHaddP+bI9yy1RlGTtFz9aVK7AACkYwvNyWbOqqHpGhTlnQPH+jTgAPbTgm2Y+Llx/wDrps23p4TqJwjneAEi4E1AXdJgSpg1x1kDt+LDhvkZMNjdqJTj3smNcbkXj5sNX7cLOZWNVY8phlD6v0ZwqFKHsAmQ34Mg=
X-MS-TrafficTypeDiagnostic: BN6P136MB0020:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;20:PlyT4h2LLIR+ZBo4WfohUT43DhJ8C1aRoUzr+hr778t/wHxPciRVmaYOH0YWeeS/fz60s9WlNvYxgyXmsb5FHghz6LSmsFPjz9pUTpLX8zvLkHlHLus5N6aEQm4SneBLU7zr3lHMTC9ElnJf/8Fx6l6IfBOYelaFsqlrrirEhgHz3RddzknZt4o9ftx76GcQz/K/FxhP2QXC/f+a49Cd2C95NZxyaRbEU5c21gBTEaebcfxaz06n82jmGbyci6AomFTQKntONuU4iIInnIHqBmkxcVFUFWCxuf0eF91UA+oLelVpo01KH96JdqjaGZRVwEzOjy5w4SxzmjFV0vaPn46c2U4BTOku9kRZMpIrE/yI8BVuN+dDppiX7gLYdgm/yzMDfkf2B+PHH7Mq0UIp4NfL7sMOfXY+VPGewAB6iHEnkKyPbF5cXKRhgglCw33hXZ/ZilArBJaoxjMyrW9vAmAdZnjlnlsbSToTTHUARfeUN/k41S3IpIz4yquQs8/fpkKVHtwvfpy/EFphhP9G8FK2bqS6lX5fPSa+t15cT/o9KmxgznzIGiTTUmgpsjqcPh3NwXRGsAp21T0FcYfBwzAne8tQR9VuCK0jL4AJu90=;4:DFHAPs74TxqCmr5zOPbo+co/rM6vsduHWr6JtIr2g7/jP3Ml3ztGja9d+Drd/+unTTd8n5hxIHtnsiE5lyvZKtRVZJ0L3Lk1X/o7kKNBlE/kso+E5YRhBsnEN6J/QblMupDJNAmZ3EUbdeS1QVdwRzh6azMon+AspDd5DqSOYA34+d6+DDJV5zVUHQha+7JtNWmIRumfI/otmwl04kuV715TeIbETzf+ee/ajj0UvW3/cvRuQjRRmHqi3RwC1WZPeFuDXM1A9k9e0PoMATaINsDDy6nGe/qSvA2++frU+v/VPzdZKh2ApbsOvTQtbu3B
X-Microsoft-Antispam-PRVS: <BN6P136MB00207E847FA24A2EED9A55A5E8F40@BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN6P136MB0020;BCL:0;PCL:0;RULEID:;SRVR:BN6P136MB0020;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(81166006)(8666007)(85782001)(186003)(5660300001)(1076002)(6116002)(50226002)(6306002)(3846002)(86362001)(305945005)(97736004)(106356001)(16526019)(2906002)(478600001)(6916009)(26005)(25786009)(81156014)(105586002)(8936002)(48376002)(53376002)(47776003)(51416003)(76176011)(2361001)(36756003)(6486002)(66066001)(8656006)(8676002)(68736007)(50466002)(316002)(7736002)(2351001)(7696005)(53936002)(386003)(52116002)(9686003)(966005)(6666003)(4326008)(39060400002)(16586007)(2950100002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0020;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0020;23:5Pgzx4mQb+YT7Ot5MOI73hpchax8jkuebTcIabuFd?=
 =?us-ascii?Q?WFDTA9aAHV3//Efw1JdPExYtTEszOovRAKGa+P6YSDeW5FTFvSJ54Uv0LI1a?=
 =?us-ascii?Q?aydcNbMgjfVAJjYzaVoL+ZUJNkcUrHY7IXu/GTWMhe3GAqeFWXCdTmW0sL9B?=
 =?us-ascii?Q?6XGhZugDqgkkR0l1rlUAg25z1/zPVPULcXIQm1gqUm96DdlzthAN/ZQUIUxe?=
 =?us-ascii?Q?LxjkLCe2hETdru2bJJD1l9/120QtGJ/YjxmsdC/r+HPqWf6VBNOMNVxT13bz?=
 =?us-ascii?Q?wEV43sX273eDJxbFKJpimMpGuKnvlkOS4INU/FK6LdJK454RtCjvfpdQr4L2?=
 =?us-ascii?Q?6n/A6nrTkclaGP4LfmIb5HQ/E/WaEPiYvbgbFFn4SJLYIe4GI+B9NM7Z2Q3T?=
 =?us-ascii?Q?Iy+PQzdL0kH0zaLR8fsj8g57BmjlheNaRDHnkyQyIkf+H9UnZ66waHHBXbyq?=
 =?us-ascii?Q?ClKslTjrcStkTc6DhvAWKFSAtr4+1wW3LbEyfx6oMBXEZVC3CBAqoqurh5au?=
 =?us-ascii?Q?EOeH4Bnz5bo8UbecKCA4YYl2tKWqIcLKtQ+UY+RMWp4EmGNNbU8C2O87bJ8Z?=
 =?us-ascii?Q?8VtcSoMWow+b8eS7GXibxxIveSAfzKZPmmU7TO96crDeFHw5qE4raa3ye2E3?=
 =?us-ascii?Q?SUy3wh0HgYkMBnagjHLIRptVAKqM0BokXgUK/6Zmvo0GofIge6nXUlFgIAvK?=
 =?us-ascii?Q?0vFDJkBZWxZlM555H1AyJ0du5FthMn9imPTEdttlgQ2ZOwcQYdXU9Cw1FUEW?=
 =?us-ascii?Q?OqvN+oyAbQXl957B382ECGbbOKRYoTpD4th5dwHtmMeYx+VtSQTYpLn08r24?=
 =?us-ascii?Q?9KvDvKFZV46VtsI9WVgMsH0QcXFFvw4IN/tQCpbuLx21D/O7K83aeEyGGTNO?=
 =?us-ascii?Q?2a1IFJEeIMDvLoEd62h4N+JJ5KOFd17ZrkGIUHbfbV0HuxcHw4US4pz4S/1t?=
 =?us-ascii?Q?YkqoUONRIp2MMhuwIYE+nu4GUd6EhN58pRpvqBuB5anfxsw2TBo5iCbc1B8D?=
 =?us-ascii?Q?gcIZMD19BZuDOdeoBLNWsm8yVfyQYumjHuZsE1SHXlL3ZjV6LHDUjRG7lpzg?=
 =?us-ascii?Q?7CdBWD0ZALMoKCv+Vy7Ncy/dz+kchczz2YhKqv4vuUvVnLZWOhZDPwfs/Mbc?=
 =?us-ascii?Q?I6qF593rWkZq+DFoxWPh4d0Vu8SJKGgz6Y08P16FpSR7Rewy+peAg3QmMmwn?=
 =?us-ascii?Q?LAZkaClwSyq7kOEm88R4x15ADzfF/WE1aLV59uoXAbHn5xiKMXMSO10ZTdFT?=
 =?us-ascii?Q?28AUCgwyU4dcWeHnscJeHqAH+4hhyKqttA1Hmwmeg59FDPy2SRc9Qxb0ZsHN?=
 =?us-ascii?Q?HyygKJzHZH7rQZDBKRusuk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;6:+WP9wfZmDbTen4rql1ukYypwS/9RILk49GjmNoNeO0Q4Wk3Tmq5HVn2yha4ZV3UMg5EfUC1hWJEII6Co7g+Fpc9I5ZOm+eP0gqVsUTesIBagZsV1l9cq62AW+jjl5xgkZu6yXWZe4woByP69+GJtWYwEoAY+44+OV3NgPOyULBFsP6i+oizzI9op+MAG7ge614DPNU4eIjC7mI5R/jqj4W5sDTREgfgpp9e7X9H5RPmbB1j+WFPVxOUSCIsfaDSZP40BiphlBdd+/JsQ4kRwlaKeYkjXZhVNMGUBXG5+RhBcgm4Gph+cT5+BQRbrM7+I+LPjzZc6ugx1Puk2Jm/CuykNeT1YfRYLKT7c1YFHKBE=;5:kWkNL159vpLaTCwN0wigBy5PQ5/BpDdMX8HFBfBCjVugrQGM7gy5opjugb58RUEh7shBrI8J2vXnXRhJq+yMCGwIilhH+zBMsZHclBVF22Jc85PN0L/FEDEO/kBfdQE0xQ1qTR40JRJ5w5nQJiyEUIx1Xa9KVu95sSX/Z+2eDSo=;24:Ft9hH3iY8azzk/pEL2OxIKN+MrSQAPatZKzL0FGjMM9lMPuKgimzOHwjWKWQLHfJeBUa1q8ZJtCUfdyufdi/i4ddTpdCsQ8ZNbMf0SDcWdo=;7:LF/YW7uJPQ9O1tuXdgtu3/U26n8w3ptxAyRIe86BZw4+/gt1Md2XvdeZPISrRBnDVUFNOMGPrDTboXwmxvB2D1L8CHsdDHcRzxvAIb4cuNPTFHDTPaHHg43dhhFCafxMSs8s0nf35GQqiQV1Dc1USCANIwkhv/f5W/T3J/BgcaryDTrdCicmvmSHp+k8n+o4vB7x9uiz77JqFwNItg8RTascS3HX2XfwhKfSfQjZvxuewM/9Iec7zl8XlF28vc9u
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 15:27:33.0263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0f1afa-4e94-4ae6-6822-08d57488a374
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

If the endianness is not defined in the encoding name, then let's
be strict and require a BOM to avoid any encoding confusion. The
is_missing_required_utf_bom() function returns true if a required BOM
is missing.

The Unicode standard instructs to assume big-endian if there in no BOM
for UTF-16/32 [1][2]. However, the W3C/WHATWG encoding standard used
in HTML5 recommends to assume little-endian to "deal with deployed
content" [3]. Strictly requiring a BOM seems to be the safest option
for content in Git.

This function is used in a subsequent commit.

[1] http://unicode.org/faq/utf_bom.html#gen6
[2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
     Section 3.10, D98, page 132
[3] https://encoding.spec.whatwg.org/#utf-16le

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 utf8.c | 13 +++++++++++++
 utf8.h | 16 ++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/utf8.c b/utf8.c
index 914881cd1f..5113d26e56 100644
--- a/utf8.c
+++ b/utf8.c
@@ -562,6 +562,19 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 	);
 }
 
+int is_missing_required_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	   !strcmp(enc, "UTF-16") &&
+	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	   !strcmp(enc, "UTF-32") &&
+	   !(has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	     has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index 4711429af9..62f86fba64 100644
--- a/utf8.h
+++ b/utf8.h
@@ -79,4 +79,20 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
  */
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
 
+/*
+ * If the endianness is not defined in the encoding name, then we
+ * require a BOM. The function returns true if a required BOM is missing.
+ *
+ * The Unicode standard instructs to assume big-endian if there
+ * in no BOM for UTF-16/32 [1][2]. However, the W3C/WHATWG
+ * encoding standard used in HTML5 recommends to assume
+ * little-endian to "deal with deployed content" [3].
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#gen6
+ * [2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
+ *     Section 3.10, D98, page 132
+ * [3] https://encoding.spec.whatwg.org/#utf-16le
+ */
+int is_missing_required_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif
-- 
2.16.1

