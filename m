Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B40921F404
	for <e@80x24.org>; Wed,  7 Mar 2018 17:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933762AbeCGRbb (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 12:31:31 -0500
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:59904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933533AbeCGRb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 12:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=J69mn/t6t5D1jRhtAYc/kQOWcUeXm/Q64R+qbCEU+RA=;
 b=MRtA8qxRi9R5vLaemXWG+S/J0rmX3F5A6iBvbUUApsrYAF4assvFDZZsNZlgbVFKwZl6+rOp0DVDoZIl/wU/vrjeP+XLXLZVjD2djBhEEISc3QzbmZtoapmmSTTgZyjWWb2qn2BoPhg/WZhLw0FtmmEttevdH8dc2XIlg7f7bVo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from neu8r3hm32.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Wed, 7
 Mar 2018 17:31:19 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 9/9] convert: add round trip check based on 'core.checkRoundtripEncoding'
Date:   Wed,  7 Mar 2018 18:30:26 +0100
Message-Id: <20180307173026.30058-10-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307173026.30058-1-lars.schneider@autodesk.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0083.namprd15.prod.outlook.com
 (2603:10b6:101:20::27) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17cc60b1-8f66-4814-41f6-08d584513eb3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:rqGOhypSWJ48sSrJir1XBiSRBvhtA4IW5czURGcohDLwyMXoEMJPN99fqIN+EKrbwftSOXtSUpQ3KjID5EV3nLtDG8S102NLim+QLqU1QMYjANp7WvXGgnLFi3Dfg28Rj2WiHRZGrTDB4t6muS++11OrSGn5uY8SnAh264JuqxlsyPiyjcB3SYmkEt+RFEFU1QRkRnd+NRT85DyYfJCtUUo99SyYy0MNNXTQWUtPimQe7csyS35+rwygEPpLwME7;25:gbz99KD571yxooqRaHlW6MXD3RTS4fWmEvORMXm7UXFESDrT/zACRT+W4jgi7Dbymm0ptOehDkY0pFHp4NeHm4Z6rQKwz4/bxZdvkuufhoZzF8fX70vPKNhzSEsjkMgEIg9dE3R6PP9gCU48KX8JyIDVdyeM/dzFIxxBM6AGWpOWvPFg0mTpqoNwlW0QrMK54CXjtVjUipmUjEW8jAbbat6It7Cld25DtxxFDc+MUhivkxj6B5Jx4aQ9NbA9xRuppxi4AlB+xQtQCRmS4IF/b2/WM7a0AlKK/5CvHPn16jPZ1D3RojmV1GFisJ8RHZ/JMFjMEdQkH92rrdQpOFAnwQ==;31:JgnxSji7zVcKymSnbjIpsrRoUf4o5qENF7vVIivhOKxH0NyfticKBhrxqLmyZTfdZL2vS1i/vTAoyjxHCi/7OVLSbeVsu6r4Qq3GcRszv5/gSDpKaEhnOlt/ruBCHKup9pjWVEaCnJC6drSIGPkBEtmAKiAYvPSCeWUAc+H29rFykI0dwZRTQo/E59b8dP1wMZag56FeGFtUKzJhZNshRYBGyqoNvyDAqbZ0KTZcjz4=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:Nihs4gWCLwT8EXfHb1xUGFqWteQp3Kz2xd4231FXDqFEXJK6c+eNz7CSRC6NqevqsN7Rrc+3Afo7Q6w4BeCT8UTDM5eaBmeSiUP/NdmA5Y+G0OJHU/62PV5LZrtr2A6Kph/DNBUcWvWr4KR0G/90uIiAaSqpvR9iTlqNEVojT+gKV/4UPyAcSgXpmIYYvZlc6JI4Z0SvMkzIJRwRyjdgQuDa9CJPCiGPLvox5HQugf8X0CsJmoxMRQkq3hL8LRxTsUtVWK02e3Vqz7aHmuBoci1sJho+59Evtqg0FtTbGqHAja6ODNHMiPhsIvTCoCJyiOZcqIpETDmK3D780Ls24F800SHXVkKdPaUQJ6gs9rSrRnZucrPOw3niB1uFLnVBxy/wiWYR2EjGCyqDcR3qMz0YAOyzGnlQrOjBpBTS3WNWqNMQfMJC47M334GEHO5DePaiIfKfZzfOh6FjTIbylpY+0Ber8Uvc9AcSldlQ6D1ewSDNWihNjwlA1CUaUzdFHUclm7jkZjqRqEIKEyseJlShJoytmXVmKIVa8tu1GYNesCSBsTKpWEFTPfrWVLs4SLDguA5Hk6wcYmSY4j2PjJX8sbDcjguy+oAKvFcOp7g=
X-Microsoft-Antispam-PRVS: <MWHP136MB0014DA338C5C6EEF5D3CE7ACE8D80@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;4:1kPmvExVSow996pQMN6KIbjmwoOrPgqj/rChyhCuo4sL7VGx4DHsbB5uQ72RoNTYsEH5ZTbGg7AOYlhhQhoI3oX4ku29T48nIfaXIN3nkzXQD6K2qeOYdJ46teKqibYpglhJGaJZe8L/jmu9cFsJ6l3w6GWX84/OpNtyrIHkIiguDz7jh/kIopH2FSc6PNzrnvm6BQBAyKBxGyV3FSkNkx4BfqglCwAlRnjvl+YHZwi6vFyNn8bjPWW4hV1AVrfLVaurKO2gnC3xTXaalIIvDn+nvQFNiC7ofWJ6y44Jf8BiFQRdSTQDd+z/Cb9Uesa2hw+oWHoTe6nICdU6Vqnp0FORAOazWxzgyHV0kEc4Jg4=
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(68736007)(36756003)(53936002)(9686003)(16586007)(16526019)(186003)(59450400001)(6486002)(4326008)(26005)(6306002)(316002)(8666007)(386003)(8656006)(53376002)(39060400002)(76176011)(52116002)(7696005)(51416003)(5890100001)(97736004)(25786009)(50466002)(2361001)(2351001)(966005)(105586002)(85782001)(50226002)(575784001)(86362001)(478600001)(6666003)(2950100002)(6916009)(2906002)(8676002)(7736002)(48376002)(106356001)(5660300001)(305945005)(81156014)(8936002)(81166006)(66066001)(47776003)(3846002)(6116002)(1076002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:neu8r3hm32.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:RT0WHLAmen+RLEk0RSZQhwfCaPDYKyTPH0rUd4g0M?=
 =?us-ascii?Q?GWjUZTWjsh966cnl7nP47Xex+iY+hj6xU2DSW1ht/rlLRLK1itcDF6tFX0If?=
 =?us-ascii?Q?OxoSoxTKF1cDIsXq/sw6iY6l9Zdxs0Zzw54gpWLfokXITdbVJlM106F1vsSd?=
 =?us-ascii?Q?a8Z4riUXDZq6D87wmpk/ZLyu5BFW/L+fFP0muBAw8eucP0cTq34STUXEfUFW?=
 =?us-ascii?Q?BmZFlOdu7GKvPUdCL8zU8Ms436/kFel9/gaypiA3NbMRQspt1yV34ITaTior?=
 =?us-ascii?Q?MWaB+3A1MZDTcgHqyRKh/lpciq1aXdSi7oPMtfQCqjki8/BfHks1PGZgBODU?=
 =?us-ascii?Q?HUe8boAYhMR6g6xVRonzST0YBwLhEnF6q8YdaKqHL7yOVRF8UHGBJ25FeOl4?=
 =?us-ascii?Q?+b1h/ksgYon0dfPEsOQcZMqTFmvjpdD+0Sacw9xpDBkoEjVytfllAg0YVF/c?=
 =?us-ascii?Q?Al2ul4VXgObFOMO2hgTkgDkpMh+oq/IilfuUGf8/OF5+94Ggc4FUZ8R1eUWY?=
 =?us-ascii?Q?8IofdP0dmE3fhB1PAtjWY/UgEs8BbyddkD/i18cfTVOlCWnRVvSga/Jk+xkI?=
 =?us-ascii?Q?tVnr9Pc7oZgxUVZXpzpdnz+09XYcCFDO0O/OpTuATiq+3+8IVw8hXWcedaTK?=
 =?us-ascii?Q?IGlVpkSjMm9AAnzJBy+b3bqk/Zuum/6KRYgN49FdPKvYh7QVUbFXDOkTxBc2?=
 =?us-ascii?Q?TuxvflrqmOQmWgzIJtCHPRRn9E/sZv8MGFibmJOnHlv8izfw1TfsGHuoTpft?=
 =?us-ascii?Q?zNJZaCt12QGK+kHssQxRRoVkrkCtxkmilqPtiT0zkGkKJUFM28s/xDM68Laf?=
 =?us-ascii?Q?xcgQ+dS3N0KPoR5irHsKlHRVknLTxA3bLIDbpI5HTb/61UGycb2cYIiUeD63?=
 =?us-ascii?Q?670SYBIAXXLGq5adAB7ftZTtfRXrHXBoFHgZilWj6UDbngwatIvlAWQbnIkd?=
 =?us-ascii?Q?99BcgRsdDeTFIZqGER7Iq1Gt1zekswO6ZKFkqUoUFq1+sc5aUe6In6aus2+p?=
 =?us-ascii?Q?ANBjRPSKjheR0gZUokBdytsLqUAcVa/kGTf/DPVdplAztSlm2DOSd70bNpU8?=
 =?us-ascii?Q?ZcdPadhoJOG2GgwQmWJGWcP3wmxrxFsLgkzxZ5tqpujQL8WI7RPm+w5lTnH/?=
 =?us-ascii?Q?1Ui6Ck73kDy98YU+fR93NVw/jOl/kpcES08kq2f3fceCNoEk6dawl0gBRyX2?=
 =?us-ascii?Q?mrOCLP6ps/MLlxaaa/nTJ8ue1U9e+pkiDI4Ntu66H6bIq/HosfkfELuVIiP+?=
 =?us-ascii?Q?7BaMR7ahEDkQ3W+JYSoRMwAHwGu9wa++GgOQ56bskPuQKVkGkau/GKfAafP9?=
 =?us-ascii?Q?VgircDkcjSPZZD9o1XqCWK9V/sPUyylYiEQpeQv2EE1wr7Ddom4HPdRT9y/V?=
 =?us-ascii?Q?sysYYWDnyhK+X3IilCmGzfOPJN3/NAt26VdFmVN0bl2uq4+?=
X-Microsoft-Antispam-Message-Info: InhQxIIj/dmeyaKayucP3/PJ/O/IxWhGUSk2HuVbl7O+fGTXp/SafdS9CXrqXfjBR8BOP6xJAQ6xsxeNkydwHrG5iUXVIYYqdadT8znduPtn9Gm89I/A1ZpeGBklnpjMrEfrSG7WoaZPxOzyeES1xzMckKpbiH2hpTfPjBRu2JDzWroOsRmcqXXHz5JgwwJM
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:EAxz6il+f5j6IInzE2iu0YIvZeGB6Q5IvnP4dtGmK9VXMLtRvsz2l0QlnH4TH1BdaExbB0Ll/Hsj/pUTqqKkbNzJrFiVASLu2iXh/Zt4YIFY34cn6fTUjURQCOoB7pXmbQxP5PL6DT/3zxYNxFc46vyWDppa1PviZ0kZRN+uFCvdyTCvFAjoNTbiy3lD3tslC9sYPHzm14ZTTWqTcgRWIRCJHQ7MV2kQxX54ubRbsRI9dSjWlvn2AiG8OLr6GTsgXH/hlHHdMj+11IEIFX1zp5Q6xS/Op+0D233dhPYsUjv0Pq2w9GLHRv+kCQuI1UgZDRyAapr8F8ZnQFzubhDUyKrfQhU6w9ruFZDkmTtnKQg=;5:JKL0cHS46ebHaNq+pedR4TS0DwJxT5iVyKaASB9nOF3CpHLOEYhnXiJdSmc0qaikPflG3REV/Wul7EjsYCypd6WrXGTd1kZCoojWsDDULeuNFLb//fnj4xSEEms9r04IqAnwLvUbtut2FlkNZHCECnZjR5SX4IEoel162A0gCes=;24:okUjKkvPm/qgoFWw57SSpUOAFIhPqXt5kAPDOOk2BAWGY/EV64nQHkQa1vx37rlnyB24BoQvZqurS/GHn9XJYmQIZv27nf20DJA5VZutSqI=;7:RugYvwc6ZOkISfeMz1v+s2JCfYvubbaSY/pOi//8xqLACPWw0431Yepw1fIcq9O214Y40o/NmhyFcckJMCgS+BmmhrXS46s7ONXjsg/R4ow8WGeSdHqoVWwCLtteOuxK46aaHaICxWdSPm1DYhohN2oTWITyac6kLa0IvqfJQ8VHHCnom0/EtWCCiUYIKbCZnFMNcEhZnkU21ue15KwokhoreEFHypvmjje2w7dZs7pg57hcHVj5i/e5+ro8FNnn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 17:31:19.5695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cc60b1-8f66-4814-41f6-08d584513eb3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

UTF supports lossless conversion round tripping and conversions between
UTF and other encodings are mostly round trip safe as Unicode aims to be
a superset of all other character encodings. However, certain encodings
(e.g. SHIFT-JIS) are known to have round trip issues [1].

Add 'core.checkRoundtripEncoding', which contains a comma separated
list of encodings, to define for what encodings Git should check the
conversion round trip if they are used in the 'working-tree-encoding'
attribute.

Set SHIFT-JIS as default value for 'core.checkRoundtripEncoding'.

[1] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/config.txt         |  6 ++++
 Documentation/gitattributes.txt  |  8 +++++
 config.c                         |  5 +++
 convert.c                        | 78 ++++++++++++++++++++++++++++++++++++++++
 convert.h                        |  1 +
 environment.c                    |  1 +
 t/t0028-working-tree-encoding.sh | 39 ++++++++++++++++++++
 7 files changed, 138 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e25b2c92b..d7a56054a5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -530,6 +530,12 @@ core.autocrlf::
 	This variable can be set to 'input',
 	in which case no output conversion is performed.
 
+core.checkRoundtripEncoding::
+	A comma separated list of encodings that Git performs UTF-8 round
+	trip checks on if they are used in an `working-tree-encoding`
+	attribute (see linkgit:gitattributes[5]). The default value is
+	`SHIFT-JIS`.
+
 core.symlinks::
 	If false, symbolic links are checked out as small plain files that
 	contain the link text. linkgit:git-update-index[1] and
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 31a4f92840..aa3deae392 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -312,6 +312,14 @@ number of pitfalls:
   internal contents as UTF-8 and try to convert it to UTF-16 on checkout.
   That operation will fail and cause an error.
 
+- Reencoding content to non-UTF encodings can cause errors as the
+  conversion might not be UTF-8 round trip safe. If you suspect your
+  encoding to not be round trip safe, then add it to
+  `core.checkRoundtripEncoding` to make Git check the round trip
+  encoding (see linkgit:git-config[1]). SHIFT-JIS (Japanese character
+  set) is known to have round trip issues with UTF-8 and is checked by
+  default.
+
 - Reencoding content requires resources that might slow down certain
   Git operations (e.g 'git checkout' or 'git add').
 
diff --git a/config.c b/config.c
index 1f003fbb90..d0ada9fcd4 100644
--- a/config.c
+++ b/config.c
@@ -1172,6 +1172,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.checkroundtripencoding")) {
+		check_roundtrip_encoding = xstrdup(value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.notesref")) {
 		notes_ref_name = xstrdup(value);
 		return 0;
diff --git a/convert.c b/convert.c
index 5776dfbc99..e861f1abbc 100644
--- a/convert.c
+++ b/convert.c
@@ -341,6 +341,43 @@ static void trace_encoding(const char *context, const char *path,
 	strbuf_release(&trace);
 }
 
+static int check_roundtrip(const char* enc_name)
+{
+	/*
+	 * check_roundtrip_encoding contains a string of space and/or
+	 * comma separated encodings (eg. "UTF-16, ASCII, CP1125").
+	 * Search for the given encoding in that string.
+	 */
+	const char *found = strcasestr(check_roundtrip_encoding, enc_name);
+	const char *next;
+	int len;
+	if (!found)
+		return 0;
+	next = found + strlen(enc_name);
+	len = strlen(check_roundtrip_encoding);
+	return (found && (
+			/*
+			 * check that the found encoding is at the
+			 * beginning of check_roundtrip_encoding or
+			 * that it is prefixed with a space or comma
+			 */
+			found == check_roundtrip_encoding || (
+				found > check_roundtrip_encoding &&
+				(*(found-1) == ' ' || *(found-1) == ',')
+			)
+		) && (
+			/*
+			 * check that the found encoding is at the
+			 * end of check_roundtrip_encoding or
+			 * that it is suffixed with a space or comma
+			 */
+			next == check_roundtrip_encoding + len || (
+				next < check_roundtrip_encoding + len &&
+				(*next == ' ' || *next == ',')
+			)
+		));
+}
+
 static const char *default_encoding = "UTF-8";
 
 static int encode_to_git(const char *path, const char *src, size_t src_len,
@@ -389,6 +426,47 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	}
 	trace_encoding("destination", path, default_encoding, dst, dst_len);
 
+	/*
+	 * UTF supports lossless conversion round tripping [1] and conversions
+	 * between UTF and other encodings are mostly round trip safe as
+	 * Unicode aims to be a superset of all other character encodings.
+	 * However, certain encodings (e.g. SHIFT-JIS) are known to have round
+	 * trip issues [2]. Check the round trip conversion for all encodings
+	 * listed in core.checkRoundtripEncoding.
+	 *
+	 * The round trip check is only performed if content is written to Git.
+	 * This ensures that no information is lost during conversion to/from
+	 * the internal UTF-8 representation.
+	 *
+	 * Please note, the code below is not tested because I was not able to
+	 * generate a faulty round trip without an iconv error. Iconv errors
+	 * are already caught above.
+	 *
+	 * [1] http://unicode.org/faq/utf_bom.html#gen2
+	 * [2] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode
+	 */
+	if (die_on_error && check_roundtrip(enc)) {
+		char *re_src;
+		int re_src_len;
+
+		re_src = reencode_string_len(dst, dst_len,
+					     enc, default_encoding,
+					     &re_src_len);
+
+		trace_printf("Checking roundtrip encoding for %s...\n", enc);
+		trace_encoding("reencoded source", path, enc,
+			       re_src, re_src_len);
+
+		if (!re_src || src_len != re_src_len ||
+		    memcmp(src, re_src, src_len)) {
+			const char* msg = _("encoding '%s' from %s to %s and "
+					    "back is not the same");
+			die(msg, path, enc, default_encoding);
+		}
+
+		free(re_src);
+	}
+
 	strbuf_attach(buf, dst, dst_len, dst_len + 1);
 	return 1;
 }
diff --git a/convert.h b/convert.h
index 1d9539ed0b..765abfbd60 100644
--- a/convert.h
+++ b/convert.h
@@ -56,6 +56,7 @@ struct delayed_checkout {
 };
 
 extern enum eol core_eol;
+extern char *check_roundtrip_encoding;
 extern const char *get_cached_convert_stats_ascii(const struct index_state *istate,
 						  const char *path);
 extern const char *get_wt_convert_stats_ascii(const char *path);
diff --git a/environment.c b/environment.c
index 10a32c20ac..5bae9131ad 100644
--- a/environment.c
+++ b/environment.c
@@ -50,6 +50,7 @@ int check_replace_refs = 1;
 char *git_replace_ref_base;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
+char *check_roundtrip_encoding = "SHIFT-JIS";
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 6f3a82f61b..7cff41a350 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -188,4 +188,43 @@ test_expect_success 'error if encoding garbage is already in Git' '
 	test_i18ngrep "error: BOM is required" err.out
 '
 
+test_expect_success 'check roundtrip encoding' '
+	test_when_finished "rm -f roundtrip.shift roundtrip.utf16" &&
+	test_when_finished "git reset --hard HEAD" &&
+
+	text="hallo there!\nroundtrip test here!" &&
+	printf "$text" | iconv -f UTF-8 -t SHIFT-JIS >roundtrip.shift &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16 >roundtrip.utf16 &&
+	echo "*.shift text working-tree-encoding=SHIFT-JIS" >>.gitattributes &&
+
+	# SHIFT-JIS encoded files are round-trip checked by default...
+	GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 |
+		grep "Checking roundtrip encoding for SHIFT-JIS" &&
+	git reset &&
+
+	# ... unless we overwrite the Git config!
+	! GIT_TRACE=1 git -c core.checkRoundtripEncoding=garbage \
+		add .gitattributes roundtrip.shift 2>&1 |
+		grep "Checking roundtrip encoding for SHIFT-JIS" &&
+	git reset &&
+
+	# UTF-16 encoded files should not be round-trip checked by default...
+	! GIT_TRACE=1 git add roundtrip.utf16 2>&1 |
+		grep "Checking roundtrip encoding for UTF-16" &&
+	git reset &&
+
+	# ... unless we tell Git to check it!
+	GIT_TRACE=1 git -c core.checkRoundtripEncoding="UTF-16, UTF-32" \
+		add roundtrip.utf16 2>&1 |
+		grep "Checking roundtrip encoding for utf-16" &&
+	git reset &&
+
+	# ... unless we tell Git to check it!
+	# (here we also check that the casing of the encoding is irrelevant)
+	GIT_TRACE=1 git -c core.checkRoundtripEncoding="UTF-32, utf-16" \
+		add roundtrip.utf16 2>&1 |
+		grep "Checking roundtrip encoding for utf-16" &&
+	git reset
+'
+
 test_done
-- 
2.16.2

