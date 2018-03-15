Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1957D1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 22:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932575AbeCOW6A (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 18:58:00 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:22756
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932537AbeCOW57 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 18:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5KJ9npVDq4TrKvaY5sCIkUPqpt4HQPeuUboPn0htuk8=;
 b=JOve4RTBxreoKIdS/YlwyZZbBvkp2WPRGfMQwc/TS/GLmp5F7ZMhwyrYDIuSkaKQ1rgqJ+PVZSq6ld9JXlPelIrv458H88qkOvkrxa5CUB1d182le8KpaHHatiKTWG6na3mY7OcdV7kEjixj7l1dGZAO2rkjQB8+F4InWkSm58Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from rem2ua0031cfw.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Thu, 15
 Mar 2018 22:57:52 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v12 00/10] convert: add support for different encodings
Date:   Thu, 15 Mar 2018 23:57:36 +0100
Message-Id: <20180315225746.18119-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:104:6::21) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da085c1f-7023-406d-94cf-08d58ac83079
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:hf0X2Fh018yw+7+HlkZSkx6kOvvTAEWcOJRBJTFr6RTtIWcDTQMjbll/CuPzWTCVmO7bo6Bm7Eii9IopBo4RRNNUJj9f1ZZk2ljGER212c7E4cQtJ+usjhyE5h+yapAiloZqQJ5x/xryBvmdpNCgHoIJElrmm+pAOJqTb7NEKW+TO0aFgPvD7qpOQMy4YtsDu4tE+VqhVDKDi0IXbXchWaW5Qpa7W2YSquPE4Jrij9gq6/hIDMLiEsTY8Fr4Y3a+;25:7mrJufe6Q39i3kKUsOOlnwDbZxNUVmyPo0NGb4xlkXHZzHhKpxTcQ9ROHEQ+So+7AYk06odo8ZovJhiSGGaRlw5ifhXDvuaQJNkItPU2sLHJXoBhJ6T7du+T6P/+AjBJRFpegzmjkn0glZdKgkpvoRAXaxltsnS3C75sVdj2TFGf3nnVIeebgvth4x1eWPtPX6urQiAMn3RzrnaOCgdp1nOUlr6YLpDFDQ28N0XRPCVF3zKWUC5pG6aETULmzSyo1nqPFG10rNyAyCqjEBLEtresTH+Ln8iNxQplow5Se8+N9dZV4h3HdADnsqSvohL6CIjR/euGvLHiGtSZCip0vg==;31:3GsHVx4ZsCN7vb+GiItEekK5xk/sd6SBylxYJQR6kouLZj/F01NNo/4DgWVbKi8Xy3GVcJD6lNxUJpZo2uA4Z022MLapkt0Q5+G9KT2UWbtV7RFjcSkM4md3wN0lCkcy3ZXlaB0ZuuztoD887cy3JYq/42qf0Pb7LjZfP5ntvoDofVJmmqQbxS4JpfmzjyHBk8EtRHxxyK/LZEXzXI07aIEJC55rzGjYKrA8sLbK4cA=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:OQM6McEzq0mNW6R9TihCwx1R+U8rstmfVx4fOvRpd58fDzlhna20ulTtYPre39OT5lo5zIcZwb/FMIfiN9LZI2ky0tIqYe2Kbh9U2OU0diE/3aGCDAj/Pi1NHWvMUYoFnVXwNN5H6+gRUtKmdzD6kMhp/dQuuNAxLXwG5zQvcviY/EPnQ1ACopnB57typpcLUORldhMXPR40+0vHH0xGdacOFfJz2hI7j7+K3basTuKXtR+I6pQgllM5C/Wz7WtuRFfiIU0XvajGHpcmK+EfG7IeujD3V8C5eGk5i/BKUkXBsAQvgCuqIRd+xFhxix0/caCxgtLA0OF54fPNtRhPgf27oqBljpl1FSE7zui24IyAkkj+/aYtJxUA4Dh78ErXLHe8sun08tzdAI0STBfsQzMCALDxpar69BEnsC/9L58DUjfk6+b6ay3Vm2Us7XIB/d7330/d8HG7UUFw0w3K6PsQOQmLo9OTx8mUx865AMnN005XVPrSpUSKSCwgTwSx1oUptBpSGEZFk/TsbzFDZueieHBVaNJp+ycMet30uMbmGELeVceYjMWYemca+mzxbSrbf+dQNd7lsGv80hV4Ff3YswD/TJOJGVWksMwapl4=
X-Microsoft-Antispam-PRVS: <MWHP136MB00146AC303B91288111D10FFE8D00@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(85827821059158)(245156298449039)(61196332173343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501276)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;4:YUnM7PdxqyIZ38W0GUqtDrdm+Tf0TcAbWxWnUOqa0826I3Pp9vLXqwJYebv/TnHYoeiQlJuWNR01jcD7v0qEpURroWaKfKc0GyBJVckmo+Fh7VJdiWTF6rtMHS5GdMITHELWOphTLHycthgv+pLyg8HR6gZLCZHltWq4BPZCGHdkwA0ch9pbRWZvoCJCH9SFYbpEXNthhy9O2AeOXcBvso6hL/pwvts1z2AK7GFBODucPNvTHnQrvdAn/f0yA1lDom+C6U4yBCqoWjfFIETRfe6+4o/EHuH0Weit7lxMDWbIPRG1OATqowucTiAg7uZ5Lu57McnU1/7HRq+DRXFEWUPZNz79KNR8mJ7ezB199s4cz1kdmguE7xnlKvdZSmzn5+FdYNJ2F3VA7Mcnzf+o7E5FcXbqWRm0vAQ5WlfqAjU=
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(377424004)(199004)(189003)(48376002)(386003)(6306002)(86362001)(8666007)(25786009)(59450400001)(36756003)(6916009)(7696005)(966005)(6666003)(3846002)(68736007)(6116002)(186003)(66066001)(9686003)(50466002)(8656006)(97736004)(5660300001)(316002)(16526019)(7736002)(7416002)(305945005)(39060400002)(1076002)(16586007)(53936002)(51416003)(2361001)(81166006)(85782001)(52116002)(4326008)(8936002)(47776003)(6486002)(2906002)(8676002)(105586002)(2351001)(26005)(50226002)(478600001)(106356001)(81156014)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:rem2ua0031cfw.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:w8iDCn6f77LGubBTMeUw9jh7c4NakOCEeVuuRo3S+?=
 =?us-ascii?Q?cO2PxTisEC3vn66P/kE6A4XvL1CrJoD3naRxoOc6lDK+pc2HiZB1YlCI6koM?=
 =?us-ascii?Q?Q68aSOmvXan5luGHSb7Cb4Ik2w0Sw92vd+tCqVVCwiZ8Y9vzyBxCl8rb87yI?=
 =?us-ascii?Q?UWQNMNRYrq3bJrg7ElqqwixkhIn0mggM4HcpEM3cGWNGTHyFy6i3DVA6obiN?=
 =?us-ascii?Q?37x4HP8MMRoZxgGFbzp96eC1xnTlMQQJa+Bq01bprTsBkcLA5Xmzn7LDITv7?=
 =?us-ascii?Q?ta9FRL3Ty8jAXSpG3m+KUcSIyeZv6if2IlX0GgtV07hKwQBv2yA9gvh73q5I?=
 =?us-ascii?Q?pVOt86DxT41iK3nVZbk9yzz+Pv3nYZCD8KltuV7u+js4sSI3dfYHOgd4Fe6P?=
 =?us-ascii?Q?JSu9JCgVY54n1r4yNc6uLcNfRl8fAxUv73uEctdHrI1EeiX4nHXVGKrzHwR6?=
 =?us-ascii?Q?r+B1aIPwKIYe/bMM0dukSt6VscvCq45/Ikw2IQorcwrF47kYMREkD30wQXYo?=
 =?us-ascii?Q?W9KLCgz8qbHTCAnE+lwarenQIs+DM+uJRbFjhiNojQaAU+5pfY+0QOoV1tjI?=
 =?us-ascii?Q?PwunzCiMSDRFEOnllGUidi/JR9f4Ws0FPrFQfUkWBmNnvKrIktHjTw2Vlb5v?=
 =?us-ascii?Q?RTKzWeZj74huXXoqaY+97dmHJoixF1rESKMFI//QzPO5nmlHvLQlsX04bjGb?=
 =?us-ascii?Q?Ogs+t1N2XozDoOSX4xKy4VnOyHSpHSxuW4DwaLXrrGcqkRsGqLXZ3ZgSTrcj?=
 =?us-ascii?Q?LmPoBWFmvbiXJovfR196i5Irmo58/fG4WpBKB+VGIgMDLgUURNyq+pCqXFpS?=
 =?us-ascii?Q?YzdheaiFuhlxXJ5mAWtk8Dnp3oaJPP9IaezpuKOiGoJ/Ku4tJMwIRL7L2mxS?=
 =?us-ascii?Q?39ICQh967/cOAs3dclPTkAfu9gxoFZwDz1IaX3/VOTiXr+zRD1HEPSGL6wY+?=
 =?us-ascii?Q?528oZ98C4kyUxpifi/6OD4ARP/Epl8V9nf5uTQIfKQoERyQ9wA7/ulK3pKQr?=
 =?us-ascii?Q?oZLPABFwf6ZZxxFI5CEHAFgp42v4DPdFbrcq5VrvsrEl0x0enFeFLBowJaPZ?=
 =?us-ascii?Q?9w8Jog7Ik4mbGS+yIV/s4IQMz13qB+lhrZwCVqrIstSZfjsh35d1YZ//FlF8?=
 =?us-ascii?Q?IU0QvyNerfByJOI3Hji0SKxIFt9gDoCremquNHOjyE/NsMrGoAJk4F956nl0?=
 =?us-ascii?Q?4CZkK0M2gRqsnBPgin3UAufth3MXZdzIgM9uOHjaXWXKW0ltEmhUC3V6y1uC?=
 =?us-ascii?Q?6ib4X8anKwY53zYM5wSqwmnbsE74peDdyzdxQTeGRICAQH7owTbwXZGsgzVV?=
 =?us-ascii?Q?eGGq7b9cnUOKVJsq///hRg=3D?=
X-Microsoft-Antispam-Message-Info: 9vqvPXdaJdS7X9jmKMWeEMR2brCMPOqDBkbkzBRXTaKOkTx6cxDKCFyFnGpjGdeBTJhgKLBbjFGOpytdXNhWR21I20144UI5gnQco4vgZlzN8vkwzWLWVfY3EBszswO0olb8HADG+DJB3HJIxLYTTIqGwdIoTeYAcCqqPO5y5XAMBwfsGSqAmEYkNPWZc8Ww
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:iQYSUroPBrww2TAYCxPQCtxbsPLSJuueABn+eFsugWyfwZsVWohOC/tAb54hPjN88+NP2DJv6MYFg+RA42kOcvFhoQ/ZXIOKQrIx4fLuetwkiOPsZE0ILKpMBM6bdC935pR7YgI9Hi/17OrgqH0uVwyc1u9sElq6WOrwrkPoBDvB3C5AV8SHjS75h2Yb31EXahK5dhLDtKQdYvPYTSnSNtqiH6cg+Z06M7CP7iN9hAQzBoJOztwkElZm1lXsH2LF3kXzGY496yY5+qAyCzI0ijDX8gjiYI+RtMFa1GnYzSkBoDS1X+OOQptofPPK9+c8KEamTopuA/pcWZTFjyM7mDbiiNG9CyaZ8UyqM3REcQc=;5:O3U2gonKGDpIhKBOEY2HjjqEImTiw5Y8khO7pI1ws7r33fJRcCUTv0kyNtmA2uoGzIRY92szSZWGXAN3aGZF+AmLwDcTsXd8LD+1canPaztFdKN25LNRpJLiD2xuQuBXLfXTszaK7it1Td9c+TeXGvtZfQl2IahI+yp7Z/Cvj/w=;24:Y7McddGwatnxcx3nHoTlOG1a6Dqr2q0F35OmsrOCzcj/IzwA0o3cfZ1oeoiFtdmqQ9Jnr8cpVY5770k/Pdz+sbT/QvIw+LwJ9f6KPViElho=;7:gWqJ7UQeaFyAYBl418I1RKMAh6lZRZSWqbyRCjWvsigYNgIiKirwLsKe7X9TfXC7p5Ajj1A8XTNrLqJUuJRf9TiCDaVRI1gxDFTaOZl3hJQLBinVJyMnUMiYXZ5P4Rvx6SJ/mpcPlrQLfIqFypPqNU7ahk+dmDjlhYODc3/ugf5DF5lxQWgHOrKW0lD6Fd5kxab6p/0kLlj2AckQzRy+r8IsfRk9b42jgaLoKVFpTuCcvDBDzrfpuwoCQEcZVc7W
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 22:57:52.8847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da085c1f-7023-406d-94cf-08d58ac83079
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

Patches 1-6,9 are preparation and helper functions. Patch 4 is new.
Patch 7,8,10 are the actual change.

This series depends on Torsten's 8462ff43e4 (convert_to_git():
safe_crlf/checksafe becomes int conv_flags, 2018-01-13) which is
already in master.

Changes since v11:

* die if w-t-e is configured with a true/false (=undefined!)
  value (Junio)
* improve same_encoding to detect all alternatives for
  UTF encodings (new commit, Junio)
* squash in "advise canonical UTF encoding names" and
  remove commit (Junio)
* fix erroneous # in comment (Junio)
* force segv for non-UTF encodings in validate_encoding() (Junio)

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
  v10: https://public-inbox.org/git/20180307173026.30058-1-lars.schneider@autodesk.com/
  v11: https://public-inbox.org/git/20180309173536.62012-1-lars.schneider@autodesk.com/

Base Ref:
Web-Diff: https://github.com/larsxschneider/git/commit/0daedbbd76
Checkout: git fetch https://github.com/larsxschneider/git encoding-v12 && git checkout 0daedbbd76


### Interdiff (v11..v12):

diff --git a/convert.c b/convert.c
index c2d24882c1..2a002af66d 100644
--- a/convert.c
+++ b/convert.c
@@ -280,13 +280,13 @@ static int validate_encoding(const char *path, const char *enc,
 			/*
 			 * This advice is shown for UTF-??BE and UTF-??LE encodings.
 			 * We cut off the last two characters of the encoding name
-			 # to generate the encoding name suitable for BOMs.
+			 * to generate the encoding name suitable for BOMs.
 			 */
 			const char *advise_msg = _(
 				"The file '%s' contains a byte order "
 				"mark (BOM). Please use UTF-%s as "
 				"working-tree-encoding.");
-			const char *stripped = "";
+			const char *stripped = NULL;
 			char *upper = xstrdup_toupper(enc);
 			upper[strlen(upper)-2] = '\0';
 			if (!skip_prefix(upper, "UTF-", &stripped))
@@ -307,7 +307,7 @@ static int validate_encoding(const char *path, const char *enc,
 				"mark (BOM). Please use UTF-%sBE or UTF-%sLE "
 				"(depending on the byte order) as "
 				"working-tree-encoding.");
-			const char *stripped = "";
+			const char *stripped = NULL;
 			char *upper = xstrdup_toupper(enc);
 			if (!skip_prefix(upper, "UTF-", &stripped))
 				skip_prefix(stripped, "UTF", &stripped);
@@ -1222,12 +1222,11 @@ static const char *git_path_check_encoding(struct attr_check_item *check)
 		return NULL;

 	if (ATTR_TRUE(value) || ATTR_FALSE(value)) {
-		error(_("working-tree-encoding attribute requires a value"));
-		return NULL;
+		die(_("working-tree-encoding attribute requires a value"));
 	}

 	/* Don't encode to the default encoding */
-	if (is_encoding_utf8(value) && is_encoding_utf8(default_encoding))
+	if (same_encoding(value, default_encoding))
 		return NULL;

 	return value;
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 07089bba2e..884f0878b1 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -149,25 +149,23 @@ done
 test_expect_success 'check unsupported encodings' '
 	test_when_finished "git reset --hard HEAD" &&

-	echo "*.set text working-tree-encoding" >>.gitattributes &&
+	echo "*.set text working-tree-encoding" >.gitattributes &&
 	printf "set" >t.set &&
-	git add t.set 2>err.out &&
-	test_i18ngrep "error: working-tree-encoding attribute requires a value" err.out &&
+	test_must_fail git add t.set 2>err.out &&
+	test_i18ngrep "working-tree-encoding attribute requires a value" err.out &&

-	echo "*.unset text -working-tree-encoding" >>.gitattributes &&
+	echo "*.unset text -working-tree-encoding" >.gitattributes &&
 	printf "unset" >t.unset &&
-	git add t.unset 2>err.out &&
-	test_i18ngrep "error: working-tree-encoding attribute requires a value" err.out &&
+	git add t.unset &&

-	echo "*.empty text working-tree-encoding=" >>.gitattributes &&
+	echo "*.empty text working-tree-encoding=" >.gitattributes &&
 	printf "empty" >t.empty &&
-	git add t.empty 2>err.out &&
-	test_i18ngrep "error: working-tree-encoding attribute requires a value" err.out &&
+	git add t.empty &&

-	echo "*.garbage text working-tree-encoding=garbage" >>.gitattributes &&
+	echo "*.garbage text working-tree-encoding=garbage" >.gitattributes &&
 	printf "garbage" >t.garbage &&
 	test_must_fail git add t.garbage 2>err.out &&
-	test_i18ngrep "fatal: failed to encode" err.out
+	test_i18ngrep "failed to encode" err.out
 '

 test_expect_success 'error if encoding round trip is not the same during refresh' '
diff --git a/utf8.c b/utf8.c
index 81c6678df1..2d8821d36e 100644
--- a/utf8.c
+++ b/utf8.c
@@ -401,11 +401,27 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
 	strbuf_release(&sb_dst);
 }

+/*
+ * Returns true (1) if the src encoding name matches the dst encoding
+ * name directly or one of its alternative names. E.g. UTF-16BE is the
+ * same as UTF16BE.
+ */
+static int same_utf_encoding(const char *src, const char *dst)
+{
+	if (istarts_with(src, "utf") && istarts_with(dst, "utf")) {
+		/* src[3] or dst[3] might be '\0' */
+		int i = (src[3] == '-' ? 4 : 3);
+		int j = (dst[3] == '-' ? 4 : 3);
+		return !strcasecmp(src+i, dst+j);
+	}
+	return 0;
+}
+
 int is_encoding_utf8(const char *name)
 {
 	if (!name)
 		return 1;
-	if (!strcasecmp(name, "utf-8") || !strcasecmp(name, "utf8"))
+	if (same_utf_encoding("utf-8", name))
 		return 1;
 	return 0;
 }
@@ -414,6 +430,8 @@ int same_encoding(const char *src, const char *dst)
 {
 	if (is_encoding_utf8(src) && is_encoding_utf8(dst))
 		return 1;
+	if (same_utf_encoding(src, dst))
+		return 1;
 	return !strcasecmp(src, dst);
 }

@@ -552,13 +570,13 @@ static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 {
 	return (
-	  (!strcasecmp(enc, "UTF-16BE") || !strcasecmp(enc, "UTF-16LE") ||
-	   !strcasecmp(enc, "UTF16BE") || !strcasecmp(enc, "UTF16LE")) &&
+	  (same_utf_encoding("UTF-16BE", enc) ||
+	   same_utf_encoding("UTF-16LE", enc)) &&
 	  (has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
 	   has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
 	) || (
-	  (!strcasecmp(enc, "UTF-32BE") || !strcasecmp(enc, "UTF-32LE") ||
-	   !strcasecmp(enc, "UTF32BE") || !strcasecmp(enc, "UTF32LE")) &&
+	  (same_utf_encoding("UTF-32BE",  enc) ||
+	   same_utf_encoding("UTF-32LE", enc)) &&
 	  (has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
 	   has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
 	);
@@ -567,11 +585,11 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 int is_missing_required_utf_bom(const char *enc, const char *data, size_t len)
 {
 	return (
-	   (!strcasecmp(enc, "UTF-16") || !strcasecmp(enc, "UTF16")) &&
+	   (same_utf_encoding(enc, "UTF-16")) &&
 	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
 	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
 	) || (
-	   (!strcasecmp(enc, "UTF-32") || !strcasecmp(enc, "UTF32")) &&
+	   (same_utf_encoding(enc, "UTF-32")) &&
 	   !(has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
 	     has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
 	);


### Patches

Lars Schneider (10):
  strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
  strbuf: add xstrdup_toupper()
  strbuf: add a case insensitive starts_with()
  utf8: teach same_encoding() alternative UTF encoding names
  utf8: add function to detect prohibited UTF-16/32 BOM
  utf8: add function to detect a missing UTF-16/32 BOM
  convert: add 'working-tree-encoding' attribute
  convert: check for detectable errors in UTF encodings
  convert: add tracing for 'working-tree-encoding' attribute
  convert: add round trip check based on 'core.checkRoundtripEncoding'

 Documentation/config.txt         |   6 +
 Documentation/gitattributes.txt  |  88 +++++++++++++
 config.c                         |   5 +
 convert.c                        | 276 ++++++++++++++++++++++++++++++++++++++-
 convert.h                        |   2 +
 environment.c                    |   1 +
 git-compat-util.h                |   1 +
 sha1_file.c                      |   2 +-
 strbuf.c                         |  22 +++-
 strbuf.h                         |   1 +
 t/t0028-working-tree-encoding.sh | 245 ++++++++++++++++++++++++++++++++++
 utf8.c                           |  59 ++++++++-
 utf8.h                           |  28 ++++
 13 files changed, 732 insertions(+), 4 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh


base-commit: 8a2f0888555ce46ac87452b194dec5cb66fb1417
--
2.16.2

