Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F59FCD5BCC
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 14:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjISOhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 10:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjISOhw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 10:37:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB68EBC
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 07:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDHOxx7PB2z/kXhpz4vcNs+WuqTWVOZH4mCCzWnCCZ9wW91K8nCeCph6DRULqLZaUTr6IXqRmkCnJjEENWA6bKN1B2XAnllf0lJfBkyP3Xopso2xugnWFSfBCY2QRSsg2ft3kk/HBi6MQXvvHX7gOI9LY84ciX0n49aAqsCoF2WvwFQndiSJtE/uxgLl+68+WkYCgZS0/CphyEr5Q9hbyvUNOlbXKl7WFktQEFQdHLs2/zAPLnkDIWBx/bfpw0Px2TfNNd4dncpGvNoUDELK87AmohlX7wE3PTzlIYf4Y5XhsbP0zAuwmnJ6h0r3CJ7zwCfg9UZ7LMbpxZ5M7qlE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRKxJaaZpdTQAgvZtp7V7aos93umUEQx7N80WrcnX6k=;
 b=eVrB+bOcahLzKVfUORrpoGkPgka4yXk7nZFkzlvhtRcsC71bK4Un3aODoVNlb0ntvGkuUCrYSp850Ge1RDdZ3MWR2bPbMWQ7NkysoYcPPdG7Nec6f9LjBZT6W4L/NIBWfmtmWJWNYSgPY+vgE6ey0NaUzjYhz+G/Qdqp2ZsCgSX41zGF8/7F+jkicG0wjR2VYiMtWyH1YjtyQIEk+isD5fdBZSimqB1U9/64Z7dMzZKUq+oi4wlRTRQAx1BSorE7oMHDv72oLdSFrUt6seMCvTVGwDZxcGT5UCE7a6lGQIi9Ysd203DQRpoEKcWBuuBJQMOht58o6xcWIsqx0vUyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRKxJaaZpdTQAgvZtp7V7aos93umUEQx7N80WrcnX6k=;
 b=fJWRe7Yaa8ODoES53y/HwBtG34bNvF4bYjVd+iHK6XpuREltvuUjkzwBp6c6gcIvxyGHI3hVCJVdgHvHIJCBvl3FW16VuJrxyUZFd+2/oihEComoKYuOHRe4X1muwXrrW/xLTtJ+/W010QOhA04+1kTC5aDq3GvMRkjPI35TwZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Tue, 19 Sep 2023 14:37:40 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 14:37:40 +0000
Message-ID: <118975ef-c07f-c397-5288-7698e60516a7@amd.com>
Date:   Tue, 19 Sep 2023 10:37:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [REGRESSION] uninitialized value $address in git send-email
Content-Language: en-US
From:   Michael Strawbridge <michael.strawbridge@amd.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <ZQhI5fMhDE82awpE@debian.me>
 <8fcd6d2a-2c16-adf9-da1f-6b9d6fdcc87a@amd.com> <ZQknHjKdGZV3vJpV@debian.me>
 <4eb0d21b-be43-529a-bfdd-3f1d2b4d3e84@amd.com>
In-Reply-To: <4eb0d21b-be43-529a-bfdd-3f1d2b4d3e84@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:408:f7::10) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a888f4-6247-4c10-4fb7-08dbb91df9e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YR+0QY6SmhfD6ZN/qES+crydFnzU+eiXAef2RFokXbYf/n16lkby8zeEkAFJKimdmqB9MwcywVzdBM2ks8mGTgL4yfoAJ90uFQ7M7cXnccrHuvAXtTa/oCH0XPPBCkn420168kZJplX22c1kh1TiZwDhiC5dequ3hHfJ5e6LCGjvHp8lEbK1Mxn5R+oD0O0dKrfSDfQIGi9gAZWwD7IhkZJkzzhbVUQNTE+jsCWcXCSXMPx6PfHpzNFs/iXTv6s0Ch5elUwcPrZ/D4WY/Py6gcEige/lVW7HhqOKjp3BFktUi5KkEhLUkNvHAHenfn3dWXqrUMTCa4rLbw3cAyGTOFra6J/5yfRkZuO41H0nRMKL40muIV8UWJNq3G7P8nH3QWueFXeP8ydZJMAlKrttGdfyZmKiSKSaZc9tkqhJei3jk6td1SJt1BxHLpMbwB2kWzwanWbXBDPcdeJAXxtH+5pHXHO7yS/CyjjYCxSnsH+hBA2ItGhxsCXuR71nxxukig0ajtmcDLklfNvrhzE52YVDP9YXOXQWG1DSLIyFFqPaLFYcu0Gzp0PIrvz3SaqHnzJtJGahi0A7UM00c2bnHzzo0zidTrIe5NacK/ZK9uUKZgrWTu0cLUdMciE+tQXpFhNt9VS+MaXw3wHaAucL2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199024)(186009)(1800799009)(478600001)(966005)(110136005)(41300700001)(83380400001)(44832011)(5660300002)(6666004)(2906002)(316002)(66946007)(66556008)(66476007)(8676002)(4326008)(31686004)(8936002)(6506007)(53546011)(6486002)(6512007)(26005)(2616005)(36756003)(86362001)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVhwOVVVcGNmenlrcEdTT2I0Ky92d0l4V0h5emlWZkowSVF1RnlrNitnTXIw?=
 =?utf-8?B?czV4QXcwVjY3dENMUXMwUkZVOWFxRWUzSjg2NWo4bDJYZis5ai9NZ00yd24z?=
 =?utf-8?B?UDBtYm5IanZUbWQ5alg4dWZ2dEFXZGlGcE1CUVBxdHRtRHJOb2pMenpyU1NH?=
 =?utf-8?B?UG1KNm1Rdms5TnhSRnMrMlc3NDAwWndZNWwxRk9ESmdRT0xFTjJOcnBnODY3?=
 =?utf-8?B?VU1iRVBmMWpDeUFBUGE0N29PZHpuRCtqblVZRDFRUlY5cjN4VkJmMkp6RWN0?=
 =?utf-8?B?UTJaU1JPQitzZkNuc3BEODROSkZvZjZUZHdweGg0NkExSFUzYTdJNEFEejQ3?=
 =?utf-8?B?YXE3YWh5aFJ1RS9hK2tPS0Nvc3p3bk8yQUNnTDRVSVBEYm92aTk0OE1rVkdr?=
 =?utf-8?B?U3l6VWxGZGNrb2RVUWlyUWpMaFZaY2ExeUduRHZLK1crYzg2YTFEdWR4Q0Rj?=
 =?utf-8?B?SDZmUm9tbERXRDdLZk5LRW1kam5tR2pBZWlhWUpscTRzM0UvZ1F0RjgyLzZz?=
 =?utf-8?B?QkFMTUJGelRVVnFtNis5a0FNS3l1a2FGdW1icUVjTDNtZVJRbjlJdk5VaU1u?=
 =?utf-8?B?Nm5pWjF4T00rdmpTY0xVRTgzaUozWUloZGFNcVVpTmJIRGFCcjVPWHIzbHFm?=
 =?utf-8?B?VXdmUGo1bjF3UmFERjNHZjI2Q3hwMDd1VVUvUklDNmQycWdUazJmaTR4aGNB?=
 =?utf-8?B?YlF3ODhnMHdzWVNhcVRkZ2VCVm1LNEZlWGc5YnBFTGpuNkhWY0RjWVFZQkZh?=
 =?utf-8?B?YzhEZVdtK0pOTExJVE5sdm9LckRGQVlVcitzYlBqMGo5STlHcmRGYjh2TzFL?=
 =?utf-8?B?R2tKS2k0b3ljTnVKdjhVYkNhY1dLSHNyN0JXZ1hXQXBZZ3E3WUNaNTcxQnox?=
 =?utf-8?B?bFRSRDRRcmFrcGFxNWxnTjZHcWVlWWRXVkFoQkJIZ0JQNVdTWlRrT2RoUW5L?=
 =?utf-8?B?eGJOYmV2OGxWbUZja0d2U3IvODJTRm9uQzNVQWQ2OUhxMk56TXdkd3VOTGRx?=
 =?utf-8?B?eEUzQk4rZjByVFZVc1dCdmNORnpoNW4wcmk2SkNhcmFVeVYyWTBOUTdYbU8v?=
 =?utf-8?B?bzBWcXRIREIwdUN5WGJvVVhKMXZ4SFZJdDZab1I4MldGekJOdVQrcWhNQ0Jo?=
 =?utf-8?B?MXAwZkdZNXEveVhTQnMzZS9YbXJxbm1ZV3JLdGpucjQ1Q2YvR0phMXJpajUw?=
 =?utf-8?B?cFpjMThnZ1RPM2Q4UUNWNFRtRnBlcGJSaENBZmh3SzVsdkloYzR3VnVNd0pK?=
 =?utf-8?B?OEI3WXF6UGVrTlNTRFhJaGd1UFZjNDlNSjZURzk1UVZkeW5SekJ2d256SFhX?=
 =?utf-8?B?MWZTNzZZRUUrV2ZNODhtQjdPS3p6Vmw5NXVJV0Y4QURJZ1l3ZEkrNUxDL0Ir?=
 =?utf-8?B?LzBpczNqU1lYdDV3c01EUzFKOS8xNjI2SnY0M2tKTVhHKzFwN3RiVUdHTkZt?=
 =?utf-8?B?UFJ5Vk95L0xmUjB4ZmZuRUJGY01ldDNRQ2JnczAzWVV2S2p4TmZsR2RQNUNa?=
 =?utf-8?B?c2dXZ3owQzNYWktFQ3p2REt6emtaaUxlQjdvbnh6S252NXMyUG9tM203eGhY?=
 =?utf-8?B?T2ZSWmh1QXkwR01pSkplUlkxY0xJN1RuOXdjTmk1NG1JL0laTUNQUWpqVHgx?=
 =?utf-8?B?M3ZCbUFnSGo3WTB6ejR3c2VOZTNWMVZZV3NtYmRvTzlZUFR5WklZOTZKd24r?=
 =?utf-8?B?VGxTS055ck14YWZGeXZrSDRWcWxUL1FhNUgwV2swa3p4MzFkVjdqdUlrSjNL?=
 =?utf-8?B?RjZpR1VqYjZiWVlLZk1LWXZNbGRzWitMWnROVjh1ajlLOTlDZWt2SDFWWTlr?=
 =?utf-8?B?K3UzWVhvSFJxd0tTNGYvMWdkTzg1NFFBcUdVQTQreDdiZVlKblVDUnNxc29R?=
 =?utf-8?B?a2lJVFRZOWZkS3hNdjFxOHRQOVZKNHNGL0s1TUZLY2I5Q01ON2VLSHM4NEJR?=
 =?utf-8?B?Y0hpQ3J5ZVo3U21Kc09ESlVxelFXRnpkWU9JMXBYNjhXYUk3MGxjVzYwNW40?=
 =?utf-8?B?WHRWWTNhbWdhaDBZNzlkSmJjT0pRbzNRQWZwQVY1VzhCSnRVbUZpdXlYK0ht?=
 =?utf-8?B?SytHWlVlOVp6REc4M1NueEdVQ3pRcFowTDh0dFFkbUZrVzVxUDkwaWNKK0ZC?=
 =?utf-8?Q?2GiKoHUThdrTJ2a5TGf9AEZ4K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a888f4-6247-4c10-4fb7-08dbb91df9e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 14:37:40.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84K4ppGI+LbZgstt2+d8eibqj8RWfwOE6IAac9ywgHe55cDFpOyHf9V63TgaY0H7w8UrbJzvzgEvCIEnDF+FOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2023-09-19 10:04, Michael Strawbridge wrote:
> On 2023-09-19 00:44, Bagas Sanjaya wrote:
>> On Mon, Sep 18, 2023 at 04:26:44PM -0400, Michael Strawbridge wrote:
>>> Hi,
>>>
>>> Author of a8022c5f7b67 (send-email: expose header information to
>>> git-send-email's sendemail-validate hook, 2023-04-19) here.
>>>
>>> On 2023-09-18 08:56, Bagas Sanjaya wrote:
>>>> I triggered this issue on patch series with cover letter. To reproduce:
>>>>
>>>> 1. Clone git.git repo, then branch off:
>>>>
>>>>    ```
>>>>    $ git clone https://github.com/git/git.git && cd git
>>>>    $ git checkout -b test
>>>>    ```
>>>>
>>>> 2. Make two dummy signed-off commits:
>>>>
>>>>    ```
>>>>    $ echo test > test && git add test && git commit -s -m "test"
>>>>    $ echo "test test" >> test && git commit -a -s -m "test test"
>>>>    ```
>>>>
>>>> 3. Generate patch series:
>>>>
>>>>    ```
>>>>    $ mkdir /tmp/test
>>>>    $ git format-patch -o /tmp/test --cover-letter main
>>>>    ```
>>>>
>>>> 4. Send the series to dummy address:
>>>>
>>>>    ```
>>>>    $ git send-email --to="pi <pi@pi>" /tmp/test/*.patch
>>>>    ```
>>> I tried to repro this today on my side.  I can repro the error when
>>> using the address "pi <pi@pi>" but that's not a valid email address and
>>> so one would expect it to fail in the extract_valid_address_or_die
>>> function with the error that you mention.  As soon as I make the address
>>> valid like "pi <pi@pi.com>", git send-email no longer complains.
>>>
>>> In your original case, are you trying to send email to an invalid email
>>> address?  Is it an alias by chance?
>> I triggered this regression when I passed multiple addresses separated by comma
>> (like `--to="foo <foo@acme.com>,bar <bar@acme.com>"`, but somehow I managed to
>> reduce the trigger to one address only (in this case, "pi <pi@pi.com>"). As for
>> multiple addresses part, let me know if I should post another regression
>> report.
>>
> Hm.  I'm not sure what to say.  I have used the below docker container
> as a test environment and don't seem to find issues with 'git send-email
> --to="pi <pi@pi.com>" /email/test/*.patch' nor with 'git send-email
> --to="foo <foo@acme.com>,bar <bar@acme.com>" /email/test/*.patch'.
>
> Maybe if you could try the following test environment too and see if you
> can reproduce it inside the docker container:
>
> NOTE: I assume you install docker on your system
>
> Step 1) Create folder with the below files inside
>
> Dockerfile:
>
> ...
>
> FROM debian:trixie
>
> RUN apt-get update && \
>     apt-get install -y git git-email vim
>
> WORKDIR /
>
> RUN git clone https://github.com/git/git.git && \
>     cd git && \
>     git checkout -b test
>
> #COPY git-send-email /usr/lib/git-core/git-send-email
>
> RUN git config --global user.email "you@example.com"
> RUN git config --global user.name "Your Name"
>
> #specific error case
> RUN cd git && echo '#!/bin/sh \n\
> patatt sign --hook "${1}"' > .git/hooks/sendemail-validate
>
> RUN cd git && echo test > test && git add test && git commit -s -m "test"
> RUN cd git && echo "test test" >> test && git commit -a -s -m "test test"
> RUN mkdir -p /email/test
> RUN cd git && git format-patch -o /email/test --cover-letter master
> RUN sed -i 's/\*\*\* SUBJECT HERE \*\*\*/test/'
> /email/test/0000-cover-letter.patch
>
> ...
>
>
> run.sh:
>
> ...
>
> #!/bin/sh
>
> sudo docker stop git-send-email-debug
> sudo docker rm git-send-email-debug
>
> sudo docker build -t git-send-email-debug:latest .
>
> sudo docker run -it --name git-send-email-debug git-send-email-debug:latest
>
> ...
>
>
> Step 2) Make run.sh executable and start run.sh to create docker
> container shell.  Inside the container's shell (will pop up
> automatically) please try this:
>
> git send-email --to="foo <foo@acme.com>,bar <bar@acme.com>"
> /email/test/*.patch
>
>
> Please let me know the results of the test case above and any other
> things you try that have interesting results.
>
>
> Thank you!
>
Whoops, somehow I missed the other responses on this thread until I
looked on the web archive version of this mailing list.  I see that a
solution to "Use of uninitialized value $address" has already been proposed.

I suppose I may have mistook what issue was being reported.  I had
originally understood the problem to be that hook related logic was
failing with correct email addresses, but it seems rather that we are
trying to fix an error that occurs when an email address that fails
extract_valid_address_or_die() is given.  Feel free to ignore my last
email if that is all we are trying to solve.

