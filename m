Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F36DC433B4
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 20:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ECAF6127A
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 20:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhDCUWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 16:22:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43156 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhDCUWB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 16:22:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 133KLno8124839;
        Sat, 3 Apr 2021 20:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=mgqX8TtrE0tbQOZMLX5evMxanpXCQHl6gR8RPEkX+Tw=;
 b=gUIixxWAFLlOfnBema28aGWWzqfdJZmEu3r9ECZUAsQdGH9AMtBl9ofKsI2fZRakHUDi
 W+S7x8/nDm6JFVSt534wq+IEryFfaKrcqPLMaOTvwgxlWOAA0n6ZX/AXknpArjvKxMMs
 n+7HeMqbHi6oxFpcNCbXGABY5C7yU3wm4e1LfR6xYIFeqwVVzhD3ebw0kwZz10vbt6e+
 QtqXxXVBORskaKKtHrTyOp1d66NQ5KmmNA1iXsYKKu+iO2dxlg+PyoiUk66f+h1NZP3f
 vlwAtL0RuajWW5wR/PyK8DPSQQyTs/yPtMZftxs3SCuWbAc+nuf+pnwd1OJa0RfvEQOz 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37pgam8paa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Apr 2021 20:21:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 133KF41V194273;
        Sat, 3 Apr 2021 20:21:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 37pg61fkwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Apr 2021 20:21:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6VDp1l1LDrfIoskb1S40HBzbFfPZfBbdoAVMedngx4VeHeJmOUauFqxD4YDNFWqOfm16NdAZ2WjraN6bWEm6Uyd64wpbsV03rhZp4f/neOD4uBQcolYvfJHCk7HHqJdhJ7aPLejvNwZnvh3c9JtNiRbakvsBgYGhQrHugdkhym0rM+6wvlARrBCqHrA5KWzhSLmvvWc+fccN3aNdoetZHJJPFQhEP7G9QEJejFVrOrrWuKU4z8kCljE/4fkFtaqzEW9l8TRKKNm4vxdpGyROYZEIMEmzbdxhO2rGXBji+2vxHcSbO8SYqUQ599FfFg+yvfDO4/ibe0Y9yoSIy28Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgqX8TtrE0tbQOZMLX5evMxanpXCQHl6gR8RPEkX+Tw=;
 b=Lzuyuci13sIWXxxMa3vQWy8A+6VAuIT0EduHZLTQe5WI81B6eyOXIUksNjKZtahQE/rVd2i8ZIvFe8UqEHEgHICyq7+7OrNoU6ZsIRcRCVCqRITCdSj9IzVNYpxYvn8mkxoJDNIJKOz8MPkG2KzHucc4M+HEdFRQBBaIj55++JQFu1gaPBbs3VA0qKRCI76MBhOju6kAnmDKx9foKDOgTbbHS0dKDL+7sxkz0l+LiF/bd6unxxJ9PbAA9gLGq3RmsUqtJXn9YEulXbD10i3RGSp2MZwGm1Kr2kVwWsDg/HHTi/jJmcN0lMnNFOLRhDrBvI/lIj2fomdEqCE1Nz8/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgqX8TtrE0tbQOZMLX5evMxanpXCQHl6gR8RPEkX+Tw=;
 b=NPwXgqCeP+xoeJZoJtqpQWcOB18Yl7bm6Jj7lmqwifRi5eGJ6QR2BUNgIK3d0ZtgexEeG21iCCrRSjPMHzm5EP3btaljVnEtFUoZNdiKpdmnLw22Cidx87i/IPoIqjn1aCCD637qFf9RY3tZIOxcWDTSNAYg1Z3pHb5uXPYeOpE=
Authentication-Results: sunshineco.com; dkim=none (message not signed)
 header.d=none;sunshineco.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Sat, 3 Apr
 2021 20:21:45 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3999.032; Sat, 3 Apr 2021
 20:21:45 +0000
Date:   Sat, 3 Apr 2021 14:21:42 -0600
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
Message-ID: <20210403202142.w4b25fhptcaguxyx@brm-x62-17.us.oracle.com>
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
 <xmqq8s613gqa.fsf@gitster.g>
 <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
 <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
 <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
 <CAPig+cRxjLObLvF9kUAuftCxQ+iiFEisagDBWpAAPwdVMUATKQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRxjLObLvF9kUAuftCxQ+iiFEisagDBWpAAPwdVMUATKQ@mail.gmail.com>
X-Originating-IP: [129.157.69.49]
X-ClientProxiedBy: SA9PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:806:27::32) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.49) by SA9PR13CA0147.namprd13.prod.outlook.com (2603:10b6:806:27::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Sat, 3 Apr 2021 20:21:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36e2b267-ab93-484c-593c-08d8f6de1983
X-MS-TrafficTypeDiagnostic: BY5PR10MB4129:
X-Microsoft-Antispam-PRVS: <BY5PR10MB412969788170EB20EEAD372AFC799@BY5PR10MB4129.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3OZuRacrbXRoECJ7maLB9v54N39JZF/YuYroIZGoHNwQ7CFxpnnn9dgM3lt9XTFBM0/XKdNLrEK3wBSIFe1dTDzkmBjoTQ57E79WHCxqwPOPj/y3UN9/KjJGChx9l01EOjte/oUP2lHXhjDExrCIfKVh01Q6fGXG9LyyKEKyT51RDz6sZyqHrIe2CA8sEZ0tkRQKB/hPhNIqvTHXfeYFl03fM3MDvfYfUt6hPV90nuf9Nn3cJ51WUDFN2kl3/lFSq/eP5h38Em1L++2QoTSfbjUxL3GzCW8CuCQL896PjEaGzItNmHERsmlid3yb0Jk/27nVkWRBU3LJ4Cw2hABJcFcFGHhPJ3EkVfKKeSQ0YdB+p1UvA/HKi0NokgXeeGqu9mzzBl51myN3HMzpRmdz5XqjJ3HEJNjnZND+JLXYEOnU8J5iK3uBbihEFuhQriTy9kG2XSoxQxlDbDxgJsUBwbagtmZjgaeec/d/LwmHv0hIXmykIruZve7RanZKnzqiD+ux54RueEllZnZDG0uUbGj4u4HCfQrIsqgIhN377IwQwKAPf8YD05rQRZzv4jUtKv9PtG90JsxBnFmbfwxhd4BzzxHoEA12jXXb2H3OsKrFTVbqHKh6VxhvY7s9Nq7QKmJGY8lQpZ7xqYteW/UaoMZIEq4Lxo24s054k8Et5sHEsp3/3QrH67xSYFJgWVizyPqG/bdQfbeJP97qi9XZMxdQv9BquFv5Vg78+haVg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(39860400002)(396003)(6916009)(54906003)(53546011)(478600001)(66556008)(8676002)(86362001)(4326008)(83380400001)(55016002)(5660300002)(966005)(16526019)(66946007)(66476007)(956004)(1076003)(7696005)(186003)(44832011)(52116002)(2906002)(316002)(38100700001)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uSay5XYOxi9YO8IQD1V8lNTqCYhx4qVW8jgNk5EotcgJcCo/FLQROXlmKRLm?=
 =?us-ascii?Q?yD0MLW8B9hqs7zP5qX5wHZdphsuClZ60i4No6khUqo60nmoK3Hbu3qoZNVV5?=
 =?us-ascii?Q?VLlKb4QAc/7jVe7HteJHiFp8tNIed1UYKXdAnA9zXGAeLN966MpW50hF6DP0?=
 =?us-ascii?Q?SneZot7Si3zMOEQfs0o+2yS4c/HT1m+YqbqEYPbvt33yhHQ1QaRTI494Y8YA?=
 =?us-ascii?Q?QX2hU9+iXH+ZqNMhlfntiAhbz+06+0CC5Z2sfwGtkG1Ibb8GysQLHfqv9pAM?=
 =?us-ascii?Q?tls2lITx2LDIzcOwHR6QOH9CbmGsRCGw5Rs1f4P7ILlAw3Jkb/WKNZU3s6um?=
 =?us-ascii?Q?TpZzhZ05t8TwnnzArnYZdC3bgveSrFL7D3AWzGpKvwGziyEKfNa4sYcPXNmz?=
 =?us-ascii?Q?1lRNffzoS2Mp7o52xMlwifYhI3O4u2ZR7N/niHS5b1nyorwMwYiuG2CMNgbK?=
 =?us-ascii?Q?uxQAL6LMAi+mF4C7Q+wH83RZW2rLtzbdzG06j7/t8gyfoK7uD+YUm4JvKTxB?=
 =?us-ascii?Q?2h/2lzdiG5uVXaJ1Rp3sL+oYXRDE+xy32Nijbn5lhoBZhvAKM7PJW0qOMDOD?=
 =?us-ascii?Q?5WXojHONxNqlYDDSimql4JZIdgITBxJRdL6oe/IucE0kyxv7HiF2/oaWQAxo?=
 =?us-ascii?Q?PXNbiW0YBL2N5WEwA/XoGcYdgCEx/Ztj5emXsYYyX+nValuR2sp6R17LEXRN?=
 =?us-ascii?Q?QdgndIneCHMp7B4p4FY7blwbRFGmYCRMAmyVb8itUdRk8UjEf0bJgyCxG2qq?=
 =?us-ascii?Q?k4M6YioN09M6zMmfgMNYfulWCyhyZnlBjZxRVITk1yXYm1Z2a9nX0YeV9eZH?=
 =?us-ascii?Q?brINxDxC3+XtrHb9V1kNjxZIBXtOplPhsLB5cnCmVMa3BjocADTfPwunnCcM?=
 =?us-ascii?Q?YD6zWSnth/5Dg0rgK2ICSj6A4jcYeHxqh8BL5srP79JqZXBkWltFmTtmSTSQ?=
 =?us-ascii?Q?e/lcaxQq6rxd3w2JIKScnea4faOLYgWqDv5GoJovGbRgBsMzzGWZfeKa4DdN?=
 =?us-ascii?Q?IPAAR1IIl82xXjLofPeRktcoT02iUvPVgB5w00P/2SK5Abl+1KRzvr/a3XHH?=
 =?us-ascii?Q?Y0dx7r6fEojmNZAXsf9TiFbEBxxLO3uranioktcXk6ZuMO2xGfMVhXJxAATU?=
 =?us-ascii?Q?lpPEDg27kPFkQPndAs8dO/TGiHMvB3oU5hGn5DAWPbdRvtrP8mRS3wKia+G2?=
 =?us-ascii?Q?xOJtAvf84+0KflM5ECNYMtPVU7B6YLLsg6RbRX7CIzmWPq28DuC8PEALaYwQ?=
 =?us-ascii?Q?i56IeDccpgffWF/faCcQLToy3pntJHtHLB4/fRFWDRtbkwPUdkPNNdvkz8Wo?=
 =?us-ascii?Q?ho0+Onw+gJXzKf1itgCrCMXF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e2b267-ab93-484c-593c-08d8f6de1983
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2021 20:21:44.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/6zZlYJxx3EO7d/WgolZ9SzfYHkO/V607bP9JF9ue8EDfsygwCncpk8hhxLe/OeUwvXlbtSxsm6mpFHVA31OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9943 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104030142
X-Proofpoint-ORIG-GUID: XyQRuSy8lOFHIabTgOcWT6zO1Gc5EuPc
X-Proofpoint-GUID: XyQRuSy8lOFHIabTgOcWT6zO1Gc5EuPc
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9943 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1011 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104030142
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 02, 2021 at 06:32:56PM -0400, Eric Sunshine wrote:
> On Fri, Apr 2, 2021 at 4:43 PM Derrick Stolee <stolee@gmail.com> wrote:
> > I have a branch available [1], but I'm seeing some failures only
> > on FreeBSD [2] and I can't understand why that platform is failing
> > this test. The current version (as of this writing) does not do
> > the substring replacement technique, and hence it just gives up
> > on exact matches. I will try the substring approach as an
> > alternative and see where that gets me.
> >
> > [1] https://github.com/gitgitgadget/git/pull/924
> > [2] https://github.com/gitgitgadget/git/pull/924/checks?check_run_id=2256079534
> 
> The "+" in patterns such as `+refs/heads/\\*:refs/prefetch...` is what
> is throwing it off. FreeBSD `grep` doesn't seem to like it, though
> it's not clear why. Escaping it the same way as you escaped "*"
> doesn't make it work. Replacing "+" with catchall "." does work, so
> that's one way to fix it.
> 
> However, all the escaping you need to do in these refspec patterns to
> pass them to `grep` is ugly. A much better solution may be to change
> the `grep` in test-lib-functions.sh:test_subcommand() to `grep -F` to
> force it to match literally. That way, you can drop all the backslash
> escaping, including those in front of "[" and "]". A cursory audit of
> callers test_subcommand() seems to indicate that none of them pass
> regex patterns, so using `-F` is probably safe and a good idea.
> 
> By the way, the `coccinelle` check is also "failing", correctly
> suggesting that you change:
> 
>     strbuf_addf(&replace, ":refs/prefetch/");
> 
> to:
> 
>     strbuf_addstr(&replace, ":refs/prefetch/");
> 
> in `builtin/gc.c`.

Was curious - so rolled all Eric's feedback into a patch.

This passes 'make test' and 'make coccicheck' locally, not sure about FreeBSD.

Stolee - can you squash this onto your PR and try it if you agree?

--Tom


diff --git a/builtin/gc.c b/builtin/gc.c
index 98229bda25fd..eb4a03a2b47b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -894,7 +894,7 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 		if (index_of_refs) {
 			struct strbuf replace = STRBUF_INIT;
 			strbuf_add(&replace, raw, index_of_refs - raw);
-			strbuf_addf(&replace, ":refs/prefetch/");
+			strbuf_addstr(&replace, ":refs/prefetch/");
 			strbuf_addstr(&replace, index_of_refs + 6);
 
 			strvec_push(&child.args, replace.buf);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 93ae93b73611..3366ea188782 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -142,8 +142,8 @@ test_expect_success 'prefetch multiple remotes' '
 	test_commit -C clone2 two &&
 	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
 	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
-	test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remotes/remote1/\\* <run-prefetch.txt &&
-	test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remotes/remote2/\\* <run-prefetch.txt &&
+	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote1/* <run-prefetch.txt &&
+	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote2/* <run-prefetch.txt &&
 	test_path_is_missing .git/refs/remotes &&
 	git log prefetch/remotes/remote1/one &&
 	git log prefetch/remotes/remote2/two &&
@@ -169,12 +169,12 @@ test_expect_success 'prefetch custom refspecs' '
 	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
 
 	# skips second refspec because it is not a pattern type
-	rs1="+refs/heads/\\*:refs/prefetch/remotes/remote1/\\*" &&
+	rs1="+refs/heads/*:refs/prefetch/remotes/remote1/*" &&
 	rs2="+refs/heads/special/fetched:refs/prefetch/heads/fetched" &&
 	rs3="^refs/heads/special/secret/not-fetched" &&
 
 	test_subcommand git fetch remote1 $fetchargs $rs1 $rs2 $rs3 <prefetch-refspec.txt &&
-	test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remotes/remote2/\\* <prefetch-refspec.txt &&
+	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote2/* <prefetch-refspec.txt &&
 
 	# first refspec is overridden by second
 	test_must_fail git rev-parse refs/prefetch/special/fetched &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6348e8d7339c..e9a1cf3e227a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1652,9 +1652,9 @@ test_subcommand () {
 
 	if test -n "$negate"
 	then
-		! grep "\[$expr\]"
+		! grep -F "$expr"
 	else
-		grep "\[$expr\]"
+		grep -F "$expr"
 	fi
 }
 
