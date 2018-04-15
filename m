Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E69B31F404
	for <e@80x24.org>; Sun, 15 Apr 2018 18:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbeDOSQ6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 14:16:58 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:46560
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752724AbeDOSQr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 14:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rupQgFN9SA1yHLnTEn7SiP2BqdvnAo+RgrUpsyJm6yo=;
 b=RmCipVtReVNBtDYxmtvCP0a/aTYnXLGZ1sBdgFmaJ64THY2BF5GtCxf52Ptz82OiXtygW5sjml/Ifw91mD+jEjjxO2SSsro1a5fw61O/LCOXpUqy2n6AAtlGkA/R+5LUnMSfPO8eGE4ONKR5ncRgE00Ms/A8A6PTimbgM9V9ECE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remj8gtty1.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.675.14; Sun, 15
 Apr 2018 18:16:42 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, avarab@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v13 03/10] strbuf: add a case insensitive starts_with()
Date:   Sun, 15 Apr 2018 20:16:03 +0200
Message-Id: <20180415181610.1612-4-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180415181610.1612-1-lars.schneider@autodesk.com>
References: <20180415181610.1612-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: AM6P193CA0010.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::23) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:t80w+kEY2BnQ8kuTGt0rt0sRqJZmCfWsrXeWg/r1sEGWvwQJyRukf0lmvgSNd7OvaWxlZ753mZf3TLtKHOaqXyxnGFMQw22V0bhzUfV9XN1SupMSBmcHIsxLTkHSnhxXm8IbaPT1SiyGRhN4Ih5c/p1LCL+z8Y7Rrxho8uvP9+pQ446uRASg9H0Oiy5clfIXxWQkOK2wLa7K6gX+3tN7ZAxhP1V8s4t81u5XJX5bhbHykRAP96f0zbBOaZa/ilxv;25:/e1ln40EgkgV5bXA7M6yUD1tO2yPRd7YRHBjkU4WKcVkk122xS9XRnppxdhvRlmspYY9soPk6363acVq/1W73gRfRKo/1f7gBQL7i4xLwDCMMk4mHiFia+z8Q6MKDKdh/o4BmR7Wxf4v0nXoG1pDJ/WGr55sZhKEnR86tLQ6e5te+JhEQNF0O/Ck2OEG0ik5V2jvAIELA1YakrN+xE2bLG763VyhM0EmN9yiHF1d4e+EEbwjOk9+xpGPA0JGCN0PxhRP207RIVSuneQpee4GYbrel2pwFdMw9IHNVkL4eCNkH38N5j1cJRGC/DCBbz4MhRKtbd5q2FV+DZXUtBMh8g==;31:ema/B5VcIY1KoWhq2iB6BApIAQn31kKez+sHktmJ8q3ebYrq5kOPuX1jkh7P+t42ZT7zFr1w/xQvgOnocoLzF7KhERvduhvBziSZI3Q0Wyx/KRbuOQCO/aecAhXvsv1RvDYeqDQMDjfQnx2z1Zmf9I8YRA7xsMNcaN4ewRVXFx5ihlAilGIYyEs8yA/Dv3iaT40SpXzLHWFHOOwOTqp/TxEr81ao7MDZmHDW21E3TQY=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:qlFWnZNaj/lT51l7TeZ77UrIqXsdllNaAZcuucafgGVWY8i+GROXyT6gdgTY9A2ZtoYNEQ4R4XtQtsqENTv4TR7D5BS7fi/gqvDVSFdREorNujpdlDAj9/MrkPkPhC423TalHRSeJNQGjDhblbPh2w337UxjSF8uoIoNINI6gIsxMJm1BtxzuseGNYc2a+QubheBRn8unbkuUhO7cDujpPlzE/qX7oZBUxv3gEQ+1CgDzw75eK1p7DCOGDSMjlIeR2Vf+ge/LOmwEm5gViyzQbwVtk1jUgnrz31z/xYk2xSYZJW+xu86p+mn8dhr2yld/NIlXPhYUvG8sx/ve1+19kayYXN4ZqPIIdpVHnRV1dSruo2QtmitptdP/bBABhMy4tvzcYqJhY9EXokvPnmRSjzlEpevJnmPRDApVtZgZyEMwdZYKLx2B2ksm1R+Fp2RRq190ocIdzsag8oeg8P+uflFKusaDbvHAUuzw1HBhZk2JpFsT32k8zTWR/LdL3lKZOlpLP3XRGIkX4ANqlHAfmpAldMfMidXIua3gX7kqWIV8C/KZ46ivshn+P/iRu3IBP+p1SMpBa8UbDOucCpiOrg0hOB5iJ+7DMdYEYFCdaA=;4:T/bPyB/5y9DCkoPwBYXbEcAEkOlgOnFlq4Kjh8OW4DDefu0kPdpY3sMMIEx+P+ymnVBnoB5sv+S9agzy8xuF+s3rbzupbwoA3FmXLAeF928SKSxQDXGet5VI6wtuFAh38Vw4hfzY/dPzaVFSufeAMG6F8puR5uWplm6WTrYazinMQrrEKc8RLtZBrAkf2oqFbAmHOhGiKiqWScmPArs2gdvmmmnwPihLc+Gcis4xKXOusEYtyqC1AuRQnv8bqiL9PSnMSPXEO3uYUWrL1+WYouprZymSf3HGaq4WJp6eLTmj0zYPjm2YZQles1WE/l8P
X-Microsoft-Antispam-PRVS: <MWHP136MB00141858FD538C600914810BE8B10@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0643BDA83C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(189003)(199004)(53936002)(86362001)(8656006)(7416002)(9686003)(106356001)(76176011)(478600001)(52116002)(7696005)(51416003)(386003)(6116002)(97736004)(446003)(476003)(1076002)(4326008)(50466002)(26005)(575784001)(68736007)(16526019)(186003)(85782001)(486006)(3846002)(36756003)(48376002)(2616005)(956004)(11346002)(105586002)(2351001)(50226002)(8676002)(7736002)(305945005)(39060400002)(8936002)(66066001)(2361001)(81166006)(81156014)(5660300001)(25786009)(6916009)(316002)(6666003)(47776003)(16586007)(2906002)(8666007)(6486002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:remj8gtty1.ads.autodesk.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:w21RH/RgFVO5135cPCJR1j2Vfa57bcW3HnIX29Zh+?=
 =?us-ascii?Q?LYy9CI3TNgdqTaKp0amyx/QMDWxNMjFD2p8aRZSrf1J/POw6GuF4mZABqlHT?=
 =?us-ascii?Q?2AxNXElxgIPtZyPrel9SuLBwq7BdwzDEUfF3/I4eur5h88mip6918wtXLYp0?=
 =?us-ascii?Q?Le3JYUH+Cbjv013oBir8stKU4DUqHYKf0xEXc6UWfTfTOh84AgSSD5weMfPA?=
 =?us-ascii?Q?uSgACTTsccqvJJEyx+Z0/TwC75SjBVH/nQpQrCraHPuCLLQ4375b47MIraYA?=
 =?us-ascii?Q?YcnLyI/cbaiEsiOFn2Vw/WUAC/5k/YbPnXSUpPMvtODxzwvUWJaunIfIimK3?=
 =?us-ascii?Q?Yc4hZAA1/nLnLf+BpMGnEocogiZpwFs6A34POWGglExeOPfgio3ANKV+YjD3?=
 =?us-ascii?Q?iwoZv48eBO0Z3G/qDvuQePzb1itHmmL8WsXfQYVQeyqetp+/gD9NqZxu6i3K?=
 =?us-ascii?Q?zSgeOGwXSlJO3bSIHWMLgsY9vKTU98ranNeJ9WJ49IwOr86s6sUTTtUh2Tko?=
 =?us-ascii?Q?5wMNd2rhQd12cUGRdvlEwB4UDYWkdouHncSnf71soq7Wg980sJnjntSZGZJm?=
 =?us-ascii?Q?ptkGwRC5kzf2KJv0uY3e+J+DRv9/u9iaTQ4RCrv7biuSqwm4tsJ8As38RmQX?=
 =?us-ascii?Q?p/Xkj7c2AIoxU+tI7nvAVbswoucnCX5xdR5j7YHIMcbKGgNX86YQ4d0+WwLJ?=
 =?us-ascii?Q?bh/JASs450rPJrkhGKgFuTWraZhbt47uZN4t7Qe1OZkDtl3esnHCylIXEohN?=
 =?us-ascii?Q?CRKHw/zS6hYHsyAaKwdK/5Q8QmHoUUB7ji5jsLG3CGbwtYe2RzZTulk0GWuO?=
 =?us-ascii?Q?FJJVWqvWcmPCmTuKL1w4fGuV5v7V3i2TB/jL6BScFEcXnzUcFJux4WbjGb5K?=
 =?us-ascii?Q?9s5NVPGi/19eYYa3+nXol2q+nDYrDzMJJ5ycorYwgJn5Gc6Mle7BqSyHVLJo?=
 =?us-ascii?Q?LT0PnOQWf2DYg2ElVsD2fz+swonadk5m6vOu56ItMLhJvbgoVWtdCWaYlRFf?=
 =?us-ascii?Q?tLQbkpsWhZvG+Imr+w9ThfRGK7OL/dCkiYPFHBjR83yicEq5MdM6dBWe6IRK?=
 =?us-ascii?Q?JIbPpFIzU88kWb9GkxzbWqHe/tFjAce6g9yE/8pTVWCawACOGSaf3ZZmST3v?=
 =?us-ascii?Q?I4hobcxZWlqWWSd7C/Q5UijK4lUXCzYErhrL/8Eeey1AnLeP490UQP+hpQZf?=
 =?us-ascii?Q?HUjwH+7kvJir0xtJ0R9EOaJNESHtuHwdm8aYL8DvZbYiUo+JshvrUrtO3zl4?=
 =?us-ascii?Q?2LiYhdkW/H/OsN68hlfmzXpbT0IVIyZZ/NOitjd4JfDXbGfVPd3yGE6gIsUw?=
 =?us-ascii?Q?usS4rLaFxEttPq4q/ncTpRuhA0z54SdI56du4vMq99aN0/J8Cvq0beu3ZvKp?=
 =?us-ascii?Q?XFeOq4OrxaQQORwva/lM+o8JMo=3D?=
X-Microsoft-Antispam-Message-Info: eOZofJYzn0X7d0NQvSgIYvokPQtpkWJLvreH08T8cXTsvrFb0CzeQHHYbPgC8Nt7ZhHSq9gxEJZTjTx5+9onzSk4DJQuTOk4rWPNs69wGp6qf8faDcpZNyQt+QrH8PNFRsBz3nu4y1b/mYa0wVhJYNpld6r/5qOpYQaT7qB0FjpSIwC0j/0X6/+h/teYuiaj
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:uZxOPlq77xP+f2nPuJspMFJtT0g0rRV47OzmvRPicrZEM9Vo+iIbMsUKQQEPlywodUG1Qf2rofjrHpaeOfhULqviKjda83x5BCzFAu2gGZlUetu63nJgfWztr39fN583m+1gVjynIxF+k30KayABLT282GlvtKc7kkESuT1DCjMOeo9StVqHSaDal5cK1wR/6QTOO4pFhEjquUZE6PwpdqB+v6ff61RcrQm9SFYBLi+7tVSHx3hJ0q9GpX7ckDial8dk7vcVgc1VjecEyTpl2zMWaPK3huwJfeaUxhfolXZRkry6yDRJoNCBhW5VN89yKADMuQwyR3dSOzZy6rbx6Z4Yr/kOI7d9WZ4FF+VudPg9YXnBeburUiUb++fknFYgibOkQzNAETycwAwYaThYi5RItD1x4UqwZ7+CBz0dGALedKS+nQTedvk+lX82/Lnyw2Q/P6b4jH+SJNuE3a21SA==;5:1a9zr928RR+rLje2lxd0p++PvLs90g1hhCuVsfL5vwOBIrL0KlHYHtTaF2Gn6A08GunLiu/aRi3bQz6TtISakeUWxbvsHgHA+zvhQAsXi0VMvg10fnbKSux8DHrgwaXS39erqfMBbvX9RvWj2prj7JnY87sshO0ov07hVr3ZAQk=;24:4N55yp9y2MdoNlVC1yGPG7mU20WoMHWVhoW6hBQ3iOfdsvh7AW55HEL6FPx9RWJ5qhP/Cvq1NVNn9711mg6JwAeE7id7Px6MLyp+0egajOo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;7:0c2TqAtsolDknvLz7DAx+725czdKh0DkFB/S1WHaV/pAH8e9blVwfB6nBJ/Cn/IvTLHIRGnOQbFanQHwBgZLYz8vMW+KN49RiPaIsw0N2gIOg8voXvTXUYaVLhxQZVpreSJDiC3tqXHu3XvfywiVOrUkFBlfdmxhsuy4GbSpRRbL7Q2g8nQ9tuAXlLeG/9Ls1O7omQ2c1JPbtgmQKJbssxoF0aoCdiXHac9dxIdPrLmBYZjnmEx2ocODH085yTce
X-MS-Office365-Filtering-Correlation-Id: 17d1362b-cd76-4884-c923-08d5a2fd0ba3
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2018 18:16:42.1782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d1362b-cd76-4884-c923-08d5a2fd0ba3
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

