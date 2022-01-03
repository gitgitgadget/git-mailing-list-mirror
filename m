Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED62C433F5
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 17:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiACRW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 12:22:59 -0500
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:62289
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232003AbiACRW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 12:22:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jq2DkJwh1QVYtwB/v6Vsg2z59pRKSC1IdBNTkX/zP4H4xK+LO0dJEPSQo7SaPf7wiwC6iT3yBA1ne8Zp7j1jU0kuFvcov+zbzrUavuzX68j76ppOUrX74PEqT+rqGv93e7FfZocn76u0bdbUMDSGnkvtyMJOjexr2sGBcFNtzXG6p51S7yJTuau9jRvEbTvW+r51s7mnsyBCL3CqnpbsB1RkVACVZEc9YQs5qd/kf+icwXNMnsTqp9jzX/w+9K9GzMGjfMtUbXlckxYGTJDhW6n2snhRQM73gdbyv5oY8Ll9Hl4XD/yE3Wnp6pSPs9XeVSuSdT9veMqKMq0HCzYYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fv72IshR3l6xZKj/jt8R7gdCeK04kugCrymG846OHq4=;
 b=FXBdeYkrIBZdGkbWE8jX5qzOFXeCYhbTB/IMYcSGQMU+F+abUENd+MKiZ0usJ5F8RHc3nEKDJeV/X+VzCZ0bo5Wq3xw+H6gCr6DWfmxnTAOB5otNhpxUlW77P0FdejUrV3NAg4soJQ8jVY+cdDltNDt3AYEuxBesZVopj1PP/9DRdZqV9nmTWhrb1fJtnDLXJ7iojUJYAYlv27HhrDPqaglU/QjwUTGCxoruM32rR8bbTLnc0ZulZEMtXBpe/7jUSYonASmYe/Zq5Lve+pbzSfEOdRmPJuQnfm/EZbpYx65CIJVptePZAFKLLbV4cS5eTtaqbSm6sKA2b2Rckt4pxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv72IshR3l6xZKj/jt8R7gdCeK04kugCrymG846OHq4=;
 b=RhESYY7fxKd2w+XMMcAPMmBJcGZExme7QLLhujnqYbA8MlOdK3W7PLNQ9w+Yct6NcNEP42zv3CnOQ535uXDSqn+DKf2BypIE3gjcCvfz40X63N2C250iyR/mTJqDClreFua9NZq194nLDcQCm85rGfPgP2laEH91zAqcJi0yqc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4397.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 17:22:56 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 17:22:56 +0000
Date:   Mon, 3 Jan 2022 18:22:55 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 7/8] merge-tree: support saving merge messages to a
 separate file
Message-ID: <20220103172255.54psh2e5iqzd37sy@fs>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <777de92d9f166793cddbb383f497518a5dedb9f4.1640927044.git.gitgitgadget@gmail.com>
 <20220103123114.uuvpk4nley22gfkg@fs>
 <CABPp-BH4okfDXVC418HwfHVR2_NtbKFBOfyYGZ9mWnABMzSruw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CABPp-BH4okfDXVC418HwfHVR2_NtbKFBOfyYGZ9mWnABMzSruw@mail.gmail.com>
X-ClientProxiedBy: AM5PR04CA0022.eurprd04.prod.outlook.com
 (2603:10a6:206:1::35) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de595803-1c56-4fca-54a6-08d9ceddaed5
X-MS-TrafficTypeDiagnostic: PA4PR10MB4397:EE_
X-Microsoft-Antispam-PRVS: <PA4PR10MB43978F4503339334D2FF2F3CB6499@PA4PR10MB4397.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRkAXXGI6tTatjZR6cN0/OYr9P+mVH/v6lwBiD2LVDadyMAYualzuR8muIIBJrKPJ8YPCOqqKNfKNRezNumW7gB/x2AhjIMbor+g9zMMOgwKVFPa6ZLYZSi68EHN7zR1QT86g+Zojhk13zD73gIA0Shsbq9XcNWkWvp2SpIf86zybyIL19e50DBvpgpQnZhrzPRMyCC3b4IzCtxKrhGvy7Pc2ILB4dkK3P0HYfFKHNPqACyfm5sJP9nEK5BwzKn+TcFkm4Jzt3dVRRl7MGdWlr6TuCySYPRkF3NGRNrMjWyrCrr26DjLjbM7xJfTn0Iv84n8adFnUzdIn+kiBdQqhFJvhWATHJ0CwFShKAndGZN9eo1jWtYl3Nv5P7WWjYxS0GyTDFPY5JFvJggxi2cKyjl5sMYtIBKYORI/QXxHPBUcVUDf86HJEx96MfaEZXwiv+aXmqxVqD5xVkL+ZvY0PlWWc8I0rj5eXteGNCC8bTD6GaT1HuypTgyoC+X7XPUyKh69+ee5e755FWj54dz5K/s1JUroVz0Bus43eWhFs6W///O3va07M5KeRBVrR8leUesc/xNPJ0mKs4TcFxo65EDuTvHAN5OgCYAYR19ghdHup7vP8jP6+OFj673G8DfnDIWwmQRunzXFQsSYpzKp1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(136003)(396003)(346002)(39840400004)(376002)(6916009)(4326008)(86362001)(508600001)(186003)(54906003)(316002)(6486002)(66556008)(1076003)(15650500001)(2906002)(83380400001)(66946007)(66476007)(9686003)(38100700002)(33716001)(53546011)(5660300002)(6512007)(8676002)(6506007)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGhBVWJPV0dEc2Y4K0owTitSTnBhRVViMHVZOHNERytIQk5MdU85eEtYQ1dL?=
 =?utf-8?B?UVdUTDRNQ0NTU01pbVE3bThycmFPT0J2RzdtUGhBWmFFZmJQYWpuazBINWFs?=
 =?utf-8?B?Y2JzekFTRlhvWHhGcC9MT2crTzJ2a3pzdWw4bFdpZG5ScXZLaVU3aG1uR3lF?=
 =?utf-8?B?Umg5WDdEWFlGTVJNdGJ4L2xqdjdnUHpZOTFWUFNOVFcwaDVGZExlaWlRTjBq?=
 =?utf-8?B?NHE1Z3BEc0FBcVFsczkzZlJjaDB3K3h1OXlrSUgrSStoeVVjcy93bzR4ajFi?=
 =?utf-8?B?NmJ3L3l1aFhINGVZQlBNN3Nza1dpVTRXL2oraDcveHRUd3h0NmRZa3VObE1H?=
 =?utf-8?B?bU9YdjJpckxkbHBJbVBhb0J4ZFBxUXpPSzZvK0xvNjZPYm81OVF0d0t2N0pl?=
 =?utf-8?B?MFZhbUJ3UitlaWc0ZFNXWDNxZmlURkJvTHFwakVBc05jN3o5dmkrNjRJZ3NJ?=
 =?utf-8?B?OHRDb2dUOFF1S2h1NjhXWG15RDU3UkpFSVZJaHNCMlYwdE5BV0NtOUxCUzFW?=
 =?utf-8?B?V21haFpLMlUxSXFsZU0vcjVxQ2dnUVVsUGVyRExKaUdRVzB2WDFHTm9tdEw5?=
 =?utf-8?B?dzRzNkNvQ2ZKeHZCcUwwL2pwNnp1SU01UVZYbVNLZjRTYm5nTzFibGtIR2RF?=
 =?utf-8?B?dkFVUnhOOXFPMTE0ZEVaUHd4emg1VStzSk80SkZNL2R6T1NoOTFBWGREN1VX?=
 =?utf-8?B?UjdTdlJqbk9NSEpnL2Mva0duV0NRQW12M0ZacUxEaVdOWlZyQVlTbXkyT24v?=
 =?utf-8?B?d0kvTVFQenZORHBhZG9XMXRMVkIwajA4c3NzYTVoRTAvalAyRUFWTXB2UHM2?=
 =?utf-8?B?bWZuM2pMcnpqbjB4SzA4OFIwY1JkcG9iRDcvUTg0bHRQUWRyMWJsQWJLak9F?=
 =?utf-8?B?b2Y0K0ZJZU5SSHJPa0wvalMrdGF4aGZjMlM3Rm9vTFBXMnJaOXp2bG9BSUJz?=
 =?utf-8?B?NnpqdThBRVhtN3BXZjluK2ZQNkZHdkplazhKMHdERXdBT0YzTWRhOG1MajI4?=
 =?utf-8?B?dnNSWnBudGw1bzEzQmdYd25XWEZGQ3lIUTBUanVZNGNWdnV6SmZpUEFxYzhB?=
 =?utf-8?B?aDVHUlNtakZISHVCVHNXb0pva3Z5azdER3ROdXpYVEZDV2tuOU42bzY5elZQ?=
 =?utf-8?B?bG9jQ1RITU9lb25pQ0h4enZ1TU85Uk5GK29GRGw1WkV3cUhIMmc1T200Ni9M?=
 =?utf-8?B?Vnd1dTR2Q2NmeEFLSXZ4bGdIZjFweEZsN0xvTFk0Yk9kb3JmQWlUZHdoalpS?=
 =?utf-8?B?MEJjbCtkMEt1RzgvYVAwRktTTVZhZUIwaVhEME9Cd0lTcWk1S0xiMlRXazdP?=
 =?utf-8?B?Q2lZeGdkTURhcUh5cU9GMSt3SEFsSG5LVmdlVzVtcTBvK1dvUXFUM09DbXRp?=
 =?utf-8?B?bnRmRHJpb21EYkpVZzMrUUNvcnZSeFFrRE5IZG1zZnZkQ2xzU2c5N1VnZktk?=
 =?utf-8?B?bFJXbFgvbVQ4dWkzcUpDRDB3cmlLQVFid0Q4bWJmTytUd1Zoc2w0eDdicWRB?=
 =?utf-8?B?a3FkRWZ1anVtbS9rSGZtMXJzKzFLZ0ROeHJwRzllaDVMQnFOSzA5QThjZTNF?=
 =?utf-8?B?V2ZJa09hbk16eFhBTHBwTEJkYVVSYUVwWmR1TU1mbHVDWCszY2F2cHlsN2xm?=
 =?utf-8?B?NjN0TVN2RjI2cXJPZitkQ2JIQU1SK2F1RDlsTFdVb1d0QjJlanFzUnhvV3Yw?=
 =?utf-8?B?UGIrd1RyZ2lZVG1MWFk1N0QvTlBHVWJIM2xCTlFIRW1tOWpLWDdmcE5BTW9H?=
 =?utf-8?B?cFlPYVlFQjdkbkZIUGxNN240QU00ME9mZWNLMHVKeC9mQVpLeVZIL3EyZlRq?=
 =?utf-8?B?dXc5anBDelNiSkhNS3U3bUVUbDlIeHdHNFpZNWRuRWNFcFNiVkNHblpBK2sz?=
 =?utf-8?B?aEsyQjh6MUluVzRTenZWYVRUWVMrcjk5Sm1ncFA3STJkcFlRd0JZMWZhdDEr?=
 =?utf-8?B?OWxZbVZDRDB4MDRnZjNqTS8ycmxSeVVMM3FUWW52dDlRZ2RCS0pIK0FMV2dr?=
 =?utf-8?B?RHVJNVRRUG1abFhEdXljaGJOR1RWcHdwTzFieEl2R2puN3gzRmlDTGplVlZy?=
 =?utf-8?B?N0pkUEdMZjJEUGg4Zjg4TTJaT0FNOUJwdmY1L3EvWFhhVkdhdk05RldXY25G?=
 =?utf-8?B?SmdUVCtnOEFIamE4ZEVVK1ZMd0JvNGkrL3o5aFpHTWZjRU9BenN5TExrWUdH?=
 =?utf-8?B?Nm5uTXBKd2NGd0V4dlpzUWM2YnJaNmFKT3AyTHVCczViRG5VbEVMdnhSVi9n?=
 =?utf-8?Q?Cc7OROYDl1raYv2jDnXliSUy61MyqpwiiNC11YxCXg=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: de595803-1c56-4fca-54a6-08d9ceddaed5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 17:22:56.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgA8F5ELVjEUOC9ZtSI4YfcCpTziSENdebnL+y4/FxNFf9K5KvSTnKRhiswxpwCGEkMIgP2lQBJsT6PdbEy49aXurv1b6NaYv/1tnwZRM3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4397
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.01.2022 08:51, Elijah Newren wrote:
>On Mon, Jan 3, 2022 at 4:31 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>>
>> On 31.12.2021 05:04, Elijah Newren via GitGitGadget wrote:
>> >From: Elijah Newren <newren@gmail.com>
[...]
>> >
>> > static int real_merge(struct merge_tree_options *o,
>> >@@ -442,8 +443,15 @@ static int real_merge(struct merge_tree_options *o,
>> >        */
>> >
>> >       merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
>> >+
>> >+      if (o->messages_file) {
>> >+              FILE *fp = xfopen(o->messages_file, "w");
>> >+              merge_display_update_messages(&opt, &result, fp);
>> >+              fclose(fp);
>>
>> I don't know enough about how merge-ort works internally, but it looks to me
>> like at this point the merge already happened and we just didn't clean up
>> (finalize) yet. It feels wrong to die() at this point just because we can't
>> open messages_file.
>
>Yes, the merge already happened; there now exists a new toplevel tree
>(that nothing references).  I'm not sure I understand what's wrong
>with die'ing here, though.  I can't tell if you want to defer the
>die-ing until later, or just avoid the die-ing and return some kind of
>success despite failing to complete what the user requested.
>

I think i would prefer the merge operation to abort before actually merging 
when not being able to write its logfile. Otherwise we possibly do a whole 
lot of work that`s inaccessible afterwards isn't it? (since we don`t print 
the hash)

Thanks for your work on this feature. I think this could open a lot of new 
possibilities.
