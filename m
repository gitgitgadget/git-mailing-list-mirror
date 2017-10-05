Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 724F02036B
	for <e@80x24.org>; Thu,  5 Oct 2017 10:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751536AbdJEKpo (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 06:45:44 -0400
Received: from mail-co1nam03on0138.outbound.protection.outlook.com ([104.47.40.138]:51680
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751489AbdJEKpm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 06:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3IwbSCTb/jSS6EBERE/UlHwIiq0+DaGRIsLS+SpV2wc=;
 b=BN/UUJAiM4wxP8XDdQC+rH9Ycc+1ibsv1lSl2xyANctKMBmU894DYsNIYiesxR4WTQInes6KWZGlbslQevtxPdVq88rdcBc5UU+pVWh3BkOZV2E5LODSbuQlsgyu2aYHiJJ3LtPvfW7ZL4Rv9Il0RNFmzG1oD/GPpYXyuvvQOkI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from localhost.localdomain (132.188.32.100) by
 CY4P136MB0008.NAMP136.PROD.OUTLOOK.COM (129.75.90.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Thu, 5 Oct 2017 10:45:39 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, t.gummerer@gmail.com, jrnieder@gmail.com,
        gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 0/2] fix temporary garbage in the cache entry
Date:   Thu,  5 Oct 2017 12:44:05 +0200
Message-Id: <20171005104407.65948-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.13.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: VI1PR0601CA0016.eurprd06.prod.outlook.com (10.169.128.26)
 To CY4P136MB0008.NAMP136.PROD.OUTLOOK.COM (129.75.90.87)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39aac455-f9ce-4d93-1740-08d50bde38ef
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:CY4P136MB0008;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0008;3:egbq/II/JQHqs59PB4J1HU9PuwPRe5xRinCjdAsI7s7IpAbG1tA3WQ1UsuVHPAWBUIUvoq8GUZWVhotJ1R9d9UfdP2D+zJtFVunElHLMMNgKBYUjfgfuKfu5e7zL0twyQtDKkzWtMaG1iZfzJohwHWYdEUh4Qy3x8Z/f6XzTMs+XG2xOX1ztc9l43BU1My2yJU1m+QGvC2Z7neCr2OJrQRH7ShlFJM4lkT4Y87yxAr9BgdtNEV5j4ho85Kg9u7Ka;25:C7VkwtYAa5PUDgjlnADD89gTUGupmqGcCAzEKOhjVFt2Yq3EJWkZGsHQfvfZwBsj+V1KZWuk6P0kC2olvkPkN4NXPHq7IM8Mhq6Yazsnsq7RlkJYPXJ44MGBfsqttEufjQrj5TYWIAXMHp2YKwpHheRIXxvtHMBMTZr5b+8eUymbS7uMdrLtOT8KVGMZGUAAIULV2USEfAFS+Z0OaW3TmVanZ/OqiTx4aYRyn8RBrEWUUv+RbPAaHQ2S799elHVcBeRJyVp6i2IvcuDI3c9MaIWA4rW4D23XEJp2vAATv40l0qeAyFNU8HKTLmNmj67tJRnjDKSPHF1FobSrUw7O/w==;31:Zgf0w+Qhf6+puhaTRJmKs1U11/ZOIixHjomTUdc8AUXqMrQjBBnbvhu8mX67smG/hFM8BWMJ1aCBzajCSBVSVtsNzYc65sRMFyoMRQxoUS7okl52xVTyAk/THfXXzh7+7zmNZo4KYUpAKXT9HQp+TyB3QYZXEYVbaFDMPc3wcl9R5s47aG4pnnMOClpEn/upxlEqXyFUfhPajKy/Ns95nbIlq6WiYerAq9CJwL0MO8o=
X-MS-TrafficTypeDiagnostic: CY4P136MB0008:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0008;20:9uGqXRrpw+sHo7n1OPt1TMftJ5yY4jVAl8j7ewjlYbQJmZfkhpT/n7+1me3Ajdu79is/vV0VuIf6K9LvhyQdKjV9m7Al+qXduR+xjb9hbbs7jrD5xWQ/zJDGT3wYPt0+EIdgV51oHez1UmtKN03XLC6MzfoTkLIbht1nXRcbBW+QvtUWeX4zohp7g9dMVS2iL0jSP+NJWCbBnilHiXfG8xDBI33562K/4KpfWpXWCLACIuYoT+3AzlMuPiMiuUGeDVxPoUzqTWex5kWfDT2j3kXCh0dmp1xEJhbKBlq3g36DAl6MwJPZDQ+EkkAu1urHcypEnZgwky5imD/d4JHazxzc8bMHDO99lGlhgYlgl/ulPwaCGzKvpgqynf0BK8ZODthlHbYL0i0tiH7y0XoMp70Hd3jeUzmHnCH8j84R5J2z/RPwN3zCEAqtenbyZPngV4BhFbj8i7Xp7Gosk6IVZ2DtsZxW/ZD1lPSGzPkXxd4YNM3FgGOFAtN7nT+234Tx;4:s2241corFrrr43bnhzfaemn4Db71LwacMQzxaaI1I7m31Hf3NleQS40K93zvrUxC7fOAvBrMIpCetMPiaxrPWr5ZeewOxDA1IkW5AR2mroUjidoCUkjQY18+v313tvUBNMcHpURdXXy7uaeRDqe+hyWbyds6ysrOaPSf6aT2yOWyu3J02RCqTPFpkMbCVDcfCaCRa/Jkig47/TFMPM1opGUEiXmUQLtA+vW9S9cNbXqoJFWnPPsq/JBqGXjIWMYxTdqHIoP+LSqrdEksZq83sK6HKe2iRT0IKUjGQliL+Tk=
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-Microsoft-Antispam-PRVS: <CY4P136MB0008230F0FE7738A2B626204E8700@CY4P136MB0008.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4P136MB0008;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4P136MB0008;
X-Forefront-PRVS: 04519BA941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(6069001)(376002)(39860400002)(346002)(199003)(189002)(16586007)(2361001)(4326008)(105586002)(25786009)(81166006)(6916009)(48376002)(68736007)(7736002)(316002)(39060400002)(2351001)(66066001)(97736004)(50226002)(3846002)(6486002)(6116002)(33646002)(6306002)(305945005)(47776003)(966005)(106356001)(50466002)(36756003)(8676002)(81156014)(6666003)(9686003)(2906002)(6512007)(86362001)(53936002)(189998001)(5660300001)(8656003)(1076002)(85782001)(478600001)(101416001)(50986999)(5003940100001)(16526018)(8936002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0008;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0008;23:2J9/8tytZd7KJYyLCn1l3O9tzZoL3pq1KfA6Z17Ao?=
 =?us-ascii?Q?6iYK6h9IRrA0TRqQ2L3HuS0MAIeNGLwvGoOZyVtwTn3C0575gp9SBC3/IkWR?=
 =?us-ascii?Q?/ixT1c4KtUUyTg3EkgsnIcM+jz6pUmG/bxFNjEYu91R232Rq4QOD0X2Vv71U?=
 =?us-ascii?Q?gj3/GO+fEkZNz0InZeBceigf+QITJk/PfIM0IhTM2Tvm366vNSL9r1PCD9Cl?=
 =?us-ascii?Q?sHTWYxB8I3jqwVSIOZVQ2LVdp9F1tmM+W3DSAeLQWKZXmvlUekzacJhXyVHj?=
 =?us-ascii?Q?zltq39LFb0lstZiK4yvQ4V1BU3thqAzPGMGcgH7Ug2NARWNkewTjkEyfBgWz?=
 =?us-ascii?Q?/ezidRu4htbvl4fUw8zCWhVxnFrmgDjQbUU4wBuw+vHFWfL8rEFerSgDLF8v?=
 =?us-ascii?Q?8qFLtiN6LnDhYuOD2Hah/sZQcIGFfWDxQk+++RJfTYnvjeHgiJcTeu5m55U/?=
 =?us-ascii?Q?oJb4VNVxeQ37SsPxJYE+nlZaKeiY2YOiKppHZrbsSYjvYFnDH8zSOvsWRtpp?=
 =?us-ascii?Q?1yFkbzVM/ydYA3o+LvWjM91Jl+fdCVPtSmYKKKsxUND3E/ce1nxQhORXgGe+?=
 =?us-ascii?Q?QdDR8jSByc4cKab3kn46BiPjirQRFxTKjmWtko7sowiKksNGwjboMSdMXYUH?=
 =?us-ascii?Q?Jq6fxYffgTUEc5Yd9yzqf1EiwPEziOW2kaimyOm9t8tOR64dz112Fq+RgJqW?=
 =?us-ascii?Q?b5t6nv0a/CQSRp04YkWA9OISaDDs/8HQChgT0gi/S+kyIprZ9WjtDieIGs6H?=
 =?us-ascii?Q?KoD0M/2rvV8nqQh8F1LXj83truPmJcbYtrX+FjB4YBaHdY0easdbVKGvVGsV?=
 =?us-ascii?Q?SB39pLPjvyHXLwITq7mYrtKitZtqGMu0lKiLQF+3ydVSumo/NMuyeeyq5AFG?=
 =?us-ascii?Q?yAHIQGr3YKBJQ47OcvkK32W4PUVVIirhlIOF7B1MpWqQmiGczSB1b0vlvXfI?=
 =?us-ascii?Q?W2FuWwRHT1lCqfzj3IL+cAScs3TXGkOdLAk2UCQl+dGvDb4uQOWlGigbFA7B?=
 =?us-ascii?Q?yFw1e7fHSQG/um0ySMbmexF+fNKNBv9XCGyu22eXCwzQbTD5my3GRimgUjHW?=
 =?us-ascii?Q?TI6zl7TZq2ddeYfi6mUnS3Ew3Xbdpk+vMbi7XeO6E80Qoh3r6VUjWC1ugNeA?=
 =?us-ascii?Q?uyqxHSx4e/8HfTybp2Av73vSXEcFkZe7SRhRV1Z0nr2OkYoYs50xeSQUBBod?=
 =?us-ascii?Q?ZXKm80F4s2Wm13uMY5YbNn/ZFhWB0SAtwZpjjWEDl7WvglvyV+2FuJv6G5ES?=
 =?us-ascii?Q?i9SMUXUBZ9HVB41eLU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0008;6:Ig0/0DLI4elKMgAvBzb0vVOxyfLtNLH59mQ4GfA4B4yrJWwL4ZILBMUFCD9oAuNh1X+O2FA0Z7GjK7HrOlO/U6etpAaJuehYUtCwYcLrybaDlcFsiFGkdLb6/k90XgIDRN47evlRO3E7ugwKFgdCu+4xphL+w2iNvjLsk3tOz7ISVCWm2wr/PZh/f5F7Z2qxmm7OR+a5WP3jUjc6vNEmpH1/M5eozdUNF1G1DgMqOgkz1GNeij8xyUqIV93+i50mNfl4Zd9yoFenC/uPrqyg2KWyFkUXWNPCSO7VEx4qO3HM5yWZsHxh8zlUq+IBf2fbG/N6sRZU3m9oKDZqF57eRA==;5:F5VM4INSVky+EAyzr4oox6SSWyXpRVUfqlK1ldYRgCSeY53L8HGE862WrwGSBRSlX4aMZMysC0CZTKUHpjcridnqMwfg+Z8MzAcG2uteAEO2Qh/YqdRHr6Yig8e5mZdv2xODYGMQ0dCdlYjop10/7Q==;24:b7HYi61s6g8YrDCkPq3jEjlyxoAT35xGA4UQuVDjSAM5Ix+gZyHot0B46uF4dUCq7weqhZUhVoKFBbh8az2kB/HtE14dfxi/YBxTvW320J8=;7:0hR2pIERaDClhtfbYmbA/myFuWuj6K7921unFB4KUb6yIyoycE2ePKfmvqJV0yg988+t7PRvdIG7UycUxllqHlL7EjgXxQP7SltMgSwxT5um1QY/IP+u2n2fvyjrrzbwfOCsS5sCvv5r3V5KJYbRlY1siTlfASD9QDHvVgmzrozP602VYfjOD8c2xMqjb6bSiv4jMoCbsTwEb54hP5Og9Omm5l0bAP03Oe2wZxwIbrE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0008;20:rpQaWaYupybF3pUODHP1Du3imMHgF0l5HaTKSkD5WMr7QDUXf4iQy7Pq7AfJijRBFimaIJ+Hh6nlYSxJ0PPADe+bweRyl0AEwcnp007SkP65nFB5lsrTcTQjxg/UmMpAWG5wqpdHdoN8RGqdDQX/hfxXbFEUqoiM7YX0UEISF1U=
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2017 10:45:39.2693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0008
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

in [1] Peff noticed that the delayed filter mechanism causes garbage
in the cache entry for a brief moment during a delayed checkout process.

The first patch fixes this issue. The second patch ensures that we don't
write garbage in that way to the cache entry caused by any other unknown
or external reason ever again.

Please review carefully in case I overlooked some unintended side
effect.

Thank you,
Lars

[1] https://public-inbox.org/git/20171005034632.kzsspk7wsuk23kf2@sigill.intra.peff.net/



Base Ref: v2.15.0-rc0
Web-Diff: https://github.com/larsxschneider/git/commit/d6fff1a941
Checkout: git fetch https://github.com/larsxschneider/git filter-process/fix-cache-entry-v1 && git checkout d6fff1a941

Lars Schneider (2):
  entry.c: update cache entry only for existing files
  entry.c: check if file exists after checkout

 entry.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


base-commit: 217f2767cbcb562872437eed4dec62e00846d90c
--
2.14.2

