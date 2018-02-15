Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BB161F404
	for <e@80x24.org>; Thu, 15 Feb 2018 18:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166196AbeBOSQn (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 13:16:43 -0500
Received: from mail-by2nam01on0105.outbound.protection.outlook.com ([104.47.34.105]:23424
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163602AbeBOP10 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 10:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=J8V88/iAxn0EBdVq6MuNyBuTwfsT6ilvoV3nkSCdbr0=;
 b=HeC8W5WMPsxDUAOJpoMyZmhsFW3z1ZJtWPqKMdsiE3CuIqyA1KXUqQd336eUcNujOREP9+QLuMNsFHZtnGl71lIw87SXurvNoGsFkZ8vyfPqIKfNjS2HBwjeMdjClKbJQs8FIKNXokU5ePtkyetOj4E+4NgIFGhuWljz8+Oyz18=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Thu, 15 Feb 2018 15:27:21 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 0/7] convert: add support for different encodings
Date:   Thu, 15 Feb 2018 16:27:04 +0100
Message-Id: <20180215152711.158-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: DM3PR12CA0049.namprd12.prod.outlook.com (10.161.151.17) To
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ad10121-0578-4a8a-6733-08d574889c7f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BN6P136MB0020;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;3:FkO8oxZFV3vUvGCLnud9+VF87kg4Zvj5NYYmADYoxjQqxI+7FpXoY1hxhbJxUtOGJK75L8h4ZjgKXkcmOXXWjYwFJIUCQvIjx/DJRwJ4uR/HG5x/YQa4t1fCG8IIS03zmpf7jd+ezhuupfSsEkz9SiDnV+Baqsq325S2NQPSbj+BnOgDxo4Jv6aRGZzERKWykS2ZmkMoxTKhSkxSu4iOkwjGl/fIjAdzpEY6GLscYkrzrnHVtviZWknfofw8cGq/;25:OBOkDvEwwvUOHnp0TwIyqVemR1MhJhLaf6rBHHh9ivtzgaYVni6nrxxNA6C1y5/UIL421tRDPnH6NFXiii1WoJpNcx1LTVNnINTcH7kFvP4cGnHOspZwnmxVoHEXiO6EoPv8ZxkTbH2AEa+BzQoTU1Lfw1p7uQHfwgcNjUPjdu+/Y8e3sRKcZfQmw4NsyQMp3HqfQ9nE69M9HvaPvK72Ih+EcZaPqLPdQ6zTKu+T1dAJWH0COMjbP/PRzOTTH24sH3GjL24V1az3mNtx29bSD+1mTH0IeNHJJSJwVRXX2nrBIOScELF4FJ5wFWUPbQDCdKu0ABYb1mweBU3AYRf5+Q==;31:CWchBuzDwqOG4wizEJGbohd6z/XIAOsguqFED06yOPGpjkkpURofZbeHYy9v5dJftlhjG7Gx1dFDZVFsj3bh2KgcNHlheJ3IEv1RMR0A7eOcawXM/qGbB3yTdwsNQnXneC2yUGKhdpkjxrBASr7zSvNE33VwqWiRtIqsmVwRmZF/nwfLPhy5WkjGSziUsEisL65CfGquJqXCC5O0lIwb4cNtApsjI7402Zgk6DbO0uI=
X-MS-TrafficTypeDiagnostic: BN6P136MB0020:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;20:rFZsy/RG5K30/jziikCtnWfYTs27Xrn5VuByJSqWBsSF2yaCpfWqVQOVKqSNIlsot8XDnH4pYkruEKxdD/3iQmsa7j3229azx/YR0sNnOgVBh6aXis8OMY3wcs3ksgtJYfbGwP7c5SZdtlGIpbfsRl3o7qbofZGeYZH+HocGXbXzkR0kPDGxTVG5l7ZHSnwHRFuLFW2klKVHTfS1wJ/nCgUdm4uYEy4ASqpUSmfpoOiYGVsS+EBwASfNBuKVR9y3fxFhoZp1omPflo5WOScjIg1eWegLC6Sx1eRJY+nk0T7xuEKbomsXlvnjp/0nR/0mvbBphAQhEUWGkTwRl62b3c77kkNr9xfQnbYeXzPPt8DrVUbbikPfPVhIDn86usgFpOIxkhpWY0XaeiSm/GDA21Wd/Powghm06ROJY5Nfx5Q0dL+Oq46lWb7i/0Sa6lD3tsCbhWAzJ+Fp2dvyoOhlz9Zu5qggbsROH0SknyJE/h+Ad6B37FWZHTjgGQWwPenMqXOCGW6s2bx7I31znj+zZKWjqcDpsVvX9+ixA3F3I6VGjqsLpf5fC6ey8Xe+Yb3i52b6i9anM+NTMG3mk7kOt8NsGbp0ztj+FWQds1ale+Q=
X-Microsoft-Antispam-PRVS: <BN6P136MB00202C24571B0AE2B5317119E8F40@BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(85827821059158)(245156298449039)(61196332173343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN6P136MB0020;BCL:0;PCL:0;RULEID:;SRVR:BN6P136MB0020;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;4:F/iFJifwyI3y5SKI72JEnNpAcB+owplBJsKkO7/cOzD+EvcccNAb6skFO4a0aZa7U2KZhGoQqZkPNacWkMCey+lruqHOI9PZkvfNh4UgGXaAazAd+C3yT0/colRYd21Ngs9EIVGM7ELWdqDY7Hz4hGuLHPT7oLqAbFt5ZSP86x1czQQfmP9PuI8q6knLTOStHADY9YbacIyRDiu4aki+ui1mLnHKYERtp5T68EnTDallJ5Y4+bVrsCVZjdiLlSDfSQyrpXEe7lRGeMhAT3dmUVZJ8Dw0/4XjOJzdyHf99xpgmmFTFdIZkamDh89ngeCVpaGFIWL2Y5WFbQefuFwJuzL7Uw4/a4nv4TrtUhmWyvEmjWU3ioCp5oZ8XO8KlRP5QUxfkHtrihhxWLyfWUP8p5WVYK9QVOGIvM68OdNE9yE=
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(377424004)(81166006)(8666007)(85782001)(186003)(5660300001)(1076002)(6116002)(50226002)(6306002)(3846002)(86362001)(305945005)(97736004)(106356001)(16526019)(2906002)(478600001)(6916009)(26005)(25786009)(81156014)(105586002)(8936002)(48376002)(47776003)(51416003)(2361001)(36756003)(6486002)(66066001)(8656006)(8676002)(68736007)(50466002)(316002)(59450400001)(7736002)(2351001)(7696005)(53936002)(386003)(52116002)(9686003)(966005)(6666003)(4326008)(39060400002)(16586007)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0020;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0020;23:fV9M/dtcBFAvm/Yd47jAesJLhkSWmResewP2IEDZ+?=
 =?us-ascii?Q?YaWEUqM+iFGz2yuJVLjTfADenjZXrgBViV5t6kMj00Nu0trYqf29RZS+bsHy?=
 =?us-ascii?Q?J8AfFImtyvpp3V0VkbdKPt61jzOAeaPjygOxbLe3bWsKRm6kWx0T8iY7c08l?=
 =?us-ascii?Q?WOBCb5IGrrr1VvNjnm721i/yQUXYmLeIA6F3PmaEsjxf22/FiWp3z9x4IzNb?=
 =?us-ascii?Q?5TCHLAxR9taY/g6ra4SbzFLnRtdIBsI4QlzyPZpShp1onNp7KhYaN4SnT1Z3?=
 =?us-ascii?Q?ugzKGqRk/24WZgDbvLEzwaZSyREZbp+Uw+xR4gfUfuDX78yzFGSV1t8GpXhl?=
 =?us-ascii?Q?iQ9glNL0vauItG5s1QLJIYwkZzjb4yspA8E4xcYT6/cDi48o8j0QUsFKznH/?=
 =?us-ascii?Q?k5oZJNwe2YXXmWSbsE0tPp3eqM/UAaA0BsUh8itKj9qsKqu4TIwKXD7bq5kL?=
 =?us-ascii?Q?gcPpMHisXukR4z0p62Qm8+UckUaNX7GVb/Pj4EvvzyrEV69IJIPkjpfbmanE?=
 =?us-ascii?Q?yolx5pZMxkUU2M0FnY46jb5Rv5r13yX5z7Lu9vLAahjPdH2bj0+/K2qw3Jxw?=
 =?us-ascii?Q?l7kjROWUnIr/CMSBkckx0/S815XXr7MqFWcfpk9LXNj/s3MPmY57XTlgi8rS?=
 =?us-ascii?Q?zys6IFlk5D8M1GKc1oaqGE7re60RF+uq5qE3GAODz6tteblLz340tgWryVF7?=
 =?us-ascii?Q?9TR4o6qNIzJ4udZM46ZrR3XuZkjR3/ilujjDMj9x0A+a+lfX6u6ytX/pLCO2?=
 =?us-ascii?Q?+oSXhaWaFfF374RGBozTxIYYVF3YubrEbnX4L4Bbjs/h5d7iU9oj0G1xGtQc?=
 =?us-ascii?Q?ttAFPjxOeV9STT06eDl6MA6/j/COoBxZSeSZvmQF1mkgdJQ7ipij5oYux4fF?=
 =?us-ascii?Q?fdKoLdLB6M8DQTZTL3yZfYkH9tFr0grTTiANxvwSkpZI8cil21Ga4qO8ug1i?=
 =?us-ascii?Q?Dyp2n+5iCZDDzs/4gh1PFGigAcK8cEDWesxJUu1VR18+EAau6YUBAEy0zPx0?=
 =?us-ascii?Q?EJHOnK93gEnPt/Cyrh4JQiMhlrjZGe1FkKQDoMBppzeGq3n0QXMQq8vABjFU?=
 =?us-ascii?Q?Ym+25yo63Ew7MfnonH56MCI2wuak1fhZL7tT7ogw2ehX8tAHcl6HVrQmpgLQ?=
 =?us-ascii?Q?QRLYWKs2BvDElVIgRiPtbCjscTi/OdDJNKsojkCdi+cY9h+3615OMIq4g4WM?=
 =?us-ascii?Q?vyp9mgYjU79d8dlSXeckzG0yQV3zFYWLrWHy0ARNdezcaZcqzTMgKIKVTixe?=
 =?us-ascii?Q?Wc1HiG1vsSTtt3oM2wyoUqcaEh9tlP+UxUGPNtxTgw6MhWAqPxFa/2XRFRz+?=
 =?us-ascii?Q?OfY0qnUn3ScetvKuYp/2eA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;6:IXx67dG9LXto7dvkMAssMY0bO4q4cEB13Y+U+rIFGpaAQZRrtvwFiYA+2tQYRI2Q4AOYPskCGT3UHBbjF93aVXh+8D97Ya0Bos3nRdIz1vVCIPefHIgYXNttgZXHmi9dOy7Qbu9TUb07ZYTV600N3FQFvM8qr0RF3pSTa1qgTelaJCp6q3S6d+jeauPPKTJEk9QqNdt0jWwSzda1UGONwU0tVUH2nDsQrIkrJg8iN9dOdBDgmpAxZ3F/LaDZoFPo92P62pcenaVN9k8oaiSbepYnbtcv38QrvJUA1Am4DBRcHWhauOSaCYuDQ3BlR5o2BHaoEAbRif+6NyE9ShyHItOz8e50CvYE9e7ji69ClbM=;5:bQrBwdiR4Mc2f5I4PCtkB3OylVfo/TGV/b3D2n4DQ6mWx4PZl4Opb1hLAeTJlbbq1ubOX8Z+JVZKvI3+ibgYASAWXD89THS/T9wzGc+2gojuez2vQ596CeN85M+EJ/zf8fAw+ZzVcDoyc8u8W8bh30j/A1x5j2CAEWlThACNg0g=;24:ZG2CIqSbT8f/NYIJUAqcyTPu0ZAryeJ5oBvvMsTh/+1Y/6M9MKJtEhnlZxS01yHOZhwQDhy2MkJA/tZuadPlQyaVbTr3pXY4a22jwqWBRS0=;7:BbrhRtRhBycBcKufBrdnMm0ZUEzspbtpCPlRKru7ajiOhaUh01eGa9O79hlRDoo+vz9EzmcAJjWgDn8D1x8sLJbem7hmJThekCV8ccyCc+eaGVDPwsghzdze8DKLknQ/O/icj3vr4gSlMhiTT3EWRt22ky0YO+3oLSL+WZrmpKtwi9XK2q9vzmgXAZAZvT5WiGzIIaa64K59JSOl6e2rNGw7Gy+44bYQIRGRncRKvzriolQ20EFWlDswfjp+ucuy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 15:27:21.4168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad10121-0578-4a8a-6733-08d574889c7f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

Patches 1-4, 6 are preparation and helper functions.
Patch 5,7 are the actual change.

This series depends on Torsten's 8462ff43e4 (convert_to_git():
safe_crlf/checksafe becomes int conv_flags, 2018-01-13) which is already
in master.

Changes since v6:

* use consistent casing for core.checkRoundtripEncoding (Junio)
* fix gibberish in commit message (Junio)
* improve documentation (Torsten)
* improve advise messages (Torsten)


Thanks,
Lars

  RFC: https://public-inbox.org/git/BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com/
   v1: https://public-inbox.org/git/20171211155023.1405-1-lars.schneider@autodesk.com/
   v2: https://public-inbox.org/git/20171229152222.39680-1-lars.schneider@autodesk.com/
   v3: https://public-inbox.org/git/20180106004808.77513-1-lars.schneider@autodesk.com/
   v4: https://public-inbox.org/git/20180120152418.52859-1-lars.schneider@autodesk.com/
   v5: https://public-inbox.org/git/20180129201855.9182-1-tboegi@web.de/
   v6: https://public-inbox.org/git/20180209132830.55385-1-lars.schneider@autodesk.com/


Base Ref:
Web-Diff: https://github.com/larsxschneider/git/commit/2b94bec353
Checkout: git fetch https://github.com/larsxschneider/git encoding-v7 && git checkout 2b94bec353


### Interdiff (v6..v7):

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index ea5a9509c6..10cb37795d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -291,19 +291,20 @@ the content is reencoded back to the specified encoding.
 Please note that using the `working-tree-encoding` attribute may have a
 number of pitfalls:

-- Git clients that do not support the `working-tree-encoding` attribute
-  will checkout the respective files UTF-8 encoded and not in the
-  expected encoding. Consequently, these files will appear different
-  which typically causes trouble. This is in particular the case for
-  older Git versions and alternative Git implementations such as JGit
-  or libgit2 (as of February 2018).
+- Third party Git implementations that do not support the
+  `working-tree-encoding` attribute will checkout the respective files
+  UTF-8 encoded and not in the expected encoding. Consequently, these
+  files will appear different which typically causes trouble. This is
+  in particular the case for older Git versions and alternative Git
+  implementations such as JGit or libgit2 (as of February 2018).

 - Reencoding content to non-UTF encodings can cause errors as the
   conversion might not be UTF-8 round trip safe. If you suspect your
-  encoding to not be round trip safe, then add it to `core.checkRoundtripEncoding`
-  to make Git check the round trip encoding (see linkgit:git-config[1]).
-  SHIFT-JIS (Japanese character set) is known to have round trip issues
-  with UTF-8 and is checked by default.
+  encoding to not be round trip safe, then add it to
+  `core.checkRoundtripEncoding` to make Git check the round trip
+  encoding (see linkgit:git-config[1]). SHIFT-JIS (Japanese character
+  set) is known to have round trip issues with UTF-8 and is checked by
+  default.

 - Reencoding content requires resources that might slow down certain
   Git operations (e.g 'git checkout' or 'git add').
@@ -327,7 +328,7 @@ explicitly define the line endings with `eol` if the `working-tree-encoding`
 attribute is used to avoid ambiguity.

 ------------------------
-*.proj 		working-tree-encoding=UTF-16LE text eol=CRLF
+*.proj 		text working-tree-encoding=UTF-16LE eol=CRLF
 ------------------------

 You can get a list of all available encodings on your platform with the
diff --git a/convert.c b/convert.c
index 71dffc7167..398cd9cf7b 100644
--- a/convert.c
+++ b/convert.c
@@ -352,29 +352,29 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,

 	if (has_prohibited_utf_bom(enc->name, src, src_len)) {
 		const char *error_msg = _(
-			"BOM is prohibited for '%s' if encoded as %s");
+			"BOM is prohibited in '%s' if encoded as %s");
+		/*
+		 * This advise is shown for UTF-??BE and UTF-??LE encodings.
+		 * We truncate the encoding name to 6 chars with %.6s to cut
+		 * off the last two "byte order" characters.
+		 */
 		const char *advise_msg = _(
-			"You told Git to treat '%s' as %s. A byte order mark "
-			"(BOM) is prohibited with this encoding. Either use "
-			"%.6s as working tree encoding or remove the BOM from the "
-			"file.");
-
-		advise(advise_msg, path, enc->name, enc->name, enc->name);
+			"The file '%s' contains a byte order mark (BOM). "
+			"Please use %.6s as working-tree-encoding.");
+		advise(advise_msg, path, enc->name);
 		if (conv_flags & CONV_WRITE_OBJECT)
 			die(error_msg, path, enc->name);
 		else
 			error(error_msg, path, enc->name);

-
 	} else if (is_missing_required_utf_bom(enc->name, src, src_len)) {
 		const char *error_msg = _(
-			"BOM is required for '%s' if encoded as %s");
+			"BOM is required in '%s' if encoded as %s");
 		const char *advise_msg = _(
-			"You told Git to treat '%s' as %s. A byte order mark "
-			"(BOM) is required with this encoding. Either use "
-			"%sBE/%sLE as working tree encoding or add a BOM to the "
-			"file.");
-		advise(advise_msg, path, enc->name, enc->name, enc->name);
+			"The file '%s' is missing a byte order mark (BOM). "
+			"Please use %sBE or %sLE (depending on the byte order) "
+			"as working-tree-encoding.");
+		advise(advise_msg, path, enc->name, enc->name);
 		if (conv_flags & CONV_WRITE_OBJECT)
 			die(error_msg, path, enc->name);
 		else
@@ -405,7 +405,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	 * Unicode aims to be a superset of all other character encodings.
 	 * However, certain encodings (e.g. SHIFT-JIS) are known to have round
 	 * trip issues [2]. Check the round trip conversion for all encodings
-	 * listed in core.checkRoundTripEncoding.
+	 * listed in core.checkRoundtripEncoding.
 	 *
 	 * The round trip check is only performed if content is written to Git.
 	 * This ensures that no information is lost during conversion to/from
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 5dcdd5f899..e4717402a5 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -221,10 +221,10 @@ test_expect_success 'check roundtrip encoding' '
 	git reset &&

 	# ... unless we overwrite the Git config!
-	test_config core.checkRoundTripEncoding "garbage" &&
+	test_config core.checkRoundtripEncoding "garbage" &&
 	! GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 >/dev/null |
 		grep "Checking roundtrip encoding for SHIFT-JIS" &&
-	test_unconfig core.checkRoundTripEncoding &&
+	test_unconfig core.checkRoundtripEncoding &&
 	git reset &&

 	# UTF-16 encoded files should not be round-trip checked by default...
@@ -233,14 +233,14 @@ test_expect_success 'check roundtrip encoding' '
 	git reset &&

 	# ... unless we tell Git to check it!
-	test_config_global core.checkRoundTripEncoding "UTF-16, UTF-32" &&
+	test_config_global core.checkRoundtripEncoding "UTF-16, UTF-32" &&
 	GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
 		grep "Checking roundtrip encoding for UTF-16" &&
 	git reset &&

 	# ... unless we tell Git to check it!
 	# (here we also check that the casing of the encoding is irrelevant)
-	test_config_global core.checkRoundTripEncoding "UTF-32, utf-16" &&
+	test_config_global core.checkRoundtripEncoding "UTF-32, utf-16" &&
 	GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
 		grep "Checking roundtrip encoding for UTF-16" &&
 	git reset &&


### Patches

Lars Schneider (7):
  strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
  strbuf: add xstrdup_toupper()
  utf8: add function to detect prohibited UTF-16/32 BOM
  utf8: add function to detect a missing UTF-16/32 BOM
  convert: add 'working-tree-encoding' attribute
  convert: add tracing for 'working-tree-encoding' attribute
  convert: add round trip check based on 'core.checkRoundtripEncoding'

 Documentation/config.txt         |   6 +
 Documentation/gitattributes.txt  |  74 +++++++++++
 config.c                         |   5 +
 convert.c                        | 256 ++++++++++++++++++++++++++++++++++++++-
 convert.h                        |   2 +
 environment.c                    |   1 +
 sha1_file.c                      |   2 +-
 strbuf.c                         |  13 +-
 strbuf.h                         |   1 +
 t/t0028-working-tree-encoding.sh | 253 ++++++++++++++++++++++++++++++++++++++
 utf8.c                           |  37 ++++++
 utf8.h                           |  25 ++++
 12 files changed, 672 insertions(+), 3 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh


base-commit: 8a2f0888555ce46ac87452b194dec5cb66fb1417
--
2.16.1

