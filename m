Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0C3C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8138761502
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhKSPnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:43:46 -0500
Received: from mail-am6eur05on2084.outbound.protection.outlook.com ([40.107.22.84]:45600
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235463AbhKSPnp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 10:43:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKJxV91L0E00EDInwOzyY76a6kZFKp3GVkEq9jR+oBJ96kezkuCEC36wtmymQR+AbpEoUE2e2TdNb2O04C9npA+51kni4p+pm/tN7Rq1YF0SX9OXchjCXbXua6CkQsr3WURVZLrIZrUiOAF33kPLBXaTCHqagcntR+VmYED3hRrLuss9dfiqoqr9Ygn9tJxpjYH+hOUvDcTZay76f5lXE6iK81QIlYrf+ddI1KFGf2AWnRSgPAlH5jNMh4sjVmyn7MQbtQX3MkcXxeDs69epib65Ff0ONXyCCbN61tjmyscjWooqjjw8fnP+idddO2Aapi9MUyUQxGNts1aw3AltPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjtBTeP3iq9tXUiPmplFlFr6EPpyOnr8QKBmSzui7tQ=;
 b=jHTBLYowNMboAn4yetUoBGOIoNEO2AWim8RtleluiP+Wk+PNhIN5xYAocXgny/zkD16Y1LkKnmFJD9CmSVZaHFiDOUTRh0RPiATHj+RRzjgfyNz7db2B2LNHhTJxNBczI5bdcnqUFU/wIHBy5T6XQ1vOin/gkw9xvM4FPVtevQ2Dmr2RnZ6ewtXvjloA4UHeEkJ6LYxDCXbF1TRm3dTUkMmJV/5yD6DkOoTF59fMl5rRszR6K0xYb7m76Lmv5EaUR9Sm9NANCfvzH2eKeyOxJCDtuwQCx+RUVXlCBby7Fw3t1h5gDyKNSQlyecmMGg+AkLqPtfpOoa9sc9R5ObmViA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjtBTeP3iq9tXUiPmplFlFr6EPpyOnr8QKBmSzui7tQ=;
 b=X976gEpAiLO+9gqZcGuld6W+kShKiLv1dnePkK+vRSKzupOl30W35bhQjoTzxTNFvFyAFDTCxq+IXIjUPv+S7vsPi8PKP/oe9lE0lzX9/ANQZNH/YqyilZK00XkxuzETp+z1aqwkuUJEX4cW2KTfVBHJpUxkrtqFxb2zZvyXfxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4333.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 15:40:42 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Fri, 19 Nov 2021
 15:40:42 +0000
Date:   Fri, 19 Nov 2021 16:40:36 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] test-lib: introduce required prereq for test runs
Message-ID: <20211119154036.5n5kpecgnptzkaqn@fs>
References: <20211117090410.8013-1-fs@gigacodes.de>
 <20211117090410.8013-3-fs@gigacodes.de>
 <211119.865yso4a9y.gmgdl@evledraar.gmail.com>
 <20211119140953.cgdppgv3f64hqbdx@fs>
 <211119.86sfvs2p9w.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211119.86sfvs2p9w.gmgdl@evledraar.gmail.com>
X-ClientProxiedBy: AS9PR05CA0057.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::35) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR05CA0057.eurprd05.prod.outlook.com (2603:10a6:20b:489::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Fri, 19 Nov 2021 15:40:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c7a15f9-6e81-4570-5f71-08d9ab72f1c8
X-MS-TrafficTypeDiagnostic: PA4PR10MB4333:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4333A254F3F19BC3710DF2FAB69C9@PA4PR10MB4333.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRo4He5aHRzsEFizv9xLHl9NISCvF364gywWZaXC0WSfswJAGHKTT25zwgIoy37niC//D3Uf/7W8vv8eAl4Gr5dyL/4GD3VzxCLaOBM5Tp08m70NhqvfOf+qTQ+DcAlYZU6Iz8ffHj7QKpeVIhu/166pExEVUEknolOw/Pt2mmrkY54unQpnut8gXqUuIyUV5Qcpib1NkEvQEcjZiK9H60idFpe2Bg3EqH91y1sudlPngfE6oI+hdctlh+BiOTP0YU9B5SO9u6JfzwaI8XaZwOxSqLOoAtGA9DNkZViB3LJYg+bgFF4etFx44+B//Qi8evmKeu6Opj8Ms2yLPtdGgHfC96e5OYgD6HQnG4ND2lXXOIv80VuYy6HISWNMdw7RRu/twTPRing8o2jHiGngnM41HsLkj9YuuVh+ICufE7Vkwltz72uhhP4hi01pWvnlXurtK+6IvsmXpqgYPNYTCM/xh1B02lq90G+Lmbf2bbS8gukhc748iwSi6a+2Gab+IEkQNl1XPq0ev0zIdv8kUmzG7UlSPxEDhnLZ4/k2hb5HWzIemuXYKb+d/ELIkwzu/TmWaDHwyQpx29zb4qFoYLjI30gj3ARaHb9MoOpw6l3EWK5UwJLy9kiGyYBMJg+BGTXMwdrxQ5GNDPZ1fvOdag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(396003)(39830400003)(366004)(136003)(346002)(6496006)(1076003)(66556008)(83380400001)(66574015)(53546011)(52116002)(2906002)(6916009)(6486002)(9686003)(66476007)(316002)(186003)(8936002)(6666004)(508600001)(4001150100001)(38100700002)(8676002)(66946007)(54906003)(86362001)(5660300002)(4326008)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2g0bHJ6ZTNNT2JnUGlLOXdkdThQTjN1QitIbnZtR0xGWTZJeGp5d3JsNEJN?=
 =?utf-8?B?NmdlR2hGT0Q2TG04dGpuNFF5TEU3UTFzQ2ZwNzhmT1ZsbllUdEhaOE5zNUpx?=
 =?utf-8?B?dVZ6YVNGUXFsR1dZQWpFbjg5Rng5UnFFMUtIdnpLSEovMEpqU09ENm1sd2pB?=
 =?utf-8?B?T1pTOFRjNHNjLzlUQlFKTFdyRUxRcHh5ZkUzeFF0bjFuaHJpaGs5NWpIZ0xQ?=
 =?utf-8?B?dFhWQTlibUFqaGNZcll2SzFEa2VENXUwYTVnVWpuT1JkT2p3VHdtOUVnOHRr?=
 =?utf-8?B?cHc1S1p3dWU2aERJSWgwUHY3T1FXdUoxSVRKZ3l5SFY0RWpybTF4LzhXV0ln?=
 =?utf-8?B?TDBiajRBZ2s3MVZidDZwSFcrRXBWV3BtVlEyUjVQWjRPYUhZL0dISXBmaWZn?=
 =?utf-8?B?WVhZVGZuNDVoa25XRWw3Ni90Rk11VGtiajM5QzJNUHNuZjljVXUrVmFOOGVY?=
 =?utf-8?B?MTJWWnJmUGVmRjFDNmw3UlVaRFIvUmUvNVhDYWZDTTJEV2F6WmVhcklJTGhS?=
 =?utf-8?B?ZVI5VVpwZndLeVR1Y2hvU3hianRLNlNjLzJOeEhTYUYyVk1MMFhtdit2SGp6?=
 =?utf-8?B?THZFWndSRE4zWjBKK3kxWFVFTWp0RHA2OTZjVGk0c0NjOWJpVVhtL1RRQ29r?=
 =?utf-8?B?TTBkNFhsVVJqSGhhZUFuZUZqcS9zN0FvV0VKQWZUUkRvd2JZUWdnS3djYi8z?=
 =?utf-8?B?SGdwR3Btc2tLbS8xck1MVHBpaG5WblhueUJvTU5PR052NjBLMjdhcnVPUExW?=
 =?utf-8?B?UUMvcmoxTXhQeWpKbWUyZitKOUhVUkJ5R3ZRSGhFQUVpTUpGbzArdUZRQzc0?=
 =?utf-8?B?MXVrZHAxMkRMaGFEdHdFUzRmeWY2aXdoZUVIcXZGckJxNSt3bTh1SWx5emZl?=
 =?utf-8?B?SHozS0JsYjFWcWxHSFRwbGpCZnFDZ1dxOFFnc2VzT2RnUHcwVUZ0VUo4bjcz?=
 =?utf-8?B?R3c4ZG1odmJZblRSNHh6cmV6YU1nd0cvR25ybVYyWlZBZnZMWGk4MGVvaHBz?=
 =?utf-8?B?Y1BFV1gvODJZRktEQ0NuN0xzd3ErOStSQmUzYmlmcEtBbFpVUXVUVnhvSVps?=
 =?utf-8?B?alB4NnU2VFJsYlJDSGdOUVRjVW9pU0ZsWEZiTXhway9UWk9XcklxeElOUVBZ?=
 =?utf-8?B?QjV4ZEpnSzRzcVpSaTBiYmJLWXA3Y0Y3WDZOY2tPbWZ2WXNBSXlTV0h4UU1v?=
 =?utf-8?B?Y2NRdFk3WmIzTVRIYzFsaHVjamsvSzBxbHlGR2laeno4MzM2RDlQcG1wMzhH?=
 =?utf-8?B?aWVmTDQzVW5MdCs0WEw2M2lNN0RYc1Q5TG9TNUFBZ0VNeXFHR1poZkZQeGtS?=
 =?utf-8?B?Y2xjYm9LZTkwS1dybk9OYmhlZlJmTFdEN3FVclVvUW13V1luYmZSYUNkajdv?=
 =?utf-8?B?VTRLVDZnU1V2MlRNVFlhSXcyQVFPSjdaRXJtMy96cnVzQ3pMRW16MTNkL2Ro?=
 =?utf-8?B?RWtVcm9wVHAydlBWWnNyV3BEd2JBNTlxUldpRzhDYWFIY1NYR0dOOWVFL3ZZ?=
 =?utf-8?B?a1ZsRHYzYS9tcngyWnBFTE5DTUNwSlZKbzgvMXlWQ0prcUpLckZoUXBZVGd2?=
 =?utf-8?B?R1FQRGlKbUpnazBOMG41d0hKS1U3OCt5OU5LZEtDMU5lWVRJVGNIeGVuajNY?=
 =?utf-8?B?VzNZTjB3dFNWK2xFN0dyc1BXVEVhVWtlVVhGOUczL3lUOVlFaksxLzNiSmZT?=
 =?utf-8?B?eUMvTW5EalNQM0pibWhZUTdhZ1ZmUDdDaUF6ZUdLaGdSTDZKRm9teXQvY3Nj?=
 =?utf-8?B?MlhIcUpieEFPMzU0NWtlNlhGZkJEcHpmbVVMRW9Qa3dXZ0VKcWpGOTF4VEtP?=
 =?utf-8?B?Y3BPaE1ETXRFakk0QlFWalJYbFJhWG9FNzdqM2hiTS9Cc0kxUTNpTkRkNVJp?=
 =?utf-8?B?TklsOGVXNm5RVDZzdWlONU0xNFRmTGVZNXJUaStKRTc2Qm1KTHZURW1Tcm1O?=
 =?utf-8?B?Vi81bTBadjYveTgyendpa0IydTlWaHUzRTB1ZURMTVdmZFNQVUZuL2E2TDFW?=
 =?utf-8?B?NTg1TnJxTEpGaDBZdGZFRklrdGhhWW9jbmYwSEpaMjB6ajczZmgySnV1L2VO?=
 =?utf-8?B?SlRtcy95ZEM2MThVZVg1VmhsM29SaVJEQW5ERGo4TE1GZ2poN2NHanVRNjlk?=
 =?utf-8?B?R0FZais5VXBXc3AxRGcrRmZHTXVGbHJwYitSZEtSaXVIOWdmeDZNR0hnRkN4?=
 =?utf-8?B?M2ppc1ZUNVpUcVVMOHZpOWladjQvcnFoakxHNm1VRFl5eXh4MHYrWlcyRUtB?=
 =?utf-8?B?cDFoc1RVSndzbUthQ1Q0L003VCtkZkJYR05IZnJSTGlvVWlnQlkycS9BdFhV?=
 =?utf-8?B?ZEtQRksvNjB5Mk5DVGY2WXNEWVlCbEFWZitKdHIxcm8zbHpKMXNIWi9CMkRI?=
 =?utf-8?Q?oWmsJUwjYIe3czes=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7a15f9-6e81-4570-5f71-08d9ab72f1c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 15:40:42.1972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MoWTguJerrn7qnuTejKz6o0C/znOKoX/b2qOlJAWO6uzhu7mkluhdnfh/oJobHfrXQIqQw+NVG9AxA6CLg4RhG697//r7VJDjx1o0GL3ZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4333
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.11.2021 15:26, Ævar Arnfjörð Bjarmason wrote:
>
>On Fri, Nov 19 2021, Fabian Stelzer wrote:
>
>> On 19.11.2021 12:13, Ævar Arnfjörð Bjarmason wrote:
>>>
>>>On Wed, Nov 17 2021, Fabian Stelzer wrote:
>>>
>>>> In certain environments or for specific test scenarios we might expect a
>>>> specific prerequisite check to succeed. Therefore we would like to
>>>> trigger an error when running our tests if this is not the case.
>>>
>>>trigger an error but...
>>>
>>>> To remedy this we add the environment variable GIT_TEST_REQUIRE_PREREQ
>>>> which can be set to a comma separated list of prereqs. If one of these
>>>> prereq tests fail then the whole test run will abort.
>>>
>>>..here it's "abort the whole test run". If that's what you want use
>>>BAIL_OUT, not error. See: 234383cd401 (test-lib.sh: use "Bail out!"
>>>syntax on bad SANITIZE=leak use, 2021-10-14)
>>>
>>
>> Hm, while testing this change i noticed another problem that i really
>> have no idea how to fix.
>> When a test uses test_have_prereq then the error/BAIL_OUT message will only be printed
>> when run with '-v'. This is not the case when the prereq is specified
>> in the test header. The test run will abort, but no error will be
>> printed which can be quite confusing :/
>> I guess this has something to do with how tests are run in subshells and
>> their outputs only printed with -v. Maybe there should be some kind of
>> override for BAIL_OUT at least? Not sure if/how this could be done.
>
>It has to do with how we juggle file descriptors around, see test_eval_
>in test-lib.sh.
>
>So the "real" stdout is fd 5, not 1 when you're in a prereq.
>
>Just:
>
>    BAIL_OUT "bad" >&5
>
>Will work, maybe it's a good idea to have:
>
>	BAIL_OUT_PREREQ () {
>		BAIL_OUT $@ >&5
>	}
>
>Sorry, I forgot about that caveat when suggesting it.

Hm. Any reason to not do this in BAIL_OUT itself?  As far as i can see
the setup of the additional fd's would only need to move up a few lines.
