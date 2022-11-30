Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7492C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 00:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiK3AhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 19:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiK3AhT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 19:37:19 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2010.outbound.protection.outlook.com [40.92.90.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859CB5ADE3
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 16:37:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aL0rTSgnF6N0Ubatn2fZiRQ7numAcgAGjCFJDgN8gKWrPqiGDK+FFj+Hb6BsWgaMGzwmNi9uL+xiGjjGX48lEIe6w/whnAoB/ZYOrBoda7d45wi4D/tSWnQVWbuaHdwVBS7mz+hS8gAZBkQ5AfmNCkRGOC/3/X3lhkWrNx8t/e+ckyl6VwA3CFjTIEceyNwdNerz+LkOMn04Hx34IMuFL18w8fo0jpDly/S2pXnrYguym1Yo6l+m5pLcy+Q51AHrC+2wptY5LsdwI0hP6G3sE5AH7dXO0xlweJDnvusth3miz3T8dMgEqMLT2C8INkIjDzJP57ojlldo/ceO+dON9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skxzDi6CNlEN8VMy3CByCZC3Vbl74ica3ug2R12r1BU=;
 b=MunuKl7T8WDGUc15z8N2gPFKOXQ3nLurS6isO3EqqVJ3wpRmf0ooLoKjm0ycHhPfM97yvNjdeRs6LtOufmEfXCnt/+VGO7wNWwIsZnDR9SzB+26ZidIMw8MjEOlO4ORyhC5v6VZqXONOQ8tbmwSuHJU+Li8vQzJ/gy0eU0Dmm913+Q53OvKHuFUvk+Kzmkqjowi15XqOtTJ7UDk8pGvac7tn1HPcL4osqzfXg+O/guw9zOu2UyF/VUlQmW2JvnauUtnPblvMGYE9TMe8niFvyIzc0YwBLYRaY3prUX06BcRrqJ4oVUtbOBdDGwtbFdDA+8agGMIS0cs7dkHZqG67tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skxzDi6CNlEN8VMy3CByCZC3Vbl74ica3ug2R12r1BU=;
 b=s9LSCujieVB5I1DDI51dr0cmoaenTLLcl3V1CpcM/osq1EUq0PTx+ojpJ2T6cVOeqZXXZCPFh43nRhGPLfVU+8qGsWX409kGglGh5oihvRljOB90xZZo0j5mzBL9anbzl5IIxsM/5Fs270vOD1rNopHTXP33ABxtSudQuOp7A3SrlYZaNz/iUk74ukdg35Y//NLveW/sJr5Vf7Dc4/NsFzmfmb8EU5/hM7dSVclcXTNGcNVIJ31TZX5hhi7XtZbi7JggW99y7GFYxaWf/SciTnkU8rKVYXoH4yw/mbX/YxWnOjeKTQNn0gjq8XC+SrrylkskBVH9z9TkYpO73xYdTg==
Received: from PRAP192MB1506.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:29f::9)
 by AM7P192MB0690.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:176::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 00:37:15 +0000
Received: from PRAP192MB1506.EURP192.PROD.OUTLOOK.COM
 ([fe80::49d0:ccf3:d2e2:5f24]) by PRAP192MB1506.EURP192.PROD.OUTLOOK.COM
 ([fe80::49d0:ccf3:d2e2:5f24%6]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 00:37:15 +0000
Message-ID: <PRAP192MB15064FE07E86792F36FCE267DE159@PRAP192MB1506.EURP192.PROD.OUTLOOK.COM>
Date:   Wed, 30 Nov 2022 08:37:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] add case insensitivity option to bash completion
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alison Winters via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        git@vger.kernel.org
References: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
 <xmqqedtm4h93.fsf@gitster.g>
 <PRAP192MB1506B74F9BB25061419FA228DE129@PRAP192MB1506.EURP192.PROD.OUTLOOK.COM>
 <221129.86y1rtirhl.gmgdl@evledraar.gmail.com>
From:   Alison Winters <alisonatwork@outlook.com>
In-Reply-To: <221129.86y1rtirhl.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [SsFH9gj9nonyIhVife9uAGXA6X/RUBRj]
X-ClientProxiedBy: KL1PR01CA0061.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::25) To PRAP192MB1506.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:29f::9)
X-Microsoft-Original-Message-ID: <a595a215-8c9a-7dd1-6598-b1e2eac0dc6c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRAP192MB1506:EE_|AM7P192MB0690:EE_
X-MS-Office365-Filtering-Correlation-Id: a89b9797-9bc1-42d2-4711-08dad26b0732
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GN77F5ofx+/miCQVIohKY9WFw5HF2I1rjrSS2Q/oOkt4fvHXxgDT1I0RNVbonKWurUeWqrFjlHJqraxQDkxKBxNsoniLcxHeOlZHrfKi6XIuBFdOi3nuFNh1/w7D2VfzCGxCALL6v8+6U5qGlQvH37zXmQi0xiHBgopef8Q5YRcXGmBKYVX5SDooNaBdBp0+Fn3Z6aBbJw3MFpFRHzGVVolSkYRuiTLdyyyU0soKu+oiZgrKYsHSiiO8znWydEDHPRwTa4g8MH5RzqS6btB5oU+Hz9wnBTz6cJNemTM7g5IwDqhtrRTXzyLaI5LExnhosRS1v4Aa3goAHS0aXR/u9rkhIJHPOEb0B+RGf8unhz36UAS0Q5yPYBi+fei4iiCKIRYmw+3+2n3tPnW8L407TM9hAnfMDDxenVx1CutJwZQUkDhsac6/nX6GWzCx0llFDsdKenfPXCpiG7sICDEKpN0qP3O2JvOvCVuV/upFb5ZLynZ5gUad/AjlkdHXZXNc7vHDDl3c9gn3s4R3THWmHDMqcGi1EAJYQfKPZgASz5Oa15+VB0JMAN+qfv3wankNHFmSZ0cIHPtoKg2nabCSDNk3qD1eu+h/tcMkye5cK/w9Cc4oRG8zQ/ygQJcayJtPZwsBBIg12hVb+NLJYVcFPg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW52aFpSakpWckZJLytaL1pLUHQ4QkJTTlRjdUoraGt4aXdSbWtsNGlCUHY5?=
 =?utf-8?B?bHFwa0wzY21ac3ZzbWNpV3Y1V3RoRE8zbkp4ZWxBSWFVRHdFcUdTUE1FM0lK?=
 =?utf-8?B?OUorUE8zbFZxeXJ6cFdyMmpyaWs4K3Fja1pLOExpQVp1UmtZSjNFOEpwbjhi?=
 =?utf-8?B?UC9WOGJmUFQzTHhsbFErOXA3ZEtFS3REUUhoWERIWTF3QVoxQktvSjlHQUlH?=
 =?utf-8?B?NEo3YjFScUxlR3Y1U0tjVXMybloycDdpMFFSUDBGWnNRYlErdkt5WkNMZTBp?=
 =?utf-8?B?QmtEN1R4dElVakNGZ3lvaFRkRXllemhHM0NDWTRzOFhmYTdHWU43SHpTZTZm?=
 =?utf-8?B?b1ZlWTQ1ZHVOcjdidUpnZkFLVnBxaDdjb21EVWQzY1dveXdBZjZuSmJqZlBm?=
 =?utf-8?B?ZkQxcnRNa0s2RjJiN0N5TWsvVXMwMUw4Z0hMM2srTE9MMG5FUC94ZkJ4ZnZm?=
 =?utf-8?B?VUJKeURrRUhpZDF4QngvT29UN0tvZjhUQmpZQ3JTNkd4TzR0MnhqSjVqY1Zl?=
 =?utf-8?B?MDkrVFphNEFZbU8wOFNDUnN4WC94S1o3QVkvRko0b1dncThGZDl0WGNGZmFS?=
 =?utf-8?B?OUg1OFJIWUFGRDBseHJydEtpNXdROHlMamxPRnl5MGRJR0J5VkhBLzZuajBS?=
 =?utf-8?B?QitxWFdQMUtRRDFOdEFBdFJURHMrcWlCdlhWeEJlWE8yRTgyYktQTkdNWHVO?=
 =?utf-8?B?Y1dXNkVHUTNPMlFNRld1TmNJL29lWWxtOSt3OVBCSGRaQlFEb3prQ29ZbG52?=
 =?utf-8?B?VWs0ZUZjUEREeWVMWjk4TU5tSCtDdCtkZmNJa1pia2k0bmNFY056a3J1a3ov?=
 =?utf-8?B?RXlPdGk4QVZNclh4Q3dBNDBvTmxLNEovTkdZeVl4MmVQR3dudThyS1M0dzYw?=
 =?utf-8?B?cCs0NUtRTnBDM1hTTXRXRm9ZN2NQL2xaOFlxS3hORi9qbkZFL2xWS1FGVmhJ?=
 =?utf-8?B?K2hWVndrWDY0V0R3SHpnWEcvaEJ2MkFyV1pXOXFhR1FZbHk5RGoxekMxWU1B?=
 =?utf-8?B?QU5uQ2NLMG5ta1pRY3R1cWVJRU44TkZLUjFOakUrdGlScXVQcHRjdVVCVXpy?=
 =?utf-8?B?ZmIyb2hqQUVCQ2hzZlU3cDZDdmZtemVkeFlpSWxzN05vazMxc2Urb2xqUVBB?=
 =?utf-8?B?RC9PNlR4QkJFdjhaRzZkbXJpb0hCZ3poK3puMlVaQTdVRWdUbmVjWXBDTDNv?=
 =?utf-8?B?OHVUenpXZEVMUFlPeDVaVmg2bStMalBoQ3YzbS9iMDlBd1NVOFpqYkplMEVH?=
 =?utf-8?B?K1JxVGlwSWo5aUVUeENZdnMvQmc1WlRwR3NlMVJUbmhnUWpkVnZuc29HdlRS?=
 =?utf-8?B?dFUwbXJubEFMS084S2xlMmFpdXdHQW9oUDNWYXBWblhlOGVLTWlzK0lyVWpz?=
 =?utf-8?B?VzZvZVFvYm1UUE51bTdQb2V1TVVOWkRlRFY2LzM2ZXp1Mkt6RUN2VHVjeWFp?=
 =?utf-8?B?UTlYdnV2MGtKTmFLUW5FTmhqNkNjSlkxV3p6YTlGM1VWb0lyUklEamhERzRn?=
 =?utf-8?B?cUViMEF0KzZpeWRtQU1CamVCOHRmY2dRa1lXR0FFRzY5bExFU21nTW5PUVZG?=
 =?utf-8?B?b1FMVWlDUVRDOHZ3TjFHUjFjaUQvbVRUUkpaNlpYams0QjJCeitaT0NCenlp?=
 =?utf-8?B?d2MrN2dIWC9sZFU2dEFjcmw3V3FDSzNsTVJjTGpwcHlPU3R1di81SDBNZy9K?=
 =?utf-8?B?dld6YTdnNTk1VmVpM2o2ektwSkpyOHkySVZVdTRhRlN4NkpyeFIxNDBRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89b9797-9bc1-42d2-4711-08dad26b0732
X-MS-Exchange-CrossTenant-AuthSource: PRAP192MB1506.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 00:37:15.4802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P192MB0690
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-30 01:40, Ævar Arnfjörð Bjarmason wrote:
 >
 > On Tue, Nov 29 2022, Alison Winters wrote:
 >
 >> On 2022-11-29 10:38, Junio C Hamano wrote:
 >>> I did not try to figure out the reason but the topic with its tests
 >>> seem to break in 'seen' the linux-cmake-ctest CI job.
 >>>
 >>> https://github.com/git/git/actions/runs/3570230611/jobs/6001013549
 >>>
 >>> but the same test does not break under usual "make test".
 >>
 >> I cannot speak for how the changes of the ab/cmake-nix-and-ci impact
 >> the aw/complete-case-insensitive branch, but the failure seems to be
 >> pointing to a test that I have since changed in the v2 patch, on the
 >> suggestion of Szeder Gabor. The variable is no longer exported and
 >> the script is no longer sourced a second time. I don't know if those
 >> v2 changes would change the results of this test, but they might be a
 >> starting point for the other people CC:ed here to consider.
 >
 > The breakage is due to a semantic conflict between the two, which is
 > solved thusly:
 >
 >     diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
 >     index d45d820da28..2aa128075ca 100755
 >     --- a/t/t9902-completion.sh
 >     +++ b/t/t9902-completion.sh
 >     @@ -2261,7 +2261,7 @@ test_expect_success 'checkout does not 
match ref names of a different case' '
 >
 >      test_expect_success 'checkout matches case insensitively with 
GIT_COMPLETION_IGNORE_CASE' '
 >          (
 >     -        . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
 >     +        . 
"$GIT_SOURCE_DIR/contrib/completion/git-completion.bash" &&
 >              GIT_COMPLETION_IGNORE_CASE=1 && export 
GIT_COMPLETION_IGNORE_CASE &&
 >              test_completion "git checkout M" <<-\EOF
 >              main Z
 >     @@ -2279,7 +2279,7 @@ test_expect_success 'checkout completes 
pseudo refs' '
 >
 >      test_expect_success 'checkout completes pseudo refs case 
insensitively with GIT_COMPLETION_IGNORE_CASE' '
 >          (
 >     -        . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
 >     +        . 
"$GIT_SOURCE_DIR/contrib/completion/git-completion.bash" &&
 >              GIT_COMPLETION_IGNORE_CASE=1 && export 
GIT_COMPLETION_IGNORE_CASE &&
 >              test_completion "git checkout h" <<-\EOF
 >              HEAD Z

In this case, I think the easiest solution will be to move the
aw/complete-case-insensitive branch forward to the v2 patch (posted to
the list @ 2022-11-21  0:26 UTC), which no longer includes this line.

Alison
