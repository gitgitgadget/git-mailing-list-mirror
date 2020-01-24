Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65579C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 11:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBB8206D5
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 11:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="F12yqMlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbgAXLzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:55:32 -0500
Received: from mail-am6eur05on2109.outbound.protection.outlook.com ([40.107.22.109]:51536
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729567AbgAXLzb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 06:55:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvW9vELYy6FHpBtw0yTetzIS/EbSBxNKQbmI1v+pipPQJmfMj/AwQ3Wb8caDrcT4Uu+KNdVP694bDugHyx5Tt4zY0D37ocMl3pGD4/9w9fDeZvWQQaOOasUDJ9y/BSWOd6xEiLQBgHuj4yWy28DdspybXeFZ01CeVkeNlWIwa/t5KtiwegFhNlLWJOZaUiOvwrXq/0tiqONMcU0RbDJf05mS6ykbfrcgdW84xDAiI1NCwkytlfCsv32aR+Z7ytt/cnnPeGhQy/dh5LRM1y93MzS7uciy5xMnWzoxZhGUqSW8j3H/AZ3z09AXV/fKxKNDUobMDzaTn9SZKSRdSmJkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvzxJ4H3T0UISWGjZ/7sdw35bcRYilIMoLCm57asj5M=;
 b=NSncurTDbObfFghjhQG90XhPHueInpXnr1P5xuP8PynFjzM5TTqvIGXV23u2ERdRAeOPnn/ZEjp9PF08MaeNgByhVQhkrFioCHfdWAff4rSGavKeX2VaLbDyldUHsdZyKvLt3oijSdnvh+T6XpNfgdY9YPEWiCNUPSWpQXGqBSVw6tz0AfY/vJD1AzBx/6okUTzQiAXy+lfXO9cj9I77E8loRkd/z3/JQzX3McGHx1LPApcrJ282BjzTgGxWO7HBg0V13W0mpLR1XONK/5YJOwJy8aRPZbLpaBYG/X0BxWPDJ3BUEVcKwCuGZqe0rVwHu9SVhiH4Ci2+5y16EA0U3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvzxJ4H3T0UISWGjZ/7sdw35bcRYilIMoLCm57asj5M=;
 b=F12yqMlPExo2cXvwOqP8oo/vf93iJ2xCowguQvu/7uxyVn39K5r2Na9ycwZQPD8YRI2D+OFuka3lW6xUE0WchQHIRMFWBcjSnM/J6YOUOCTgTQAPSxW+y/bmkdsCMRaqhNgjmdXHwdnKEm+ygC0IUCcWKxrTQUJnAhDArZ6n2rA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peter.kaestle@nokia.com; 
Received: from AM0PR07MB6179.eurprd07.prod.outlook.com (20.178.20.93) by
 AM0PR07MB4481.eurprd07.prod.outlook.com (52.135.151.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.14; Fri, 24 Jan 2020 11:55:28 +0000
Received: from AM0PR07MB6179.eurprd07.prod.outlook.com
 ([fe80::68d2:a509:8a23:8d98]) by AM0PR07MB6179.eurprd07.prod.outlook.com
 ([fe80::68d2:a509:8a23:8d98%4]) with mapi id 15.20.2665.017; Fri, 24 Jan 2020
 11:55:28 +0000
Subject: Re: [PATCH v2] Fix status of initialized but not cloned submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, pc44800@gmail.com
References: <23e3d410-5271-a919-aa03-9e776cf72f7c@nokia.com>
 <1579601532-10694-1-git-send-email-peter.kaestle@nokia.com>
 <xmqq4kwl512y.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <9192695a-0b3f-d166-7efa-84f57e091c2c@nokia.com>
Date:   Fri, 24 Jan 2020 12:55:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <xmqq4kwl512y.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR07CA0002.eurprd07.prod.outlook.com
 (2603:10a6:7:67::12) To AM0PR07MB6179.eurprd07.prod.outlook.com
 (2603:10a6:208:f8::29)
MIME-Version: 1.0
Received: from [10.144.209.29] (131.228.2.10) by HE1PR07CA0002.eurprd07.prod.outlook.com (2603:10a6:7:67::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.15 via Frontend Transport; Fri, 24 Jan 2020 11:55:27 +0000
X-Originating-IP: [131.228.2.10]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e09e980e-c945-4e5b-3ea8-08d7a0c44e51
X-MS-TrafficTypeDiagnostic: AM0PR07MB4481:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR07MB448159EB2DFB39F435539ADFEE0E0@AM0PR07MB4481.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(199004)(189003)(26005)(6916009)(66946007)(8676002)(4326008)(66476007)(66556008)(53546011)(8936002)(5660300002)(16576012)(478600001)(52116002)(81156014)(81166006)(316002)(186003)(6486002)(956004)(2616005)(31696002)(2906002)(16526019)(31686004)(86362001)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR07MB4481;H:AM0PR07MB6179.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NN9CkiiDnXFHOLkQAU3e47jMPgg2CbKtp6j2zEIh/pC2SlbEEkcb2oQKh92bvqM4H3IQlIcl7kunK4vpcuotZtlLN4o+gtvnVC6vJhR2FdRaWWLQ6Irk1Nt7bjRFPhUJ/G8wW235+mwC88DF3BGdFBIHFql6q7VGJZbNtBH+N7Usl4LiMgLn1YiFeLiexZBT2Sy1st77NQoIQ6ynp/OiN5jwFE8gOSufFjI0G2hebZfguXtUK/YDoXXdC4kKZ79QWakp1PyXAaPSdGlXPXWEWHU8CQ6iu2HChtVcO76yLe4K7sVSy8digMj2wTdXybrPxYz7RfrDiw7GZ5tFqbadv4j8EIh+2gw67eVBVbiXXx85fYKN4FUxy0wrAtflNiGEJC2b/sMw5diwOHEJH57v/5bpx6PaMLKD9cvkvUg/HOPwkJJnZpu3W9XUOiPMW2jI
X-MS-Exchange-AntiSpam-MessageData: dWSgFOiWhanhrlhRzXpyfZK5Y/8tNIGFR1+hu7qp3iHaqPbCFyPTD/Z+Jw7XMtBdpt494ZUP4Ec6wvezVpIIm9s9AZ9Fgm3i1UMY7CbwjBejvxO7I9cdTon7inR3Iq/QWQxIo/Cd9gSt98MPNbdRMg==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09e980e-c945-4e5b-3ea8-08d7a0c44e51
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 11:55:28.5715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/5jypz20bn5F+obZbK1aOBLifxx1Ej8JQ2TN8sFScGdW5fxAspCgmmcxFeouQKkthri/8eOdW5lk2ZnHDksjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4481
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23.01.20 22:12, Junio C Hamano wrote:
> Peter Kaestle <peter.kaestle@nokia.com> writes:
> 
>> Original bash helper for "submodule status" was doing a check for
>> initialized but not cloned submodules and prefixed the status with
>> a minus sign in case no .git file or folder was found inside the
>> submodule directory.
>> This check was missed when the original port of the functionality
>> from bash to C was done.
>>
>> Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
>> ---
>>   builtin/submodule--helper.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> I wonder if this is easily protectable with an additional test.

Yes, please find it inside patch series v3.


> In general, do we have a good coverage of "git status" output that
> involves submodules in various states?

Originally, without applying the v3 series, I can see those testcases:

1) not-init, not-cloned: 'status should initially be "missing"'
2) init, not-cloned: MISSING
3) not-init, cloned: MISSING
4) init, cloned: 'status should be "up-to-date" after update'
4.1) + modified: 'status should be "modified" after submodule commit'
4.2) + modified, committed: 'status should be "up-to-date" after update'

My patch v3 series adds a testcase for 2).
Is 3) even a possible use-case?

Besides that, I think testcases for man git-submodule's description of 
status on merge conflicts are missing (...[prefix] U if the submodule 
has merge conflicts).
At least, I didn't find any when searching the tests folder with:
$> grep 'grep "^U' *.sh

> 
> Thanks.
> 
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index c72931e..c04241b 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -782,6 +782,9 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
>>   	struct argv_array diff_files_args = ARGV_ARRAY_INIT;
>>   	struct rev_info rev;
>>   	int diff_files_result;
>> +	struct strbuf buf = STRBUF_INIT;
>> +	const char *git_dir;
>> +
>>   
>>   	if (!submodule_from_path(the_repository, &null_oid, path))
>>   		die(_("no submodule mapping found in .gitmodules for path '%s'"),
>> @@ -794,10 +797,18 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
>>   		goto cleanup;
>>   	}
>>   
>> -	if (!is_submodule_active(the_repository, path)) {
>> +	strbuf_addf(&buf, "%s/.git", path);
>> +	git_dir = read_gitfile(buf.buf);
>> +	if (!git_dir)
>> +		git_dir = buf.buf;
>> +
>> +	if (!is_submodule_active(the_repository, path) ||
>> +			!is_git_directory(git_dir)) {
>>   		print_status(flags, '-', path, ce_oid, displaypath);
>> +		strbuf_release(&buf);
>>   		goto cleanup;
>>   	}
>> +	strbuf_release(&buf);
>>   
>>   	argv_array_pushl(&diff_files_args, "diff-files",
>>   			 "--ignore-submodules=dirty", "--quiet", "--",
