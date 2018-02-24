Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA631F404
	for <e@80x24.org>; Sat, 24 Feb 2018 16:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeBXQ3g (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 11:29:36 -0500
Received: from mail-cys01nam02on0121.outbound.protection.outlook.com ([104.47.37.121]:55968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751131AbeBXQ3f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 11:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=apR7R02x7Y1zt1YE2Zt3g7br3Yi7EoXxEorQs/B/3k0=;
 b=IGvpJ1nphT5pDQV8xm6iSNV9StzQvfL1xgbLFYEPXD4jHrvn/pQe4HmOSmTf4CifUuiNBtLj7hj/7qB34+jopL7tl3hAgSSEyZA0KTlxUnBvWxWnDZlUfDi16nVJLgPu2zq2SuyLfXe5N3NNNAM2IBvPcwarA3d9TtaqmP3URZc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from localhost.localdomain (132.188.32.100) by
 CY4P136MB0007.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.506.26; Sat, 24
 Feb 2018 16:28:30 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 0/7] convert: add support for different encodings
Date:   Sat, 24 Feb 2018 17:27:54 +0100
Message-Id: <20180224162801.98860-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CY4PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:910:16::13) To CY4P136MB0007.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:923:12::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57456934-46aa-4be0-0aee-08d57ba3a562
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0007;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;3:wrk/EdJKVEfpecwulUy5APkcGjqalpePbcemJYBUv/7BkxnyyC7FCq3R79sif22YwKk7EKYnaNdmcPaAUQ+9oMNeHFqBfK3d9VOnG83li1vdg4Q4oV9m/WbPXBfE3cXxbEzxLLQ0WJ/7hyP0xDou9qyd70tIblNQhwrXlInh2qydr7ltjI18LNc5BvN0kkM80Joj5XJqzVuPPsr2tTY9A8av/YGPeJzwA+90RlG7h2UWyG+0EdlC6FUT0V/uEj25;25:Hazvbvu6SY9AbCkqSUNdeoqym66XyNjWBFcW8+sKSz9H5ms5N7bRQ5JNjo/WvWuWQoISDfDEpmiJOaYVltkM2XSRUpXpc8dp0yJN1M6qNErhgrdAZbN4DAVO0J7vmvRiJrkrzwplBhSfTHKgjq91efdZKj2d7d5MTqm0TerImH8jCoMelEU5/958E1Idk1zRQFxbyvGbnVRBve9wVw20IuAJGmIeUCae3ccjSz7BK9gYkVRB0iYFyRnspFxZBrTVWN0Owq7eXT2MQ3JLQJie5uK9fI0rEkOJFAk4dAlWtX//hYlb0UzexwwagB1LDMgQocb8GOG/dXNgxw8FHfR0hw==;31:gdqf7kZs1Wmp/L7F/8HqAmnnKzWOZMNVajaiHEthbEvFVX9XSzKYiCCzLE9S1Q4YDBDSgueHqhKLcH4CDQdw0RbRsmJFibrUqzCmnD7oAANS1G10HR17c/vdObdIOg5B/u08bcX3fFmnlgVAtAiUS0+xOxURaNh8gtCJDBc0KH7ylYucqaJ9iWMvEctjJFUeyDAo3aaqYoE2+sd6xNX1hoN6h1yuVXncgRF23jBZYog=
X-MS-TrafficTypeDiagnostic: CY4P136MB0007:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;20:+nQhmW2mhxrOxV5wBfG9Dn+wfz966T4ju7HzDnnvNyUTwh0C2bLdvM4ZYZFPycod4oCFpdkLqhR95zOOB/3aPVBoWXUyxQtYGJhFD4tId/UiC2LN5MpnfDtNiHprw4W7b3C5qY+yhZS9Vt9QxJ+ZxlXjAEpbPCKPqtX5JVg0eIFInoeNKRLpoDqkR90tidikVbeUr7nXYmBrtXaQqosuTcHx5frjTAxJej/I2CvOqu5hHh1/GdpswWldWVvd4lSjr28kANRBYo7zk3wdPQmWsYl50zdqKYK2bqWgnJrvwGA7LiX9LNjqaTxwW/igqITatksGJi3ibfxEN5eZNQk0rMAnh8VnK5BvEQZOWixU0Ts2U5oWEI1pzhDzdJyfk+JjX4997zlvv4vCe6Y/9wB2Fiw83i8ros4OTj4rhJBSUYqj571Q/CAG9BGZjYKXWkWZnR7v2+AhCnBkYLy9h+iUwbGjne20Ss4VKiAsHghryj+DBlG1rps2yi6gYwHaVZdUu5YCnHxDbsyRqlqdGzSr320rBjxTQ2df90u5h+oLhg+QSJ8wF94h8bQiHUXsTW+jMqHD+o2xr1CF5bnAW1sJlRwLO0eA1EISfD5ESLtjK4A=;4:X+JQNfLOdQrJ+4KMmTBn2oxBOavVRTXOp1oSe7Q7UuA31/yS2CBUN/Z+j7+ASqQYmjLgksW7jUfhkQrcJDMARlf3rXndfxG7kEqTjoDXb41QXeZuInrADGMhgeSMVylgdBt0ErNZYfyiqP2G2l9XO7XdRA52+u9qWiMIbskTXrolDw7J5vObEq//HeXq/AyCEj5XEtkK4+7n96YE3t0FEYM3p63V1SI5qrsqK8yMy3KQjVVDdXCBXgrZx2pSY35w2LFw/BBUiDv4crkOyCVuUg==
X-Exchange-Antispam-Report-CFA: BCL:0;PCL:0;RULEID:(3231001);SRVR:CY4P136MB0007;BCL:0;PCL:0;RULEID:;SRVR:CY4P136MB0007;
X-Forefront-PRVS: 0593E261C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(199004)(377424004)(189003)(8656006)(5660300001)(7736002)(66066001)(50226002)(47776003)(97736004)(8936002)(6512007)(9686003)(305945005)(8666007)(6306002)(6486002)(106356001)(36756003)(2351001)(2361001)(8676002)(81156014)(48376002)(68736007)(50466002)(85782001)(16586007)(33896004)(59450400001)(6506007)(386003)(105586002)(86362001)(26005)(6116002)(3846002)(1076002)(16526019)(186003)(52116002)(966005)(51416003)(39060400002)(6666003)(4326008)(25786009)(6916009)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0007;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0007;23:mx/8ZaeECVfcWDNfAm8xwUdhPPonuXjAOwGqjX9Qk?=
 =?us-ascii?Q?ty40OhB0W7qQKAHlbYFZvi1brNdF3imhsUf89i9JD1pft3yl+cxtdFv93RWO?=
 =?us-ascii?Q?i6aDyJxs/6j144OriB9vVIqeIUMWxliffSwvO8hPsG9hldKFE6YcIf/qsfFe?=
 =?us-ascii?Q?G/X0fKObidcvn0/AvROviL/D3OYAaUuUUYHdSfDCaF4x4gg8eUx406UcV9j0?=
 =?us-ascii?Q?KjYWOe7an1L51F2Slv/5iz+6sTHRvlhaRHlOqKqsbruQPNiTXpE8DJhw9L8x?=
 =?us-ascii?Q?VWTEd0C7ZaoTVVE8xxwhA8mRDVwv5M1s/E+ZZbmjVop2ZWtBjn3nossGeECV?=
 =?us-ascii?Q?PO+ZV9kRNqeB/UjbBuylIgGxlqcZlcP3Ya1bqOQIsM5CgtHAxcbaDu8gTG0N?=
 =?us-ascii?Q?obPRArYppkbl/jjN9gyDhje+Q5AFul/r+te8YNC5shmkUTINc7oklJ7pHUMC?=
 =?us-ascii?Q?8oDcEvgeoLu/PMTMsG8sfBnYVoDu3fF65/N1PQ6kYO00BgDVBtL9CTiHdLdd?=
 =?us-ascii?Q?m0g5dwRQXMNmjlEXznl+1RZ+Tdx1b5A7+b5C11mZh+2PaR/0c7drTB6po3BQ?=
 =?us-ascii?Q?KOJX+eHgxpPdBHdYvpvxjz/0qWj9E8pwCY/r6th3sY2pbGAl9R5iGIoS+5Ee?=
 =?us-ascii?Q?doSl9Ed/O3j+NW2PHnEFs0wF3ybRqousJN3aGZxFigIfoLS8Qh0LleMIFpe5?=
 =?us-ascii?Q?WHSKt827/XZixYbTG2drZqByH+/wKqConlHwS1HKYYY+lA1d0dTBZlVPC2dh?=
 =?us-ascii?Q?Z996Mtx06TJi45qMeCgdPAdiW7mAt7dRVcanfwg8pUTLt1rloSAGRzS18h8/?=
 =?us-ascii?Q?9zTDvqNv6ZYgXG6hF/JGRoHOUT4DXG7SFFvzCWvCnI1M0GEmjpS5joKtqetO?=
 =?us-ascii?Q?yuvkvDgEJTQxEovcPs5len1+t5DMcP3F+EMBQuEJISzh3BsmX7ezn4Dji2kJ?=
 =?us-ascii?Q?pWTTKhWIWhO7zdhIVxrdawVOUhxMrwx3q9/vspiYq27Ceqpk1Id9Ztz7OvWd?=
 =?us-ascii?Q?juPy5vGagLvh+n0piVPWhqC+EaRjsONNJBuYVTKZKnquggJhUBsBmzMKuF15?=
 =?us-ascii?Q?gq38G4K+RaqZ6I9bBQKzsYrfEhXlULapWdBkZSkv9s3VtDU0tX0B/nJFxV9f?=
 =?us-ascii?Q?VrH8SOk24lz7SJG877l6kbJgoMU/D6HYz63R+Sk4DMaVD80aJAP0Q=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;6:PFsgV4sAqmxtTAo20IiG+31bWr1NvEXmPNvsG4BQ9TYVG6I+4pNc6LmN5MD5YCwPPmI4aEHUphENLkArbyzRHOfFI2PcJGbYywFUYk4TXSXpVFzvCi4YkG8006eKa9GlC3paqgIGBbih9EBrB33Xtn2BcxP6mkcXY//KeM5LqSaMJyLpdp7bQyDSYBQvoPOqw/2Om9ZfmQ90eNQFJ2cSJl4npfUz2Q+vPzrzv89ssIgvv9a3DFm9RE8szEYqx0jqVUqpoCWLAOcIrkERskpym0Ji0YkYUddKcHl+bYUpRTbMW9QhwHzJenS3AbXFcvLMibRj7WMBDCg0JzQFNW0E0q9M++/WT8vR13OJ9OprZig=;5:NrjkSZMtLyGyGnhjPvyVyMMABKg8qysI0eRBf2GiiLyeBI3NFSBBXveQH15wt8qIfwsuf4tLjbtzZ/bDiSjgKv/SGBONBSpisnAOxS6xsN19SpuEljdkmOO4/kBUOFPgBWhpy5S70dvzTZEnru8bWIuQK99m4F4H8TnnCWFY1zc=;24:DMChlJ4oFnCeofbLwpAibA3C/Gv0PBHTGf7V7xHO2b01JnXFZKzVVfssaV43fL5M8E/F0lNQ4KUcsaztr5MHASkjY+vWQ4w2gUO9bdvCOV4=;7:vGMWM+tNpVAAoig7lCL3frE8nwF0kU68EIf3Rf1qr/y8YUTgi4mvMIU2qhC2mhaEmivEs8Nr7McPfuWeg8Cg54zuDTv7TlsRgDY6/b9TKLe5eZ9kDU+O/TcKWy0Tor5CWyd6EGHD9mxkDLOPNeUxwB6mrjyJrKPD+qLM2xGopjjX3MZxLAwtjP94lIwh8vKd7QSab8WzxgDWZbnwOQ9elnwXpCFvOsNq+B8IooYEezha5ODwPdRi9KFj30vewgas
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2018 16:28:30.6563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57456934-46aa-4be0-0aee-08d57ba3a562
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

Patches 1-4, 6 are preparation and helper functions.
Patch 5,7 are the actual change.

This series depends on Torsten's 8462ff43e4 (convert_to_git():
safe_crlf/checksafe becomes int conv_flags, 2018-01-13) which is
already in master.

Changes since v7:

* make it clearer in the documentation that Git stores content "as-is"
  by default. Content is only stored in UTF-8 if w-t-e is used (Junio)
* add test case for $GIT_DIR/info/attributes support (Junio)

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


Base Ref:
Web-Diff: https://github.com/larsxschneider/git/commit/2758a2da29
Checkout: git fetch https://github.com/larsxschneider/git encoding-v8 && git checkout 2758a2da29


### Interdiff (v7..v8):

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 10cb37795d..11315054f4 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -275,11 +275,11 @@ few exceptions.  Even though...
 `working-tree-encoding`
 ^^^^^^^^^^^^^^^^^^^^^^^

-Git recognizes files encoded with ASCII or one of its supersets (e.g.
-UTF-8 or ISO-8859-1) as text files.  All other encodings are usually
-interpreted as binary and consequently built-in Git text processing
-tools (e.g. 'git diff') as well as most Git web front ends do not
-visualize the content.
+Git recognizes files encoded in ASCII or one of its supersets (e.g.
+UTF-8, ISO-8859-1, ...) as text files. Files encoded in certain other
+encodings (e.g. UTF-16) are interpreted as binary and consequently
+built-in Git text processing tools (e.g. 'git diff') as well as most Git
+web front ends do not visualize the contents of these files by default.

 In these cases you can tell Git the encoding of a file in the working
 directory with the `working-tree-encoding` attribute. If a file with this
@@ -291,12 +291,24 @@ the content is reencoded back to the specified encoding.
 Please note that using the `working-tree-encoding` attribute may have a
 number of pitfalls:

-- Third party Git implementations that do not support the
-  `working-tree-encoding` attribute will checkout the respective files
-  UTF-8 encoded and not in the expected encoding. Consequently, these
-  files will appear different which typically causes trouble. This is
-  in particular the case for older Git versions and alternative Git
-  implementations such as JGit or libgit2 (as of February 2018).
+- Alternative Git implementations (e.g. JGit or libgit2) and older Git
+  versions (as of March 2018) do not support the `working-tree-encoding`
+  attribute. If you decide to use the `working-tree-encoding` attribute
+  in your repository, then it is strongly recommended to ensure that all
+  clients working with the repository support it.
+
+  If you declare `*.proj` files as UTF-16 and you add `foo.proj` with an
+  `working-tree-encoding` enabled Git client, then `foo.proj` will be
+  stored as UTF-8 internally. A client without `working-tree-encoding`
+  support will checkout `foo.proj` as UTF-8 encoded file. This will
+  typically cause trouble for the users of this file.
+
+  If a Git client, that does not support the `working-tree-encoding`
+  attribute, adds a new file `bar.proj`, then `bar.proj` will be
+  stored "as-is" internally (in this example probably as UTF-16).
+  A client with `working-tree-encoding` support will interpret the
+  internal contents as UTF-8 and try to convert it to UTF-16 on checkout.
+  That operation will fail and cause an error.

 - Reencoding content to non-UTF encodings can cause errors as the
   conversion might not be UTF-8 round trip safe. If you suspect your
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index e4717402a5..e34c21eb29 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -13,8 +13,11 @@ test_expect_success 'setup test repo' '
 	echo "*.utf16 text working-tree-encoding=utf-16" >.gitattributes &&
 	printf "$text" >test.utf8.raw &&
 	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
+	printf "$text" | iconv -f UTF-8 -t UTF-32 >test.utf32.raw &&
 	cp test.utf16.raw test.utf16 &&
+	cp test.utf32.raw test.utf32 &&

+	# Add only UTF-16 file, we will add the UTF-32 file later
 	git add .gitattributes test.utf16 &&
 	git commit -m initial
 '
@@ -24,7 +27,7 @@ test_expect_success 'ensure UTF-8 is stored in Git' '
 	test_cmp_bin test.utf8.raw test.utf16.git &&

 	# cleanup
-	rm test.utf8.raw test.utf16.git
+	rm test.utf16.git
 '

 test_expect_success 're-encode to UTF-16 on checkout' '
@@ -36,6 +39,19 @@ test_expect_success 're-encode to UTF-16 on checkout' '
 	rm test.utf16.raw
 '

+test_expect_success 'check $GIT_DIR/info/attributes support' '
+	echo "*.utf32 text working-tree-encoding=utf-32" >.git/info/attributes &&
+
+	git add test.utf32 &&
+
+	git cat-file -p :test.utf32 >test.utf32.git &&
+	test_cmp_bin test.utf8.raw test.utf32.git &&
+
+	# cleanup
+	git reset --hard HEAD &&
+	rm test.utf8.raw test.utf32.raw test.utf32.git
+'
+
 test_expect_success 'check prohibited UTF BOM' '
 	printf "\0a\0b\0c"                         >nobom.utf16be.raw &&
 	printf "a\0b\0c\0"                         >nobom.utf16le.raw &&


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
 Documentation/gitattributes.txt  |  86 +++++++++++++
 config.c                         |   5 +
 convert.c                        | 256 ++++++++++++++++++++++++++++++++++++-
 convert.h                        |   2 +
 environment.c                    |   1 +
 sha1_file.c                      |   2 +-
 strbuf.c                         |  13 +-
 strbuf.h                         |   1 +
 t/t0028-working-tree-encoding.sh | 269 +++++++++++++++++++++++++++++++++++++++
 utf8.c                           |  37 ++++++
 utf8.h                           |  25 ++++
 12 files changed, 700 insertions(+), 3 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh


base-commit: 8a2f0888555ce46ac87452b194dec5cb66fb1417
--
2.16.1

