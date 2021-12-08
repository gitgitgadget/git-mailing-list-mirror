Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C80C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 16:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhLHQDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:03:31 -0500
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:44014
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236460AbhLHQDa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 11:03:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIA2Xl7nvtayruovVlgSXRY81+AG5c8aqteKRH8BU1Jt3PP6jDDLwBA8o4p9/jpz54MwtMDcbqcmq4PJ8RtyrNpswMFTBjpLJN5rgy+Iazn3Ltjz7YFnWVfwpoVT9uRYJCbXz56Ok+7bE4kv0fwhk+3U+gonvnJNk06Mwrh2kfKwqFGHaQHiy8Q5Be+xMCcF7gXMWE7/bt6o3/xtxIRDn4ZeW8CHk67A7oZ2GgD/Q6FR3tqmkDc0I4v6PHkFAYKEe1twjzjeGMNfre751uGssaesFViKhuA1Oag9HIRj6Juo+I1o5fZaBLIK4vB/Az0gdAAxxsABdMF4ZxWxAIJWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIaAj7photSS1cXChFnrFqvAKivw6HWB8+gtUvIpVEc=;
 b=RGBEmsX+a3C6gKmJmKZcYzPOy65ypvaP3deJYcWRmq523rZAvZuGlLD1O4JtKHBDhmZyoKH350luuMPQB4aGT4vwkBbYocBNFtG+GlJDdIe5tsqadiSa0eP7gLRDuX3LAWTwMooWHtl4NoT302/oOqId5XKQ3nb3mFdJ6QHnG8XOOyI356z4VAbw9Ul+zoyvcksu7IFI66jbtQJU1slm+jMQsZavfBcbS+tHraYmJWkSzmAbuOx/ImEtbyN/IJHYatks4jZ/VdQ+7nQTPPlAE9ouuj+kSqg/If8N2xT61FJH2IfDseblZpzbxGCMEZJGejt/Z2AWrtM0zzL2sQQ0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIaAj7photSS1cXChFnrFqvAKivw6HWB8+gtUvIpVEc=;
 b=JJFstdLqBg/26v6l0llSCQT8+fy6r/R28JZ6guAeb8I+0SaH/DXU1Y5tD/A0Ai0bJ6hqNoD+YVxVCmw024gpM/N8t8mqh9DBRK+jVbBdK9Fk+AJSCZmBEJfA2lZasY8r+8wZduUxCWIMLef2hvbg0v2l46RqrwwXVUq7wXWMk08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4398.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 15:59:55 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 8 Dec 2021
 15:59:55 +0000
Date:   Wed, 8 Dec 2021 16:59:54 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 6/7] ssh signing: make fmt-merge-msg consider key
 lifetime
Message-ID: <20211208155954.4ksd7cmowhhjeig5@fs>
References: <20211117093529.13953-1-fs@gigacodes.de>
 <20211130141112.78193-1-fs@gigacodes.de>
 <20211130141112.78193-7-fs@gigacodes.de>
 <20211205192344.GB624717@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211205192344.GB624717@szeder.dev>
X-ClientProxiedBy: AS9P194CA0019.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::23) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS9P194CA0019.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Wed, 8 Dec 2021 15:59:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36813be4-02eb-448a-d6cb-08d9ba63c727
X-MS-TrafficTypeDiagnostic: PA4PR10MB4398:EE_
X-Microsoft-Antispam-PRVS: <PA4PR10MB4398C0BFC4E8BFEFCE7B615BB66F9@PA4PR10MB4398.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGBwBt126XFZwQvUNhMQVUOTk6qc65f1FJ3pnF2YCoZoBncwFydJ5UriUimb/PvaRSMjhGBNaz/5tk5lS90aywFcSOdEJtFpJNEVD/2n7bGi1AS1ITZGR6KzlxmpH3Nbpnp3777JRwwK1CrSlH5XmrWjctpJceGuFquGPwmpwsHnd0YJCmeLfsIG4SnGzJHtA6CblWWFILMG80Jmv7ino22mthzuVOLX5MJIsb+ReX+FAL7qBRDkwhFjfZfMqmiVd1FwlVaJ7lm3x7L75C7RXty2EP2Y2lYg0hDhQsmDkqlqTMFo+NXtP2jZvHGt9eziw9RQT8mqAuwfddVQVRwFtSrSf5pu2/Zn3stsvGYIW/5wD+Jlw4dC3Khh+rzBRJots2VuwECvEWEbu4O0Va7tt5tSBUbHVIp5t2NbRL0ubprjry+55D8nXJGGTtiD5nu6UH9/56BXafa64/xCzebKpCcxuf7LsjCTCxKCNHdd8lNEqlGGMUmpi9SyaRbDfwv48AE0tLDSf0yD6mvK9hUOPe1M2G6E04l4kIAaDN153r/ReFP4GT3FRL1VCSipqUyX+7GPfVHO2jHyTwFptgyVnCSWyL1NdC2MsuOKi80dklLifKw5VeDlFYj4fXKHz+pyzYY4CUjQ++KN1WT9+ZcyDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(39840400004)(136003)(396003)(376002)(346002)(38100700002)(8676002)(5660300002)(2906002)(4744005)(508600001)(6916009)(54906003)(8936002)(4326008)(66556008)(6486002)(83380400001)(66476007)(66574015)(53546011)(1076003)(6496006)(9686003)(316002)(86362001)(186003)(33716001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nlp3RlFaQ0dVTmsyUGZSK3B6WTUxMnVXRU50VjIrb09ua0hGa09vaCsxTlNP?=
 =?utf-8?B?Sm9DTE9zK25zSFo0bUZSNUxRUlNKZzIxMnYxU0xPQiswQmtsZmFaVnVrVTVj?=
 =?utf-8?B?bHdtVm8vdEZIOUdBZHNTayszTFpxQlpSN2lRaUdQMnVicVJNdkNNUlN1ZzRX?=
 =?utf-8?B?b2VkNnVaUFRuMGFGdnhaaTJJRHFjd3JQMTQvU0g2SWo5RWR2elF6RW1OLy9a?=
 =?utf-8?B?cy9MQXErVW1nTTd0Q0RxUW1pVkYrNzhFU2tvNHl1bHZLc3drenlqNEtNVE42?=
 =?utf-8?B?dk1HUEh6U2o1TmtxZjVMSmJ0Rm43ckREK3dwTEFIcUU0Q05obFlSRkNXRmdw?=
 =?utf-8?B?VXpwUHRiS1pyVEJQcTI5bklxald5ZG9XVWUyUElMUkduUFhjMHlrNjAwczJQ?=
 =?utf-8?B?NGhYUS9SdEtyQlhmRm92YXlseWpxNGZENHJhMUNCTXpqZURKNXREOXFvaGEz?=
 =?utf-8?B?VEttT29KVmplWjhjWUd4dmRUcHBYRlIrYnYrV214R0dCNFFXaTZWbTdJdytk?=
 =?utf-8?B?UVJZSERXVjBGbkxqUFRVM0pBQ1JVSERWVlJKTk5PMU52NHJpdkFVbUsxaVdw?=
 =?utf-8?B?V0pFdWtjankzMXkrQm51dW9NZU1KbG95YmhXbmYvclZFcnh0UE9oZmdOUWxt?=
 =?utf-8?B?NkJrMWpkZ2dMWkFJV1JFV1ptanVEU2N6RTF0VjhWODZtVDRLVnNwVWdXc2l2?=
 =?utf-8?B?bDZWK20wL0hkbW5PdW1MNlpaaGNueHpyZCt6bkFiUlNES05rQjBLSlJ0TENt?=
 =?utf-8?B?RklMcXpKVG1iVC8zQmNHU0pBRzk5MHN2eEdiZTFrOHE1ajVYNEs0YkVpbGxL?=
 =?utf-8?B?MnVOd051SGQrb1NZdVdNOU9rUkhaWUg3UFFkKzZoZllzM2J6L0doTUJMQ05X?=
 =?utf-8?B?L3pIQnNUY0QwNWphUVB5NzRvV1VseTg5eFcrSnp2SFNEYzJ1YVYySkRRYXcz?=
 =?utf-8?B?S0dKZ1EraVBHd1drbkczR2M3aFErcWZGZnRvekN4R0lsaHM1YWprTnpLYitZ?=
 =?utf-8?B?RXRmQkNpbS9UWWZKKzlZSkdhMUlzcUJOakhyTi8vR3RsdnY4NlJoYXowbk9D?=
 =?utf-8?B?Y1pnWENRYitqTS9oZ2ZSdmlsTytDUTcxcFlPN0MycktJZG1zSDJEK25tQUZ2?=
 =?utf-8?B?VjR6RlBMd2pKaDl4V0o2OWVBUllmZ3JUVFRyNXVnQkpHTUtpWk9QaUNtRHo3?=
 =?utf-8?B?MUtJWUhrbkEzbm5WWHZjNnp0OW0wTHhjY3Q1WWY3Qy94a1krSjBYL3owQlZL?=
 =?utf-8?B?L1RrUTZVSFRtbytKM2tHY0hMOTMyTTYrOVVRbk1RcXQ2MFcyeUwyTklOTVZm?=
 =?utf-8?B?N3dzZmxTaVdHWmZmZHM4U3RCOE85WHRTZEZtQ2pzSzZJeHRpVTQ2Y1liRy9m?=
 =?utf-8?B?R24zTlZoYm1HYnRROEREenRYSFZKQ2lLSmE5b0FHVDNQL2ZPSGtGdE8vN0Iw?=
 =?utf-8?B?L1gyOUJDS3p6akcwY3VtSEF4ZjMrY3lJb1IrU0tNWU9lb1FqclFNYTVFbjNL?=
 =?utf-8?B?TjdjTDY0USsrcG45RnhjeWY1czlIZEsvSEo4U0lBKytsbHdOY3BZNDRQQ040?=
 =?utf-8?B?UTErNmpuN1FBNzM0UmphTmxjVWZqalZWS1pNT2k0cWRlMWN5R3RVbkZZUlBm?=
 =?utf-8?B?V3lYRnFWNzB5SGJpNFZGK1g1YThUdjJoakJqdk5lZnhuUjVIN1RBbGxKNkFl?=
 =?utf-8?B?TUlYby80bE51Q0phREJOcmdkUkhtc2Fmc3pWN2dhNDBJd1l1a1N1aDAyNEZO?=
 =?utf-8?B?dnYrUThRUnlHOFB6dzdBbEhTMjkrRzJiNUdlK3ZFTTZSNldkQTRzOVFnbFBm?=
 =?utf-8?B?OW81THV2RExCVEg4cHpMSndXVkxJNnZTMWQyZmNwUkdHdXZvQUxaZzRybGJi?=
 =?utf-8?B?NFhMQm50aTM4UjkwcE1Kc0RscVQ5MW1QSCtXSW1BQmdYSDhYNUNoQVUrY2NU?=
 =?utf-8?B?cUNhUkJkYUtuTGdWZWk3SlZHMXJZU2dUWklnb2phTFR2WWZJR05RTmRpWkhS?=
 =?utf-8?B?M25jSXpLaUJsRW5jakZHTWJuTWE3RWZDWU9aZnhIcks3aUNkdWN6dzdvck9Q?=
 =?utf-8?B?Zk5GdzNPYUNwV3R4M0hOQUZuLzZzYlZ6OFhtQjN1cS9EUnhyNE1GK2FZSlI3?=
 =?utf-8?B?MmpRbXFiK0kyWjcyeEFMTXRoM3FsOWhWYVhzbU0ybkRMTUhYRmVHcTFXd2dz?=
 =?utf-8?B?dXp0OHg1SU15bWI1V1ZPVW9sQ3R2TU9RMWt1d1piMXZGdFlzeWpXUDRyMEEr?=
 =?utf-8?B?TkZWeUpGOFVHOFJMZXRMTVVzQW51OC94NDJSV0FQRy9QTE1HTGw0TmE2NXda?=
 =?utf-8?B?Y3Z2Y21WNStlZWVmU2Y5am1malJBQUNVaHNVYzRkVHdRd0FncEFTdz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 36813be4-02eb-448a-d6cb-08d9ba63c727
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 15:59:55.7462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ses2lToUHQ0Vl1dTcK4UYM9nFxFks/mI+j69GCB1kefOJlroKjNwgxPah7SjIT6C61/6Wbkjexrj5gaDomZ6aAh9WyCCi5g1nYWAXtTt1/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4398
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.12.2021 20:23, SZEDER Gábor wrote:
>On Tue, Nov 30, 2021 at 03:11:11PM +0100, Fabian Stelzer wrote:
>> +
>> +test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by expired ssh key' '
>> +	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
>> +	git checkout main &&
>> +	git fetch . expired-signed &&
>> +	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
>> +	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
>
>Are these messages supposed to go to standard output or error?  If
>it's the former, then please drop the unnecessary (and confusing)
>'2>&1' redirection, but if it's the latter, then save and 'grep' only
>stderr.
>

You are right, these are not correct. I copied the fmt-merge-msg calls from 
the GPG tests a bit above which grep for the merged tag name and for gpg 
signature output (i assume those two things go to stdout/err respectively).  
I will check and create a new patch series for fixing up all of these.

Thanks
