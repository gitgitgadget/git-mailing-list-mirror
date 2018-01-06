Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 636061F428
	for <e@80x24.org>; Sat,  6 Jan 2018 00:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753462AbeAFAsl (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 19:48:41 -0500
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:56393
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753447AbeAFAsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 19:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tAurH7m9oPs62iv806z4MMVY/ypZTUscN9IscZJXqtk=;
 b=UY1tZ65w1D28aDhzdElMnh4WsmVz/dhBuHYd4Hz1djr8exMmFDV2TGNyLzyGeS3RIfTEbBajQ2nNgSWQL0nM7pUU87E8aP3KZr/xb3kFDNKmrlTCqeM33fRlhHOpKhjwHT9yDF67GA7COBj3THTtEBF1lQr6FKd7voRwccAnrJI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.88.245) by
 CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.386.7; Sat, 6 Jan 2018 00:48:33 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 0/7] convert: add support for different encodings
Date:   Sat,  6 Jan 2018 01:48:01 +0100
Message-Id: <20180106004808.77513-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [93.219.88.245]
X-ClientProxiedBy: HE1PR0102CA0039.eurprd01.prod.exchangelabs.com
 (10.167.35.16) To CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e7bad7d-2b04-49a4-ce71-08d5549f37c5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060);SRVR:CY4P136MB0021;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;3:F4k+UR9DVKRgJdXsNXX+2AXYwvU5DjHougCEZL4PEqAWD0sbK8z+uw9fZMJ5Udr7uBp+LL43kkhErIuo6rrTMyGTOlkYllLyoNd25j11N/kVux0H+Akx9tH+2T78HKszE4JTZtVz8hlPiiT4rOVz6nGl2L+E+P4WnzHqG+zlkRFi4NUCJ42hrgteYXjLnu3m9oc00SVZlhC+dOuZZQUsn5tfkd06sOWtr1EFF3pirbPTxUw9zi/DIYzwvzA7Mjgu;25:oBqYghNuQLy/KL8SdfiGheXoSYjH8GbYUyrQS7bXEiT5ZDsCqBLa0hYswRBRqVpuTx5D9XbE9R+yr5ccMhYIDTfj7POIYSOi/Fv+V0Voy0Ba+LBP/4Frz1iWO9XF6+kuUb0XFZqZA8AtYa5rnGBRyuPi/FlLmkztVTsl8HFnBRo43x/6GZSFl2h2H7A/tSCpc0H8LiXLejsRmdFr5NmfcnW8e8H1ws7hPLmg6UwdiyUffMobga8D4b5FVlWL1bwIOOTJxhFy9l//o4rlNlciSFM50TlI3jqCVa49EUg/rCx8ZPSvyXMtKB8NAWSYE4ybYr24d5H21LAvygcWZUzFeQ==;31:wflaiKrM/UXTmqidfURUiqo/oH4IVQ4qb3wFdXUfFmaOmPNTUrElbKSrOJO4IbVSAYddWlLWVTONl6tOyIW1fC1p0W3w7mAdKqIw+FA7rpNtTbmpH6B8Y1E+zNXJMkJ0ubJJeaszYaXoelfCEWjESjSbi6dN4o+8wfP1qEvf/c15lnTiMZvENg9AhIlIKz7ZneZfsidhQYueFEAwSVDTOGI6X47jZw5DQMqnHrXWg3Q=
X-MS-TrafficTypeDiagnostic: CY4P136MB0021:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;20:K3h6t+1Ivrsz2eZyurvxR/KWBU2dzNKSODpbrB1deT0EZL0TW/10AXpJvJdeLRn55ra85Xclddu016ErNJcc6cjlAoYj8bjiskNRoAtTs5ygqLVLUQLUnm8QY2TCwW9EaMz0vS5PDZFPc1qWso+71yIqWCIPHj2iGnteGml9wy/bfnynlsvPzYtrwzVB7hs3BgpeiaOasCwzzeIRrf38qGYfCW4ynuacS5EaloZLyxDXc6WDmyUXLulsG1teQVicnAI3Dcq4wtL2Vk/3aVukA51MNAxGMKfol73a5ljdZvKhHxDw5zJbHny5XFcoC1VmqAlAqK8/FQHLxgWZ04OCRAS6aYR6L6EL/x5jHUFTlsqvzASWfNJ4KeDOOEZCq3y7HqAkS4ix21rTCP/MLvXJAY+BM+GfBm4QY8NIb8D1L5VOLC/3DzE2kDv6zId+Z7UQNz7aWMT5D6lxgM4zJytaNXYHpIC4+AUJq4uGP+Bol/0JzFMRSsEx6/NCKmftRj34SaXj2uSdNn2ZMzxfwHb4cDkfdxlKGsuOB1typeQi/LYOhm5YArl7cGsL2ild3AoW4/uhYiQSgzoQX6PxE0FoLhSQQ71KSFOLDYRRvEAE3lM=
X-Microsoft-Antispam-PRVS: <CY4P136MB00212DDBFA91BD7DCA97FFCDE81D0@CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(61196332173343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(8121501046)(5005006)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4P136MB0021;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0021;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;4:TO5YX0uM4pvHrJUdpEqubmEjbM5/E0S2u4sFXWk4DE8n3ybZyONDGh5Wj0jVgRLZKtYWRs5ct0ObVWnNjnAkrmOuzXk0eA2OngzsIXrtUrRNiZShuYm1pioqJmrvrvdC7FDUyQTBptnmgltat9egDEqpYLvsTJh4u6q7QKhgXR8eg5DC0gn1ytk+O4f25T02N/mn6nVNmE0CvnDWIo2zwX0KJt2foXhkDhaMqgnDx1m9MH9waYXpg+TCyG0bQC/qKLlXeyaPFILOhdCavec1M5gATvzccvG35i2FQmq+ZnAc1lz539oWVkT7XxVzJd+cOpFJZsiP04L3aZLEmKcFv4owFcCXrURdje/0BvMlt+A=
X-Forefront-PRVS: 0544D934E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(366004)(39860400002)(396003)(346002)(376002)(39380400002)(189003)(199004)(5660300001)(575784001)(6916009)(86362001)(478600001)(6666003)(50466002)(97736004)(106356001)(2870700001)(52116002)(23676004)(2351001)(6512007)(53936002)(7736002)(6306002)(50226002)(2361001)(6116002)(3846002)(305945005)(105586002)(1076002)(966005)(85782001)(9686003)(4326008)(8656006)(66066001)(33896004)(316002)(6506007)(68736007)(2906002)(69596002)(39060400002)(8666007)(386003)(6486002)(53416004)(8936002)(25786009)(16526018)(81166006)(59450400001)(81156014)(36756003)(53376002)(8676002)(47776003)(85772001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0021;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQMTM2TUIwMDIxOzIzOkNpRHJvZVczeHZuQi9pQmcwWkJoRll4djlE?=
 =?utf-8?B?SHFDY051R3NQREVWN2hIT1hVMHgwNjd0d2IwOWF0QkRFRjI4OHo0cTU5Ynhj?=
 =?utf-8?B?cWE5VDhtR1hOWll6Szh6UkJUbjMyWDRMQlZaR2lmQ0hvSG14RW93b0tHM3lD?=
 =?utf-8?B?QlRPcUpYUEZqbmU5VFdtMitrNU9NZHNDSXQwbit4U2NBRFlUMTJGL2lMYW9k?=
 =?utf-8?B?QU5QZ2JXVjVTMjgvOWlTYnlPN2pwK2YvNTZKWmt6ZDN2SCs5SERQV3FBM3Jq?=
 =?utf-8?B?cU1JN2JsTWd0WWUzNU9jdm5TT3hMdHhPRVgvbjdNQXhxVTg0VEt4QmNaM2xS?=
 =?utf-8?B?T1hXTnIrNDhHVk9KNUh4MnpTME1vNEpTR1drMEpwMWNjZHBTNzFrQUtYb3Fm?=
 =?utf-8?B?SjVVcGI5aU1CbGRjYlE3cFBjVkpEVkJka3R4WlhKWDhpZFNxTFVvU0NSck51?=
 =?utf-8?B?bGhESTJCcEc3S2VEdllxeEZPcWRZRXFSU1g0elR6MG5uYjlEa2tockM2RHFM?=
 =?utf-8?B?aFJYQVVCTDBtTEloSUFlZTZHNjJwZUJCQXlEYlZ5YXhmYXF2ZktsbmxmQ29r?=
 =?utf-8?B?akRPbm1jWjdDb3NFdEV0RGIrbk5nNlFaVVgzenV1VmdBOVUzUlJTejFBMlBI?=
 =?utf-8?B?SGZzaUZ1cWRZYlVrOTMyWnhTVkpLSll4dGYwT1lMZWdwRWhrQjVsWDFIT0ZK?=
 =?utf-8?B?QlZvUHRuYlBSTGNuR0cyMDZ6KzdMRHdmUDFKM21sNVM4SUorbHk4aWNDUGNF?=
 =?utf-8?B?OS84c3hIV3JvamFWRG9IOFlxNkNXN3I5ajEvVXNRdi9TTXJMTW1sTStzQ05i?=
 =?utf-8?B?a2VYbGxka1Q5N2U4NHlDZmlNNGx1ZnN1VUI0SWtnYWpmUWV3QTFVQk1hbFZl?=
 =?utf-8?B?MDhwSU1DQjJlTkVaOWdtK2hBdzlLa2s3cWxndWFIWDBpQklydEY4WURHWG9k?=
 =?utf-8?B?NVZxR1FIZ0NuZjN6cENpaE5iZXAvVUF2VzBaeVcyMHV0Z0RNd0RFSHVXb2VL?=
 =?utf-8?B?d0Jjc0R4ZS9lSXVOSy9HZjVtQytsV2htQ0s1VjJaQlVWU1IzUXRBZlV6Qzhs?=
 =?utf-8?B?emk3RmRLQm1BN1JvZ2lrZklBVXc4TUlOU0hlUDBOSGorTjdOU2dyWHFvL282?=
 =?utf-8?B?Z3lHSUNJTGtXZmxocktabTRnaEtqVmNLWGtPTzZyZnFLc1FDUGxZTjJnZ1o5?=
 =?utf-8?B?NjVFa09aNGFaYnFudmgyeFEzTEpUaFFVd25qZ2dxd1FJc0Q2SU9tNDdyRC80?=
 =?utf-8?B?NEdFLzRzUjBwTU9ESEdRSm1VdWEzeEpnRUVwN1hUZ3JZY21KcjVXM041Z3B5?=
 =?utf-8?B?S1JyOHBPWkxnOWRhRTNGVWhKQ1ZPblZWaGtFSk04ZzMzRUc5WDl2Z1FOdTlG?=
 =?utf-8?B?ZUZYV0JWUXloa3QyYUxJK3JISEh6enl0VDBRQURobmdPbHN4eU11Q1pOdlVp?=
 =?utf-8?B?eDMwSlM5QVdhMzgvMXFoRkhKaXBzWDdXU2hqVTlJazMxQVR5cGlSbCtYeXJt?=
 =?utf-8?B?Q0dLMU9XK3pSaXVLNjBKV0VTNllOQkljT2xUYXVnR0JoUS83TFlqcmFIOUJq?=
 =?utf-8?B?bFdEMnh6bkFqSDA1ZyttenBEVEhMeUlJb0pPWGx5TkdTenk3dklLbXR0QzY1?=
 =?utf-8?B?SzJaVktVNWMveTZFV1YxR0hFQWltV2VGOGFaNjBpeS9CcW10UklydnVKNmZV?=
 =?utf-8?B?d2FZYUZuVitOaUpZSVMybWV6cDVJUWNLWThubUpuWWhmajVDczZHYm5CbnBu?=
 =?utf-8?B?c3RvcWRoV3pSZERyY2p4a1JibXBxeU5zaExkSnJmN0M5cElDd0hocis5eTUz?=
 =?utf-8?B?QnRMUncvZURjbHMzbkl4VkF5TTdrQnpON1dYVEVvWUJtSHdRazN5MEhhTWZv?=
 =?utf-8?B?Vzk2RUpwb1VyNWNuY29DeFU5c0UxSW5GMytqYjJ4RDltSkFXTjJCM1hLSXBQ?=
 =?utf-8?B?bW1oejQ4WmZQaFBSSW5DekNpTElBU2h4QS9WcEpYSVRFNkdvVzA5UWhTYVFR?=
 =?utf-8?Q?3aZic6?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;6:sDpJqhkXql7SP05vlnqUSdsY7B79rNi6fECTwgBINZp6e8g0AL6T4cY9H9Xr4nnaWZnJxDFMSsrbvg325ORF2GCFnI9vyF9n9ZCNx/6Uy1XUXDKiA8A5GX+t7AmUChLXZYM+tu5Mx87L+Ct1Nhp7hH72qyekv+R5kZBDS9utjsSlzmgRbefEaaZv42TgIyYK0Vbk14aAPFvlgi3McrfQ2MhxzYlu0ZQfkS/OgM+bePsS1m9pxfGNUq+HPwY2VPXwJ5My7l/c3YqgWAlXbY4SUj/SFzVyCvMm2Tlk+tM3iefbsExKsFeHMXPmnr9SIY4DILQHVyamFDSh4DTBhHgqsahjMhaYiUCs3KDO7/VFxYk=;5:xvPckYip2HIVrEhKjIIFwlKSAqeMGMm1NIeyMTA8Ztzw/4SkzUPEpJzRrHHAX/MbgU1Iw8bxIUu8//GuUqNazPRHOCHaaSDCz0hJK0Z+jfe4XkzvOYWztoA5V1khbtQyz3iBBzVwv7FTYyICyle4dy+nnwOoJGkX4Z9IWBygEhs=;24:MC2PgdMnTIKLmTLmyIHWg+j6HdiTVt3YeGQvD98h9wdCVvaegTztSVdxwoZqnfT8Nj9RogdNjShACnSxQEQYjPeMQISMgkWGF6YpOM473gk=;7:MGx06LKgaBcVH0VbRjQ6Cl/lfQR1I2gmUnODMZOCEBwmLoDSCPVmZWGZrYBX3E4yOYlGoLxApI7MQlVbtHg1DwdlzDzefCUTlDnRmFR7bDmyPT3GcsWzXiRtK9ohSw2Bw9iHHLtRVLfYB+52NGXYQbgwqa3tpkRjEo7wsBR4fteBpITuZqFNWPwYZJ0zGqOPGVzim4SeolOAST+EHygUUN1syCKCLjKYIygFm0Sc+fAhkOo4Xjl2oVDUWbuUoBVg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2018 00:48:33.0505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7bad7d-2b04-49a4-ce71-08d5549f37c5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

Patches 1-5 and 6 are helper functions and preparation.
Patch 6 is the actual change.

I am still torn between "checkout-encoding" and "working-tree-encoding"
as attribute name. I am happy to hear arguments for/against one or the
other.

Changes since v2:

* Added Torsten's crlfsave refactoring patch (patch 5)
  @Torsten: I tried to make the commit message more clean, added
            some comments to and renamed conv_flags_eol to
            global_conv_flags_eol.

* Improved documentation and commit message (Torsten)

* Removed unnecessary NUL assignment in xstrdup_tolower() (Torsten)

* Set "git config core.eol lf" to made the test run on Windows (Dscho)

* Made BOM arrays static (Ramsay)


Thanks,
Lars


    RFC: https://public-inbox.org/git/BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com/
     v1: https://public-inbox.org/git/20171211155023.1405-1-lars.schneider@autodesk.com/
     v2: https://public-inbox.org/git/20171229152222.39680-1-lars.schneider@autodesk.com/



Base Ref: master
Web-Diff: https://github.com/larsxschneider/git/commit/f21a1841a4
Checkout: git fetch https://github.com/larsxschneider/git encoding-v3 && git checkout f21a1841a4


### Interdiff (v2..v3):

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 0039bd38c3..1bc03e69cb 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -285,11 +285,18 @@ In these cases you can teach Git the encoding of a file in the working
 directory with the `checkout-encoding` attribute. If a file with this
 attributes is added to Git, then Git reencodes the content from the
 specified encoding to UTF-8 and stores the result in its internal data
-structure. On checkout the content is encoded back to the specified
-encoding.
+structure (called "the index"). On checkout the content is encoded
+back to the specified encoding.

-Please note that using the `checkout-encoding` attribute has a number
-of drawbacks:
+Please note that using the `checkout-encoding` attribute may have a
+number of pitfalls:
+
+- Git clients that do not support the `checkout-encoding` attribute
+  will checkout the respective files UTF-8 encoded and not in the
+  expected encoding. Consequently, these files will appear different
+  which typically causes trouble. This is in particular the case for
+  older Git versions and alternative Git implementations such as JGit
+  or libgit2 (as of January 2018).

 - Reencoding content to non-UTF encodings (e.g. SHIFT-JIS) can cause
   errors as the conversion might not be round trip safe.
@@ -297,12 +304,6 @@ of drawbacks:
 - Reencoding content requires resources that might slow down certain
   Git operations (e.g 'git checkout' or 'git add').

-- Git clients that do not support the `checkout-encoding` attribute or
-  the used encoding will checkout the respective files as UTF-8 encoded.
-  That means the content appears to be different which could cause
-  trouble. Affected clients are older Git versions and alternative Git
-  implementations such as JGit or libgit2 (as of January 2018).
-
 Use the `checkout-encoding` attribute only if you cannot store a file in
 UTF-8 encoding and if you want Git to be able to process the content as
 text.
diff --git a/apply.c b/apply.c
index c4bd5cf1f2..f8b67bfee2 100644
--- a/apply.c
+++ b/apply.c
@@ -2263,8 +2263,8 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 static int read_old_data(struct stat *st, struct patch *patch,
 			 const char *path, struct strbuf *buf)
 {
-	enum safe_crlf safe_crlf = patch->crlf_in_old ?
-		SAFE_CRLF_KEEP_CRLF : SAFE_CRLF_RENORMALIZE;
+	int conv_flags = patch->crlf_in_old ?
+		CONV_EOL_KEEP_CRLF : CONV_EOL_RENORMALIZE;
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
 		if (strbuf_readlink(buf, path, st->st_size) < 0)
@@ -2281,7 +2281,7 @@ static int read_old_data(struct stat *st, struct patch *patch,
 		 * should never look at the index when explicit crlf option
 		 * is given.
 		 */
-		convert_to_git(NULL, path, buf->buf, buf->len, buf, safe_crlf, 0);
+		convert_to_git(NULL, path, buf->buf, buf->len, buf, conv_flags);
 		return 0;
 	default:
 		return -1;
diff --git a/blame.c b/blame.c
index 388b66897b..2893f3c103 100644
--- a/blame.c
+++ b/blame.c
@@ -229,7 +229,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(&the_index, path, buf.buf, buf.len, &buf, 0, 0);
+	convert_to_git(&the_index, path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_oid.hash);
diff --git a/combine-diff.c b/combine-diff.c
index 4555e49b5f..19f30c3353 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1053,7 +1053,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;

-				if (convert_to_git(&the_index, elem->path, result, len, &buf, safe_crlf, 0)) {
+				if (convert_to_git(&the_index, elem->path, result, len, &buf, global_conv_flags_eol)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
diff --git a/config.c b/config.c
index e617c2018d..1f003fbb90 100644
--- a/config.c
+++ b/config.c
@@ -1149,11 +1149,14 @@ static int git_default_core_config(const char *var, const char *value)
 	}

 	if (!strcmp(var, "core.safecrlf")) {
+		int eol_rndtrp_die;
 		if (value && !strcasecmp(value, "warn")) {
-			safe_crlf = SAFE_CRLF_WARN;
+			global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 			return 0;
 		}
-		safe_crlf = git_config_bool(var, value);
+		eol_rndtrp_die = git_config_bool(var, value);
+		global_conv_flags_eol = eol_rndtrp_die ?
+			CONV_EOL_RNDTRP_DIE : CONV_EOL_RNDTRP_WARN;
 		return 0;
 	}

diff --git a/convert.c b/convert.c
index ca7b2f3e5c..525958bb56 100644
--- a/convert.c
+++ b/convert.c
@@ -194,30 +194,30 @@ static enum eol output_eol(enum crlf_action crlf_action)
 	return core_eol;
 }

-static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
+static void check_global_conv_flags_eol(const char *path, enum crlf_action crlf_action,
 			    struct text_stat *old_stats, struct text_stat *new_stats,
-			    enum safe_crlf checksafe)
+			    int conv_flags)
 {
 	if (old_stats->crlf && !new_stats->crlf ) {
 		/*
 		 * CRLFs would not be restored by checkout
 		 */
-		if (checksafe == SAFE_CRLF_WARN)
+		if (conv_flags & CONV_EOL_RNDTRP_DIE)
+			die(_("CRLF would be replaced by LF in %s."), path);
+		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
 			warning(_("CRLF will be replaced by LF in %s.\n"
 				  "The file will have its original line"
 				  " endings in your working directory."), path);
-		else /* i.e. SAFE_CRLF_FAIL */
-			die(_("CRLF would be replaced by LF in %s."), path);
 	} else if (old_stats->lonelf && !new_stats->lonelf ) {
 		/*
 		 * CRLFs would be added by checkout
 		 */
-		if (checksafe == SAFE_CRLF_WARN)
+		if (conv_flags & CONV_EOL_RNDTRP_DIE)
+			die(_("LF would be replaced by CRLF in %s"), path);
+		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
 			warning(_("LF will be replaced by CRLF in %s.\n"
 				  "The file will have its original line"
 				  " endings in your working directory."), path);
-		else /* i.e. SAFE_CRLF_FAIL */
-			die(_("LF would be replaced by CRLF in %s"), path);
 	}
 }

@@ -287,7 +287,7 @@ static struct encoding {
 static const char *default_encoding = "UTF-8";

 static int encode_to_git(const char *path, const char *src, size_t src_len,
-			 struct strbuf *buf, struct encoding *enc, int write_obj)
+			 struct strbuf *buf, struct encoding *enc, int conv_flags)
 {
 	char *dst;
 	int dst_len;
@@ -318,7 +318,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 			"file.");

 		advise(advise_msg, path, enc->name, enc->name, enc->name);
-		if (write_obj)
+		if (conv_flags & CONV_WRITE_OBJECT)
 			die(error_msg, path, enc->name);
 		else
 			error(error_msg, path, enc->name);
@@ -333,7 +333,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 			"%sBE/%sLE as checkout encoding or add a BOM to the "
 			"file.");
 		advise(advise_msg, path, enc->name, enc->name, enc->name);
-		if (write_obj)
+		if (conv_flags & CONV_WRITE_OBJECT)
 			die(error_msg, path, enc->name);
 		else
 			error(error_msg, path, enc->name);
@@ -350,7 +350,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 		 * working tree. Let's try to avoid this by screaming loud.
 		 */
 		const char* msg = _("failed to encode '%s' from %s to %s");
-		if (write_obj)
+		if (conv_flags & CONV_WRITE_OBJECT)
 			die(msg, path, enc->name, default_encoding);
 		else
 			error(msg, path, enc->name, default_encoding);
@@ -373,7 +373,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	 * [1] http://unicode.org/faq/utf_bom.html#gen2
 	 * [2] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode
 	 */
-	if (write_obj && !strcmp(enc->name, "SHIFT-JIS")) {
+	if ((conv_flags & CONV_WRITE_OBJECT) && !strcmp(enc->name, "SHIFT-JIS")) {
 		char *re_src;
 		int re_src_len;

@@ -388,7 +388,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 		    memcmp(src, re_src, src_len)) {
 			const char* msg = _("encoding '%s' from %s to %s and "
 					    "back is not the same");
-			if (write_obj)
+			if (conv_flags & CONV_WRITE_OBJECT)
 				die(msg, path, enc->name, default_encoding);
 			else
 				error(msg, path, enc->name, default_encoding);
@@ -429,7 +429,7 @@ static int encode_to_worktree(const char *path, const char *src, size_t src_len,
 static int crlf_to_git(const struct index_state *istate,
 		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
-		       enum crlf_action crlf_action, enum safe_crlf checksafe)
+		       enum crlf_action crlf_action, int conv_flags)
 {
 	struct text_stat stats;
 	char *dst;
@@ -459,12 +459,12 @@ static int crlf_to_git(const struct index_state *istate,
 		 * unless we want to renormalize in a merge or
 		 * cherry-pick.
 		 */
-		if ((checksafe != SAFE_CRLF_RENORMALIZE) &&
+		if ((!(conv_flags & CONV_EOL_RENORMALIZE)) &&
 		    has_cr_in_index(istate, path))
 			convert_crlf_into_lf = 0;
 	}
-	if ((checksafe == SAFE_CRLF_WARN ||
-	    (checksafe == SAFE_CRLF_FAIL)) && len) {
+	if (((conv_flags & CONV_EOL_RNDTRP_WARN) ||
+	     ((conv_flags & CONV_EOL_RNDTRP_DIE) && len))) {
 		struct text_stat new_stats;
 		memcpy(&new_stats, &stats, sizeof(new_stats));
 		/* simulate "git add" */
@@ -477,7 +477,7 @@ static int crlf_to_git(const struct index_state *istate,
 			new_stats.crlf += new_stats.lonelf;
 			new_stats.lonelf = 0;
 		}
-		check_safe_crlf(path, crlf_action, &stats, &new_stats, checksafe);
+		check_global_conv_flags_eol(path, crlf_action, &stats, &new_stats, conv_flags);
 	}
 	if (!convert_crlf_into_lf)
 		return 0;
@@ -1319,7 +1319,7 @@ const char *get_convert_attr_ascii(const char *path)

 int convert_to_git(const struct index_state *istate,
 		   const char *path, const char *src, size_t len,
-		   struct strbuf *dst, enum safe_crlf checksafe, int write_obj)
+		   struct strbuf *dst, int conv_flags)
 {
 	int ret = 0;
 	struct conv_attrs ca;
@@ -1335,14 +1335,14 @@ int convert_to_git(const struct index_state *istate,
 		len = dst->len;
 	}

-	ret |= encode_to_git(path, src, len, dst, ca.checkout_encoding, write_obj);
+	ret |= encode_to_git(path, src, len, dst, ca.checkout_encoding, conv_flags);
 	if (ret && dst) {
 		src = dst->buf;
 		len = dst->len;
 	}

-	if (checksafe != SAFE_CRLF_KEEP_CRLF) {
-		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
+	if (!(conv_flags & CONV_EOL_KEEP_CRLF)) {
+		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, conv_flags);
 		if (ret && dst) {
 			src = dst->buf;
 			len = dst->len;
@@ -1353,7 +1353,7 @@ int convert_to_git(const struct index_state *istate,

 void convert_to_git_filter_fd(const struct index_state *istate,
 			      const char *path, int fd, struct strbuf *dst,
-			      enum safe_crlf checksafe, int write_obj)
+			      int conv_flags)
 {
 	struct conv_attrs ca;
 	convert_attrs(&ca, path);
@@ -1364,8 +1364,8 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);

-	encode_to_git(path, dst->buf, dst->len, dst, ca.checkout_encoding, write_obj);
-	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
+	encode_to_git(path, dst->buf, dst->len, dst, ca.checkout_encoding, conv_flags);
+	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }

@@ -1430,7 +1430,7 @@ int renormalize_buffer(const struct index_state *istate, const char *path,
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(istate, path, src, len, dst, SAFE_CRLF_RENORMALIZE, 0);
+	return ret | convert_to_git(istate, path, src, len, dst, CONV_EOL_RENORMALIZE);
 }

 /*****************************************************************
diff --git a/convert.h b/convert.h
index 9e4e884ec1..1d9539ed0b 100644
--- a/convert.h
+++ b/convert.h
@@ -8,15 +8,13 @@

 struct index_state;

-enum safe_crlf {
-	SAFE_CRLF_FALSE = 0,
-	SAFE_CRLF_FAIL = 1,
-	SAFE_CRLF_WARN = 2,
-	SAFE_CRLF_RENORMALIZE = 3,
-	SAFE_CRLF_KEEP_CRLF = 4
-};
+#define CONV_EOL_RNDTRP_DIE   (1<<0) /* Die if CRLF to LF to CRLF is different */
+#define CONV_EOL_RNDTRP_WARN  (1<<1) /* Warn if CRLF to LF to CRLF is different */
+#define CONV_EOL_RENORMALIZE  (1<<2) /* Convert CRLF to LF */
+#define CONV_EOL_KEEP_CRLF    (1<<3) /* Keep CRLF line endings as is */
+#define CONV_WRITE_OBJECT     (1<<4) /* Content is written to the index */

-extern enum safe_crlf safe_crlf;
+extern int global_conv_flags_eol;

 enum auto_crlf {
 	AUTO_CRLF_FALSE = 0,
@@ -66,8 +64,7 @@ extern const char *get_convert_attr_ascii(const char *path);
 /* returns 1 if *dst was used */
 extern int convert_to_git(const struct index_state *istate,
 			  const char *path, const char *src, size_t len,
-			  struct strbuf *dst, enum safe_crlf checksafe,
-			  int write_obj);
+			  struct strbuf *dst, int conv_flags);
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int async_convert_to_working_tree(const char *path, const char *src,
@@ -80,14 +77,13 @@ extern int renormalize_buffer(const struct index_state *istate,
 static inline int would_convert_to_git(const struct index_state *istate,
 				       const char *path)
 {
-	return convert_to_git(istate, path, NULL, 0, NULL, 0, 0);
+	return convert_to_git(istate, path, NULL, 0, NULL, 0);
 }
 /* Precondition: would_convert_to_git_filter_fd(path) == true */
 extern void convert_to_git_filter_fd(const struct index_state *istate,
 				     const char *path, int fd,
 				     struct strbuf *dst,
-				     enum safe_crlf checksafe,
-				     int write_obj);
+				     int conv_flags);
 extern int would_convert_to_git_filter_fd(const char *path);

 /*****************************************************************
diff --git a/diff.c b/diff.c
index 16ca0bf0df..fe3ff6e876 100644
--- a/diff.c
+++ b/diff.c
@@ -3516,13 +3516,13 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 {
 	int size_only = flags & CHECK_SIZE_ONLY;
 	int err = 0;
+	int conv_flags = global_conv_flags_eol;
 	/*
 	 * demote FAIL to WARN to allow inspecting the situation
 	 * instead of refusing.
 	 */
-	enum safe_crlf crlf_warn = (safe_crlf == SAFE_CRLF_FAIL
-				    ? SAFE_CRLF_WARN
-				    : safe_crlf);
+	if (conv_flags & CONV_EOL_RNDTRP_DIE)
+		conv_flags = CONV_EOL_RNDTRP_WARN;

 	if (!DIFF_FILE_VALID(s))
 		die("internal error: asking to populate invalid file.");
@@ -3599,7 +3599,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, crlf_warn, 0)) {
+		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, conv_flags)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
diff --git a/environment.c b/environment.c
index 8fa032f307..888b873f90 100644
--- a/environment.c
+++ b/environment.c
@@ -49,7 +49,7 @@ enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int check_replace_refs = 1;
 char *git_replace_ref_base;
 enum eol core_eol = EOL_UNSET;
-enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
+int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
diff --git a/sha1_file.c b/sha1_file.c
index 75800248d2..dcb02e9ffd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -75,14 +75,14 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
 }


-static enum safe_crlf get_safe_crlf(unsigned flags)
+static int get_conv_flags(unsigned flags)
 {
 	if (flags & HASH_RENORMALIZE)
-		return SAFE_CRLF_RENORMALIZE;
+		return CONV_EOL_RENORMALIZE;
 	else if (flags & HASH_WRITE_OBJECT)
-		return safe_crlf;
+		return global_conv_flags_eol | CONV_WRITE_OBJECT;
 	else
-		return SAFE_CRLF_FALSE;
+		return 0;
 }


@@ -1694,8 +1694,7 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
 		if (convert_to_git(&the_index, path, buf, size, &nbuf,
-				   get_safe_crlf(flags),
-				   write_object)) {
+				   get_conv_flags(flags))) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
 		}
@@ -1729,7 +1728,7 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
 	assert(would_convert_to_git_filter_fd(path));

 	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
-				 get_safe_crlf(flags), write_object);
+				 get_conv_flags(flags));

 	if (write_object)
 		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
diff --git a/strbuf.c b/strbuf.c
index 54276e96e7..703a1556cb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -756,7 +756,6 @@ char *xstrdup_tolower(const char *string)
 	result = xmallocz(len);
 	for (i = 0; i < len; i++)
 		result[i] = tolower(string[i]);
-	result[i] = '\0';
 	return result;
 }

@@ -769,7 +768,6 @@ char *xstrdup_toupper(const char *string)
 	result = xmallocz(len);
 	for (i = 0; i < len; i++)
 		result[i] = toupper(string[i]);
-	result[i] = '\0';
 	return result;
 }

diff --git a/t/t0028-checkout-encoding.sh b/t/t0028-checkout-encoding.sh
index df3cc91269..5f1c911c07 100755
--- a/t/t0028-checkout-encoding.sh
+++ b/t/t0028-checkout-encoding.sh
@@ -7,11 +7,10 @@ test_description='checkout-encoding conversion via gitattributes'
 GIT_TRACE_CHECKOUT_ENCODING=1 && export GIT_TRACE_CHECKOUT_ENCODING

 test_expect_success 'setup test repo' '
+	git config core.eol lf &&

 	text="hallo there!\ncan you read me?" &&
-
 	echo "*.utf16 text checkout-encoding=utf-16" >.gitattributes &&
-
 	printf "$text" >test.utf8.raw &&
 	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
 	cp test.utf16.raw test.utf16 &&
diff --git a/utf8.c b/utf8.c
index 1978d6c42a..f033fec1c2 100644
--- a/utf8.c
+++ b/utf8.c
@@ -544,10 +544,10 @@ static int has_bom_prefix(const char *data, size_t len,
 	return (len >= bom_len) && !memcmp(data, bom, bom_len);
 }

-const char utf16_be_bom[] = {0xFE, 0xFF};
-const char utf16_le_bom[] = {0xFF, 0xFE};
-const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
-const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
+static const char utf16_be_bom[] = {0xFE, 0xFF};
+static const char utf16_le_bom[] = {0xFF, 0xFE};
+static const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
+static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};

 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 {


### Patches

Lars Schneider (6):
  strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
  strbuf: add xstrdup_toupper()
  utf8: add function to detect prohibited UTF-16/32 BOM
  utf8: add function to detect a missing UTF-16/32 BOM
  convert: add support for 'checkout-encoding' attribute
  convert: add tracing for checkout-encoding

Torsten Bögershausen (1):
  convert_to_git(): safe_crlf/checksafe becomes int conv_flags

 Documentation/gitattributes.txt |  60 ++++++++++
 apply.c                         |   6 +-
 combine-diff.c                  |   2 +-
 config.c                        |   7 +-
 convert.c                       | 256 ++++++++++++++++++++++++++++++++++++----
 convert.h                       |  18 ++-
 diff.c                          |   8 +-
 environment.c                   |   2 +-
 sha1_file.c                     |  12 +-
 strbuf.c                        |  13 +-
 strbuf.h                        |   1 +
 t/t0028-checkout-encoding.sh    | 198 +++++++++++++++++++++++++++++++
 utf8.c                          |  37 ++++++
 utf8.h                          |  25 ++++
 14 files changed, 597 insertions(+), 48 deletions(-)
 create mode 100755 t/t0028-checkout-encoding.sh


base-commit: 95ec6b1b3393eb6e26da40c565520a8db9796e9f
--
2.15.1

