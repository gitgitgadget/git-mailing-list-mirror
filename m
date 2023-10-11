Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9665FCDB481
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 19:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346812AbjJKT2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 15:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjJKT2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 15:28:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4787E8F
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+R9kQMNn/D9eswH6CWI2WZ1NXsaFgFxIXwnyT3/+GOmQK0gEsVLYJRj/5f73U16czL8Bs5mh1Vxp2lgikMBfHD9WninXedYG1K71MCh/p4u7dG/QKCn78CQsAn6BV5ovvV92JVvHKtXaX/0HlRzBcXGSGau30j2UMrzpeqG06IRgiSPURkgV0fagVE6Ze6LsnxpyBLwD/oqIC6SZBIPYKnBo1oMeI+RzTzGhmnsQXbjhkZnninOd90OSB/3kP9WaF/6LuqbpdfXv/oF8ITLuMc2CVMZOgZ/I68qZbZ09Mw8eIKxREIn3YlHikhI6HY+riG9H+cBT1P31thz5I3ivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbTzUEejbPIRp2Wjl2l9AppWI4qctttNdDdldnami90=;
 b=KBAjePLqdld8YZP8kxQSyNxbYh2UTBZNz05bCmYOi8N+Ku9ODQMJuw/9T53FR7O3rfkwrFrHNR/PTsx5P+pcMy+BzHP9ttK6u08oXtLm21WcK2wgi8US8jQ9tKP2Ma3nC994/n/rZ3q/kVliHmRJiQdGai+B0wEcclYN29ln7H3Lvq4Jo6/dRwlTR7yiT1ehH8HpYPBTbS7O5BVHtEqkHWZemS2rtpty9Ek5GlV9C83tY26+PLiTKf68GDk8dbHyb7XsXFHl6ylHDn0gO3fCivEEjvx//LiW3RJnwyV3TYLvnsVAPzUvOwDPnckoXcd9usrkz8lI10LlJ7VCv15W4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbTzUEejbPIRp2Wjl2l9AppWI4qctttNdDdldnami90=;
 b=NGb9xHtadNoUywxxlaud8FPrFQA0/TOPDBfb6l83y1Mn/f64C13Q4jJo6e9TqvM2w8SZvFWey7/i+WHnU8AWsg98m1WC78UDQS5i2EjllFA/iKj8SSb2O9merQ8dkcCk2ucYCYISrxPZFPoamjQMw565XPq/fwpmPnqhu5akX3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.36; Wed, 11 Oct 2023 19:27:59 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097%7]) with mapi id 15.20.6863.040; Wed, 11 Oct 2023
 19:27:58 +0000
Message-ID: <95b9e5d5-ab07-48a6-b972-af5348f653be@amd.com>
Date:   Wed, 11 Oct 2023 15:27:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] uninitialized value $address in git send-email when
 given multiple recipients separated by commas
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
References: <ZQ1eGzqfyoeeTBUq@debian.me>
 <20230924033625.GA1492190@coredump.intra.peff.net>
 <ZRE6q8dHPFRIQezX@debian.me>
 <20230925080010.GA1534025@coredump.intra.peff.net>
 <ZRGdvRQuj4zllGnm@pobox.com>
 <20230925161748.GA2149383@coredump.intra.peff.net>
 <ZSal-mQIZAUBaq6g@debian.me>
From:   Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <ZSal-mQIZAUBaq6g@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:408:f5::6) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 3836d52b-0d72-44c4-5355-08dbca902d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4o6QLyLQAZHy1duxr+MPPfujnHmljpJsVT9mYVwNtoXLqIsXYy+208wc5ptv5cmd5kLAE9fiTVmXHB7p6y0X9UUKPslasH11Rxlw52HlShv7+FvOH+xJUjpa7sBTagf02dqcCkKIXnnATuF2BkGnySHOdrAfFlZ1Wyq/Z1H/pHVt/mgfCgWEoGuZ/VX6+MdONIbE1L635RJ5B/WN8qtO9+2AcauDSZQi9UX2NB+vkOEkxjr/HbaebmMxTQEK1E08YJChtkzmzYvHj5+MBuxg/hXoW79BfFqnAMRqvXKVzWC0XS4fGS8JzCLsnjGg1t88umouJczIef6VRihdNPbOrDTkpnXZUkx05maP0NP7NANOYPreMaPnmMqC9CUOB41QKOsjLbjn7/UnvUIK6npXM6xGW6YTnbwyp72lyZPcq6Dxo5svJW5z9Lf6NH+rQyKlyzlUSOxcjelcBwTnaLyotkr9J5V2jMV0q138+ofcGWXHZjl++ZV0xIVtxtRN/1e6G/eyQmv7gu0q7tFBCNW96uipUjFAQeeUVQPX6OcdXsL7fy30sKJu7kLwnjZqTdsRdWVC5dLwo9ZK48lLWFfituAUddAY7qiVHnBLb0bM1UhQdbYEYsUdFquWfCNi7UrxE+P47aZUN4SqJwAIHNL7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(83380400001)(6666004)(31686004)(53546011)(2616005)(26005)(5660300002)(31696002)(86362001)(36756003)(4326008)(478600001)(44832011)(2906002)(38100700002)(6512007)(8936002)(8676002)(6486002)(110136005)(41300700001)(66476007)(6506007)(316002)(66946007)(66556008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDRPMVVucnNqWEo3N0h1enlTczZTeGF0UzN6Z0VpVDNuNGFhTWMxVUxOUy94?=
 =?utf-8?B?bUo4dXFXUHVSZmttclFONEFSTmJqaTBPS1FFU3daSVRjVWp2NHNQNDN4SWZK?=
 =?utf-8?B?UGtaNm8wTEcvd1FxK1k1cS96VnVpRGRHUzgwQmRZWlEyYldEdUs2QVdTOTNl?=
 =?utf-8?B?Nlpjd3pxMEdVWFlWbVJMbUdSaW9MVUpjaFQ2VnB1Nkljbm1nQnFqbHpjKytF?=
 =?utf-8?B?cmloTVMrNVRsK2xIcnhWbTFsSTRCL3NqSHI1UEpEQTFnMTl3YXJrekFKNXln?=
 =?utf-8?B?b0xObkVUYjVWYXhCYVlXNXU0bTU2cHhoRGZxK2o0RUNtS1ZXdmU0cHV6VDdJ?=
 =?utf-8?B?b2x0TFdPOStzRlVKS256OXA2SlgzRExUWVVQR1dJb3pVRjE4TGdWaDdpRGMr?=
 =?utf-8?B?WlkvcVFsVzYycS8rMFRxL2R1eTRYa2VXQm96MFJzUFAvWUJlc2tzVWZJSm1G?=
 =?utf-8?B?NHhIR0dHeVdJSlhzcElQM3I2RzgrNks0bWFtSmZFUitTSkpNVWN4YmRoR1Yx?=
 =?utf-8?B?OEhYUURnTzVObEt5VkxUQS9MSDViNzc3Z0hWb2VsSW95THVYc0FMT0d2eWVT?=
 =?utf-8?B?d204bHFTRGFSRlhURE9FYmJjUlZBeThzYUdxMHhRandjNW5CKzQ1RDZPWVpU?=
 =?utf-8?B?ZGVnRjBYUWo4L1F0eHI5cEhFR2dEMVIzNFk5eUtHM25tMzdiODJ6TlBMUHBQ?=
 =?utf-8?B?RVVNM0xsbXdBVkVaRlhzamx1UWlMajNpdTdHamx6K0ZGcU10VlZUbzhPSm8z?=
 =?utf-8?B?YXZLL1JMVDNBTkg2c1RHeGNrU1JPU29ubmVKbGplRkc0OWhCVUtXR3BJcEJp?=
 =?utf-8?B?Vk56V1pSWlJrZjA1a25uMXNUMEt0ejZWbjlxV0JmK2FjdURwZTJGc3dBbHpO?=
 =?utf-8?B?OCtBK0FNMFJPUW4yZ1dFcnNLallVVGNwcE1hT2RIT2NyL3QrSlFwL3M2ZkNC?=
 =?utf-8?B?YUhvdGV5RW1rdjh5dG9nYk1HbVlUM2FwZUlzOEVtWEhGckJsWVpmZ3RobG9E?=
 =?utf-8?B?TklwTkxzaE1FZElYZnlNcmxJSGRjM1JQUFlQVy9CSHE2Z094SjNrbmw3R202?=
 =?utf-8?B?bi8zYUNscWl0Z2xGQXR6NXRzWkdVa0NJU2dOTzhtbDRMQWlkWXRYeWxvbW1a?=
 =?utf-8?B?Q2ROai9xbjJQT2pWVVVXajZNVGRBa1Vja2IyTElDVklkcE5ObjdDRm5LUjFv?=
 =?utf-8?B?NkhxOVNRTFpvMy9ENEI2RXI5T3ZHMkpYdjQ3WmZpRDRzTDFYbDQ0SWJwZmlp?=
 =?utf-8?B?TzRRb3RFRnU5VGJWWERESDlqVFh0eFNkdExLU1p4RHM1bit3d1cxRStXemU4?=
 =?utf-8?B?MXhpOVk1SXFqU3ltalVtd1ZQb0x3OVE4RFk3NDdGaWhmdEhhTUFLWlBBcThP?=
 =?utf-8?B?SHJKQkRiV0g4SWZlWmIrUXNOWHh4c0tMTys2V2VwTm9YZzlTU0drME1vbVB1?=
 =?utf-8?B?NnZ3bkpYWVg5b0YzRjlZWjZ1ckk0bnlsTmdWL0hBcDgvbUtZUkNiMzdMTDlH?=
 =?utf-8?B?VEN0bmYvOHdOZ2F4eTdpMFU5RTBwdHcxLzhlOHJmVnNoaVVpc1pNUjIwdGgz?=
 =?utf-8?B?c2xXK1BjRmI2VGZhOXRKc2ppMUhETjNjVzQvYXhLZytteE1uQ3AxUDN5R1lt?=
 =?utf-8?B?bUphak1UY28rLy9DaUltNW9NMlF3M3UvWGg1K2VPWkw1T2FVRGxxZGlZWGx2?=
 =?utf-8?B?MlJQN3NmQXRpRUpkMG9TNkI5T2hZV1pYOTZESVhIMHE4MHhnNXpsZmI4T0t6?=
 =?utf-8?B?NUZFa3RNZUJyVnRsT2tpMWs5WXkzejVLOEd6RzdrVXR0aXhnbEJjMmRHQVM3?=
 =?utf-8?B?VVZFQWNNaFZ2Q00vbVBpTEREbDlWdmdoOGx1OVVIZWMwa0xQVVE4d2Q3bEl6?=
 =?utf-8?B?S2h3MWJwcnlkU3lSRUxBT1RqakxWRGo2dXRyUEVpZDgxeXBsVEluNWM0U3Zs?=
 =?utf-8?B?MGl4ZFdnLzV4WDFGZldtNC8yVnp0UHdaeXpQSXpUVGsxQVhsY0FOM29ZRU9w?=
 =?utf-8?B?R3QzbExCK3d0L3FWVVRTcjNFT3RpdzRLa0dLQW5nRE1WeGdSUmJVRUlCcTRM?=
 =?utf-8?B?bUNuQnRDRHFMYU5rdm1VemtNMUYxQy9MSGxSeGlEWWJ6bis0SVhOSC9TM1lV?=
 =?utf-8?Q?Qq511OpNVWB2xj/qSkWBFW+tO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3836d52b-0d72-44c4-5355-08dbca902d4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 19:27:58.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KPwvG3F/b+JVWl5VSUBAoFxdYeLQfMb6XD/8yuNgWBGIVOtTmDYmLXKzS+SPIfkTKaj0yJwwYnU2nF0NucLyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10/11/23 09:41, Bagas Sanjaya wrote:
> On Mon, Sep 25, 2023 at 12:17:48PM -0400, Jeff King wrote:
>> On Mon, Sep 25, 2023 at 10:48:29AM -0400, Todd Zullinger wrote:
>>
>>> From the peanut gallery... could the presence or lack of the
>>> Email::Valid perl module be a factor?
>> Ah, thanks! The thought of differing modules even occurred to me, since
>> I know we have a few optimistic dependencies, but when I looked I didn't
>> manage to find that one (somehow I thought Mail::Address was the
>> interesting one here; I think I might be getting senile).
>>
>> With Email::Valid installed, I can reproduce with just (in git.git, but
>> I think it would work in any repo):
>>
>>   $ echo "exit 0" >.git/hooks/sendemail-validate
>>   $ chmod +x .git/hooks/sendemail-validate
>>   $ git send-email --dry-run -1 --to=foo@example.com,bar@example.com
>>   error: unable to extract a valid address from: foo@example.com,bar@example.com
>>
>> Disabling the hook with "chmod -x" makes the problem go away (and this
>> is with current "master", hence the more readable error message).
>>
>> I think the issue is that a8022c5f7b ends up in extract_valid_address()
>> via this call stack:
>>
>>   $ = main::extract_valid_address('foo@example.com,bar@example.com') called from file '/home/peff/compile/git/git-send-email' line 1161
>>   $ = main::extract_valid_address_or_die('foo@example.com,bar@example.com') called from file '/home/peff/compile/git/git-send-email' line 2087
>>   @ = main::unique_email_list('foo@example.com,bar@example.com') called from file '/home/peff/compile/git/git-send-email' line 1507
>>   @ = main::gen_header() called from file '/home/peff/compile/git/git-send-email' line 2113
>>   . = main::validate_patch('/tmp/WfoPQSKCUa/0001-The-twelfth-batch.patch', 'auto') called from file '/home/peff/compile/git/git-send-email' line 815
>>
>> whereas prior to that commit, we hit it later:
>>
>>   $ = main::extract_valid_address('foo@example.com') called from file '/home/peff/compile/git/git-send-email' line 1166
>>   @ = main::validate_address('foo@example.com') called from file '/home/peff/compile/git/git-send-email' line 1189
>>   @ = main::validate_address_list('foo@example.com', 'bar@example.com') called from file '/home/peff/compile/git/git-send-email' line 1348
>>   @ = main::process_address_list('foo@example.com,bar@example.com') called from file '/home/peff/compile/git/git-send-email' line 1091
>>
>> So the issue is the call to gen_header() added in validate_patch(). We
>> won't yet have processed the address lists by that point. We can move
>> those calls up, but it requires moving a bit of extra code, too (like
>> the parts prompting for the "to" list if it isn't filled in).
>>
>> Possibly the validation checks need to be moved down, if they want to
>> see a more complete view of the emails. But now we're doing more work
>> (like asking the user to write the cover letter!) before we do
>> validation, which is probably bad.
>>
>> So I dunno. Maybe gen_header() should be lazily doing this
>> process_address_list() stuff? I'm not very familiar with the send-email
>> code, so I'm not sure what secondary effects that could have.
>>
> Michael, did you look into this since you authored the culprit?
>
I tried to repro the issue previously but didn't have luck (even with Email::Valid installed). I decided to try again today and realised I forgot to make the test sendemail-validate hook executable before.  Now that I can repro it, I can look further.

The fix may not be easy for the reasons that Jeff King states.  There is a lot of implicit order in the code because there are several places where code exists outside of any function, which has function definitions scattered through it.  My change attempted to clean a portion of that up and encapsulated it into a reusable function for generating header information so that sendemail-validate could see it.  I'll keep digging into it.

