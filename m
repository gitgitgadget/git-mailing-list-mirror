Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B656FC433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 10:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbhL3KUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 05:20:55 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:58947
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234946AbhL3KUz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 05:20:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zzg3eOz2xwv23yQw8Ec6lQTlQcm2nqgxSH5a/rkx5j4uCwtyhtH4r6I922j5gJYWwyFgye9G1a9HhbYSJMteSXhn39NAhMoOln963sIo7elO4yY9IlKjFJ37LRDN4U1cynPbGRSeq6p8MFWJSXG486LIYO4hUrjk4DQ/MpR0s+ekmcNF3VbD0Fo9oNDC9OPYwMYjAHjXPUKV91kprx5gTDz1Lzh78L+FSnt93uv4gy6r8Zn5uPa5UXUmY521Z8SghIUE+veRjpv3urjaMlg6cdQ2r9X9CUonb2Q7/5n100t/eGZeoBrkbPl4qRdlpSk5yi8t2UvOK7lN98VWLunGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNX2WTd+2jbO03TpH6nczC56sQXB+dyW5xzzpDviTlg=;
 b=eIrjRTIZnCprvw+f9ZFAqsqNbXtH+w0bGBElkiCvoA+kNvpR5qGIwUWiu/l5KHIngbmNn5wlluEe/JbFbjT4XaqhLnT27hKirVdkxgbD3R5t4/liGckqAhBpjYjON5K7QTtzfdznJcZdbTI5pVXO9w57w75ska+Xp8tDRzpQHVv6+DK39F6pdZT1bCIcFv5QaBNavF5nmgdH8ol4glmKGRzAbbQOyJClKTfMbiAMatZXP2UG1mMgoxS8jXUHeNCtXUznSCIQWCkuhPGpVxcsPmjaHkCK4lUZkJ4omwctAXMxx9BzDKiWU1ojlOQHQiTY0YSiVOoJorV4A3yQkkJPpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNX2WTd+2jbO03TpH6nczC56sQXB+dyW5xzzpDviTlg=;
 b=r/BwDTteKZ4FiReDBl3BRSSNcLQ3BTlV+H2AO2UwKXf7oCGeNI7JsRv3cEUmSDuHBHd2AN6TpMElFirwEt8etJk0RwP7CicxR+0NOCoHqjSpU7zi0Wmzxdy2LHqB3s/7K76P1EMibK8uwldXdmeWBVzi/Vdv4kR7txLc/hni+4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3883.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 30 Dec
 2021 10:20:52 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4823.023; Thu, 30 Dec 2021
 10:20:52 +0000
Date:   Thu, 30 Dec 2021 11:20:50 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2] SubmittingPatchs: clarify choice of base and testing
Message-ID: <20211230102050.oe2t5pavijaow5lx@fs>
References: <xmqqa6izcwio.fsf_-_@gitster.g>
 <xmqq5yre7w5o.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq5yre7w5o.fsf@gitster.g>
X-ClientProxiedBy: AM5PR0701CA0005.eurprd07.prod.outlook.com
 (2603:10a6:203:51::15) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66652e7a-a8d9-4036-6acd-08d9cb7e0e6f
X-MS-TrafficTypeDiagnostic: PR3PR10MB3883:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB3883D3AE32AE084CAAF9EE96B6459@PR3PR10MB3883.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ir+1N/+n1oDN+wCaGHxtIyuY7CR//j4CIQaPvtdihyeUa6EO414PW+jUDMDDnvh+TUfKcGnYipfi1ydcN8aB8uLu7rGRhMD1C/3+zmFjVMcT1UhGB1LnMV57CKrSMitc/3uYxeVqZnLZNjMbnta0BinY2G60mwjCPRtnbgsGvnHWRNSAcs6C73HSglOEqjLfNqINkBdoEPUDXfUWnpMhmGwl+TtOVKYNsdW1o5GLZBvhOfEGg87e7GlV7ynuTzAdzDIy2ioxOrQxxa5KO+4TpSjuL5j5KF9H9aNMdrjv36lGswX2RyCkLneAYwIa85J7G0TG67AcaM5KXZFa0Sp64bB9Uxm/TdnzLybg0cEQHXB59Sy1LEaiP8cXOQ1e/SYHA0/uoWk88gae2SeUBtTTJBptbLu4Qx1NFDI2Dtfu/DQpCL50R62R8NSrz8TbYlS2LGCee3UApTo8qxZ5z17DjJgWPaavOkw1Vq0xlDLjFi19RN8rt8lVj6Uf+LJwAP8/cFnoVEs3QJXq8Dgc8bcIpL/PVclMHiP1KSGxh0Osc/CzbRoxuAzn/0fnZjIcwMfWDA08J4NPwVVk3V0VWV0c42p1cuxGMn/j18BSF5DaBKm6i8dlm4dQgCVwa0iiJt+qY2MlUrCzh2faJSbjevD/Z9DstkMNmFqLSzsZ3b0myAlDd+RqCVt5qvNuDbEUYyyD2c/dFI+tkv0fQBNgntYmEqh/sOrkvyEPHoGyQU0fciw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(346002)(136003)(39830400003)(376002)(366004)(396003)(6916009)(6512007)(86362001)(6486002)(66476007)(66556008)(1076003)(9686003)(508600001)(66946007)(4326008)(53546011)(186003)(5660300002)(8936002)(33716001)(54906003)(6506007)(8676002)(38100700002)(966005)(2906002)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3VpdjZnNU9Db2xGSHQzZUpwa1RKazVCSXF3M0kwd1pWcWVJdURLckllQ2Zp?=
 =?utf-8?B?aTRhYkFkOFBmYnhrMWpjdUZxTDlycFRZQ1VJYmUvVTBhMGF1ZitBTUV2S1Zy?=
 =?utf-8?B?WnRDdnhEcFFIYTMyN3lISUxhNHp2YmRubGpSTHQreDZIeVNpWnpzZTZuSS8w?=
 =?utf-8?B?TlhCRlNuVkFSK1JTdktqLy80eWI1VE9pSEdleFRYdHFJM3pRTGMrUndkemQ1?=
 =?utf-8?B?cVc5aVZqcm5wMWIyWDNXemRZeiszQkt6K2lvdVhqSU02TXczeVVGaXoyU3VB?=
 =?utf-8?B?YU0xTi9zeFJDTW1pNWFUVVcxMlpTWXNjSkhGbWo5dVBLZmVxbmtvNmRsZ3JN?=
 =?utf-8?B?QXAxMDBKcWF1amgyOU5OUkQ4S0k3cm1BdUVWTWJPUWdFaDQvbHdQQ3ZCNkJn?=
 =?utf-8?B?a0JIRWc0MkpBNmFPZDNRNmVtaHRjbUFEVUhGL2pOeFJEOFNFWklDcHAwNWpE?=
 =?utf-8?B?OTVVOXVLU3JaaDJNeVIxejZWV2lmTy9QTnl4b3lydmFmNWFlRjlTQ0RSOXpq?=
 =?utf-8?B?cVNoUTJsdFZWaHYveWhvcXY0dFJSZXdOMkUrZ1ZLZU5xdkV0VVBmOUVhS3Qr?=
 =?utf-8?B?dllSeDV1cVYvVVZURlE5VUdpaVk4UDdxYUV6eGFRL3NadGV6UzFQeVBYZ3lR?=
 =?utf-8?B?R05EbHlhTFlPQWJ4QnNSd2QzM01PSmJyRTVVSFVrOVpYTkdmQlFWeFZpbUY1?=
 =?utf-8?B?N3N0VUNheEdmaXpDMlFkUWtIMUhUY1IyUFNjRElNWFFUbkcyRVhFWkwyT29J?=
 =?utf-8?B?QU9mYWpJR2trakFPQ1Q2QVU3cCtCSEZybGpPYVQwUHZHQ2lhN1I4U2dhSDgx?=
 =?utf-8?B?eXpaa055M2czNVBDcTE4SWVTWFFVaFFoMXRBNjhBWkdXVko2U2t6ZU56RldD?=
 =?utf-8?B?ek9ISGJ4SE9URVlURnVlamo2WXJtSlo1bHFDQnJxOERaNlpqa2RHZkl0cElB?=
 =?utf-8?B?U21seTArd2FFRiszRjQ4bG84dWFoRUZxUC9zWC81YkR1bngyNXhFa0tFOHRx?=
 =?utf-8?B?QnhWQVlkUW5JaldPcHFoNVNTK0NaSXo5VnpuTFRlN0NFWkMrZU9JNDlsaHZx?=
 =?utf-8?B?V3JSdlVzei9pMmMvM1A2N0JpcXNoTDg5VnpKeUVhb2RiNjZxM0d5VkhOVEJ4?=
 =?utf-8?B?NE5tdUErRGlMblR4S00wcGRvSlFVc1hpSXNoaWloNXlaeFppTDJVTUFyOEd4?=
 =?utf-8?B?dHlmSVhZSUlwVXErRW1HNitVMThxS29hMno5RHVSaGdseEthb2hrZDVxL3NO?=
 =?utf-8?B?Zi9qNVBPSWNNM3NZL3JlT2VoYWdRWW5Sd0lWaG5sM05ycTdaUDcwZHhiRUdH?=
 =?utf-8?B?Q0d4cklsRk5UQktONFJoL2VYYlZYK1BCZHFqOGxHalg0YWlmVVJZa3N2VXZh?=
 =?utf-8?B?amU2ekFhUnZUckhTSEdPSzdYb2dZNE1jalZNOE1Hb1R6WmdQb21BWGhROFlm?=
 =?utf-8?B?STFZS2VvbWtvV0c5Z2tPWGw4K1lyR3gyaDhyUU9QRHBXRmpDTWZNNy9EUlNI?=
 =?utf-8?B?bUxJZjN3OFltdzBPZXJhZlhRdUUxanNVcHJ3YlpQZGlld0lidzlkUUFPZlRx?=
 =?utf-8?B?MEQ0ZjNsUEVSOEl2dUNWUWpHemkwdGxRVDhneGhNQmYwbkg2UVZiNTVmL2FJ?=
 =?utf-8?B?ellyYytrYks2ZTlvWGpKbFNiSlM4ajBHa25vc0syY3hoYXNySmtIYUlpeDF6?=
 =?utf-8?B?V1k4Y1prQzJDWjNHeVBBNzZnSE5DbnhOYjJQeTY2djJ4Ujg4a1FxVk4wOHNu?=
 =?utf-8?B?aFBkNENRZm82eDJGaWUzQmIxMjhIR1AxU3NuQ05qNGhEa2xwWFZ1bjNOZS9M?=
 =?utf-8?B?OHJGNzUyN0FpdkJKSTlkMndrTDBmR2NNWVJ0NHNYdWtEVkdRcC9sYnlCZW5q?=
 =?utf-8?B?aDVuWWtiTzJTWUpCejlKajV2NFcvQkl2Uk94TVZ0d1hZME1mRmYyMzZkM0gy?=
 =?utf-8?B?WEpYaThheVphL0R6NVhEQ01JUmpEbHkwU09jUnRwVHc4L0Y2QU02dTFJZDlE?=
 =?utf-8?B?Y05OcG5HUWNkM2IwTm83aytYRjhQQkZRNTEya1pXRk1iU21zWlhNNE90WUM0?=
 =?utf-8?B?QjR2R3pVZmV1SExHSUNhRHRwQ0FTSGJQY3hxZTVudi96ZGxod1l4RUZiN1pk?=
 =?utf-8?B?bThnRHJMb0ZlQ2FBcW1HYVZUbFpYQjlnZ2ZWUE5reWM3c2tYUWVEdzN0QTlp?=
 =?utf-8?B?czNWekhub2FUcXdMR0JmRng5czdROGg2azJiMS9UcldISm1RMHRwb1dOOUx3?=
 =?utf-8?B?R2YvdFZJTWU4c2Vieno0bUlKN2NTRVdtWEZWejU3eGVVbGZmMkU2cVJtTnFw?=
 =?utf-8?B?QjJQcDduM21TU0VXaG5sdmZyeDc1SXVzQXExbzk0UWl1Q1MveFljZz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 66652e7a-a8d9-4036-6acd-08d9cb7e0e6f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2021 10:20:51.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91It96ws8/PUxAkJVtO8WFa9EYrX6fTrs690WeoBUOiTBMd9mLixq6Yt0GGZPUf3MVyv8llN+jx7TfEISyeLBdE0TXpfHrY8c/U6yQrrJjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3883
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23.12.2021 15:12, Junio C Hamano wrote:

Just some minor pointers/typos. Looks good.

>We encourage identifying what, among many topics on `next`, exact
>topics a new work depends on, instead of building directly on
>`next`.  Let's clarify this in the documentation.
>
>Developers should know what they are building on top of, and be
>aware of which part of the system is currently being worked on.
>Encouraging them to make trial merges to `next` and `seen`
>themselves will incentivize them to read others' changes and
>understand them, eventually helping the developers to coordinate
>among themselves and reviewing each others' changes.
>
>Signed-off-by: Junio C Hamano <gitster@pobox.com>
>---
> Documentation/SubmittingPatches | 53 ++++++++++++++++++++++++++++++-----------
> 1 file changed, 39 insertions(+), 14 deletions(-)
>
> * I've been trying to clear the deck, and noticed that this has
>   been untended for quite some time.  With some clarification to
>   a place I was even confused myself while responding to Fabian's
>   comments in the earlier round.
>
>diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
>index e409022d93..3c4c5d9f18 100644
>--- c/Documentation/SubmittingPatches
>+++ w/Documentation/SubmittingPatches
>@@ -19,8 +19,10 @@ change is relevant to.
>   base your work on the tip of the topic.
>
> * A new feature should be based on `master` in general. If the new
>-  feature depends on a topic that is in `seen`, but not in `master`,
>-  base your work on the tip of that topic.
>+  feature depends on other topics that are in `next`, but not in
>+  `master`, fork a branch from the tip of `master`, merge these topics
>+  to the branch, and work on that branch.  You can remind yourself of
>+  how you prepared the base with `git log --first-parent master..`.
>
> * Corrections and enhancements to a topic not yet in `master` should
>   be based on the tip of that topic. If the topic has not been merged
>@@ -28,10 +30,10 @@ change is relevant to.
>   into the series.
>
> * In the exceptional case that a new feature depends on several topics
>-  not in `master`, start working on `next` or `seen` privately and send
>-  out patches for discussion. Before the final merge, you may have to
>-  wait until some of the dependent topics graduate to `master`, and
>-  rebase your work.
>+  not in `master`, start working on `next` or `seen` privately and
>+  send out patches only for discussion. Once your new feature starts
>+  to stabilize, you would have to rebase it (see the "depends on other
>+  topics" above).
>
> * Some parts of the system have dedicated maintainers with their own
>   repositories (see the section "Subsystems" below).  Changes to
>@@ -71,8 +73,13 @@ Make sure that you have tests for the bug you are fixing.  See
> [[tests]]
> When adding a new feature, make sure that you have new tests to show
> the feature triggers the new behavior when it should, and to show the
>-feature does not trigger when it shouldn't.  After any code change, make
>-sure that the entire test suite passes.
>+feature does not trigger when it shouldn't.  After any code change,
>+make sure that the entire test suite passes.  When fixing a bug, make
>+sure you have new tests that breaks if somebody else breaks what you

s/breaks/break

>+fixed by accident to avoid regression.  Also, try merging your work to
>+'next' and 'seen' and make sure the tests still pass; topics by others
>+that are still in flight may have unexpected interactions with what
>+you are trying to do in your topic.
>
> Pushing to a fork of https://github.com/git/git will use their CI
> integration to test your changes on Linux, Mac and Windows. See the
>@@ -144,8 +151,21 @@ without external resources. Instead of giving a URL to a mailing list
> archive, summarize the relevant points of the discussion.
>
> [[commit-reference]]
>-If you want to reference a previous commit in the history of a stable
>-branch, use the format "abbreviated hash (subject, date)", like this:
>+
>+There are a few reasons why you may want to refer to another commit in
>+the "more stable" part of the history (i.e. on branches like `maint`,
>+`master`, and `next`):
>+
>+. A commit that introduced the root cause of a bug you are fixing.
>+
>+. A commit that introduced a feature that is what you are enhancing.

I'm not a native speaker, but `that is what` sounds wrong to me.
`feature which you are enhancing` or `feature that you are enhancing` maybe?

>+
>+. A commit that conflicts with your work when you made a trial merge
>+  of your work into `next` and `seen` for testing.
>+
>+When you reference a commit on a more stable branch (like `master`,
>+`maint` and `next`), use the format "abbreviated hash (subject,
>+date)", like this:
>
> ....
> 	Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
>@@ -259,9 +279,11 @@ Please make sure your patch does not add commented out debugging code,
> or include any extra files which do not relate to what your patch
> is trying to achieve. Make sure to review
> your patch after generating it, to ensure accuracy.  Before
>-sending out, please make sure it cleanly applies to the `master`
>-branch head.  If you are preparing a work based on "next" branch,
>-that is fine, but please mark it as such.
>+sending out, please make sure it cleanly applies to the base you
>+have chosen in the "Decide what to base your work on" section,
>+and unless it targets the `master` branch (which is the default),
>+mark your patches as such.
>+

Maybe add a hint to `--base=` for format-patch?

>
> [[send-patches]]
> === Sending your patches.
>@@ -365,7 +387,10 @@ Security mailing list{security-ml-ref}.
> Send your patch with "To:" set to the mailing list, with "cc:" listing
> people who are involved in the area you are touching (the `git
> contacts` command in `contrib/contacts/` can help to
>-identify them), to solicit comments and reviews.
>+identify them), to solicit comments and reviews.  Also, when you made
>+trial merges of your topic to `next` and `seen`, you may have noticed
>+work by others conflicting with your changes.  There is a good possibility
>+that these people may know the area you are touching well.
>
> :current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
> :git-ml: footnote:[The mailing list: git@vger.kernel.org]
