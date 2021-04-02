Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7616C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 18:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0BC361165
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 18:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbhDBS11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 14:27:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52090 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbhDBS10 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 14:27:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132IJtTJ152199;
        Fri, 2 Apr 2021 18:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=+qwpXdQygm0liDni25FHQy2yOpA/Ny2TJpBMPG4PmrA=;
 b=qC6XeTFXYwwnZg3SCfRfP8JMv1i+5SCAUNyFJfl2fRgZgK/mkpsP16V6HjJ9uOcmEEs1
 QV8CnMXG2fik33d6Xf2nBRlQC3I3aQzjkxD4UzACadUgBipO2k+LTBzGx5zoS36tXiwU
 7ocMzN1NwzwAJ5Wdy58BxCJT5erxNsSkD6aMXKPBBMfdq2Kj/U6TG/qalgJXFho76rrd
 y8lVLacpLdwiGDEquqaO6l9QifjeSN0rx7XFReXzF4SKdn2eiY+j7dInh32+I3gGckiy
 rWW6sFu2pXIw5mny+tXzv0ioiilL6Pt8koJL8gMOIANu07gb+a9hppOSkKk9AHywBU2g 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37n2akncwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 18:27:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132IEl7i064310;
        Fri, 2 Apr 2021 18:27:21 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3020.oracle.com with ESMTP id 37n2pc0vrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 18:27:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7F8jU7cKbTE1EK3rbB7wHT+8r2zDOLuv+xz/7fC8Gqlhbiyf67XdB7xHA4FTZ8BjLZBM6lpxOBbwZuCvHneBoE99OkvfUQWoGhTuW3GI4WJSdmtE1fUIKaGUGZbIso8O2zvPblQhMulNAc/CjPWVPE7p9YY26hKqgyOVkk4ojJoSxdig2nXcVoHLFahCptY1Ic0U4gSsZA9dT/SK/x33OKMowbPg2mzXko3tJClkrwp2/EtSMxfwxs7Zh/pH+eQTjhQ2Mt1gIJYvBHuIlj8ccNNpnoEDkMnunWxruPNM3N+fJpxknVYl29F7+2p52wngB8RHNAccTNtyZkt90WJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qwpXdQygm0liDni25FHQy2yOpA/Ny2TJpBMPG4PmrA=;
 b=C2Mk6ip7f49YpwYa2XoTC2DE0zdoPYPFGga4mqBqbm3QK92wqUTxxBhVpROf60d4xe66B5V6JOMzsGEZxsUR3eWox5aQiHRvKU2/PERTjWhyHmnu6jZ38MNo73D+6kpqiCc4qWRf/fY5+4bPLcGnQxOQtMG9x8KER7brBdDIFvOT+X3rN0j/laR/8vlEGBgvfWzKPGy0D4SI6pxtdmRvHyw0c/WeueDhG6pOTwcV5+G/GknjtjZgf7iQG/nrdLDPZyaJz+2u+svp+aK4Q4QHuPqbdgt8/InHrE59dL7CO+z7UiFICbNLev0NG3Aemoh/7Gmw03PDu2SqOTD+zwzQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qwpXdQygm0liDni25FHQy2yOpA/Ny2TJpBMPG4PmrA=;
 b=Mnm1kqnURtfLbv+M7ErlNY4umQekutXowz2ogiHzT7Fhc8ABfEbrt5U6vEkj3mgI9/8KL4Ed+rc1p9YWGiPiH3Mhp1RJpnHLlYa5/wshQ2P/kFhAcSc4vNvEip/hkY6Z441LjdmRe/Td/KAurI+LA/uoNrME6PLXGQ5P1xMA4tg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BY5PR10MB3844.namprd10.prod.outlook.com (2603:10b6:a03:1b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 18:27:19 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 18:27:19 +0000
Date:   Fri, 2 Apr 2021 12:27:16 -0600
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
Message-ID: <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
 <xmqq8s613gqa.fsf@gitster.g>
 <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
X-Originating-IP: [129.157.69.39]
X-ClientProxiedBy: SA9PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:806:28::28) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.39) by SA9PR13CA0173.namprd13.prod.outlook.com (2603:10b6:806:28::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.11 via Frontend Transport; Fri, 2 Apr 2021 18:27:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2498ad9-8b58-45b7-77db-08d8f604f2d9
X-MS-TrafficTypeDiagnostic: BY5PR10MB3844:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3844911B01ED47201F285FC0FC7A9@BY5PR10MB3844.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FYfxODL0cCp1G78bXJWaZrnEawyUHh7gYgmc+x5zuo2lA/J4V9G/apTB4cjlUZZTj10Vwdt4MpcK4VEq2FWMqA1fbXKyP9cbghQ/E81sPmIy+g7a+zYakjSZOgTgp4vq7X5sdXyUPhG7PHAKlnX29yRQ+++y6tdbn4DOyy3BHwxLP56X01sqVzYl6Z3PFfmOZrpnL2RGF+otLL/65b1BuD2YC3z5UwseBi3SRAsK9Sl0dTiE0PqZQKwT6PMMQa11YRJkzRYyNce6RN1khodbiRhJ4cm372mGDv/P8Hnot9PG7uneUnV62lMT7iF1WuVPG8JYJpcXmLaaOP3udJQzy6dJX4MXcuJ/5KojoUqOmL1lHrdFEFckmKk3P3SKQToK6VUwQV5/9bDOJ8PpeTOxS4dqbCd5STCHtcjl6qFYyZJ47yRtu5Mi+QsLKBWUGWizMt1fqFNLpC6XsSdPsbpNHE3ulKKn9rTJhzffpRAiSOK5u46AZhcpqnH32mAWrEW3pfnyhNDXXzwNFStyydaxXd8vyAYdIul5sZifa4SsMT29o7bvDEqpfvixN9RWS2WV/LRih+Aqd6r55J+r9lC71WTPgfyKXUjyyt8iQH3t1DzkXJodEznUanCVlQtNl00wDE+Cdiyzby3GF6LA4g1aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(346002)(376002)(366004)(4326008)(8676002)(1076003)(478600001)(16526019)(5660300002)(186003)(44832011)(316002)(26005)(66556008)(6916009)(66476007)(8936002)(83380400001)(7696005)(66946007)(2906002)(52116002)(956004)(53546011)(86362001)(55016002)(38100700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Gb6YHGw5112g9YyMQ9Q8Z3AQJVXrEqS8fUwAHIsOa31n7CuOdCZbq7OTnzZ9?=
 =?us-ascii?Q?M/IT7usYpUdf5M4fLNucuSKIk75GPi9sHIltsfakbjJi6OgvS/RY+8I5TQjc?=
 =?us-ascii?Q?EGdv4uDI+LNOD9iPGHYsLn5FWbzwoRVTdmtrRJYvuHkE7lisiNfxJVizD8A/?=
 =?us-ascii?Q?BPzz7wbrJ6DT6HZviibYTsCYWEjHNEHSfm8Wkz6XrpZKNo3gh28na8MIK0Y7?=
 =?us-ascii?Q?zz7E+fJItzRT3jc8rhlFeW28oeZpovQRQyqhQQ+9Sc3JuP5igUbMXuIzem8L?=
 =?us-ascii?Q?byHxiQcBBdDlfwU9xtd/u8lZ/QdSXF4ADqtZGgkat6pUzc0DHxprLbxmGMPE?=
 =?us-ascii?Q?1pNPxr9eX/PCjkcmtvqrwJFkUgEqZE8qMacMrkNGvwIOR1tA58tzWmGX4teV?=
 =?us-ascii?Q?3mtI2sp1uq384TaOOY5Y8ST1pnKt2dTjBsemzyTBbrSOiZSvn8nD+nmHGvS2?=
 =?us-ascii?Q?cJNNPimds0CSGYenbIA3CrZyzhIZXbDSJgmeZwGM9tIdxDETr//LXoG0PqC6?=
 =?us-ascii?Q?iPzNdx2GeszoQTgds+njLyG1OYTuaoZ/CZQvSAeufrVxhs7g2w2dIhcvEnR0?=
 =?us-ascii?Q?UCUqWVbDb96OFCEJylpUax3G78xgjX/eBhq0PSfda/5iVhRf+5KUcApGgX2t?=
 =?us-ascii?Q?mk8sYhy74qWZ/LfhyRDPx38bI0+fKU0NWmkuCoRTdNTT6qNfzgQXTpZhzScR?=
 =?us-ascii?Q?8Kdy01vssJ+S/Pwm2P9CMvWNBMEJw2czn1g+RnTICwmtbLOQIP2u5LL1yjBG?=
 =?us-ascii?Q?9KdhLt3fB7zNPATU5VYhEBBxQVq0gfg85L+DaARTIRlmmt44rclNva8Cvpb0?=
 =?us-ascii?Q?QvYC1uYULpIyKZrM0nOwy+/DlaCtjM8mqqXNemKj6wJIItJO7812m3vGMSxh?=
 =?us-ascii?Q?jhP4oCoqlUVPMea/T6M4Zd23ouyKTBvNUJsrDCxdMvuyDH4GtTjslErtrRTb?=
 =?us-ascii?Q?EPhZfoF8xwUvsWGFmrD1y6rYIcoJQZ3YFBncgJ2+SReYWsZB+0IY/jwek461?=
 =?us-ascii?Q?m81sFtNbLReVjLMc3KGfXFRn2ssmPEkqHOec+KloGlzr0qUUu3YnuWggWbvt?=
 =?us-ascii?Q?dxtld494GQSGAFBd1yszuQPL1KVlHKZKYyKgpArxkLN7Zg70NJvgjDJ83vAV?=
 =?us-ascii?Q?PJ1zNpte5p1B4Pspp6r4tGmnqpLnF31gD910Osrxn+oq9dIO/XGCQbCTje52?=
 =?us-ascii?Q?B550JGq6Qn6QIGAZj3S98mRb+Gib5SZGHfB1AOi3TWsyo22jJ+CWSLsKO4qL?=
 =?us-ascii?Q?XJtZ5ciSEavltNeVlv66In5JMkaP8SBxfcwZlGp/BtNuB8VKvYCyFkweeU3j?=
 =?us-ascii?Q?JOcsDI+Oht/QaNiCGefrzCh6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2498ad9-8b58-45b7-77db-08d8f604f2d9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 18:27:19.0383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELaVURjzXyy79tJYs7DNJr9dnXSsfySiqjyGfnIfD2iYq5l3c0cZKR7zWvb8PD5msoUVVWHsSuQthqL7gnS9vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3844
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104020127
X-Proofpoint-ORIG-GUID: c9NVLEKl1EOvwTVVqo99rEHPri3Dt5qN
X-Proofpoint-GUID: c9NVLEKl1EOvwTVVqo99rEHPri3Dt5qN
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020127
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 01, 2021 at 06:25:36PM -0400, Derrick Stolee wrote:
> On 4/1/2021 4:14 PM, Junio C Hamano wrote:
> > Derrick Stolee <stolee@gmail.com> writes:
> > 
> >> On 4/1/2021 2:49 PM, Tom Saeger wrote:
> >>> I've recently setup git maintenance and noticed prefetch task
> >>> fetches ALL remote refs (well not tags) and does not honor
> >>> remote fetch config settings.
> >>
> >> This is intentional. The point is to get the latest objects
> >> without modifying any local copies of refs. You still need
> >> to run "git fetch" manually to update the refs, but that
> >> should be faster because you have most of the objects already
> >> in your copy of the repository.
> > 
> > You answered only half of the question, I think.
> 
> You are right. Thanks, both, for pointing that out.
>  
> > The plain vanilla refspec after you clone would be
> > 
> >     [remote "origin"]
> > 	fetch = +refs/heads/*:refs/remotes/origin/*
> > 
> > and "maintenance prefetch" intentionally redirect the destination
> > part away from refs/remotes/origin/ to avoid disrupting the
> > reference to @{upstream} etc. that are used locally.  And
> > intentionally doing so is good.
> > 
> > But imagine you are tracking my 'todo' branch which has nothing
> > common with the history of Git.  You'd have
> > 
> >     [remote "origin"]
> > 	url = git://git.kernel.org/pub/scm/git/git.git
> > 	fetch = +refs/heads/todo:refs/remotes/origin/todo
> > 
> > If "maintenance prefetch" does "+refs/heads/*:refs/prefetch/origin/*",
> > you'd end up the history of Git, which is not interesting for you who
> > are only interested in the 'todo' branch (to be checked out in the
> > Meta subdirectory to use Meta/cook script or read Meta/whats-cooking.txt
> > file).
> > 
> > So, redirecting the right-hand of configured refspec is a good idea;
> > not copying the left-hand of configured refspec, and unconditionally
> > using "refs/heads/*" is not.
>  
> This makes sense as a way to augment the feature. It doesn't seem
> like a common scenario, but it would be good for users to have
> that flexibility.

It's common for me, especially on repos requiring 'maintenance'.

> 
> Upon initial inspection, it shouldn't be too much work. However,
> there is some generality to the refspec that might not be wholly
> appropriate for prefetch (such as the exact_sha1 option). I'm
> unfamiliar with the advanced forms of the refspec, so it'll take
> some time to have confidence in this approach.

Didn't know about exact_sha1.  prefetch probably wouldn't do
anything in that case?

'negative' refspecs - hmm haven't tried those.  I see how that might
complicate things or maybe not.

generally isn't it still changing the right-hand side of refspec?

replacing ":refs/" with ":refs/prefetch/"

This would still work for refspecs with negative patterns right?

I'm willing to help with/test/review this, thanks for investigating.


> 
> Thanks,
> -Stolee
