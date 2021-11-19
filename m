Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EAFC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 09:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7238461101
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 09:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhKSJDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:03:43 -0500
Received: from mail-vi1eur05on2051.outbound.protection.outlook.com ([40.107.21.51]:61152
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232274AbhKSJDm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 04:03:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8UrHj6Dt3kYug/8vfbKJE1ULgdD+MAQDk9vgPA3nUbl4RVKgecMyQqztH6tDl7A5RYyqYaoPyldri5qKy7NDjK6ZxYs50p2GIwIbCaoBIQZkPkRk1ZlHCR6Vl4mgL9NIyjbz8jJdxZ+duWEYEPO8cSZ85TloqDC6viWK3pQ4HJeKakLprrNrWljmMc5rbHFTuSHVuh7VL8RS1np6TF7wxMeSnpXIr10Mx0ED+UI+xdGT8OrmS1gqr+4+GyPUOnTfn2PA4y1nxmJfG7YvuOb3OJl+lvqsIlAsLmx7xb5lNKrWCdWpTMhuJ/EndMO4QrbLTJvSC7dl1Mr6ahKaWqxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yW7YvTys9pmlUoU6ozkUgSP6n0saCabjD/f46iLtfLI=;
 b=OcWhrxOjO5R6uLp8mUgUL8zBXuMqxZ/vDUSBWhE6a48N6a01+ShwilI9c65IX2Sfgy29/D/x3AUQDJfZR3zuw94qKvTBZjAsRoMSItfv6yk3CGVhi8rcBcxWXgFu0R8QTvzTh4OjFOD7sOWys0jCj2uqLE0I0c2yREwYlAMpV6g97121SMubqX0s+ZJwbz090qSRoW7bhEDksgWkUgPTMmrf9QI2CvvbiFK5qbo1vKneLq3DIpr+wxzjyyzTj6dzQqRmJQUX0Zn1SiQ/OqqUeU4HHzjpY8rqX4S52MJt93Ezr7D4fLzivg8l7jtE/RLFhaXXaPVyFifnng0bTuIBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yW7YvTys9pmlUoU6ozkUgSP6n0saCabjD/f46iLtfLI=;
 b=BU+4zjPPvlIQFlnPhfflF95DG5zjI6irIwElGNo5obixK6M82Y+DlqZAsoD1YJYKraD8aSh50CS/cu+3noJDGA1WLEVmAn5eNXB5iwiTqOU27yUzKhO+xNCqt8mY/ISRHovGrRSSwU1pgp6Qsu0iu98fR9s+QGlJYsO6HO8dfc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4287.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 09:00:39 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Fri, 19 Nov 2021
 09:00:38 +0000
Date:   Fri, 19 Nov 2021 10:00:37 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Thor Andreas Rognan <thor.rognan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Ambiguous verification response when ssh-based signatures
Message-ID: <20211119090037.m4zfzovaitfj35l3@fs>
References: <CAMn8hCcFLR-YyLaawtbtjpVUKd45Z4C6t1kWj+-WBZVNtNgozw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMn8hCcFLR-YyLaawtbtjpVUKd45Z4C6t1kWj+-WBZVNtNgozw@mail.gmail.com>
X-ClientProxiedBy: AS8PR04CA0162.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::17) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8PR04CA0162.eurprd04.prod.outlook.com (2603:10a6:20b:331::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 09:00:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c82e2125-c21e-409c-c115-08d9ab3b0e99
X-MS-TrafficTypeDiagnostic: PR3PR10MB4287:
X-Microsoft-Antispam-PRVS: <PR3PR10MB428777FB1B1E73AC8CBC99B5B69C9@PR3PR10MB4287.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wh3Yw0JlMrkGsaIWX0CAmkH6shHaGqQazzYwPQf11np30u11Muqdg+AOipZDajbUjrr24hSLbBSKUZsvSE8DWRPum40eiKH4WvmcavDNGbg8ePrXo3Wfq5czRVrD4QuA+C673Q48L3+9TvEjof3SvDzY3SxinUlThg0nOBzVAQOGJMzD7D4wsYNZyJkqQAAv3Yl7cl0AgVGLt+03ttOwbzm/JBCyhtb6OlYTBbXcu4hZA+tK60WaDAI7PxBAjVyVY7lmv3cxWd263iBxJpqb5EjCGva/oi25WvQilSWhO6RsbUiIYiDH8Y0/QWp62moUkBAncn0i5yPH4yeBPqhj8yLi+F7M7Vhpn5Wuea0SoG6+makELwwNYyZ48xoBQZ8MapgRVgwgWkKbItrwi9kgKBIQdbSThL24J/OPFKrmm66hSEBKNlNYGypTcbGHGKFwKr5EXqCekjjgO8bFijVDACeNy9M0rP+XgIU8pLYnMBO0+1jS+lPyu5AFgjRj03ar6W0v/wQmjbJTeMphfbAQUTSDMzC+tXf7t5ugSLU9r+Ec0dj/XK5QB/uPsY2FSXNvcqEEY28fAY0FJOm+GR2Md+LLNnpSU8wGWvyA978+5w6HBOoGfp3xOXyj4Mem+2aiP3rZWePhEzlEx1fEb2ZBjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(396003)(39830400003)(366004)(376002)(346002)(83380400001)(52116002)(6496006)(66946007)(38100700002)(8936002)(6486002)(8676002)(9686003)(316002)(4326008)(5660300002)(86362001)(186003)(508600001)(66476007)(53546011)(15650500001)(2906002)(1076003)(6916009)(33716001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVlzNXFwek9SR3JrZWgwQUlLTW8vOHRDWWhvZklNeUUzU1dJWlV2SXk0RS81?=
 =?utf-8?B?N1M0WGRCWFZqZHprUVJnV0k4andRTXdpeWxmcXAxbEZXZ1VJY2puM0VpakpT?=
 =?utf-8?B?TzFUZXhZYlpsMEJLVktlNVBjTmtnVVJaYVZlNVo0MjFLdmNoL3RhVk5wNThL?=
 =?utf-8?B?TUdEeHJleHlJMmt0SUZYU1FxdmZEbFZWMmt2L29XMXl4RkUzZ3oyVDZDay9v?=
 =?utf-8?B?cmthV1h3TUNhdmFUcVJwMW5kSkdiK3JMVnNzT0I5NGdIZHpnUkwrTWZFRzV4?=
 =?utf-8?B?YVVicHhHWHlaNDBPdWgyU1paNnNmQ2RRRFVsdTRqN2dSdm9QWjN0cnYwdkxs?=
 =?utf-8?B?QzVPbjRDczh5eGVoMUg4b1M2QlR5RDByT2E1eGVXUG5Ld0o1Zm5FNWp2eU00?=
 =?utf-8?B?RkpvOWdLMWxzSk1Hcmc2Y2s0OGIrMzI4bEdUejl0bm5GWjV2M21ZU3ZOOVMz?=
 =?utf-8?B?KzVJVnVnMXBMM3VsY2dvVVkvZHdQcUtSWDc0NHVYTHBJWDNTRWsrRlIxbUlq?=
 =?utf-8?B?ZElTOXZ3QkJIaHI3WXVueWVVSVJiMEliclJURExZcElBQ3FNTVBRNmRWM0Jx?=
 =?utf-8?B?dVVIcmdGQ00rNEpmajdMQ0dpcHR6TEtXTk0zWG9vZkxSMWp4dUMxYnZ2c25X?=
 =?utf-8?B?d2tWalQyQVF5T1c0QTMxcVNUMlo2eHlCYTh1TStwRGswSU5KYXBMcmgrMXA1?=
 =?utf-8?B?VWh2c254L0dVaFBibXU1Y2V1NmRXSnZZbkJ2NldLQ2p0cm45dGREcllOSnZ3?=
 =?utf-8?B?aGlmRmtFQUlKYlBUREs3VjJVTWtYSVJDNEgyZnRQQkF6UGxzam5wUUdWODBa?=
 =?utf-8?B?MDUvMmRPRkUyOXE2ZzBBT1dWeEVTNkVZclAvSVFYRDBDczVNOWxsaDFRN2Zj?=
 =?utf-8?B?WE9MY2ZnNE9uVjRKK3FwdDBYNUpKZXE3RTgrc1JGZGl6dWxPbFNwVUs3OEtY?=
 =?utf-8?B?bnVzbVF1YWRWZmNYQTJXMkkvMGlUaXl0N2J3ekoxaVdoOTQrWFVPNEkxR2dr?=
 =?utf-8?B?T1NHdFRTUTZDUDlpN2xEdEx6TUVCSkw0MDUvR2FJK21VMVlNSWs5Y2c2dnZT?=
 =?utf-8?B?bnJEcmxldytuTER6cU1mQVN2OGJGbCtjRGllMVU0Nm13RmJ6cmFaSlEyNWFD?=
 =?utf-8?B?aSt3ZDh1RVVJWm9TdFUxZFg1b2VzNlQ0SzJObXNrQTRIRlJ0cnJYa2pLS1Jo?=
 =?utf-8?B?am80QW43MjQ5UTAya0swZDNjOW9EWXNQaUNRZEhUVjdaWVozTytmdUpZZEgz?=
 =?utf-8?B?Mkxxc3djYVgwbEw2UDN5VVMzOVBDT0tCV1pEeWp3NWczcHFjZ0FJZ0hxa0tB?=
 =?utf-8?B?dnI3OXNpVElqeTZJa3NoN1JMZFh6aUNkSEhOdit5cVdCZklhOSsrcWhXaW1C?=
 =?utf-8?B?RkRKbFFsbEErVVJ0cmFJeEVQdGs4VVRmVVRJdjhuYm1EQ01Ic3UrS20raTd6?=
 =?utf-8?B?OUk4WnF0bTFTbUxsb2hYUFBVNU5DQldZSkkxSEZXdkpZUlpRL0dPK0U0ZXlL?=
 =?utf-8?B?djE0bFpzRWhyUUxuUEZrYldOdHQ0RDY1ak5lRWJ5TW9tU25jNGZNTE5JUWho?=
 =?utf-8?B?clVaenBic3RjMFVQQ0dNSGdlUnQyYWJvUGdkSk1UMDFkTlJ3ZzZ3WlNhR3lB?=
 =?utf-8?B?LzM2dUFGdUhVeHlwVGRpb01pNmhQMnZoWU5hLzlqZTlOb3FqaXRnVnRsUEZi?=
 =?utf-8?B?aVNhSjFSRUhUU1FYME5lWERDRUFIUjEvaGt0L1NWQnZzaFRHOXh2ZXhiMkpt?=
 =?utf-8?B?cHJXSFdZSjQxdk5SV3JzUTBWY1VwRkZ4Qkd2M2xYOWhpNHNDQmZKVWZMSXM0?=
 =?utf-8?B?amQzbmRLemludjdGWFkwS0diZHR2SXYwRkNwSmFlUWVCZEpSZFpZTjJyZnpU?=
 =?utf-8?B?aExZbjFEaDNDLy8xS1BjT3V4eWoxRW1BdnhSOEQ2UHdSelJLK2NJTmRwdzcw?=
 =?utf-8?B?RmJUeTIzVVdyRXBzVlFGanpvUjBiTzdWRm5TazJqajE0ekV6eFpuL0gzalNR?=
 =?utf-8?B?RmtjdXBVN3F5dTB4K0RuYkMyTm0xbkFWQXNsZEM1SFpXdEF6ZkJPdzQyQ1Zp?=
 =?utf-8?B?b1Nua3BUZ05valNzbGtYZnFqR1hDZ3JtcmNESk5OZXdubXR4cW9xZi9VcWQw?=
 =?utf-8?B?bCtSTmZTeWVyRDR0ZHJNZEpBNUg2WGlSOThrV3oyTEkrV0VFb1pnU3dueVQ0?=
 =?utf-8?B?YnJVWVJ5b1NCYWs0WFRCdC9WWFZLSXlFNGE5TjRUUGFJNTliVDlVWkUxRGl1?=
 =?utf-8?B?ajdWeU1UUE5FY3R1eCsvUU8yQXJGa29DSmtEaXlFak11NlYwaythakNSQXlP?=
 =?utf-8?B?VTBuYkxEMENtdW91bkZ5RktPOFZ6UkNvUDcvS1Q2TVdPeTl2ZGl5QT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c82e2125-c21e-409c-c115-08d9ab3b0e99
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 09:00:38.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5pBWaRq3GAi3Mkppsvo0vYGtZ+YffNE1drl9OZScFtBsk+K6GUSz+Klu5XwnEuQiE2qbJ82gXIebRhh/ow3H37mMi/zH3as0ioNDDKxgCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4287
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.11.2021 03:46, Thor Andreas Rognan wrote:
>Thank you for filling out a Git bug report!
>Please answer the following questions to help us understand your issue.
>
>What did you do before the bug happened? (Steps to reproduce your issue)
>
>$ ssh-keygen -t ed25519 -C "me@example.com"
>$ mkdir -pv ~/tmp/example && cd ~/tmp/example && git init
>$ git config commit.gpgsign true
>$ git config gpg.format ssh
>$ git config user.signingkey "$(cat ~/.ssh/id_ed25519.pub)"
>$ mkdir -p ~/.config/git/ && touch ~/.config/git/allowed_signers\
> && chmod 0600 ~/.config/git/allowed_signers
>$ cat ~/.ssh/id_ed25519.pub | awk '{print email " " $0}' email=$(git
>config user.email)\
> >> ~/.config/git/allowed_signers
>$ git config gpg.ssh.allowedSignersFile "$HOME/.config/git/allowed_signers"
>$ git commit --allow-empty -m "Initial commit"
>$ git verify-commit HEAD
>
>What did you expect to happen? (Expected behavior)
>
>A verified signature without any error message.
>
>What happened instead? (Actual behavior)
>
>$ git verify-commit HEAD
>Good "git" signature with ED25519 key SHA256:...
>Too few arguments for sign/verify: missing namespace
>$ git log --show-signature
>commit 4697b474dd5ec0de14870d5b0eba5f579b852bbd (HEAD -> main)
>Good "git" signature with ED25519 key SHA256:...
>Too few arguments for sign/verify: missing namespace^M
>
>What's different between what you expected and what actually happened?
>
>Ambiguous signature verification message.
>
>Anything else you want to add:
>
>Please review the rest of the bug report below.
>You can delete any lines you don't wish to share.
>
>
>[System Info]
>git version:
>git version 2.34.0
>cpu: x86_64
>no commit associated with this build
>sizeof-long: 8
>sizeof-size_t: 8
>shell-path: /bin/sh
>uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Mon Aug 30 06:12:21
>PDT 2021; root:xnu-7195.141.6~3/RELEASE_X86_64 x86_64
>compiler info: clang: 13.0.0 (clang-1300.0.29.3)
>libc info: no libc information available
>$SHELL (typically, interactive shell): /usr/local/bin/bash
>
>
>[Enabled Hooks]

Hi Thor,
thanks for your report. I'm curious why verify complains about a missing
namespace. This parameter is basically hard coded to every command :/
What version of openssh are you using (ssh -V)?
Also, could you run the sign & the verify with a `GIT_TRACE=1`?
This way we can see what the actual keygen commands are that are
executed.

Thanks,
Fabian
