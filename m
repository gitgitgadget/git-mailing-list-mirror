Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105AA1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 18:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbeDOSQl (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 14:16:41 -0400
Received: from mail-sn1nam01on0092.outbound.protection.outlook.com ([104.47.32.92]:64364
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752524AbeDOSQh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 14:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=C3Fd0ej9HSO6L0DUFBflwmz7ziO7daoOVrlUL8Kdf4Q=;
 b=aYUgP2l9xHZYnBzZt8nQDTIl89leWRI3a8NrXUpShpPNx9qOoOK1a80EssZI0I+r3Zemni91KuiUxe6+LDiy0XHcN4+whR5XhbV/68igkAN0Vdxpmu9IPId9u4oPVPaq7z8F9e6YFH0ywCWYX+1OiBaXFu5szmr8apfHuPtaAOo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remj8gtty1.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.675.14; Sun, 15
 Apr 2018 18:16:32 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, avarab@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v13 00/10] convert: add support for different encodings
Date:   Sun, 15 Apr 2018 20:16:00 +0200
Message-Id: <20180415181610.1612-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: AM6P193CA0010.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::23) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:BgJj1HN4bmAus33MSjdB/Y6coZ5YR/BkQRhdQugzkKtAoheUgwXUH2QYXT17RdUV06dA9k6/xGfHAEanxEXBY/2idY6eqh+XiR5XbCDBNXM+jT0sYn2Xj/kVOtlRKJkGR+Bf37l1UoKJWzLWHbdT1yHwa6FPSbV9Yc7LJ3+c+W7JH+0SOi/GnRSEg6KzIW1Zbi2jlBgPJ2Syo/eyIu7l3XctH/qyQfxiDL6VH/0KPobebE33klqxh5QNMTvR3zXM;25:xmjB7QIEhuABbfjpJg3qBPZInjygySSfCjmOFq6WsM1EsBLPk+k7d870vQHaGLVpsaNFI7dey8TkZwr9BWUChqs9zEfFh3DHYsIFV/4L08EnycFfV7UyE3ONMkfhyQUU76v93H77Tfl0R0Ei76+UanPzUmi27+EOQxa0nu89MwpxNryhRkIJoKGFdakAkqizvH6pvSP0a/mxDgdBQpVkKt9K2bN3tb2hKq122ZdDCcmk0lVFsEEjk+lB78mpFhCEa9Rnhz34N8ID6d4jWvHhyunEq6TQ1z274FPwS7erPOuFgf2HlqRJsyRqTp/FUAXxt8RrJsx9qT79O6Mr84BMzA==;31:mHhQFVfHL5uoub1fhCpAEQY9uAUNYn5abR1OtWMI8LoOFR5aTtsHB9lCfZNzOnRh4X/8uoOk93eI78YRdgt/olgREKhnfNVBCozUTbdIQWPGas550wFhae/jP3ZdQjb6DIBRGkbMyiYCh3beD2v7pekGlN+KLJ05gbbaHiDFWTo+cNYshRAAm9HQWi4CJARKWlgZZkbIEX1fUj20oOpGRt9OF2rhWRjCfQrHTzDxg7w=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:xDT6zc//mPmx/WHiNrezbdcerU23kGwqpmBnWABxoj0KbhjCG6Nxd1qIYek2DUdWxx3uQ0OEx0a0mW48d5EVx96yjCESet67Piwg5Vis1xMc/enujk9IEOFf8bK2FxyTRD7/5YYnq+LmrmP6y8oLO0foAKRmbb8XUndrze14X1mr5PpVDHbsYfzq+PnZq4l3BZj4dLAda6Yk8gj/fyUritj/hX9GmXSNPk/vJmmld7DIZQekZq2FQHENaO4E1ULxOriOPfOITonHANg8AFgvbfuuOtqmjrqi0rBUEm/Luk+dO67/W/LEzW2cIt4fh9D5dj2P2efp5pR0ENBhRB/yS8a8cJVAqaCT8/9/GG93yx09/RpoflCboWYstD0g6zaxfcyB/7UcKnuedPcJs6ZfOMwTz3kWg6/WRJv+f4+LNApsByICiYffkoH6iOd3uaP6zEr0r21hg1Tp6RbQBkYGwumZLpRqrsrILSB+aY/rR5G1Q1wc/xtmWED89FsKJ1i5mjOIjrX1IUaqPPlBka0xab5V9y/Q/Vj7YxF2tSMfF1zWic0inJRJcIFsN1YfiHvEdq76CaEBQAIit9eJAxW9A4aXK2sd3095Ng6KtDIx26s=
X-Microsoft-Antispam-PRVS: <MWHP136MB00149B12FE0B93C694976069E8B10@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(85827821059158)(245156298449039)(61196332173343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;4:BtSLMig3bOCqH6cXkeKNCVt5x1/E/3tUElGNB1VRjG//cYNi6ecFs8zdq8Tsf4toklcvLJm6Mo/f1fi0QFaNQYdxKbBW/+zR11Rp2pN4vnBPH2ZBRDdhnFJWlp0guoakzRId/LBDuGBnf5E5cqcFh6yjt36skr5VNkI0nmjU8+Z5+RG9pPGTngggi53cth4AfSnzODuZT1dAA5V8WhbbMhLLT00JolcABxjpSMZLhUuHy2b7Ev7q4wU2jfJjk0YvAF4bpsH3CJwVZYukFpUJKNmMECRzWy/sMe8LXl02SGXlcqXNd10n0RG1irymBDC0ksCJyYvSRlQMRlfJDzm1p2vnEZsBcrjoisS/mppmXQ0gEZpBlweK9lp8DjwqhWH4dBK2GXGj75wzMac1o1NQHXwYtvNXj7TejYTkiIIIx7U=
X-Forefront-PRVS: 0643BDA83C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(377424004)(189003)(199004)(53936002)(86362001)(8656006)(7416002)(966005)(9686003)(6306002)(106356001)(478600001)(52116002)(7696005)(51416003)(386003)(6116002)(97736004)(476003)(1076002)(4326008)(50466002)(26005)(68736007)(16526019)(186003)(85782001)(59450400001)(486006)(3846002)(36756003)(48376002)(2616005)(956004)(105586002)(2351001)(50226002)(8676002)(7736002)(305945005)(39060400002)(8936002)(66066001)(2361001)(81166006)(81156014)(5660300001)(25786009)(6916009)(316002)(6666003)(47776003)(16586007)(2906002)(8666007)(6486002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:remj8gtty1.ads.autodesk.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:V9GzUEK3s++ZGsljOwXxlIUVIZ3FH7moRn9bFGx59?=
 =?us-ascii?Q?nI7qlRBe33BMr8xYS2aYG7HiL+Qo2cr2ClGMwmyHWBhOne/WRZWca5IG0eW7?=
 =?us-ascii?Q?d9xQWkl7VXGDhGGZ/E1rucD8G3Dnd4dwW04zAKp3q/Tij/JVebA61D78CgVj?=
 =?us-ascii?Q?kRtNDSQs/3jcDp+4ZfypF5snl3dGuec8aaXY6fjO24JcdaTRbuaANmQekVIw?=
 =?us-ascii?Q?IEMC+zOw6gYZP+VFC08g3oyY+xcSrI2Bej1XYpIFTQh05UVBPaOK8jPI08+j?=
 =?us-ascii?Q?ewlEMo0P3HBBnMDNIwHm72zYEXduBlVhTjPubVvUv8KeYY3Oc8pB2ng5UnXt?=
 =?us-ascii?Q?4GD+BrPHrf/RUTQaxNDUiwDD/z8PIiIWMapddRuAJ0Am+2mmXbjHdUfsQvpm?=
 =?us-ascii?Q?wwIUNIPUPnyqnMZ2bnF38EXg9dYnN+n9VmXCYN2dzKJuvd2TSvBUhtSSMGP0?=
 =?us-ascii?Q?pui27b0qUAHHEnshmPTcbNKDShO8ZKoPslxxB0fp2ICFWWbPkKcWq5a8MXqQ?=
 =?us-ascii?Q?XvNr4iLzHx9eyR91etkjpf5J7Xw/3gV3/RFyFvI8xb9Gaos+HQeWKAvfnHzG?=
 =?us-ascii?Q?+HZsGc2N4FqklfL229QE9l3pFZLLDL7QxWbG8I/gj1U1AOZp75thTycZtc1g?=
 =?us-ascii?Q?/bFHmQVT/9ApgtTeP/SWWjqKyXpcK2VZd35yvo2djRAS4N5cxoZ4S9Fcwgj4?=
 =?us-ascii?Q?ZNA/5dLgleA4/ikO6d9eV0ZSha1raPAOMb8uy8DMDpcnDZsRO6b0iu6+iLTv?=
 =?us-ascii?Q?vq+Ktoo85WAOtluVq/nExV6My3l++f6b5NkJZpBPPNn25yFaNnO0KIS1myLM?=
 =?us-ascii?Q?1h8rLKah8GijvFqYg6L7bzznot3TLKQNnzBQAbhgfjR8CoAhyK9ziTEBB421?=
 =?us-ascii?Q?mbtUBOM0elh2niIej3Ddrek9KlG3syqdonifF1JJEdgY7vZ2a3X2BZDGAI+F?=
 =?us-ascii?Q?RquwfkcVQrITZo3mmU69fsH+SmFvu6t0fWUP7PJX7ZN9D/W30f0zpepgs7Vw?=
 =?us-ascii?Q?3cEq343ogtfd9ag5YUcSpHY0nyUmDcymk2xqyyuJttoOmDl3ZsdoRZSKOccE?=
 =?us-ascii?Q?NJRCNgTwgJae2tczmtRUfr4PYWY4H4lQ4ffWQGB4qqlNogNat3B4p6nqogGn?=
 =?us-ascii?Q?CjGfX/eMUTgqao8fMc+Qoh4kX7JRdnaf6cy82X9xF3PQ3TrMA7n3hHppvUK1?=
 =?us-ascii?Q?olExiV1SqUdB8ExstiqgLnSqvZWdWIsyc20riWFtvC/yJcHjkIZ3mJ/k9IRK?=
 =?us-ascii?Q?87gNJ2cQ/EtHrDmkk45Vlb0EYwkiXxJCshicwqEQ6IgNwbKP+HwLoB1ZaenJ?=
 =?us-ascii?Q?qWMKb7PnsG47mh61uyrtwZo7o/PDj0DvE7mdxk96FmwK4XH5PiN8IuaCkgaR?=
 =?us-ascii?Q?VF1AuPrRwkIk09Y8VvXTJD2/yNIG1Ohsw6KoN9rZb6z2RuQ?=
X-Microsoft-Antispam-Message-Info: ZmXNiw7bzD2CREgl01zogU6ZxJ9+vUeWRkuWTAhxuI1W9UqanNse0IWcarP7tHPuSxlAPg+MPIhvPQ38TYTTpMH3RgYNwg6My+uwMuPUsIY80ByY68S7dbpnnqF3DN0oTyVjgHzdCBTrZvPN83RjQB8CiO2ThIzoTpFsa8dIWVQn2jv+lhTdBginDzo35o6P
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:8R65Fw6DDFte7uchhqrp/zeVAXWTSBG2XMZalv6aMnaZwIoSQ2k2acGmL4LziXTTyA3fPLNNmwuqr+PeomPvkd7C0ABlfjczBcivUcr4WPkI0IUhDcRjNKNj2qQ/nW+qnPQPk4qyr1g3oAdrpt6qj544ZJLoll9Z4bxmjE6NNbJvNzNXB1Uqfbs6soA9LL+4zLCLulC0c232l9SWu7aq2XwtnWVndjZUGSaq/pgLcELaKeJwgujy/pP+DO3Bsu4GWkUU49SGauuuL6l96ks0VDcnIXpqVkX8R/pdIZS9lwhF3kXrDJhuIWAJStuzlUqjmaLSOWvX+MOU8ybmxMPe8jvrFH7iOWk1SJwLVgcF5mh+r6RvmWqmRqVeLvvGjD6vxHqp/eWxqgmBLoCWkJ2gIBATuUlhfgr+9WYPtyjbJrpRJDo/+IShQRq+FLn97s29NcDcbsQ4PobU3Y19CT5srg==;5:3OuV/l9zFLJlJCdUXnn48OIGE2etGSfrjznJKheO5CU4ha+yHtHKQ3Wz3CCQOtg7Sz2aJuhW2DTwz75MqA1NuXu4i2wvaeXodj/BZAaS7NBoiu0nCkp6fbQvvrYVofiK2pYqHJ3JTp7/FfPVG+lUjdAtycYHPwuPfkSuODDU7Qs=;24:/uDxIQiE4GK0hsb3xYj4hOV4k19UvVX33KSSC3LDIghr7Rt+C3HlXruu23rkVtpmef8/NjTPcrpz9S74G4HbH+IgzBmdnmTqkcE8AE2WTYk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;7:5QIjmNwERj1/8/j0+reiKYwF4r6QMgNRHDmqReYqVUsCD1a5h/htpZRRxEEJovJ4CTfN3OjtHDrU3DU3C1ytl0qj4BJY+4aJYCeB63yr+5uo9qAk7SC+1q9lf7Zh9ldBmb121jyLXQ4XvB++BISA24ir3mCcVapOvIm71Kw3dtI1F30sDadPEwQkn4zqRsFhMNrIa8FH8CdHu7jnT0Uo/Ahl2M+IS6oNtuMz8U5h+f5U/AUDxnY6l3mbfmDKzQng
X-MS-Office365-Filtering-Correlation-Id: a4be61d7-a6a3-4ec9-ebdf-08d5a2fd05c0
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2018 18:16:32.1778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4be61d7-a6a3-4ec9-ebdf-08d5a2fd05c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

Patches 1-6,9 are preparation and helper functions.
Patch 7,8,10 are the actual change.

This series is based on v2.16.0 and Torsten's 8462ff43e4 (convert_to_git():
safe_crlf/checksafe becomes int conv_flags, 2018-01-13).

The series can be rebased without conflicts on top of v2.17.0:
https://github.com/larsxschneider/git/tree/encoding-2.17

Changes since v12:

* commit message improvement (Torsten)
* prevent undefined memcpy behavior in has_bom_prefix (Avar)
* improve error message: true/false are no valid working-tree-encodings (Torsten)
* fix crash in same_encoding() if only one argument is NULL (this bug
  was already present before this series, Eric)

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
  v12: https://public-inbox.org/git/20180315225746.18119-1-lars.schneider@autodesk.com/

Base Ref:
Web-Diff: https://github.com/larsxschneider/git/commit/3aa98e6975
Checkout: git fetch https://github.com/larsxschneider/git encoding-v13 && git checkout 3aa98e6975


### Interdiff (v12..v13):

diff --git a/convert.c b/convert.c
index 2a002af66d..1ae6301629 100644
--- a/convert.c
+++ b/convert.c
@@ -1222,7 +1222,7 @@ static const char *git_path_check_encoding(struct attr_check_item *check)
 		return NULL;

 	if (ATTR_TRUE(value) || ATTR_FALSE(value)) {
-		die(_("working-tree-encoding attribute requires a value"));
+		die(_("true/false are no valid working-tree-encodings"));
 	}

 	/* Don't encode to the default encoding */
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 884f0878b1..12b8eb963a 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -152,7 +152,7 @@ test_expect_success 'check unsupported encodings' '
 	echo "*.set text working-tree-encoding" >.gitattributes &&
 	printf "set" >t.set &&
 	test_must_fail git add t.set 2>err.out &&
-	test_i18ngrep "working-tree-encoding attribute requires a value" err.out &&
+	test_i18ngrep "true/false are no valid working-tree-encodings" err.out &&

 	echo "*.unset text -working-tree-encoding" >.gitattributes &&
 	printf "unset" >t.unset &&
diff --git a/utf8.c b/utf8.c
index 2d8821d36e..25d366d6b3 100644
--- a/utf8.c
+++ b/utf8.c
@@ -428,8 +428,12 @@ int is_encoding_utf8(const char *name)

 int same_encoding(const char *src, const char *dst)
 {
-	if (is_encoding_utf8(src) && is_encoding_utf8(dst))
-		return 1;
+	static const char utf8[] = "UTF-8";
+
+	if (!src)
+		src = utf8;
+	if (!dst)
+		dst = utf8;
 	if (same_utf_encoding(src, dst))
 		return 1;
 	return !strcasecmp(src, dst);
@@ -559,7 +563,7 @@ char *reencode_string_len(const char *in, int insz,
 static int has_bom_prefix(const char *data, size_t len,
 			  const char *bom, size_t bom_len)
 {
-	return (len >= bom_len) && !memcmp(data, bom, bom_len);
+	return data && bom && (len >= bom_len) && !memcmp(data, bom, bom_len);
 }

 static const char utf16_be_bom[] = {0xFE, 0xFF};


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
 utf8.c                           |  65 ++++++++-
 utf8.h                           |  28 ++++
 13 files changed, 737 insertions(+), 5 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh


base-commit: 8a2f0888555ce46ac87452b194dec5cb66fb1417
--
2.16.2

