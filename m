Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B40C433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 20:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F5F613C4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 20:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhDEUvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 16:51:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48132 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhDEUvL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 16:51:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135KmhHR028174;
        Mon, 5 Apr 2021 20:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=x4r0+x3IO03PEL0zHrtI6SSvw5Ka+hdIi2A1ikQBNQg=;
 b=ADPwVKY3HxhTnWVqgXxsFfQGYbsDT6rZynnq9rgXCPZeJS3IzZaWtp5XXyAVmfikqtqP
 2QbDXHDo8y5zR3pSzZaSkltf3LXFcEIuidkvS0DLGbSuAK61w0XiWkpVoo5p1/ll/yTE
 4ZJZv2OagrBOLNjqitzPNwybHsZ9DdItObBRqo9+gOzgplPvgDpCRE736DepVwnGMs3a
 pjNpx1v+UPZDm/AiBJSNncJmGyuCIit2k0P2Z++W/Ka4MJv+pKQsS8x9Nm5HRG43NFmn
 THNQ1ZdTc5QrBl8MOMC/abgWH2AwbnQ/LFhEfE2fYdAiHG6eyCEmD2MS6+EjY6sJdaWD FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37q3f2bc6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 20:51:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135KnwWL159860;
        Mon, 5 Apr 2021 20:50:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3030.oracle.com with ESMTP id 37q2pbp8xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 20:50:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beC2wqak7dEHvn2BJ93+/tYwap+qypuj5yhmIJwv8/FO74uz63u66zcY9ZJWVQCA+UwAzCwXdUG8zqYZ3P30ZnN6r/g55AGwL8HBUIPIOl0wYx2TWM9xrFTabD4jl3RfIGdZYrWlqnOqdUOPSvW6POJ/9VRnTzaSyDZQ2pJwx7qjYZLJtDn3nEhctMqSqJvNrnDHXFD45VrLy3RAK0VHFyAUBj3Dl8feqUHsVJgmTTTS6s+Zvr//QainovWXZTpRVJ1DH/Y4k+o2WS7dlDNS1GycNkTz4GBMjx+xDXyN7Jfkt0NI4u1f96GYwQv2rGJMa1K/CyrSNg5JqdD6YAZ8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4r0+x3IO03PEL0zHrtI6SSvw5Ka+hdIi2A1ikQBNQg=;
 b=GsYNk6y0u2q7N26DLi+Uk42/QRoMy8vOSZiwGqCrZ3CYu/Pl440TEtZnHauzWbu3hI/KGI7+2eppbV3C/AIFlh8LDuuOPz3tQfNnO/oAwrE+J15V/mxxW6tK4WX84vGaJPlGSMYMF4iFbO5gLhWZHSA8RBP0ARhSCrgyKiMT78hZD5dU4tyEfOvrO3B1Sg0+4srP/ZNzpH2oQTkZ5G8R9Bm4/TwblRI5nNb5wULcZamEhj3NxQ0o9gTUuIRLU3gP8Bkm30dOQIZBd/TOT7VpYJ48mIjAcUie0oZz1ce9gT9tAEer5isakRkwa4EYwe3G6hGPuF6ApvULILHAsQBu6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4r0+x3IO03PEL0zHrtI6SSvw5Ka+hdIi2A1ikQBNQg=;
 b=eaktiKkpxmptLsJ1xduqU5XFPjEkV8u9AL4CdiDIqDYfRhfwrFyMUOdcnv0sjL8GRHKWJ+WiX+Sxk2SvBaqMEk99BedJCbMeYbtb7NXaMyGI8HCYCzF+vDqN8+vF+dWuuawZVpA/n2/UXInJwhzTvjrGBXnrFKQqA0jkQk8Rd/M=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB3126.namprd10.prod.outlook.com (2603:10b6:a03:15c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Mon, 5 Apr
 2021 20:50:57 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 20:50:57 +0000
Date:   Mon, 5 Apr 2021 15:50:56 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
Message-ID: <20210405205056.czzkjdxr3guca3mf@dhcp-10-154-153-195.vpn.oracle.com>
References: <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
 <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
 <xmqq1rbs4c6t.fsf@gitster.g>
 <f113284b-a7fe-ba7f-ce1c-d214efd5d0c6@gmail.com>
 <xmqqft057ijc.fsf@gitster.g>
 <e75b1e72-6c9f-d466-ac52-24b324b44b3c@gmail.com>
 <xmqqr1jo5zzb.fsf@gitster.g>
 <20210405203832.x275fqoinfsw5gik@dhcp-10-154-153-195.vpn.oracle.com>
 <xmqq5z105uia.fsf@gitster.g>
 <5c432329-1e42-c29c-242d-a2955174296b@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c432329-1e42-c29c-242d-a2955174296b@gmail.com>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: SN4PR0501CA0092.namprd05.prod.outlook.com
 (2603:10b6:803:22::30) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-153-195.vpn.oracle.com (70.114.130.219) by SN4PR0501CA0092.namprd05.prod.outlook.com (2603:10b6:803:22::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.9 via Frontend Transport; Mon, 5 Apr 2021 20:50:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba37e21d-a23e-47fd-ee50-08d8f8748336
X-MS-TrafficTypeDiagnostic: BYAPR10MB3126:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3126FD704E9F7AA8C23CA7A5FC779@BYAPR10MB3126.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40e5PASEyBsBmvBj8CLE6HpQXJGTqtpkih6q0QqgfVzS0foo/Buakjev11zYMMnbRDJajobu6JCs0NxNkel9UHiLvxRWfzUE/qJi30P82ODBJz2omOri9JwpSMshZPfe6v8AZIwiGVV3K7ZDS3JP3dR6yZ6//nO746aT3TYsqYm7HD57bUdRb+8ujPE0h9I73yyLn+KSQVu+RM8avvZ5X/pVM5Hs3QYTslLycabcWW6yiWAh2aBvKzzsaa6aF0Bp2Qd7kxOnT69CIAPAJtGxXyCTaFm0+4abO8T45lblmHL75lU9Dv/V2yUwOtKq406d/h3l3oL+RtSoUpxrmOe5oBjzUyFxPxazv9nONRofvUpWSo/WUqp5NZuWrlw18sOE79u2xapHPuWzzQXEE+9V3Z0+sPUTb8Ji+ddobcODcH1/AFBjiUQWUTlI4YnYlHm55nSMxalTxnUcUwkuH8TPM87MhJQTgJwXCSmvvCMQavSdzcbc5J8YMgbszhq4nWj9qKfBiunQfBvuEnGLKaUJqkx7MfU5APcjRtmqYv8vhUuUGJ0fPba//MFJJOMz93sZXlDe1Ugi+o9No2HAZogKm6pCzAQ/N7r71lbfEbXMbmJrhgV3Qc9XG12mbSzHCqDi21qSkFdTb/tFXM9NWnOvVIlB6veI9BYDYMKC9t1HKmwU4gz66tPs8U511ktsaj7U/ASrKEBCuHEOR/zG8vqa5XcI9DlfE7zqdpPVeHRRXj7A89gK4sBAm+XQG1uCXi3sk+6N43yPC1VaBzSAEDj9xsLpNFyxRrWzPEj96QUHJHCHtIvWag8PGH7Daj0w8LRG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(396003)(366004)(966005)(66556008)(8936002)(55016002)(66476007)(478600001)(7696005)(66946007)(52116002)(8676002)(53546011)(44832011)(38350700001)(86362001)(26005)(38100700001)(186003)(16526019)(6916009)(5660300002)(1076003)(316002)(4326008)(956004)(2906002)(102196002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Y0w8Bvadp/wMDWgpb8yY1pf+DbrHYrCqQKrt8cc6m+1zuADnJ3wu8V4elvab?=
 =?us-ascii?Q?PcwNbCz1K8ZKTHHuXEFZYC058I6M9ggEdi1tc5csn0DkFlzj8jgN9qd8YnoX?=
 =?us-ascii?Q?E+Sel1K9cKyTgssSxWi/FIi/HMRv84gbEZ8oQPsm4Gm8VQlQKlkyyP2RuyGu?=
 =?us-ascii?Q?6H9zO4WED1ODE3IFPRmY/6dpXpWAEIBCNjEHZ8Fm3UGRuxMXqUsnbcskO6pK?=
 =?us-ascii?Q?zAp9DYDJ8y9VYyxYL60WDtl2uhZ2T3uGdlBLE7nZsQ9gLHtLhWhPV4DNGRz3?=
 =?us-ascii?Q?Nq+6Zh4yFu0n9lK4F8vDmL+N0D11Gcv272gOL1N2mD4uSGAzgEVBc+FxB0ul?=
 =?us-ascii?Q?w3oODtORhegVLwnOn6W+Qm9xeYy++IJmnNzrIcxR+mrsdsSJF3ZwVhFQCAKM?=
 =?us-ascii?Q?9dGVj+Egk3g+DJsQ5DR66HX0BwL/nq0zw+IgsLXZJVtT8iO7yiRj6eFy3Zxd?=
 =?us-ascii?Q?VfMgWj8CxJO9Fd5Ex3SdvWmNhSMM4tJMLNy9+SBC0f+lw3Pgav2IqJQmoMBv?=
 =?us-ascii?Q?SEy8mYDnsIaHenxwkuVcgf3B+ypytSIoPA+NCfAi3Ak4zFh+5XsCx3LzQxaC?=
 =?us-ascii?Q?IzpQZprVWfD7AGWxdaSFD5Io9jVBVG3wRfQWrivo/zcaLVAP3oBxeYJJwB/w?=
 =?us-ascii?Q?m22wgkJrGWoCS4OAD1Dq0eg9ARL35QvCvAW9Mx5J90hvA1nFS3+jPkdWbAO/?=
 =?us-ascii?Q?mIXqa91kGLIcBAOI5dL7AwSyLWgaaKWm3ryogswT6RKAA5km6IQ+URABzaKy?=
 =?us-ascii?Q?q1YXg+EaICuIFGAect43ysWxduoutWzKTLwy+fK1V6HoYmtkY7RTJEU6K+c+?=
 =?us-ascii?Q?+R1SRSUOSjRgTTPsl7zEh9cBuXlZsQm12Sk0vruO1j8DClgs5a1Ynf3xUxBW?=
 =?us-ascii?Q?Ph99CwG5HrTG9s1LhqEyGNeFOsigygBaYnpRwmy2O1r97U3pmusDxoJcCLWj?=
 =?us-ascii?Q?/znSoL8E4eotzoQqcflfyqXCNF3mqhJfHrVD1j6KTNPRDbT3qC/ExCOG53GH?=
 =?us-ascii?Q?8G310aDhnaxVChUI7Y8yuXwCOd9kVmqiUCDgOOwPoCF445gQiyKvZU8HUjeQ?=
 =?us-ascii?Q?UY6zPm43QGROEHbCsqNSpWy+z28bGMoBOxSGpvmcaXet7spGQIvKkdwDDjL4?=
 =?us-ascii?Q?yEjNz3L+5+7cF/p9QvG6mkp8kyC7x3liFsPU/UVXNAABoPNf78c6TWRdjXtn?=
 =?us-ascii?Q?T+0KWNN+NvpI/QurIiqZhSuFIxO+1yd4E2Mwb5bdPh/8OuiK9dD4YC1LWqlC?=
 =?us-ascii?Q?gDBEXVwjB1VhuhuIqgVn9UUpCveKxiNb3mrfzR5xsJXyvPVsxXuArmRlRsaH?=
 =?us-ascii?Q?mpoxSelI3uHMabS4HF24OgU3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba37e21d-a23e-47fd-ee50-08d8f8748336
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 20:50:57.5654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2WKi57nzAwQxJNDSG2pxKnmwMRTBZevjbrYlQoIkMzBH8M47P9ajahq5Mf5qvWlEuwwLH5C1CT1umyKNfGA/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3126
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050137
X-Proofpoint-GUID: pLIy_0k0kPr5HKGf0WK2Of9IKr_-RYke
X-Proofpoint-ORIG-GUID: pLIy_0k0kPr5HKGf0WK2Of9IKr_-RYke
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050137
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 05, 2021 at 04:49:29PM -0400, Derrick Stolee wrote:
> On 4/5/2021 4:47 PM, Junio C Hamano wrote:
> > Tom Saeger <tom.saeger@oracle.com> writes:
> > 
> >> $ git config --local --get-regexp "pr-924"
> >> remote.pr-924.url https://github.com/gitgitgadget/git
> >> remote.pr-924.fetch +refs/tags/pr-924/derrickstolee/maintenance/refspec-v1
> >>
> >> Seems legal, fetch even works
> > 
> > Yes.  For a ref that is one-shot use (like PR tags), this does not
> > make much sense, but
> > 
> >     [remote "submaintainer1"]
> > 	url = ... repository of submaintainer #1 ...
> > 	fetch = master
> > 	tagopts = --no-tags
> > 
> > is a reasonable thing to have for those who regularly work with
> > submaintainer(s) of their project.  They'd do
> > 
> > 	$ git pull submaintainer1
> > 
> > to accept the work their submaintainers have done.
> 
> Thanks for the extra testing! I'll be sure to fix this bug in v2.
> 
> -Stolee
>  

Hacked this:

diff --git a/builtin/gc.c b/builtin/gc.c
index 92cb8b4e0bfa..8c0fcbd3bb7e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -879,6 +879,7 @@ static int fetch_remote(struct remote *remote, void *cbdata)
        struct maintenance_run_opts *opts = cbdata;
        struct child_process child = CHILD_PROCESS_INIT;
        int i;
+       int nargs;

        child.git_cmd = 1;
        strvec_pushl(&child.args, "fetch", remote->name, "--prune", "--no-tags",
@@ -888,6 +889,8 @@ static int fetch_remote(struct remote *remote, void *cbdata)
        if (opts->quiet)
                strvec_push(&child.args, "--quiet");

+       nargs = child.args.nr;
+
        for (i = 0; i < remote->fetch.nr; i++) {
                struct refspec_item replace;
                struct refspec_item *rsi = &remote->fetch.items[i];
@@ -899,6 +902,10 @@ static int fetch_remote(struct remote *remote, void *cbdata)
                        continue;
                }

+               if (!rsi->dst) {
+                       continue;
+               }
+
                refspec_item_init(&replace, remote->fetch.raw[i], 1);

                /*
@@ -920,6 +927,10 @@ static int fetch_remote(struct remote *remote, void *cbdata)
                refspec_item_clear(&replace);
        }

+       /* skip remote if no refspecs to fetch */
+       if (child.args.nr <= nargs)
+               return 0;
+
        return !!run_command(&child);
 }

