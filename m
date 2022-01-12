Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E38C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353070AbiALMKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:10:42 -0500
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:26592
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240575AbiALMKl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:10:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiCHFvYFWHw294xevgBN9W/UnMr2BczUAmJWm8ePwItY5Lzur1VvTa4pJYsU/8rGgTZqscmJnwFZcoY9AnHsJ351r9nlkzWcLRo81A7AvQ33q/w+NV923or9eaXYg5A2jgWHtWfZsRwFZ/h4C00/4R8JH7sVPx6gbzCbHLnctyaXk/KSh6cVRdxDeMu/xG+NNX6oa2zHRWIpdEQf5RxVK+SqbNYawZvi9Xfg6Z+cuWLdP3UzD1NJlcP/sJ7dtN8WziDRN+EcoNFYQ5v6fDpo3FJj2EYTVB3rAi3R4XbK2bUGy0AgYEtOpqdL2mvsQiFfIYps696/mIo93wuZF4ySOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frPtI+oFx12gRq1kknItoNktz9qsB7XB5AohpARwdX4=;
 b=ThSRfGhz/YDVLH8a7+W9U5CelHt1CFyFd5DMUVJLXxCyJ76ZgTONbM+p/0TDnRe12Dr+Y4QcpZLUAmrpTHFpp3p39jAi/BkUd7qEC3OmLSj8m6ez2RBrmd4ikJL40Ik5oXc2Zy1Pbxzuv+geK6qUOufL8Y55BiShu4IFXD400xUAs7x1Q7U7qHwJnTebvDazFDwTp0oMphGLmji6GtpsaX/Mcqm7oem9ImUJN+TmHP0lw7ZVeiBRMzLf7cCdFjDAofu3C3t1XBUJBunvU0fY2QbF72F4x2QbtDwfnNnBd/UpTMajG5xvXHboKymI/hVZTPx0T28XbOvZ4/Uy5c94Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frPtI+oFx12gRq1kknItoNktz9qsB7XB5AohpARwdX4=;
 b=GUFid7ex3zp8YC94Tj74QwqVRNeWTkItCrozusG4fWpwikUO/qGcrXm+pUO5LCzUzbec6PDOLqNQBtq6V7K1Ck4FN2VL4Ot6gzpsFUn2HSePNFvInIf/LxJab2ijBB2dJW7DPoPUM1dInvB+jnEZnpZ1kIhvHVMXlgJFO7NMKKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB5088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:217::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 12:10:38 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%5]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 12:10:38 +0000
Date:   Wed, 12 Jan 2022 13:10:37 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] t/gpg: simplify test for unknown key
Message-ID: <20220112121037.6gvmvbjyovzuhb2j@fs>
References: <20220107091432.581225-1-fs@gigacodes.de>
 <220111.86r19exl4z.gmgdl@evledraar.gmail.com>
 <20220111172621.qwupg4oyosvpeguu@fs>
 <Yd3dQkGxG1hbjThH@nand.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <Yd3dQkGxG1hbjThH@nand.local>
X-ClientProxiedBy: AM6P195CA0017.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::30) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09c98170-acf6-4883-011b-08d9d5c48ba6
X-MS-TrafficTypeDiagnostic: PAXPR10MB5088:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB508882395099EC8A14EBCD3FB6529@PAXPR10MB5088.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5HZXVfWMgI8zCsD/4X7CsE2l47EjZzYec1OXR7fSjOKJg2CTMW6k7eKwnEWpHtIgSTle/bzf7JIlr+niuA5A5B0GatEx1mpc73o7/XdG8iuGSIRDE+zFQ7AoiPGCevo9BGU9rtFoQIG2BhNapDM4fX7E95bT1QcdfsTFOQXGCyQ1Kp/i12mZfG9G8e6JnOMu0oJEy3w9mG32N++/BfrLrnuo2jOl9ScJH+TH0OtwNoParRZTOFXBWh0QeenR1nvzKMCW53KQyPj55O15ldIZCLhYjkVMtaeKGps72GiB60p9OzRjpZSs0z30nVGOnVdpO7lVAJQwRkBDxEZBEkiz+F7nJQY4P01pHpDPYKlstL1ZuEQWESzWxhP+bTYMqF1UsD+SHO1mtQm0k78MxVLNgFc3G1SaqFWAkAoPXsLyTeItjCyq853GSbsOyxRwK+8belK563N1u67kbvqYf8N7kqTqN6I6IfV/E6per4e40J0RNC2r7SxBV0nKiLBm/HCdVmV/uKo9Tuy+uU45Q957pYiHgtazOwXsve9TJN4EHw19MHhVAFo8Lo739KqAMB1a8ppBS/h6pRKCt5xY2RynPQkSuEZXFRdTAMLNLwtFO/UIUWj4HGhJczDxFWFiiPwHq7PK1yI74vf7TRHXUvYIWckMDhdRLhxaYpe5PrtsDXJopSvK4K45ZZLq4MRXYORkn62ZN5+qLQpNIVQ4hxA0rRjRrUpB/hzZS3n/lf8lA6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(396003)(346002)(136003)(366004)(39840400004)(186003)(6916009)(6486002)(8676002)(53546011)(2906002)(8936002)(66556008)(66476007)(66946007)(6506007)(7416002)(86362001)(4326008)(1076003)(33716001)(54906003)(966005)(508600001)(83380400001)(5660300002)(316002)(6512007)(9686003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzN5YWhhYmZBUXE4cU9HY2YwckFyWDVOM1QwbkRjSUFuaHM3NmxORGRHZFJU?=
 =?utf-8?B?MnE0c1lydTJBMkI3UGpBYVVVVkNmYkFXQzZEZlZ4aFBQcWtuZ0NQUkNHKy80?=
 =?utf-8?B?QXhLVGFWTTJ5Zy8xUnhvQWI4cmRPLzdHK3VaOENjakxkeEY3VW8raHNxcW8x?=
 =?utf-8?B?VHlFTW5VVGJ3ZWROSlhhS0E3TFdRdHFBS1FYRmtuMHhMS3M3Zlh3K2NPOGM1?=
 =?utf-8?B?OWVNWVBkYUhabTRHS3Y1RThQRGJZMFJaN29WRWpuVmRybE1leDVnL3o5eTdn?=
 =?utf-8?B?U1BOSFdIaW0yVVhKZm8xRi9BV000RW1WTGZ6bi9FREZzZVlNS3FKTW9FajRn?=
 =?utf-8?B?UTlCbmRMMGR5VW5Rc3puNTdKcHduaXVRWWhsbG5HVmRWZFowakFQMXhSdDJ4?=
 =?utf-8?B?eVdZYklrcWVPcnZFQWpzeEk1QjZMbXdvWVlQeVdiUG45b2RqYnhaMGlJS05B?=
 =?utf-8?B?bHhjcUFNTXBBL3MxQm4wVDRDa3FXalVUU0xFUHN0OU9TMFdDQ3FDT3lJUzZG?=
 =?utf-8?B?MTRBNEF3cXBxVURTaUMwV2JPcnNKeENVMVdkRmpKSFdNWXNkYTU5REI5VG4w?=
 =?utf-8?B?YWc1MTdXSjFZT3RRaWgxYTRTRFpIT2NndStNU1dJUEs0WW1HRXREeVM3Y2Jz?=
 =?utf-8?B?WlZaRUdwZDJINHRzSUR5UnczamR2dktTR2xvME9uQWpzOFJPV21EM2p6eDVX?=
 =?utf-8?B?TWNiVUM4Wm1pbzJRb3c2QVc0N1FrZVViMlpLZUlzNHQ2eVBueGxoa1l4Q3pO?=
 =?utf-8?B?Zkc0R3lxaDBKVzRiQ1phUG9Ya1dYV0tkMnhRMjRTSHQ5QXVUeUpKUXBOYjFk?=
 =?utf-8?B?ODYwLy9yWWJvdkJCUjJUektoYlJzUGhvSkt4MEg0NlptMVNvMGt5MEZHa2N1?=
 =?utf-8?B?alZ2bllQWFFSMWlBRDNWZ1JkaTdqV2FnNVBvUkEwT0E2Q3lnYXVtbXpSOUFS?=
 =?utf-8?B?VEUwTGhxb3FKVmxhY0dNVG9zNGovRWo1SUVJK2xNaWREVklLTHdjdmVxS2tZ?=
 =?utf-8?B?ZWw0NXJpS0JJRDNhN3lyUTEvOGVheStZdEtNVzU2ZTdrZVE3dWNlNDlRb3Zq?=
 =?utf-8?B?Z3ViSmlKL2pvaHdBcFFSei85aHpzaWZ4UFd2MVp4cW1iNzB1WjVzTEc1M2N4?=
 =?utf-8?B?Z0VYcS9iQlQ3Q3pheERSR0hlaUhaTE02Qk5kSkVRYWNmRnRmK3JGZzl2TnR2?=
 =?utf-8?B?M3M2K1h0KzRGRCsyeitvZk1nemVDUFJmenFxMmZ0M0Q2Q25UTHI2OUNrZThj?=
 =?utf-8?B?NDNEVWh4Vm9HOU1mbGxiTmQxU3N6RE9aWnQ4UCswamtOSVQvU3d2MktJY3FZ?=
 =?utf-8?B?blBDNzRobS9RNlRFYURHVkNVU0ZNa0duMXV1blk1enJPU1JKNnllSGFsekh0?=
 =?utf-8?B?WmJoODFzQjVadHBTU0orQVlhTkc1WnZ5enFuc3hhUmNlV2VEYWhFK1d3Q3ps?=
 =?utf-8?B?MS9XUCt4OVFQRlpyUk1hUjhwSnQrRzZQaU9ZY3lPV2RwRnVFQWErcDYxWmtx?=
 =?utf-8?B?L05mSk80bkFGalRJYkpxSzVFWkhPSms0UFNPZlhkbEpwa3ZVMkJ6UjRhcHJz?=
 =?utf-8?B?bURHSTdjZDJwZU44YWJtakxUYVZ1OGVMZUtqN1FuU2E2THBZY3h5WmdSaGxI?=
 =?utf-8?B?QVhqSDRPS3RVVzhMQ05oTEdzdE1ML0tWV0Z0QVR6TTdXTE1BZEEyL2RUWkNT?=
 =?utf-8?B?UW5JUzBweUhnZi9rUzMyUjFERktJVS95eXJsWWVwL1ArbWtqTWZpWFptODVz?=
 =?utf-8?B?d3lSeUQxM0d4OUVaZWdpK0FLN2JBclYvZHJMa2J2bGE3T1JpQXQrK29yYmp5?=
 =?utf-8?B?Y1g5OURYL1lyUTJ0dXBBRXhtYVVaMmxoOUIxQXEwRU0vOXQybU40bUFCOGxa?=
 =?utf-8?B?dDB5Y1BEQWx0WnIyVEVtRUl0UGtBbmt0ZUdkTlpjNWVqY241L1dQcVA5dGZz?=
 =?utf-8?B?T1R4Vm9OV1cyaUt2dG1IekxWbVdMRUhnRjVBTUJhM0V3M3VRSWRqeTVrR3Q4?=
 =?utf-8?B?bW9LaERZZURqMFNBVmhmOThWUldxcEtQWERRKy9vYVVOMElSVkNyY0JXME5q?=
 =?utf-8?B?b3hENmRtdm5qQmd2aFV0eloycmZmcmlWL2VpdVQ2NFd2Z0xCMGpHVFlDT1F6?=
 =?utf-8?B?VWljWmpOcWhhSG85Rk5MSFNab2lqZUdtV05pZHdNY0JuMFpWdElFVnhkQjB1?=
 =?utf-8?B?V0g1VS91UWwzTGM2YmJJamVNUUhFcjJnQzJKLzlSU1FReVc2WjJZbkcxNC9G?=
 =?utf-8?B?MldjRm1TWktYbTdEKzYrVWxLWnRJeGtxSTl1alIzdkZ1b3VpcWN0WFRJNmhY?=
 =?utf-8?B?akIwSjVWOTQvaVVkd1hFS21UK2xWeEZUbzlLWlhhZlhTQm0xY2YyZlhhbTd5?=
 =?utf-8?Q?+Ie3q5oum5E+tGAs=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c98170-acf6-4883-011b-08d9d5c48ba6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 12:10:38.4572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abwKq2Hf0TLzwa8EZus/Ogb9jmrKnNEhkBYa/EKnefG6Ij7VzuR7N0NpX9/XG4OJS6ToxqQPJKV0GpLRwMX+DE7IA8OuhvXgdGVWlTP5NB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5088
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11.01.2022 14:40, Taylor Blau wrote:
>On Tue, Jan 11, 2022 at 06:26:21PM +0100, Fabian Stelzer wrote:
>> > I was about to submit
>> > exactly this patch for you but with:
>> >
>> > 	-       test_must_fail git verify-commit thirteenth-signed 2>actual &&
>> > 	+       test_must_fail env GNUPGHOME="$GNUPGHOME_NOT_USED" git verify-commit initial 2>actual &&
>> >
>> > Both of those are probably a good thing to do here. I.e.:
>> >
>> > 1. Didn't we have portability issues with "ENV_VAR=VALUE shell_function ..." ?
>>
>> I'm not good with portability stuff and trust your judgment on this.
>
>See [1] and the ensuing discussion for a good summary. Re-reading
>that thread and comparing it with what we see with `git grep
>test_must_fail env -- t` confirms that that
>
>    test_must_fail env GNUPGHOME="$GNUPGHOME_NOT_USED" git verify-commit ...
>
>is the right thing to do here.

Thanks. Interesting

>
>> > 2. You're pointing to a nonexisting ./empty_home, but shouldn't we use
>> >    $GNUPGHOME_NOT_USED? The existing "show unknown signature with custom format"
>> >    test in the same file does that.
>>
>> I was not aware of $GNUPGHOME_NOT_USED but it is used in a similar fashion.
>> However it is set to the old value of $GNUPGHOME before we change it in
>> lib-gpg.sh which seems wrong to me. Wouldn't it then just pick up the gpg
>> homedir of whatever the test environment has?
>> Using the variable is good, but i would set it to a known empty directory
>> or?
>
>Yeah, t7510 captures the value of $GNUPGHOME as $GNUPGHOME_NOT_USED
>before sourcing t/lib-gpg.sh. So long as nobody else has tampered with
>$GNUPGHOME, they should get `$TRASH_DIRECTORY/gnupg-home-not-used`.
>
>But I'm less certain that there isn't somebody accidentally ignoring the
>"not-used" portion of the test $GNUPGHOME ;).
>
>And I don't think that reasoning through it all is that worthwhile, so
>I'm fine with what a much more direct ./empty_home here.
>

Yeah. I checked the other uses of GNUPGHOME and the NOT_USED seems fine (and 
more consistent with existing tests). So let's use it.
Even if some other (non gpg related) test accidentally pollutes this gpghome 
it would surely not do so with the actual signing key used in the test 
suite.

Thanks, I'll send a new patch in a second

>Thanks,
>Taylor
>
>[1]: https://lore.kernel.org/git/xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com/
