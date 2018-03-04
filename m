Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F39381F404
	for <e@80x24.org>; Sun,  4 Mar 2018 20:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeCDUQH (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 15:16:07 -0500
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:20096
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932164AbeCDUPs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 15:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YSGVXtkZUKh98sgIx015rk+4Maf8RoewXTjLV/DpCIc=;
 b=nF4P5dl/dROQN4474R8ug02iAlPCUnfDsSLYz5vL2jWxpqO87pZsQGAZxaV3efazQWjiGXhkG5A5Xk/ztfrnx57Z3EXf+hCVxpvcZ2mFUDhot01UVbW2Ux84p0X+BYJuVG18wg4y4Ts8Xjs6TVh4eZM0H0oy4Mased41oFJXFUo=
Received: from far8gsqyz1.ads.autodesk.com (132.188.32.100) by
 DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM (2603:10b6:23:8::20) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Sun, 4
 Mar 2018 20:14:56 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 6/8] convert: check for detectable errors in UTF encodings
Date:   Sun,  4 Mar 2018 21:14:16 +0100
Message-Id: <20180304201418.60958-7-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180304201418.60958-1-lars.schneider@autodesk.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0113.namprd15.prod.outlook.com
 (2603:10b6:101:21::33) To DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:23:8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc442569-c853-47d6-6e6e-08d5820c9ac4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0009;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;3:biGrOa9evXONFb+ie5Xvzm/8z3/AwhB1flH0ZA9NcOGl6lklSyq6G4tMSSj63TratCQZfbpx6SAZeVJ5yiJrKU+JZqL2W678hVmo/yk0q+JIvKlF1wCzCxuqIvvOBT5lW/f/oNIbgINbCIrzrs51enwVWjGPRes+683MyMyeg8DUD1FPTkObhawFGx+rpF1oIyhEkHyUr1rFeCSGZ88XSHo+IlTcyl2JwumjkcKaTS0OKVlJFwFZ1RI0JnjpGSFz;25:yk0oQwMhqwJpCshnbQ8zmsb1louoJqP9SqQFThxcymltJ+v3pHBiL2VWWaa+/V0tVyq/RSzNCeIs41Ny5NaCOMjMeAxrnG8zWnLtmoVQlvKY/ATIio8rMMRwAGpCrkfnEdvTrg72M1buaoHj2pnYvATXFNHeK2l+tCVXIhTJwrI8XZgQjvbfIl5vwqOyZvJyafk/3b4zfGj77Hqed1NDStfMwMx3dsyL/1EiqLc2/RZJaSueVXTrlF7Mttf1dviipSVUirXstILY/nw4MY0vtSG7ZzZJ5sk2nnYW8dCt/i0Nd1H6QONgkRXKmd0rjDxqZ32lZNO0Rgq55bMNSti71Q==;31:+a2Ousi+7CuJyyWxzDeszjTni3LjzR5Xh0WomPdl3jbCYPXK8u9ZcCpGCzZFJaYWu/iTH5gXUUOJs87PzBzBLgGMtzSWyRlg05iE29zZBoyIBKSMX3x6Th/NbM4aw3ngylMri0GnQNdaQs+mmUcy38j87T6P44CDctlg4yFlBQasyINSzYd6aoo5pbtV9R4GAYWXtXpScXjoAEXQucxriDFNjUsUIq2uZV+JC8/mRp0=
X-MS-TrafficTypeDiagnostic: DM5P136MB0009:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;20:AQBpV2KV1I08wePDgXb3sNnGg9wKgp0UQ70wnkt8fCMo5K7H3vnBZKIkQyrj1oxyJZE/mgtd7FplTEv3fWQtj+ljiT7KpsMAnMbKJmV9YiTgD3a4h+QZGtHwkYtQGoSjO3zj4s6Tr04YG04bNC0jcQdSFOfZk9kbmiADrbiJIdpyj54O+v54BhU0+2yxxQ4xbA5qF7v2tEHNfjLmI2slUYAnkTRJJLqo8/xtWSsh7LXqJTGZ08mXUalLkxcdBOC7a6owkHKPHC4RPtduwP6zLKcBj0cHE3XGt21WVqjleC9K+tg6vrOqTnpdDguYYYuSNGQBAJdbWY2nPifxW82izQ/Kh9MZcNT8o3dO8SkKWzWMvR7XL+CBLSVy2kqPTGFRylUIg6r5a6QVIweFXJdDQiHKPIVpd7KCCcITnZTjHIDSl0nFwEsmojcsdeb+BOTK4pyIqnXgNAIgVz8noLNUuagpzKBuOeAydlgpk0wrDSY8y+wDVXAOrtMQxtO0A4z1mz4uyuf+L3/0XrF+M6LBZwi5dytd+3trw4g0epwOJMCXQ8XIIw/zFBwUfujkcIPhykn3Bta9jSWiXEF7z2VCaVEpZYlUpB+tVrP4PlKpgdM=;4:U8LP7wDbu4uEs9ZJV+R1WS1XemPEyhKEqKMzj01iYrlMCfy8P05TiDtC7ZfOXZaEVwipB1WSCBOH0gEV6T/5sseUb6kIkbqPJepIqOk1EQTBfAq3ZePIqwOn7CLAk9ossUI/ZUUY6UYinVGjX9K8IQy7P8H5M8uXPM3jd6cqtlgD+CfHiOz50S4LgrHfrJHIFAXG4VxVClhb31EXpAdeCPo2k4/LRCSnKmz30fROgdV/UwmlM0j14uOguretDkI26LfPMb3gO2f38yHKONtU/JR01yDEJmVxN5Sht/is70e4e0IAIvtB7E4Y8GHbp0dJ
X-Microsoft-Antispam-PRVS: <DM5P136MB000967C2A233D58DC6606EAEE8DB0@DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5P136MB0009;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0009;
X-Forefront-PRVS: 060166847D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(189003)(199004)(316002)(1076002)(8656006)(2361001)(16586007)(66066001)(2906002)(68736007)(7696005)(85782001)(52116002)(97736004)(105586002)(51416003)(76176011)(106356001)(86362001)(2351001)(47776003)(6116002)(3846002)(48376002)(8666007)(25786009)(6346003)(39060400002)(26005)(4326008)(50226002)(9686003)(305945005)(386003)(6486002)(59450400001)(53936002)(36756003)(6666003)(2950100002)(6916009)(81156014)(478600001)(8936002)(50466002)(7736002)(186003)(16526019)(5660300001)(81166006)(8676002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0009;H:far8gsqyz1.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0009;23:/R2qL73iCSco4AjAfkS8h91zAPOC8LrMkA1EmiApm?=
 =?us-ascii?Q?3Z4rDaoK+91L6I4jrt7yt2TyMr5aG9SFoe69e1Plz7XoQGHZ8aVyOTQ31e38?=
 =?us-ascii?Q?Bz/WENPCwYAou3k6T6tw5JqcCZKXQ0TDMsbdZLrxXJGTJkkhLuIWryAj6v5a?=
 =?us-ascii?Q?IkfQo/RjRp5/qSzQ8mVq1mMOLzY5M7Z0hWezyet4uK7oKi+bUkwYnwRRqsV9?=
 =?us-ascii?Q?MoOTloYd1pI5sDXTt+58sh0ilS8nyFfNGv7894i9Q7aqmamO6kM8jGEHSpJd?=
 =?us-ascii?Q?srm+krdZi+h4zwCqT4hEpcezWb7qfBK+aG/356TXUr/W1PO8KGeQaMgCTDUA?=
 =?us-ascii?Q?xriJQ5go45++NhqwL9P4olVv2zh5s2sJzlgFYQ0yzPB8XAL5Rl+6kHEnSLZn?=
 =?us-ascii?Q?kauL2IaFiKvX51s0E2RERHhJjBp/Rn8JUeMrLDVk3tSe4tYuiSRjqk0zYC7o?=
 =?us-ascii?Q?rVZoi6sk0t+AFmPgBvBPTb7XL8vDuvvEpq3qVeo/2UqRpkzVWomjTJsyhU2Z?=
 =?us-ascii?Q?18mFSAyJvcfG6qLRdsdrlikVdGbgeLGDzXlIboP2iVLapnso7powRSrt5lqz?=
 =?us-ascii?Q?hy6VaJIhmeXfTjaJ+R+3I/srzFV5jwz9+TZM5A9IXP1j/3J2vkU4QuALc3YQ?=
 =?us-ascii?Q?eZPeWYoVzFxolp/MuuM6eUX/kslaSxMHU39vWBbkgGKf9P3FIhnEwFpBPsYy?=
 =?us-ascii?Q?8wYHYRP0pcSIhXOyT65m6GfZKuNwRC435AHQhW8Znx/6XU6osZbw1lf5YtTr?=
 =?us-ascii?Q?sFU+PI4ItWrLACW+KpygS8gwfiKDA3fM5ErWPN26M7STmF6KaMY6vWOo/ks2?=
 =?us-ascii?Q?di0qyYyEIaiI8Ro+6JbSofvRDdtR1/hMMr4HNIre/c8JIsHBtiLKonMLDKMs?=
 =?us-ascii?Q?mZdQJbhAuKO9UYUGkq0MXIerJn4lDzy2mneX15ne/9gg1V9Wi3wxvB4ujIQD?=
 =?us-ascii?Q?9Ikyl1ZT7lVckXtU6TxLZEXI8iyH7RxT/K9enpuYiUrlHRfzmBBp50Yx97Mt?=
 =?us-ascii?Q?TfkS/5dMif9VzhQquM2tvXRXd1pfPMJsGuQjnzpBApuh3Kt6yBwp/EjSl+w3?=
 =?us-ascii?Q?+JVhlUaWBqLWTWsWdy2jbHd7p1WwuI8x7l0WdQQnNIzayQ7DWZRLGuHLpHgP?=
 =?us-ascii?Q?w09/wdrLGXBawgFTWP26QbmOqaaa1zp9z4cxkQU0ydyiiI1FcVpfyxlVXQcI?=
 =?us-ascii?Q?VR+SVrG44moX+dgl5T9w9gMPRF0YAFhCwlgwdNiJJpXZCQLMg3PE5+jqvPlZ?=
 =?us-ascii?Q?BBTnX6FEU26dvezbbP8UEJ2dmUdaRqo4LC9EQrxWHdyJF72G5sJeCojH0KAs?=
 =?us-ascii?Q?MXdjFGz+3CTYKY1771hvRM=3D?=
X-Microsoft-Antispam-Message-Info: FFqz1HkbbbYz/Yq6zUZNaSeF8FbgxqEbaFlh8lqDIF9EtcaH+M0JS9WIv2Py1qQbhsjXQLe8YQB8wGOxfcmqud0bN/m7G2SHKX1Lx+146686XjbH7Zh3hKJ58cycJNakuesk+hLCQhPsztBR825EM+wCRmaEGIaeRutHc2cHjZpc4O4aoMaMa2dsSch23ICU
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;6:SMI4ym95JczH89y2dTgEvxdUaetzlga59e6j7tVi0TbKjCJr4eMRpsTEArcT0asHtNTDxfQ0UGPn4cej2etIi4O8xEx4yXkv6z8u3qzdvmgCmfeLdpRT1gTc7vEQ4WS9AoDEHu8/B0hGXi/CV6P4YqgHE/NtVEkojYMf7YAEV0pMtmcXnu/zyB7ZdWOGNWht9x5bxXYuaR+oqjpmwc6/bXT47lq+GdGAVALp173nG1WaYZG/giXgnKNxF/MUw0xQGBx7RXp/88hEvJ3TVQEdgK8v+Flpz5G6VUf9Ad0oeqrgo2H664IaEYbEVXnFvcE7CatiwDGuWjha3wzl0EYtcIKI5mI3r1xfTSMhkIH/2Cc=;5:lUbuXRCyu2vTR+o3LNo9KhHhGsZTg3Prvt5E/oC00AZZVGLGXzGBQrrXJGjujj3k5+uZMmHSaGbBe5iqVjHrIB899rdgkPGZBOYSu8QRvsmhcfxhuTtlY2tre93GCjWK/QV/eN45K/tL9aWUS+61vBJyR3tSLQHU1vJuUFcObyM=;24:AacH7742Eeg0wXojBE+tMrFXYJP9HjZasj4dmyQcs87c7XxQjeJnYbWKMTnmtW3PN0ADE3FmwV/Gh8ilzKdF83cFuYUa2zPwXM0iQW9Vwk4=;7:0EOZP8OnJxU6dcYksRZj/84CIsO0m8AJ1/L6BzhsIN+UraVKHHjeRfB5wK1ItoPA8T/69WmfG0nPKdvunY2syUMH87g5gvVLjmsaNZRZpbn1zQSx6f+J5NCF3ToPB86Lper7NPx1aaHb+H902Q4IRLtN/3fbQ7t+DEQU4M5bsXGb4CkiZ9RZExrONdZYQ4nbkCRSNTQX3jgG9xEPMnDQcGwecWShK7dDNzaq8G3wpW9KO9vZRu9TMV63tbFQd4HK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2018 20:14:56.1513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc442569-c853-47d6-6e6e-08d5820c9ac4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0009
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Check that new content is valid with respect to the user defined
'working-tree-encoding' attribute.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c                        | 50 +++++++++++++++++++++++++++++++++++
 t/t0028-working-tree-encoding.sh | 57 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/convert.c b/convert.c
index 2f864df258..9647b06679 100644
--- a/convert.c
+++ b/convert.c
@@ -266,6 +266,53 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
+static int validate_encoding(const char *path, const char *enc,
+		      const char *data, size_t len, int die_on_error)
+{
+	if (!memcmp("UTF-", enc, 4)) {
+		/*
+		 * Check for detectable errors in UTF encodings
+		 */
+		if (has_prohibited_utf_bom(enc, data, len)) {
+			const char *error_msg = _(
+				"BOM is prohibited in '%s' if encoded as %s");
+			/*
+			 * This advice is shown for UTF-??BE and UTF-??LE
+			 * encodings. We truncate the encoding name to 6
+			 * chars with %.6s to cut off the last two "byte
+			 * order" characters.
+			 */
+			const char *advise_msg = _(
+				"The file '%s' contains a byte order "
+				"mark (BOM). Please use %.6s as "
+				"working-tree-encoding.");
+			advise(advise_msg, path, enc);
+			if (die_on_error)
+				die(error_msg, path, enc);
+			else {
+				return error(error_msg, path, enc);
+			}
+
+		} else if (is_missing_required_utf_bom(enc, data, len)) {
+			const char *error_msg = _(
+				"BOM is required in '%s' if encoded as %s");
+			const char *advise_msg = _(
+				"The file '%s' is missing a byte order "
+				"mark (BOM). Please use %sBE or %sLE "
+				"(depending on the byte order) as "
+				"working-tree-encoding.");
+			advise(advise_msg, path, enc, enc);
+			if (die_on_error)
+				die(error_msg, path, enc);
+			else {
+				return error(error_msg, path, enc);
+			}
+		}
+
+	}
+	return 0;
+}
+
 static const char *default_encoding = "UTF-8";
 
 static int encode_to_git(const char *path, const char *src, size_t src_len,
@@ -291,6 +338,9 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	if (!buf && !src)
 		return 1;
 
+	if (validate_encoding(path, enc, src, src_len, die_on_error))
+		return 0;
+
 	dst = reencode_string_len(src, src_len, default_encoding, enc,
 				  &dst_len);
 	if (!dst) {
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 71e8e3700b..5c7e36a164 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -62,6 +62,46 @@ test_expect_success 'check $GIT_DIR/info/attributes support' '
 
 for i in 16 32
 do
+	test_expect_success "check prohibited UTF-${i} BOM" '
+		test_when_finished "git reset --hard HEAD" &&
+
+		echo "*.utf${i}be text working-tree-encoding=utf-${i}be" >>.gitattributes &&
+		echo "*.utf${i}le text working-tree-encoding=utf-${i}le" >>.gitattributes &&
+
+		# Here we add a UTF-16 (resp. UTF-32) files with BOM (big/little-endian)
+		# but we tell Git to treat it as UTF-16BE/UTF-16LE (resp. UTF-32).
+		# In these cases the BOM is prohibited.
+		cp bebom.utf${i}be.raw bebom.utf${i}be &&
+		test_must_fail git add bebom.utf${i}be 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* UTF-${i}BE" err.out &&
+
+		cp lebom.utf${i}le.raw lebom.utf${i}be &&
+		test_must_fail git add lebom.utf${i}be 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* UTF-${i}BE" err.out &&
+
+		cp bebom.utf${i}be.raw bebom.utf${i}le &&
+		test_must_fail git add bebom.utf${i}le 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* UTF-${i}LE" err.out &&
+
+		cp lebom.utf${i}le.raw lebom.utf${i}le &&
+		test_must_fail git add lebom.utf${i}le 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* UTF-${i}LE" err.out
+	'
+
+	test_expect_success "check required UTF-${i} BOM" '
+		test_when_finished "git reset --hard HEAD" &&
+
+		echo "*.utf${i} text working-tree-encoding=utf-${i}" >>.gitattributes &&
+
+		cp nobom.utf${i}be.raw nobom.utf${i} &&
+		test_must_fail git add nobom.utf${i} 2>err.out &&
+		test_i18ngrep "fatal: BOM is required .* UTF-${i}" err.out &&
+
+		cp nobom.utf${i}le.raw nobom.utf${i} &&
+		test_must_fail git add nobom.utf${i} 2>err.out &&
+		test_i18ngrep "fatal: BOM is required .* UTF-${i}" err.out
+	'
+
 	test_expect_success "eol conversion for UTF-${i} encoded files on checkout" '
 		test_when_finished "rm -f crlf.utf${i}.raw lf.utf${i}.raw" &&
 		test_when_finished "git reset --hard HEAD^" &&
@@ -132,4 +172,21 @@ test_expect_success 'error if encoding round trip is not the same during refresh
 	test_i18ngrep "error: .* overwritten by checkout:" err.out
 '
 
+test_expect_success 'error if encoding garbage is already in Git' '
+	BEFORE_STATE=$(git rev-parse HEAD) &&
+	test_when_finished "rm -f err.out" &&
+	test_when_finished "git reset --hard $BEFORE_STATE" &&
+
+	# Skip the UTF-16 filter for the added file
+	# This simulates a Git version that has no checkoutEncoding support
+	cp nobom.utf16be.raw nonsense.utf16 &&
+	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
+	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&
+	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
+	git update-ref refs/heads/master $COMMIT &&
+
+	git diff 2>err.out &&
+	test_i18ngrep "error: BOM is required" err.out
+'
+
 test_done
-- 
2.16.2

