Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1476C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 08:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJFI25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 04:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJFI2j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 04:28:39 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00045.outbound.protection.outlook.com [40.107.0.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC7E8E0F0
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 01:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnEN3gq5RKomwrimakMdsbMBp3PUhXvuiTBzR+7OtAs0W6wliaVhxi4XAHcivAbaDedR5lyPb3wMG35cBPm3LURqDPI7c9CTjsTuty5z3yVSOOlyn9P2p5AB2aqkSCgRazYNJOuAlSrb066lpQWpWr1ma6HQuHxHGINfU77psiQyvtGPW8/N4uJt3vaXsSksOk8WPOa85BxgmVye0ILzF+Uqa+R5+csxgm54yxaxQ2hufQKdxcmV4akoBdj7HgMsV3m84p/IVbU/cBC67eWkzlGJ71XDWYbZjNg/VGNdv1ZTD76VX7WqI+3dDVCZ3tA1AJInIgX74aF+8LUzcqjSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLJ5bWZJK/2e3t/XYbMYo4yMfsGnkKQ5Vh7bTVJ3M30=;
 b=TE3F9BO90H2R35IZl2Sw8uxLF3Z/K/TTe0pQdLUfv3hfmO54ojIA3jyTy5RCEfSobhYgUC2GSamYhjnuujX4f0kvVX3XnOMzcmB/d2eJLnnyEIHOk68Yh9Z+d4WFOZ09xzOVTc2ymLC3r1JXABZ2IXkBXoLGHUR+crmOn3a+tR1j9S3EhGltN1QQd2q4DfKUYUPGZdrcceBAtQUGSa2CY3fJX2YPaYcgtYmdEjW8eCP4VEi7owmzhJihUnaI+Kp8cQq0mRaGLkq32mCM1gG+cz8GzLEcQh5gUuDuORgHTSRKuBzkYruiXPWXnzFoxxL66l3xuTCGZcjLmFXdaMRyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLJ5bWZJK/2e3t/XYbMYo4yMfsGnkKQ5Vh7bTVJ3M30=;
 b=SjQ3SMggOpcplIpCUZ4BFNlgl62F8/UMmn5A7XB5y1R0Ozx+Abr2jI44uMpKUMNZE3zih0kY6zzop2+znYa1xdlrBF7p092AQCaBjMFAmXYHIOBBWbrELaqXdT1hUoAZ0AL4fD4oiY7olhR5iY2BqTwXlIKAp/0TJtTWNEdewmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10d::17)
 by AM0PR10MB3122.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Thu, 6 Oct
 2022 08:28:19 +0000
Received: from AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::545:2b60:d0bc:1402]) by AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::545:2b60:d0bc:1402%3]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 08:28:18 +0000
Date:   Thu, 6 Oct 2022 10:28:17 +0200
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] ssh signing: return an error when signature cannot be
 read
Message-ID: <20221006082817.4uxywfxjokfyml6y@fs>
References: <pull.1371.git.1664789075343.gitgitgadget@gmail.com>
 <pull.1371.v2.git.1664877694430.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <pull.1371.v2.git.1664877694430.gitgitgadget@gmail.com>
X-ClientProxiedBy: FR3P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::11) To AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:10d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3271:EE_|AM0PR10MB3122:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cadfc2c-d987-4e75-fdaf-08daa774b8e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTCJ35PUFWebqiFDEQRawthir/Hn++xB7TiSFTrFC+HYGub8ZKr6zjlsLpE4JZNAo2UrQYtwjYDdveRfQXMhp6Ee/fIvsQ/HvfDnwwlT7oyJzjP5MfCzaU2DEpY9qz/d7jS31ULebI7ScHBmUsZW1F6aRTxIIPvXS9Da11irUD+pN9jfRv5b+AXW2ygt8qEKuT38y+kVMKJO0UW7+GOSLENzwbPT61gmPPMjc8Qi34u7lKuhn1uYeAc5FfFvTIgf0jsEx8xXKd0LQO+czrw5KtCXYix+nEkckrUzcpgDqqwgpSSQnGR8+IWfrL3yaEpxfYIU1JYJnxMSx6ACuKMKAMDNfMvH5VfGGYZmudRkWW6npL0rW3kW0/bYth1IwHIo2lQHqrzt7FKYfmi6KYfiPu4XqtmLj7vUV8wXFwiS0rAJuu/gZya51LZR4I3d7xQUdxiC6OOn5RKy0dnV1MjtuTkd4dnJWyf4l9et264m/HqM6GKUBAVmezrvkgGJJGxdS9Ckr73tURteQ+WmgGDkgjr2oUuj3YGZjWGOIyon8XQzqJhYRxSCCUK1/Gj0mj+O7Xl2qREbUUV3abNYwEadxvDumZgddhv/8AQ11zauaF1MIh4qMpiIa7PiXG5NdVYsZ25khR554A9PaSOvmz+MpzicL5qQq+cl1FY55TXqBnQjBrHVS8bjVJf07jg8qWlSPqM3tcfx+AwoatLSj06dAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(366004)(396003)(39840400004)(136003)(376002)(451199015)(6512007)(9686003)(26005)(316002)(6916009)(6486002)(38100700002)(86362001)(83380400001)(33716001)(6506007)(53546011)(478600001)(4326008)(66556008)(66946007)(8676002)(66476007)(8936002)(5660300002)(186003)(1076003)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHYzL0wzblNpbHpNQTdDM1NRK2xhSnRKY1pPRlVNeHpNUlpVTTB6cTl3Y0s2?=
 =?utf-8?B?VG9lU0dIRFE2RjRFSmJGNkRoUGhIM3BGTktDRlZ6eHJQRGRUWUt5TnhHZFNF?=
 =?utf-8?B?S2cwdFBqNzNJajJnL1FQNTNac3FzamlSUVlKTTY0bWJObDNOTFlZdmZ3eW1u?=
 =?utf-8?B?cXlpNElmYmdrZ080SUpaZ2hWQVVoRlpKM0JkM1BpV3RVVkthQTVBdmh4UWw2?=
 =?utf-8?B?TnlXbTNGaU5JZXJ4YnV4SzYwQ2ZzVkdXRWtSWFVWU2Rsb2ViNjZQSkJPcDhO?=
 =?utf-8?B?Y1RGVDFxZFV6d2dyWURLVTFFc05rUGxGRmpaMFBXWVh5OUFpNnVmTHdqQjhP?=
 =?utf-8?B?MTlDL2IvUzB2S1ovbG9iUFR5andIaWJhUGcvNlhCU1VsWnduZ1g5d0pYRDlk?=
 =?utf-8?B?bWYrcEliQWVNalhtUnRGQnQ3VU9YWEVqTUxaSE9QWTA0YVBsbnd6SGhOM1BQ?=
 =?utf-8?B?cGZLZm1WazVma2JvcThhY0tWTzdBS3lNazA4SnNlTTJvYW1ReWJoSzhENEk2?=
 =?utf-8?B?NXNGZXlneTR2VE92U0FqdWo0VFA1eUVyQW04c2p0Q1pyTm5lc2pkOHFMTi9T?=
 =?utf-8?B?bW44RExtV0RVTTBDSGJZaTd6NWduTU82TEo5cFVjcXoybWdINUNBa1hyeVpB?=
 =?utf-8?B?akJ5ajAvMWtQcVhrbG1wSXJOSW1PQ3N3bGVYVDQ4RCs0YkZDeWdVZDJCVmJJ?=
 =?utf-8?B?RTlPRCtsNmx2RkxFTy9KMkxUY1NYOHNPMDlQcGNtTElBeTFPM1BZTkUxdWZr?=
 =?utf-8?B?Y01Qam8ydTlvTTVDWkVKMi9yNjdqWkk4Ulp2ZFJ1c1ZnZ0oyd1pJS0Qzd1Bp?=
 =?utf-8?B?YzNyVEI0NzhjZWp5Y0MrZ1BpUUV1K3lhRzE1cFJpQ3gxWnRLMFVQOEtFTFNr?=
 =?utf-8?B?VE9RYldQM1RBaG1BMXhsNGIvUVFsOCtMR3R2ZmVkUnc0RmhUQlo3QnBBREVO?=
 =?utf-8?B?eFZVK043RnF2UlY5OW1oNkdLTDZxRHk4MXg4WnBhcjEvRHU0TUQ2b0JCdzdO?=
 =?utf-8?B?aFh5ZGMxRzNib2svYlhUYThJbE1qbFIxTkxDenB1dVAzK1ZoQlRJNXM5Y2Fh?=
 =?utf-8?B?MWV4ODNXcnVSSnJ3K1g2Mzk5cnFsYVl5M0MrZmIyMG5LN0Z1V21qdWFBcDM0?=
 =?utf-8?B?OW1kVjhWb2FNMUNsSi9IQWZ6TjBwRXRPeVpYZ1RKU0lTMSsvSWhRRUFnVjFs?=
 =?utf-8?B?azZyOHdjK0Zsd0ZrNDZsTFVTTUs3ZVBySmpmamZtQmp0TW5yb1lTNDhOcnIz?=
 =?utf-8?B?cEwyYVFtT2VVY2pmRGV5eHMyYlhuUUNPbTZZOS9zYWJoM1lEbDZMbnJNMGg2?=
 =?utf-8?B?OXd5eVMwTFlZNWtEbmNSYzk1T0lCYjcxcGZqTmx3empncUFtdkIwL1ZUOFpa?=
 =?utf-8?B?OHk1RkZrMEFxeSttSHowdWRCUDhrQVlDZkR5VzNaYUZtYURkWmNvT3E4V2Ft?=
 =?utf-8?B?anNkb0MwOVdsNUw0bVUvUHJlL0k3K0pHeUhCa2FhdTdBWmxLcnZkNkV2QjYy?=
 =?utf-8?B?SHY4dnY2WmJBMFlWVmNBOFlBUTMrNnlDay8xWkkwY3JHTHFQY09BTnVVY1ZT?=
 =?utf-8?B?UEhDK0VUVUhSZWhpaklpalBwUnRZdElERzV0U0xjZWlHQWVKSkdra3RWemhM?=
 =?utf-8?B?SlRlUFVjZGZmcnhFR3ZaUXFDdm4zZk1wQzQ3Y29lVENRaXpibFZUSUYzWGp5?=
 =?utf-8?B?UjZXTVQ0NWF2RVZkV1RoV2o0MzBpdlZCZXhoZjBiTEhvc2Fsa0kvREFLQkZk?=
 =?utf-8?B?TFNXSjJsbk5QUm1LYlpyR3Judnh5WnNydDMxWGJTVWFMeSs0MlFmR3kxMUI5?=
 =?utf-8?B?NjVGTk5McDU4OXpyZ2RBMW54M3RGd09GeTIyZk5mckV1MXhyT0puNmFNNUkw?=
 =?utf-8?B?S0l5V09CbDBYWlN5RmR1VmorZnZqTGI1OVZQVlZDMjJhMG52VkpHeE95bjJo?=
 =?utf-8?B?OU1BQ3o3WnVGSHIyU0YrZEJKY3dVOXVEU01JSjhRcGVONVd6cy9UaWVMekFr?=
 =?utf-8?B?aGNpMEdWMnFVTnNvb3VwUjltdFRqbnNtUWJMbnR6ZWFlbjVnRWJybnpzMkJr?=
 =?utf-8?B?VW5uZ1ZFcERTQ0pPb3FzeXRyaHZzcGlxa3dqV3lIalc1NC9jeGhWZDNqaVE5?=
 =?utf-8?B?cUZmZ2k0ZHBqc2pwOHU3WHpzOXI3RzRTV3RlU3dCM3hOeTNub0o1cDJNa09i?=
 =?utf-8?Q?z6/qX01l2XwoUAqr1kPU6m0=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cadfc2c-d987-4e75-fdaf-08daa774b8e3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 08:28:18.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcLkJanIzJOHMRjjNVrmlQ7kH4+rII8E0xITUDM8F9mXN6M5+8llxgMtdBdVHU8dRNv2qNGeuZQ2W4OCeW523vHytvStEJkon9oV0ElxVTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3122
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04.10.2022 10:01, Phillip Wood via GitGitGadget wrote:
>From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>If the signature file cannot be read we print an error message but do
>not return an error to the caller. In practice it seems unlikely that
>the file would be unreadable if the call to ssh-keygen succeeds.
>
>The unlink_or_warn() call is moved to the end of the function so that
>we always try and remove the signature file. This isn't strictly
>necessary at the moment but it protects us against any extra code
>being added between trying to read the signature file and the cleanup
>at the end of the function in the future. unlink_or_warn() only prints
>a warning if it exists and cannot be removed.

Sounds sensible and the change looks good to me.

>
>Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>---
>    ssh signing: return an error when signature cannot be read
>
>    Thanks to Junio for his comments. I've updated the patch to always use
>    unlink_or_warn() to remove the signature file as it does not warn on
>    missing files.
>
>    V1 cover letter
>
>    This patch is based on maint. In the longer term the code could be
>    simplified by using pipes rather than tempfiles as we do for gpg.
>    ssh-keygen has supported reading the data to be signed from stdin and
>    writing the signature to stdout since it introduced signing.

The ssh-keygen call is already using stdin for the content to sign or 
verify. The signature and the signing key need to be files passed as 
parameters to ssh-keygen. I'm not aware of any other option of providing 
them to it.

Cheers,
Fabian

