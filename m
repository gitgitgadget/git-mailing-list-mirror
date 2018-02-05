Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2561F404
	for <e@80x24.org>; Mon,  5 Feb 2018 19:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeBET5e (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 14:57:34 -0500
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:25556
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750964AbeBET5P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 14:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Z6pt6Y+dLKkwNUcpmTwudw0ztOz92mzetIMz332hEY8=;
 b=V21chEYZgO2nnTFXfRhcqV+B0kb98CHUTNYfFUXYkH3rPeLztZSyOD7QTCBx/vqXFl4taWbYkc1HtpoQx8KM/6f2B36sSEeV4n42BIDDS22BF4gLDcFZvFm0mgZ/rKub1oQtHyuiaHdvEp5mekR5WTnFhMZ/QL5SZi801RaowDQ=
Received: from localhost.localdomain (70.33.148.227) by
 SN6PR2101MB0910.namprd21.prod.outlook.com (2603:10b6:805:a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.506.3; Mon, 5 Feb 2018
 19:57:12 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, bmwill@google.com, avarab@gmail.com,
        benpeart@microsoft.com
Subject: [PATCH v1] dir.c: don't flag the index as dirty for changes to the untracked cache
Date:   Mon,  5 Feb 2018 14:56:19 -0500
Message-Id: <20180205195619.31064-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.15.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [70.33.148.227]
X-ClientProxiedBy: BN6PR19CA0080.namprd19.prod.outlook.com
 (2603:10b6:404:133::18) To SN6PR2101MB0910.namprd21.prod.outlook.com
 (2603:10b6:805:a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7e85bdc-4511-4e5b-7d16-08d56cd2a65e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:SN6PR2101MB0910;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR2101MB0910;3:R5AqdrjInmft3O+Epo/RS/4iYyrP4SMu7EMhipSHBndpVSnj1RLBpNihKmTuFy1CwURupltWFGfuXRjds8TaQracYQvioKU/rU2ZT82S0TpLAfdlEogm/ct+fukLSRuPBuzg540rSHmdrohS15VRirwBifaa6S3VsasTozhyBT2IvJvFUmvZTcJA0nThMelSDyihNzP1Bh7eQqBkblLVO0kqCkz8ouxav7zjuH0IuL6pahDTqmRBqUG71+EBlXAP;25:bx3AdpIHkJKFuLYy15FVpusSw/eyp7jwiArO8+25SI6f9hu8q/vNNNVayVAopNLuBAVaDf+0EOHsXbFBhJ+bdG37YeStVcByXaDoc0P/PBocD3mwTxeGGESsHXGOzYbDafHkbcaVerHBagguIbMavSWv/ke3IY6wyZMHoRLxpy7w2ZIW95Iq96O+cxSY59e/Ziix4BGWEEnDw3A7+65ohUvQalJ/ZOQx/3JrEzXSBJfy0B/7WLBn7z2F8Z+oWpz0aiJnu0hhWZX13/0ZMn+Rup9KK6lTn4cdQify2pEv3E+ER48oK4mDWSHB9zrjyZ/OMKfhtA45exGmL0PDxO4Vfw==;31:n0/45Vrdu3Vsi85xwze9sDoYPnupNKnEfS+xNLixlU2bWnlnnAWE9wDUfD3BImtOzTg6uFxDfiHa3Qjz1Oi+YY3DdOBBY5Fx6td4qo26Hd+2qDCZeXg9+hz6sI1kruTM2akozbK1QgVQUzrFSD7qSmVBrxsMjgATNDpILCfXyxeEJ51drrPL/Sd0UGoBowYIbIQ8ejV897azObSB2YX0q8amwjZPQ9bNVAFIuVoSXn0=
X-MS-TrafficTypeDiagnostic: SN6PR2101MB0910:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR2101MB0910;20:48neRIO1ncc7zjhf/om2TEx2uxqDBDqvKKigSELRrIs0U1MPpum3YR+1E8WICixLZmaAD4o5wPU5uK5OKbLuGE/3ZpCHM6y41l+kBDe/BnbbV21OT49EUkMzApJ7ZBoKlFHLH/Ybz7zS5pKVXqevIoQ492SSaDGKuUTukzUab9F1Bhw8I4KGzy8DZ7adKW25wCDTWr8CBO5rt0pxjBa69U0zmH6v2847+Dm3uj00WpTbfXJ71Rmbq+sKVrgP3swNJ6zapbDfXZTNzSfx1hLNruKbg67RzKiXuns97ozGL7FYJcFogwXw2y8DBwcgPLiintqnB6YKakLwIY1/NsH9qtFRKki/X+Uq67LPDzWyjk4CDh2YcKDY51otBAlUU9Sy1Es4SAE0jBjfyjOkvJQQMjfnyEVZONcnzX/ldyUGMw2lAB8aFFGKPqYuiPL7qY3tvMusc3xhJX2CSLEvbzN5mi39yiKs6HOR76eXGz+gWwvP6mSygZOZcs4d0wTjGuUe;4:q159XPVlL1HlRFfBQOZwYqjyYFhpyhsz2n3OMnDFhPH2EpBcypHs7yP1arSOVAuHs1CE6FfL3+9OlfFm/dbzNnkpCWfctPVpWucdvJHVGF/1AwNXwQ5AaXV+7bf8utLsYFACn2NVsf4GkhLB/T6QCxHUoSPk1IPRir9dbCYyzrpKpg8LP963ZQ6ryrNmZvKyD3OucobFDvkTEbyCKPYAjC+ubdqVcN/h1PQbg4uJQXVrxi9LiKodNt092heSYlMU8h/TWBNvQIrQMAMS4xbUrmzKN/L8mrGZktVvk/fwjjJdk8DsVP/iMAGHLu/99XkbpK14JIFr/nH7wKinMFMw4+lAHaq2aXzGT+gbWflianchkFg7xSe6JMzwfSUwgVBV04DlwnOecHT5CRm29xl7SUXRqhfeGNXFZMNDi16m3qE=
X-Microsoft-Antispam-PRVS: <SN6PR2101MB0910CE9FD03B9D6286A5B228F4FE0@SN6PR2101MB0910.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(166708455590820)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:SN6PR2101MB0910;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB0910;
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(346002)(39380400002)(396003)(39860400002)(366004)(189003)(199004)(7736002)(6306002)(305945005)(3846002)(86612001)(6486002)(6116002)(16526019)(10290500003)(105586002)(186003)(478600001)(966005)(72206003)(575784001)(386003)(51416003)(6346003)(26005)(6506007)(59450400001)(52116002)(97736004)(5660300001)(36756003)(50466002)(48376002)(81156014)(81166006)(8676002)(10090500001)(1076002)(68736007)(6916009)(25786009)(2906002)(47776003)(53936002)(22452003)(8936002)(39060400002)(4326008)(106356001)(50226002)(316002)(2351001)(66066001)(107886003)(2361001)(16586007)(6512007)(22906009)(14143004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0910;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR2101MB0910;23:ETRhL3TABsVuyhwS0w1prFBqX3pPjqTeSBcjwZf?=
 =?us-ascii?Q?6PtT3MgVMByoezsxvumqxp6QUJadboNBRI69l42RnLUwvCLq90L6rVaOYoQC?=
 =?us-ascii?Q?yQMZYZRH+SxAklCvpmZhIGfAujdzsYMPeLYQNhiDJtRBek/WvTBO5yBNpsmU?=
 =?us-ascii?Q?ff+vfX1XNokFwwMCBKNHsvykMeDaNQPa+3kzM4ext+JifWGQ4F6FlfgtNv/d?=
 =?us-ascii?Q?wT5Zm1pBoAbzfKg0vxpgwAC+qP7iJAB6INkCANLtgThLeiGGmUMGx7FKPygW?=
 =?us-ascii?Q?B3w4KvI6D29UC7FaEW3Uk7jPmPHfycLlPd8/PgjeCQwbcc1qDs556ryoACy1?=
 =?us-ascii?Q?oXFbAaBm7U74+cGsFzaw+k28q/dVLZ0KZDwBvrTCKCFUwepdjjmJMgkLDswz?=
 =?us-ascii?Q?yKXq9jbgglpcPDKQ/VJuoqIPgYnAFbv2mI1gpoOvbZ9qhzm3XEItCkNsPAkc?=
 =?us-ascii?Q?IPFIVmGqSW7uh7nuAYi6z7MayKpdXZqR3Fxw0Uwl5SPzHrf9gn+xwDe+iqCN?=
 =?us-ascii?Q?52IzeNx3vJi+zK26tGVhLZu5yVwMwrh6HTD2G8zz++dN6IEh7wtp0PHI5Czh?=
 =?us-ascii?Q?N+hVhSLYRdRs0mutPfMt+bAGyxBv3zjMf3FiwtPrfd/12cOrCqPla/cq1LgU?=
 =?us-ascii?Q?b6faWr08cvS33utkDtI/VUaG0JGTtU3CNchdEU47FtD4N+KCM+7EsTxBzH+Q?=
 =?us-ascii?Q?/ueKeAFjYjttdVXQ1AaNd/PUO01mrLdmTCJ65dhv2FX0ISiG38Nb5NoSf2YB?=
 =?us-ascii?Q?zfI33TBDaVbzpaJ5xgz3CQ4q6ggW54W7BePUHwUALpW8S6YzCkKZFBva4DaH?=
 =?us-ascii?Q?8GdsLLSzPzLCKhvxAzzrYnA7WE2c6cgKi11WEhfLDpDpnKJG16i97CtHqATs?=
 =?us-ascii?Q?BVy4LmJUmlo9PDEX+uJiGxwpgIxTWP5oa7jR2I2fxGZmITHK/V5rGXimKVdT?=
 =?us-ascii?Q?69bYa3CcNixcQkVNuhCOzNUbfOHJqQY/7n1/rAKCFzJcrkUr1UwRPBvnnmyF?=
 =?us-ascii?Q?PDiHgy7cRjErfTPNQPz5kX6diYTl42QsylGJYLapB3cJrvaAxOw9z3xEFfwh?=
 =?us-ascii?Q?vTXpZOCxPhhFOQOl7jZcl4/luCF8YfqxZdhOaNFeOiTwD9Dt1+VpvYhIgTW9?=
 =?us-ascii?Q?ZFMQsdpLeVjg+DiqfyoSnAuio6JRVRJBqcisVfAjoK/Dd69wJIk65IInMEp3?=
 =?us-ascii?Q?Gb8FDiiN8nmKQMDXG/nI+iOcoFl3n8dNjnzQ3pqNCaPk9I/BVP24seQe3vWI?=
 =?us-ascii?Q?c+EiBg2lVSAM8sn/s94t25f5QAlfXG2yFBpdnlyeR1B3mg4SCzX62oAUQSaN?=
 =?us-ascii?Q?16AWLDNIbU9ADqO5xPWljeRV10yV2HJonMsM9jCiZu5Hpt+uHT1uMp4jhNMP?=
 =?us-ascii?Q?TOm0YkVzrxlMbPRGGhNBM0Ga4IbOfeqw/JytsAlXkLyEyyaJ2?=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR2101MB0910;6:GdgC4q70+K+t3vuChnAl49rs5EaAHJI2nsOEvQ5Oc5QlI009UtxHYYLEPIE6n0XHOLb967q29zScPcpkMUcT6Q6PTlK76TiBfdT6yRodr3pWx3XiiR7ngNWlFzsmBpENuix7O6TPMmbxmv03NbDoObpv9C8+QqINgy+SBz8xLhrcosVkj1vU/kxhUCNLgm1YXU2ERuzg6t3nPFQRRYQNXQXBrcKrBXHNfou9++C5oKlpd6vQwE15mOBjEu2YscclkwQCyNguZOYDeodTTDeO1nlteGNihgKjEIm2ydq8AEFxaTH3I14etUYsgo+Ds3mYBDwPR8WCp7m+4JAa+/SmUDe449C8GJGtK3IxWb0LGKw=;5:jb607B0ZcLIFEk6SI/nlIwslwTCJnojMqdxJ6MjaZLuncGPw/OXhHR8eNmkX8que9gnv4A+K2hIEZi32qJm2aIYXL6wAehss05xbgCOVEf+JjVsu+cKxUkZP1OevDH/GI+JZqf/XKPrJHvmfgv6xrow0HtLsnbpOK11seZPE/HU=;24:xDwq/St5Al6408moqqOQDuNf1VZwRCFuZxYNH0T4jb2sS0ayGWrt0yqYQeGnQRD3gC4+gpPhOZ9yDDvcifBvgEArtC/v9rrQDpt3LReBsEo=;7:AIlseSdFOCIv8cLNI/D1G9yXY1uyxLTblcOjdz6puLlNlXBDgtRTSqEbm4wSktJWuJDa0uHpmOUD3bGaNfIZO8I1Sw3DT0pbnBdM5Mnp6JPvLIcWwmLcynKUvNEhei92V4L8wi6FnRK2P77UBDkmM7TPfMJRtam/2GGvWmD+KS5QMgcDvT9VEIV/+GdidzL7MHZVAc+w8RowmWUcRep9A1D61EpJYzmY3kVjtlQ9s5gRVprPuzQ4PTrx845mkYDQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 19:57:12.9893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e85bdc-4511-4e5b-7d16-08d56cd2a65e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0910
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The untracked cache saves its current state in the UNTR index extension.
Currently, _any_ change to that state causes the index to be flagged as dirty
and written out to disk.  Unfortunately, the cost to write out the index can
exceed the savings gained by using the untracked cache.  Since it is a cache
that can be updated from the current state of the working directory, there is
no functional requirement that the index be written out for every change to the
untracked cache.

Update the untracked cache logic so that it no longer forces the index to be
written to disk except in the case where the extension is being turned on or
off.  When some other git command requires the index to be written to disk, the
untracked cache will take advantage of that to save it's updated state as well.
This results in a performance win when looked at over common sequences of git
commands (ie such as a status followed by add, commit, etc).

After this patch, all the logic to track statistics for the untracked cache
could be removed as it is only used by debug tracing used to debug the untracked
cache.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/20c2e8d787
    Checkout: git fetch https://github.com/benpeart/git untracked-cache-v1 && git checkout 20c2e8d787

 dir.c                             | 3 ++-
 t/t7063-status-untracked-cache.sh | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 7c4b45e30e..da93374f0c 100644
--- a/dir.c
+++ b/dir.c
@@ -2297,7 +2297,8 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 				 dir->untracked->gitignore_invalidated,
 				 dir->untracked->dir_invalidated,
 				 dir->untracked->dir_opened);
-		if (dir->untracked == istate->untracked &&
+		if (getenv("GIT_TEST_UNTRACKED_CACHE") &&
+			dir->untracked == istate->untracked &&
 		    (dir->untracked->dir_opened ||
 		     dir->untracked->gitignore_invalidated ||
 		     dir->untracked->dir_invalidated))
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index e5fb892f95..6ef520e823 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -14,6 +14,9 @@ test_description='test untracked cache'
 # See <20160803174522.5571-1-pclouds@gmail.com> if you want to know
 # more.
 
+GIT_TEST_UNTRACKED_CACHE=true
+export GIT_TEST_UNTRACKED_CACHE
+
 sync_mtime () {
 	find . -type d -ls >/dev/null
 }

base-commit: 5be1f00a9a701532232f57958efab4be8c959a29
-- 
2.15.0.windows.1

