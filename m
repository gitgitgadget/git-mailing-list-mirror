Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F77C202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbdIVQgO (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:36:14 -0400
Received: from mail-cys01nam02on0112.outbound.protection.outlook.com ([104.47.37.112]:49189
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752485AbdIVQgK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5aC7bzOc8sAt9he2Z+ckMpmpH4BWZYn2mMpI8T6mD1U=;
 b=e2KwpGV0YMB+LEZAHs02x1SYTlHB8vCiuOc8MqwlHWP2e75Pq4oSZOkTQUmjylWTfQupNohfEf7xOcQCdjhrqa48LKPRSP+O/7itXtjCdop5Cm9CFV7xmwvzv105dP9/HCVQWa7FsZpNKGbjHFR8kTI0ITqiYDSyHc75y5obCFA=
Received: from localhost.localdomain (65.222.173.206) by
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.98.0; Fri, 22 Sep 2017 16:36:07 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v8 00/12] Fast git status via a file system watcher
Date:   Fri, 22 Sep 2017 12:35:36 -0400
Message-Id: <20170922163548.11288-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.549.g6ff7ed0467
In-Reply-To: <20170919192744.19224-1-benpeart@microsoft.com>
References: <20170919192744.19224-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR06CA0048.namprd06.prod.outlook.com (10.174.93.37) To
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 624755bc-0c7f-4ee3-6088-08d501d806c0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN6PR21MB0466;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;3:8+7suhKokX+iz0eD2YOFP+kxVYT8bRDh9DlP5Fz+I1is+3FU79Ax7MAlRSTR44xkY2IuxS0QvMboOpOmhqOKIvWAIog9o1mHEnIjLGtYIn9NnFym4oVwbOIKm0IkvLJFQKwa8cFPfugBk5EHnzDRAaqe1kaJ3M3n52r/lmOKfSmw/r42CHZpmkQIJ955Hx+hw0sUvQtiz+UHOM835Q0oYMut1Y4RqwTy4joPCjzUnrBXfJ6dmedKnSMHA5J+dR/x;25:GKjhBz70DOsly/lxQzPOOLpC0J9XM53w/PAbezvekgPpC7z8q0ymG1a5wFbbJ1zLFSVNJqTj1ARjmRN+XBcC3Yi2lSdD12wUM7nRZ28PCaokZgaPb5IlrQA7F/BsWiNQmYShfB1D6l6UwGaH5URPOY7+bVEfCxS1knLTAjQocV2wau8dwTMH3ZbZTfx3Z9kZEheVMb6f4JDdEyzw9dL9g54vvFyMnaFuDC4099W9oBC1cYOtjnVoCrKyCsMOq24zxVmjaQopcRfc6VhdL4LFc85KwteRCg57DF+y3Augek3aJaE6w8WnAOhtd61B89jgzliRDk1KwD79pngBxhLIXQ==;31:jpsWcGrobhEWA6Rc9ZXzj0G9/gbQzu1MXt6pGIvXGk0mVJrAK169fzTgV9GZHeIeJle4zKiKgPoD9r8Vtr5FQhFWV9z2+G/aUfZdfOnEYapV4o+aTCL2ODZ4Fl93Tu/Zc7+2UA38vyN/NE8h+DYxh8hhmUsWfYsUipVCBWCO9LLGsWH6LHACx6uS01QyGBl10ZxoZrOLlyLZQBO/XFC2budKI/lW6O+lHAEvmM1MDY4=
X-MS-TrafficTypeDiagnostic: BN6PR21MB0466:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;20:Zbn/H0Fag9SWCz9Oq4uK9f0dBYorUHj+wRzOqsAV8nw0pBzMV31proR7h+R9HKsd6FaK2AnvBSmqyZb7DQD5rt88aad0D3vLf0la/C2mB/s6yv+XBsamva9UZK6mqH4gNYYTqksWGb066dYFCM5emZxemlZudiyvVD1wU9TkhRv6kVDMQb6nPzICq0uEX+BZ4z7zIA/ED1LR99mE2S8BgnVo/tFvcxqQzZqM08lxr3AR9iLvdmll5/JF6HkfIvqiK9rWZpV83XeRdEq7GKbZYfd0QkT1dgpQBdCE9y3u8+6+e6X3/+n5JgZJRypCirG3JkNRGGAgUDDtHhHwg5F4cM+vc+fDlA8J8/H6Qr34O5w7tEhErKICWCQwwW53KiWtrf8TPpR5Vjzb/cLQYX/KZZYFcLnc0cGL0FbbKRlbgh3KuiWjB3k8tigtm7fLL8IXXNqkNbzMytCemzWsfxL/JeWPxSy5rkKiy6JxJJUJ9HOhzWmRIQ4m5oYQSjBUjdTU;4:EpEuR1akrC700RMO1C2S43nGwRpdvkQtWCAqx0fKFSi8JdZMT7eu6RiV+oR3/aa2ofntTKVyf5d6U40r3jcmXYH+OVRDan3GQaY8A1OrbEfQpDWki0oq1up1BJNxddPeLjbcNS1e/b1pGrBqpkF77oisN0h+iusf017IGMH5PCCrCq7MR11vvMM72dITjFfKKdqvwUFrz8g53k1qZLcU7r6ulRfjSJ9+xB9gU76rEyWwSQx1/4bO31xUzMe+tV7B
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <BN6PR21MB04666443DC5ABF9BA00CA674F4670@BN6PR21MB0466.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0466;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0466;
X-Forefront-PRVS: 0438F90F17
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(43784003)(189002)(2351001)(6506006)(10290500003)(6486002)(86612001)(2906002)(5660300001)(66066001)(4326008)(10090500001)(101416001)(97736004)(1511001)(47776003)(50986999)(575784001)(68736007)(76176999)(50226002)(2870700001)(106356001)(6666003)(16526017)(478600001)(53936002)(2361001)(37006003)(50466002)(81166006)(81156014)(8666007)(8936002)(316002)(72206003)(36756003)(23676002)(22452003)(6512007)(189998001)(8656003)(25786009)(2421001)(33646002)(2950100002)(6116002)(34206002)(39060400002)(3846002)(1076002)(305945005)(7736002)(105586002)(8676002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0466;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjIxTUIwNDY2OzIzOnE1MnpCL3hQSUlGUFFHR00yZjMxMDdIQWt0?=
 =?utf-8?B?djJ4WXl1YXhFeFpuZEEvYnQvcmU3N1lKTGFCa1M0Y215NHlmdHo4Vk1Cckdy?=
 =?utf-8?B?VlAyc0xickRJQmxCU2xVOGx5UXlJQ0MrWXlXbzNvRzdMS0dJWjJzZHVKbnIr?=
 =?utf-8?B?dmQ3WlZkWFQ4RzNOS09CZnNZb3lwUUd3YVA4VjRIMHlwR2hmQVpoTDBYOCtK?=
 =?utf-8?B?a1p0L09YL2owOHdSdHd6MWxoMGFUMTAvMDNWeUdzeFp6Vk03YkFrMGkvZXdZ?=
 =?utf-8?B?OVJkQmdvVmZrMTBJUkEwWHAyVWpSVi9jRTNNSUlHa251UEtVRnloMUZSRmY2?=
 =?utf-8?B?NURxdVl4R0FGRXNKZitwb2dNZVdUZ0lXN1duT3ZaZCtraWlNNmRBbGtqUkxD?=
 =?utf-8?B?VTRkNE9xWnVubmlLYTE4bDdBNmx4WHVVTXhiazhVdTljMmFKa0c4bm1ORnNN?=
 =?utf-8?B?ZWhQdmRBRHd1UXRLdk9sdE5CZHdaKzFzSGFYRmZWaTVNcXhZUi9mMVlTRG9W?=
 =?utf-8?B?RVBvNFA2WDgrUCtjVjZ0eWVwTUVEeTUySGNiekVUNURka2FtUEtSQi9ZZURy?=
 =?utf-8?B?TEVYYTJHdklzUnJKeEd4cnc3REFOeWZUVjE0SG1rUWJTZkRrMHdwenh2UjRC?=
 =?utf-8?B?Q21uT3M0NHpQQjFNQmhPeE5yaVhTOHpFY1NmSDUwQVNNaUV4TWZDYkNHMWxX?=
 =?utf-8?B?eEtSTFVpRHhhbzA2dXlONDRkN0FpOEhvUXh5a2JBdUFUK05hbDFVQzB5SWpK?=
 =?utf-8?B?TVZxNXJFS1dWUlVKblhhKzUzU2RqMnRpVCtVcmxNdVozQnZMSTAzU1ZPNjM1?=
 =?utf-8?B?QTdSbXFhL2V5cXYyanBaVkRId1JSNEwwQmRYYkFweWtERTRLdEUzdGRONFZV?=
 =?utf-8?B?RlljcTN2VSs1MjhSc3JnUDZCMGJiT0l3Y3BWYzJsTk90MWRiK2N6YXZaR3ls?=
 =?utf-8?B?bzJjai9sWnZGQldFNkNoTGx0ZUxKNWdYR3UwZmZqMjMzRWNkY1VPMGl3YUlh?=
 =?utf-8?B?WmZHUHhKMFJ2OWg2SlAxZXRUcGVqTHhMZlhKTTNVUmY0L3dlVWR3ZGFCZ2Nu?=
 =?utf-8?B?SWxITkxTRDg2QnRuL2xObUpQbUNzK1A3ODNKVU1hTUNqcEZYVldIZnk1TElp?=
 =?utf-8?B?eXk4Z2JweEVCdWhhZW0vR1VxeUpOcDFadnZvRm1IT0dSYkhCamEreWxGRElv?=
 =?utf-8?B?b3BNNit2bEF4WFFJS25YU3hXSXhYNUVra2huV0c1Z3dHWnlsSFFmTHFQSlh1?=
 =?utf-8?B?UEozMlF4UzVsU3Zyd21QSU80WVlkamIrNG9qWlhJUU5oSFJlSlZyRkVDbUxR?=
 =?utf-8?B?R1pqN21EcXhNWEFnSkRnMzEzcFU0dGcyaFNYVlpXZWRwN0poemZSRi9DeXl5?=
 =?utf-8?B?aFdlME9XdkFEWnI4ZFVBczdDL2FhWjIvU3lFZkpPdkMrclBTcC9LTG5WOE1K?=
 =?utf-8?B?cGRaN09TcVVHYnpMOENlMytxUE5rY3JXSFZScGhvTjFmTEEvMUFRTm9zaXdu?=
 =?utf-8?B?VmhCUDlYZU5nRFdYZk8zd3dUdGlVQ0xkUHVtbXhla2tpODM3K2FPSnNmelJu?=
 =?utf-8?B?MXVib3QrbUd2Vi90c21vcDJoZ09XUXpDajdQQW10L2o2ZzlXVm1ESHk4b3Z3?=
 =?utf-8?B?cWtvU1dMN0YwaHN2YlgwSmFSdnMyYkt5dU5CajVHK2Z1Ym5NVkhpUWUyNXk4?=
 =?utf-8?B?V2Q4b0tVaWkxbStSclJ1ZGJTMm5WYUs2UmJUVENzQ2hVd0MwRHBoNlo1L0JQ?=
 =?utf-8?B?KzNVTGc3TUU1dDRZRE9jS0VpOEtmN3ZYVzM0MGpkSVVqa1pKUWtZdGsvNTcy?=
 =?utf-8?B?cS9QdjF5MmhnbUhtRER2WTJTVEZPRE1mcTZ1aE0vbnhQWFA2MHhFRHExT0x4?=
 =?utf-8?B?TVJjK3RTbjhzbDZqSkJZMWJHKy9tQjd6aHRwTDRnWHdHL0NvYkpZNFZFaDR0?=
 =?utf-8?B?SWplYThncDR5SCsrY1lTcldNTlplUGpDN0tUWGlsdzlmSFRkOVRsNVZSejlm?=
 =?utf-8?Q?1+Oi2M?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;6:Yo3dVoUWOglMcmsBj/h47sBuP5qmCcNHaEXdRG5liD3/HoglTGF3gXFjY8yRoiXu7HfR0QjvNgHViylbpq3VYW0nTwBrPwZrH2lhmIvFNcJug8I12fAEIDycJch9MC8s7DskJZK5ebK83jyGatwulE6cj4ADzBlsj6KV5EbiwvG+jqV6mKJDh6aCYIWvKiHtPB9iob3OgNLWw07tvRmRsr6bgjnuqv4wPlO17xImJ1DJjmt1In7ioCH1cxZmwaOG4aCCbLrLhtgectR83N9Bce0e4JdzSaXIuiMD/vEjEszwVVq1041Db93qHUH98aXzb6cG19A3IxNR2FnChx/fHg==;5:5h427enQOWCCrbe6M5uvxuD9hOPTEqUvQa4BXj81nc3vlyonIREKgpIgf8zMhLaOT/dZu3PMqZyIfYmHjAeF8cZfpQH9mX7lcfaNRpGguvDyx90HTXWuPTN/4ZlKp/4mUUP+rB4YLwd2XlAyi7dIrA==;24:yfNq1+utprf3EiqeVtGvbr/wdRDaE/pCvGAGpeJ1X/UKKOcBc8EqEjuo+E9V0j773tDi+Vh5ESIu0tZa7XrInd6ompnjddJgSbusirkyehc=;7:vvxcjq3sztm1q1Zw3GXN1g+ahgdnPRFk169RFN//gQds0hKKbM8VbsD8n4K2lkbBRZ3P/KPhInrpVCviABoJBRzwtTKRGdPwmorgF80KIkzCdpeKpQaTUViaOsTIiN0hU6LFuma4YcrYtqyjkV8GqdubebMPuV/Vcizdpv1HYVKR+QymhwaMYkY81VZ73t4EKJt489pCutaN5TOSJ+79vNzTjTx3xVBvXLeAk33XFzA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2017 16:36:07.7502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0466
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks again to everyone who provided feedback.  There are several
spelling, documentation, and code comment changes.

The only behavioral change from V7 is the removal of unnecessary uses of
CE_MATCH_IGNORE_FSMONITOR.  With a better understanding of *why* the
CE_MATCH_IGNORE_* flags are used, it is now clear they are not required
in most cases where CE_MATCH_IGNORE_FSMONITOR was being passed out of an
abundance of caution.

Since the fsmonitor data can be trusted and is kept in sync with the
working directory, the only remaining valid uses are those locations
where we don't want to trigger an unneeded refresh_fsmonitor() call.

One is where preload_index() is doing a fast precompute of state for
the bulk of the index entries but is not required for correctness as
refresh_cache_ent() will ensure any "missed" by preload_index() are
up-to-date if/when they are needed.

The second is in is_staging_gitmodules_ok() where we don't want to
trigger a complete refresh just to check the .gitignore file.

The net result of this change will be that there are more cases where
we will be able to use the cached index state and avoid unnecessary
lstat() calls.

Interdiff between V7 and V8:

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 95231dbfcb..7c2f880a22 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -476,7 +476,7 @@ inform it as to what files have been modified. This enables git to avoid
 having to lstat() every file to find modified files.
 
 When used in conjunction with the untracked cache, it can further improve
-performance by avoiding the cost of scaning the entire working directory
+performance by avoiding the cost of scanning the entire working directory
 looking for new files.
 
 If you want to enable (or disable) this feature, it is easier to use
diff --git a/apply.c b/apply.c
index 9061cc5f15..71cbbd141c 100644
--- a/apply.c
+++ b/apply.c
@@ -3399,7 +3399,7 @@ static int verify_index_match(const struct cache_entry *ce, struct stat *st)
 			return -1;
 		return 0;
 	}
-	return ce_match_stat(ce, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_IGNORE_FSMONITOR);
+	return ce_match_stat(ce, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 }
 
 #define SUBMODULE_PATCH_WITHOUT_INDEX 1
diff --git a/cache.h b/cache.h
index eccab968bd..f1c903e1b6 100644
--- a/cache.h
+++ b/cache.h
@@ -682,7 +682,7 @@ extern void *read_blob_data_from_index(const struct index_state *, const char *,
 #define CE_MATCH_IGNORE_MISSING		0x08
 /* enable stat refresh */
 #define CE_MATCH_REFRESH		0x10
-/* do stat comparison even if CE_FSMONITOR_VALID is true */
+/* don't refresh_fsmonitor state or do stat comparison even if CE_FSMONITOR_VALID is true */
 #define CE_MATCH_IGNORE_FSMONITOR 0X20
 extern int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 extern int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
diff --git a/entry.c b/entry.c
index 5e6794f9fc..3a7b667373 100644
--- a/entry.c
+++ b/entry.c
@@ -404,7 +404,7 @@ int checkout_entry(struct cache_entry *ce,
 
 	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
 		const struct submodule *sub;
-		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_IGNORE_FSMONITOR);
+		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 		/*
 		 * Needs to be checked before !changed returns early,
 		 * as the possibly empty directory was not changed
diff --git a/fsmonitor.c b/fsmonitor.c
index b8b2d88fe1..7c1540c054 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -176,7 +176,7 @@ void refresh_fsmonitor(struct index_state *istate)
 			core_fsmonitor, query_success ? "success" : "failure");
 	}
 
-	/* a fsmonitor process can return '*' to indicate all entries are invalid */
+	/* a fsmonitor process can return '/' to indicate all entries are invalid */
 	if (query_success && query_result.buf[0] != '/') {
 		/* Mark all entries returned by the monitor as dirty */
 		buf = query_result.buf;
diff --git a/fsmonitor.h b/fsmonitor.h
index c2240b811a..8eb6163455 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -35,7 +35,9 @@ extern void tweak_fsmonitor(struct index_state *istate);
 extern void refresh_fsmonitor(struct index_state *istate);
 
 /*
- * Set the given cache entries CE_FSMONITOR_VALID bit.
+ * Set the given cache entries CE_FSMONITOR_VALID bit. This should be
+ * called any time the cache entry has been updated to reflect the
+ * current state of the file on disk.
  */
 static inline void mark_fsmonitor_valid(struct cache_entry *ce)
 {
@@ -46,8 +48,11 @@ static inline void mark_fsmonitor_valid(struct cache_entry *ce)
 }
 
 /*
- * Clear the given cache entry's CE_FSMONITOR_VALID bit and invalidate any
- * corresponding untracked cache directory structures.
+ * Clear the given cache entry's CE_FSMONITOR_VALID bit and invalidate
+ * any corresponding untracked cache directory structures. This should
+ * be called any time git creates or modifies a file that should
+ * trigger an lstat() or invalidate the untracked cache for the
+ * corresponding directory
  */
 static inline void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce)
 {
diff --git a/read-cache.c b/read-cache.c
index 53093dbebf..05c0a33fdd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -641,7 +641,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	int size, namelen, was_same;
 	mode_t st_mode = st->st_mode;
 	struct cache_entry *ce, *alias;
-	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_RACY_IS_DIRTY|CE_MATCH_IGNORE_FSMONITOR;
+	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_RACY_IS_DIRTY;
 	int verbose = flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
 	int pretend = flags & ADD_CACHE_PRETEND;
 	int intent_only = flags & ADD_CACHE_INTENT;
@@ -1356,7 +1356,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	int first = 1;
 	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
 	unsigned int options = (CE_MATCH_REFRESH |
-				(really ? CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_FSMONITOR : 0) |
+				(really ? CE_MATCH_IGNORE_VALID : 0) |
 				(not_new ? CE_MATCH_IGNORE_MISSING : 0));
 	const char *modified_fmt;
 	const char *deleted_fmt;
diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
index 4e5ca8f397..bd1a857d52 100644
--- a/t/helper/test-drop-caches.c
+++ b/t/helper/test-drop-caches.c
@@ -82,6 +82,8 @@ static int cmd_dropcaches(void)
 	HANDLE hProcess = GetCurrentProcess();
 	HANDLE hToken;
 	HMODULE ntdll;
+	DWORD(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG);
+	SYSTEM_MEMORY_LIST_COMMAND command;
 	int status;
 
 	if (!OpenProcessToken(hProcess, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES, &hToken))
@@ -96,12 +98,12 @@ static int cmd_dropcaches(void)
 	if (!ntdll)
 		return error("Can't load ntdll.dll, wrong Windows version?");
 
-	DWORD(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG) =
+	NtSetSystemInformation =
 		(DWORD(WINAPI *)(INT, PVOID, ULONG))GetProcAddress(ntdll, "NtSetSystemInformation");
 	if (!NtSetSystemInformation)
 		return error("Can't get function addresses, wrong Windows version?");
 
-	SYSTEM_MEMORY_LIST_COMMAND command = MemoryPurgeStandbyList;
+	command = MemoryPurgeStandbyList;
 	status = NtSetSystemInformation(
 		SystemMemoryListInformation,
 		&command,
diff --git a/unpack-trees.c b/unpack-trees.c
index f724a61ac0..1f5d371636 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1456,7 +1456,7 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
-		int flags = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_IGNORE_FSMONITOR;
+		int flags = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;
 		unsigned changed = ie_match_stat(o->src_index, ce, &st, flags);
 
 		if (submodule_from_ce(ce)) {
@@ -1612,7 +1612,7 @@ static int icase_exists(struct unpack_trees_options *o, const char *name, int le
 	const struct cache_entry *src;
 
 	src = index_file_exists(o->src_index, name, len, 1);
-	return src && !ie_match_stat(o->src_index, src, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_IGNORE_FSMONITOR);
+	return src && !ie_match_stat(o->src_index, src, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 }
 
 static int check_ok_to_remove(const char *name, int len, int dtype,
@@ -2136,7 +2136,7 @@ int oneway_merge(const struct cache_entry * const *src,
 		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
-			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_IGNORE_FSMONITOR))
+			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
 				update |= CE_UPDATE;
 		}
 		add_entry(o, old, update, 0);

Ben Peart (12):
  bswap: add 64 bit endianness helper get_be64
  preload-index: add override to enable testing preload-index
  update-index: add a new --force-write-index option
  fsmonitor: teach git to optionally utilize a file system monitor to
    speed up detecting new or changed files.
  fsmonitor: add documentation for the fsmonitor extension.
  ls-files: Add support in ls-files to display the fsmonitor valid bit
  update-index: add fsmonitor support to update-index
  fsmonitor: add a test tool to dump the index extension
  split-index: disable the fsmonitor extension when running the split
    index test
  fsmonitor: add test cases for fsmonitor extension
  fsmonitor: add a sample integration script for Watchman
  fsmonitor: add a performance test

 Documentation/config.txt                   |   7 +
 Documentation/git-ls-files.txt             |   7 +-
 Documentation/git-update-index.txt         |  45 +++++
 Documentation/githooks.txt                 |  28 +++
 Documentation/technical/index-format.txt   |  19 ++
 Makefile                                   |   3 +
 builtin/ls-files.c                         |   8 +-
 builtin/update-index.c                     |  38 +++-
 cache.h                                    |  10 +-
 compat/bswap.h                             |  22 +++
 config.c                                   |  14 ++
 config.h                                   |   1 +
 diff-lib.c                                 |   2 +
 dir.c                                      |  27 ++-
 dir.h                                      |   2 +
 entry.c                                    |   2 +
 environment.c                              |   1 +
 fsmonitor.c                                | 253 ++++++++++++++++++++++++
 fsmonitor.h                                |  66 +++++++
 preload-index.c                            |   8 +-
 read-cache.c                               |  45 ++++-
 submodule.c                                |   2 +-
 t/helper/.gitignore                        |   1 +
 t/helper/test-drop-caches.c                | 164 ++++++++++++++++
 t/helper/test-dump-fsmonitor.c             |  21 ++
 t/perf/p7519-fsmonitor.sh                  | 184 +++++++++++++++++
 t/t1700-split-index.sh                     |   1 +
 t/t7519-status-fsmonitor.sh                | 304 +++++++++++++++++++++++++++++
 t/t7519/fsmonitor-all                      |  24 +++
 t/t7519/fsmonitor-none                     |  22 +++
 t/t7519/fsmonitor-watchman                 | 140 +++++++++++++
 templates/hooks--fsmonitor-watchman.sample | 122 ++++++++++++
 unpack-trees.c                             |   2 +
 33 files changed, 1572 insertions(+), 23 deletions(-)
 create mode 100644 fsmonitor.c
 create mode 100644 fsmonitor.h
 create mode 100644 t/helper/test-drop-caches.c
 create mode 100644 t/helper/test-dump-fsmonitor.c
 create mode 100755 t/perf/p7519-fsmonitor.sh
 create mode 100755 t/t7519-status-fsmonitor.sh
 create mode 100755 t/t7519/fsmonitor-all
 create mode 100755 t/t7519/fsmonitor-none
 create mode 100755 t/t7519/fsmonitor-watchman
 create mode 100755 templates/hooks--fsmonitor-watchman.sample

-- 
2.14.1.549.g6ff7ed0467

