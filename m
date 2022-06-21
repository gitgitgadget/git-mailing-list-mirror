Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33EAC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 13:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350531AbiFUN7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiFUN7v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 09:59:51 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABB513E08
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuXTvyN57pF9fjY9x7Wl3VRUG/NfNYqCqRPxS0IYnQ6i7fAC72DsMxEC/PNlSap01lSahq6RlOThxVsdceJwGKbl3RopOh+Lu2MbspdQK0T1BmuU2zq+l+KLD9o137UZqTN+pzkfDyRsSw4CKMJ3VOxU85RqdLiRmm8cfdLdGIe2167f1SkAuQ03sfbt+94Ll5WSUkzZZLHcuw2EoDseOuBtnFFhPCY2osHjwRmN4mR5qnvwVNDb2IAPtadY3IjjjZeT6x23LDCoyM/IRpzlvgQp25Y+8qTyaJzDW9HHM7EcwUooEXHXI2JF2xWyBpzgAUl2YVa/jVemPKfpunPLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ORM+eDn4ruRZ4hmh7PK3zhB68zKBiOnjuD7gqQ0ZC4=;
 b=DvM/ryaB6E8zjsd7kQSP6lN/tVq45AZ4l9pMq7GObq/WbJAD+Je2ZscsOU2fy2I6KCGQ+8KM4nf6bUUGJO2jqiz2NelMqPUnJrD45ttavcjE3EbvpXmVwu3L+cns136D0A9Oi4ESMjVu/Oe3sG/AWnDp4dc5d0a3ZIsSNsXoyJGV7RIecM713dtCJ8h+soroNXHZq9St1aH9R+zzoHc8O1B9XWJt3cU+Nvi+l+2/3MWqyYJMTE5NBcflemP6RhQywE2xdN4VxnEZIwzCwX/BAIrvL1XZhyxPijC+of+tTsV1Zsgm6rczD50LiJrjrISj3UnKUjylpvE928l30Z9AYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ORM+eDn4ruRZ4hmh7PK3zhB68zKBiOnjuD7gqQ0ZC4=;
 b=Jk5a5vTkk1PqGZHEfGNiminAO6EXU2DnMY1OBv1Yx/kxoYjdPv+jtdQMRdtU43OLU1NB5J2VoNW6wJ6X6NgqBxgW72Td/GbigbW4vx9LMFIJXbDq7VMV2NjVMfNyoJ6uVNJtVSlozHY/eSCpTjovc8zEMkdBbjrtrryV7TimJsfZkMQi2wVY462fSQSxUS2c9bpPYaSkaGpVRzOoLa0gLtXQdwTFDBicgWJWRg1BywdjgSdwRUrp1/GLhlqONhBrifXaGE4hjTqdIR3EJA6GnLACeZm2Dyk91XSdyEuzghK4uegwZFlr9q7L1KiKZiZPd3Dw4i0jXGd9Cmr35g54KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from CO1PR01MB7225.prod.exchangelabs.com (2603:10b6:303:160::21) by
 BN7PR01MB3684.prod.exchangelabs.com (2603:10b6:406:88::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.20; Tue, 21 Jun 2022 13:59:45 +0000
Received: from CO1PR01MB7225.prod.exchangelabs.com
 ([fe80::1062:158b:2993:5535]) by CO1PR01MB7225.prod.exchangelabs.com
 ([fe80::1062:158b:2993:5535%6]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 13:59:45 +0000
Message-ID: <748f39a9-65aa-2110-cf92-7ddf81b5f507@roku.com>
Date:   Tue, 21 Jun 2022 14:59:39 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH] mktree: do not check type of remote objects
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        jonathantanmy@google.com
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
 <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
 <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
 <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
 <YqkpRE8nykqVv8cn@nand.local> <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
 <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com> <xmqqa6adzln6.fsf@gitster.g>
 <1566aed1-a38f-a9ca-241c-21b56d732328@roku.com> <xmqqy1xwtsds.fsf@gitster.g>
From:   Richard Oliver <roliver@roku.com>
In-Reply-To: <xmqqy1xwtsds.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0270.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::23) To CO1PR01MB7225.prod.exchangelabs.com
 (2603:10b6:303:160::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdb28fe8-d95d-4cc8-aff5-08da538e4c18
X-MS-TrafficTypeDiagnostic: BN7PR01MB3684:EE_
X-Microsoft-Antispam-PRVS: <BN7PR01MB3684566A64C9D5C9A3093B26CFB39@BN7PR01MB3684.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9WTBhrYvhdePh4hIJQesq5/wtwp4dxxKoi3WdryJGtzYg2t5gtOcbGqcSWc2WAMuYyvAZE+lXuE0Iixmf9qC5Uxyr2FfAFTf1CUThY8T2wncGGnm/NBwDruDDrDnEIVGEk3+ZKVKrpj65I2f5ipEnAjEVAHdORe/IMGuFwR2H5P22yx9R1K9n2Ssr4RLMY6Q3eJukQfAT0zefdFWP7RDDx3alIdM/232vZIglXzwajPi9u948BGnouQ9dYrJQLBX5vsSt/PjVzMImYI00PZHBP4wJzAbFup9dkjzENhdD5fJO79iaHmqDj/E/A39aKaw/CCF06yXjCj4FingcngE/7oBZ+m+1LQNPots4KtUIM0Sp9rPrWGuMuiRtACzBSTaCsXC7bX5NKxRpBc31FEI9a3opZWRy8MJ+UXRiMH0g4XiZ4iqvaX7KQzFAp7wSoJ0Q3xQA1+K/EeOP1CCsooJXpeSfUrkdSB6FLemJbxsBZuU4amDrMaSfb09RuOuJ/ckfm5QJ9o/7SxywUe8DYpIiY3ZbDwT3iGEq2+qQgF7DcxFOpJ3DAWLuSZ+TX1tILRyEPQehkRO+l3sYSspHwTBumu3u8wlRUyUgXuUpZZVqjF8Oqn6nBJHGdtYX4BJbDIZ+RP4wwxjpTF8lSo/Di3Z6KgFobXiYq0ThKahyRScBRekXVLQt/UWFCRidaj6Vvjm3fCexmRtzIFEEGPHeNN0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7225.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(136003)(346002)(376002)(396003)(366004)(66556008)(66476007)(4326008)(2616005)(66946007)(316002)(8676002)(41300700001)(36756003)(186003)(31686004)(83380400001)(8936002)(478600001)(6512007)(6666004)(5660300002)(86362001)(31696002)(53546011)(2906002)(26005)(6506007)(54906003)(38100700002)(6916009)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q01TUmthQ3FtdXdiV1dUTHVMZjNoM1h5VE9vNjBlQU01U2pwNllOVkY1bDh6?=
 =?utf-8?B?TDVycnpKNnBsSkNsVno0RmdNQTNuMlhaNWw5aE8zRUU0L0JDSlFJZFl2bC9N?=
 =?utf-8?B?OWk0dFV5WmFpL1BtLzkrc3p4OFkramd0MER3WllzM3JxS0RsV1g3VmI4RlRT?=
 =?utf-8?B?Y3crRCs1OHFad0FnUjhxNW96cm5zTU5VTk04Q2tPOThzNlViZlpaWTNrNVYr?=
 =?utf-8?B?b2xCWnZ3S0h3a0ExbnJrOVJuMEVSazYxdDhiMktkaDNjZDV4WVB0d0pNZXJz?=
 =?utf-8?B?RkJSdTlDbVdiTU1VdEFheXo4d1k0RU0rWFlielAwV1FxL0JPc0VmZFlEcC9C?=
 =?utf-8?B?dU44QVREN1pRNUZ6MTE5b1pTVEVjeGtOY1pOYzVaL2tRUjhEYkI5ZC9FajB1?=
 =?utf-8?B?WW9VTlhydkREazg4OFE5czVtM1plL0lHdEIyL0FLallvR1ZzR0dPalpYTXdu?=
 =?utf-8?B?eTZoeFFJWlRaL2t0dXJPRDIwbHU0M2ZlRmdYRDVZR1pDaFZHcWJ5dk9DQUxL?=
 =?utf-8?B?WUVNcmsreHE3RGsxd3N1SlduR0hKdW8waXVaaEltVklZclhhK2NKV0dNcjY1?=
 =?utf-8?B?blo1eFhZZjQ1T1pQbHlteWV5cGNQZ0FWSy9MQ2tJVkx0N1UwZS9pUEQrejhM?=
 =?utf-8?B?OTYvN09ZZkhhTmNEcEpNNUJCZ1k0c0lOUG1JUTRBM0hKMEl3YitNUHdac25K?=
 =?utf-8?B?WHhrVjVnQytaQlh3dVpaTWVPUkd5aXJEN2x5cXB4azk5WkNTRUNHU1lHb2xZ?=
 =?utf-8?B?ZGhyZVZvQUhyNHVBMjk2UmNTMWU0KzJIK2pHUEJSUnNiNWFVWEtCVWFCcW9Q?=
 =?utf-8?B?THVadHBWL0RwNU9HdFlhaDdpczltL3U4REt1bzczWWl2MGRIRXN3Si9ISFJ2?=
 =?utf-8?B?N2k1Z1lyQkVQeXNEMElUOFNiTCsxaGdLZjZOYUFTaUg5cU43TGxJNEhaVjJl?=
 =?utf-8?B?TUU1QVpXQzlsdGdjdGdmQXltOXl2MmpPSTB6YWQ0SVArcTlSUHpHMlFCcEto?=
 =?utf-8?B?R0ExaTJWajJITjQ1V0M1aklDci9EYTUyOWtidWlBWTJ6VlhlTzZsTWhMTGph?=
 =?utf-8?B?WnVjRUVMRUpRaFozRmNwZ1pUUHFRNXNjZVkzSmV1Z0JpMFduMFMrQmhlekxt?=
 =?utf-8?B?dmZIU2tBam9TSEpXS29WSGRxRy9xWlM2NE00RjFtaTZwS2x1MktOYy9IUzhK?=
 =?utf-8?B?ekNPMUUyS3RFY3BRSmNEZm1OQzE4ME5JNW1uRUJPMldLRDhuaDZlbmtTSnBY?=
 =?utf-8?B?a01hbGx4RjZLSUhxR2NLZHhJVkQ4Nk1IWTZsK1ZXZndlci9FQXdSTzhjK2lF?=
 =?utf-8?B?UUl0OXhqY3RMZWROWk1wU2hVejdYeStRT2tRdko4ZXhLVU5Ia0xsdExybEVX?=
 =?utf-8?B?SFUyeFpYcGRLS0hIRVYvSFpNMk5DM1Z3TjNKQjBEYzV4eHlUY0crVnBEdXFH?=
 =?utf-8?B?UmRnWnZTbHBIYzFtWlF6S1ZOUDNTTkdUTjE3Z1hCVHZGWmNiL0RLbzZ6eFJ3?=
 =?utf-8?B?UHYybkFlbWhONkl5TnlnUTllbWZHcDRWak8ycjY4Wm5FeWhmUHAraHgxU2NQ?=
 =?utf-8?B?Uy82cEF3VmdpOVFnbWJtbUE1d1prNW0wQ2REMGNxRUV3L2dMTHBQZ2NDS1RF?=
 =?utf-8?B?bWJqSlFYVUZYdjdsdDRpU2hpZmlsYzZpbDhrSkhyZVcrRmhhOGd1My9rUGhn?=
 =?utf-8?B?VmF5d3dnMGxuMm4zM3dGeC9jSWEyR0UrTEVFUE0rb3dPOGNVNnkxVnNtNGto?=
 =?utf-8?B?TVh5U3hXRjdXckgybjE5dHUzUnpxdUl0WWZhbDJ5dGNYbjBmZUhPMkNUQ3hC?=
 =?utf-8?B?Z0gvYm5qb2VGblJpdlA3alU4OXg4V1NIVFJFZm9LNjRMcDJZUzhSVytZbzMv?=
 =?utf-8?B?RFcwNUdSb2xPdEtRZjE4dVIvTXo5bmV6NmxINFovMUFGQnVCRHBSclhkcG95?=
 =?utf-8?B?ZVNOSDBJbmNodDRWTTlpaE5IVkFRblRPVGY1L2ZlalNtZjE5R3FxVlNndFBm?=
 =?utf-8?B?U0lOMjlZMWpqUzJCOS9TaEd2dzFSWWFGM1Rac0V3K3BhMEhkd0pLWUxyY2px?=
 =?utf-8?B?R3FtcW80MUdaRDl0bzZiWGF4allIa2lVRDZTN3hLRmdoMFVqUlZOaXpnaXNw?=
 =?utf-8?B?blp3aFlEZHRiMjk3VnZXYUN0R1BQNnVWVFdXZ3p2TTE0OHhuNFRjVjM3emtw?=
 =?utf-8?B?R1JIU1I2MFM0WFlXT3JSVUlRMWRvQ3p0YjJWOGl6b0JZWHJnTHhJNjQ2bnky?=
 =?utf-8?B?T1lkbHFIL0cvMzhJa3QxOEQ2Ni9Ha2JlencrNU9wSHVEMDExS2FBcEd0bE9H?=
 =?utf-8?B?NlpzRUxrL0lybm8vK2puMWF6Ui83OHViSFhJaE8rcmtsVVlQQWNJQT09?=
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb28fe8-d95d-4cc8-aff5-08da538e4c18
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7225.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 13:59:45.6306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlKr3nf47mogUzOJXn4YFaXTxnN7QnKBQZig5tHnZO1RqrVNNDNxfV2wHtn5BG4rZwByjPZOIklp1DWA1C3wnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3684
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/06/2022 18:44, Junio C Hamano wrote:
> This patch would be a good first cut as a starting point, but we
> probably can do better by doing oid_object_info_extended() call with
> OBJECT_INFO_SKIP_FETCH_OBJECT bit (and probably QUICK bit, too) set,
> with the current code structure.
> 
> And when we do so, the title would not match the purpose of the
> change.  The verification was disabled with "--missing" all along
> and that is not what we are changing.  What we will be fixing is the
> wasteful implementation.
> 
>     mktree: do not check types of remote objects
> 
>     With 31c8221a (mktree: validate entry type in input, 2009-05-14), we
>     called the sha1_object_info() API to obtain the type information,
>     but allowed the call to silently fail when the object was missing
>     locally, so that we can sanity-check the types opportunistically
>     when the object did exist.
> 
>     The implementation is understandable because back then there was no
>     lazy/on-demand downloading of individual objects from the promisor
>     remotes that causes a long delay and materializes the object, hence
>     defeating the point of using "--missing".  The design is hurting us
>     now.
> 
>     We could bypass the opportunistic type/mode consistency check
>     altogether when "--missing" is given, but instead, use the
>     oid_object_info_extended() API and tell it that we are only
>     interested in objects that locally exist and are immediately
>     available by passing OBJECT_INFO_SKIP_FETCH_OBJECT bit to it.  That
>     way, we will still retain the cheap and opportunistic sanity check
>     for local objects.

I've prepared a patch below as per your suggestion.

As a side note, do you think we need to re-work some uses of the word
'missing' in the documentation? Some uses of the word, such as in
mktree, predate the concept of promisor remotes. The partial-clone.txt
documentation differentiates between missing "due to a partial clone
or fetch" and missing "due to repository corruption".  Would making
such a distinction elsewhere be useful?

Cheers,
Richard

-- >8 --
Subject: [PATCH] mktree: do not check type of remote objects

With 31c8221a (mktree: validate entry type in input, 2009-05-14), we
called the sha1_object_info() API to obtain the type information, but
allowed the call to silently fail when the object was missing locally,
so that we can sanity-check the types opportunistically when the
object did exist.

The implementation is understandable because back then there was no
lazy/on-demand downloading of individual objects from the promisor
remotes that causes a long delay and materializes the object, hence
defeating the point of using "--missing".  The design is hurting us
now.

We could bypass the opportunistic type/mode consistency check
altogether when "--missing" is given, but instead, use the
oid_object_info_extended() API and tell it that we are only interested
in objects that locally exist and are immediately available by passing
OBJECT_INFO_SKIP_FETCH_OBJECT bit to it.  That way, we will still
retain the cheap and opportunistic sanity check for local objects.

Signed-off-by: Richard Oliver <roliver@roku.com>
---
 builtin/mktree.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 902edba6d2..cfadb52670 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -116,8 +116,15 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 			path, ptr, type_name(mode_type));
 	}
 
-	/* Check the type of object identified by sha1 */
-	obj_type = oid_object_info(the_repository, &oid, NULL);
+	/* Check the type of object identified by oid without fetching objects */
+	struct object_info oi = OBJECT_INFO_INIT;
+	oi.typep = &obj_type;
+	if (oid_object_info_extended(the_repository, &oid, &oi,
+				     OBJECT_INFO_LOOKUP_REPLACE |
+				     OBJECT_INFO_QUICK |
+				     OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
+		obj_type = -1;
+
 	if (obj_type < 0) {
 		if (allow_missing) {
 			; /* no problem - missing objects are presumed to be of the right type */
-- 
2.36.1.467.g4f6db706e6.dirty

