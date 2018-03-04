Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46E341F404
	for <e@80x24.org>; Sun,  4 Mar 2018 20:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeCDUPn (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 15:15:43 -0500
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:20096
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751848AbeCDUPl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 15:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pq/HOwT9KkjT9J9ut3lu4epUonoSc3cIM5YLpQNFPVQ=;
 b=gIr1Zl2bxYR/fXTnPxoP6rLyRg4ijEpw8xWDOSR3dnSqIwbdEgb9gJhW18yRsXSKyI1L/gFyHMBNKGo9rEDeSbApq+38QKEwLxsmjD7+u/e8tSZFEnDwML8jmoNzVm2/XwRgrGCV14TTSZgAyXqie0T7goH5hX2ma0w9mrgANKE=
Received: from far8gsqyz1.ads.autodesk.com (132.188.32.100) by
 DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM (2603:10b6:23:8::20) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Sun, 4
 Mar 2018 20:14:34 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 0/8] convert: add support for different encodings
Date:   Sun,  4 Mar 2018 21:14:10 +0100
Message-Id: <20180304201418.60958-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0113.namprd15.prod.outlook.com
 (2603:10b6:101:21::33) To DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:23:8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6a4b817-b952-4a4d-d713-08d5820c8e06
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0009;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;3:cXZuUqnYz8dXnfzu/WOBoVZ614wX483XR7b/UencCTdE1tN85Xfm7gtVz2zBmw9NRZMGEHna036RHMfI4WD1akTJpTuJ2/m5TNGQPb3pUr56K4Y0yzH/Ko03St3oBKeMA7jX5B7lLLS4cF2/nBhNt1V6wfVstTPa8x6c3KjEVRbQ7rwK//KhbSwxBSl9RssX/KEip0CSGot0//fxeqexfT50/0pCsVj4i5aLWTk6l4WxWY3E1+PM048wW1rt6y3G;25:O8kbEPhqMKWwYzrGlZFZSO1CKkmXcq7hr1gYERsZbcXlPg7Y2hKf2LABKFl3ludOwq7E3pMbL0ltvY4jzQ22ARoQf24LJq0xa8ndhoZekc2b741IBdfkvNDxsuUi1A1NPrwKGVKguTq0ApqdOhYbfzWC+tJBcpPN3kD3xhwB9LD460JT0r9LFfMOk/zZTF7vM9LKl2nJ1HV0XJOmfwgxnD8Ozu3mNKPvLrO9xBnmNHjTIx/T/E4J0iOU3HNUbiId2aEJ41xQcvuCKkqMoIWug6f0paip/yIKM3HaU4WrndMZJL3XJ02M80ajOue7x1f9Qzy175C9FpvIwRUH1vhBDg==;31:vhpXTqbTyVYz9ghosG63Imd3dlhLP3QlApJTSvdP5/rWSaysEr/P8TsfT4RBCpeHFuCer9r5v/sNs1+HoNnp05hINvduxV7txOVTV73p1Wax1Uk0xgxCrS4DFlyqvCqHWnPf1sgQLaBZfsL/OFJEE6lDSqNfUBxsl1JvmDIPWMwAuslR3/sey8f1BywG7xHaM4A4tQ8AailBx2azVkREApxNsyS2BRQ/kuPIVW4rLi8=
X-MS-TrafficTypeDiagnostic: DM5P136MB0009:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;20:mnH2s9+Pwq6LjQPjfe/D7uTT8EX/pEIE1dtEapcKuDErv3ZKrxnwtcZpYuGzGTGhRbXrqix67EkqTgKxV4pqFK+GVoF5aMlrD95uysfYXDRXUPYsKY/Oag0d6qCUPjtnt7cO0OGQhbljckzdTNCeXPVuDkMetQq3MCYk3EiKABJrgQUuwPx75Vg4X1OS0RCsT4+4xW50lcl+bhYT04LapRJhXj9iodfqyfvZTF9a9iY1hPz3LITyasAlLNmJ3aWwEHrARG/Qpr6mUKZo+/sOUSNpMNKZB8aRQy4ZGNzKzngdjUSh3ns0EZgkk9oRsZQ5CMdqgY5hFSBiJQTFP8qZ1cF9Up173vjizdsiPBPZRWWiVDEeqDP+pURsZk9u7mOrAypHSXpRfK3xGWceyitZ3P+a6/ti9d4NBFwKvOL96VJZe2u0xivdCyv8bkItv8+DXqa8e9vHBlaOnd6LhgTKWl2Juq8oAyAnpZqO0EVkKCNGZFWm3ZfJO8X/ssKO4o/OCKu0B/bO+hmy+Zk220Wt0owAzWskP2lCinKi1KI8wMnussPUXQAKK/UI786aU9KSdlHHV8gKt/eNyKFVpquFvvvK9NiFjPJsL/fPqAPA3xI=
X-Microsoft-Antispam-PRVS: <DM5P136MB0009182D4D23BF2189D689D8E8DB0@DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(166708455590820)(85827821059158)(245156298449039)(185212123834332)(61196332173343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5P136MB0009;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0009;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;4:Y0+ctj3u8igHz16elvPjdUSKudSYoMee4aFIcr7SLOQv8Eje7hjuf6a330Z17AvxV8a/qdbqyEQXAygnkDPW6OzYCbQ0gEBPghnXRvvH5HOoKT0Q2GQeNNoZrGiak2rsMdsaI9nWRQWqdzneJq/G8t3MDWnrXIN2mCMR7BM4Pc4EuRIpTeHpvaf6r8EnPIxxVR88GifHHTgQlaZxq4QaThgs/HBWaJaIKzCswOTW96tEw9t2Z8BCCg78eeoh0YJ+aoQIWXS8VwAcOGjpYMxW59raeIdQBTrveBIkxHI67Thmr5cIpHP2mB0IQkSR0c9Hf2ARdow7x9F5KkXT9NhZ19A05hP/lSlEgoE03Ar0TalXOFPpAhjZ8KsQKOwE3FzGDzfn7nQs7RZoJpbB4+3d49ykHuDhyngArT9etUd1LPnyVSljUu80hvGBvqSncnFFpcu/tlcPAMLE9N4gZCJtvNmZus/0TkcS+lM6S8JulFQ=
X-Forefront-PRVS: 060166847D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(189003)(199004)(377424004)(316002)(1076002)(8656006)(2361001)(16586007)(66066001)(2906002)(68736007)(7696005)(85782001)(52116002)(97736004)(105586002)(51416003)(966005)(575784001)(106356001)(86362001)(2351001)(47776003)(6116002)(3846002)(53946003)(45080400002)(48376002)(8666007)(25786009)(6346003)(39060400002)(26005)(4326008)(50226002)(9686003)(305945005)(386003)(53376002)(6486002)(59450400001)(53936002)(36756003)(6666003)(6916009)(6306002)(81156014)(478600001)(8936002)(50466002)(7736002)(186003)(16526019)(5660300001)(81166006)(8676002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0009;H:far8gsqyz1.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0009;23:+bShHHrKxG0+fXxFjwDU9peCkvNEeI9lwmFa4fWTp?=
 =?us-ascii?Q?UQKLtfkJR1ne/s4pnXubrrfxKcr++MoewYGDiPpQ2m70DQh3XlmgAo2I8HTY?=
 =?us-ascii?Q?gkTReQ6A6+19HNUllOIEq6EZtKxIHQcDEryfgE7r+63B9toiO5dgr6nu31gH?=
 =?us-ascii?Q?mVnmw+yXpc9LE9unTBrIMy25rGhWOdVwNRSPrNF7JRa9PzbLrf1RaDckT7of?=
 =?us-ascii?Q?r6bfXcRst1eg8YXeIrC1u8te81uyDzyvfJu7RivXANOwSTzlI1f2NDaG3VKy?=
 =?us-ascii?Q?MRxT0goBnxoEchAYLbY5pQ64akULRPBQn0k86IG/Lsk2hR95Nxnp/E/deYpE?=
 =?us-ascii?Q?2jjBAkE5Q97kJR99Lyka1Hxdu+W3jGXR6JZSEsayucX+JUIP09l418NxhFXY?=
 =?us-ascii?Q?Y90WuhL2Gp8FknZKQziMLX/hkUE7hsHpRxIyVPUi5jF6rPgC5v0uPu7UwXVf?=
 =?us-ascii?Q?gYD7wUQzrv6CUaYKw9H1WMdE71OmWYPnH0Gwg3gWZ/IJo8m0IsnIWPpzALDE?=
 =?us-ascii?Q?gphy48B8hS2k27JMw0LSQEY+EQn6HJiw/uKpRvBCmP+oYbX825niQ/ilAo/d?=
 =?us-ascii?Q?KzDDDjhVwCHe/gW8ATs1C258ruEyEx5A2gz6n8ojTU36OOxtsPF8cT6gWxeH?=
 =?us-ascii?Q?Gw2HAHYvKwNPmY7gSXhyIndlYq86YI3a0pzQGs/SVsC5V11IvmHSOYbJFlCa?=
 =?us-ascii?Q?ctJ7L+G8ZByfxs3Iulk5+G/bIi8EHjwKo31vL7ycSZFoZnkMCYE4sdRx2E8q?=
 =?us-ascii?Q?6ZyiCrBGlRgli9Y/4/jDgWay4/2hovg4GX1EKVLPb0RyEwdm4LAURtWXFH9s?=
 =?us-ascii?Q?3oLee9B3QSF9wQ6NGiUoxPhdsTXuYXBqOlQG+JzglCdGZYnX9YvjFPNuj6SS?=
 =?us-ascii?Q?062K9bfsJakNgM9zPtxKdZzQmu2mWNs5nY82xUZJ7Nbv2abMO23A5ld7pH70?=
 =?us-ascii?Q?USGRREFg/VsmaC2f4xrme8XLqZXzII7J2UfAkySiyQa+vKzVJqD1Vc0u+J98?=
 =?us-ascii?Q?w4Ap+5oGOnGcBzDLLQilhYzyo9l6hmptCSv8z2OQRWi544uZ+t7lm8meeC/k?=
 =?us-ascii?Q?FXiGjSgKMVoP+pYkhouChxmbDgLrCsySorbdAT3UDiuwJuQOusY5w9GdweZ2?=
 =?us-ascii?Q?Z1U07zF4HLLFzk+C3chtltyaP2nthkRXlqpsvtnETGqniieHEPVdTz+bzI8h?=
 =?us-ascii?Q?L9ymhL0BoOpxmszFkn563KyAvW0LWzPzUS28cvHKBYhYaQM+1/eP1i9IHg0X?=
 =?us-ascii?Q?WegiD3JYbuSN5rZqVPQAuYgqzS14+ABZiIO5lHoV0/7HxBxAbGtdGdHXsDry?=
 =?us-ascii?Q?ynW3lI3YNXRvUii7V40wXzcUeZ2gi2+1Xv5rWQW0x5k8UudZ6XVlMvHvviAD?=
 =?us-ascii?Q?2QIhs6x3W/1FeuSoNcn72VVYPEDSGJBkqsW9tslROirQvVxM4z2s7qSVBEOx?=
 =?us-ascii?Q?SPvQy3Uqg=3D=3D?=
X-Microsoft-Antispam-Message-Info: VyAU83zGXkzhAjfmz2KrUtvST5uoiPU+aYSJKXFTSvrUILxIb/0xq0IdMYRClSnek7Li4ODxt5eAsdu148+QMhGlgjlKk+De+fX5dcay7fL8/BbTmXnMJjTtqYjwr+olvFsbVANgaFvzpeqlyRhBSyfdVkla3GwgkR4I/YWaYGqDqmqv3eDftvFxOmAVAb54
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;6:dAmJNxFrq04QNdNiPmTu0aHeHms7s3F3zLCdlVMYHvt/OxNuxD7wA7gjGZ4OsmlhNb5V4MH24OLoZS/uLBNM80p8xjj1/Orh0o3afWAd/ryetStXu/vV2V9fwZ66L3cxQ+QGCFsk+Zr00xupqQsTVtchnb+UzeYtr3e80Ds7PzCvBw1Bpd8H90hdU7lOtRirS9h/qtbSKT3/23rMLCIW4TlxDa+FvqfxUGn3pJdnjulPS6l+ONmDpiTgHXSz3EXHrWxlL4lW6xaXbDN7kAMnkS7Vx7SiKHWWdBht2VztOHgELK3n4XWGjygf9oTD2ptGH7it4/jdoeVrZeYZyt1SDU9BzSiOMgbrBedBRGG8roA=;5:L5i3o8sC1id7R5yVASP5YHMCe7+FM42WI8JdLVtfv89Uio4lbWpZa2ybWTzjIYqbNGdAJ74lW916vHPFjLydMTS9QX94itYpvSq0fGKZDTAHzgUoN723zT7G+lc8hg7EXbdRmDKIhNXXs8h7fWv0EXmBpOl4nikiz1lolmh5Now=;24:wBeG5Df+yx7N8hyTNpVl1kSQdL++U7697YfFdy4pB98o/ly06rv/NKkrdGmREmB/U5uQjlMfXBuOt2CgBXPEuTgZ5YKoJ6RSiVL4NbxEZeU=;7:1Q3evnMrPZbnRIXddo+YJkpf21a2z+bF2z0+ykO/pDogxBe2rpS5n3eJXxGB5BCGqyNx85scR4NHpIDX1UDriTrfR9YgHmEeJSMosQpDNRZ6XLUXPZXAmdFAUYhVhOAyD2bGxXZPsStoqS45k5avF5isgDFHSgKm3PN27vhJxksC0LiTd4Ip5euGp8hxVxzDju+iU9PBIrS+Ft6xYldYO5mMbRk70dGpqljse63QVKAKY8OnUmsn9MfEUdM2doqk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2018 20:14:34.9636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a4b817-b952-4a4d-d713-08d5820c8e06
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0009
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

Patches 1-4,7 are preparation and helper functions.
Patch 5,6,8 are the actual change.

This series depends on Torsten's 8462ff43e4 (convert_to_git():
safe_crlf/checksafe becomes int conv_flags, 2018-01-13) which is
already in master.

Changes since v8:

* move UTF BOM error checks in a new dedicated function
  validate_encoding() and into a dedicated commit (6)
* remove unnecessary encoding struct (became a plain char*)
* fail early and do not try to run the reencode content in case of a
  validation error
* return early if roundtrip encoding was not found (avoid undefined
  pointer arithmetic)
* fix wrong argument order in encode_to_worktree() error message
* use test_when_finished to cleanup tests
* move UTF-16/32 BOM test file generation into "setup test"
* reduce code duplication in tests
* improve documentation:
    - use *.rc and *.ps1 as examples as they are usually UTF-16 encoded
* fix comment: /advise/advice/

Thanks a lot Eric for your great review! I think I fixed everything you
objected with one exception. You noticed that the current code only
checks for BOMs corresponding to the declared size (16 or 32 bits) [1].
I understand your point of view and I agree that any BOM in these cases
is *most likely* an error. However, according to the spec it might
still be valid. The comments on my related question on StackOverflow
seem to support that view [2]. Therefore, I would like to leave it as
it is in this series. If it turns out to be a problem in practice, then
I am happy to change it later. OK for you?


Thanks,
Lars

[1] https://public-inbox.org/git/DF6F3855-EFE7-4C13-AA53-819AAE0DEF7A@gmail.com/
[2] https://stackoverflow.com/questions/49038872/is-a-utf-32be-bom-valid-in-an-utf-16le-declared-data-stream


  RFC: https://public-inbox.org/git/BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com/
   v1: https://public-inbox.org/git/20171211155023.1405-1-lars.schneider@autodesk.com/
   v2: https://public-inbox.org/git/20171229152222.39680-1-lars.schneider@autodesk.com/
   v3: https://public-inbox.org/git/20180106004808.77513-1-lars.schneider@autodesk.com/
   v4: https://public-inbox.org/git/20180120152418.52859-1-lars.schneider@autodesk.com/
   v5: https://public-inbox.org/git/20180129201855.9182-1-tboegi@web.de/
   v6: https://public-inbox.org/git/20180209132830.55385-1-lars.schneider@autodesk.com/
   v7: https://public-inbox.org/git/20180215152711.158-1-lars.schneider@autodesk.com/
   v8: https://public-inbox.org/git/20180224162801.98860-1-lars.schneider@autodesk.com/


Base Ref:
Web-Diff: https://github.com/larsxschneider/git/commit/fdf0d63188
Checkout: git fetch https://github.com/larsxschneider/git encoding-v9 && git checkout fdf0d63188


### Interdiff (v8..v9):

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 11315054f4..aa3deae392 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -297,14 +297,16 @@ number of pitfalls:
   in your repository, then it is strongly recommended to ensure that all
   clients working with the repository support it.

-  If you declare `*.proj` files as UTF-16 and you add `foo.proj` with an
-  `working-tree-encoding` enabled Git client, then `foo.proj` will be
+  For example, Microsoft Visual Studio resources files (`*.rc`) or
+  PowerShell script files (`*.ps1`) are sometimes encoded in UTF-16.
+  If you declare `*.ps1` as files as UTF-16 and you add `foo.ps1` with
+  a `working-tree-encoding` enabled Git client, then `foo.ps1` will be
   stored as UTF-8 internally. A client without `working-tree-encoding`
-  support will checkout `foo.proj` as UTF-8 encoded file. This will
+  support will checkout `foo.ps1` as UTF-8 encoded file. This will
   typically cause trouble for the users of this file.

   If a Git client, that does not support the `working-tree-encoding`
-  attribute, adds a new file `bar.proj`, then `bar.proj` will be
+  attribute, adds a new file `bar.ps1`, then `bar.ps1` will be
   stored "as-is" internally (in this example probably as UTF-16).
   A client with `working-tree-encoding` support will interpret the
   internal contents as UTF-8 and try to convert it to UTF-16 on checkout.
@@ -325,22 +327,22 @@ Use the `working-tree-encoding` attribute only if you cannot store a file
 in UTF-8 encoding and if you want Git to be able to process the content
 as text.

-As an example, use the following attributes if your '*.proj' files are
+As an example, use the following attributes if your '*.ps1' files are
 UTF-16 encoded with byte order mark (BOM) and you want Git to perform
 automatic line ending conversion based on your platform.

 ------------------------
-*.proj		text working-tree-encoding=UTF-16
+*.ps1		text working-tree-encoding=UTF-16
 ------------------------

-Use the following attributes if your '*.proj' files are UTF-16 little
+Use the following attributes if your '*.ps1' files are UTF-16 little
 endian encoded without BOM and you want Git to use Windows line endings
 in the working directory. Please note, it is highly recommended to
 explicitly define the line endings with `eol` if the `working-tree-encoding`
 attribute is used to avoid ambiguity.

 ------------------------
-*.proj 		text working-tree-encoding=UTF-16LE eol=CRLF
+*.ps1		text working-tree-encoding=UTF-16LE eol=CRLF
 ------------------------

 You can get a list of all available encodings on your platform with the
@@ -354,7 +356,7 @@ If you do not know the encoding of a file, then you can use the `file`
 command to guess the encoding:

 ------------------------
-file foo.proj
+file foo.ps1
 ------------------------


diff --git a/convert.c b/convert.c
index 398cd9cf7b..6cbb2b2618 100644
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
 static void trace_encoding(const char *context, const char *path,
 			   const char *encoding, const char *buf, size_t len)
 {
@@ -297,8 +344,12 @@ static int check_roundtrip(const char* enc_name)
 	 * Search for the given encoding in that string.
 	 */
 	const char *found = strcasestr(check_roundtrip_encoding, enc_name);
-	const char *next = found + strlen(enc_name);
-	int len = strlen(check_roundtrip_encoding);
+	const char *next;
+	int len;
+	if (!found)
+		return 0;
+	next = found + strlen(enc_name);
+	len = strlen(check_roundtrip_encoding);
 	return (found && (
 			/*
 			 * check that the found encoding is at the
@@ -322,17 +373,14 @@ static int check_roundtrip(const char* enc_name)
 		));
 }

-static struct encoding {
-	const char *name;
-	struct encoding *next;
-} *encoding, **encoding_tail;
 static const char *default_encoding = "UTF-8";

 static int encode_to_git(const char *path, const char *src, size_t src_len,
-			 struct strbuf *buf, struct encoding *enc, int conv_flags)
+			 struct strbuf *buf, const char *enc, int conv_flags)
 {
 	char *dst;
 	int dst_len;
+	int die_on_error = conv_flags & CONV_WRITE_OBJECT;

 	/*
 	 * No encoding is specified or there is nothing to encode.
@@ -350,39 +398,11 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	if (!buf && !src)
 		return 1;

-	if (has_prohibited_utf_bom(enc->name, src, src_len)) {
-		const char *error_msg = _(
-			"BOM is prohibited in '%s' if encoded as %s");
-		/*
-		 * This advise is shown for UTF-??BE and UTF-??LE encodings.
-		 * We truncate the encoding name to 6 chars with %.6s to cut
-		 * off the last two "byte order" characters.
-		 */
-		const char *advise_msg = _(
-			"The file '%s' contains a byte order mark (BOM). "
-			"Please use %.6s as working-tree-encoding.");
-		advise(advise_msg, path, enc->name);
-		if (conv_flags & CONV_WRITE_OBJECT)
-			die(error_msg, path, enc->name);
-		else
-			error(error_msg, path, enc->name);
-
-	} else if (is_missing_required_utf_bom(enc->name, src, src_len)) {
-		const char *error_msg = _(
-			"BOM is required in '%s' if encoded as %s");
-		const char *advise_msg = _(
-			"The file '%s' is missing a byte order mark (BOM). "
-			"Please use %sBE or %sLE (depending on the byte order) "
-			"as working-tree-encoding.");
-		advise(advise_msg, path, enc->name, enc->name);
-		if (conv_flags & CONV_WRITE_OBJECT)
-			die(error_msg, path, enc->name);
-		else
-			error(error_msg, path, enc->name);
-	}
+	if (validate_encoding(path, enc, src, src_len, die_on_error))
+		return 0;

-	trace_encoding("source", path, enc->name, src, src_len);
-	dst = reencode_string_len(src, src_len, default_encoding, enc->name,
+	trace_encoding("source", path, enc, src, src_len);
+	dst = reencode_string_len(src, src_len, default_encoding, enc,
 				  &dst_len);
 	if (!dst) {
 		/*
@@ -392,10 +412,12 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 		 * working tree. Let's try to avoid this by screaming loud.
 		 */
 		const char* msg = _("failed to encode '%s' from %s to %s");
-		if (conv_flags & CONV_WRITE_OBJECT)
-			die(msg, path, enc->name, default_encoding);
-		else
-			error(msg, path, enc->name, default_encoding);
+		if (die_on_error)
+			die(msg, path, enc, default_encoding);
+		else {
+			error(msg, path, enc, default_encoding);
+			return 0;
+		}
 	}
 	trace_encoding("destination", path, default_encoding, dst, dst_len);

@@ -418,23 +440,23 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	 * [1] http://unicode.org/faq/utf_bom.html#gen2
 	 * [2] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode
 	 */
-	if ((conv_flags & CONV_WRITE_OBJECT) && check_roundtrip(enc->name)) {
+	if (die_on_error && check_roundtrip(enc)) {
 		char *re_src;
 		int re_src_len;

 		re_src = reencode_string_len(dst, dst_len,
-					     enc->name, default_encoding,
+					     enc, default_encoding,
 					     &re_src_len);

-		trace_printf("Checking roundtrip encoding for %s...\n", enc->name);
-		trace_encoding("reencoded source", path, enc->name,
+		trace_printf("Checking roundtrip encoding for %s...\n", enc);
+		trace_encoding("reencoded source", path, enc,
 			       re_src, re_src_len);

 		if (!re_src || src_len != re_src_len ||
 		    memcmp(src, re_src, src_len)) {
 			const char* msg = _("encoding '%s' from %s to %s and "
 					    "back is not the same");
-			die(msg, path, enc->name, default_encoding);
+			die(msg, path, enc, default_encoding);
 		}

 		free(re_src);
@@ -445,7 +467,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 }

 static int encode_to_worktree(const char *path, const char *src, size_t src_len,
-			      struct strbuf *buf, struct encoding *enc)
+			      struct strbuf *buf, const char *enc)
 {
 	char *dst;
 	int dst_len;
@@ -457,11 +479,11 @@ static int encode_to_worktree(const char *path, const char *src, size_t src_len,
 	if (!enc || (src && !src_len))
 		return 0;

-	dst = reencode_string_len(src, src_len, enc->name, default_encoding,
+	dst = reencode_string_len(src, src_len, enc, default_encoding,
 				  &dst_len);
 	if (!dst) {
 		error("failed to encode '%s' from %s to %s",
-			path, enc->name, default_encoding);
+			path, default_encoding, enc);
 		return 0;
 	}

@@ -1182,33 +1204,23 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }

-static struct encoding *git_path_check_encoding(struct attr_check_item *check)
+static const char *git_path_check_encoding(struct attr_check_item *check)
 {
 	const char *value = check->value;
-	struct encoding *enc;

 	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value) ||
 	    !strlen(value))
 		return NULL;

-	for (enc = encoding; enc; enc = enc->next)
-		if (!strcasecmp(value, enc->name))
-			return enc;
-
 	/* Don't encode to the default encoding */
 	if (!strcasecmp(value, default_encoding))
 		return NULL;

-	enc = xcalloc(1, sizeof(*enc));
 	/*
 	 * Ensure encoding names are always upper case (e.g. UTF-8) to
 	 * simplify subsequent string comparisons.
 	 */
-	enc->name = xstrdup_toupper(value);
-	*encoding_tail = enc;
-	encoding_tail = &(enc->next);
-
-	return enc;
+	return xstrdup_toupper(value);
 }

 static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
@@ -1266,7 +1278,7 @@ struct conv_attrs {
 	enum crlf_action attr_action; /* What attr says */
 	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
 	int ident;
-	struct encoding *working_tree_encoding; /* Supported encoding or default encoding if NULL */
+	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
 };

 static void convert_attrs(struct conv_attrs *ca, const char *path)
@@ -1278,7 +1290,6 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 					 "eol", "text", "working-tree-encoding",
 					 NULL);
 		user_convert_tail = &user_convert;
-		encoding_tail = &encoding;
 		git_config(read_convert_config, NULL);
 	}

diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index e34c21eb29..23e89ae623 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -6,7 +6,7 @@ test_description='working-tree-encoding conversion via gitattributes'

 GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING

-test_expect_success 'setup test repo' '
+test_expect_success 'setup test files' '
 	git config core.eol lf &&

 	text="hallo there!\ncan you read me?" &&
@@ -14,164 +14,135 @@ test_expect_success 'setup test repo' '
 	printf "$text" >test.utf8.raw &&
 	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
 	printf "$text" | iconv -f UTF-8 -t UTF-32 >test.utf32.raw &&
-	cp test.utf16.raw test.utf16 &&
-	cp test.utf32.raw test.utf32 &&
+
+	# Line ending tests
+	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
+	printf "one\r\ntwo\r\nthree\r\n" >crlf.utf8.raw &&
+
+	# BOM tests
+	printf "\0a\0b\0c"                         >nobom.utf16be.raw &&
+	printf "a\0b\0c\0"                         >nobom.utf16le.raw &&
+	printf "\376\777\0a\0b\0c"                 >bebom.utf16be.raw &&
+	printf "\777\376a\0b\0c\0"                 >lebom.utf16le.raw &&
+	printf "\0\0\0a\0\0\0b\0\0\0c"             >nobom.utf32be.raw &&
+	printf "a\0\0\0b\0\0\0c\0\0\0"             >nobom.utf32le.raw &&
+	printf "\0\0\376\777\0\0\0a\0\0\0b\0\0\0c" >bebom.utf32be.raw &&
+	printf "\777\376\0\0a\0\0\0b\0\0\0c\0\0\0" >lebom.utf32le.raw &&

 	# Add only UTF-16 file, we will add the UTF-32 file later
+	cp test.utf16.raw test.utf16 &&
+	cp test.utf32.raw test.utf32 &&
 	git add .gitattributes test.utf16 &&
 	git commit -m initial
 '

 test_expect_success 'ensure UTF-8 is stored in Git' '
-	git cat-file -p :test.utf16 >test.utf16.git &&
-	test_cmp_bin test.utf8.raw test.utf16.git &&
+	test_when_finished "rm -f test.utf16.git" &&

-	# cleanup
-	rm test.utf16.git
+	git cat-file -p :test.utf16 >test.utf16.git &&
+	test_cmp_bin test.utf8.raw test.utf16.git
 '

 test_expect_success 're-encode to UTF-16 on checkout' '
+	test_when_finished "rm -f test.utf16.raw" &&
+
 	rm test.utf16 &&
 	git checkout test.utf16 &&
-	test_cmp_bin test.utf16.raw test.utf16 &&
-
-	# cleanup
-	rm test.utf16.raw
+	test_cmp_bin test.utf16.raw test.utf16
 '

 test_expect_success 'check $GIT_DIR/info/attributes support' '
-	echo "*.utf32 text working-tree-encoding=utf-32" >.git/info/attributes &&
+	test_when_finished "rm -f test.utf8.raw test.utf32.raw test.utf32.git" &&
+	test_when_finished "git reset --hard HEAD" &&

+	echo "*.utf32 text working-tree-encoding=utf-32" >.git/info/attributes &&
 	git add test.utf32 &&

 	git cat-file -p :test.utf32 >test.utf32.git &&
-	test_cmp_bin test.utf8.raw test.utf32.git &&
-
-	# cleanup
-	git reset --hard HEAD &&
-	rm test.utf8.raw test.utf32.raw test.utf32.git
+	test_cmp_bin test.utf8.raw test.utf32.git
 '

-test_expect_success 'check prohibited UTF BOM' '
-	printf "\0a\0b\0c"                         >nobom.utf16be.raw &&
-	printf "a\0b\0c\0"                         >nobom.utf16le.raw &&
-	printf "\376\777\0a\0b\0c"                 >bebom.utf16be.raw &&
-	printf "\777\376a\0b\0c\0"                 >lebom.utf16le.raw &&
+for i in 16 32
+do
+	test_expect_success "check prohibited UTF-${i} BOM" '
+		test_when_finished "git reset --hard HEAD" &&

-	printf "\0\0\0a\0\0\0b\0\0\0c"             >nobom.utf32be.raw &&
-	printf "a\0\0\0b\0\0\0c\0\0\0"             >nobom.utf32le.raw &&
-	printf "\0\0\376\777\0\0\0a\0\0\0b\0\0\0c" >bebom.utf32be.raw &&
-	printf "\777\376\0\0a\0\0\0b\0\0\0c\0\0\0" >lebom.utf32le.raw &&
+		echo "*.utf${i}be text working-tree-encoding=utf-${i}be" >>.gitattributes &&
+		echo "*.utf${i}le text working-tree-encoding=utf-${i}le" >>.gitattributes &&

-	echo "*.utf16be text working-tree-encoding=utf-16be" >>.gitattributes &&
-	echo "*.utf16le text working-tree-encoding=utf-16le" >>.gitattributes &&
-	echo "*.utf32be text working-tree-encoding=utf-32be" >>.gitattributes &&
-	echo "*.utf32le text working-tree-encoding=utf-32le" >>.gitattributes &&
-
-	# Here we add a UTF-16 files with BOM (big-endian and little-endian)
-	# but we tell Git to treat it as UTF-16BE/UTF-16LE. In these cases
-	# the BOM is prohibited.
-	cp bebom.utf16be.raw bebom.utf16be &&
-	test_must_fail git add bebom.utf16be 2>err.out &&
-	test_i18ngrep "fatal: BOM is prohibited .* UTF-16BE" err.out &&
-
-	cp lebom.utf16le.raw lebom.utf16be &&
-	test_must_fail git add lebom.utf16be 2>err.out &&
-	test_i18ngrep "fatal: BOM is prohibited .* UTF-16BE" err.out &&
-
-	cp bebom.utf16be.raw bebom.utf16le &&
-	test_must_fail git add bebom.utf16le 2>err.out &&
-	test_i18ngrep "fatal: BOM is prohibited .* UTF-16LE" err.out &&
-
-	cp lebom.utf16le.raw lebom.utf16le &&
-	test_must_fail git add lebom.utf16le 2>err.out &&
-	test_i18ngrep "fatal: BOM is prohibited .* UTF-16LE" err.out &&
-
-	# ... and the same for UTF-32
-	cp bebom.utf32be.raw bebom.utf32be &&
-	test_must_fail git add bebom.utf32be 2>err.out &&
-	test_i18ngrep "fatal: BOM is prohibited .* UTF-32BE" err.out &&
-
-	cp lebom.utf32le.raw lebom.utf32be &&
-	test_must_fail git add lebom.utf32be 2>err.out &&
-	test_i18ngrep "fatal: BOM is prohibited .* UTF-32BE" err.out &&
-
-	cp bebom.utf32be.raw bebom.utf32le &&
-	test_must_fail git add bebom.utf32le 2>err.out &&
-	test_i18ngrep "fatal: BOM is prohibited .* UTF-32LE" err.out &&
-
-	cp lebom.utf32le.raw lebom.utf32le &&
-	test_must_fail git add lebom.utf32le 2>err.out &&
-	test_i18ngrep "fatal: BOM is prohibited .* UTF-32LE" err.out &&
-
-	# cleanup
-	git reset --hard HEAD
-'
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

-test_expect_success 'check required UTF BOM' '
-	echo "*.utf32 text working-tree-encoding=utf-32" >>.gitattributes &&
+		cp bebom.utf${i}be.raw bebom.utf${i}le &&
+		test_must_fail git add bebom.utf${i}le 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* UTF-${i}LE" err.out &&

-	cp nobom.utf16be.raw nobom.utf16 &&
-	test_must_fail git add nobom.utf16 2>err.out &&
-	test_i18ngrep "fatal: BOM is required .* UTF-16" err.out &&
+		cp lebom.utf${i}le.raw lebom.utf${i}le &&
+		test_must_fail git add lebom.utf${i}le 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* UTF-${i}LE" err.out
+	'

-	cp nobom.utf16le.raw nobom.utf16 &&
-	test_must_fail git add nobom.utf16 2>err.out &&
-	test_i18ngrep "fatal: BOM is required .* UTF-16" err.out &&
+	test_expect_success "check required UTF-${i} BOM" '
+		test_when_finished "git reset --hard HEAD" &&

-	cp nobom.utf32be.raw nobom.utf32 &&
-	test_must_fail git add nobom.utf32 2>err.out &&
-	test_i18ngrep "fatal: BOM is required .* UTF-32" err.out &&
+		echo "*.utf${i} text working-tree-encoding=utf-${i}" >>.gitattributes &&

-	cp nobom.utf32le.raw nobom.utf32 &&
-	test_must_fail git add nobom.utf32 2>err.out &&
-	test_i18ngrep "fatal: BOM is required .* UTF-32" err.out &&
+		cp nobom.utf${i}be.raw nobom.utf${i} &&
+		test_must_fail git add nobom.utf${i} 2>err.out &&
+		test_i18ngrep "fatal: BOM is required .* UTF-${i}" err.out &&

-	# cleanup
-	rm nobom.utf16 nobom.utf32 &&
-	git reset --hard HEAD
+		cp nobom.utf${i}le.raw nobom.utf${i} &&
+		test_must_fail git add nobom.utf${i} 2>err.out &&
+		test_i18ngrep "fatal: BOM is required .* UTF-${i}" err.out
 	'

-test_expect_success 'eol conversion for UTF-16 encoded files on checkout' '
-	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
-	printf "one\r\ntwo\r\nthree\r\n" >crlf.utf8.raw &&
+	test_expect_success "eol conversion for UTF-${i} encoded files on checkout" '
+		test_when_finished "rm -f crlf.utf${i}.raw lf.utf${i}.raw" &&
+		test_when_finished "git reset --hard HEAD^" &&

-	cat lf.utf8.raw | iconv -f UTF-8 -t UTF-16 >lf.utf16.raw &&
-	cat crlf.utf8.raw | iconv -f UTF-8 -t UTF-16 >crlf.utf16.raw &&
-	cp crlf.utf16.raw eol.utf16 &&
+		cat lf.utf8.raw | iconv -f UTF-8 -t UTF-${i} >lf.utf${i}.raw &&
+		cat crlf.utf8.raw | iconv -f UTF-8 -t UTF-${i} >crlf.utf${i}.raw &&
+		cp crlf.utf${i}.raw eol.utf${i} &&

-	cat >expectIndexLF <<-\EOF &&
-		i/lf    w/-text attr/text             	eol.utf16
+		cat >expectIndexLF <<-EOF &&
+			i/lf    w/-text attr/text             	eol.utf${i}
 		EOF

-	git add eol.utf16 &&
+		git add eol.utf${i} &&
 		git commit -m eol &&

-	# UTF-16 with CRLF (Windows line endings)
-	rm eol.utf16 &&
-	git -c core.eol=crlf checkout eol.utf16 &&
-	test_cmp_bin crlf.utf16.raw eol.utf16 &&
+		# UTF-${i} with CRLF (Windows line endings)
+		rm eol.utf${i} &&
+		git -c core.eol=crlf checkout eol.utf${i} &&
+		test_cmp_bin crlf.utf${i}.raw eol.utf${i} &&

-	# Although the file has CRLF in the working tree, ensure LF in the index
-	git ls-files --eol eol.utf16 >actual &&
+		# Although the file has CRLF in the working tree,
+		# ensure LF in the index
+		git ls-files --eol eol.utf${i} >actual &&
 		test_cmp expectIndexLF actual &&

-	# UTF-16 with LF (Unix line endings)
-	rm eol.utf16 &&
-	git -c core.eol=lf checkout eol.utf16 &&
-	test_cmp_bin lf.utf16.raw eol.utf16 &&
+		# UTF-${i} with LF (Unix line endings)
+		rm eol.utf${i} &&
+		git -c core.eol=lf checkout eol.utf${i} &&
+		test_cmp_bin lf.utf${i}.raw eol.utf${i} &&

 		# The file LF in the working tree, ensure LF in the index
-	git ls-files --eol eol.utf16 >actual &&
-	test_cmp expectIndexLF actual&&
-
-	rm crlf.utf16.raw crlf.utf8.raw lf.utf16.raw lf.utf8.raw &&
-
-	# cleanup
-	git reset --hard HEAD^
+		git ls-files --eol eol.utf${i} >actual &&
+		test_cmp expectIndexLF actual
 	'
+done

 test_expect_success 'check unsupported encodings' '
+	test_when_finished "rm -f err.out" &&
+	test_when_finished "git reset --hard HEAD" &&

 	echo "*.nothing text working-tree-encoding=" >>.gitattributes &&
 	printf "nothing" >t.nothing &&
@@ -180,34 +151,33 @@ test_expect_success 'check unsupported encodings' '
 	echo "*.garbage text working-tree-encoding=garbage" >>.gitattributes &&
 	printf "garbage" >t.garbage &&
 	test_must_fail git add t.garbage 2>err.out &&
-	test_i18ngrep "fatal: failed to encode" err.out &&
-
-	# cleanup
-	rm err.out &&
-	git reset --hard HEAD
+	test_i18ngrep "fatal: failed to encode" err.out
 '

 test_expect_success 'error if encoding round trip is not the same during refresh' '
 	BEFORE_STATE=$(git rev-parse HEAD) &&
-
-	# Skip the UTF-16 filter for the added file
-	# This simulates a Git version that has no working tree encoding support
-	echo "hallo" >nonsense.utf16 &&
-	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
-	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&
+	test_when_finished "rm -f err.out" &&
+	test_when_finished "git reset --hard $BEFORE_STATE" &&
+
+	# Add and commit a UTF-16 file but skip the "working-tree-encoding"
+	# filter. Consequently, the in-repo representation is UTF-16 and not
+	# UTF-8. This simulates a Git version that has no working tree encoding
+	# support.
+	echo "*.utf16le text working-tree-encoding=utf-16le" >.gitattributes &&
+	echo "hallo" >nonsense.utf16le &&
+	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16le) &&
+	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16le &&
 	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
 	git update-ref refs/heads/master $COMMIT &&

 	test_must_fail git checkout HEAD^ 2>err.out &&
-	test_i18ngrep "error: .* overwritten by checkout:" err.out &&
-
-	# cleanup
-	rm err.out &&
-	git reset --hard $BEFORE_STATE
+	test_i18ngrep "error: .* overwritten by checkout:" err.out
 '

 test_expect_success 'error if encoding garbage is already in Git' '
 	BEFORE_STATE=$(git rev-parse HEAD) &&
+	test_when_finished "rm -f err.out" &&
+	test_when_finished "git reset --hard $BEFORE_STATE" &&

 	# Skip the UTF-16 filter for the added file
 	# This simulates a Git version that has no checkoutEncoding support
@@ -218,52 +188,46 @@ test_expect_success 'error if encoding garbage is already in Git' '
 	git update-ref refs/heads/master $COMMIT &&

 	git diff 2>err.out &&
-	test_i18ngrep "error: BOM is required" err.out &&
-
-	# cleanup
-	rm err.out &&
-	git reset --hard $BEFORE_STATE
+	test_i18ngrep "error: BOM is required" err.out
 '

 test_expect_success 'check roundtrip encoding' '
+	test_when_finished "rm -f roundtrip.shift roundtrip.utf16" &&
+	test_when_finished "git reset --hard HEAD" &&
+
 	text="hallo there!\nroundtrip test here!" &&
 	printf "$text" | iconv -f UTF-8 -t SHIFT-JIS >roundtrip.shift &&
 	printf "$text" | iconv -f UTF-8 -t UTF-16 >roundtrip.utf16 &&
 	echo "*.shift text working-tree-encoding=SHIFT-JIS" >>.gitattributes &&

 	# SHIFT-JIS encoded files are round-trip checked by default...
-	GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 >/dev/null |
+	GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 |
 		grep "Checking roundtrip encoding for SHIFT-JIS" &&
 	git reset &&

 	# ... unless we overwrite the Git config!
-	test_config core.checkRoundtripEncoding "garbage" &&
-	! GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 >/dev/null |
+	! GIT_TRACE=1 git -c core.checkRoundtripEncoding=garbage \
+		add .gitattributes roundtrip.shift 2>&1 |
 		grep "Checking roundtrip encoding for SHIFT-JIS" &&
-	test_unconfig core.checkRoundtripEncoding &&
 	git reset &&

 	# UTF-16 encoded files should not be round-trip checked by default...
-	! GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
+	! GIT_TRACE=1 git add roundtrip.utf16 2>&1 |
 		grep "Checking roundtrip encoding for UTF-16" &&
 	git reset &&

 	# ... unless we tell Git to check it!
-	test_config_global core.checkRoundtripEncoding "UTF-16, UTF-32" &&
-	GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
+	GIT_TRACE=1 git -c core.checkRoundtripEncoding="UTF-16, UTF-32" \
+		add roundtrip.utf16 2>&1 |
 		grep "Checking roundtrip encoding for UTF-16" &&
 	git reset &&

 	# ... unless we tell Git to check it!
 	# (here we also check that the casing of the encoding is irrelevant)
-	test_config_global core.checkRoundtripEncoding "UTF-32, utf-16" &&
-	GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
+	GIT_TRACE=1 git -c core.checkRoundtripEncoding="UTF-32, utf-16" \
+		add roundtrip.utf16 2>&1 |
 		grep "Checking roundtrip encoding for UTF-16" &&
-	git reset &&
-
-	# cleanup
-	rm roundtrip.shift roundtrip.utf16 &&
-	git reset --hard HEAD
+	git reset
 '

 test_done
diff --git a/utf8.h b/utf8.h
index 62f86fba64..cce654a64a 100644
--- a/utf8.h
+++ b/utf8.h
@@ -71,9 +71,9 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
 		       const char *s);

 /*
- * Whenever a data stream is declared to be UTF-16BE, UTF-16LE, UTF-32BE
- * or UTF-32LE a BOM must not be used [1]. The function returns true if
- * this is the case.
+ * If a data stream is declared as UTF-16BE or UTF-16LE, then a UTF-16
+ * BOM must not be used [1]. The same applies for the UTF-32 equivalents.
+ * The function returns true if this rule is violated.
  *
  * [1] http://unicode.org/faq/utf_bom.html#bom10
  */
@@ -83,10 +83,13 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
  * If the endianness is not defined in the encoding name, then we
  * require a BOM. The function returns true if a required BOM is missing.
  *
- * The Unicode standard instructs to assume big-endian if there
- * in no BOM for UTF-16/32 [1][2]. However, the W3C/WHATWG
- * encoding standard used in HTML5 recommends to assume
- * little-endian to "deal with deployed content" [3].
+ * The Unicode standard instructs to assume big-endian if there in no
+ * BOM for UTF-16/32 [1][2]. However, the W3C/WHATWG encoding standard
+ * used in HTML5 recommends to assume little-endian to "deal with
+ * deployed content" [3].
+ *
+ * Therefore, strictly requiring a BOM seems to be the safest option for
+ * content in Git.
  *
  * [1] http://unicode.org/faq/utf_bom.html#gen6
  * [2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf


### Patches

Lars Schneider (8):
  strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
  strbuf: add xstrdup_toupper()
  utf8: add function to detect prohibited UTF-16/32 BOM
  utf8: add function to detect a missing UTF-16/32 BOM
  convert: add 'working-tree-encoding' attribute
  convert: check for detectable errors in UTF encodings
  convert: add tracing for 'working-tree-encoding' attribute
  convert: add round trip check based on 'core.checkRoundtripEncoding'

 Documentation/config.txt         |   6 +
 Documentation/gitattributes.txt  |  88 +++++++++++++
 config.c                         |   5 +
 convert.c                        | 267 ++++++++++++++++++++++++++++++++++++++-
 convert.h                        |   2 +
 environment.c                    |   1 +
 sha1_file.c                      |   2 +-
 strbuf.c                         |  13 +-
 strbuf.h                         |   1 +
 t/t0028-working-tree-encoding.sh | 233 ++++++++++++++++++++++++++++++++++
 utf8.c                           |  37 ++++++
 utf8.h                           |  28 ++++
 12 files changed, 680 insertions(+), 3 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh


base-commit: 8a2f0888555ce46ac87452b194dec5cb66fb1417
--
2.16.2

