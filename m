Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7F1C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 11:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5616761882
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 11:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhKSLK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 06:10:28 -0500
Received: from mail-am6eur05on2051.outbound.protection.outlook.com ([40.107.22.51]:18561
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229521AbhKSLK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 06:10:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WphkPcursCC2b6J4lgU0YhvD3OQtl6oicPpjVNakiZx2bn2xE3yxBaypNxratnwrBkNDlrM6jXC7s06prOwRXXiYd6ioNxzKVjmWzywsMxbpAqPFi3Aw9/h18oVquygBzn9liJjyfk/Z1xK/yYgiTpSZEvGt4sX6WxbzhIJ+Kgh6zf56VtDMvKEumuptgJQUNRgKhSYeblHTwsRz79vhBRdKhWZ6WPieO2SmEiGFh9SyJ+nIrrpomhrEFl0WhdpuoJkkU/+q/23bRYq1chAm/yp7jqtMS+RY7urd4YMEGtCRfvKn9X7R8rNFtY0UH4JqxC2a1kHEX/RY6sr77NX8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D+HRiOT+W48yjWV6a58u24KgmmPyf06tyJcX3iEAR0=;
 b=ZfD5HorQIvf60DN1LNWQxhnCLOy1BZ0vUpVm2s6K872I2Zl9seJyZioWOHwxWVn6wWx6YVnAldAW1GEmJcFZExo84msyyrgKfJcgdTZX+Dzwyoquihysmz83hVmz7skaY3os7lBVGI6TK5vbWYWnYvPElj7rcwnRmWQv/ogsVCX5G8YgwZq7Eb7Vd3QYBug4qLTVhpVvzt/MNgynw+pWPJ7iabGkqTvqXLJXln/rfKWckh74ovwc6cJd3rg+1qVvgk1AdN5j85CEfTfNTSliyG7wbLVfOru5/TM+CH47aKWZOlTp+AgBnwppEnJn3wdFsE1iV4nJatvyE0iEXYbFxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D+HRiOT+W48yjWV6a58u24KgmmPyf06tyJcX3iEAR0=;
 b=UTYdHXLabztUyhyfCJviRQdteSgX4R09HgQeCvhh1CCc8wfZVFAlgOqzAbPwkKkgLNdoMXTBGzf6CD+2W2c+5nW1Sblmf2ogPjnQykxz+R7HFw7j6tgSvUp/m0jBgd45WNzScFh+k04EvXwcJJfDAYlmkzm/pkd/iNhOkI4fnUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3802.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 11:07:23 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Fri, 19 Nov 2021
 11:07:23 +0000
Date:   Fri, 19 Nov 2021 12:07:22 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Thor Andreas Rognan <thor.rognan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Ambiguous verification response when ssh-based signatures
Message-ID: <20211119110722.noxoecfk5zk5hssv@fs>
References: <CAMn8hCcFLR-YyLaawtbtjpVUKd45Z4C6t1kWj+-WBZVNtNgozw@mail.gmail.com>
 <20211119090037.m4zfzovaitfj35l3@fs>
 <CAMn8hCf1ypU4Bwt8bDgai86QFTdORPyaHiE7W+=tx_rKbchz4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMn8hCf1ypU4Bwt8bDgai86QFTdORPyaHiE7W+=tx_rKbchz4w@mail.gmail.com>
X-ClientProxiedBy: AM6PR08CA0014.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::26) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6PR08CA0014.eurprd08.prod.outlook.com (2603:10a6:20b:b2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 11:07:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78527afa-5842-4caf-2fc8-08d9ab4cc357
X-MS-TrafficTypeDiagnostic: PR3PR10MB3802:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3802F506C05FBC05B31CE8A1B69C9@PR3PR10MB3802.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LuZdsYjPPSesd3FnX1N/0gqNAx0K4bGwrfdoP9iDYog31OoNypYGtN/4Ug3Y8isEZgh42jNUbdLiVGkfCoBmixlc/LSuQLNMxWENrp6Oa8d6hfkRkY9tpDEojD00zpiqg1EtjG0WgfWZyDQAhTme8igsYaLdIPxleUbFt+pP01tx5hqr/ns46xCwGnIPF4MBmVwnfX9AZjL2y79z/53qqZYRZsxvYq08eExhlw+Oh4mVERDaJW+Zq0IHwyAA/w8cAf3iAqlzLVON1dsv4l1vu1mvLN+44bQqngfhKpgc5OG+Y4FHsQg6XdIcYb0OP63UJktaWdpnraO4DFsmhxmFXR6vL09Te7jvXW7IViC5cHOG6TqevCTbURshnD/uhKci4PmUuvHQXjHPW4wIb4wvwZA+Jt8VeLeWmnn6aHEDf42wBY0/u0b6C4HsgBoqtv5ysIqd7g2ahR7Jz1VmoeD3n1ytDaJ5IT5JAxM1B5RSDyryBqI+AhwbvyUPzAoGmlDVhZQndmIj/Dnb4lXC2oNyawDgoGXb7HqIzME8vhSVxleuYi/7LX1XzMx+Jx4KsJtYew1eOhdVF0quUGDbTntd66t4PCLzeuMwJPlsIIT2UeWQ5TFjFHLdqRYQVzfXr9WU4IX5h5R1ZxvNyadJ7jAqyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(366004)(376002)(396003)(346002)(39830400003)(66476007)(66556008)(53546011)(186003)(6916009)(8676002)(38100700002)(9686003)(6486002)(83380400001)(33716001)(316002)(8936002)(66946007)(6496006)(2906002)(508600001)(4001150100001)(52116002)(86362001)(5660300002)(4326008)(1076003)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFFNT01JTmFCZTFIL3pKdzlPN3NBbE9ab3NLU1BpZXhmOHY5WWRnanpuVkNH?=
 =?utf-8?B?ME11RzVCQ05vSHRHLzlkV1J4aFlheEtUQ1dDQzdRbHdNMzRhdXZzZUNQSXFJ?=
 =?utf-8?B?b0lkQWZrMFcwZ3g4b3dTZ3g0L2FuQTgzQ1pkTC9xRytDUVhITEY3OWtIRnkx?=
 =?utf-8?B?T0xTNno4ZEdtUHBqaVcrdmJzUEJWWnJUWml3amwzUXZGeVk0Ymhydm5QSlA2?=
 =?utf-8?B?OEVqTHRFbkV3K0FHZ29ETzNuKzE3TjluVmU0UkFXck1yc254ZDVBNHIvdGht?=
 =?utf-8?B?MTVBYnRRbXhvSExYSldLNXBnQ0tySkVWZm9wa0dXM0VuWlVySDN4NlppM2FF?=
 =?utf-8?B?U2w5a1VXbWlhUGVwcE1WOGJJNVhGamVmZGFqbVVsbXh3M00vUEhYcGxXdWk5?=
 =?utf-8?B?NXhDYjZ1eDlrR0VHcm53UUEreXVLWWJLVEE0QjI1d3l2K3lQOVdyT1J1TCtR?=
 =?utf-8?B?TnFCcTlpSHpaNFpQYXFTcnNYR3pZZ3BoeVYwR3lOdmZ6SG1VODM0RlE5bWRB?=
 =?utf-8?B?L25UVEg4dmY4cm1GdytMRCtmZ1hmYTNKY2Z5aFlyT211YzIvVXptU0lrQlFm?=
 =?utf-8?B?SFdGcFFodWtIZHR6Qkw4Z2JYVS92QnJKNU15VVBmZm5ndDBnRUJtS1dGSVlx?=
 =?utf-8?B?cndac0FBRzFVS2tuOTVSd1I5YnNoakE2dkxkMnlsRjhFN05zTE12ai9aYk54?=
 =?utf-8?B?WXNEaUwvb1pZWU9OTkFOeDk4UGxiZGJ6TURxM0lseDhSV0JNMFBNcFBVaHZ5?=
 =?utf-8?B?WThvOXNXSFNRY0dQVzNWTHNCdUF6WHI1MFVTUG1EN29MazVxdjF1Yk5NM1Qz?=
 =?utf-8?B?MW9lZmF5Nm5BRWkrMWIyT2wzTjFFZFVJV2wyQkhOQW8va3hWSkZrcmE4blVl?=
 =?utf-8?B?aVI4Y1RZME1jTEszclR5ajgvWThiVWxVRHBROEpRL1dwbEJnWldsaGY4Vldn?=
 =?utf-8?B?dE5KbnlOdjNoU0lVVzFTQ1F6S2NDYlVZbnJUSWhIbzZWSmUzb3ErRVpsS3ow?=
 =?utf-8?B?SUk0djQ0ZDErUXNSN1dGTXRROWNSdXR6anQ1VFlVazh2MENxZy9yeUlYS2Jo?=
 =?utf-8?B?SWNzNHMyVjcvVEhxV3NDNGo1RHV3eTZ4K2YyNUNmbTJzOFEwa3dWWi9leTJo?=
 =?utf-8?B?SzNpcGU3ekExZjRBUW95eGgwYXQyMkpiMUN6YW1pUTNQVzdSZmU3ZjJMbEdQ?=
 =?utf-8?B?ZTd1VkdTSkV0THpxZHgyVGV2cnF0eHNsYzFtZjhibzV0VDBWdGF5UHljVWJV?=
 =?utf-8?B?SEFjS0xvTFQ0a1RlaHg4OStaSkZyMTVEZFlCNWsvSnRiQXIvZTc4T2FvM3BU?=
 =?utf-8?B?S1J1OVg0eFprT2Jjalh3WG9idlpVK1FpcGdsa2FIVlRNbHVsMitQc0dweFBE?=
 =?utf-8?B?cDE5ckdXcVNnOE03aWFkbVRnVGh0a2IwWm1xSlh5VEJKUG9lYk03SjZlU01G?=
 =?utf-8?B?VlBRY0dqZEkzbzNRekF4WWFHYVBySWhPU0h2YWdBbGFwUXdrVDY5OW92a29M?=
 =?utf-8?B?dGZoZU5ObEswemdTdGdlWjhPSU5JbGFLbFJUclRkY1V1UzFMMWxBUW00NDFC?=
 =?utf-8?B?a09BWkJhR1hyTTh3dVFwQklGSGZvK1V5QnVudEw0SzF4MDVpWUNoT1BVbitz?=
 =?utf-8?B?cmt3QmV2cFZLNERDcXBTKzJLTGZZVy9FZXJ5ZjZWYzRvWFVLZk8wTUZOMlZE?=
 =?utf-8?B?c2hod2JJcW5ITkt1dWVIZCs1dzJGS1R5c1BaYUlVUzFjSlNzRnB1Tkt0bE5q?=
 =?utf-8?B?Z2RiTDdCT2IwYmFLVUtvRFI3SWlUcHNoNjJUZ0FwNURBUGtlWVFhSmRpYTlV?=
 =?utf-8?B?Rk9LZkp4QktoaDFFSHBOSGxJcjdUcDIyWHRoQ3FHV1JPUnZQeGFDc0NuOERa?=
 =?utf-8?B?cjNYb3c2WTJvMGx1YkdVZmRnM0k2YjB5azVtR2NOV3ZIZnFzWWlpS2dyL01D?=
 =?utf-8?B?RTM4UVJmQ0ZxbFcxTUFQQmE0b0d6Skx3U1R4dnUvNmsyQnJYYlZIZmhBRXl5?=
 =?utf-8?B?aENERUdOUlZSMXg0amtmUU1TK25Td24zaWZNYXVYaG92ZWpaTGZpUTNkeC9D?=
 =?utf-8?B?RURGcFdUYk5PTFRsQk9UZmgwaks5cmV3WmZzbFhwUGEvdmxuekZBeEovbU1Y?=
 =?utf-8?B?VVFOWlEyVi9qWUtMZXJrYnJ6Vm8yTVc2MGUyUFZ6b1NyTWhBcnlpQThHY2sw?=
 =?utf-8?B?RmdyTS93Zm5oRGpxeTIyb0pmbjh2VnY4cG1McVcwam13VlNnLzZjUUhlYUZ6?=
 =?utf-8?B?d1Y4Skd5Qm9EY3BxTHUvcGpMQmo0RWZTVmtPWWY0eFozcmU1ZW9BU3pSRGxO?=
 =?utf-8?B?RnZtaUxxdmloUktCZWp5NHFNNHJMV2J6dWJId3dSL3U1NFY0cE9zR0VLTEth?=
 =?utf-8?Q?M+fLuX2lOzR9VMC0=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 78527afa-5842-4caf-2fc8-08d9ab4cc357
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 11:07:23.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfGrOc6jZpe4vlAe3bGkPjIyDVJ7wDuN59nMBvJObfTwqcGmyMPsYUrwYzSj5kh9VlkOa6m0OVWfOkv1oWzva0KceZ2HiG1SVGV7jpYFvgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3802
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.11.2021 11:26, Thor Andreas Rognan wrote:
>Hi Fabian,
>
>Thank you for your quick response! Commands and output below:
>
>$ ssh -V
>OpenSSH_8.1p1, LibreSSL 2.7.3
>
>$ GIT_TRACE=1 git commit -m "Trace keygen commands with GIT_TRACE"
>11:13:49.771601 git.c:455               trace: built-in: git commit -m
>'Trace keygen commands with GIT_TRACE'
>11:13:49.776095 run-command.c:668       trace: run_command: ssh-keygen
>-Y sign -n git -f
>/var/folders/jj/sfgpggbj5b13gvljxf977zq80000gn/T//.git_signing_key_tmp1FkZ52
>/var/folders/jj/sfgpggbj5b13gvljxf977zq80000gn/T//.git_signing_buffer_tmpBweN52
>11:13:49.814072 run-command.c:668       trace: run_command: git
>maintenance run --auto --no-quiet
>11:13:49.819952 git.c:455               trace: built-in: git
>maintenance run --auto --no-quiet
>[main 633e567] Trace keygen commands with GIT_TRACE
> 1 file changed, 59 insertions(+)
> create mode 100644 git-bugreport-2021-11-19-0311.txt
>
>$ GIT_TRACE=1 git verify-commit HEAD
>11:14:40.274423 git.c:455               trace: built-in: git verify-commit HEAD
>11:14:40.277417 run-command.c:668       trace: run_command: ssh-keygen
>-Y find-principals -f ~/.config/git/allowed_signers -s
>/var/folders/jj/sfgpggbj5b13gvljxf977zq80000gn/T//.git_vtag_tmpEI3SAu
>11:14:40.284075 run-command.c:668       trace: run_command: ssh-keygen
>-Y check-novalidate -n git -s
>/var/folders/jj/sfgpggbj5b13gvljxf977zq80000gn/T//.git_vtag_tmpEI3SAu
>Good "git" signature with ED25519 key
>SHA256:x3FRAl3XR188M9KR3UE+TuG3jkZzPQMjfBo+ddbM0dk
>Too few arguments for sign/verify: missing namespace
>

Ok. OpenSSH 8.1p1 does not have the required functionality for the ssh
signing feature. Normally a git warning would trigger to notify you
about this. Unfortunately it seems as openssh introduced the features
between 8.0 and 8.2 and exactly the 8.1 version has some of them but not
all and does not produce the expected error for the find-principals call
:/. I'll check if can do something about this and print the correct
error.

I'd recommend to upgrade to the latest openssh 8.8. If you don't want to
upgrade your OS version you can install to another prefix (e.g.: /opt)
and point git to the newer ssh-keygen command like this:
`git config --global gpg.ssh.program /opt/openssh/ssh-keygen`.

Fabian
