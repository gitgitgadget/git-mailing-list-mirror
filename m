Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3874C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 11:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2B460EC0
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 11:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhG2LB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 07:01:29 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:26180
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234000AbhG2LB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 07:01:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJWq9AUsdpx8d+OFajMrA0jic29oGfcC8lAaUuFjno+1EhhZgk+yDoz268suJ9sp5CtSBikmIrvUiF4BBgSHd4G4LK8ferIQ1hnm6zlhwAVeKXKUvWFnvLPo0jVKEk/rOD+8ZbbJNFMOdrFQY31GlL6kjCvSUD33buZvHNpObEcRKIOGl5K7G5J2AVaZo+GatoQXO2oTbuEQw3M6LOWzHSWeuQmrT/XvKudaUUNkkBh8OB3jTj8QWlljk2ReJEmJHOOi6e3s9Q5f8TtuM3kreEiL9EGJafrC3F5Ai90SpqrKzJ613JJwJ3jgEa3wU0B7b4zybc/TpLYdBNg2SQiiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+EDptq2+0yPb45qPWa/Jlc9BSzsi02e+j4NbI0C/Mg=;
 b=GdUx3Ii9g4YssXbxcO58DbRiq5AQOFVovr+VMBb9qqajM1lCSrRuuBrDDwZabiOzK5ZrbJkFi4gPeMc6EOhTEt3VLaeL4S6zv450QmbN5qBHcM6di8VLYKTXlOvsvE+oAbc0O+JpFce0ynWyXI2R5BjqDUk9Uo8C45xqzlyawWGQtfTy08Ql5vScL/1/MNJdcY8D1J7H6azCg4ikycoBOAZG6/Y8kFbDmB7nmFTm+aTPl91o+s3kkTHdVZlNPfy5c96J8goH8wOh9HrhqbqVNPzfNjd5AyyTZLHynnFergFX4gGvH/uChX6gdB5XXRicjfGf48js5gb1dhnyrdI0uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+EDptq2+0yPb45qPWa/Jlc9BSzsi02e+j4NbI0C/Mg=;
 b=obxBbZClCbBudGhXwJaJaZXAz+UiFV8F6n7autvJUo19wH9TIm1Fz/GYx200toXs1/WL+SrvD9OaA4K8LYjnYMiT/X+fYgHn2xA/1QJJubKa/hdmyyv9NnH0j52TrDUNZtn3+6D8cOsQmTaBCY9UnvvTs7mMbyNlrdGWzwoYPbU=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:259::19)
 by DB9PR10MB4396.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:22b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Thu, 29 Jul
 2021 11:01:22 +0000
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d980:59ba:f8fd:6178]) by DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d980:59ba:f8fd:6178%5]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 11:01:22 +0000
Subject: Re: [PATCH v6 2/9] ssh signing: add ssh signature format and signing
 using ssh keys
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club
References: <f05bab16096c080891ee8f7e179eecce7f32e839.1627501009.git.gitgitgadget@gmail.com>
 <20210728224523.2716969-1-jonathantanmy@google.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <ea422afa-50c0-4345-e7e6-935d02608c39@gigacodes.de>
Date:   Thu, 29 Jul 2021 13:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210728224523.2716969-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0056.eurprd03.prod.outlook.com (2603:10a6:208::33)
 To DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:259::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by AM0PR03CA0056.eurprd03.prod.outlook.com (2603:10a6:208::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Thu, 29 Jul 2021 11:01:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8ac7cea-7e56-447e-7e09-08d952803359
X-MS-TrafficTypeDiagnostic: DB9PR10MB4396:
X-Microsoft-Antispam-PRVS: <DB9PR10MB43969F7D12D2B194EA4F3AAEB6EB9@DB9PR10MB4396.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzCf99D1SWCGrfC26FVfao73vWgkO606mZ1IJlyS6SkhL2aKiO3hLbvtGmt2bOeAtQSb5NXJB2PHQ0b/tlEbN7me/FV45a1XMUc5dZB3t35AdTDMJNls9xrnoNGNRZkWVifoOC3B7wE4DeCFa4C5x+uArXZznDQCFo++uKCkqFprD+3J3NpS1HZVFSLrcmQ6UeAtrQDDVTzq1i7oZFvGUNFgi0dMW4RiEQvoy+EgBR2PVH/OcO69KhC5c3QkSzpSPuUFfcONvVrmo/974t688S9xI3ZPn+nG2cHMCoS9973MlmWbr6RYVn8gBILN669HseA0U5QWAeVfgNb/SLBLsLErCgwXwIzWOclW4rLmu1oFamn5eRqxxj5FjPRgkXdnJIkvV1LiGlwlzWCUOCOyP6HXO97m36VfHGGlXfVxAUY9A6+iEIcXi4hWDHxV6mrAMiFDLR9cUfi6a4CE8lLCoj2jsgriYzJ22tRNsNXjnypS0a5iO3d9GhJBlINr3W1IayMBvVu7pzBmvDhvx9d6H8/udmqBG2xOAHYf/bFhNY8ClLDFEEi3dEMcOHGg0bWMNYAgQ2qWxEan/54XFIPoPCAfKjxw0j/Q+5qXxmxEkpCuNFdpyVJcp2zxEcWD7+pkjI7xDiyi2U1PdZ6FSDY8rJioh9AU7vLj07feVVRXu8Q+reaFS63Ib5CtZvZvzzg9hqB6qlyJ9dPsflJSjB+K7yEzz1mdqK9IkXOyem0APe2lv6/uYYrQ8tDzpwUGuTJy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(376002)(366004)(136003)(346002)(5660300002)(66946007)(316002)(66476007)(66556008)(8936002)(6486002)(38100700002)(83380400001)(36756003)(7416002)(186003)(52116002)(4326008)(8676002)(53546011)(31696002)(2616005)(86362001)(478600001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SS9acm5mOWY1R0dnUVZhQzlSazNncjY4TURkNkkwdSs5aThvbUora2JzSXlk?=
 =?utf-8?B?WHF0TWJQUFlrdEs2MzJtQ2ZiYkliUURVdExQN2FpTmJUcjRCVlVZZ1ZUSnZJ?=
 =?utf-8?B?bWh1ekFDWndnUUVJZndLNytLaFBUVDhGb3dQb2tMdGdETTZOTlQ2bXhDZTFI?=
 =?utf-8?B?R2JacXF3WDR6NTVIWVZDRzdHNkF6T1RPOTBmM2pCbGVCRkRWMDlGWWR3U0Ur?=
 =?utf-8?B?QmtmNXZNQ01RaVFFK3J0VUswRHJKb3lpQWxLZHVVNFUyS24rRzFtNFo3OXJO?=
 =?utf-8?B?Vmgxc1RSUTdsL2dSV2pGM2ZTQ1ZHNDI1M1NEUytLZGF2QWpoNko1UXZ0RCty?=
 =?utf-8?B?aWRWeHZEWEllU0UzTS92VW52ZjlMNUxkK1NPN1JScjREWExNTEVjNzgyZTU3?=
 =?utf-8?B?STNnZnh6OUdjc0FYWlh6QWg5dFFNbFlxaUczQ3U5eWFwWUExZlNybllML2Vx?=
 =?utf-8?B?SEppb2hTeXA3aXJ6eTZaUXNvbG85akt3UUgxdlN1UzNtd0diVlFGS0lXcDY4?=
 =?utf-8?B?dXVyQmliWFN4WEJpalpOWnFjZnovaGNWaVl6Tm5yYmhVamI4ZEdjK1pYbzVp?=
 =?utf-8?B?eWNCTWpVUVpxRHh6ZENXcjVtdkJCb2ZEK1k2OE4vQzVFNjBpSk9pY1ZMVDM3?=
 =?utf-8?B?SE1uQkxUNzZTNE9SNWNVdnVDSkF0ZnRaRHhyYXFkUmpsUWZLRnJQaGNpRTZW?=
 =?utf-8?B?eldueG1uZDE3YWNUUlN0UDJlMTZ5bW8vWTVSWVVHZGNLd0ZVVUsxb1lCa2R3?=
 =?utf-8?B?aFhOeEJCU2t2NVNCRC9TdVAxR2hYNU9NQVZyeWc5T2U5eHliZlNMcGFhWXds?=
 =?utf-8?B?ZzVMRTRHTXNQMytLVlAvODE4SktCRjVWbk9yU00vMFJZb2xLSFJCb1pUR3JE?=
 =?utf-8?B?ZW5aNkRqM2RIM3BENDdPcnlrZEVTdC80TEJrWklYdk5OT0p6T2tpWjZQOWFX?=
 =?utf-8?B?WVA4amdIUjRLWmhiTUxEaExIUC8zWUs2NEhQZ3IzWVc4Slg4Qk5jQngyYThQ?=
 =?utf-8?B?QVNqVmZydzVtdUZ5Q0R6cW9nSXNwYng5Q2pZSyt0TVBTalBLQUtuZ1VJanlq?=
 =?utf-8?B?WjRTL29WS2RiUUdEejNJRENaRUdqN1Fyd05BV0MrSVZpbkFXbkwxTGFEMkl5?=
 =?utf-8?B?QnNVVXNOQWJ6RWJmc2MyaGE1SVZyMnFsbE1ReXFZYlYxRXQ4dHQvT2hwL25z?=
 =?utf-8?B?dEpTY3k4NDcxL1AwRjgrWkxBdTdHcStQVEZ2K2RQb0E4S3htV2FjTzFmWUVI?=
 =?utf-8?B?UkpNZ2FJa3hlVnY4bmlNUUpwOXNIREdsKzk3ME9OdUVQMFhhVWtvQ2laL2VD?=
 =?utf-8?B?R0diWWxjSVBVbTVFQTM0STVPbVFGR1RBbzdrSkJDd3NiTVhpTWZ0V2lDVThv?=
 =?utf-8?B?OTFLWUhlR1BMVmpDVFZheDRuckdwL2FzdEU1bFM4TTY3SlhZNDRvbDZLQUVa?=
 =?utf-8?B?R3dkR1FKSHdjT1ZBTzZpSXRJRm1UVzZGcjJ0QVFiY1ZLa2ExUlp3M1liY0NP?=
 =?utf-8?B?UXRsRVAwR3hqaUxQQ09sK3RuTXVtdDZGZHF2NjhIZjJnOWpneXVscEdKWmUw?=
 =?utf-8?B?QVFlVEdzVWpCMDJ0UEx5UnpxY096VWNFT0Y1ZkZkRDNzNmJHNnVYeG1zaSt1?=
 =?utf-8?B?QWViQndTcSswckhLSTNpeGdKRU9GVGh4US9lTldMQXdCcTZWM2F2MXVkVUFR?=
 =?utf-8?B?M2lWM2dDNURjYVVkQlpYV1JuckNPUDZLOTNnZU1rZHlqV1grRCsrbWVBYVBv?=
 =?utf-8?B?S1h0SmZXMDRIdWw5cVdUMUxBY09CZWZRcDhZb0JKUCsvWGFWOUR5eU8rV2ZR?=
 =?utf-8?B?b090RzlYYXprK1JZUE9RY2l0cmVmN0NkVmI5OFhZV0hsdVEvYnRiNm4wRFd6?=
 =?utf-8?Q?ywZDw/iVMN74t?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ac7cea-7e56-447e-7e09-08d952803359
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 11:01:22.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIFgW6OrnLcwabUzAAwXf5yYv1yiMEBM5tBRXPXDK84154m3lqH7cZoO/S6cpEAGIOxRl/zT4OsoDqwej0oWZ0g+0/I9MQzhEZjQflQ5UgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4396
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.07.21 00:45, Jonathan Tan wrote:
> Keep the commit titles to 50 characters or fewer. E.g.:
> 
>    gpg-interface: teach "ssh" gpg.format
> 

i will go over my commits and shorten them although I find your example 
very unclear. or did you mean: teach "ssh" to gpg.format ?

>> implements the actual sign_buffer_ssh operation and move some shared
>> cleanup code into a strbuf function
> 
> Capitalization and punctuation.
fixed

> 
>> Set gpg.format = ssh and user.signingkey to either a ssh public key
>> string (like from an authorized_keys file), or a ssh key file.
>> If the key file or the config value itself contains only a public key
>> then the private key needs to be available via ssh-agent.
>>
>> gpg.ssh.program can be set to an alternative location of ssh-keygen.
>> A somewhat recent openssh version (8.2p1+) of ssh-keygen is needed for
>> this feature. Since only ssh-keygen is needed it can this way be
>> installed seperately without upgrading your system openssh packages.
> 
> I notice that end-user documentation (e.g. about gpg.ssh.program) is in
> its own patch, but could that be added as functionality is being
> implemented? That makes it easier for reviewers to understand what's
> being implemented in each patch.
> 

I can move the user.signingkey & gpg.format part into the signing 
implementation commit and the rest into the verification. I don't see 
much benefit in splitting it up further. I don't want to split up parts 
of the same documentation block into separate commits.

>> +
>> +	if (starts_with(signing_key, "ssh-")) {
>> +		/* A literal ssh key */
>> +		key_file = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
>> +		if (!key_file)
>> +			return error_errno(
>> +				_("could not create temporary file"));
>> +		keylen = strlen(signing_key);
>> +		if (write_in_full(key_file->fd, signing_key, keylen) < 0 ||
>> +		    close_tempfile_gently(key_file) < 0) {
>> +			error_errno(_("failed writing ssh signing key to '%s'"),
>> +				    key_file->filename.buf);
>> +			goto out;
>> +		}
>> +		ssh_signing_key_file = key_file->filename.buf;
>> +	} else {
>> +		/* We assume a file */
>> +		ssh_signing_key_file = expand_user_path(signing_key, 1);
>> +	}
> 
> A config that has 2 modes of operation is quite error-prone, I think.
> For example, a user could put a path starting with "ssh-" (admittedly
> unlikely since it would usually be an absolute path, but not
> impossible). And also from an implementation point of view, here the
> "ssh-" is case-sensitive, but in a future patch, there is a "ssh-" that
> is case-insensitive.
> 
> Can this just always take a path?
> 

I found the ability to specify the key literally useful since i don't 
need an extra file for my public key. In my case all keys come from an 
ssh-agent anyway but I'd like to be able to select which one to use for 
signing. But i'm not hard pressed on this feature. If consenus is this 
complicates things then i can remove it.

>> +	if (ret) {
>> +		if (strstr(signer_stderr.buf, "usage:"))
>> +			error(_("ssh-keygen -Y sign is needed for ssh signing (available in openssh version 8.2p1+)"));
>> +
>> +		error("%s", signer_stderr.buf);
>> +		goto out;
>> +	}
> 
> Checking for "usage:" seems fragile -  a binary running in a different
> locale might emit a different string, and legitimate output may somehow
> contain the string "usage:". Is there a different way to detect a
> version mismatch?
> 

I agree. Unfortunately i did not find any better way. But i think the 
risk of doing something wrong here is quite low. We only check for 
"usage:" in case ssh-keygen fails. And all we do if we find it is give 
the user an extra hint on what the problem probably is.
In any case we print the full stderr output as well.
