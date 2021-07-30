Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EF9C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 07:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088D460295
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 07:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbhG3HdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 03:33:11 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:44037
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230384AbhG3HdK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 03:33:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAiTfDkcb6IaqSsrzGB/UJtJPmQXt/nIkgWqxY5W+FRNWNQvlSO3N+/BfTUUVc5SwFFXW9VCCxpcmGUrZ0IrlPr4rft0I1O/m4iQWfimKF77QhyGYpc4PzPXl1iLRRTqFUH9N2j4utvhLWEwSoH/f5rx11tj+jw74dzXlCqt75vRIFZ4QOwLQBP1q7XqUB6H5kB6GKC2mAq3gP3PdpFp3UdfSYDjGsJRFvfQnnv5lhJrkeLBTVB9YBOJ4VoIhj2AporhfnRyO0wzs61/t82YZNRXtZmz5jVSXRhlUG3QdMWWuslmMD/gLY/FeU3/ekDtqgXQxEoY4NPpirdyydj0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqFgfZbBsri1c9xxNMPHkEqVA1dDK/Du0ClCvBmQYqc=;
 b=AMozWIxZRofrfIJlx8MN2tYCnIqDagDWWUctEhGdWl9s1pdHOcJ/z3vLTodSppaJK+ixYEY3ByASpuvFolBD/c2L6aV3j2JhxEvtU3mTQK8iTr1H8FM9v/w6rC+tnnEGOO3HCtZcgOzFwkIm2wN0mBfGZQ0G4L8oclei1n5chIsppka8Afk2pq5lx6fU9hjT3o9tnLfNcW5hMbJF2OYrw3zPle/ql/PF9VRbONeLnzKBw9DyV3BjZXMPLPykBQoHl4LSn0DUEGjzrWTXX7dtEAjlQzdqhXLZCY75msm2rv6BdkeYInVuunshVCWoFfaQ8x177FrxwzoGxSP0bTyHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqFgfZbBsri1c9xxNMPHkEqVA1dDK/Du0ClCvBmQYqc=;
 b=HuOHClYOQt8yBWAQJjuCxArxeb+XlusHta8ETnuOhcDq/Z2KqcXRHmwNSzoYtRelYev7dsiDfOOC/i1Qt8Ci0jP7crI9K5XGA0ql5Cq1uHs89cQ2UQbwuZL0dV/tlFK/PUEPlkoqso68uZeJcwC2Bz5hSzWOhj4bdlzm7MkiqOU=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:100::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 07:33:02 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 07:33:01 +0000
Subject: Re: [PATCH v6 6/9] ssh signing: add test prereqs
To:     Josh Steadmon <steadmon@google.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
 <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
 <18a26ca49e7a9b0046559ac8d5c62c99ea7262ae.1627501009.git.gitgitgadget@gmail.com>
 <YQL8+UFtVJPlJroe@google.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <63cc209f-1111-9d03-f6ff-24598d7c9918@gigacodes.de>
Date:   Fri, 30 Jul 2021 09:32:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YQL8+UFtVJPlJroe@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0036.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::11) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR3P193CA0036.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:51::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Fri, 30 Jul 2021 07:33:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 699f4dd3-458f-43dc-e7e4-08d9532c42e4
X-MS-TrafficTypeDiagnostic: PA4PR10MB4336:
X-Microsoft-Antispam-PRVS: <PA4PR10MB433667883309047E063AFD13B6EC9@PA4PR10MB4336.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhQ+wuIBM6vTpqS54YrfamyAE7DjCoIgNo48o8kea/TwvZExgzZnKfUw+nEK1Fj9tCqYUFzwhWPCo/g9pjAazajeKf0d2Y64HLjLZNZABQu4OdKvYaddzoDymPFR1dHgnI/iNa5Ug1WSa1Cvi/w6zp98VMyXHxGIFZ4+5pBgeg6Qf4Foj1UmOPrqXdGl8uWOQnLLVmRks2sv+sUmX2HYw1s2XVpfOXuDcv30r5REqQsnGj5S4gX9qX1YyFsvRsObklzLHGcTmN2Sr316rW5FmzQeqX81A29/WjU71ajRkW0/BSXvgrAVMyhqladr46RFDZEofdJ1quqiwoKfmUdlCEUOSKLagauwvONRQULivA09QKPgk5KDwmYducUmCEHD3hLx04jowm7jx1031Iu/U3HHSUMg+OjGE9tBb+yLlzw8YDG82Ep88SsJk0VLecvB8bN7dA72DrmuIxrf1IEZLKQguLL3hLfpSX926FTtEzSQlJDcS1p0pxJIlsqdlrMoxD9y9qMC19DXT3pmM6BC3mcUhxX+VAhwf1phjbAfMiXSNCuVbolA77gXXApKACzMSSCY/AK8hHqDz6Ams5QNM/di9zR/mFxmnO+lTjg1H3Ht64mgQwQ95kpuHDs/MYlnuZ4efeRkAljcWOgbqW0xl0KYo+3EU531rSVWEGLB5Km+xoy0F8v6tnDw1s1xaSR4xf/HiqkbH0o33CJxbOjZV+wnq7pyYkMYNqKRHZLhiFBaUS/R+kAwx0XO14M3jQHB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39840400004)(136003)(31696002)(6486002)(110136005)(2906002)(7416002)(316002)(53546011)(2616005)(8936002)(38100700002)(36756003)(186003)(5660300002)(83380400001)(921005)(52116002)(86362001)(31686004)(66946007)(66556008)(8676002)(478600001)(66476007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnRRTlVxVU83emxsQUtweE8yZXFjYnlSNENUL1J5OWlSenRHQy9qWko3VWY0?=
 =?utf-8?B?ZnNuaWtjcUcrc1ZKQUFrVDF2QXVmWEpMQ3NaOHdseDVBMDM1eURLeHNGaWV5?=
 =?utf-8?B?VXg1OHVFM1lXeTJXbzRzdlg4Nkw5emlsTjNlelR2d0hyUGVYK293b1Jvd1ZM?=
 =?utf-8?B?NGwzSXFVWjBieEpPNkQxbHZSM2Y5ek02UmRWa1cydUllcTUyTUJCN3RiY0do?=
 =?utf-8?B?c0lZT2JBWjVYVWJxNmQzQkM1TE5QWWprNEhORWhoNFZkc0F6M3NDa3FXNHVs?=
 =?utf-8?B?bzNlNTBadHROajhzQTFiVjNnYUM3MnJhV1pTRERiOThFUzdORDV6cUVBLy9v?=
 =?utf-8?B?UWNzRmdLcUVVcm8yaGwwdFV6UW55RXBOdzdpeWZETzA4TFhIMnhyWG9GMlRR?=
 =?utf-8?B?NmVsV2NObFBRczB2MGF5TitDNFloNldEbzE5SUcvVXhmYVpoSVJOZTArUWR3?=
 =?utf-8?B?UHpKQVdvVFpoUlc4dGtUUm1zVE9kYUUwZE90OGhaSkFJVlBhSys1ZzFhRGVY?=
 =?utf-8?B?ZTZGcWtqTEkxYjhST2xFbWhNZUNWWUpoVXV3NGZkTklsUzhiOStadGVJOHYx?=
 =?utf-8?B?ZkFRd1ZIZDRpcGwrb09TczNQcldHSis5bEpKT1ZTcmsvWTdzbTFaQlZBaStC?=
 =?utf-8?B?TVlDOHdTTmpTSzNhVEg1NWRKYmVMcVF2QnMvUXh1VFBhY1dXRHVpUys5azEw?=
 =?utf-8?B?dFBSM2JldDNDdUdsa1M5WDhrd2VOOTlrbW1mWjJrRDhDaUhQb3FkR2RNNUpP?=
 =?utf-8?B?U2VoMXdVWW5MaGVQbnd6K1RyWlFFYUxNcDRuTnArVkMxQ3Q0OStZVndIenhi?=
 =?utf-8?B?RThQaFFpcUhDY1FIUXIyOUF0WDdhWFVHQU5nYnFNNGUrTWZJbjZRb1pRZnhi?=
 =?utf-8?B?eEJJL2JRbEgySHlIK2tTRERFdmljQ0FYU2Zlb1Y5TFVJMkVodHQrdnVJdkdt?=
 =?utf-8?B?bWRmUGdKUUM1dzBwRktMVVJ6M3IyWDF2eTRDM3E4Wkw2TVQ0MnJsdW9OMXE1?=
 =?utf-8?B?V0dGWmxGbU5FYkRFN1FKVkRtTUFKcFdRL1RjaHVMYU1vdWh1WncvV0d2cWxt?=
 =?utf-8?B?YVZJNktyWkFNMEpJazVTc2lIMzlHakNENmZvRnBHMkxhaTlBSFlmN2NmaVFS?=
 =?utf-8?B?V1BObWZJLzE5YkNVUHMwK2R5ZUd5aXFSdC80UnY3aGdxUXhzTUVZcTZRcmNC?=
 =?utf-8?B?eGZteDNnYXg1Q0RsN3dFSXAydHRvK3VvY3VuS2NTUXZ0NlQ2L0VtK0JuYXBO?=
 =?utf-8?B?L1oyRnQ5TmxiU3V6ajJIZGxudGtqSW9hUUxlTWRrbG1TTERMR0EvTDFiVmVN?=
 =?utf-8?B?R2FsS0k4THpCM241MFY0TVpoK250N0MvNG95YTlPMG84MHRDYnVyU0NaZm5U?=
 =?utf-8?B?WEl6SHdlOXpXeFp0dDhZY0k5bUo5STNIdlVkVlQzK2xkdGdKekNRRnIraVds?=
 =?utf-8?B?UFZMT2VqM1B1a2NrcjYwRmdtOFNNQk5BOEprVHZaL0hSTVhEL0xLeERsUnd0?=
 =?utf-8?B?dFlLRnBpa3FvaUx5K2pidEVJS0EzWEI0MmdjN05jZERIZ1RtenFvZ2lZZFBK?=
 =?utf-8?B?bGYvVWZIbktxRWEvSzU0dnB2K0NnWW15ZHVEdEMzMkV2MDEydTlSbkFONklT?=
 =?utf-8?B?cHdJTkc5bDc2U2lmUDY3YjNkQ0xaVFhLblY4WVRPcXNSTnVrdXY5ZWlDWEIz?=
 =?utf-8?B?d0dpeFBiQzZ3bDNmN00weXFaNGh2bWF3OFNlVk9mT0JEeWoybEVEdmNQVTFU?=
 =?utf-8?B?dTZ0TG1waG43RlJRUWNZNmNqQ3ppWnVIampvdXRoUWwzQ08wTUl5SUhwYTlq?=
 =?utf-8?B?Q0pSZ3pabmY5cFIyTGtmMWZxNVp2WklEMDhaQzN5OVBnUGdSbVNjU0oxdGVy?=
 =?utf-8?Q?6tb2xCCUCzk3/?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 699f4dd3-458f-43dc-e7e4-08d9532c42e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 07:33:01.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAbUPtbj+9JsUgtMayJVRVGvN3k+g5e76f5YYx8EmAC6wDASNQWjRKWR0ObyzYjxgrtH+fYxrLLAo5oJqhcyR4aAq/snPPuSIt3NqBHvjtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4336
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.07.21 21:09, Josh Steadmon wrote:
> On 2021.07.28 19:36, Fabian Stelzer via GitGitGadget wrote:
>> From: Fabian Stelzer <fs@gigacodes.de>
>>   
>> +test_lazy_prereq GPGSSH '
>> +	ssh_version=$(ssh-keygen -Y find-principals -n "git" 2>&1)
>> +	test $? != 127 || exit 1
>> +	echo $ssh_version | grep -q "find-principals:missing signature file"
>> +	test $? = 0 || exit 1;
>> +	mkdir -p "${GNUPGHOME}" &&
>> +	chmod 0700 "${GNUPGHOME}" &&
>> +	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GNUPGHOME}/ed25519_ssh_signing_key" >/dev/null &&
>> +	echo "\"principal with number 1\" $(cat "${GNUPGHOME}/ed25519_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
>> +	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GNUPGHOME}/rsa_2048_ssh_signing_key" >/dev/null &&
>> +	echo "\"principal with number 2\" $(cat "${GNUPGHOME}/rsa_2048_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
>> +	ssh-keygen -t ed25519 -N "super_secret" -C "git ed25519 encrypted key" -f "${GNUPGHOME}/protected_ssh_signing_key" >/dev/null &&
>> +	echo "\"principal with number 3\" $(cat "${GNUPGHOME}/protected_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
>> +	cat "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
>> +	ssh-keygen -t ed25519 -N "" -f "${GNUPGHOME}/untrusted_ssh_signing_key" >/dev/null
>> +'
>> +
>> +SIGNING_KEY_PRIMARY="${GNUPGHOME}/ed25519_ssh_signing_key"
>> +SIGNING_KEY_SECONDARY="${GNUPGHOME}/rsa_2048_ssh_signing_key"
>> +SIGNING_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_ssh_signing_key"
>> +SIGNING_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
>> +SIGNING_KEY_PASSPHRASE="super_secret"
>> +SIGNING_ALLOWED_SIGNERS="${GNUPGHOME}/ssh.all_valid.allowedSignersFile"
>> +
>> +GOOD_SIGNATURE_TRUSTED='Good "git" signature for'
>> +GOOD_SIGNATURE_UNTRUSTED='Good "git" signature with'
>> +KEY_NOT_TRUSTED="No principal matched"
>> +BAD_SIGNATURE="Signature verification failed"
>> +
> 
> Is there a reason why we don't use these variables in the script above?
> 
> Also, in general I feel that it's better to add tests in the same commit
> where new features are added, rather than having standalone test
> commits.
> 

Intially i wanted to fill them in the prereq but couldn't acces them in 
the tests then.

Thanks, i have moved the variables above the prereq and used them there 
as well. makes sense.
Also i have prefixed them now with GPGSSH so we don't collide with any 
other tests accidentally.
