Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4710EC3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 05:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbjAQFGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 00:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjAQFGs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 00:06:48 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4371234FF
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 21:06:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mulxb63N6pr2EVZMfVEDixHD4YCHFOEsvRKrHVfxjYhbD/HUQHuL/WdB61xh4I6N53EnJpMyGKqVFkNCctFHJNgUI4DNydFse1hVV2ijJ34RMLKI92EcJBU/roReE5mchpt7uDZ4PcFdBRfn+MUzhaPUnMZjZHe3XEQo27RX5l01V9ra/XquFaDjkaaUxeQZZFrO7U3dWftOmWhcMaM5T4gW93XdiqshekZpMwk2jvqXVNth3gSws/fscIEsTQMKV7X28VGUTUWxFBFZCc7SnqUSCBOVzy07aNjX0aDwcfgaoEY+iStKcOxbYf32vvCz97IHPwxaunSh2qU+1IdDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a685Ny9W3TuRjmh99GG095TRUDP1dt+XWAkzJruxqyo=;
 b=LeMuPcLr0W//xnPO6G6GYRKJbkUqeu8rTSevhwyyNZa5gbmOXiQGIEKSnK8YVl/683lBmM/gopqogobigl7cl77Ssgf9L4lK2vIHJKeesAwFPm42gyo0zebc/K2juDtRe4a7dqjIpHSi7RDR3SeMXBmtmwgR+V0Gr2ngWt6tnB4o4R8LTPp4ynv4Iq/yZr61oySj4oOUm9TP5ALDj9u868ZXLmrJDb8TNQjEIrctZYUb/0Y8zdunDMkXRTuhzx2XX55UN1PvYtbqX1YlhaG+6b+m8CXRJxcfAbe1t5l8aKoAZ5YkeDGaFUZdfVLeDE+CaLyuJAB5RqGUJvnfvup94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a685Ny9W3TuRjmh99GG095TRUDP1dt+XWAkzJruxqyo=;
 b=tQmTpR6l3zoRspMCdJgRtNRNW2zE2Wd73wXUZ3qwl5MCaPbOKP87NOp+EhCcyXMluv8HGiOtClSUHGDm1LGLfifH3EHSOUQzi1GYCuOX9UT1/glZH3Yel4bAUiBNsQVrZr7IXuwxbwclTvzXaggBp7uR/LKSDITVQz3ArL2Nrs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 05:06:38 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 05:06:38 +0000
Message-ID: <3a2d4559-fce2-80f3-bafd-5eb8ac1a7eff@amd.com>
Date:   Tue, 17 Jan 2023 00:06:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-CA
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20230117013932.47570-1-michael.strawbridge@amd.com>
 <20230117013932.47570-3-michael.strawbridge@amd.com>
From:   Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v6 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
In-Reply-To: <20230117013932.47570-3-michael.strawbridge@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::12) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f68c675-2c2f-4249-596d-08daf8489cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVzXKOIr+t5HmnS7wLVEOVbj+62Mo17E/hMrnijCVLuQnU5OFRg1aFUSgiMSZOoEUbSOXiQx+S8vol+sZEk6M9sAzXwtoElbV/QXPGGJjZJ3cm8AE+BH5h046J5v/BUYaSTFMt0raYDiWHrQFv3fbp/f5n4DYfP7i1l7QzMJiEPtBYos0Dfc/oMhLKpsXk06ueTfEdJSsKLNdGmEIlMw1Qiz/hbfafrDw6giKY+io/bEY9gTvPhE3r8/TyFDk0MDzx96E8/0rapZx6Ra0OK7kgpQvblxK6cH02+T9+IewXjXeTfgov7qm3xfuN45oca+ry4tFx0eKrPkRX+2tY+/HwP7WwJAU0vPs8E3PNFmBlbfwemk1UK0f2YoI8rcp6NxVQ2FET6ptN1/NpxoFcbMgaXao5c1qoZ3JA/ZejB3SByhe2fbfEDZxlKV5aH5HgukQ2WhHUu8S2oC+81BbSUEfpoHK3cQc785WLuWWIEwP3zRMMnvHmFSqZ6N5EQYbb+bY+GETi4wMrC1H3IOFjoOPkfTu6BPZIsjjKOtqbMEcwHqMeq1ghzhLghizI7cqXv9y8KpZFftxumMogVKMM2r4lu+FG0Gg7NYU44rl7osGKg2FOeUNGYeZNmzoNOWcnEZd3r33oJ5ec/Ndvt88kw3Fog4hndfTspa+3+689xAM1np4o4ZSVgDYOeDrEp3yGHtYcB5SA3ZLIvSXbWHkCPjlleauXcAiFPZiYVFR0RWG4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199015)(83380400001)(38100700002)(2906002)(86362001)(8936002)(5660300002)(4326008)(31696002)(66946007)(15650500001)(44832011)(8676002)(66476007)(66556008)(41300700001)(186003)(6506007)(26005)(6512007)(53546011)(2616005)(110136005)(6666004)(478600001)(6486002)(316002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZ0bjByejhTcTJ3TGt4RlRWUGsyU01BK01RVFc3bGFPMC95VFFTNUhTNmJr?=
 =?utf-8?B?VnhSZkNSVlNRNFpUYnZESkJ5RW12ZURkTExNZzhObHczZmxnYjNCRUJKektI?=
 =?utf-8?B?ZVBEZW9kUnRiQmpXblpvOXdUaG5pTGVKb3Fud0RvWHBtR3lVNU9McmtzQmlH?=
 =?utf-8?B?MzN3blpIZVFqVkk0MmRJQUROQnFFMjJudXdtbkY2NUlIVGJLeXFYZytGdzlZ?=
 =?utf-8?B?c3dMajZTRzd2OUlLSEt0RGtxYUtwOTc3RlIxWTJaWmZRc3hieTlFV1pmVVhq?=
 =?utf-8?B?RDZkQVZzR3dha3pWTWwyWlRTZjNDRWtYM2ttay9LQmw3TitEQ25ZQS80azRh?=
 =?utf-8?B?dGtCcHhJNm1aZTNkYVhycGZVRys1My9HSEJXdk8wUGNmSE14czh0c1BKWVV2?=
 =?utf-8?B?dURRV1JneEVZUi85RFg1YVJKRlBSSThtVmZGdFVpclU0SC9MRXUxMFhmN0Yr?=
 =?utf-8?B?cmpXMi9aSHgwRmJZaVZTbnFiRnI1djhzcGN3d1ZTcndweXJkM0Rxb3JNZUpN?=
 =?utf-8?B?SW15azA1YjdzNElMMVBuMk1WTldyVnpxRHlIV0dYbUV5Uy81UXpTVjJrYjBm?=
 =?utf-8?B?ZlRwdGRqd24vRjRzb2k5dk1nUWtmVWM3VzZtZDhtT1orSHBZbytaSlE3T0lT?=
 =?utf-8?B?ai9BTDVQMDYvMTFvMXphVVpDOFFDdlVONk9rczVsMkQ5QUVXOWVodFN0bUpO?=
 =?utf-8?B?SEpMVFNFQlJDVGo4T3kzSUlnMlgxbUlnUmpEeWU3b2F0bXNaWDVZb1EzR1JW?=
 =?utf-8?B?NS81a0FFdE5FTlh1U2xPY1lTTmlLNlNVbXRVNnBlYTBBYVVTenNhTzNnVW5F?=
 =?utf-8?B?MHVwbFF1NjJJNFVsc2hpNk9iWVZoWG5Pd1N1Ym5NdU4yQ3JzdTZJb2VySVBw?=
 =?utf-8?B?NHh4a3U4bGxkaDl4RFN6eGdiMW5qSFRGUVZQQ1FWWDh6Q25rT3hBMGVLWWw5?=
 =?utf-8?B?K2hWT29RSmtCRVlTRHBxZ3czQzIvcFd4TTdqenFyd2VkZUgyTlFrVlhkQjly?=
 =?utf-8?B?RTlEU2tUanltbWdhYVA1elo4OWhCNzB5OHFlMmxrcCtNSXdKMEZBQlZxWGtD?=
 =?utf-8?B?QVlQbzJGbDA5VDdUQ0Vwd0ZCRXh4L0h0Z2JTQXdJQ3JWT1MydVJjMVdMU3VC?=
 =?utf-8?B?ekJsd0VEbVVjeVZ0MFRydHlGa3RoTmFiZzgyTHZXT0JuMkVnUDBNSVZubXFk?=
 =?utf-8?B?NTRXaElJODRBMTM4RnluaFVRWVRiZ3ptNENVUDZnck9RS3JEbUxUdUh1K05l?=
 =?utf-8?B?ZVliSTJ2cDFPVlJZZFlwV21mUnE5VmM0b2tpY0ZQMGdqZTdoY2ZUYXllOGsv?=
 =?utf-8?B?QkZzUnBlTGpYUzdqK001K1lYNFhTWXJTT0E0OHpjYkY0ZVE2OWUybFptNzlj?=
 =?utf-8?B?Mm9UNStiZC9BUmxyK2xoT2tNS3dqOXovd1U4QzBHOFMrTVVnL05XbnlZMFk4?=
 =?utf-8?B?YWtEaXZneVFMRHpxbWg1ZURkcEpEQ0ZmODlYNlhMaTg0M0loMWNwZ01XMmd2?=
 =?utf-8?B?MEZINGRmcCtwVzBZMG5ld3BPZDc2Mm0yKzg5dVZVcGpRSnRFTW8vc05yU3Nm?=
 =?utf-8?B?YnpFZjU0aDhEdjQyOTdHUldHMU9Ccm5FYVMvTG04bmFqYWMxaWdnc0pGQlh3?=
 =?utf-8?B?U0wvbWVLenhZemQ4WkdrNEZMUXVBbndIcTMyQ1RWdDcxQnJxTzZML0VPdHc3?=
 =?utf-8?B?REpjcXJJR0RFMXFtTy8zWWlIWmxLVXd1M0UvTXVwb2VKdGJrblJ3amhVSjhS?=
 =?utf-8?B?VDA1NHNxeGw1ZDVrR1JlVTNsL0JNUGQzSzJJLzdvRTRUK0hhVklLWTB6Uy93?=
 =?utf-8?B?ZkNzR3pPQ1hCSnEwaUFpaVN4ZEFXM0J2K0RvL2V4dW95Y0hPbitTUnlVUkx6?=
 =?utf-8?B?Q3hyWkJFQjZ2L2ZxMnk3ZTlCY1NPTElQNFUrRi9xWEFiaXV1ZjJ5SWtYMGY4?=
 =?utf-8?B?YTRVcjdxNlRUeEtIQm5NSWc1TWFiYkNnMklwdDF2dGMrOFdDSStCRjJad0Vx?=
 =?utf-8?B?Z3VMWWlIa2l3R3VWRkpUeTJPSTJZU1BaSHZ3WGpsTmF2dTl2NUZFMVJhQkpk?=
 =?utf-8?B?Qi9kKzZwMmNCbkpvcVN6RnVWRW1JRlA2bHlCZ3Y3bC9kekxyZXpvdHhCaWNr?=
 =?utf-8?Q?7ZkwcAmBA1DwWzoXRsBVAiLEk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f68c675-2c2f-4249-596d-08daf8489cea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 05:06:38.1377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiBL/X7wLsFxyaSOeyAKilVabID0Fot8xGMZvCsPHr5aHLUurXj9llQQu7VQ3yrh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On 2023-01-16 20:39, Strawbridge, Michael wrote:
--[cut]--
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 1130ef21b3..346ff1463e 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -540,7 +540,7 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
>  	test_path_is_file my-hooks.ran &&
>  	cat >expect <<-EOF &&
>  	fatal: longline.patch: rejected by sendemail-validate hook
> -	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
> +	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch> <header>'"'"' died with exit code 1
>  	warning: no patches were sent
>  	EOF
>  	test_cmp expect actual
> @@ -559,12 +559,55 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
>  	test_path_is_file my-hooks.ran &&
>  	cat >expect <<-EOF &&
>  	fatal: longline.patch: rejected by sendemail-validate hook
> -	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
> +	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch> <header>'"'"' died with exit code 1
>  	warning: no patches were sent
>  	EOF
>  	test_cmp expect actual
>  '
>  
> +test_expect_success $PREREQ 'setup expect' "
> +cat >expected-headers <<\EOF
> +From: Example <from@example.com>
> +To: to@example.com
> +Cc: cc@example.com,
> +	A <author@example.com>,
> +	One <one@example.com>,
> +	two@example.com
> +Subject: [PATCH 1/1] Second.
> +Date: DATE-STRING
> +Message-Id: MESSAGE-ID-STRING
> +X-Mailer: X-MAILER-STRING
> +Reply-To: Reply <reply@example.com>
> +MIME-Version: 1.0
> +Content-Transfer-Encoding: quoted-printable
> +EOF
> +"
> +
> +test_expect_success $PREREQ "--validate hook supports header argument" '
> +	write_script my-hooks/sendemail-validate <<-\EOF &&
> +	if test -s "$2"
> +	then
> +		cat "$2" >actual
> +		exit 1
> +	fi
> +	EOF
> +	test_config core.hooksPath "my-hooks" &&
> +	test_must_fail git send-email \
> +		--dry-run \
> +		--suppress-cc=sob \
> +		--from="Example <from@example.com>" \
> +		--reply-to="Reply <reply@example.com>" \
> +		--to=to@example.com \
> +		--cc=cc@example.com \
> +		--bcc=bcc@example.com \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		--validate \
> +		longline.patch &&
> +	cat actual | replace_variable_fields \
> +	>actual-headers &&
> +	test_cmp expected-headers actual-headers
> +'
> +
>  for enc in 7bit 8bit quoted-printable base64
>  do
>  	test_expect_success $PREREQ "--transfer-encoding=$enc produces correct header" '

As Junio and I discussed in the v5 2/2 patch review, here we may want to
do something like this: Add a custom header to the SMTP envelope and then make
sure that that is present when the hook checks $2.

To add a custom header, (and this uses real-world data, which is good),
use the following:

git format-patch --stdout --add-header="X-test-header: v1.0" HEAD^..HEAD > /tmp/some-temp-file

Then the hook verifies that "X-test-header: v1.0" is present in $2, when git-send-email
is run with /tmp/some-temp-file.
-- 
Regards,
Luben

