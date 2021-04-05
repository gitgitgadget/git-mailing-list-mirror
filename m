Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB6BC433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 20:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28262613CB
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 20:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhDEUir (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 16:38:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55326 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbhDEUiq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 16:38:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135KZdld119647;
        Mon, 5 Apr 2021 20:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=lqpuHcqVdXH6l8gtd3sv9ad6zAk/J2WJ9UzInRGoTHI=;
 b=LyodxbV6iPnWQHZFs9C8VpYD5jeo3VUF58b/JzBAN2Hn0009qdbo61PNYPRzYqmCh/zP
 Hr5X3+Ro0VRTfYLq6/ISnGQN4iP1z02+N8Zv1O6wY9NhlPXimQ6DkHR09DcbYnxh2wkL
 aqGCT6KYKIpZKSGnnXb5Sit7js+bGgJeNuzkYYIJYQqsNiUG21XtPtbzxJI6VwVgPKml
 UQb+GxgP9CCrO2QaVNs5B/hi9I4RKmRbCOj+BnGxJPBr9r7eV9MzTgRue33XbN3MHkSr
 Pypuq4GuNGmugOhg23Bi8feN0Udn2CcnoTSOCdf1XTAfCUXeE6ViSBeejwg/IpLcwJmg IQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37q3bwkawh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 20:38:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135KZpfO061220;
        Mon, 5 Apr 2021 20:38:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3030.oracle.com with ESMTP id 37qa3hjda3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 20:38:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVSU0PsblWNyjNirvBECi+2rt7pNSgSayfIfRJtXcJuI3eEYnmgcb6Vs6G4aIbUE9chtm5l4/STsNnAUZaTEwl0PE14U4Fq5r6TpFn611AeR2Lg5BM+GTo8q5k8NcSkZLn6TvQ8NO6skNJsGW0GF7/9uYuvw7a2fTOdjRMF6hZ0dyrikpWHktFAhpZrbgRCWoionmBKsE7i+sSlqochnuwosF+bCBie27Ba2JTk/ndMy/hTDZhq3GTQy/Znt0AtFNwC9f+JrDXFdT2CBIU6AyvUdoGISTMxK20RsgHRr/QBiSWjb4itFTRzlmvThYUtaWcJ8fSRYhTQrbwwSekjiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqpuHcqVdXH6l8gtd3sv9ad6zAk/J2WJ9UzInRGoTHI=;
 b=aHA7jRafa4Yf0Xw/dMRK64SEP8UDjaNkE6xKTrL/kxd/vToGWoFZbuvVPcE8D2iLleTf/k0P+qMCtfT7Y0GwCPcbrJJRPjTOQpURVjZgC4Qv8pctaYGGG3x8DF2YZbQSPq3Am/mfJ2Kw9RCFVm7opmdB3/FN7vk+u8LNiMU9ujKbnllpkpEAAqU8KXlED81/4oNfoC500ukFMcy6zW/3J8ZfCiH2uy6sk7B4m+5uJe+tIZFndhFpit7N3PRXf2v/FQNChlXdZY3s+HHSJghOxOT0HCODyREMfYDsDMwMicNYzYL7DQhp+cGCKhh7zSzCrVmBZ5l+JT+HjdOPIutXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqpuHcqVdXH6l8gtd3sv9ad6zAk/J2WJ9UzInRGoTHI=;
 b=bo9XQvyW3FTcCnUNSK42TXAhAmqQbJpDKoFtQFCRUHj9Z8HBAONfH0G0f6Fah0uKztcTQLZs5Gpm3ZJecZf/9Cvd9xRJ/9dwGV5K091ilo9vh18aEEKpMcKNEUixjnVIsEP76ETAuf/3E8IQ9wozeY+65769AdOO/PWs7EGocLc=
Authentication-Results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BY5PR10MB4289.namprd10.prod.outlook.com (2603:10b6:a03:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Mon, 5 Apr
 2021 20:38:35 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 20:38:35 +0000
Date:   Mon, 5 Apr 2021 15:38:32 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
Message-ID: <20210405203832.x275fqoinfsw5gik@dhcp-10-154-153-195.vpn.oracle.com>
References: <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
 <xmqq8s613gqa.fsf@gitster.g>
 <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
 <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
 <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
 <xmqq1rbs4c6t.fsf@gitster.g>
 <f113284b-a7fe-ba7f-ce1c-d214efd5d0c6@gmail.com>
 <xmqqft057ijc.fsf@gitster.g>
 <e75b1e72-6c9f-d466-ac52-24b324b44b3c@gmail.com>
 <xmqqr1jo5zzb.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1jo5zzb.fsf@gitster.g>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: BYAPR01CA0008.prod.exchangelabs.com (2603:10b6:a02:80::21)
 To BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-153-195.vpn.oracle.com (70.114.130.219) by BYAPR01CA0008.prod.exchangelabs.com (2603:10b6:a02:80::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 20:38:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02bcd322-ae3d-453f-0a31-08d8f872c88c
X-MS-TrafficTypeDiagnostic: BY5PR10MB4289:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4289428AD28234EE9B27A586FC779@BY5PR10MB4289.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpxVlB5MF63LsjRSYhLp8UG+9N75wxe9UGYspBPZxkdyFFrBWqJmg7Fzvb/gFquoFBWSVW4K5+aMPqjEiuJoWqT6eFvJUrr3ShNLlml2p9/aUioNpZ0scTa03h3a9CRvn+OhTbx9kN0xYgS6QvahDrAFOtzs1mRmHXv9MWA/gLKFK8z2nhjAfATrCrfVhrkitQJ1WG5wv3da/GNgYNZgDW1MvDtN/S2LeGrOEeZMmXpxsnEnEbiwT095Wt2nxUCIYbAHX6iokhF00L5ffWuU4U0BlAjm0GNAZASLagbpNfrGeCeZsTR7vNu4x0YjThN7N52aVzsvbs0zKAwcvgxprZg13Gmxh58YheCT6gtbeBkoEgdxThulbAzzLm0VValSlpWyRd9yewu9zc+niO88MiWcCB4+HZDEyM6TvE6QrV69H26FuvfbWnEqkaHujMdUNwHb6tg262D3mmhz1lE/qsFtl5Oklk7ACtrUnB/TSIHKo6vMb4KHFFtxm5rEc0ZcNCS0INuyVmhxe83F9T88Oup4VVNN/WdhXmYDd2CEvHmac2/sigZ9XseoZa289eDrVFb3QR61C8TZgxAAZgsINJbRh/n5i1InJK/XlWvI2DNrzEVCMHfBy2S3seFtIoGPe+haiq+vmzNaOrY7prNhI90kQmZD0qF/xh0FtAyiDOm3MMq9tmL3YMeLah3KfHI32KDDqFkId6QJy/EX226HlL49FgEtTjOy91FQP7GtNE1IFgptFRnYtDQmNxZRwu+iUt5OZsximoKG4jGhodTyL3hDBJcCPGdDrgNDQc3fEh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39860400002)(376002)(346002)(2906002)(66476007)(55016002)(8676002)(86362001)(66946007)(26005)(478600001)(186003)(6916009)(5660300002)(4326008)(966005)(66556008)(1076003)(316002)(8936002)(38100700001)(956004)(52116002)(7696005)(44832011)(16526019)(38350700001)(102196002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fo7e2ZisHcdrFW2sXr0bAmiqGhBrvzUdOeBEU4SoTK6IqHYPW5SdI9jRCPcE?=
 =?us-ascii?Q?hlYPoj4+MKuL5K4E21GKMf2hrGvQwwlNG1dDaev0Cck5iwgKhOhLweJ4lAyS?=
 =?us-ascii?Q?zOZiOH9ue5mN+R/0Ns1YgDQkrtJRv+omWJ3ILuhBjoUpC35zdn8r7cxK/Y1M?=
 =?us-ascii?Q?SP1IbJMgXKJNcpRs2mbcx5bxfVRn8SPhTYMKW1jXSKMzcmMdkTMkPfYvL+Zx?=
 =?us-ascii?Q?xLE0X8LUx1Vs234F1zKMPoopFmgmneEBfdQSoa2CasLJvDSrUF4Nn7XzNOIX?=
 =?us-ascii?Q?ePZgrL9UPLFpC79AnkLk4XcjSquNGp7c0aqZT+DHApqHQOXv464vkM+aewbC?=
 =?us-ascii?Q?VFkeg0WC7MVApzd7WLbH7+EIlHD4J7risHeySQY0xYvkKCYF4pVnLfm7gAJM?=
 =?us-ascii?Q?zJAyD2nonCEsNcFMbxdy1VUC7yGN9HGaybJQJnd6yVe5VzLrXorLLhYgj7qh?=
 =?us-ascii?Q?+93SfaYQSXB8LYzZ0/nlr53lYDezdHQaypJwjfXt3Ak7PjwxmuwGODJydZ1H?=
 =?us-ascii?Q?tARNnsL7Am6hXE+1qliCtn9GaUa265ZOC5sJN6nm+ysVupWLghIvKb+9Sqjn?=
 =?us-ascii?Q?VxGJ3i+7Y8rLf23zh9KaKgg98hG1ea2xoaE6MrVNl/idZuwh62mO3d58DU9O?=
 =?us-ascii?Q?VibLoWUhKOwNfYffSSIdcTePRONPsHlSs/xTBGCLJF221Zp7UTDp9evDIhnn?=
 =?us-ascii?Q?1vzmN8RSDZVmXykSrVe+f9J38Yc5QJfw/YXgSoBBfghlFaLmvwChsfcQFHYH?=
 =?us-ascii?Q?Mcfu/aXmlS27YRJ2u3hS3ByutPhpisW7MpBlfhgfnOdTn+ez7bakSv49mLfn?=
 =?us-ascii?Q?OFmz6Hly4+stQPgVf4xP/K6wUo4JmEPgyncFRGUhItJmjmQClv5UejhdWOz6?=
 =?us-ascii?Q?C6rvKVzJfSPw9DqQwQc++4QVqsoAn0jz4GbDDlPHruA72jwZpWJd7B5G5IhC?=
 =?us-ascii?Q?WZIbynamugXUm1P4M3nOtv9PxadvnIOGZVtTycpxPmgAGEcHCN2wFJrrKdHI?=
 =?us-ascii?Q?uSafy/da6XvPiObiHq8l6Mg5GF7RLK9siuQX76T8o4zjkCu80FpvkwbF64hf?=
 =?us-ascii?Q?ceQSyi079P9VMHnVZarNuusPQ2XLlWyL+uuCyg9U8uoGMkrYawX5RsFDlKuI?=
 =?us-ascii?Q?yG5bAwnKjoEaUGe44nEVJa9j3QlmIt/vuHY2U7ON3XOeMJxpnv8zbPVaGtRG?=
 =?us-ascii?Q?t7GnAOX138UbGx8JjigL/MZ/TIp5CoMW+Hl7Ak5kEJvi+zmNrHCDoYycTjQl?=
 =?us-ascii?Q?kM4eurhHsMAds2gxz1zS679aKuq3aV7ZjWCdBvls4JD97SMtY36Phx3/mbd4?=
 =?us-ascii?Q?F/xcGEv8458kuD2T4FvW5Noy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bcd322-ae3d-453f-0a31-08d8f872c88c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 20:38:34.9265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQp7NyxCTvAMuLA9X+aQpv+9SNpcaOnsMWnzL8fQazSb0mm8UJAFBUGfKTnM6XNm6o70hWJzOC8cX0fehZrXRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4289
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050135
X-Proofpoint-GUID: xegJ4nPgk04agIDyrBuUHl8gzWt_NLDe
X-Proofpoint-ORIG-GUID: xegJ4nPgk04agIDyrBuUHl8gzWt_NLDe
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050135
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 05, 2021 at 11:48:56AM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
> > ... but it becomes difficult
> > when we intend to make a distinction between "refs/heads/" and
> > other sub-areas within "refs/". Finally, I punted on that
> > conversion and made the logic in 'prefetch' extremely obvious:
> >
> > 1. If the refspec's 'dst' starts with "refs/", then replace
> >    that prefix with "refs/prefetch/".
> >
> > 2. If the refspec's 'dst' does not start with "refs/", then
> >    concatenate "refs/prefetch/" and 'dst'.
> >
> > This will keep a roughly-equivalent partition of refs (some
> > might have previously collided that will not any more).
> 
> Makes sense.  Do we need to add another rule?
> 
> 3. If the refspec does not have 'dst', ignore it.

I just tried what I think you're saying here.

Consider this fetch config:

$ git config --local --get-regexp "pr-924"
remote.pr-924.url https://github.com/gitgitgadget/git
remote.pr-924.fetch +refs/tags/pr-924/derrickstolee/maintenance/refspec-v1

Seems legal, fetch even works

$ git fetch pr-924
Fetching pr-924
From https://github.com/gitgitgadget/git
 * tag                         pr-924/derrickstolee/maintenance/refspec-v1 -> FETCH_HEAD


Prefetch segfaults

$ git maintenance run --task prefetch
[1]    3811315 segmentation fault (core dumped)  git maintenance run --task prefetch


refspec which isn't a 'negative' with a src, but no dst.


Quick hack:

diff --git a/builtin/gc.c b/builtin/gc.c
index 92cb8b4e0bfa..2f4b8f2375c3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -899,6 +899,10 @@ static int fetch_remote(struct remote *remote, void *cbdata)
                        continue;
                }

+               if (!rsi->dst) {
+                       continue;
+               }
+
                refspec_item_init(&replace, remote->fetch.raw[i], 1);

                /*


Better, but now a different issue:

$ git maintenance run --task prefetch
fatal: --refmap option is only meaningful with command-line refspec(s).
error: failed to prefetch remotes
error: task 'prefetch' failed

So a "remote" where the only fetch url is skipped.


> 
> > I have posted my patch series [1], so please take a look. It
> > builds up the infrastructure to properly test such a refspec
> > expansion, if we wish to do so.
> >
> > [1] https://lore.kernel.org/git/pull.924.git.1617627856.gitgitgadget@gmail.com/
> >
> > Thanks,
> > -Stolee
> 
> Thanks.
