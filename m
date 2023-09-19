Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F134FCD5BC2
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 14:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjISOFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 10:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjISOFL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 10:05:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E71C83
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 07:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jK07GQCty+W5+RJy9GaGunIQOwBbSJK7WXmsVu8rB0WfG0CnKv2sprv78Xet6/OOj16OX/dxiGMwdSc95VsmxtYWVSSFbd2PSc795A5gR/fBYebifBFzPMnRXYRaxG8RISjbC/B2OzDx4EWLBEgqp50H2Igbhh0cEU9slIrtA800eWlKA0t9YDHtkVXkigjCLNqBY7kgTyaBiT05fsAGdkZlX96zL+ZF3d5bLHGmwZ00pL/3voDVLUSjPNeHnk0/u6xmjNhf1ZuxBRV+EF300nRMqpLfuV1to21EcCr1bscLOGoepcwotn3B4KgTh4SAbOC0Wl8W2UMLh9XsOVSDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzJOsFP3hS921UaTtKDBrCfe4k1kAd19R4GMUNu2Irg=;
 b=JSOuhd8H9UKDPkOPBeVZDnV73XDerqECEyew8YCxThJRXrPMm6LcKZXmxgJZeGMtvGup6EQwiMz1UzohT44IqTV6rVPUZLkafUaFbayKeLPKysVkIH+pz5TPUAC7do+qEfj7I3mwEaD5GUCC48RnAfwJf+IrOvA219BLY5BT5Iw0lNWBtPC/Y45ih+WU06fcx+uCaoVkK5sZcVXtTfK+GqScJfTNvQrLd4i949ZtXyFWWwGVh9QV6rZgvrqMPzscW4H/S7KZ4eqp5Rk9QP0xFkUmKFoYt2kd8XzYZv5axx8mNz8b+cDdC6sYLlQinVxYZkVqJnr1NXcI1grbyCMREw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzJOsFP3hS921UaTtKDBrCfe4k1kAd19R4GMUNu2Irg=;
 b=voWhia4uIm8/vAsnqoE4GMzmsqX39slS30hiXpQZg6S9QMt5iAhLFySj4d5aODUfr1xtOVKPeSwBrN2azouEOxN7WiG92wugk5K2MT4cFz+hMJBiaqV6/F2VZWbAgXELm4kaHDAvs7uMjebyldkss0jAwfB2rYOFnEiX5mlf5Ts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 BL0PR12MB4994.namprd12.prod.outlook.com (2603:10b6:208:1ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 14:05:01 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 14:05:01 +0000
Message-ID: <4eb0d21b-be43-529a-bfdd-3f1d2b4d3e84@amd.com>
Date:   Tue, 19 Sep 2023 10:04:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [REGRESSION] uninitialized value $address in git send-email
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <ZQhI5fMhDE82awpE@debian.me>
 <8fcd6d2a-2c16-adf9-da1f-6b9d6fdcc87a@amd.com> <ZQknHjKdGZV3vJpV@debian.me>
From:   Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <ZQknHjKdGZV3vJpV@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0964.namprd03.prod.outlook.com
 (2603:10b6:408:109::9) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|BL0PR12MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: 5830974e-6029-4928-7929-08dbb9196a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jFz+8Maa0dF6DO3r9TKk0cb7ZiTfD8Gs0p167/qnNfy1RpuvrLqtGa25bxEUwDMIpz3qrMmpwwLWBa+09dguhd688sbeaL2UlBVgY4cmfZqU6jTqQs/gqsMaCWSMy9scoTkY90PaMi7GVf9sGc3GltiGBM5kJniIOfZfOOG2kqX3bp55hZ0e6XW7rAFD+WaQ7uJGpOZiz3owH9l5/SrOR7qD4OmLd9cEoIQ4zQhrTKDTxQtXiSn8DK6LgiO0WfPUM6BB62lP7MVhlb5HH5+FJ8XTfW2DTZDVckFFgv9dVMjDEN74QRJ4OOjpFuyTKLucT81b70SJlE8V37DRGaMouI+RcT345p6aH45rL8TxnvvDOAp8mQ9Ntw1rhT6cR2PWeX/UlMX8URwTlAllrERDvFwZOq1ozD7P92oifc43LXrWoBfM4ShAbFjFajkOkLsdZw2PRFQB3ugvRkGIkKh9v/j9J/LNntL1OsFmepT95CZGPoVnG8aocQAY/g+hdhW0sDAHX0LhRNp2ldiA7zEilMO51whNEdSIJLnyWkMw4VrZwWMACQaWbdH9S5ugFjPzsDWyTplczGB4UnuE18szfCWPQSXuntIZldxMjGPjv4gPlCuT6LQYlEodBmVkuTpPDxvjWxjvYASO8Orf9Ue5uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(186009)(1800799009)(451199024)(316002)(110136005)(66556008)(66476007)(66946007)(26005)(2616005)(83380400001)(36756003)(53546011)(6506007)(6512007)(6486002)(6666004)(31696002)(86362001)(38100700002)(966005)(478600001)(2906002)(31686004)(8676002)(4326008)(8936002)(41300700001)(44832011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUdKR0xFOTBzYm5SVkM1Y2tkaXdidVpQcTR3RERwZ21YZkxMaW13OU5zVVgw?=
 =?utf-8?B?THVoL0RNVHYvK0E1WEdhUWFBUVRFSFZlTUFmOHZvTzJ0eUJ3M2xiVER3T3RB?=
 =?utf-8?B?SHE5cG4wandtVXNkOUFvWWlaVFZSdTQxdTlFV3ZWY09ENXUvVm9oRmlkcHNR?=
 =?utf-8?B?ZVpBRjZ4c1E4UGJQMlhCamxOaENVNXV5YWVBL2NiU01oODRveTRMbWVaSXk1?=
 =?utf-8?B?Z0VYZ3V0aS9sZG9BU2o2ZkwwU1VQL3V5R20rR215NWZWeXgrcXFzSTRvVWlH?=
 =?utf-8?B?dkt1eXRQcUtUMGlveEVFR2UwSTZTNVFMSUUydW5RRHhZNXpZb2U4M2d0SllK?=
 =?utf-8?B?Y3E5NmFuU2NBTkFreWpkSmdpakNjZjM3MlpDVVBmMDdndERJWHFSZ05GTzR2?=
 =?utf-8?B?bkJXMkEwaTRzaDhEYjhSOU16bTJ2aFBYV0Q2b080SEFKQnB3YXlwTnU0anow?=
 =?utf-8?B?SFI0RG41WWZFdzhlRDIyS01DejYyY0N3RmdjeTNzeEZrLytwT3ZzTUtEejlQ?=
 =?utf-8?B?VzVJQVFRakIvYjhySk9SdExPVENpK0VLd2U2TzZybmFyWHAvS09pOHI3QkIv?=
 =?utf-8?B?M0FuQyt1ZHY5dWMwUVNJWmJXamRjTDNmL1A3dlZHejdtZnM2TWMzMDZmdmJI?=
 =?utf-8?B?dmNmc1lmMVZWQlRXZzAzS25aM0gycVRueWlZVk9aNlVpZ3FOemlZbEdiRWkx?=
 =?utf-8?B?d1c5Rk1pWG93dG5ma0FLV01jRGo1aUxDTkVSY0FtSmVzM0hRVDNIR3R2Q2pE?=
 =?utf-8?B?bzAzd1V1dFcveEluZVV4cTZwTlMyeHNuV1orMyt2c2UwaWwxaXFRZmo4WE5a?=
 =?utf-8?B?WTVkZklKSjM1aCs0NGdtSjZLdE55Z1dEYmhoUDFMYyt1Y3FSWngzY0pITkV4?=
 =?utf-8?B?TEw3TEZMbVZGK2RYeXN2RWdQclU5VkUwT1FMS3Q2SkhPQWdjcW1QV3RMcy9p?=
 =?utf-8?B?Q2l3T2xRZW1MVjAxRXFWbW5YNFRHVEIvM3RhN3h0Q01ETTBkN29ibnVpNGJ2?=
 =?utf-8?B?TFlMWGR4OG8wWDNHenRiTEJDNkdrdlFhMGZWOGpTaWZGVEJmMlp5ckJOc3px?=
 =?utf-8?B?YVNuUWR2djNwQ2NoczhjbkdkbDhuUHJrVzhtMGxOaDU4SURkVVZLRjNSMDF1?=
 =?utf-8?B?U3NxSFdxdWpheDhEeElYZ0wzMVhMa2p1RC96UitUbVA2OElwSWFjY3BNb3BI?=
 =?utf-8?B?TllsanF4THN5cERxWHJWNlBwU1piOWNZdDFnVlE0amNwUHVVMnB1VmtwQldY?=
 =?utf-8?B?WXNBNWZqVVc3d2d2ZStnWjFXdUowZHRZK0dGVGdYZnEwVWExYjlxdlhYZFV5?=
 =?utf-8?B?SDZTWFA0ZFEyM1pTR1RkcjJCK0loZDZ3SDQvOVJIcWNZeElyaTRkTHd3NUph?=
 =?utf-8?B?TUNjZUtLNWUrZVA4Um52bFpvK3N0ZFdaSmY5Z3ovb1NQMUdTY3hjdUkvZVBn?=
 =?utf-8?B?Uk5rZUpRaGlhNzdnWkZ3TzJhY0xscXZzYmZqaENmMVhmYmg5REdYTk05Q2t4?=
 =?utf-8?B?MmtRR1B5dmc3Vk44NXhweHl2QXVNeGE4eXl2S1p0N2lPelNoNDNxM3gxV09P?=
 =?utf-8?B?T3N6dG5xY2trREVkclBEelI5bmlncW9sc0lxcGdnK2IzazlkUm1kSlJXcHJu?=
 =?utf-8?B?cFhkWGhCZllVOXF1NUxMM0V4MVZITzBZOWJ5L2RSWTJESVFXNm9mWDdIQm1Q?=
 =?utf-8?B?K3NINGhURmQwaFVSWjRpdVdZQlpMS1hPUUFwc01yV2t1SzFvRjN0eDRaeFJq?=
 =?utf-8?B?MTVFcm9KMi9VYk80Y2c5SzRPdEdCNHhmcWh3ZGNLNGhGODNaM0tWTjFXQk1B?=
 =?utf-8?B?VUIrUkhqSmVMdEhUdzJGSGduWmwyU0htVG5WcEdidCsrdkg3bUF5aEZoVlpU?=
 =?utf-8?B?eHFNMWxqUDhrNVFaTEJ5eUNRYlViVGNNcllRKzJMaFh0alQvdExJOTV3RHky?=
 =?utf-8?B?OGVhcENlS3lFbFkrMG5DLytEbytqaUZ5bjFVRG9oak4xSGtlalRKTkxzM1ZV?=
 =?utf-8?B?ZTcxWk82TXNRVFZGR0thMFhvRkpDNWFkQXZ4UWE4eGpWd3FwUGI2NGdrNHNQ?=
 =?utf-8?B?T1lWM2xKY3dHTEhwUzR0bmZjbUJnRG1sNnlVVU1rKzVWalNudm4rbG5VWCtB?=
 =?utf-8?Q?WOYX+0E8KmgTn/tWTAJDMoOqz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5830974e-6029-4928-7929-08dbb9196a28
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 14:05:01.1090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtysie7KsX5CH8XAlRLLg2ne3agG7be+0E9ZlUlTy7XnvIVcKERhIVNX264Vp2Qmj2dM/1711eckQz+HSu6ugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4994
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2023-09-19 00:44, Bagas Sanjaya wrote:
> On Mon, Sep 18, 2023 at 04:26:44PM -0400, Michael Strawbridge wrote:
>> Hi,
>>
>> Author of a8022c5f7b67 (send-email: expose header information to
>> git-send-email's sendemail-validate hook, 2023-04-19) here.
>>
>> On 2023-09-18 08:56, Bagas Sanjaya wrote:
>>> I triggered this issue on patch series with cover letter. To reproduce:
>>>
>>> 1. Clone git.git repo, then branch off:
>>>
>>>    ```
>>>    $ git clone https://github.com/git/git.git && cd git
>>>    $ git checkout -b test
>>>    ```
>>>
>>> 2. Make two dummy signed-off commits:
>>>
>>>    ```
>>>    $ echo test > test && git add test && git commit -s -m "test"
>>>    $ echo "test test" >> test && git commit -a -s -m "test test"
>>>    ```
>>>
>>> 3. Generate patch series:
>>>
>>>    ```
>>>    $ mkdir /tmp/test
>>>    $ git format-patch -o /tmp/test --cover-letter main
>>>    ```
>>>
>>> 4. Send the series to dummy address:
>>>
>>>    ```
>>>    $ git send-email --to="pi <pi@pi>" /tmp/test/*.patch
>>>    ```
>> I tried to repro this today on my side.  I can repro the error when
>> using the address "pi <pi@pi>" but that's not a valid email address and
>> so one would expect it to fail in the extract_valid_address_or_die
>> function with the error that you mention.  As soon as I make the address
>> valid like "pi <pi@pi.com>", git send-email no longer complains.
>>
>> In your original case, are you trying to send email to an invalid email
>> address?  Is it an alias by chance?
> I triggered this regression when I passed multiple addresses separated by comma
> (like `--to="foo <foo@acme.com>,bar <bar@acme.com>"`, but somehow I managed to
> reduce the trigger to one address only (in this case, "pi <pi@pi.com>"). As for
> multiple addresses part, let me know if I should post another regression
> report.
>
Hm.  I'm not sure what to say.  I have used the below docker container
as a test environment and don't seem to find issues with 'git send-email
--to="pi <pi@pi.com>" /email/test/*.patch' nor with 'git send-email
--to="foo <foo@acme.com>,bar <bar@acme.com>" /email/test/*.patch'.

Maybe if you could try the following test environment too and see if you
can reproduce it inside the docker container:

NOTE: I assume you install docker on your system

Step 1) Create folder with the below files inside

Dockerfile:

...

FROM debian:trixie

RUN apt-get update && \
    apt-get install -y git git-email vim

WORKDIR /

RUN git clone https://github.com/git/git.git && \
    cd git && \
    git checkout -b test

#COPY git-send-email /usr/lib/git-core/git-send-email

RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Your Name"

#specific error case
RUN cd git && echo '#!/bin/sh \n\
patatt sign --hook "${1}"' > .git/hooks/sendemail-validate

RUN cd git && echo test > test && git add test && git commit -s -m "test"
RUN cd git && echo "test test" >> test && git commit -a -s -m "test test"
RUN mkdir -p /email/test
RUN cd git && git format-patch -o /email/test --cover-letter master
RUN sed -i 's/\*\*\* SUBJECT HERE \*\*\*/test/'
/email/test/0000-cover-letter.patch

...


run.sh:

...

#!/bin/sh

sudo docker stop git-send-email-debug
sudo docker rm git-send-email-debug

sudo docker build -t git-send-email-debug:latest .

sudo docker run -it --name git-send-email-debug git-send-email-debug:latest

...


Step 2) Make run.sh executable and start run.sh to create docker
container shell.  Inside the container's shell (will pop up
automatically) please try this:

git send-email --to="foo <foo@acme.com>,bar <bar@acme.com>"
/email/test/*.patch


Please let me know the results of the test case above and any other
things you try that have interesting results.


Thank you!

