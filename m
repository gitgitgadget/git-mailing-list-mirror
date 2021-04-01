Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE18C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 22:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DECB561103
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 22:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhDAWLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 18:11:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58546 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhDAWLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 18:11:16 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131M93DG118145;
        Thu, 1 Apr 2021 22:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=crToMFOiTlWkTbvNMbqDPChEFderBUOYUmEmpVuihf4=;
 b=wu09UvvWsCNQVrsZKbtvg0Tj0WlGhqYNlk9Hn46pTEAJOkPXgOOEcXQpshMYFBuGeFEK
 F+OAXfDypUZx0uN/2LTEu4IFkYuufhsJH2ZANMyoSl3f2MG1lQ4tPcdj44CEpndgVtE6
 JqaAN+YQCIRnAm9ksP8pcfWX/Foxsdi90UBn+uJpAUNYlfPlqZVYL2IPxn7P4aRm7GNN
 5Yjavh51r0CbNYBt3jmb12iFv6u8N0fYzCNvTdFa2N38MCAnFfQf9qS5RyLoMSGOB/xI
 2H0c+jSgbAsHPGFTKDuceHwBmxcZavGdLWF9ZX2AcRdSRlS+PVaBBBGWfw7TgKruRzoL sA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37n33du87s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 22:11:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131M9dNb143704;
        Thu, 1 Apr 2021 22:11:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3030.oracle.com with ESMTP id 37n2atcgw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 22:11:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOc4brHy04GmJ3VEYZaL68dksVqACHPC+ODAOkZTNvlT2WANqrIz6yzMIzYQn05FLrvKnowPsZKhs3/zhcycozXjgg72zELGrVZTi7jWizs0tdCzKi8bfHI5M60AMnxZKQdqxBzlYgbNcq6ZovHQ/vcswZ9fCFyJ4GYLNITp3Q+Bgi+g8lBWp2gSUIp1P75BAVrdhutxhXeiVmKcWv5V29ln4V6sb0aXFvFF6PFq4mlE/FzyisK6OlfxPo9gocWThpI2HtUv1dCFytBzyp3JIMqfsG+dntzfTrX1EVJx7s0Aqc0HyOYmqHnbmd+WlWJgVMJPPHiVFnceRaB4gJobPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crToMFOiTlWkTbvNMbqDPChEFderBUOYUmEmpVuihf4=;
 b=iy0tG+vP8Uk751DvnS0LKxjIjOBNZd1pAO0XDWn6UJ48quJZeqv4+E/XFgR5P6Ofh38ppRAjuttx0Bo5oNAQwaRxiSDTpl5WL5GQVr0I+5ItjncB+2n9pD8i/nVk0LrdmW0lMWgo8r+bb/RDO7pPyUH7/xkk7lNV+GxWDuv43hM3CwXlUfcBl/vGYyhOzm5qzofG1AuM8itIJ/ZCRjIAtAOeL22uXIAcO295ysGsSZRqW/9wWCq4Lp/n6sSVnQCL48ZIVsnw3IhgPde68swfVE3EAO/MPzDFEgIi3ehU9eXJ3H93dmVF3Aa/pjsGCLd/xrgFBbCpUzH390v3jKi2Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crToMFOiTlWkTbvNMbqDPChEFderBUOYUmEmpVuihf4=;
 b=kOOg/3lGfMhYKKKNVpLQG0RBzuWzVfnyzGXZxpy+eipsRT5/ngOZkClDvXYBAnToFJeH7+tzOuO6HS/VQeTn0yCE4cp+wwi7QiE5/VMFVmlumWuNnK/WkdYI5+y0y7IdXCI1KFj1dS6EZXYZbgZCpNUnGTxa1PDYU39P4rWS+ZQ=
Authentication-Results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB2807.namprd10.prod.outlook.com (2603:10b6:a03:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 1 Apr
 2021 22:11:10 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 22:11:10 +0000
Date:   Thu, 1 Apr 2021 16:11:08 -0600
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
Message-ID: <20210401221108.oy66vviohvin5se3@brm-x62-17.us.oracle.com>
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
 <xmqq8s613gqa.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8s613gqa.fsf@gitster.g>
X-Originating-IP: [129.157.69.36]
X-ClientProxiedBy: BYAPR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:a03:54::47) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.36) by BYAPR02CA0070.namprd02.prod.outlook.com (2603:10b6:a03:54::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Thu, 1 Apr 2021 22:11:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21b0e367-8b85-455f-13a1-08d8f55b0e6b
X-MS-TrafficTypeDiagnostic: BYAPR10MB2807:
X-Microsoft-Antispam-PRVS: <BYAPR10MB28078DF8B81B0008EE5A17ECFC7B9@BYAPR10MB2807.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJvjb6+wz7VoSrA31fSS93Zf61JNxiy2HDJyGplR4pcST4i3jV1YIL/uNRR3redv612DYDtCtFtPvTzskic8mFtVLX2yfypD8hoRdCEdA+KDIR1SV6+wRXZaneevegP6kXqO3iLLXKrvZX51iOE21adwcqn/xpKTqYH7PaMhwpgmifyRiUjxCfrzh00drF7nMiAVEmRvVOUuCu/RXAcEXxR0cTX1ETW7SlQWSS5hfmtF3nsFTFKUVho7I2bcAGOtqXC1n/jGynlt6T6c/2fo8nx1ynRAs8FNlWvv7uJ6Zcbxz35FOAOfmpLyPt2x0vgDQDfZxxuXk1tRBmHMAasPI3AedzXMId7mgiHUBUnUf98AI0nokbP3Rk/k+yTSgb510RJmDoGTWA/V/4d3v7SISNrd+6ps9YRhXsX1k5KETe8xpFvHaaxXlsUkPnqnxUF/lZYvNajdGrbWVbUaeohD7dhFq6Vbiw2PUV6NT4iaa6ppuCP8W7TASvFoo+tFmo2gyq6X5pESqDFpCWAOEwyxZwGy6zUvZpf51NjoheiodvNVINN9rVeLqVxsgOSpqvrLpcsQqGx785zb29StxegTQ2NeIiu+j3cx3cVMLsJaXy/1ZKOUueorMiDzvdUpjDs7fRLkvkm1WYSCLSjFlAPSyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(366004)(39860400002)(86362001)(53546011)(66946007)(316002)(8936002)(1076003)(16526019)(26005)(55016002)(7696005)(2906002)(52116002)(956004)(6916009)(5660300002)(4326008)(478600001)(83380400001)(66556008)(186003)(66476007)(44832011)(38100700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1HTc4bs8H7BmSXTm3QgKrE6BJvyDXo61TRaCWri3iUoCg4ylzwhgpUJ+Q4Bt?=
 =?us-ascii?Q?1kk5j8MIziR+J9JVb75ZyeOR7AnIUc0WVx377cW1DTUr4aPdINrvtZ91EkWa?=
 =?us-ascii?Q?B241fyKa2a1J4YvEyhxpdKHjQgNtrCiRZGOIizJEbHsyKUAwobo1T9wOfhsT?=
 =?us-ascii?Q?YH862M1TAHEsHT6TjAdkHFgflgwTbwEQrmyYf6tz4uPeBkOv2sgvO3eraPjI?=
 =?us-ascii?Q?nX/GIfz4V1qd5Np9NUlreXGi+bthHrxb9fFLDIwltcSv52IgJrjKqFFiviLc?=
 =?us-ascii?Q?uQ6hs6usetgz7Irub8HjjeV7DHFnSaa1c36NujZxmZAxlOMNfe/jx10hCYSB?=
 =?us-ascii?Q?j6Lx6U4Pa6DXBriIA5pJUmp96WXkBBDIMKc8neG4L0txpbu6Oy2Sls9XhqhF?=
 =?us-ascii?Q?him60A2iNqHa/gNpsxCuRcV2LomyI5ljwBU8UpGcfkJfv6qcCpIZ1W0Y9wcn?=
 =?us-ascii?Q?dFYt4BSArLyx6IRL0C0AssF4uPerwM3NXaegl4QXrIo1pFjS528jUorFyyOa?=
 =?us-ascii?Q?Rh3chp6vfRm5/EkZY5QnXK8zwZFofR3jtAukD8U+B+UoS6I0nno/5HQQkrp6?=
 =?us-ascii?Q?jgKsgPYy2NRh6vA2V2U9c/FYDx8XC/HJZYXeyHdrxAChYSceehySW1/U2Ylx?=
 =?us-ascii?Q?qfjphv64IAG2dYHlHHHhSPz+E4y+2qt+27m6km+z6dAYgtXwaRl9RkFcfro2?=
 =?us-ascii?Q?atOphkwOkfREMMrOXIaaDCQALFlmnJK+i563UyV7lKo6hIQSSjZKmIGNjLag?=
 =?us-ascii?Q?Ip6aOp0IyqL8HYKlypG/r0iD8TgRVPqRQe0WjQBaZ1Ja3SnZ2T8sH+mvb14P?=
 =?us-ascii?Q?YoNrMjb02hRMVU8+X6fii2qOrwjMsKJ8qpQZjQzmAJ2C8b5yx6JF2+6+Pe4h?=
 =?us-ascii?Q?pA47XYOgOFBwTo4MX8mep90DDpsrnqSorSuDjZ2FXDvGEtPyMPFd+sxLiw+7?=
 =?us-ascii?Q?IHc9yEJX5gmNUDXK9QmSdEOtHXxf+3tGAFVJCX50tv/gu5WMRvQ5+Qiut0Aq?=
 =?us-ascii?Q?3ho1IRxurZV8VTnHF5Ozb0GQf5zQMfb2iwPNL1kAmL/YkOv2f5VJvHMGT6/p?=
 =?us-ascii?Q?LnBo5gQha+9h7/TvbFAIQPkvLwdy/r7ttAM5SHZx0JTYUqt7S/K/WN0LpYwM?=
 =?us-ascii?Q?vcCkKtZeqwFtGCbiM4gydEGoSdS0GAKJxLB04iNRQkAIgSc4oHyRvuqBP43k?=
 =?us-ascii?Q?ldPN/V2DM2BAGf18N4FAeeZhm+Dcbc7xf/pn0pUsga5viSgZ8Hmy4muiOGp7?=
 =?us-ascii?Q?3zLXgba8OK8ceTNTIip5LD6Ee0OQCRlWRtiNVywDHipF38GbMCl/VuE9+kmv?=
 =?us-ascii?Q?YUQADzCLCw2kN0tzGpMNqJ8E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b0e367-8b85-455f-13a1-08d8f55b0e6b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 22:11:10.7421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmsMaq80UryZVV0iMwdWd02m0OMxQuFt3X20f2SyRYOQgxKfsAHPHdQg3UurbaSFkdCKWpAWvuVWh48Sqs36EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2807
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010140
X-Proofpoint-GUID: NwqaLliADmF6IXUKmRf7dPbZAq66REfG
X-Proofpoint-ORIG-GUID: NwqaLliADmF6IXUKmRf7dPbZAq66REfG
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010140
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 01, 2021 at 01:14:05PM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
> > On 4/1/2021 2:49 PM, Tom Saeger wrote:
> >> I've recently setup git maintenance and noticed prefetch task
> >> fetches ALL remote refs (well not tags) and does not honor
> >> remote fetch config settings.
> >
> > This is intentional. The point is to get the latest objects
> > without modifying any local copies of refs. You still need
> > to run "git fetch" manually to update the refs, but that
> > should be faster because you have most of the objects already
> > in your copy of the repository.
> 
> You answered only half of the question, I think.
> 
> The plain vanilla refspec after you clone would be
> 
>     [remote "origin"]
> 	fetch = +refs/heads/*:refs/remotes/origin/*
> 
> and "maintenance prefetch" intentionally redirect the destination
> part away from refs/remotes/origin/ to avoid disrupting the
> reference to @{upstream} etc. that are used locally.  And
> intentionally doing so is good.
> 
> But imagine you are tracking my 'todo' branch which has nothing
> common with the history of Git.  You'd have
> 
>     [remote "origin"]
> 	url = git://git.kernel.org/pub/scm/git/git.git
> 	fetch = +refs/heads/todo:refs/remotes/origin/todo
> 
> If "maintenance prefetch" does "+refs/heads/*:refs/prefetch/origin/*",
> you'd end up the history of Git, which is not interesting for you who
> are only interested in the 'todo' branch (to be checked out in the
> Meta subdirectory to use Meta/cook script or read Meta/whats-cooking.txt
> file).

Yes - precisely.

> 
> So, redirecting the right-hand of configured refspec is a good idea;
> not copying the left-hand of configured refspec, and unconditionally
> using "refs/heads/*" is not.
> 

And multiple values can be set for remote.remotename.fetch


Behavior equivalent to:

git remote | while read -r remote; do
    refspecs=$(
    git config --get-all "remote.${remote}.fetch" \
    | sed 's#refs/remotes/#refs/prefetch/#' \
    | xargs)
    git fetch "${remote}" --prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet ${refspecs};
done
