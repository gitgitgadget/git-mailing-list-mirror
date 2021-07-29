Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E19EC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 08:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BFB60EBB
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 08:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhG2IVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:21:11 -0400
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:10054
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234256AbhG2IVK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 04:21:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3qT7Nih/vDX+OEQ7UwIlRyrj5CpNuJe2TDnphqp/S83GOIrbGb3ZqHVyofLwFBO8XLfp+H0NzBC33k1dk0uOmdW4ZizTSUlnNTcJNVBVuSiYPamOR0ZWxzGYpTV6Pu1mLgtTfXkDk43/bXMxi11+A/2RzQxllH2p4kztd6fqn1e6BfxMSNd/LRN+s2rWAS5K3E/y2tvYRvhU3T/w+DGXTKo9I+weuO/ZilcSoJDeMBBk951fSvlBGrG1CANygsWQQ8hXVVOXAE0CR+1BuNCV0pJ210s/Kl09QQSWZvhCMoj2CaSyiBOJovKR/A1YwiIYUFjcNBPXnrc8GMGbE+NbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY8xjgHXv2sz99y85vn6VaOMvWIGXQstuo3cyoBQ1xM=;
 b=Ypgc28cD1VhIk3HwBaO+lHEWreEXMEhv08HYaYmRh9bhLa1IGH6QWJjX+LO+PfmRvk+5FVhWshVpihnIlwQhV/CKghgKFi46YYtG4X8rT2eOISKyjl9mr0oSCh0f4dVKTZDeVTPHjMngDMJqPrtLl2PqsQScOoW+b31XACbu0cGiBZ8QNdN51iyxh8WLNHMy6IC77yxGaxPDJv77iUCpNazArB9vPB57xQ2Jk2wBS7mD/cgu8+veBabFc+1dJJhoQm6XWK19RHKmgGyvZmL/7v0alRzIF1SzCI13A+F+vJxAb0EHeTNMbntSsTHeYlUi50INjknjZtXQozi+qZ31Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY8xjgHXv2sz99y85vn6VaOMvWIGXQstuo3cyoBQ1xM=;
 b=ZiKMum4weq9SXVkOETIl0CyhXXz38IyjycBwjYKPvY77HmeEKig8mfgLbyVXDclnmeWgou9sM0h9rRFdAMSCeStcf3EC8SGpoF9nIAXyclQ4kFxQtMiNqUpELJaY6lv99ygqcqcF0VqrLEeJ7cNuoxR6r7nIKt+tsJcutuwNl+Q=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4875.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 08:21:05 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 08:21:05 +0000
Subject: Re: [PATCH v6 4/9] ssh signing: provide a textual representation of
 the signing key
To:     Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
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
 <7d1d131ff5b43559c8a750ebdfd6faaba93c1ad1.1627501009.git.gitgitgadget@gmail.com>
 <xmqqeebi86m7.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <e79a63f3-d86b-d4e7-2aa5-12aa1f2e6090@gigacodes.de>
Date:   Thu, 29 Jul 2021 10:21:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqqeebi86m7.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0058.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::38) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by AM0PR10CA0058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend Transport; Thu, 29 Jul 2021 08:21:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9978f14-9eac-4c22-4da6-08d95269cf39
X-MS-TrafficTypeDiagnostic: PAXPR10MB4875:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4875F852430F5F164F334725B6EB9@PAXPR10MB4875.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cOvx5BWu95cwTGmUgw5DaEKTLFoSdt64Tyqhle5berBm978JI1oSQeNkPtwFAgZh6Ur8VRz4OBmle5JGVAX0NwT3WLLJ7k1pjRsSAGlPtPOWUohfDSOlt7RJhpAU01FwOf16h4XuPWcgcuvQ+l7GxKTZ8GqCSIV3xEEiXdbn35rXIALHWHRCWGyHPv6OXnW/PinZB3Qr0DiYgwkegOnQkTebC7WJBTER3GH1hk8YwaRPmgfPtpP8Mc3LIO2lmBUXvyLwfKglgi5m8GcZhqGpThhnKVNB4ecm9LiLpnU4qCJBHSYOEUG1FslDyviaDuX8IAKCv425R3vDCmkjBo5QH+cGLaaJ40gIvbx8dPl+su5u+XThrjZ53UvKaFlMuueAZ7HYA+fr+4yPil/Ocwwwz/EnaL4PINlJzVmlZLYV8d2bs8USm6vWZf4RxvUFks3f2sff4OwTrVT6fZVmcPReYsQUDY0nGXlC3bSMCHcNeOR9+aFtyuRltVWmRPPP4m+p1rG5DJRsy67tQWzkxddOWK/7o3IyjhN4xw/Bo+ebrN+ZPphPbjjs9fq68xGjraqA3sqVoDLxPke3x1YZaTWBEa69+MJxLp7f70sMRfsn3uitBoEwNkj2Yj0OvXmcpXoJfmLHO0V0MD1TIpGBufWOyJZZt2QMo+sLM6kIdstbcJVnDlcnCCppWQUueoYCUO1bceWAaEsKS6UweTYTdhcjzIqsR5Rwk2jXNWXbgjjZfVIuSqadLNmMx2uhWe9aMyyR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(39830400003)(396003)(346002)(366004)(136003)(6486002)(66946007)(186003)(31696002)(8936002)(7416002)(8676002)(66476007)(66556008)(86362001)(54906003)(110136005)(316002)(4326008)(36756003)(478600001)(5660300002)(31686004)(53546011)(52116002)(2616005)(38100700002)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzBoalhoZk16WWczdms2bFJ5OWZkcEVvWDYyOWZ0dllWQzdyT3QvVmo4WDhQ?=
 =?utf-8?B?Ty9ZSENvN0NPQ1dBTTBEc1ljQmwxSU5wU2x3aXRsVnRGd0JTTk4yQmErVWVp?=
 =?utf-8?B?NXAzTk1TblU5UmhDVG5QQzFwK2ljVm50NHBMeHBuVzhOckUyR0NZc0RBYUxG?=
 =?utf-8?B?Mnk1OFpybTdZd05CTDNyalVoZjhrZDZpenU2SG5YQmttcDhmN2tMQ2I2bGJs?=
 =?utf-8?B?dUJWMlNmTVRpUXEvZ0tQTURGazFUZlNQV0Q5M29vaVpiOUVlZzJMQ3VRQ0VC?=
 =?utf-8?B?K2lJdUF6M0cvb1B5VGMrMG52SzB2VXpkbkNiOUtIeUprYWRQcWp3d0NjNzNx?=
 =?utf-8?B?L2Z4ZllKVVlBL1h2cUtwWnMzb1hHWkJyVnpQanFNN3hjMWFlbEtDR2JJazBh?=
 =?utf-8?B?eHlVa2orZ29ONVdoUURqMHNsaXVjM1BvL3NCQ1FhU3lKWEs2d0Q1VStIOVJT?=
 =?utf-8?B?UmdMZ25QWFNhbmhPVWYwckVYMm1MMUVWZnc1YmZ6QzVCNWwwK0ZGVjR3QjhE?=
 =?utf-8?B?bi90UzZMSWNhM0tGTU9qUlRURkpIRHBWN2t5Z0JCUXJtSkQ0WG1QMEEwQXAw?=
 =?utf-8?B?TGxtOFl0OTVBbUxWQ2VvRlk1NG5ja3FKQXcrZHRaT1kvUzlhUUVjVDJCRWZI?=
 =?utf-8?B?c0x3WXNkSlBWVkc0Vk5hT0ZYaExQR3ljRHBreS9KVThYdGYzY3M3Q1hUcmIy?=
 =?utf-8?B?NkZrVEJLUWthTVhFdStUL09OSjlLSktydExmTXBWTXVSOHJSdnBhbTVQVXJl?=
 =?utf-8?B?NjFlbVYyUUhkZlQrMnBLVGF2Y2gyS1JQVVZPOFpMM3dZQkxUSDcrcTdOc2wz?=
 =?utf-8?B?N3pKOERITDRFNVBBZ2FMOHU2dmlSNWZPSS9yczFLOUt6NkdhOVlDeVA2cnNk?=
 =?utf-8?B?Wm9nV0RYYmpSSHhtcFVuMlNVaUNlL3J1eXhFZURrM2N6Tk9EVFYyWm5wQkto?=
 =?utf-8?B?eFFvdEV1ZnA2c25aN3NIalY1TjhnQWFOV2tnc010STFPZDBIaytXTlFNWVdi?=
 =?utf-8?B?ZTU1T1hncVBGQkxwU0QzS29jWldNM2krVlE3TlhnOFUwL0NDaU8yMUpZbnNk?=
 =?utf-8?B?MGQ4eXo5TUNiV1dOZFFUYkN6RzdwbzJwejZZSXdVcEFwVWg0Z0VDOFllVVFX?=
 =?utf-8?B?STZxUTlTcDArM3VCZGpmbGp5RzI5R0hmbFRvMXpEek1nKzZLY3B3SlUwcVN1?=
 =?utf-8?B?NHh6OE1pbWllNGNPWGRCNk4yTGpoazN0TEJNSE5wcGZJLyt5WDJrUFJpaTA5?=
 =?utf-8?B?OGlpY2N0ZmNzNXVPVEFVMjdOVm0ycEg5TzJ1WE44M08zeWpiQjBqdDNWT3k2?=
 =?utf-8?B?eE1VMEpqWWNCTXRQYW42RmcwQzM4TDNNWlN6LzE4M0xoS2hZenNFcHVRRWpl?=
 =?utf-8?B?ekR6amgzOXhCbnkzWmpqNjlpd2xJaGdTNTllcHRNYTY5amdRVnZXZFhKbTJR?=
 =?utf-8?B?YWhQd2dnbnV5QUtqTWY1dE5tc2dhQlpaVVhrRDZaUjRBZXExVS95Z3B6L3NG?=
 =?utf-8?B?N0EvRThmdzlhTkU3alB0ei9ERU1WdldVdjZ0UHdMUm5lWFJWVHYxVE1UWVMr?=
 =?utf-8?B?MDZDbHpneFFPR2szSEN1aTZiTDA5bXFOMEhGMTMvUUY4Rkt3VGtJQkFqZEhJ?=
 =?utf-8?B?OUcrOEN3bU52Mk1hUXp3WkwzUUc3bjFSWEZpTHFHc3NYQm9tbXhzYXJ5WTJN?=
 =?utf-8?B?ckpwbzlrTU40d1JVVXE2SWxkQU1vY3NkQzBTRnN4RVVyTGdTdkdGbDN4R2t0?=
 =?utf-8?B?Smp2eHdEODRPd1BrNVhuQW9oUHRXUDVBcXN4MEFvWkVTNjJWWWJBekxHSWwx?=
 =?utf-8?B?V1UwWWgwaUI2R3lwdWpnanlQdmdNMFU5Z2hxaWFnNEZFZk1XQ1VSbDRmck5L?=
 =?utf-8?Q?NKEu1UKLfjKII?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a9978f14-9eac-4c22-4da6-08d95269cf39
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 08:21:05.2423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5yqY3OpA+wtd0SqnbydkyhV9+FGw9wRXWDDcVljYq6PTw7zVSA0dC0PKrytU1QWK5tYSXoX5hK5Gpp9sbPwltCLQWIet2pkKeWOlSdT7fQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4875
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28.07.21 23:34, Junio C Hamano wrote:
> "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Fabian Stelzer <fs@gigacodes.de>
>>
>> for ssh the user.signingkey can be a filename/path or even a literal ssh pubkey.
>> in push certs and textual output we prefer the ssh fingerprint instead.
> 
> These sentences that lack the initial capital letters would look
> unusual and distracting in our "git log --no-merges" stream.
> 

Fixed

>>   
>> +/* Returns a textual but unique representation ot the signing key */
> 
> "ot" -> "of".
> 

Fixed

>> +const char *get_signing_key_id(void)
>> +{
>> +	if (!strcmp(use_format->name, "ssh")) {
>> +		return get_ssh_key_fingerprint(get_signing_key());
>> +	} else {
>> +		/* GPG/GPGSM only store a key id on this variable */
>> +		return get_signing_key();
> 
> Hmph, we could ask gpg key fingerprint if we wanted to, and we
> cannot tell why "ssh" side needs a separate "key" and "key_id"
> while "gpg" side does not.  Hopefully it will become clear as we
> read on?
> 
> Again, dispatching on use_format->name looked rather unexpected.
> 

i will put the two strcmp(ssh) ifs on my todo list to also replace with 
a callback function.

>> -	char *signing_key = xstrdup(get_signing_key());
>> +	char *signing_key_id = xstrdup(get_signing_key_id());
>>   	const char *cp, *np;
>>   	struct strbuf cert = STRBUF_INIT;
>>   	int update_seen = 0;
>>   
>>   	strbuf_addstr(&cert, "certificate version 0.1\n");
>> -	strbuf_addf(&cert, "pusher %s ", signing_key);
>> +	strbuf_addf(&cert, "pusher %s ", signing_key_id);
> 
> Ahh...  We do not send GPG fingerprint in push certificate but you
> want to use the fingerprint when signing with SSH keys, and that is
> where the need for signing_key_id comes from?
> 
> OK.
> 

Previously the push certs contained the configured user.signingkey as 
"pusher". For gpg this is usually the key id. (e.g.: ABCDEF01)
For ssh signing this can now be a file path which would not make much 
sense to put into the push cert. I did not use the public ssh key since 
the file can also contain an encrypted private key, so i would have to 
ask ssh-keygen for the public key anyway.
Since the ssh fingerprint more resembles the gpg key id i used it instead.

As far as i understand the actual contents of the "pusher" header is not 
really relevant for the push-cert. The unique nonce is important but 
besides that its just a signed text blob.
If we don't care about having a local users file path in this header we 
could drop this commit.
