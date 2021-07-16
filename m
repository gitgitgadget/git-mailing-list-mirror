Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D83C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 07:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA70613E3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 07:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbhGPHD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 03:03:27 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:65078
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234986AbhGPHD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 03:03:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVzJY8Eu3cVcx4EKV7vv9hhIHPuAtTzLhUVA00n+RIIy2SbnsRxKeLxdlSlS2pGWdMPrdDRE5OL5Vh4EHbc21xjTCX06NQkdZfkt2GC+eoYBNxxuG0zBfY9hEs4LTqgYGyMPLiou7OzyruouE2xr1FZcotGdPPKTcc0wo0843fyg4Bujcm462tKEeoqfEBUW1dx6JOB2uun20nCY7MpfKwyMMJ1d25/wU9Epyi2e0dzzURRvsCOlgz0XHOeJEs+0lrYYZSGUZ4e9TfySCNgNg2NzWItXjB+o707f6bNT/txZB5AvovIwRYx9VXoBKCUWJl5WRiQYZ1fGVU6UCjWVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtmT77O2BuVm85Sp92ITSQdvhCXknkic3DWfCfCb0cI=;
 b=kTz3Gt1J0qoAhMtghm0EycgdvcKpudZ//kumWifzFsS3Kwx2W7hBizs8UhbOv4RNkyZNnU16RWdh8LDX0UDpeEKFopH0Y4bmFP3R6uN+Vp+WaG+czP+KQgr6aVyLJRabGhVGr68rQTKqqWyg/kHEmDIocEoffuCj/MFlKqT1K9MVeGucL6mcbNmI4CzeFAQQRIv9bYRiSoyddMqiLQdko5Q/7QxnoagcMIZAkWNL6slQdl4GrBNqCYmHYtLMBMs4J8yX/mu4EwdHxFSWnqG2FCvIGEy5yzdo8OvFOJ22xJxOdn9+T4i5r6b5XVtAAD3DBu2oIJ0HKj6Y1EgPT+JKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtmT77O2BuVm85Sp92ITSQdvhCXknkic3DWfCfCb0cI=;
 b=RqY83HjHFfU53eFCy3MobTlr/A3hdOhIZeqbE/V7m9/Mne+ibpVv1woEOE5vSKpFOK9zgLt62Capw3CMuCYoXToi0GjGgx2tGGhXGgHZpo0zdM50LM3fnXi9kGLo01fQ1cNceVsUa1PxZzFQ9qIiO06SGYotcpIg3sG2Iu/685Q=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 07:00:29 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%4]) with mapi id 15.20.4308.028; Fri, 16 Jul 2021
 07:00:29 +0000
Subject: Re: [PATCH v3 6/9] ssh signing: parse ssh-keygen output and verify
 signatures
To:     Gwyneth Morgan <gwymor@tilde.club>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
 <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
 <381a950a6e1708b3895bb9c9cb46e974e142ae64.1626264613.git.gitgitgadget@gmail.com>
 <YPDN3Lkg9xm0WCSP@tilde.club>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <3d8a3221-5d28-5707-0b80-5c8a58cc23bb@gigacodes.de>
Date:   Fri, 16 Jul 2021 09:00:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPDN3Lkg9xm0WCSP@tilde.club>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0202.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::22) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR0P264CA0202.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 07:00:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef988ef1-67ba-4321-26f6-08d948276570
X-MS-TrafficTypeDiagnostic: PR3PR10MB4064:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4064FEC583FA0BF0570FC53EB6119@PR3PR10MB4064.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +G0V+/X1ERkArZi9yKwgEuciEWUbKxLRWZacXk1CAyVYohAAESyZTw6Cs1fwuuMls1rXVSwOtigBLcruRMLYvIM1Sbi3zg8hJCGTVY8jd2xF5JSTA3LRnwA8shgACyGiZ1nEZyxi2gdd/dtr1MzrDVH6bziZOsYqTOWkLZTGpazbECBVyXnh8STocbyIwgThuE1xZb1p90UYPRCzW4HRQnDmpPtrL7azl8/wghkxVDBeKdkVMwayiO9+bdxCR5x45z/fh1jL5qBVOEb5E5/gw99z4omVehFD1xc/nsaBfFIoM8kLKn57tViEuiq34ckqFx8Dhtfv95Sdcnmmxh7TNXfFNMp7zh7AA1zPLmU7RQHUbrt0wft8h9ME7GRmnFxIIFvDR1CFFqs/MF5fgwGbnwHUodYVCHeZpjwNiOTVt2bRRwdRirQzm9eH5PhB3g+6uGn8gOZS32vIDdd0rqMtP85La0MhbOk13OmSMy4oEpUghyIG4Itggu3V2JDBooofPny0OuXizhzNKwrZSr68vDrbnf/RLEh7u9ieHiZmxLlSb9s4a0/4NcoZFyCE+wGHoshwsNrsm4GKc/EkW8owjYRi4qbkF1jSOacDikl1XsMpyAcs2YtHPO0DFjtUlneSCwVicj+i/CjNkf2Ua2F5nFC9WeneVPSt518dGdtI8WQb9sOULtdHY/WCZ3yLseSq+RIcR1mtW7wN3YSn5QJJpM3U3z0EdI+Q2ZZV0pH4OgcWCXEU4bsCWaXjSKiY8nYF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39830400003)(38100700002)(83380400001)(31696002)(86362001)(186003)(54906003)(53546011)(52116002)(8936002)(2616005)(6486002)(478600001)(66556008)(66476007)(66946007)(7416002)(15650500001)(316002)(2906002)(6666004)(36756003)(31686004)(4744005)(5660300002)(8676002)(4326008)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFVnOUVBQ2JzMG9WbHdwOXRWdmRmRUxId0hYSG1XSzFPM2dCc2o0UXp4NW9x?=
 =?utf-8?B?TzJxUDI3SUoxOVRhdEtsd1hpVnZoOHRKS09HZ1FLWWEyUVBaaEgwTmhnREE3?=
 =?utf-8?B?L3FrbXdSMXl3VWRjOExHTzBnVm9aMHBvYWxaUlpaMmNnWUNpMVdzZG5rbDB6?=
 =?utf-8?B?VTBqUitKRFpFcVBsTXNqYXM2b0lPNk5CdXN3NHUzQW42ZjdETTh1b0NvbThm?=
 =?utf-8?B?M2tzTCsrZVdWc0RnL3JlQk5ZU0lHZnJlRitCUXJhVW44THQ4R3dXVHA2VVV1?=
 =?utf-8?B?cnJ0QmtPcjU2eHdTcGhTVjVoa3RHOFk4WTNyQVErM1pxZ0x2bE02a2pHVDd3?=
 =?utf-8?B?bU91NG5kLzMwVzdJTE5OM0xLWlJER2kzenVVaHFacXRPcVZMTjVuSVV4NVZt?=
 =?utf-8?B?S0NMTU02QmxQRGNkNm1DaHdVdXEycmxqcTJEVzQ0bzVteUlhbWdjOEIvYXNu?=
 =?utf-8?B?U0NVaEMwQW96dVlOY1RQNnRIZG14ek5ORTNhTVU4VFN0TlIrZnA0L1NFLzM4?=
 =?utf-8?B?S1BZcjFDNlp5SzlkeUxNSVBsZTZFa05SZXd2TzVGc2dtRnVldUJUQ2RXSEpz?=
 =?utf-8?B?c3Z5SXVPcjFUWVFGT3NQb09xeUhJSC9tMzVOVHNEVTd3bks3YjhpdWtNZG1D?=
 =?utf-8?B?Z3prR0lkZGszUXlCQkZJQ2k2bDF0c3RRUnU2czdDMzlpSnozQ2JGaldCZjRT?=
 =?utf-8?B?eTBmOFh0bjFpTWRFVXlKQWtWbE15Y2ZYNEZvTnJUeEVWNWEvb0dqRG1LRU9t?=
 =?utf-8?B?MEhlZGg4NTl6WmtvVndyK00yZUkxc0FlMGlpa3JIUEwxUXNmdU5DSTgxaUtX?=
 =?utf-8?B?NDZoK3FFUGd5d1hUOWhqMHZtZWRycDAxdEtWbEpva2REU0pJRGI1L3lTc0xE?=
 =?utf-8?B?bVZSTldEdzI5N09YUmg5UXhRZXh0Q2lEUFBuTWZObmZhSy9mQW9JSURpZGtp?=
 =?utf-8?B?S0FiVXcvQUl5cTJzejBuMzhadzltU0dKVHhiVVR2c2toclVsdHVEL09pSmhB?=
 =?utf-8?B?Q2dnd0VJeEtDZ3lnMGtXamZmN2Z3VGFncEZndlNkNWQxTjBYbnM1SlIzaWtZ?=
 =?utf-8?B?SUJjSDJNcG9oWmRGMFVrVEpkYSs3bEtRZGNIQkNtbnlLUXVtZTNvM3BHbDNz?=
 =?utf-8?B?dVU3ZmJrcHVqaVFTUlRQNTZnMWlsZWVhWFpyYldoMUhGZS9TaG1McUROSytj?=
 =?utf-8?B?SVFLbEk3bzNEczBUcXhLdW5mc3FFNTJYRVR3b2JXSnZiRkFmVTVqblVEQVhG?=
 =?utf-8?B?YnM3NmdXUmpodE1DR0MzWkVya1k0WXViUHpjMWZKWVMydXk0RmhQSkdIUHh5?=
 =?utf-8?B?Z2Z6WVE4RkhwVk9mSFdqQUJmMCtKc0FJQXhNRThEL1hjUWI3LzlEZ3hZbHFu?=
 =?utf-8?B?emY5MDJRWCtwM1hwMDZGKy9aQWVFcnRUOEVvekV2a2x5alpRN2hmTHcwWnZq?=
 =?utf-8?B?bno4Uk4vOUcycDl1ZFdJU2N5NmUvM2xPdDVpL05veXp2WlBYTlBnQ0pEaWxN?=
 =?utf-8?B?MDVSOXUySGtDYzRJRitYVkVjYVNCZ1FnVkQ4Vng2RERsODMvMTNlTm1oc3o2?=
 =?utf-8?B?amN1ajZ3RjRtdmVaOUxVUXJhdzR5YzZTbkRzclpUUndvemRxWEVqNXJhKzV3?=
 =?utf-8?B?ZVlLUG5vM3ZVSmJrcHZ6UVh0RDZVWm5QTGt6emtIenRmcHB1NGlVT0RSS1ZR?=
 =?utf-8?B?bTU0QUJLRW1QNEt1SnpxOGFMY2VBWkl3VFc2MUoxM1B6aytUWEtnaFNuQjlK?=
 =?utf-8?B?RElUT1dCWnphb09IaHVicWQ3L1JPMFcwQWVGamd2UGd3L0lXcU5CYlFHOEpx?=
 =?utf-8?B?K2pEdU5QTEUvU1lVWU16R2FIYTIvOWkvNWdpbVpQdEVRRmQxK1Z1MjdlZlE4?=
 =?utf-8?Q?1YiVLvFihNlyB?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ef988ef1-67ba-4321-26f6-08d948276570
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 07:00:29.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uY5+Nkp07IKBfOwiFV7fctfNTJ8zKWoMJg//+INw/+SfYxLUywN296AVUpqT+8/Iezc9Ea5u13bSb9jaWDitfj4p3mlOwZcKBehlj05huu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4064
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 16.07.21 02:07, Gwyneth Morgan wrote:
> On 2021-07-14 12:10:10+0000, Fabian Stelzer via GitGitGadget wrote:
>> +		for (line = ssh_keygen_out.buf; *line; line = strchrnul(line + 1, '\n')) {
>> +			while (*line == '\n')
>> +				line++;
>> +			if (!*line)
>> +				break;
>> +
>> +			trust_size = strcspn(line, " \n");
>> +			principal = xmemdupz(line, trust_size);
> This breaks on principals with spaces in them (principals in the allowed
> signers file can have spaces if surrounded by quotes). Looks like
> strcspn should reject "\n" instead of " \n".
>
> BTW, thanks for working on this feature. It seems much more convenient
> than GPG in my testing.
Oh thanks. Very nice catch. Easily fixed here but i'll have to rewrite 
the verification output parsing to account for this as well.
I will add a testcase too.
