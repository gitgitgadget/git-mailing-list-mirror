Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95499CE79CE
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 13:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjITNOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjITNOP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 09:14:15 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127949E
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoCx6ErIB6VOqVyGE87tntSxAiTbSRzYx+pJzQAKqY8/BI6RAP9SsFAjRMOybh7HycSe8nZNrdjZWP9tEoXUbOforYeIsp5iIuwOsKjgjhwO31i7nl4+FYOf9kWkGblnxDz5T2UJhGqNYdFgmzVxGR2nbXJah0e9hX4LWlSb7b2FR/My/V8npghQFpFGrjL3xfcMdq/JX0+oWvczWlIZnOHZJGf/Vmubrt2ocCgvfP1GiaPCRr49NWvB/x6nqcY6InJS6jWXhBtf7k6P/tX/Ly0O1wjIILngl8zjZPwZD4iWTgOvE2KBwacIf9K+GZ8uDcIiHAL1U/tvQQEBytyhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X2nvxyIZEuxt6Q2qy/oq3ur9tY88JkrGs81QmDrgvM=;
 b=VwfowAvhC1Cycm93Z8yQDPChVgxZvHG9CIE2RJpBRLA73h/y8wIWq+L+6yg5RoiRLkARDNvIU5jveGcxSNi4cRvoAGzolLFaAv1nDtX/wr/nDGEtQqqCmWT1EIwI8afshLTv6iIBUPZ9foTVxmO9hB6P4Rr9HH0DYRbc2g2PWOzkE2tM+s9O/Jt91d+owgyh6RvDt096rOB2FzmTv31LTOAUQs2WyNkEnWS6URcIvJQQG8Hgv8/Cwa02X3PuU0znLZ1UGW7maZru23GsXVQKOQxsNk7zEGKsN6xpOH2R9mD3st7smsFDoH6nJoMNNvJXsD4J1OuNkVr6lEzlIQqdEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X2nvxyIZEuxt6Q2qy/oq3ur9tY88JkrGs81QmDrgvM=;
 b=McazEo+dcY7EEBXJaPB1fUFr9BnlnqJGBtjDH/K7eFfdc0aQeVO/coFDCYKCZQADJ7EGbs0Pm/JaLvn+22uPFDNIyBdk6ueUx1U2hA1ma8xFfTswScgMAP9reIrmIOF3dulbJEPLAqCxzLagFtHmig12d4Vlj2U1CRJtRIx0JD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Wed, 20 Sep 2023 13:14:06 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097%7]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 13:14:05 +0000
Message-ID: <c15a6561-3105-df16-b74b-99e5dad63fa8@amd.com>
Date:   Wed, 20 Sep 2023 09:14:02 -0400
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
 <4eb0d21b-be43-529a-bfdd-3f1d2b4d3e84@amd.com>
 <118975ef-c07f-c397-5288-7698e60516a7@amd.com> <ZQrQsa5GJEVhBttT@debian.me>
From:   Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <ZQrQsa5GJEVhBttT@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::9) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b70bda4-4909-4080-a5a5-08dbb9db776f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBd/E5+WisjDVOPGeL9q57KRzN8YRuGYqMhT3i2pIe6xy1N0XqqQErupMXvYttC0nomoxsflqkcU4FokkjLUS86HTWEnzwQwq+mEInxXS4ruzuIr2GJ+VUvj+JhEgpnnjTFkTptuhj0XSkOCFVCIdTsFDt8ii/f9KbsOPtuCYbZAWulsOLVBXkClZylcqJOAfM03gCGSDjauoLwT6+3V7qktYRR8oxd54zSZTYI4LhE7CUcqcErP16CcHPxSmzAfArqPeDKs3hXL4zDnaxNWfgGmIJLnAJuA4IOEDPC/8It8OYizbbBD5eKRGzEive3ZvOR4hzGretm1CW5gAEni7GTjc6v/2oFOt799E5oOVVRSHA3yFI/JdMGd96jfy2JtlByEqjUrh1OimGB2RUKL94JA/tqprva2LMIfdzXSVcfiWB0kAs4MsSm2/wJg1zBLM61hEkWY3PrTfVHcecDrMOWPgmkHb6GDtx2Crej6FiWFJy8tYBqh+MiUoI/7KGCtNdl5rVsfbbRcRumtqrE1YfbcU1GplVl0obsWkDD/V3dGqdYrjGUt+UkH7EAjQwcdimRjLXgitbfKz2Xrg1jZKj8KItLpQ63FgcVaZ9YAjncc2DiG8lGnXi8DoJT2OZSa6i6gmElEd/kgRpRl2Y5aUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(1800799009)(451199024)(186009)(8676002)(4326008)(8936002)(6666004)(110136005)(66556008)(66476007)(66946007)(478600001)(5660300002)(316002)(86362001)(41300700001)(31696002)(36756003)(38100700002)(44832011)(6512007)(6506007)(6486002)(53546011)(31686004)(2616005)(26005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0NHS0twNXNKeWZFWlRINVU3eWZOK1I3WEhxUk1ySHRxbk8rRDRrK0dzaFFV?=
 =?utf-8?B?aUhOQ0NXQ3FHdUtxYUdZMmNyYzYweGg4dUFaVlNCbHdXQys2S0t2Mm9IK256?=
 =?utf-8?B?UUcrd21acitwLzBEeGNyRXZnSSs4c2VJcjhyYUNjYnlEQ3R6UitsR0xEK3FQ?=
 =?utf-8?B?ZUJLM1RSRVZMNzVoK0taVk5zelZpVHNMS1NtQ3ZYa3JFb1cxdjFFdktZRUZY?=
 =?utf-8?B?a2dnWU9tcGpOTE51RW5qM3FsdzZ2NXFKNW90amJUV1Z0R3dmdlVFZnRCSWxR?=
 =?utf-8?B?dXZNNllIemxKb1lQTFFMS2NiclFjbXNjSjNhamRGTUpTMytGa0VGVFFpazU3?=
 =?utf-8?B?dWhoK0V0ZWV5NC9ZY2theVdWTnI2Y3FVSFUvYlk5VjRQbnhYbGhSVDRqNXEy?=
 =?utf-8?B?aTFGVTNIZVFrUjFRRHh4ekc3Y2Y2bVQ2OHI0Nk5iTTZqT3F6UVk5TGlIK05N?=
 =?utf-8?B?cVg2cWpOenJYVldybFA4a0dLUUVNaytadzE4YTYvQWVBcUVoQ1VPU1hhWHM5?=
 =?utf-8?B?Y2NvaWJnTHJrNEhHcnB5MDRuSjUrMUhxT2xpVlNHYi9NdXBuSEFlV1VGRGtX?=
 =?utf-8?B?UXNKRXZIek8xeHo0bEE1bFhURk9LaVMrdnA5d09XS3hyM1J4Z3dlVWJvWkk1?=
 =?utf-8?B?TGZzQlE4Uyt0UjlqUEovTWxqYVk1Ui96RTZJV1grbllsWGlVQzY4WnRLTGRl?=
 =?utf-8?B?L2tEVVBqcE16NVRzbWFjSUpyd2p1OWU4OU5wem5sNkNhUzBQTjhSMFh2a0xS?=
 =?utf-8?B?c21zZ1p6N1F3SmZDRU50blM5bktrY2VFcHlIZmVRdEtoOGcrQ0cvU0J0dkpK?=
 =?utf-8?B?MDN1Y3JzWTFlSGhPYVZidHQ4LzlaVmcxQjRhMHhqV3lMaFBuL01uOGpOMGFT?=
 =?utf-8?B?bm9oRjV0dkRQamhmVDQ3OGtWYnpId3Ztb2NjTFVIa3NtQmkwK0xjdTMvbHY0?=
 =?utf-8?B?eGV1QkFXanp0SFJOazhweDIwQ3FqaVdnUEgwcE95TEQ5VkNON0tiZ25sbU5Z?=
 =?utf-8?B?NWhVV2pHcE1jZkMzMlhjOGYxNWhoOW84NFBYdlNXbE9JZnFoNnBKQ2E2eHFh?=
 =?utf-8?B?VklYMElKYmhYTFRIay9kbU81alltZnVzSDJLeEIrWCtRR082RjgydE5FbzZQ?=
 =?utf-8?B?c3pUQm16aHJlaUlFWEk2RXY3a25XV1ZDSjVWL3I5Q3JuazNZWDN0TkJmM1Zz?=
 =?utf-8?B?TXA4RE1VMm0zanFkTHRkMmJjeGJURWxJSlNmUlJjblZDVktINms4U2NFcDNp?=
 =?utf-8?B?R2JkWGQrN1h2YWh1ak1IdHNoVDBLQ1NXbDdCQ1gxbEIzd2xoM09XdHlyT1ZQ?=
 =?utf-8?B?dk5aSVdmam1IKzgyODYyRUtpcE5nUUdUN0FPdmdEa0ZZdVVwelYvQjl5QU9R?=
 =?utf-8?B?cjd3bERFdTZHb0FKTFV4bHVUMElvSzdibUR5SVBTYTdPOVpKWXpqMkRmbVFx?=
 =?utf-8?B?QzNLZkZ2V1VOaW1naVJCS2ErQ21lbGJwc25DWVhBa0JDdXdlejhqcXRWTG04?=
 =?utf-8?B?SUkzd2pFak1Va3Q4NW92WUFrYjREd2c0S3R2YmJOTUd3NWNFVlYyWFhObDlt?=
 =?utf-8?B?V2k1UTEwaDM3T2tZMHgza3VVY3VqRDlBc2NqWVMvZmRtMzBicVlQQW1GcUR4?=
 =?utf-8?B?enV0eW5wUjV1NzdyLzFaaVBjSDF2RmJ5S3l6OGt3ODN5LzNFRC9zcWs0L3Mr?=
 =?utf-8?B?cGcrVlZxb25oNGVxS0MvSWQxbG5RZStzWWJzLzcyb3crMzlBdUljVlplY2E0?=
 =?utf-8?B?Zmd5bG1nNHJlcTk2akVMcUI4N2RzL1F4UTVhSy9uWGJWcE9PWmgrc1dwNHJV?=
 =?utf-8?B?ZlJOY2RWNktLODZrSnF5OVlidndrc2M0V3laRTBEeXMwUWlFZnBtWU5lNm1x?=
 =?utf-8?B?VG9xM29RUnBGYU9HYVZNTmxXcC9ydlNYeDFNNE1XTTNOWGFjTy9OeXVvWGI4?=
 =?utf-8?B?bVI2QnZ0RlpVNVNIM3ZsS3JkNTZRTnNPSjl5K00wZTVHb09hME1iTnp3ZWsv?=
 =?utf-8?B?VDZpbWt5dmp3MEp4ZTV4eUp4QzFrVi8xeithZytBU09GSVBMdDQ5dmRkaDdi?=
 =?utf-8?B?S1BKbUoxUTZzNTJUcmgrVGVuWFJzNGJYZC9NbE1BVlEzSURjNU5taUdKT2o3?=
 =?utf-8?Q?f7QGDP2PS2Yjl3uegnhbqLxex?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b70bda4-4909-4080-a5a5-08dbb9db776f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 13:14:05.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BekZC6tnpJrPcqj+mmV9UUMazAAIc2Jk9H88WqHl2u85cxTRbksFyhWBipDjJD7u+tMnjL6yqiKb/w9DodJnWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2023-09-20 07:00, Bagas Sanjaya wrote:
> On Tue, Sep 19, 2023 at 10:37:36AM -0400, Michael Strawbridge wrote:
>> I suppose I may have mistook what issue was being reported.  I had
>> originally understood the problem to be that hook related logic was
>> failing with correct email addresses, but it seems rather that we are
>> trying to fix an error that occurs when an email address that fails
>> extract_valid_address_or_die() is given.  Feel free to ignore my last
>> email if that is all we are trying to solve.
>>
> Originally, I was intended to report regression on handling multiple
> addresses passed in a single --to/--cc/--bcc option. Previously on Git v2.40,
> git-send-email(1) accepts `--to="foo <foo@foo.com>,bar <bar@bar.com>"
> as two separate --to addresses (with comma as separator). However, on
> v2.41 and up, instead I got perl error as I reported in this thread.
> Interestingly, that perl error can be reduced into one invalid addresses.
> The same thing also happens to --cc and --bcc. I used aforementioned
> trick when I was sending patches to LKML to save frin typing the same
> option multiple times, each with different address.
>
> If I need to send separate regression report for above use case,
> please let me know.
>
I'm probably not the best person to answer whether you should file
another report.  Junio would know better the processes of this mailing list.

However, I believe that if you are just trying to have the
"uninitialized value $address" error disappear then the above patch by
Taylor Blau should work great.  Feel free to try it by editing your
local copy of git-send-email usually found here:
/usr/lib/git-core/git-send-email

