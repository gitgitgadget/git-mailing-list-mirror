Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046A3C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 14:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352640AbhLCOVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 09:21:51 -0500
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:36319
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244958AbhLCOVu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 09:21:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RX285dlAECkDTF1jpddX49ldOWeBzok1cMtWdV9knikea7j7wUrqzuQe6xNkz15+/vTBDQhp9KdnPTYoK0WFah7S7Y/OLluk/kzYmw2dKzE85GM6IB76bGvkcuvgvFtSajnNf1mNpgo3hZ9woeTnkphdOGDi8f3yb+h7e4xT3SfoD9IS0TYkydbOevRZUlOgKJg64z4AQM+InSskcl+R7y+D04G1kdOhTCBayzbglIX5AlsQ2wYqe68jsdsO2Uy1dAt/9YVwKwb8oq2NjeLrXit4O3yvCK9vdPj0iYQu2SXXu5LBaNdW14DdWgGMj5/UA2mL06UggW+KLbUrimyWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LjEMkvsuk1j2UdNk03aUfhOvm+3by0TyoRwBoiVGQ0=;
 b=BSDC5gEyPlPRsTDigfn4//EfolzAvMYQK/B8syM4Yca8cPtAf5aEYByG+85nKyxI3Cby1viSuF8f+1c7hTspgEQsZmQdLDWQxyFwy52xVtcEtM9P9safqw4VEhozeWxgl1bcXjc0gkoPbWXq40gq0owYRFsLXyIjBhR8a6fyG9pDZhfPOGu2DJFl96TE8Ye/wJJ76ANilt2TfI9LprlvY3PI6xAzBhrCtOh9KvZh/m7UqL2fCDwSMoyfC1s9T4dZ239OtoOZtsB9b2eNAMtPnDxfUKCnUA8uYr/Iz4Ul1QjZWArC5xZnX2FZR+ab0555W2j3SuUDx1u37flwWhtYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LjEMkvsuk1j2UdNk03aUfhOvm+3by0TyoRwBoiVGQ0=;
 b=WhB/rF0roKKdDDJmrBzqiBVkOdGgkCKi9fM5eJEhfwWb/f6IwbiDkknRYGvCYsWFU8Kj6ISN0MWs6uCEttv0AnOCVBhe/MRvxMiQn9cviPaPYH+8WGOm6zB+x32zlDSu1vczJ9z83i4ImQmM3cqzm7A7T6B5m7xnUC1fR/kFpXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4398.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Fri, 3 Dec
 2021 14:18:24 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Fri, 3 Dec 2021
 14:18:24 +0000
Date:   Fri, 3 Dec 2021 15:18:22 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        pedro martelletto <pedro@yubico.com>
Subject: Re: [PATCH] gpg-interface: trim CR from ssh-keygen -Y find-principals
Message-ID: <20211203141822.w3d2poeiylm6zpf6@fs>
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
X-ClientProxiedBy: AM6P191CA0033.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::46) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P191CA0033.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Fri, 3 Dec 2021 14:18:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1552715-4648-42d1-4c94-08d9b667c456
X-MS-TrafficTypeDiagnostic: PA4PR10MB4398:
X-Microsoft-Antispam-PRVS: <PA4PR10MB43987F613CABE1E4E10A1284B66A9@PA4PR10MB4398.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vmmk3CbRk8sv6ZaUCzXe1KSZZ2sWvk6nx8YpXcq0VbmWL3pGXXCZYRjPXv5ERG7RgVS4fgcwMTop9duvZ+IylWgCzvMg/QQQviXcUcCT0E+uJo/P2bcrjKIK+G+t28bun2vW3KsH2/pqIrbEuYaM3MWXQfqbST3vS/VLU4O6giO+pWWeRenMA+hEEjiabu6ckz23RP8jNRY1fPNto53WNE/mCjKQJwqIH5Tk7Vz35l94Eptgsjc9pHqRkOpr9ASlmB7yvO2FAMBWR0fE7UjoyY7UtPFkAMtVjNHT4B7sfi+ZgSXzIGvukzvF8geWlTijrAf4z5SCpYOXh14UeF/NThl9XA4CYX3FP8CQx2wRNEJwLMCQj2G2SFzMIIcydc+gX5z26rnB1112sTy5FJZb2JazPaJhssc52Y7X+O7B/UMOATE1YRjUM8wEicRYMa/rkTCE5g59sywZPaX7XvP6lqNNAkR4RmfV/ExW7tsoWqJ3lQ5WbgzjQR33pGnFSnbIOXVCk2FQ3sNYVTlhE/wlU3Bfryt7BtrOybnrJcAvOQnpxmkz9+C5ZP9H46a8KAvpKjP/wFAcbrs1IjrDpz6u4jutxF2N5EOkuwaD5kcLszzsS1ToriBsoVPBFq62aU1jEF99I/fLqjD21yiE0fIuM+Gg0+MeqW40c7yZBx3qfcwnN4HMx4njyOLKc3t3L/YI3Hajx8na6TDSBYd/SZFQ0czPBTCO/3KL6ZZKaypadlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(366004)(346002)(396003)(376002)(39840400004)(6916009)(316002)(54906003)(66946007)(186003)(66476007)(966005)(66556008)(4326008)(5660300002)(8936002)(83380400001)(9686003)(6496006)(8676002)(53546011)(6486002)(1076003)(86362001)(508600001)(33716001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW9wdkRSb0Fab2ZqZ0M4VDlYQlpOUFpZbGhlT3JDY01XaHd6N2hoUFpIekJG?=
 =?utf-8?B?aC9WVFZWSnpLWkhkYk94VDRKZWJOMzRSaDYrYnE1MWdxWnVqV1VERXhKYm5I?=
 =?utf-8?B?TWtiL0VPZ0FWWTgwRmYwSmg2aDU4U2pDcnBiZ29jeVF3aENrZmswRkVOb0hq?=
 =?utf-8?B?MWY3MU1rMzVpT1IzWk1WYThoOVpDbzduWVZpZ2JFZEVOYVp1STRTcDYzYW1r?=
 =?utf-8?B?K2FHWGtyYkNQZFFHbEFjTGZhTW5BclFPV2xhQjJBcElYM1lpT3NLM08zcFZv?=
 =?utf-8?B?VllpakR0a2RwbEUxQk9zblRuSGtrQllnTFVyQnJCM3luUU8zNmZacko0SjI1?=
 =?utf-8?B?cnNxb1dVQmF6VThxWkNNSmtTa0pEZGxuZkZBQ0dNTFJnV3p1YlhhQndSQlU1?=
 =?utf-8?B?aXRwYlZXSXg5L2syZngzbTdXV0U1MklGU2d1ZWprcUNKZ0Z3TkVtcVEzcUxt?=
 =?utf-8?B?RFZmUS9VSm1zMHlJUG5LWDllK1hvckVCc3I4S0ZFK2xpQlREMlVod1VtU0xu?=
 =?utf-8?B?TThlM2NobGZVTkpQK1lUV1lHZlV1UzZ3MDZyejRPbVJrMnZZRWlwTkQ5REJk?=
 =?utf-8?B?aWpUdG5ueGNZZWVLbjRxN1l5dmhmc3VYYXRLR2FDTGJ2S25WSDNIRyt0aWZn?=
 =?utf-8?B?K3dxZXYxWlpFL3IxQkJkVW96YzVDK0FMeTNVemhoNzNHeXQwRm1VUzZYVVJS?=
 =?utf-8?B?UDM2NDIzMVZ6REdTd3dxRDRMQ21PaWZPMnZoa1lBQjhYU3V6OWxCUm9uWGdH?=
 =?utf-8?B?SzJRcHF2blNTUGtpWGVrWDlpbVJEV3R6M1AxSW9Fc3JIdlg5OEF3R3lrblVz?=
 =?utf-8?B?S2E0TVE0UFptMTJNMnRpbnhBUHZOQ0FhdTZncUY0aDlTY2hwTjZIQU54M2tQ?=
 =?utf-8?B?SytPb1RkTG5vWUxoTEdoclkrcmJHS1hvZE8vL3JPdk5peHBaMVpzK29kR2Qr?=
 =?utf-8?B?c2dhUEk3M3Zrc3J6M0YrQ25FSE82STdLOEZXT3VsNUJxRWJab0tmT1VLS2Ny?=
 =?utf-8?B?YnVGa2M2ZE80bkxHaHFsWWIyQ3ZDLzNqMzM4TjVjYkU4cUFLcUJMZDZkckNS?=
 =?utf-8?B?MCtQTjVRUXE4WlJIdEJPcDlQSTFQeEZwRHNtM0FSaVRSTnh4cVRBenRVSDJn?=
 =?utf-8?B?bGdXa2x0MSswNGt4Q3lDL1NKa0dxa0ZFUmxucEpuOVFIWUJjYlduK0hJd3JQ?=
 =?utf-8?B?NU13czErcVdQelhSYUttNk9DWGtNK1VMNG1oN1piNnJHMEJxdlRtWnpQQnJs?=
 =?utf-8?B?VzQ4MXZ2Tk9pbGdPcDVLNWlkVnEvZ2wwUHYrbS9OL3FvL0ZwbUc0Y1JDQWE1?=
 =?utf-8?B?OVBWS3Nnb0VNQi9tUnBlOW9OVWdOcFVRSjliU09vM0l0Vk1uYi8rRGpySTVP?=
 =?utf-8?B?MCtIMDMyRzVza2s3SHZOdWp6TWJuUkp5ZGhWUzNpWm9Gc1NOSlRqcGNpWWJK?=
 =?utf-8?B?S1R4S0NzZCtjbFJKOFBlQXc4cWZYRVZJTXM5TUhBcExxNnVNQm10R3BFUk5a?=
 =?utf-8?B?TFRpL0V2YkpzdnlSTHBpSXg1ZXBKQVM0enpReFdSNVpuemNmdUhKWVFTSDll?=
 =?utf-8?B?VlpXelkvbGNPSklqaysxUThxYjRkRDh5L2I5bEhzTzdBc3RKeFdlVTREQlhP?=
 =?utf-8?B?aEpuNEFEaDNOZFhMM085djkwTkFOcElNMHRHM2d4eWt2MU5kVFVyOFVuaXB6?=
 =?utf-8?B?clRJZUxxdjZ2dzdJN0o1d2NRYmZZaUxPV09uSVBESjRFNWVJYUlaRURIb3lH?=
 =?utf-8?B?TjRjU01RNFNxNitWWndIcktrZ2d3NDVzRFY4NFB4eklhYVRXdE80bkt6N1FW?=
 =?utf-8?B?czdjaDJUelJ1eW8yTTFhL1FJaldrWlIxUGhBSkRPV0xoMXRKQnNvZ3I0RzJN?=
 =?utf-8?B?STMzT1UzdEFaRTJVTEx6cGtJUzJPYU41MlN6UzdXQUdFTEdIdXlZNk11ejhT?=
 =?utf-8?B?TDRsUmEranhVM215N2t5UjZicGY3Y25BTlhKbFVGYkE1UDlSeVpSNmxiQm9l?=
 =?utf-8?B?T0lGVVQwS21EVlF5bjUwTEQyOWs3aDQzUkl0RTcrMTJ0cmFiTkRoYTdnY1V3?=
 =?utf-8?B?RGlWbm1rOHNmckVJSFQvN2VqemdZTGJNeWlRTGdzaGszWVpxTSt0YmV2M0J0?=
 =?utf-8?B?VTk1eE5OTjJJRkxhbkdva1VRVnNHT0E2bTk1Q2svT3BtQStMVVhUcDdpUEho?=
 =?utf-8?B?WVYxMDkxSTQ0K2FYL2RXNWVpbGpNK0lrQSs2ekdoYm51NjNPZ05lZkNSS1hZ?=
 =?utf-8?B?d3ZaVUNYYTFYRWZMVGhNZUtOdXhWMjRjckttS0VuZTE4TExia09heUdoNDdw?=
 =?utf-8?B?SVh3ZVpIeEVOU0dVenVwL1g0R1FWMTNXU0R4dk9vbkRYaDV3VHRQQT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c1552715-4648-42d1-4c94-08d9b667c456
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 14:18:24.2548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rRVZJWYGh2eR6NgK4nfP0K3P7DigIbWS+vnSowRT/jsQopSxvPakMHdvIsM2hyUu6Hj/gt95zuTJsQRm0GxU9xKBrkUI8cMTJhUjT/u28E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4398
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.12.2021 13:31, Johannes Schindelin via GitGitGadget wrote:
>From: pedro martelletto <pedro@yubico.com>
>
>We need to trim \r from the output of 'ssh-keygen -Y find-principals' on
>Windows, or we end up calling 'ssh-keygen -Y verify' with a bogus signer
>identity. ssh-keygen.c:2841 contains a call to puts(3), which confirms this
>hypothesis. Signature verification passes with the fix.

This fix is obviously fine. But I'm a unsure if this is the only place where 
we would need to account for windows line endings. There are at least two 
similar uses in gpg-interface.c. parse_ssh_output() might include a trailing 
\r in the fingerprint. So I think we should do the same thing here:

diff --git a/gpg-interface.c b/gpg-interface.c
index 330cfc5845..92cd0f0ebd 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -383,7 +383,7 @@ static void parse_ssh_output(struct signature_check *sigc)
  	sigc->result = 'B';
  	sigc->trust_level = TRUST_NEVER;
  
-	line = to_free = xmemdupz(sigc->output, strcspn(sigc->output, "\n"));
+	line = to_free = xmemdupz(sigc->output, strcspn(sigc->output, "\r\n"));
  
  	if (skip_prefix(line, "Good \"git\" signature for ", &line)) {
  		/* Search for the last "with" to get the full principal */

get_default_ssh_signing_key() also splits the defaultKeyCommand output by \n 
but only puts the result into a file for ssh to use which should be able to 
deal with it.

However the whole parse_gpg_output() also assumes "\n" everywhere. So either 
GPG behaves differently under windows than ssh or a similar bug could be in 
there (and if, then probably is for a long time).
I'm not familiar with the windows details (like what MSYS2 is / whats 
different here) and don't really have the means to test it.


>
>Signed-off-by: pedro martelletto <pedro@yubico.com>
>Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>---
>    Allow for CR in the output of ssh-keygen
>
>    This came in via https://github.com/git-for-windows/git/pull/3561. It
>    affects current Windows versions of OpenSSH (but apparently not the
>    MSYS2 version included in Git for Windows).
>
>Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1090%2Fdscho%2Fallow-cr-from-ssh-keygen-v1
>Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1090/dscho/allow-cr-from-ssh-keygen-v1
>Pull-Request: https://github.com/gitgitgadget/git/pull/1090
>
> gpg-interface.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/gpg-interface.c b/gpg-interface.c
>index 3e7255a2a91..85e26882782 100644
>--- a/gpg-interface.c
>+++ b/gpg-interface.c
>@@ -497,7 +497,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
> 			if (!*line)
> 				break;
>
>-			trust_size = strcspn(line, "\n");
>+			trust_size = strcspn(line, "\r\n");
> 			principal = xmemdupz(line, trust_size);
>
> 			child_process_init(&ssh_keygen);
>
>base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
>-- 
>gitgitgadget
