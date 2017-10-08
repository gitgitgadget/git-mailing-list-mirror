Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CC3F1FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 18:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753564AbdJHSuD (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 14:50:03 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:22725
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753543AbdJHSuB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 14:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YJ40VNgcBAH5qefwDwimWsvzei2fCA+4kKzw7f6gBI4=;
 b=WEUGVBmSRa9LIlX6ga9/nvVKpctmj6wMAesDipfi4xjbs+FLwRx3G7zaN7aLG4tpGnzb4wISHDJ0r9GAC/MOzYw5QshZiZn9BCDq/+n7D4A0kDVb7941gT6KRa3Kc312TIpvUncht/suZq8l8Y6yoFcsLljSKjkni5khZ6cOJGI=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 SN4PR2101MB0734.namprd21.prod.outlook.com (2603:10b6:803:51::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.122.0; Sun, 8 Oct
 2017 18:49:58 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 1/4] p4211-line-log.sh: add log --online --raw --parents perf test
Date:   Sun,  8 Oct 2017 14:49:39 -0400
Message-Id: <20171008184942.69444-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20171008184942.69444-1-dstolee@microsoft.com>
References: <20171008184942.69444-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:404:10a::20) To SN4PR2101MB0734.namprd21.prod.outlook.com
 (2603:10b6:803:51::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbf33bc5-790b-4eb8-f6db-08d50e7d6013
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR2101MB0734;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;3:WfqW4QlF4iKo3o9TIw88Z6o/v5D0KakscQNxFDVZGg8aDoocZr88yvLB9AKKoZFJAUInUPE18iGj0AdLg89NVWFgt3PyIdp452wKUgS2eIfdNyBwpgiq/6CEfRlBI6vAo85leeVp+rYtNCNmddngjrvYLlkapl9AnHaHkW44ACxmxPEvfIdBRJITC6B7ITgD3O7+8i+4gxiqcJmxnCfIX53jRCWeEeE3gwfjP6UhRqWVXFw7QmUOTPa2xzy24bcV;25:4IDD9eeiew6Ypql4x00AZpCYd2YSSqJWtOjPQZivu2cncFHtn2FnEPicECDdvptJUIh3zF2jhBnrW/kQ3inAtJA2DIeIe9TifC5z/Ds7QWAtj9DSmKEvwlM6bvm8uL5IHADWmh6mzeKaTXMxBxqtymTa4ywe4DmiM+0pLRg6dB1490iFGWpcHbhKE/zQ5gqv8H4LPSpJ1uLD9YaIDZD/1EB64cbCZ0q87pVqVKJDB38oBqYLCC2TS1SmkaY1zjcyFKiIKYFOXtbOrQott153Et0Vb3WcaZNTsXMsJnMp1kp5t7gLVeYAaiz7ZiucwRmJ1JF2xYKaX/S3bzASDeI8Pw==;31:23+53cZEjjF+q7/ZSrxgZBr225pTUpSME29frP1LcAv8vCskxh1bNnft5FvdUhFYNm6QZHJbuBl3IlpF8Q0bjIX+tj4XDFGYLczAQCbq5194rjrqFMYdICCVy16Ho2gQO/1yZZWEzSxiazV7EPDUQOZHVeukEpBX9W8lBpS8GxHJi4k8Sxtf+iqoWzWH0d8WU5fIFw3CP3PYmObhBrEtmL76PiUYCYtaa+XsYow3NLg=
X-MS-TrafficTypeDiagnostic: SN4PR2101MB0734:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;20:2P3zLNl6ZyRu7f93Biugd/gz11bkHLfatxI8t0YB1YyjhcnOouT/bWbZBpOWP0uyDJemA5aWj2IttZbtWX+61hPGBaj3TY8TR7/HkrqekUeLB2nysslJYIDoO+09ogIQwo2jdmbxf5jEyjkdX36Wjaa6uw94aL0LfVnx+YHRuCeHruEuNHcfTuh9XjszTx7IjfG3rJWBQonvB7ih8lEOaP50oaIcnu3wPqC0GuJToGvvQO1fZ4EwGda4HjfnDZYzkOYcW0o1EgssivS2kK1CvSjcqbfli0Kb7XyeXkmyycHi/P6kQ78dIW5NJ4tEYP3kJ0zWV09GvwfMEtlZqFkQ8BAalbhyj0lMPK2EvKSJUW/HXrcZkRW8DT/nrZ954oqbFBm2PHqtgENJkKz1zgQ9mXMcWNF3WVY90Gkzu5R0u1ySohMKDg17rW84NzDsnAc/7ilH07/7fWFgdykjD/KkiDCSDiRpAZeHj70Hiz0xYJwVX8RQ3jjIieEFQ6y6iG3d;4:bTrli28tJF9zrjAivFvXwmidfVCzarpHctSnAqxZzpd5jHMH3tUK5SM0WXp1Yar7NDCqMy5QlVV8/IkHtJECKY3tEIksL3l8ao1+BSRwvZzfpHG6oWkTYQZM45c7AOOqNWk6GtLND+0hUZZDFWP2WF1VThNkDEf/B4lK3XnAfiJqMUbuUX638U/GvA6HMjAczk/RJQS0zNf+GZonOYI12tCzE6BysstzSMHqwnsEOnZyRLBASElzKedQLkbu57Z6TpVTB7RBJoUKe2/2vV/Eb+2nBgeM3W5nIIvxID0V7dA=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <SN4PR2101MB073458FE4AA69C4617AE0B17A1770@SN4PR2101MB0734.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(12181511122)(6055026)(61426038)(61427038)(6041248)(20161123555025)(20161123562025)(20161123560025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR2101MB0734;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR2101MB0734;
X-Forefront-PRVS: 0454444834
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(376002)(346002)(39860400002)(47760400005)(199003)(189002)(6116002)(6666003)(33646002)(2361001)(81166006)(81156014)(47776003)(6916009)(8936002)(2950100002)(50226002)(8676002)(97736004)(48376002)(50466002)(2351001)(1076002)(22452003)(10090500001)(189998001)(25786009)(16586007)(86612001)(53936002)(575784001)(316002)(4326008)(5003940100001)(36756003)(39060400002)(107886003)(68736007)(6486002)(106356001)(10290500003)(5660300001)(76176999)(2906002)(8656003)(105586002)(86362001)(50986999)(478600001)(101416001)(305945005)(230783001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0734;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR2101MB0734;23:Y6hjcpzjy2OiGYfhg5ygn2SGy9gEASOzHkSLAjl?=
 =?us-ascii?Q?1XUqQaNUrbZd0czRQqVxFNxHM5w9BvX78mcj2bgcU/X1bSZ2lTWUMlRZjJFl?=
 =?us-ascii?Q?tFFmQefGpoAzHdplQNSV+wuU4Uf/2P9nJx5UBF3nm7R6fCUyXIX0wznfUCLb?=
 =?us-ascii?Q?6QrEVx1Pwsn+2/Ls6paB3Jbb4MuTVbMObE+plwHzQXKDm56BkAiJbnWyMSit?=
 =?us-ascii?Q?rc3VmCH/BPXn4Sig5vA8vgcSnmXo77xdYGH6xRqcLgJjgSIxV08D98GoDojn?=
 =?us-ascii?Q?bIhsze95GSbLTz0mKeLpJ9TDWABnEXI8UFEk9kNK+1doOE9J3Mgug9wILTYY?=
 =?us-ascii?Q?pl9qoKxEL1Ttkbffiex8UdqxfLjAcdI/K5Ca0ymXAs/S6FsVcBchuSJZs2mc?=
 =?us-ascii?Q?4Jo1EZ6E0IYVAAepLK49VRka9yGUoOnBsMYLl1jbE/Ky7rcfi29VUgP+jQ3Z?=
 =?us-ascii?Q?UlDf/egpDlznzbBT1o0mS7aLTq9XkAa8UZ6zL4V2l0JAm0JgIrJzIroFBpiF?=
 =?us-ascii?Q?+nPDHGtwMy5BO2XYyKfpqVTaPFa3jPOX5XUaDFHIgsh9oZ0WBEBthZ1BWZKF?=
 =?us-ascii?Q?ysZ1j+FIj2t6nNnJpv1BNJThqOz7I9t8lb+TUsBe/PCZHLuuQIqaIdtBZLZy?=
 =?us-ascii?Q?apKPQD57URtmybiAO5JASsYp4cY4KNCWLbI0jVFBg6cJ0/Jbdbos6h4VQ0kQ?=
 =?us-ascii?Q?JkUXp7QcolEIs2xt1FM1/2HkqZiYPiBJYu7NPzQRovjPFMvVjUEasQmsaRb/?=
 =?us-ascii?Q?GL6rUG45kq9pojKA4HAvWjyxQOQs/gdadciycdDZD0ziJEXC/irxdZob6U/o?=
 =?us-ascii?Q?/5tKiALxUD3lTiUd8vkBV6nOflX0Js3nqw1ts66bsPBv2YuHtjw64AsZBXC3?=
 =?us-ascii?Q?LLU1EScYPmcg0kJUJvbOwc6siqUNoEnddH70YaycdsRSYYgRGbHzDiDX/So5?=
 =?us-ascii?Q?/li7J5LzJXO0PjQp4Nf/AQ9FZ2rWMyBP7nF6idwYLjsAWC7OrdngRBZQU+cN?=
 =?us-ascii?Q?j96BhT2av5FP2v4qo1tEsxaq0abZvkZS28WJFN8dUJg7G7udf2bV+oIJe2ry?=
 =?us-ascii?Q?1bjBTVxAVzw9z41Z/PFXZZb6VniGvEgHaLtA6C3hdfaHZRFIVyNQkyoUvU2G?=
 =?us-ascii?Q?8EDMD26gM3rwSr1KXs6Px0XjsK6zWGBYD1ZR1PGLWgUMCn9k8m07i5HfKNOz?=
 =?us-ascii?Q?ZX48Vw8QpLbwGtlasVBHzIpi1WWsBaZQVJat8jEeV+w7XDh9skGpQAF4lMBe?=
 =?us-ascii?Q?DTWTjLUj02xDf6uHedJg33r8dqU77/woNqEC1JMQPeEqsAAe71BDXbrIbuUi?=
 =?us-ascii?Q?bEA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;6:9+yXe47rsaDcUOAGGiRAdsPB71uEf3WMtLtOc2SMSsU4KBrPORRGlsLVMvCAS+EMlSJH8YXjsSn3f9OWoGMyNHZcdWQurK7cDXjuSG70n4bk0GX6ttPFT9eKGG5pAk6DZeU26y2M+N+xuXQ6Jt9xCqiem3H7BfR1VgwEBfQavU3ZFYm6M22qNV1xPL85ZfihwNe7EHZoYPFs8C/qNSbs+dpkj2SSqYzoarZB9E7HmsoKz/It25qD6bk6L9c71msr8YM7MFYEoVcNVJ+DL3uqknhheXjrHepm7Ht2qbjqS9JCbL6USHuxUyM9J6WYf8Tf4BAC5PxFoYlpjwb3b3j2Ig==;5:uHkRV0oQv08861cU2tPdipP6p6YxRe+A94XitOmpfRhRod5NqOweYTAF+J2q7g6oPX+pM0XETQuH1ot2R8cPlDODZJFstryRHUiAEn3uTWb1tPmM7eRJk1+2EKu8fkGmYvjLh0h5/4x9CUMBDBhluQ==;24:r8mTot9F1D8TT/uQn8ksYYOxTo6UZ/62vXWu5Qhj4BD9y6KxL/3R0uhcfaY3mfn4I7TuSIi8xJcS+Pf3YeSxHxN0LtI89WOO/TLUpK+v9ek=;7:U6r+Hxk/03IQ+gIGCXvtoqey9QeLzDS2pX1oybVeRdCr0bW+V5w0DHLNdiT0Re8pDiYdO/Zpc//Y6U2jpzlgntCujJ4J/r85V3A55MU5Ckm/Q1cehq6WgbR4yycOwImc6LadiUjBc5H7N1vNQs/XrqCQi0HvtW7h2KeRwRS7PuwoeBDF36Ph2HV00aSGPBzfp1Zdhn6B75/oELCDo9wIr/VgPyvBMCIm9voq0c+qENY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2017 18:49:58.2633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf33bc5-790b-4eb8-f6db-08d50e7d6013
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0734
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new perf test for testing the performance of log while computing
OID abbreviations. Using --oneline --raw and --parents options maximizes
the number of OIDs to abbreviate while still spending some time computing
diffs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/perf/p4211-line-log.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/perf/p4211-line-log.sh b/t/perf/p4211-line-log.sh
index b7ff68d4f..e0ed05907 100755
--- a/t/perf/p4211-line-log.sh
+++ b/t/perf/p4211-line-log.sh
@@ -31,4 +31,8 @@ test_perf 'git log -L (renames on)' '
 	git log -M -L 1:"$file" >/dev/null
 '
 
+test_perf 'git log --oneline --raw --parents' '
+	git log --oneline --raw --parents >/dev/null
+'
+
 test_done
-- 
2.14.1.538.g56ec8fc98.dirty

