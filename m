Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5B020372
	for <e@80x24.org>; Thu, 12 Oct 2017 12:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756431AbdJLMCn (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 08:02:43 -0400
Received: from mail-by2nam03on0112.outbound.protection.outlook.com ([104.47.42.112]:13952
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755729AbdJLMCk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 08:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vvR+s2onFQG818Jkhsf8B+Eb7NIZwZJXZO2M1XaNgrU=;
 b=FLFpH0AnByt2dDURX+8NRMYrcoJbz7AUuz3aC9m0mkxsfTTaeDqgrodQ5CEuAmPJKL+QfCyW7bMtaA1vOHhL0Ectp2ZRhXr/AAusTBqgM3426B4eQpXX5VTVsnzFqdr8ua5nG6ihrawEKA0OJNRFwZRELqMx10Z/ydnF8cRgjas=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 MWHPR2101MB0729.namprd21.prod.outlook.com (2603:10b6:301:76::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.122.0; Thu, 12
 Oct 2017 12:02:37 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 0/4] Improve abbreviation disambiguation
Date:   Thu, 12 Oct 2017 08:02:16 -0400
Message-Id: <20171012120220.226427-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <61168095-d392-39d2-ba65-823525239b5c@gmail.com>
References: <61168095-d392-39d2-ba65-823525239b5c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR20CA0066.namprd20.prod.outlook.com
 (2603:10b6:404:151::28) To MWHPR2101MB0729.namprd21.prod.outlook.com
 (2603:10b6:301:76::39)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4db5dd2e-145f-44fe-cc40-08d5116921f1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603210)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR2101MB0729;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;3:5xXoGsHjAsq+kNkr0p0eslpj27opWH24z0SWTJjw9PL0pqcIl1amgt8MO3niid/s8AyTmiMK7NyEJNyEmmtjNQyTKWCuuig+zNDZTvbbZ7ELTSHALUCaKrK6m6bSEM1at99xUrKSWytqVMLRj94PNU7r6hW4ZiYX2XJX9wD/IhW7KNiyC2wKHzyAt+vfqmsjxJhJ3Iz+StRhmuNEJyJZZRNVcY0muGyCGyyxjj8aZC8Spb7NSus+csGgzZz/EwXq;25:6T2Sy+s404rH7j/TD5zJ56nfxu4sYN97kix93j53Db87vjKq+ztanceUBUE6SwMyOOBtbu9LCxQjgfUlOiZI1QTGcjZpOPI62YDnl465TIVxbTfWm+7C9Bpujio04wxqVs6rhkRbOi+7O7yGGGSYUHfUug6RYD5tv0mp6VAAOEBh9x+Jew51EDuJJgnyMzr0WYDLmybGTkfWYKBPEuRcOw55QCNfAef1FJ80NhzULSnGKHkM0ytVe0bhGHRph2qaqSPaMp3/A89e3USW58TxTsNvsuTXS7Cy40GK1HtwcVF+AQ2PZkwrWMUjCQRut4W89sTKM/H8wHd2OQJTEuzR7g==;31:856/XhiVjyo7Lgm196MXl/CNO1Y0wRb+0NtL+eMLV1FeFOWH5qKjWTXNxaoAjH8aDV/HXKdUgK1sg4OVDoqYrJjJ7RIzmdlAx4RVYk93OMoG3yDJZ0nt79q6sEEi4CIDgkJqsV88tmT9jgmPhlnlAG8+yCv4QL/3FiGd00PCeNs9Cng/3ZZtJ8YFm4ZI9XyZ//bKZgS9b6UXnbiAtvRjUD3mPSnHINmC3SAW9pFY+H4=
X-MS-TrafficTypeDiagnostic: MWHPR2101MB0729:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;20:Csu85DsHX7+D2OFcoZJTS7+gHmmO5HiAW/rnP6lhwN1pQro3Ipoe3oEJFlY4huh8A5tKqU9Ban/JaldM52P1snbqGJhegIXtcAKqwoTI6caaHCQzcMTJnOSmNArV0rmnVXjfWxoZZ/Vfu6IF2ImeBy6Y2fLJQbuJnTvwz1p1xN30YbTKcUZhHnH07LBVj0LwJo+jPgMeYhN2nnnjrBsGHYCiG/QCkyjaxHRUBJ3WwGhWqmeJ2hUjktEJvukzfA8pyk3IEhO+KqkbcJ0KWNyXKX1uusVGnlWtmGbgYuFhPTE7ZuRe5ecI1aJ/pu6eqPUe2dF8cL7qI54A9ow5wTh84fTiaF8pKvvibSHW09+Pc2nWD6p/XoIHyXmfGCoFdSNrA1HbMYuSvuppj5xGtuuzE/yh+zhQ8AfFBWsEmefef1CUl+ARP7qy0GyTFl/nZXHvs54zqohm/NFEq+33AlPeGixZjudSzU9oJguADyLM49iEia8RZIKtqnagTsP5avQh;4:Br1gxKx/4TL0TrLcGU/l7bIs1aUDUnTkxmVPcnyy5R6VDdvc87qVW5lUa1pI5G4FHCARhV9/svfts2RAS7mktY6EQtnhTPJSqxNpcwR2yw899cSi65PqG1Ew9bvHP4F/VOSexwE0l9/znThb8x0DMlxP3gAjR8PP+Fgm1bSnT8SnzqVctAZVaIgvob7N1euRCc8J3ehoi/zngGmjfO4jDjMHOcUyAvunjKXKR+ormIr7BUkt+X4Hqj3oGTwYiDFgfc+I5HhZ7rfQbDybA99efMk6CerJ/IyzPgThbOtVdew=
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-Microsoft-Antispam-PRVS: <MWHPR2101MB07299730189732748B56AB97A14B0@MWHPR2101MB0729.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(100000703101)(100105400095)(3002001)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123558100)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR2101MB0729;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR2101MB0729;
X-Forefront-PRVS: 04583CED1A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(76176999)(189998001)(1076002)(6116002)(2351001)(50986999)(105586002)(106356001)(53936002)(2361001)(10290500003)(6666003)(478600001)(25786009)(47776003)(33646002)(36756003)(305945005)(39060400002)(4326008)(101416001)(107886003)(6486002)(97736004)(22452003)(50226002)(48376002)(68736007)(7736002)(50466002)(16586007)(8656003)(5660300001)(2906002)(10090500001)(2950100002)(86612001)(81156014)(316002)(8936002)(6916009)(86362001)(81166006)(8676002)(5003940100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0729;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR2101MB0729;23:ouv8YE7xFp8PkOtM7Qy9gCOSGp9EU0Ac8O/4Yfo?=
 =?us-ascii?Q?9tWTa5dM/Irxl4f055bgaYO28IhJs67h43cpQapEje3bTJdFIq/yQ6IEjX80?=
 =?us-ascii?Q?vU5jaNvt1V25VZOOthS58CptVOTAHq4ouv2TJMZtlXchP9IMzgX5Q7it+Id5?=
 =?us-ascii?Q?JA97TroyD7MaGqsBMlw2ObwG6yjnriYQQztzBJRQJ9sRRZ4q2LlR7Temo5ho?=
 =?us-ascii?Q?FEwS5pvtrglezklM3OtOy+u4vKG2ef3br65AVYkcZKZMGhh7t02BnkFhRo2j?=
 =?us-ascii?Q?8+bWkpaakNxW1EGJp1/nzt3zsPT29iVD7bMdqCX+15qAByHAiGCOxa+XQol+?=
 =?us-ascii?Q?SRxtdw495l6IY2b/LS6sVB0t+M8n9C5r62c/DLVpm0+kJ8r1aqBHnMKBoPrP?=
 =?us-ascii?Q?DRVe3GcM3WAVF0KIt8SMSSZQYUWSZAPC6ugvBdz+TwMnV1NLZDR04t81DMm+?=
 =?us-ascii?Q?TNPY/8xvVsapQ2tnSlVGboxDTy25tIAkKusQ3gOBTGwhvGNxIaj3M04gIj8b?=
 =?us-ascii?Q?pPmYUZ2TIAXBOpNPkDrsMklLJ57QzkvUqeQqyztplGXU5U9FpJWHkfZGC3vj?=
 =?us-ascii?Q?qTK3aY2bT80FfrRsA3hUyyN21u/+4auBWBd5rh2e93bZT/tj66BTlHlqONhV?=
 =?us-ascii?Q?+EmRL/yK1rLefKblCQvK/90LTS7kPgTnMiAMFV9UcZhhHl0Bqd2x8VK9BiHk?=
 =?us-ascii?Q?1uHAJfChPu21gPJIuYJHb1c699lgExykXxfZkIbbO+FlBtcDkDp+raHUB9Q+?=
 =?us-ascii?Q?S7zHAomQVta7klPKOv17eGmB+qBFYUYZo2dBZr/eR6a+HPAcKZl7qHbMiudA?=
 =?us-ascii?Q?ibnEVSqE6LHcBK7gYv/Ni/K45Q79JZQf4ZQUHRJGehl0yReXt+0Li7I9Rk1U?=
 =?us-ascii?Q?G1HeQIfqJQoBk0UcWjyzBBEK1a6CXOuGa+O8FEHaPBguc9Oly7FuSS7NbYEw?=
 =?us-ascii?Q?tUJPlEibyiBfIi6kdHvpJVTsdZuE0bRab7tSEKLpvTqHmIF2edPXK9ACdwdR?=
 =?us-ascii?Q?8GqxSdNyzWjCw1cMA41HywGL4QPoYwk0azN/AjOZsYNuqTdc0ymuoHaY5ze6?=
 =?us-ascii?Q?YORrwPHIA9Uw+b4dphpVZfC8jdvYE6zTScE9NVNQsYWEfE4y7a2T16YA93Io?=
 =?us-ascii?Q?23v1Ckc6IJTTXfkFJVSKwL9ipVKUoTjEjgA7zumg9lvcqjOBmUv5mfPngU5Z?=
 =?us-ascii?Q?+9AhDIGPuJ0GnRmPEEO0XNkgq6uAoPHCAvZzpKNhd2J73j80IZBdtH2D2+8l?=
 =?us-ascii?Q?xZjRZGuBEpvNi9EMwYl8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;6:EPdXpnPpBI/OzoNQ/tqi0HrtTrfy4PypAJ6pnjVRwiKVmXLrlhKnyj77dDnREYQCyYn/XrBTvmRX70irTR1Sl8FCK+Ik/nbx8OpHrtr5BQsOB+Whre8Crt18eV09aLD3zj5nkwB93NDZqM7NcFWLTDHeBV5n49izXSIhdLoNguAIzJrs6uWpPh+zb0/FauV/MNHk50ri1BWknsGxXmVnrOW7y9y2JrZDOtsvzw23x/6Xy4h2h6MwIJB1CexB2eu7zwFqmAKtK2fNqwJ94CEYzt99Ml2HFQniw7myvx4lxGRySTPZ8kWEmmAcTDXpbH/P+KXRytaePKz4G55HqnBkxg==;5:KSrz2ZE8VoJJvI/0xBSfBY0tMgKm7ybZSKKzZcZJfdsvqbBgTQcJXaBp1Ie84nysRaGzgShXUw+JhKKs68x3g7jAiEnuV3p5LP4Tk8yEoedcxnWD9LH10KrNWpkqmRfeCbhHSOLzM1JXDI3gzk0JWt/iyy5q93x3Pgr2Dat4bC4=;24:N0RgDTp6/PW/tBrtsZSBjgVEyCQLVK7nMLlPrtbm1pG9Fr9kFg4CKA9i2B52mfY4lGqs7tglRLfcfIv5YohO0qHjrhjVc8i7ttlXofx+Vlc=;7:V9sUXvFRQo7q1G5Lk/o4V2e9G9O78qWKqq+nKn8yS+ZpbDJKobz2sCHN7q/Aon3Cu34e1ExQ/LZwTZmiPEulErRpdwqI5q8uQLC4sr34srvZmno38/r6aenmmw5K7YHBQIQ1sC+fBcbA3XW1BanvuFDdF8V6UAI2CctGiPhTudg6B6sAo4r6HUW6Nw8f054ZbMpa1tUDlzMYcNu0dw5+3yp8FENVhRS64b6u/OHZy8I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2017 12:02:37.4026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db5dd2e-145f-44fe-cc40-08d5116921f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0729
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since previous version:

* Make 'pos' unsigned in get_hex_char_from_oid()

* Check response from open_pack_index()

* Small typos in commit messages 

Thanks,
 Stolee

---

When displaying object ids, we frequently want to see an abbreviation
for easier typing. That abbreviation must be unambiguous among all
object ids.

The current implementation of find_unique_abbrev() performs a loop
checking if each abbreviation length is unambiguous until finding one
that works. This causes multiple round-trips to the disk when starting
with the default abbreviation length (usually 7) but needing up to 12
characters for an unambiguous short-sha. For very large repos, this
effect is pronounced and causes issues with several commands, from
obvious consumers `status` and `log` to less obvious commands such as
`fetch` and `push`.

This patch improves performance by iterating over objects matching the
short abbreviation only once, inspecting each object id, and reporting
the minimum length of an unambiguous abbreviation.

Add a new perf test for testing the performance of log while computing
OID abbreviations. Using --oneline --raw and --parents options maximizes
the number of OIDs to abbreviate while still spending some time
computing diffs. Below we report performance statistics for perf test
4211.6 from p4211-line-log.sh using three copies of the Linux repo:

| Packs | Loose  | Base Time | New Time | Rel%  |
|-------|--------|-----------|----------|-------|
|  1    |      0 |   41.27 s |  38.93 s | -4.8% |
| 24    |      0 |   98.04 s |  91.35 s | -5.7% |
| 23    | 323952 |  117.78 s | 112.18 s | -4.8% |

Derrick Stolee (4):
  p4211-line-log.sh: add log --online --raw --parents perf test
  sha1_name: unroll len loop in find_unique_abbrev_r
  sha1_name: parse less while finding common prefix
  sha1_name: minimize OID comparisons during disambiguation
 sha1_name.c              | 135 +++++++++++++++++++++++++++++++++++++++++------
 t/perf/p4211-line-log.sh |   4 ++
 2 files changed, 123 insertions(+), 16 deletions(-)

-- 
2.14.1.538.g56ec8fc98.dirty

