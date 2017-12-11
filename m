Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775371F404
	for <e@80x24.org>; Mon, 11 Dec 2017 15:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbdLKPuw (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 10:50:52 -0500
Received: from mail-bn3nam01on0106.outbound.protection.outlook.com ([104.47.33.106]:20608
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750707AbdLKPuu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 10:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/tjRvQvgP4CeBtPEpQmc27j19B0MxuRNt7G1ii+ZseI=;
 b=RO2MSSlR4M7rJc3mTRKtpcHmL4MH6HGrYjjMRABBsHZ9RaxKDCT1qCtjsGmwYCNYBslFAfosmP4TbCVQWFydtl8OGKhcq7BoF5YY3a4Hf50j+RXm/mHbdqTa11fr/p+dY2p0fZEhJMqvKwn1nlyEo+qnEqb02/et6IGK7ALy6zw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 BN6P136MB0018.NAMP136.PROD.OUTLOOK.COM (129.75.91.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.13; Mon, 11 Dec 2017 15:50:41 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, peff@peff.net, patrick@luehne.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] convert: add support for 'encoding' attribute
Date:   Mon, 11 Dec 2017 16:50:23 +0100
Message-Id: <20171211155023.1405-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: VI1PR0802CA0039.eurprd08.prod.outlook.com (10.172.253.25)
 To BN6P136MB0018.NAMP136.PROD.OUTLOOK.COM (129.75.91.25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e052676c-fff2-4d6c-09b7-08d540aeefe2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307);SRVR:BN6P136MB0018;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0018;3:4aN3E53dUCdHqNOtDhoJifFzLukYgSA5SDjBhP8XDbAAvwvEfatcV+pVHJ7EslRGWDPZx/g71wuo/Th9tzpPbuoF8rLqKQUnyagQwMBaDttS1BZmzq/9xEJHlmIqY2IO6Kxvx8C1UhuXGm9nMyrdJ3mS+TgaU6wgSN0HSLbW/9iQiT7B/SXN0fZK5QKBSrDbdw/m60Vp3bDKMWPPwOhNkr4fs4z1EGW/JdcVIZZCuOM8LTd2QxMuJ48g3RLvrCZF;25:v3CDr0iPGJVktGvZ3UJY97g5PkMPulaW+APlTdyQRRiccMFvd0p3OBFJJsOliQWLlm3NCjItcIiNeLaYVSjr+fIhVnw81+FM8dBgyrCY9VMmklncYYbF5gWNyQsbRaGmWN2Zdr2c/YwK05qCwHXf4FD5Tx8Pnkc61jwIuWL3a6AwXzZ1pCan4gSJvfttMHEaoFfJVQxkPvZHd8CITmGhPrmCKBg/hz3HRsyNMf9DGszQA28GFWKp4jSUczXFizOoVWXL1Eo0JQarJ0PkjVsCvqXBTMC1bSGaWh8SZa1zorTvpDOpNdqZA20FKEPdGdhBw0uxfgSQyEryRIgU/xS4RQ==;31:snUsfH2wHiXlAXF1Q99qPe0o41KrWsPLIR1zIQVQiIm/lI7gwpprxOw7vrDBqeQ5zEEBZ28EnT5qZ8aVOO93digX2Jd9Sx3EzXmzS+bkzhAUJb6Zk/P8fQiF9rVk4SWZC0VwaQEpNnaB534DLq+X9BQuCIj6OerN33/OzkQf9CK+LPz9hLXfUsLuUwIMTzJGcSYmBvYk2cq5L8FXqAvoMCm5yGztEH5G/w+0ZC4pTyU=
X-MS-TrafficTypeDiagnostic: BN6P136MB0018:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0018;20:1ILqqCOTZaJBMtE5R1sNKB63h7dDeu65i/R14oNut6wVPPv7r4vMm8x6vrV5gMcmMERc4UpwWjzfpH1CifVTaOipaSD92ks5idxeDgJ3x7NDdXYuIzNUy1JZ/u0Rbc6o4IGxybXOOtOTh0ACA/dbODJq6JHxGMjtir79rND4OfH97QM6SqIFHBahWdZvM5OM/gApD5In5FMbljf3I/o7uuP+mBzFIQZNP8/ruYmKeIZTLsyzPFFeHVULYkbFCUvO3OyPxwj5PBv9NmqTMbyFUbQb6uAE13IVpDucdg1/Ep1BhGPxYVWxYs045SuxRCZ+DW6lCdXXYZ4m778BaemoPLVVg6PUrG8cAOAc4GGC/RO275TYZuwS8clzteyupNf1pPTg8YArR+jL00++4sxUflMXICQAmBoaDL+dciE4PaK1x7Zrvuwy5tnHClMnpYoCemwyFnA/zRlSDAINDi+oVsTfCYUbPiQRCouoPIz0QjjSq3F6+9HaMr1jYdQF02SYT+sNhESEqn8oB+dHub/2ED0vhKbWdstcFJGBLk60YlI+LwHpO3/skfQRastIHoa6TRWFs0k2+lfoz2wdVO+zGgpYi8Q8HK4VOD1rerWNoHQ=
X-Microsoft-Antispam-PRVS: <BN6P136MB001886040D446BD30424F0D7E8370@BN6P136MB0018.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030)(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3002001)(3231022)(93006095)(93001095)(10201501046)(6055026)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123564025)(20161123560025)(20161123555025)(6072148)(201708071742011);SRVR:BN6P136MB0018;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BN6P136MB0018;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0018;4:DYWCxOZO9Jhu5aOQGl2ELHlD1kmuGxc4SeHXER1wu+B+n5vhXsi+sC6ZRGUdpVel0jPExIz0QJHbMcSVSnoAWzZvOnjGLUVisdPpUO7mBMSdAhdzBY97a07slKYBnBgRpptBzYebs6SGaMDnuaxFj4MoDDT+Dml0QsFcOCEx+N1npezb62aS7dtw4sYYKe3eWqsQCvELyDLZAueD9Y9Rq9LUz7gFfcWLcj+iMxCDc5cOQGtjw86alFut9iP0hrBr3wF2gGTYs782kshNXGUzkDFbjsuoLD9i+Z9RaZ9hPbGLSM/kj2HEh0r1yGR/vr6RC+pu7/cQZvGg1WMWomvPmvAgxBAZJ8P2CSLGGDGcVa7fd2OUWTFKcqkq+mxueMO1
X-Forefront-PRVS: 0518EEFB48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(189003)(199004)(23676004)(9686003)(66066001)(81166006)(85782001)(86362001)(47776003)(8676002)(25786009)(1076002)(2351001)(6116002)(6916009)(6306002)(6666003)(478600001)(81156014)(575784001)(50466002)(16526018)(966005)(3846002)(2361001)(50226002)(36756003)(52116002)(4326008)(2906002)(105586002)(68736007)(5890100001)(5660300001)(6486002)(316002)(2870700001)(7696005)(8936002)(106356001)(97736004)(7736002)(8656006)(53936002)(53376002)(39060400002)(305945005)(59450400001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0018;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQMTM2TUIwMDE4OzIzOjhUUVRYbEZyTXlHZGdxYW1yRjI2Q2RtZ09F?=
 =?utf-8?B?TFpMdFYzUVBRM0Z6amFnRTRLaC91dGJJVTdFZmptNnZDcFZiSWpVcXNzbkJW?=
 =?utf-8?B?OG80cm1JdTlSR05ZaEI0TkZzVklKMnFpcVRNZVFiaHVtWEJadTRjR1NGRnFy?=
 =?utf-8?B?YlBhRzJYVWxIbDRNV0ZjOUVYTE43MDlUV09qd3g4ci9SYmtocHdwU1FWcHhM?=
 =?utf-8?B?VVpaWmVtK3VYdzlVZ1NsSDBaZ2psVzlabHpvc0xzVld1K2xHdWNoZDNqdmFq?=
 =?utf-8?B?UG5rZStYM3hpNjJFQndkR3pXdVQvWjFPakZ5dFh6dUhLdVJJdzlwWHNOb21y?=
 =?utf-8?B?SFRINWswSGltdkhjNlBkaG5GbCtzVHJ2Ykgreis1WEs3Y0J1cURGTWhuM1BL?=
 =?utf-8?B?Z2RsWjdyOGF1bXdKRE5wTnBEdmd2NEJ6eDRwbEJJTE1LNTVGYkNxM0h2R2Jz?=
 =?utf-8?B?ZytoZXNJTncyUUZHUk1XMmc0L1lIS3ZVbkJkcGpSYWJqQmtmQWFJbzdqNUhq?=
 =?utf-8?B?aWRlU1NIMkx5dUdqN3VjRnQvLyszemVoU1JYeUJWTkdQT1hXZXY1Unh5Mlk1?=
 =?utf-8?B?eG4rUS8wUWFvRlJnYUNpUmtEL1dGQlZKUlNqbTBZMHB3ckV4TmlIbEtvYUZH?=
 =?utf-8?B?M0tRRDFaUjh3c0h4RC96cWhsbEg1UGxGL0N0M3VDRlVaejlLUmNLT08yVnJi?=
 =?utf-8?B?UW1kSlF6Zk5vcXRCQlcrMFNUc1BSaU5VVGdnYU90UEVmZlpKOXdEMXY1M1My?=
 =?utf-8?B?WWo2ZUQ0M3VWTTErL1dmNy8wVE9YUStHaTNZblAvV3BUUnRiNUxkMElqOFhB?=
 =?utf-8?B?UkdBOTcxUWNvanN1VlhkeW00S0pXS3dQQ2g0akp6UXdxd3FyVThwenJ1ZVQz?=
 =?utf-8?B?azFzZy83UXVUdmFxRXNOaHlycDFxOVRVWk8wM216WDMzaHpMdkc3aWNhcEov?=
 =?utf-8?B?bXJaYndvSUNKdmRYT09zV1hUSnQyaFJneHdrNXVSQnpWb2w2aHBHOFg5dGV6?=
 =?utf-8?B?TXMrejlYaUFtcVB4bityWm5FbVI1SGRZUnJnSzlka0gzV0FycmJyTHdHeGFq?=
 =?utf-8?B?WVJ3Q1dObEE4M01PclNOUnBwSndkR0xweEtPdGkyTjRyRXZ5S0tUYzZBK3A0?=
 =?utf-8?B?OXRIWXFOWUtuNVlROE4xZUpJa3dqdkxiU2xuOUNVbmJ2NTFENGZoazdtNlpF?=
 =?utf-8?B?bkZQMnNmaGF0QkRxUStBOTlwbFFIdm5vTTBnekhCV3BXTUNzRnhoZmsvc2RV?=
 =?utf-8?B?UHRLMStzQnNrdUJQWURVL09hazFHalZvVTNQRlo4VkQxRW1QWFRMQlpTLzF0?=
 =?utf-8?B?TFJKdEEyUEsrL1JSYjZuTFMwRjExNDNCREdrdThBLzhPVzdQS0FpQTJ4TVh4?=
 =?utf-8?B?YzVjRnBwRzk5NkFTdEhMMFFBYi9xemtXT2lTcUVMaThjZkZLSXlWdysvZGRz?=
 =?utf-8?B?MDVHa0dNd2xDRXRpRnRpRXJLeVNGNUUvN0p4RW1xRVVuK0g1NFVMNFY1MmJq?=
 =?utf-8?B?dW5UaC80czk1UFVIeGM5VHJxTzFWY1ErWUZHQ2R2S083aVBZRElONG9BNmV1?=
 =?utf-8?B?bnRyMHd1bERZRFRMT1draUt0ekFFcXk5VWlGNGs2d09oV3lVck5SYS95d1hm?=
 =?utf-8?B?OHArQmVQVy9yWlZ2ejlWZWpaL0wrWGVPRG1VRXBMUW5JOEJsY29BaFJnPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0018;6:oTzw61Om0AeK/0NcvW5j3Y03CJusxmvZBDNvuy12q0sTiqCu9rRX6XR5LovacLxb8sN/7pDE9I4wiMPj0m2tr01plPzz9DavECI/BJ33LjVjygtiXKCmPR6nqkYCmXXl49YYK1sdHCX16qqO0A+uFddJd9Zi0qar3Cw/Ea4VLP5UZcMyk6/fCNbtWoTIj54C7hDCzajyu4MhTHgXJHQvlTvlq4+F2cHJNfVFHFluOvTHcYpHPlcUXb9Jq75AMb1LyFjUYCBYCVbi4cXs3GN5pNgtvDss5I9idEL2TAY2dlbEDWixeyxATxfDAe6OT6nOob0Gg5VRFAnG5TnylVAu5KF2Dv5W8Zal0IzE3D65KJ0=;5:8x4+hktaldPyrmpuNkhHuE1D27oR6wYrRJM0pVDljo0EsrqpsBK7LHWWMOCNUB7QEH+Ohq0OrGG97OXi8KOEOT8jpg4d13gIuOtxXgcmoRhFdJpm5whGhw04kbDjvuiYPzqkUue/IKeeWzdofMX5jgjQMa3WXvP2F2Iy5jooOos=;24:lioep4OKviYC4xOK0pjqckSBFKlgY+Dp0VLr3t0h7YKpUiL71MGcCeUqVE2Z/4/uRVGdo4Rsx8GCjgVgIfu6Io2VcvZ8WQKIPkjkFUXawkA=;7:bOSq8jBjH1EoJVutvZHT739/EdUWR/OoLldRK5qxHbPUo3w77ZXvIC9IsEHlKCIX0ppdYNNJw3WN2Mntt4Q3oVO+KPn6rVKuJVIDQzuE1QDeIO5Gnb5sdUWicrvwtnXP6+Nj5SNsKBl6dSl69W+7pLTRsxuoWzSOBtrxcBdNfZWxsMK4kXPvCFr+Dj8kuANa/RdY3gL0EjeO39TO36V0w+LjoXZR/1RVQ/UWmM+P/ZIw6OTAF/6WEqoSOUUVkvrk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0018;20:y9IDA1LKXr1HwU9oHle2E/U/Mqy58X1Jfz0vHMJgmiGaQN1hsyu+TaeFGjeneNpEIVXG9BXqa6uIl302+q9OOy2fBoI0VvsvorftPmlq+jMkFVj0t0IeVHBvUW1D58Xv1nQxwNetd7DgZY9k2ZtYKU+Jo0YY79OvAXgBSEgw198=
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2017 15:50:41.1473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e052676c-fff2-4d6c-09b7-08d540aeefe2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0018
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git and its tools (e.g. git diff) expect all text files in UTF-8
encoding. Git will happily accept content in all other encodings, too,
but it might not be able to process the text (e.g. viewing diffs or
changing line endings).

Add an attribute to tell Git what encoding the user has defined for a
given file. If the content is added to the index, then Git converts the
content to a canonical UTF-8 representation. On checkout Git will
reverse the conversion.

Reviewed-by: Patrick Lühne <patrick@luehne.de>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Hi,

here is a WIP patch to add text encoding support for files encoded with
something other than UTF-8 [RFC].

The 'encoding' attribute is already used to view blobs in gitk. That
could be a problem as the content is stored in Git with the defined
encoding. This patch would interpret the content as UTF-8 encoded and
it would try to reencode it to the defined encoding on checkout.
Plus, many repos define the attribute very broad (e.g. "* encoding=cp1251").
These folks would see errors like these with my patch:
    error: failed to encode 'foo.bar' from utf-8 to cp1251

A quick search on GitHub reveals 2,722 repositories that use the
'encoding' attribute [1]. Using the GitHub API [2], I identified the
following encodings in all publicly accessible repositories:

    ANSI        <-- garbage (ignore by my implementation)
    cp1251
    cp866
    cp950
    iso8859-1
    koi8-r
    shiftjis    <-- garbage (ignore by my implementation)
    UTF-8       <-- unnecessary (ignore by my implementation)
    utf8        <-- garbage (ignore by my implementation)

TODOs:
    - The iconv docs mention that "errno == EINVAL" is harmless but
      we don't handle that case in utf8.c:reencode_string_iconv()
    - Git does not compile with NO_ICONV=1 right now because of
      compat/precompose_utf8.c. I will send a patch to fix that.

Questions:
    - Should I use warning() or error() in the patch?
      (currently I use the warning)
    - Do you agree with the approach in general?

Thanks,
Lars


[RFC] http://public-inbox.org/git/BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com
  [1] https://github.com/search?p=1&q=encoding+filename%3Agitattributes&type=Code&utf8=%E2%9C%93
  [2] curl --user larsxschneider:secret -H 'Accept: application/vnd.github.v3.text-match+json' 'https://api.github.com/search/code?q=encoding+in:file+filename:gitattributes' | jq -r '.items[].text_matches[].fragment' | sed 's/.*encoding=//' | sort | uniq
  [3] https://www.gnu.org/software/libc/manual/html_node/iconv-Examples.html#iconv-Examples




Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/afc9e88a4d
    Checkout: git fetch https://github.com/larsxschneider/git encoding-v1 && git checkout afc9e88a4d

 Documentation/gitattributes.txt |  27 ++++++
 convert.c                       | 192 +++++++++++++++++++++++++++++++++++++++-
 t/t0028-encoding.sh             |  60 +++++++++++++
 3 files changed, 278 insertions(+), 1 deletion(-)
 create mode 100755 t/t0028-encoding.sh

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 30687de81a..84de2fa49c 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -146,6 +146,33 @@ Unspecified::
 Any other value causes Git to act as if `text` has been left
 unspecified.

+`encoding`
+^^^^^^^^^^
+
+By default Git assumes UTF-8 encoding for text files.  The `encoding`
+attribute sets the encoding to be used in the working directory.
+If the path is added to the index, then Git encodes the content to
+UTF-8.  On checkout the content is encoded back to the original
+encoding.  Consequently, you can use all built-in Git text processing
+tools (e.g. git diff, line ending conversions, etc.) with your
+non-UTF-8 encoded file.
+
+Please note that re-encoding content can cause errors and requires
+resources. Use the `encoding` attribute only if you cannot store
+a file in UTF-8 encoding and if you want Git to be able to process
+the text.
+
+------------------------
+*.txt		text encoding=UTF-16
+------------------------
+
+All `iconv` encodings with a stable round-trip conversion to and from
+UTF-8 are supported.  You can see a full list with the following command:
+
+------------------------
+iconv --list
+------------------------
+
 `eol`
 ^^^^^

diff --git a/convert.c b/convert.c
index 20d7ab67bd..ee19c17104 100644
--- a/convert.c
+++ b/convert.c
@@ -7,6 +7,7 @@
 #include "sigchain.h"
 #include "pkt-line.h"
 #include "sub-process.h"
+#include "utf8.h"

 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -256,6 +257,149 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,

 }

+#ifdef NO_ICONV
+#ifndef _ICONV_T
+/* The type is just a placeholder and not actually used. */
+typedef void* iconv_t;
+#endif
+#endif
+
+static struct encoding {
+	const char *name;
+	iconv_t to_git;       /* conversion to Git's canonical encoding (UTF-8) */
+	iconv_t to_worktree;  /* conversion to user-defined encoding */
+	struct encoding *next;
+} *encoding, **encoding_tail;
+static const char *default_encoding = "utf-8";
+static iconv_t invalid_conversion = (iconv_t)-1;
+
+static int encode_to_git(const char *path, const char *src, size_t src_len,
+			 struct strbuf *buf, struct encoding *enc)
+{
+#ifndef NO_ICONV
+	char *dst, *re_src;
+	int dst_len, re_src_len;
+
+	/*
+	 * No encoding is specified or there is nothing to encode.
+	 * Tell the caller that the content was not modified.
+	 */
+	if (!enc || (src && !src_len))
+		return 0;
+
+	/*
+	 * Looks like we got called from "would_convert_to_git()".
+	 * This means Git wants to know if it would encode (= modify!)
+	 * the content. Let's answer with "yes", since an encoding was
+	 * specified.
+	 */
+	if (!buf && !src)
+		return 1;
+
+	if (enc->to_git == invalid_conversion) {
+		enc->to_git = iconv_open(default_encoding, encoding->name);
+		if (enc->to_git == invalid_conversion)
+			warning(_("unsupported encoding %s"), encoding->name);
+	}
+
+	if (enc->to_worktree == invalid_conversion)
+		enc->to_worktree = iconv_open(encoding->name, default_encoding);
+
+	/*
+	 * Do nothing if the encoding is not supported. This could happen in
+	 * two cases:
+	 *   (1) The encoding is garbage. That is no problem as we would not
+	 *       encode the content to UTF-8 on "add" and we would not encode
+	 *       it back on "checkout".
+	 *   (2) Git users use different iconv versions that support different
+	 *       encodings. This could lead to problems, as the content might
+	 *       not be encoded on "add" but encoded back on "checkout" (or
+	 *       the other way around).
+	 * We print a one-time warning to the user in both cases above.
+	 */
+	if (enc->to_git == invalid_conversion || enc->to_worktree == invalid_conversion)
+		return 0;
+
+	dst = reencode_string_iconv(src, src_len, enc->to_git, &dst_len);
+	if (!dst)
+		/*
+		 * We could add the blob "as-is" to Git. However, on checkout
+		 * we would try to reencode to the original encoding. This
+		 * would fail and we would leave the user with a messed-up
+		 * working tree. Let's try to avoid this by screaming loud.
+		 */
+		die(_("failed to encode '%s' from %s to %s"),
+			path, enc->name, default_encoding);
+
+	/*
+	 * Encode dst back to ensure no information is lost. This wastes
+	 * a few cycles as most conversions are round trip conversion
+	 * safe. However, content that has an invalid encoding might not
+	 * match its original byte sequence after the UTF-8 conversion
+	 * round trip. Let's play safe here and check the round trip
+	 * conversion.
+	 */
+	re_src = reencode_string_iconv(dst, dst_len, enc->to_worktree, &re_src_len);
+	if (!re_src || strcmp(src, re_src)) {
+		die(_("encoding '%s' from %s to %s and back is not the same"),
+			path, enc->name, default_encoding);
+	}
+	free(re_src);
+
+	strbuf_attach(buf, dst, dst_len, dst_len + 1);
+	return 1;
+#else
+	warning(_("cannot encode '%s' from %s to %s because "
+		"your Git was not compiled with encoding support"),
+		path, enc->name, default_encoding);
+	return 0;
+#endif
+}
+
+static int encode_to_worktree(const char *path, const char *src, size_t src_len,
+			      struct strbuf *buf, struct encoding *enc)
+{
+#ifndef NO_ICONV
+	char *dst;
+	int dst_len;
+
+	/*
+	 * No encoding is specified or there is nothing to encode.
+	 * Tell the caller that the content was not modified.
+	 */
+	if (!enc || (src && !src_len))
+		return 0;
+
+	if (enc->to_worktree == invalid_conversion) {
+		enc->to_worktree = iconv_open(encoding->name, default_encoding);
+		if (enc->to_worktree == invalid_conversion)
+			warning("unsupported encoding %s", encoding->name);
+	}
+
+	/*
+	 * Do nothing if the encoding is not supported.
+	 * See detailed explanation in encode_to_git().
+	 */
+	if (enc->to_worktree == invalid_conversion)
+		return 0;
+
+	dst = reencode_string_iconv(src, src_len, enc->to_worktree, &dst_len);
+	if (!dst) {
+		warning("failed to encode '%s' from %s to %s",
+			path, default_encoding, encoding->name);
+		return 0;
+	}
+
+	strbuf_attach(buf, dst, dst_len, dst_len + 1);
+	return 1;
+#else
+	warning(_("cannot encode '%s' from %s to %s because "
+		"your Git was not compiled with encoding support"),
+		path, default_encoding, encoding->name);
+	return 0;
+#endif
+}
+
 static int crlf_to_git(const struct index_state *istate,
 		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
@@ -969,6 +1113,32 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }

+static struct encoding *git_path_check_encoding(struct attr_check_item *check)
+{
+	const char *value = check->value;
+	struct encoding *enc;
+
+	if (ATTR_UNSET(value))
+		return NULL;
+
+	for (enc = encoding; enc; enc = enc->next)
+		if (!strcmp(value, enc->name))
+			return enc;
+
+	/* Don't encode to the default encoding */
+	if (!strcasecmp(value, default_encoding))
+		return NULL;
+
+	enc = xcalloc(1, sizeof(struct convert_driver));
+	enc->name = xstrdup(value);
+	enc->to_git = invalid_conversion;
+	enc->to_worktree = invalid_conversion;
+	*encoding_tail = enc;
+	encoding_tail = &(enc->next);
+
+	return enc;
+}
+
 static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
 {
 	const char *value = check->value;
@@ -1024,6 +1194,7 @@ struct conv_attrs {
 	enum crlf_action attr_action; /* What attr says */
 	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
 	int ident;
+	struct encoding *encoding; /* Supported encoding or default encoding if NULL */
 };

 static void convert_attrs(struct conv_attrs *ca, const char *path)
@@ -1032,8 +1203,9 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)

 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
-					 "eol", "text", NULL);
+					 "eol", "text", "encoding", NULL);
 		user_convert_tail = &user_convert;
+		encoding_tail = &encoding;
 		git_config(read_convert_config, NULL);
 	}

@@ -1055,6 +1227,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 			else if (eol_attr == EOL_CRLF)
 				ca->crlf_action = CRLF_TEXT_CRLF;
 		}
+		ca->encoding = git_path_check_encoding(ccheck + 5);
 	} else {
 		ca->drv = NULL;
 		ca->crlf_action = CRLF_UNDEFINED;
@@ -1135,6 +1308,13 @@ int convert_to_git(const struct index_state *istate,
 		src = dst->buf;
 		len = dst->len;
 	}
+
+	ret |= encode_to_git(path, src, len, dst, ca.encoding);
+	if (ret && dst) {
+		src = dst->buf;
+		len = dst->len;
+	}
+
 	if (checksafe != SAFE_CRLF_KEEP_CRLF) {
 		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
 		if (ret && dst) {
@@ -1158,6 +1338,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);

+	encode_to_git(path, dst->buf, dst->len, dst, ca.encoding);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
@@ -1189,6 +1370,12 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}

+	ret |= encode_to_worktree(path, src, len, dst, ca.encoding);
+	if (ret) {
+		src = dst->buf;
+		len = dst->len;
+	}
+
 	ret_filter = apply_filter(
 		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, dco);
 	if (!ret_filter && ca.drv && ca.drv->required)
@@ -1655,6 +1842,9 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
 		return NULL;

+	if (ca.encoding)
+		return NULL;
+
 	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
 		return NULL;

diff --git a/t/t0028-encoding.sh b/t/t0028-encoding.sh
new file mode 100755
index 0000000000..24f24f9e0d
--- /dev/null
+++ b/t/t0028-encoding.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='encoding conversion via gitattributes'
+
+. ./test-lib.sh
+
+test_expect_success 'setup test repo' '
+
+	text="hallo there!\ncan you read me?" &&
+
+	echo "*.utf16 text encoding=utf-16" >.gitattributes &&
+	printf "$text" >t.utf8.raw &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16 >t.utf16.raw &&
+	cp t.utf16.raw t.utf16 &&
+
+	git add .gitattributes t.utf16.raw t.utf16 &&
+	git commit -m initial
+'
+
+test_expect_success 'ensure UTF-8 is stored in Git' '
+	git cat-file -p :t.utf16 >t.utf16.git &&
+	test_cmp_bin t.utf8.raw t.utf16.git
+'
+
+test_expect_success 're-encode to UTF-16 on checkout' '
+	rm t.utf16 &&
+	git checkout t.utf16 &&
+	test_cmp_bin t.utf16.raw t.utf16
+'
+
+test_expect_success 'warn if an unsupported encoding is used' '
+	echo "*.garbage text encoding=garbage" >>.gitattributes &&
+	printf "garbage" >t.garbage &&
+	git add t.garbage 2>error.out &&
+	test_i18ngrep "warning: unsupported encoding" error.out &&
+
+	# cleanup
+	git reset --hard HEAD
+'
+
+test_expect_success 'fail if files with invalid encoding are added' '
+	printf "\0\0h\0a" >error.utf16 &&
+	# The test string encoding would fail
+	# test_must_fail iconv -f utf-16 -t utf-8 error.utf16 &&
+	test_must_fail git add error.utf16
+'
+
+# Some sequences might trigger errno == E2BIG in reencode_string_iconv, utf.8.
+# This would cause no error on "git add" and, consequently, the Git internal
+# UTF-8 encoded blob would contain garbage. Hence, the worktree file after a
+# checkout would contain garbage, too. This garbage would not match the file
+# that was initially added.
+test_expect_success 'fail if encoding from X to UTF-8 and back to X is not the same' '
+	printf "\xc3\x28" >error.utf16 &&
+	# The test string re-encoding would fail
+	# iconv -f utf-16 -t utf-8 error.utf16 | iconv -f utf-8 -t utf-16 &&
+	test_must_fail git add error.utf16
+'
+
+test_done

base-commit: 95ec6b1b3393eb6e26da40c565520a8db9796e9f
--
2.15.1

