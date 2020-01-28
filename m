Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5755AC33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 08:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2456C2467B
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 08:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="SRWbrzUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgA1IQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:16:46 -0500
Received: from mail-db8eur05on2095.outbound.protection.outlook.com ([40.107.20.95]:12001
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbgA1IQq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 03:16:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLEwtQT0p4HEa9UCXkX3muzY7+grX+bU9rArFbw8X/x7jhoXBa9wO9I+mjqPgjOb17n3VA8FlJfiPR+0UAyIzsTUAxiHTQM2HIzMZtkmXqx2GPJz//xPyhmScY7yValhW7m6zxQ478TRWMYVOcJ5MwcrTJEGtzLnPtIqHu9RhcaPoNsftG51qQbxgHcUL22fOun0elj9L59quOZbGF1Jy2++/bsljr11XmLNmqsyshH3nLnnd/HRYiUMN0DfVCVcMBDXRQvxNaragHIv86KoLqHuiDI5jXlMW6e3Up1lkL4cF6aC97jrjuJ5i+I52eT1WlzDIVFk8k4KzJ7L7vEvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkRdxUcwmTRB9NPWeq8Rj+MesHQc1Vu4uDA9fCpE3Mw=;
 b=PCd/B2URBS9UdXexRTDfNuismWHiJ63cZncrUmc0WWmO8Ckr4OHN0z2/5nmWS4igNDgW26kpgvprUTfNE7L9w7GemkziSWrAaSr5C38KDqUu8Ou+j86tJ3W40D66nU6Z2SOpN0qssbOnfK1qmENNFpVErzSCVaC10Ia0TeFjlQOB8K4rn0tzN+GuFgAaVRPJDKmyLyefNPU8DnFso84m8Fr4kIXVoOmsy7erba41phmqQlsgo6x9vGfrfeVAr13Rv53uxWohDl84kmiFQshfm3NunUpUr/WWZsfBs3GGvjqgHvoy0Dp5lwetenttqoqOgP/coFYTou5ORvMyK8xkdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkRdxUcwmTRB9NPWeq8Rj+MesHQc1Vu4uDA9fCpE3Mw=;
 b=SRWbrzUQGn5FjLkHWMitPl/S2Nofmiveoshvqrg+fM1EdmXIamd+MmObiKa2WH9/AouPY7hlKah+HlqtDNItFNQV2m/9hSEFbFSdhRQ6E4kcwtLgna1BJoOBKiltT2hcmlWh61S/fllyN7p/JQQr1xcb4LPshLtXy6QhSOZelZ0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peter.kaestle@nokia.com; 
Received: from AM0PR07MB6179.eurprd07.prod.outlook.com (20.178.20.93) by
 AM0PR07MB6036.eurprd07.prod.outlook.com (20.178.114.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.15; Tue, 28 Jan 2020 08:16:43 +0000
Received: from AM0PR07MB6179.eurprd07.prod.outlook.com
 ([fe80::68d2:a509:8a23:8d98]) by AM0PR07MB6179.eurprd07.prod.outlook.com
 ([fe80::68d2:a509:8a23:8d98%4]) with mapi id 15.20.2686.019; Tue, 28 Jan 2020
 08:16:43 +0000
Subject: Re: [PATCH v4 1/2] t7400: add a testcase for submodule status on
 empty dirs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, pc44800@gmail.com
References: <xmqq7e1g3ggd.fsf@gitster-ct.c.googlers.com>
 <1580115989-32649-1-git-send-email-peter.kaestle@nokia.com>
 <xmqqzhe8bwab.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <2181f9d5-7556-90e8-14a5-0ca86f2c2c97@nokia.com>
Date:   Tue, 28 Jan 2020 09:16:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <xmqqzhe8bwab.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0401CA0074.eurprd04.prod.outlook.com
 (2603:10a6:3:19::42) To AM0PR07MB6179.eurprd07.prod.outlook.com
 (2603:10a6:208:f8::29)
MIME-Version: 1.0
Received: from [10.151.80.182] (131.228.32.182) by HE1PR0401CA0074.eurprd04.prod.outlook.com (2603:10a6:3:19::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Tue, 28 Jan 2020 08:16:42 +0000
X-Originating-IP: [131.228.32.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ceaf7a0-eb1f-4ddc-f175-08d7a3ca6879
X-MS-TrafficTypeDiagnostic: AM0PR07MB6036:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR07MB603684ECAC87413C028EE506EE0A0@AM0PR07MB6036.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(199004)(189003)(8676002)(8936002)(2616005)(81166006)(81156014)(26005)(316002)(2906002)(31696002)(52116002)(478600001)(53546011)(186003)(16576012)(956004)(5660300002)(4326008)(16526019)(31686004)(66556008)(66476007)(6666004)(66946007)(6486002)(86362001)(4744005)(6916009)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR07MB6036;H:AM0PR07MB6179.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Be2QRvp/x/DEiqZ79WuZbB/z31Vib1wNOrvc5GjB7wNR4zXom0hoJ/SpIJcLtgcIILgAbubHfZJKTEOMN3DmJVcrbSbHO3GlUTJkmAyjOH9d0ZhtAj9EbOduzSPxf1q8Q0g5fj0rtyG6o+MkhRPIJ2MBY+IUuhy7IqdwGBtn8cAU6F6cZZzaZcsdyfskFAZxQ6pYs1hZ7FElUXhENUhI/U/khVo3l7u9HM38DE2RJOv5VID0M27Xp7qGbR9x2AaYwthJjf9yGU7FU/9xE9R2OSLf/P/1SdH+UBELHaVSp3OC6lOuayUUNXOFFxTKBlIrK2U7symPZ+hpb0Q7gRIyOm265lTmdYyP2t5e9kiBrN9Kwi+q3VtXtwEn9zMEq7mJVeZFVvW6DtLRZsxqvBEQtL7EGRtSnr4+nfC1ZTb5Uci1dSclj+i5fmfrfcMWju1I
X-MS-Exchange-AntiSpam-MessageData: FP11rv/YAKI4qNOOER1UTsdflAWRRbR9BPPy57JScq7Zs4ZQ/qpQZRhKSlLXEtBCsnJjShZtYBaqE7ahIEc5wTJkmScg0RSmKOgubf8EGdNJpjvfpol/0mgi/it1gaq0ZcrSUtliE+n0IkAEr/zzSg==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceaf7a0-eb1f-4ddc-f175-08d7a3ca6879
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 08:16:42.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrbK6M0CnQrAATzGCHOdX1QuA740YV7eaNDYyx2WHGa/3AurbJsJaJ6AdHHPfn08GOV1DvUHZMiptbnHo/709g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6036
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 27.01.20 19:15, Junio C Hamano wrote:
> Peter Kaestle <peter.kaestle@nokia.com> writes:
> 
>> We have test coverage for "git submodule status" output in
>> various cases, i.e.
>>
>>    1) not-init, not-cloned: status should initially be "missing"
>>    2) init, not-cloned: status should be "missing"
>>    3) not-init, cloned:
>>    4) init, cloned:'status should be "up-to-date" after update
>>    4.1) + modified: status should be "modified" after submodule commit
>>    4.2) + modified, committed: status should be "up-to-date" after update
>>
>> Case 2) will be covered by this patch.  Case 3) remains uncovered.
>>
>> Test that submodule status reports initialized but not cloned
>> submodules as missing to fill the gap in test coverage.
> 
> Thanks for an update.
> 

Sure, welcome.  Will you include those patches, or do you need further 
refinement?
- Thanks a lot for your guidance and mentoring.  It was a pleasure to 
learn from you.

-- 
kind regards,
--peter;
