Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B70C20281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbdIOTVT (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:21:19 -0400
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:62490
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751590AbdIOTVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bX12vc/HEsoVzYEuIkORVdZJuD21oWqq2LPiclMnDW4=;
 b=Qi71EpZIki2qJ9dV+reJvOvwZJ7jw80imFzAGcCXHzaIs+vceuJDGkncAm/VieycsEYNZjqiCSwoSuS7UUdA+lSLo0n5XcrsTSN0gcuDk1Lm7cPs4yNudvU88c13FAjAqJJuJ4w6rWyLbYFl90cHCqz5GoEp+HIxq4uYwruPNt4=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Fri, 15 Sep 2017 19:21:09 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v6 00/12] Fast git status via a file system watcher
Date:   Fri, 15 Sep 2017 15:20:31 -0400
Message-Id: <20170915192043.4516-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170610134026.104552-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR2201CA0010.namprd22.prod.outlook.com (10.174.119.23)
 To CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7c27b5c-c182-4ae1-71c2-08d4fc6eeed7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0469;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;3:SxO1ft8OUpsbyfkJHV7NmJVTadhIY0ozVENRpcugw7dhuq5C3vu7i9yTTBzOn2+sg4C3ObVNq7vJQVJ4ZnQAytdxHXa5JFcT7ef1610N2goFe2Dex7IWb4HS1rnKPiloYlOXieD7Q8zouEreRgR/z8wXPC3Gip7zITI8qbRH+TB/3dIt3BbzAGOoxcbm7a3IVhHQfp+46O+4tJx3kJtAPBsjAjiAZm+BHAE875/BmyEypdt2QEebEX2SgkUsuCuw;25:EXI9uA91PZGvLsgOC75FIskphGAUDDf0vbTvWE2TRUj+qVbfanMQby3IdaBc9kBNnCX5p1glb+xV5hNGWPhuNu2/2wljpbpKTK7jV9Fpx/KSqq6a2c162eh9jbLuDuhOR+XgjRSISzKKugweRvvEuyYWC9Q84Jff6OrU6qhUatSFMrp0dfINav31Eh8Ej6qyY+BFs6PfQFs7MBrU3fftY9qSArcdu2/rNsjeHwavuetW8MTzar1iezWakdhrY7bzfIIu0LWsjbO6u43yW67eoiusgG/b1ciuIe/CnuGvGZ216ExJ7wLENncp5hKUSNqWlD0gifKBkXRF1/9GuzeYpA==;31:5+9uJl7QYw29hcT0f8TMopF3J0WK2s4DBrqsH2suKnTGZ96gCpyWsreHbvKeyN1wY2YqqL1lA1ZWYFS3ZTdQ1Z8JZTtoX36A34TPjy7PYuJHvjFJc9TcaUybBQVQRInMLPf8wxS3F24bN0Wz9fCq+dGrWGoXtwLob/QhurJmMDOiU8uLhbi6GSNz2vmuc/ovAvJVTnlEUdmLcfm3bJBN+mQd2FjR/z5OEfVIUa5HJ40=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0469:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;20:F+s9ZEFRW/vHqMt4jTdgkkPGUNJ2XZp63u5IWYWOJKpAeSh+67xpEHg9mrR8xK52WiT6I1uxFzu8b6ahVNQQja35MnYjOqe1gTbPi3AxuckMhsdk7UPPQubpiCbegaNgMclbBiR8klFugMZPzmWXOdZOfDz96ZrBevJ1Rn6wKvWjFwird6QGE0cHJS8p3TiS3TTEJtAhO/6MN7UMl3ijn89ya98YDjzN8yY2T68tpqn7lgE0DRZpb9FVwFMidn5V/2206hhKj3amUFZEDyc5yyS2EfWaH0ck9TCitF6E2l92wwg5jjhvXyYHP6sLHfFWYFZfIQc0a7MpjLPh4B90vUoBl0EV5EqvmXEt97FeQ8vgF7gSlOIj8tYGOBHSNLxSKNIQh9gs7oQHCbxAXN0HG045EeP3vUVLja/+BjhrTLRc2zsfLwTh2piY7HXP/OTTUUYyge23bOFvV5ivbqwuk/xXUftjhKuemOYyV5XPeqvRV2iWqOyoJT7FOQ8qad62;4:9hqDOn7C7D9GjoYiqqLFSPZcp95fRA3eZpcZAiV0AabwwKArmpclv/XNb5pT0FU5Qj0Ma5mHIZqeqQB4jas7GgSh533dDhC9KlKmrKk250l8ynxm60KQGQB+ilfg0UpZqKixzz8OY5nuY93I0Uf8OB+8kSftvCv7Z1HQ8y/CjuVokhOi4dH0/knObfJsfSjWExItLXlXF6T/NcSWdEcKk1nVJNkBSR9k5ZdLPSKGH57DARAu0upJ9zfr29pD15MM
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR21MB0469FEB505C44714B8018460F46C0@CY4PR21MB0469.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0469;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(101416001)(4326008)(39060400002)(110136004)(34206002)(8656003)(25786009)(561924002)(97736004)(2906002)(2870700001)(2351001)(50986999)(76176999)(22452003)(50466002)(2421001)(33646002)(68736007)(36756003)(105586002)(50226002)(23676002)(2361001)(478600001)(106356001)(16526017)(1511001)(316002)(47776003)(10090500001)(5660300001)(6666003)(6506006)(2950100002)(72206003)(66066001)(6486002)(6512007)(81156014)(81166006)(6116002)(7736002)(305945005)(8936002)(8676002)(3846002)(53936002)(10290500003)(1076002)(86612001)(189998001)(8666007)(37006003)(22906009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjIxTUIwNDY5OzIzOlo0QzA4TE1NNFhYQnU2VnVmYm5NSll4QW9i?=
 =?utf-8?B?Y1ZyRHBlaUpQdFBuWkJmRnJtb3kzdy9LelViWGZjRzNNdi9QRTloc2xiSXdM?=
 =?utf-8?B?L1BicGVDVEZZcUJWNC9vSXVjQjdYQm5RNExZeUltZGhwckZYNHRITEt3VUtE?=
 =?utf-8?B?UE5pVEdzMjNwaHYzSkU3RWMzVm9HZ0tLQUtaV1p2T0NubGhKMDl2S3ZGcUR6?=
 =?utf-8?B?bmRHRVNxZ1NuUnpZbUs4Nks1MVpaUnNTMTNCMzhEVk11V3JqemlFZzJxWUo5?=
 =?utf-8?B?QmtWM1ZxaHFZN2NyWWNyV1NGODFITEhDRTRabDI0ZFpGdTk1VEQ2QlhpdEhw?=
 =?utf-8?B?a3kvYjBsbDlkQndtdEU0U09ncHFTWUtWWWtzOTBBenM0NlpFTDVFS0xCRVBi?=
 =?utf-8?B?MytWTEtJc2hCMWxrZFRIWW5LVWFFazFTeXBKNGNsUnI1WmVEeWl3bzZQMXBO?=
 =?utf-8?B?aXBScUh4N1NhalpCdnNFZEkybTZLbGJvYVJ6eWxodFl5VGdvaCtGb0twWWlS?=
 =?utf-8?B?bjgyUEJSWDUxZThxUDltMll4cy9OSTlUQWFjOUg0Q09GZFJuZFRwUnFEcFp6?=
 =?utf-8?B?WmNpUlp6THBLVTIvcXRFTlZ2SThBR2VLR3FrYUFTZEVPSXU2ekY4K1hPbmRl?=
 =?utf-8?B?NW5BTVBsaXJ2UFRLcldLRDF3NlZOTHJHa0trOUtrcEhQcktRcEpNaG1nbFk0?=
 =?utf-8?B?eERlR3RDUlpoME1uZGpiOUMzeDB3cVhlb0UvSXhPaG9tYWJmelY4aCtQTUdM?=
 =?utf-8?B?emtJQUNoYmVTN3dwb1FWU0toQU1NWXVla05NWlh6SjNrUS9XVFRqMWRVTTNy?=
 =?utf-8?B?SmVSRFR5TXBpUktlUjY2c2I0T0pIT2NHT1hTaWxiN0tnblA3UGQrOElTVlJM?=
 =?utf-8?B?Ny9WaDM1bzZjOGluaUNoWjhoKytqT01YRUpoUm52cVE2MlA3TzFEZFQ1cUFk?=
 =?utf-8?B?YVN1L2ZsMllpWkNCLzJpdU5ONERWWnNENWRoMUdxSFhFLzU1b28rckk4MVRy?=
 =?utf-8?B?dnVYUXI5OGpqM1RsOWhMd0swRkNhdE8wOWh6ZHNoby9pVzFBV2xwK3RRZ2Np?=
 =?utf-8?B?UzArOW43aGNvQjd1YXpvdXhMbWYzM0lNMlRWK3RzajUvMlFvTHdJdkhaTjhO?=
 =?utf-8?B?VzJPaGF1ZWdIMlFVOUExNnR4NWdCSFRqcGE0VENKSk8yejJKZW1mdHhoTkxH?=
 =?utf-8?B?VW9BTzByTGZseTVXNHB0VDJpMkJsQnZCdWhDM1JERHZNVjR1K0s3dlBHWkt2?=
 =?utf-8?B?YjlRMTJNMndRMEU5WWlweitMMlI4WDNVVXBtNzJ0aTdwMFowV00zTG5kUHY5?=
 =?utf-8?B?cWs1KytZN1FlanB5UjlOOVpQQlRVaGtZclFOdWRPMDUybzM2SXNsc3ljWlA0?=
 =?utf-8?B?L0RXaVRncjJtMWN4ck1zc1RxMkwvN1p5czRydUV5ay9lL1ZHQ2ZVQUthVFVY?=
 =?utf-8?B?MEhtVkE5VWdBTHQ0Z2tWMkU1aEk4OWtkWU9VNDV0UzRoSUc3NXlEOG1Ha0NE?=
 =?utf-8?B?YSszMTVZZlVBUlZnSUdZRXYwdXdmbklIZU5GWU1xc1pxMkZFaHlpZ0E0ZCta?=
 =?utf-8?B?dEhweStjdjU1RE1Sdk9SUlFIWFpQRnl3Ry9mNHE5ajR0VHlLUUZCTzN3T0tJ?=
 =?utf-8?B?bC9ZbG1ab3Bta1g5dnNtc2d2L1h1d3ZFWkJlbUhRMjJoRnZNRXV2Nmdja2lp?=
 =?utf-8?B?bG5COGhZMktCOE5mMjNQYUhiRXNUcG5vOEU4OTRwWnhmYmYxQ0dIRnZCZkdP?=
 =?utf-8?B?ckFSanFGMVNteGJVTnFBZy92S0w0bWVId2hSZ3poZTcvNFExY2RGSzhBd0ht?=
 =?utf-8?B?Y045Nzk1UUNpVnRwaE5CaGdaQ2pUSXp3OVZuMWNJVVFpTWNzRWJmT2cyN3RU?=
 =?utf-8?B?WlNLYTJGcmdaL2RMN2NVZmJXckI2YlhoQm9uNUhXTi90OHNZRXhSdE8vOHp1?=
 =?utf-8?B?Y2MyTjJJai9DbkgrcjlIZ0lyM0tzVkEwSk8wWVJobTVhSHAvTFBEaGhqekVw?=
 =?utf-8?B?Y3FjS0ZGN2p2SURQMUdwK2xMYXB4OTE3bURVa1VSU3Vkc1JUWmNjRjhlYmNv?=
 =?utf-8?B?N0dPdy9hMmp3VERtaDRIVktPOUN1NDJ1ZGt4dnJPQXFibnNJMnYwQmhVVTVq?=
 =?utf-8?B?eEE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;6:M/sLp3r6eMX6MqlC4l0i86sPEvLvl8O4is3O+EqjsY2/5Jkab7KrjOMuGMgmoVET3OmLOFdIaoG5UC5gbaGakrwClKZ7C9pLgU+Vxs9REXz8HaTYy8O96elzTrQgBalWdj6EUQK29upM6F5++tdfQUFIUNFUQUjm01m06V4LWFLJr0oRRjidHsDyfP7RjmR4Dpwg5YR46zDwA2ZlNiYdRarPPC2cJ4B4+POa0Xu9JCr8w8YlSc83ib7c94XlLKHMVfSNz08mxEacprTiEN3Oyfxt92QWgFSe4J8ecF9n64SALsP8H56Yei8q5RIAhNiEvwDcoYeZ9V3WRVWlDWMI4g==;5:Cmy+/SxjjPsb/tl752Gsru1FVIbD5ty7PA2akiAFZR/CIR7QXL3QBbA8GhrcYCuNOfNaBOQ12UfMU6GPeNAy2s5/OCSwRxfEUzwJrQ4HZeZ4+leGkKQ9Fpq0oBABTQBfOEPQzUZmLQaLXRL1xfmj9w==;24:97MnfRxeOyCSU7WMw6jpXKYBxF3LDP9rrW721DLdeG8hbNbmTVIWjmnNX1C5V+PphPJibPExm97PCYG++g35HDAgPORdqdCyD2xS1+GJbqA=;7:hnlSIkgucNP6X8kZnSlArayB9fbUFJ0EiVAwZSrHCc9rdl+am3qZrPIzkPVWE3kudl4nX2zRQRFqd2PD3kzDI1ddqptnjmS3/lhNQEQhWkx4/KA2UajztOlGxfOe1JamxbokA7S8xZjrrYhU23LEoxM5bwKrbY+AKMQ0tV1UDqUt6ZIprlV7b46YAwBXRP2ou51WFl4+4NWNDfN/ZI3SxajjZWEhJnJ5xln84MVa66Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 19:21:09.2281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a fairly significant rewrite since V5. The big changes include:

Multiple functions including preload-index(), ie_match_stat(), and
refresh_cache_ent() have been updated to honor the CE_FSMONITOR_VALID bit
following the same pattern as skip_worktree and CE_VALID.  As a result,
performance improvements apply to all git commands that would otherwise
have had to scan the entire working directory.

core.fsmonitor is now a registered command (instead of a hook) to
provide additional flexibility.  It is called when needed to ensure the
state of the index is up-to-date.

The Watchman integration script is now entirely written in perl to
minimize spawning additional helper commands.  This along with the other
changes have helped reduce the overhead and made the extension applicable
to more (ie smaller) repos.

There are additional opportunities for performance improvements but I
wanted to get this version out there and then build on it as the
foundation.  Some potential examples of future patches include:

 - call the integration script on a background thread so that it can
   execute in parallel.

 - optimize traverse trees by pruning out entire branches that do not
   contain any changes.

Other optimizations likely exist where knowledge that files have not
changed can be used to short circuit some of the normal workflow.

Performance
===========

With the various enhancements, performance has been improved especially
for smaller repos.  The included perf test compares status times without
fsmonitor to those with fsmonitor using the provided Watchman integration
script.

Due to the overhead of calling out to Watchman, on very small repos
(<10K files) the overhead exceeds the savings.  Once repos hit 10K files
the savings kick in and for repos beyond that, the savings are dramatic.

Test with 10,000 files                                           this tree
------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         0.35(0.03+0.04)
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.37(0.00+0.09)
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   0.43(0.03+0.06)
7519.6: status (fsmonitor=)                                      0.45(0.00+0.07)
7519.7: status -uno (fsmonitor=)                                 0.40(0.03+0.07)
7519.8: status -uall (fsmonitor=)                                0.44(0.04+0.04)

Test with 100,000 files                                          this tree
------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         0.33(0.01+0.03)
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.36(0.00+0.06)
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   0.93(0.00+0.07)
7519.6: status (fsmonitor=)                                      2.66(0.04+0.03)
7519.7: status -uno (fsmonitor=)                                 2.44(0.01+0.06)
7519.8: status -uall (fsmonitor=)                                2.94(0.03+0.07)

Test with 1,000,000 files                                        this tree
---------------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         1.45(0.00+0.06)
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.88(0.01+0.04)
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   6.14(0.03+0.04)
7519.6: status (fsmonitor=)                                      25.91(0.04+0.06)
7519.7: status -uno (fsmonitor=)                                 23.96(0.04+0.03)
7519.8: status -uall (fsmonitor=)                                28.81(0.00+0.07)

Note: all numbers above are with a warm disk cache on a fast SSD, real
world performance numbers are often dramatically better as fsmonitor can
eliminate all the file IO to lstat every file and then traverse the
working directory looking for untracked files.  For example, a cold
status without fsmonitor on a HDD with 1M files takes 1m22.774s

$ time git -c core.fsmonitor= status
On branch p0006-ballast

It took 2.09 seconds to enumerate untracked files. 'status -uno'
may speed it up, but you have to be careful not to forget to add
new files yourself (see 'git help status').
nothing to commit, working tree clean

real    1m22.774s
user    0m0.000s
sys     0m0.000s


Ben Peart (12):
  bswap: add 64 bit endianness helper get_be64
  preload-index: add override to enable testing preload-index
  update-index: add a new --force-write-index option
  fsmonitor: teach git to optionally utilize a file system monitor to
    speed up detecting new or changed files.
  fsmonitor: add documentation for the fsmonitor extension.
  ls-files: Add support in ls-files to display the fsmonitor valid bit
  update-index: add fsmonitor support to update-index
  fsmonitor: add a test tool to dump the index extension
  split-index: disable the fsmonitor extension when running the split
    index test
  fsmonitor: add test cases for fsmonitor extension
  fsmonitor: add a sample integration script for Watchman
  fsmonitor: add a performance test

 Documentation/config.txt                   |   6 +
 Documentation/githooks.txt                 |  23 +++
 Documentation/technical/index-format.txt   |  19 +++
 Makefile                                   |   3 +
 apply.c                                    |   2 +-
 builtin/ls-files.c                         |   8 +-
 builtin/update-index.c                     |  26 ++-
 cache.h                                    |  10 +-
 compat/bswap.h                             |  22 +++
 config.c                                   |  14 ++
 config.h                                   |   1 +
 diff-lib.c                                 |   2 +
 dir.c                                      |  27 +--
 dir.h                                      |   2 +
 entry.c                                    |   4 +-
 environment.c                              |   1 +
 fsmonitor.c                                | 253 ++++++++++++++++++++++++++++
 fsmonitor.h                                |  61 +++++++
 preload-index.c                            |   8 +-
 read-cache.c                               |  49 +++++-
 submodule.c                                |   2 +-
 t/helper/.gitignore                        |   1 +
 t/helper/test-drop-caches.c                | 161 ++++++++++++++++++
 t/helper/test-dump-fsmonitor.c             |  21 +++
 t/perf/p7519-fsmonitor.sh                  | 184 ++++++++++++++++++++
 t/t1700-split-index.sh                     |   1 +
 t/t7519-status-fsmonitor.sh                | 259 +++++++++++++++++++++++++++++
 t/t7519/fsmonitor-all                      |  23 +++
 t/t7519/fsmonitor-none                     |  21 +++
 t/t7519/fsmonitor-watchman                 | 128 ++++++++++++++
 templates/hooks--fsmonitor-watchman.sample | 119 +++++++++++++
 unpack-trees.c                             |   8 +-
 32 files changed, 1440 insertions(+), 29 deletions(-)
 create mode 100644 fsmonitor.c
 create mode 100644 fsmonitor.h
 create mode 100644 t/helper/test-drop-caches.c
 create mode 100644 t/helper/test-dump-fsmonitor.c
 create mode 100755 t/perf/p7519-fsmonitor.sh
 create mode 100755 t/t7519-status-fsmonitor.sh
 create mode 100755 t/t7519/fsmonitor-all
 create mode 100755 t/t7519/fsmonitor-none
 create mode 100755 t/t7519/fsmonitor-watchman
 create mode 100755 templates/hooks--fsmonitor-watchman.sample

-- 
2.14.1.548.ge54b1befee.dirty

