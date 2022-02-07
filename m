Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F8BC4167D
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 10:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbiBGK6p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 05:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243064AbiBGKwr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 05:52:47 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D399C0401C0
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 02:52:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhZRDIN3SigSWsF6ad5IYSVaJY1DF8YEPrWBnxxNzTk3hcM+GFjMFnXlPDS3EpKqhLxfilAXHVTsT3fRRxgJpqHhXnAGnPGHdWJd5MJdi5Z+6v9IrQ1kjSSzfAS2zMjaRF4hZ6+gCFEPyTzOCACeUnceU9iqtWWl8poBojNstwI4nl/z0R9cDW8OCN1SU4mOlg3xRlmwn1OysBaGEdX0esEWT1hKzOYHbu6eWOshXYMOrlqnjiDlZqeFd2AO08cxQSVpd5MW50P+XzDuGKb/oyHJuCQBfvhnp2acyodLgVsB2BrQy72LAN5eVAGJ2pB7y3h28E6TWOw1PgszD3S3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkXpCEgYtYc9goVpdTu9bUuK0S0LTOFBBheRHqwbs1k=;
 b=A3d54vAN/N2EZraWymh2RpHBlw291i0+M0NYRDY7jwPhuKV2gbGKhr6qR634YkkI3H945Ga/Z03pxXxqn++GZcC5/YjOZw/Cg5AJNSYv1Krg2CLQlGUbx6q/cINSEloq6Onp2zv31fDtUbxC95HnzTAInCDLsUHlIabUWjLpurX4yldGRXkcjuIz5myfcUIx8rduvRr4yzATb3nSLJOaMP24cgRUG31zficnmqD5y1Wryy5kBXfD5GNXBvfWfcYwSh4DgtBgkGedO8r9+ve6873TBnI5/jq7Fed6fGcAY3F/lf2+OrCK9YaYLBfv5AC1h2VdRYFLNouIPt6VhDGp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkXpCEgYtYc9goVpdTu9bUuK0S0LTOFBBheRHqwbs1k=;
 b=YNU9P0TbmRn1VzCua4XTbkh/LpsODmNB42bWVDbZaB2lnduWb78N+8QxhVhGqMI+LAYPMKa5xKgewyiIdiwZEVObMdE1fvwX99UZjofMhihnmMAb2lR31tDyVtR6S3+TOShiXQqpNcv5qzz3QGc1Q0+Om2bigFtHPpYFOrgUmww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:259::19)
 by AM5PR1001MB1089.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:203:13::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 10:52:42 +0000
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5014:44dc:e7d1:3e85]) by DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5014:44dc:e7d1:3e85%5]) with mapi id 15.20.4951.014; Mon, 7 Feb 2022
 10:52:42 +0000
Date:   Mon, 7 Feb 2022 11:52:40 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gpg-interface: fix for gpgsm v2.3
Message-ID: <20220207105240.dk443kcozynlonpp@fs>
References: <20220203123724.47529-1-fs@gigacodes.de>
 <Yfw0kapgSSWO3Pyx@pobox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <Yfw0kapgSSWO3Pyx@pobox.com>
X-ClientProxiedBy: AM6P194CA0084.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::25) To DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:259::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03b9ced2-7fea-4006-32ed-08d9ea27f704
X-MS-TrafficTypeDiagnostic: AM5PR1001MB1089:EE_
X-Microsoft-Antispam-PRVS: <AM5PR1001MB10891891CC4364D13ED2C0CFB62C9@AM5PR1001MB1089.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypNtolBgnDAr31HjOqWW5Q85rMbX3DXcpZwyUl4SrQBbnd3G0KfFyAkmwKsQUpBQeMoEn62fa810a5wbX4Hg2YjxZesMZ9Tdu25N0Ygiou6d2a/lXiWS6vU9CVwDRXO7xs9Wpcamshw6hrGCid296JVRjF8HUc8+OiGZA5FFpqIhcsqAOz8ZNuP8X4Qt73OiNYPzv06tCUBq/Qp4+d5w4f7JV1LZgHjmnsLMDa70i3nya8MNI6b5OYSba8615D2TbeMq/w1Hvkw8RG2Zn0d3iM70tZ92D1yXvfmjNoDcwhoa1P67hZNwAqQ6QxotemczA7Xq1+J/JYaPpHvuN4iaKmP6aQd+AFKUiSVtQZ+H6ynFYuySJpQAJAE7bY2x6+bVZt7qE0sI/THzy8+FhCYRUcbLSGWbq+FhYNFkr9J7wwQZK8HaWwu9q4dnF+rwDTp3vTO54yWAUlulCACanZL2toVhfuRXOOVG7zu0/cr9fuF/qPm1lCOr4DW/LfoTAryNniPn7bZeyYvV65rb/QmLXIWuVJUzcyI+f2ZArAmsBp2Anx9E6PFx6MODEPHFnnRJMG2FUN0VGkZKW8QQ2XLA6cvLDEwDqVVk24/MDagxr0a9HKcFyTkAuLexpNeO+jDfkw1yoxDDS8zXanazBTq0VzjHRImK1cESv63iiB8NdNB3dOHdtweYJYquLLkWLmJ2ogekwjhzurC4pKsOc5kgE8TX7GLUDuqMxO/NO9r5psY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(346002)(39830400003)(396003)(366004)(376002)(136003)(38100700002)(83380400001)(54906003)(6916009)(316002)(33716001)(86362001)(9686003)(6506007)(6512007)(53546011)(8676002)(186003)(5660300002)(8936002)(6486002)(966005)(508600001)(2906002)(1076003)(66556008)(66946007)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NitjOTZqcU4zQTVLenpleHArWVJsbFJTMU8vSEpwQ2xyZHdET3drZWpPekN0?=
 =?utf-8?B?eDdpcG5TWHdFN3k5Z2FDWm1zRjRCR2VPaFhhUUI0SFRKcTFqSXkxSDZIZHB0?=
 =?utf-8?B?aXp1bjhFaE1XZUdOZlVWaU9IMUh0dllDNUh1eUZHNHc3enhuWElVL2dGd2Z1?=
 =?utf-8?B?R0dzZDFpY3Axc05JdnVwWStEYmpJdmhnVTRIZ0Vpa2t1azBxVTJmTzdKSnFV?=
 =?utf-8?B?QllrZ3dXTzZRa1JHb0FNYkNhcHdvRkEySmlBOXcwdWJDTEU0dXppcEpibFky?=
 =?utf-8?B?bU4xblpod3VKbG56NUhUSG9vWkxnWlFEeFRNTHlHTit4eVNnbDl6QndGY2JD?=
 =?utf-8?B?M1AwQWRvY0NLUVVBVVg5ODUySGRFS2xXRzd0Ykx5MXdZY2k3c1BNb1JRbTNr?=
 =?utf-8?B?eDZUaGVhNVhMTUJxY3ExODV3V0p4cnpRVGRPYi96cGE1Q1I2UTZvbW51YTRw?=
 =?utf-8?B?b3ppa0FpaG5XYmloMGUwcjRxMWU3SStCWkFGZkVxNm1NYWJzc0lVQTRoVzlK?=
 =?utf-8?B?ZWNUaVNpcGJodUtkQytSeGVpUnJyNlhOUkZpTHZ5d3QxL09zZkVWdC94VktP?=
 =?utf-8?B?SjAyeDdUQzdIOGZzMVh6aEI1Rm5nMklYUUZpbU5pTlNCVmtuU3BEdkJSSjUy?=
 =?utf-8?B?N3M2S3FHZ2pFNitucnhzTlBjMUNqVmZFTGFNcnp4N2JVZGFCRTVIRkFHcFdL?=
 =?utf-8?B?OEZmc1RIYjJUOHF3NDJxSTFZWnJHYnYrMGZIRWVGWGwrWFd0RE82MWJvK1lY?=
 =?utf-8?B?eXo3RWhqeVoyMHdwb0ZzSnliWlRtOEdMV0l0dTFFTml4UnhBQWlCdFhMS1Fl?=
 =?utf-8?B?WldpemNMekJzOFBzNzgvZWdkV2JNdmlWRjkzc0wrRUZBdDM5WHdjTnVKY3BD?=
 =?utf-8?B?ckRrVEljU3UxM2lUNmQwRWcvVGhkTlVMcnJHY3BmNjFRR2hwTmQ1clRjVUFC?=
 =?utf-8?B?eTRvUUtRUFBlUU54cnF6eG0wMkdkbm9NWDFENTVJZnE1aTQwdXpyTk1US01x?=
 =?utf-8?B?ZjkxNkJob1pISXkzbFg2eER3cHNuZlgxT0pLVHVqNzQyMDAwTW15SFFUUHpK?=
 =?utf-8?B?Qk01OHdRQ1BlZ204STJJM3J1STI3SDJGak1OQk1tU1pYU1FyT1hSMEo0U0xo?=
 =?utf-8?B?TFM0MER4L2NmOTBKcnZLUlVrbjFQYlowMU1rcWZpMUtQVmtZbnJmejM2b0Jl?=
 =?utf-8?B?U2xoem4zVmFOcHFaeFhlb3Y3ZkRRQWllTWFZNlRiRzNDVzltL21pQ2xXUmUw?=
 =?utf-8?B?ZlFVd1ZTbHNuNm1vQzYwUHZJMW5sb0xjWjRxRVQyUlFCYjNIK1JKVWc5UEZl?=
 =?utf-8?B?UTU1VklKbzFNaEdURmNQNnY5SVNyRXoyM1JnSmNpTmloZ3pMT2JiN3h4Wk1H?=
 =?utf-8?B?VEZZbzlORXd5V3RzN3lFcWpidWtvK1dxV0VDU3FJVmc5UHNnaWdva3BBV3A4?=
 =?utf-8?B?K2EzRE9XTkdHSnFSdzRYRm9KZnRvd0pEZlllbFhxY0NZK29tVGZBY002QXdX?=
 =?utf-8?B?UHlhSEtlWStnRnJwRHJ3cFB3dDhRVHFuNkhsekhLSERoMHdDZ2JoYjlSUmNM?=
 =?utf-8?B?cExmemppcnhXVU0xSUJ5eFVKMit1ZHB3OTA5bFVFekRGc05qVzB1a2hnL0JP?=
 =?utf-8?B?OXUzNW9Yb3ZzOVlJcFY2dTREeVBZaHMyNGlUaUQxcDNjZWxpMmNXTEdSUUI4?=
 =?utf-8?B?a1pDZlhUNXZ2NEo5VmpKV3NlS1RMSVBBLzlTcWpOY0d2RzhrQ0FERHZDOHI5?=
 =?utf-8?B?U3BLRlJTNnZvZHM3QTRHK1lDSVpFT0ZvOFN3NVFzSmtmOUVXRUdDeXBlZ0hL?=
 =?utf-8?B?NGNGeDdiR0Z0WDM1Tjl4djZueG03clpMQ2xEZTNya3VoOUJPTUVrUnk3dS8w?=
 =?utf-8?B?aHZQNENaeXUycnUrSS9JN3EwSmN5c2FuTFg5YjRWVmZpc3d4dHprTElJRk1n?=
 =?utf-8?B?bTJaQndVcVd0YVNRbXlKM2FTeWZyY0VEd2FIMU41NVptWjAxOUVPZ3dVdkxJ?=
 =?utf-8?B?L0FzcVFIa0JHMWUyRDQyRldaNndYZnZJZHNyWkRpeUxGd3NhUDVINzJ3WW9q?=
 =?utf-8?B?eVNBcENjcWkvMnBIMVhZT1B3a0Y3R2ZEVUNNTTlGWjd3cm8vdWZ1UVUwb0xz?=
 =?utf-8?B?SDk1MFFIWkpYdW9lSkJJNDQ0L3NORndhOWxnWmk2K0ViUWF4ZGhnblR6Ym8w?=
 =?utf-8?B?bnNKMFA1R2hac1VjMnFrVXdmalBRYWhpVFpBZ3hqUmZMWVlXK1NLUG5ieTEy?=
 =?utf-8?B?VmhFY3cxR0crL1dWV05XUU4xRlF2Q05HM09zT0RILy9JYzhTUWwvQUwxcHhm?=
 =?utf-8?B?WWxibklINThvU0tnZzNzOFJoSndxNjN0TkRIRHpIYnc0ZVBXamhBaVFDK1BS?=
 =?utf-8?Q?qa1judRg0bq8O/YY=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b9ced2-7fea-4006-32ed-08d9ea27f704
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 10:52:42.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40239TkJBnbX8Cfe5IoryPPYUUmftV5a13KeAWFfY/Xi7msI2yfCQdvZp18Np2zb/basyEJL7B7fDWu5r6bUdD0PafZVDjfX+dwHsMxA3uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1089
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.02.2022 15:01, Todd Zullinger wrote:
>Hi Fabian,
>
>Fabian Stelzer wrote:
>> gpgsm v2.3 changed some details about its output:
>>  - instead of displaying `fingerprint:` for keys it will print `sha1
>>    fpr:` and `sha2 fpr:`
>>  - some wording of errors has changed
>>  - signing will omit an extra debug output line before the [GNUPG]: tag
>
>Thanks for sending this.  I noticed these as well, as Fedora
>started shipping gnupg-2.3 a few months back.  I have been
>trying (and failing) to make time to submit (when I know I
>won't be too distracted to actually converse about them).
>The commits I made for the tests in Fedora are all here:
>
>    https://src.fedoraproject.org/rpms/git/c/a7d2f7e53
>
>I don't intend that as something anyone here should feel the
>need to chase down.  But since they provide some additional
>context on the changes I made in the same area, it might
>help if anyone's curious.
>
>> diff --git a/gpg-interface.c b/gpg-interface.c
>> index b52eb0e2e0..299e7f588a 100644
>> --- a/gpg-interface.c
>> +++ b/gpg-interface.c
>> @@ -939,7 +939,7 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
>>  			   signature, 1024, &gpg_status, 0);
>>  	sigchain_pop(SIGPIPE);
>>
>> -	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
>> +	ret |= !strstr(gpg_status.buf, "[GNUPG:] SIG_CREATED ");
>>  	strbuf_release(&gpg_status);
>>  	if (ret)
>>  		return error(_("gpg failed to sign the data"));
>
>As Junio noted, this loosens the GPG parsing a good bit.  I
>worried it could lead to security issues as well.  The
>simple fix I made in Fedora was to add a newline to the
>gpg_status string buffer before adding the command output to
>it:
>
>    diff --git a/gpg-interface.c b/gpg-interface.c
>    index 3e7255a2a9..d179dfb3ab 100644
>    --- a/gpg-interface.c
>    +++ b/gpg-interface.c
>    @@ -859,6 +859,12 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
>
>	bottom = signature->len;
>
>    +	/*
>    +	 * Ensure gpg_status begins with a newline or we'll fail to match if
>    +	 * the SIG_CREATED line is at the start of the gpg output.
>    +	 */
>    +	strbuf_addch(&gpg_status, '\n');
>    +
>	/*
>	* When the username signingkey is bad, program could be terminated
>	* because gpg exits without reading and then write gets SIGPIPE.
>
>https://src.fedoraproject.org/rpms/git/blob/a7d2f7e53/f/0005-gpg-interface-match-SIG_CREATED-if-it-s-the-first-li.patch
>
>But that seemed like a bit of a hack.  What I had queued up
>to submit for discussion (as I'm not sure that it isn't
>entirely horrible) used the string-list API to parse the gpg
>output:
>
>    diff --git a/gpg-interface.c b/gpg-interface.c
>    index b52eb0e2e0..e63ccdcb11 100644
>    --- a/gpg-interface.c
>    +++ b/gpg-interface.c
>    @@ -921,6 +921,7 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
>     	int ret;
>     	size_t bottom;
>     	struct strbuf gpg_status = STRBUF_INIT;
>    +	struct string_list lines = { .cmp = starts_with };
>
>     	strvec_pushl(&gpg.args,
>     		     use_format->program,
>    @@ -939,8 +940,11 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
>     			   signature, 1024, &gpg_status, 0);
>     	sigchain_pop(SIGPIPE);
>
>    -	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
>    +	string_list_split_in_place(&lines, gpg_status.buf, '\n', -1);
>    +	ret |= !unsorted_string_list_has_string(&lines, "[GNUPG:] SIG_CREATED ");
>     	strbuf_release(&gpg_status);
>    +	string_list_clear(&lines, 0);
>    +
>     	if (ret)
>     		return error(_("gpg failed to sign the data"));
>
>That's the commit I was most in doubt about though, as my C
>"skills" are close to non-existant.  I'd rather have
>something ugly and clear (like the `strbuf_addch(...)`
>above) than clever and wrong in gpg-interface.c.
>
>(To be clear, I mean "clever and wrong" in regard to my use
>of the string list API, not anyone else's code.)

string_list_split seems a bit like overkill.  My first thought was actually 
sth like:

cp = strstr(gpg_status.buf, "[GNUPG]: SIG_CREATED");
if (cp == gpg_status.buf || --cp == '\n')
	// found

But that would fail in case the string came up before the actual success 
message at the beginning of a line. So Junios variant of using the for() 
loop is more robust and would normally find the correct string on its first 
iteration anyway.

>
>> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
>> index 3e7ee1386a..6c2dd4b14b 100644
>> --- a/t/lib-gpg.sh
>> +++ b/t/lib-gpg.sh
>> @@ -73,8 +73,8 @@ test_lazy_prereq GPGSM '
>>  		--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
>>
>>  	gpgsm --homedir "${GNUPGHOME}" -K |
>> -	grep fingerprint: |
>> -	cut -d" " -f4 |
>> +	grep -E "(fingerprint|sha1 fpr):" |
>> +	cut -d":" -f2- | tr -d " " |
>>  	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&
>
>I think this whole thing can (and should) be simplified by
>using gpg's --with-colons output which is intended to be
>machine parsable.

I looked for sth like this but gpgs --help does not list it so i didn't dig 
deeper. I've checked the blame and it seems like this was introduced >19 
years ago. So i guess we can probably use this ^^

>
>If we'd been using that previously, we wouldn't need to make
>any further changes here.
>
>I think we're making our lives difficult by screen scraping
>here wher we don't need to do so.
>
>The change I made for the Fedora package to fix this does
>it like this:
>
>    --- a/t/lib-gpg.sh
>    +++ b/t/lib-gpg.sh
>    @@ -72,12 +72,10 @@ test_lazy_prereq GPGSM '
>                    --passphrase-fd 0 --pinentry-mode loopback \
>                    --import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
>
>    -	gpgsm --homedir "${GNUPGHOME}" -K |
>    -	grep fingerprint: |
>    -	cut -d" " -f4 |
>    -	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&
>    +	gpgsm --homedir "${GNUPGHOME}" -K --with-colons |
>    +	awk -F ":" "/^fpr:/ {printf \"%s S relax\\n\", \$10}" \
>    +		>"${GNUPGHOME}/trustlist.txt" &&

This does not quite work for me. It will add the fingerprint without the 
colons into the trustlist which is not valid :/
It would need sth like:
+       gpgsm --with-colons --homedir "${GNUPGHOME}" -K |
+       awk -F ":" "/^(fpr|fingerprint):/ {gsub(/.{2}/, \"&:\", \$10); 
printf \"%s S relax\\n\", substr(\$10, 1, length(\$10)-1)}" \
+        >"${GNUPGHOME}/trustlist.txt" &&

which looks needlessly complicated. There is probably some better way to do 
this with/without awk.

>
>    -	echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
>            echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
>                   -u committer@example.com -o /dev/null --sign -
>     '
>
>With a commit message:
>
>    https://src.fedoraproject.org/rpms/git/blob/a7d2f7e53/f/0001-t-lib-gpg-use-with-colons-when-parsing-gpgsm-output.patch
>
>I was hoping to submit that small series in the next day or
>two, while I've got a few days away from $work.  If doing it
>that way is appealing, I can submit them.  But only if that
>looks like a reasonable improvement to you and others.
>
>>  	echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
>> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>> index 5049559861..08556493ce 100755
>> --- a/t/t4202-log.sh
>> +++ b/t/t4202-log.sh
>> @@ -1931,7 +1931,10 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 miss
>>  	git merge --no-ff -m msg signed_tag_x509_nokey &&
>>  	GNUPGHOME=. git log --graph --show-signature -n1 plain-x509-nokey >actual &&
>>  	grep "^|\\\  merged tag" actual &&
>> -	grep "^| | gpgsm: certificate not found" actual
>> +	(
>> +		grep "^| | gpgsm: certificate not found" actual ||
>> +		grep "^| | gpgsm: failed to find the certificate: Not found" actual
>> +	)
>>  '
>>
>>  test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 bad signature' '
>
>Can we make this simpler by adjusting the grep pattern?
>It's certainly a slight trade-off in ease of reading, but it
>saves a subshell and an extra command:
>
>    -	grep "^| | gpgsm: certificate not found" actual
>    +	grep -Ei "^| | gpgsm:( failed to find the)? certificate:? not found" actual

Thanks, will do.

>
>I did that in a separate patch:
>
>    https://src.fedoraproject.org/rpms/git/blob/a7d2f7e53/f/0004-t4202-match-gpgsm-output-from-GnuPG-2.3.patch
>
>IMO, this is a bug in gnupg-2.3.  I submitted a patch to
>resolve it back in November, but have not gotten any
>response as yet. :(
>
>    https://lists.gnupg.org/pipermail/gnupg-devel/2021-November/034991.html
>
>Not that it will preclude us from having to fix this for the
>test suite, but it's worth noting why the change is needed
>(and when it will no longer be relevant -- if/when we don't
>care to support the few early gnupg-2.3.x releases).
>
>Thanks,
>
>-- 
>Todd
