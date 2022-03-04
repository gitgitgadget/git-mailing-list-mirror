Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A158DC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 08:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiCDI6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 03:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiCDI6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 03:58:12 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A7119E0B5
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 00:57:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjEbW6ua5eKFvmklPkrOG35h6jXYbnIb2uqwmflQm/QT3U84973aS+HBPBS1STYxC1wHlDCGe+eBmU8UnEwAav1zgZ13oRSK4HLq65C5pbhiflYR+N1h5DFaXTcHiEXLJIHfjLpIojMOb7CHhcL/NCZFBt2jhrSkOIDJAfsGuyKtXqwYG3YsnPOkvju77xkMTQ/ShfRoOWH/iBgpwIs6ZV3CHh3ZzBr2pduTiAtmQ/RiIKR+lDLJxqd8nzj6AMCm3cgBv5DXKCxCcwfLENmQzohLvS+MF8McCzbEKh8Xk2Kt6ROcZKvosLW0kGUbce4lmqaczD1hIF2a+IKiqQ4DjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PE8SLhSkRYeFODjReGASpJOTzY8Z5tSC1UHiyk9Ogc=;
 b=YRX0dh66CU6KtkjfZqvoc5j3C4+C7xacdo8NNwkFpF/zZSZd4h+kzYzMlhVzh5z3sDGtALHq054nwRUhKz9SO93+Fhmp37B11wsKY0LcPqKmmLd+gQGqmzBbqcaVaig7hCNsq8+YTeXMlBGF2OBJdtUhjgNa8ln2JfIUzOD34SF2d2C+Uw+CvD+jJXp7KuHZQMbdEGNrJeEMt73kEwNM/5jvT9o4lLnZNHo4VgkIbQf4zqnr/JG/yrPCaUh6NzEJaryr+Tkem0dFRRxBsq4I0TVHrBD6Sxesy2MS94z3n52z7mC6rGW29/YGMrtv/J2t4hvRh09MYXiH/JfJvL+vRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PE8SLhSkRYeFODjReGASpJOTzY8Z5tSC1UHiyk9Ogc=;
 b=guOGPnWcWTTHjMEgUGuj+ij3PtFgJLnbsWwAW879nNl7ZbPgI9KbMXq0oaKk+8f2Ck0EBDxEknL1kJeD7BNXWDsiZMmr9Owc2mXRDdIH51CxfFwXnCnzHtkhbuT77e0ixbWGje412utZG3uTIx2yDQ0HJYTKaf1SZUJUIVmdJYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by VE1PR10MB2893.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 4 Mar
 2022 08:57:20 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba%8]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 08:57:20 +0000
Date:   Fri, 4 Mar 2022 09:57:19 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        J Smith <dark.panda@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Tests in t4202 are aborted early, was: Re: [PATCH v3 2/7] log
Message-ID: <20220304085719.yht6hiuybhgfd6vo@fs>
tests:  check if grep_config() is called by "log"-like cmds
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
 <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
 <patch-v3-2.7-ec8e42ced1a-20211129T143956Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-2.7-ec8e42ced1a-20211129T143956Z-avarab@gmail.com>
X-ClientProxiedBy: AM6P192CA0097.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::38) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19c711fb-6f8f-41e5-3eb8-08d9fdbcfdc7
X-MS-TrafficTypeDiagnostic: VE1PR10MB2893:EE_
X-Microsoft-Antispam-PRVS: <VE1PR10MB289380B5F0B1EAA2F4D720BAB6059@VE1PR10MB2893.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9LzUkHZs1l7umqqjB+8W+gCAc0+Ix51A5Xgl5VA+A6VmQly6NS1LaBabKzWC1i1wMQhTtc7i50b5Wv99AGdj6brRIhoiLsEe9fH2EsCw40jgPET9GdkmBbj26rAsHdwSXsAiokkkym7nQ1ssApSg2Dkka7/6MkiKn3/fwOocrArL9v8eHzBMcMXzFv8XY/VmJTsJttrSy4RqdxLpndNSxLRpjtCaw+1RByUtMjdIHMQdrkZUDAfloRdeTHZZ8ahclPZPp04fmAxiowaZa9dGX2Y41muNdX3kuAsS05wSKman6OlzVUDyADAGmZxOYNo2V/fRXYLg72oGTSyK0hJ2z04hYAGGwJ3autGLhcbCGuuB9H56xwN05Ozusffm0e+gd2/KbcT+rBlyEWJM8SZRMGfNk1B5RId58P6DOResAFyGoRKY0TTuQgWdlRWnwcAgDdErEXTgHlSV23sONnTlM6rPaExtc84eEuiMhfGau5KY7NwKirXPDy/74PZ9k6h2Q/27LN9rtSQD/FyLAntWapSkYqaIBiWoilBIQeOzHEUFdSlxOj3910KdehjZhl6CoMC4bzC5L5+TgZHhnmIsbJziYaudvKD6u2lHta4F2KSWqie2JG5L8dO8RVegSWaR2V782s6ofIEJvpwaubAxiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(346002)(39830400003)(396003)(136003)(366004)(376002)(26005)(1076003)(186003)(5660300002)(6512007)(8936002)(33716001)(508600001)(2906002)(4326008)(53546011)(6506007)(6486002)(8676002)(66476007)(66556008)(66946007)(316002)(54906003)(6916009)(9686003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXVDU2RadzBVNi9wU0JVR3UxTDdoalAxMjlveUdDQmhqam5JeEhrblN2dDJw?=
 =?utf-8?B?enpiUnpXUjdWRlhhL3QyZWN2b2xwRXNWMnA0WWRXeG1IaFBLY0hRWC9jcVkv?=
 =?utf-8?B?OXlCMEtEcC8wcGdLY1ZqVGF5NkRrM25aa252bit4eDdKdTNlT0V6Qm13a2xY?=
 =?utf-8?B?dmNxRGxFSEFjdHBFbXFCdlpXeGVEZGdXTkhPWW45MUF3R1pRTFZ6M2UwMTl4?=
 =?utf-8?B?Mm56Y2JibEplV1ZpZm9PeEk4ZXEvY2RNY1psYlovSFUrNVhTSnU4dE1keW5S?=
 =?utf-8?B?R1BXblBna2FkVmdyQU5kMDBYUUFTVWJKVjNrL0NpZzVUblZvRXp6Ym5wMVl1?=
 =?utf-8?B?OFJRYjREb2JwYlFvckkzOXhORERxb2tieUJkYXlyR0tLQ3NLdk1pU25hcXYr?=
 =?utf-8?B?ZUJ5YjhzUEF0TlI4MUQ5eS90ME00bmJYWkxrbVdjUkZuZXAyRFFyTmdnRmhs?=
 =?utf-8?B?b3JndVRYbXFPd0h5dGdpQ2dpcWN3WkxEeTBRNVBuL1g0QzA4d1lmbXBhYXN1?=
 =?utf-8?B?cUlVcjM5MmZURkRLbnIwekxPSzJVT0NHNzFsZWQzeDQ3VnNHbTBzWmxqQ29w?=
 =?utf-8?B?TWJoZTNIRW43V091VFFWSXRnSm9XYWZ4NTZGTlZvSDJ3SUFxaHNNd3k4U284?=
 =?utf-8?B?VXk0dXQvRk45VXB1TytuclZLWWpUbEtDZEVHYzgvNWJpVDk2dFl6VDJpZDNH?=
 =?utf-8?B?ZEg3bzd6Rm91c0k3dEJlVVpNVDR5V1k3WGdVQ3ZQb2w1VWF0NE9QM2RzcCt4?=
 =?utf-8?B?NkNnb3RYL25yRlZzdVE0bEZUN1FtaWVqMmhHMzV5aFh2T3pHdktJWVAyalBq?=
 =?utf-8?B?ZGwvQjJaUVBzMWNiWDI4aUN0cWhJUDIzTGovWHRZdTBWMkVPWkMreVBBUWtE?=
 =?utf-8?B?aW1zMmpBWFJRRUpqNVdXL1BHTTVCVm9mWlBQN2krRUU2WGkvbTE4VXBkTUZj?=
 =?utf-8?B?am10ZWxPVmNIUnpDL1VmTEFYTzUwN1VTV0w4WDJqdTFNcUhLZkw5SFdMZjh2?=
 =?utf-8?B?Zlo1aVJxazNEZ2oxa3UwTVZROEFOY1l1S25Mblp2UkNHNCtUaTROSmVRdHV5?=
 =?utf-8?B?SHp1TXlkS3J5K2dlQWtXU25rOWw0cklVa2xWRUl5K3pGbHprc2xZSCtLTHF2?=
 =?utf-8?B?YWJlWExla1RlYzVzU1JtNkY2aG42RkhOWjFzRFNKMFB0ZmpKdklSRHZRWktV?=
 =?utf-8?B?WUFRQ2dyMlZiQ3JEOWVhVmgrL0J5NkhhSmNiZjFOTC9GWTBMRmJYdGZlbjVu?=
 =?utf-8?B?N0JCU3V6ZXVKTzlCdHRlZ0JkM3EzeE9xZmlrN2JZY2xZQnJkbWx0cFJQQWg5?=
 =?utf-8?B?S1FRVytQT2tSSk1weXFIL2ZIdExLWXhWY0dYMEZRZC9lOFdQeUpkTHRtQy9Z?=
 =?utf-8?B?eHFGTWJzejYrSy9BS09VUHNybE1jdHpSYmlhWXZaM2I5NjR0Q1ZuWnJRWTZa?=
 =?utf-8?B?dlE0T2VIZ0pRN2RGVU1jOEpYTEkrdnlLS0IwVjA4anJEL0VHS2MzY1ltNDFE?=
 =?utf-8?B?MzNmOU1HaXNPVjdSSTlqZWt1a0svSzFkVi9mcE5McXdLRjRaRkVIQlJHUzFG?=
 =?utf-8?B?TGcwaEZlQnpVSWIvd0pJQnNocm5Odk5URTdqRC92SUdUcHRGYUYyNWMydk95?=
 =?utf-8?B?NXF2S3JaenVUVGZEMVJ5UmJyajNKcTJXYTJrOGQ3RzFKbjh4cUIvNmRrZXd3?=
 =?utf-8?B?S1pNeVY3OXJqVXNZSjEzSmZPb01SWkRCSG9qYmlvRVMwK3grV3V3L09TSzR6?=
 =?utf-8?B?WG1IMHlMTkRXWWpEaHhwTmZsNlVEY0g5RFlOOGdaa1hnajJhT3dWQmkrTUh3?=
 =?utf-8?B?WkpZbHVxM1pEZmIybmJYR0pPOTBLWHRLWC9tOHZRVDdGWEpEYjIrTlFhYmhT?=
 =?utf-8?B?T2tScG83WFIyMy9JWmllQ1ZvV21KSjFqRXJ3Wkkxc04zWDVQN3NzZ0krYVBl?=
 =?utf-8?B?ZTlqWWRkZ1FmTTVmNlV2cmwzZC9JK0FFMkpNdmFpcEtyL3NrZEJwUFBRZlVi?=
 =?utf-8?B?Z1dKYnhUVjlvbEVzMnBFek8xOFh5YllyL3pqYVhXVUJDZkxteTZqWTQxUS9M?=
 =?utf-8?B?OFNIS1lyL055SWtEQWl5VXZHWVAxcU9oV3hpWU85WjJ5ZkJYRFJhcWZid2px?=
 =?utf-8?B?NDZ0ZjF2L1ZjeFlDMXhMbnoxR0IrTERzaDc0dm01SU5Fa3p6MlluZm5mdDBR?=
 =?utf-8?B?ZXE4eTdteVFhSko2bTY3M1JVS2M5cVFvUHhZeUNVeksrVkV3dkFUeUgwUFEv?=
 =?utf-8?Q?ulG318wFlKoJchMC3NnLX7suTSewbTfvnAH76GiVgc=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c711fb-6f8f-41e5-3eb8-08d9fdbcfdc7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 08:57:20.5039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWmC07BMGkAsRm2BTgy4axiDjvhiAE1xwrkmUz3DAD4SWkM483u1GmKv0Y6m7550VZIxuDpvMrckTopJfp6EeoOIcre3561FuFb5NErbJIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB2893
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.11.2021 15:50, Ævar Arnfjörð Bjarmason wrote:
>Extend the tests added in my 9df46763ef1 (log: add exhaustive tests
>for pattern style options & config, 2017-05-20) to check not only
>whether "git log" handles "grep.patternType", but also "git show"
>etc.
>
>It's sufficient to check whether we match a "fixed" or a "basic" regex
>here to see if these codepaths correctly invoked grep_config(). We
>don't need to check the details of their regular expression matching
>as the "log" test does.
>
>Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>---
> t/t4202-log.sh | 24 ++++++++++++++++++++++++
> 1 file changed, 24 insertions(+)
>
>diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>index 7884e3d46b3..11bb25440b0 100755
>--- a/t/t4202-log.sh
>+++ b/t/t4202-log.sh
>@@ -449,6 +449,30 @@ test_expect_success !FAIL_PREREQS 'log with various grep.patternType configurati
> 	)
> '
>
>+for cmd in show whatchanged reflog format-patch
>+do
>+	case "$cmd" in
>+	format-patch) myarg="HEAD~.." ;;
>+	*) myarg= ;;
>+	esac
>+
>+	test_expect_success "$cmd: understands grep.patternType, like 'log'" '
>+		git init "pattern-type-$cmd" &&
>+		(
>+			cd "pattern-type-$cmd" &&
>+			test_commit 1 file A &&
>+			test_commit "(1|2)" file B 2 &&
>+
>+			git -c grep.patternType=fixed $cmd --grep="..." $myarg >actual &&
>+			test_must_be_empty actual &&
>+
>+			git -c grep.patternType=basic $cmd --grep="..." $myarg >actual &&
>+			test_file_not_empty actual
>+		)
>+	'
>+done
>+test_done

After rebasing my work from <20220302090250.590450-1-fs@gigacodes.de> on 
master I was a bit confused as to why my tests in t4202 were no longer 
executing and none of my changes did anything about it. I suppose this 
`test_done` is left over from testing and slipped into master?

>+
> test_expect_success 'log --author' '
> 	cat >expect <<-\EOF &&
> 	Author: <BOLD;RED>A U<RESET> Thor <author@example.com>
>-- 
>2.34.1.841.gf15fb7e6f34
>
