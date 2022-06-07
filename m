Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE84CC433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 08:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbiFGIwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 04:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238528AbiFGIwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 04:52:33 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBB7DFA9
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 01:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvQqpqktxbuyytkTc3s5Cdxcf/u/4BTkQhA+OgUigrfZuXrr6KP0qSyjQli4h8M4ajra3mTZyfpsBqVR/r4ipZ0+QDbF42yG6cAtcE+E2+EEyVUboKcb2VxAgDBBSeJkTwuoxDbrAgZNSp+bJtiV+W+JsFx+Yj8LxcwcTkLle7Z895ePjmAoiXyXg41/hsQCyH/BLowMhilEa6KnYk8WjRacRFgId4bsmjFSzynhcaoqage3w6ion1zWhWMv79hjkuVz0MT1GC3/dZL8028GZ2appvHzyIaSakwMbmGPqk30ZenPK9Hg71PnU8/Xse9aIAzkw5nstqev0N2jqQMt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxfTgHgClqnCOUM5Gwn4S5dsZ3wIZzSA+TaJM+IjHZg=;
 b=ei5SoaVX1UltpmBhpbGzxjqbnzYBLPSQeM7bUo0w9LQavdmduVbWub0U16/Bo/4XyyA5cS1YQGz3LrDsLRNqbHj5wgcQDo8NMDrYaZRjSDX4rqGrueFc7FOUIXECrHg3h63ZjHHc/M08+Pz+vqT9JZqAddpYhHBaTurdSe9rys9IKuzr6Uauvo0+1QTx3KK0+mRajuTt3VkFJDVNVg63XPHjdX6IqjBpkxaGbDgwXTnaUCa7Ms13YRNFY892+gZi8gZ27ILffSnfEqUtlfpA/fsiEiz4mlCckVU3AcihLoXz1yjaX3jsd00RNjfM0laGU0m9pWATrZOJrbD+4i4S1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxfTgHgClqnCOUM5Gwn4S5dsZ3wIZzSA+TaJM+IjHZg=;
 b=abKR64K8G0sGc8rc2DNvlKdP2fo8/+87xLSjYUg45fUYUpddLv+PDHxZA6bVRe6R/JmhB9phGnGETbUdW3A8JxekYHnfT5islNLeRNt9mEejJYfjH1FD3AeKk8FKXY5cf5OKIl+bM44Pv8S4hdnmOa/otwbKiM0ApKlNrK7Us5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by AS4PR10MB6184.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 08:52:27 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b4dd:8ff5:e52f:a55f]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b4dd:8ff5:e52f:a55f%8]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 08:52:27 +0000
Date:   Tue, 7 Jun 2022 10:52:26 +0200
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andy Lindeman <andy@lindeman.io>,
        Andy Lindeman via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ssh signing: Support ECDSA as literal SSH keys
Message-ID: <20220607085226.g6sjcmoiimcvqknx@fs>
References: <pull.1272.git.git.1653932705097.gitgitgadget@gmail.com>
 <20220531073445.iuovy634ufp5xims@fs>
 <CA+vJLfu1WyqP4V44iyZj+Fyr8O7JSB8tSJfOmS1SeSZ65fXh0w@mail.gmail.com>
 <20220531144703.jbawf3tkypt7se2i@fs>
 <xmqqa6awvp60.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqa6awvp60.fsf@gitster.g>
X-ClientProxiedBy: AS8PR04CA0185.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::10) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 283a0fc5-742a-4125-0f5e-08da48630c7a
X-MS-TrafficTypeDiagnostic: AS4PR10MB6184:EE_
X-Microsoft-Antispam-PRVS: <AS4PR10MB6184AD1EBBB6AB2969248D64B6A59@AS4PR10MB6184.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5yj4hQzfvvB4NavZKaUxQ9LbzZ8lclIBp+nDBA7XkjadkLpsZkHj8IyCWDaa5OFsSzF02YdEvGZqG+whxq+pEEkofVS19zh3Uc5D+9wgamK98m56N97QOPBbVNZ5cVtOjOEb32F1c6n31tD3T+hiWoDjl/wnmgIL8Y/2k2s90mr4vBwytpSkIS6gvyNu+zzkI4uLGOl9yFAU6j6txywaO2OVJob4U38QB2Xh6cHSdSSr5n705OL71sjdYMpS+2FvXY7BD8t42SrqPh/7oN24Mk+rjbMJ5pXdE4lohkEQJ/aeWTSRh6KbP2JMPYv/6apjv34DosrtEfJs6fRX+bSaeecn4xaYcFDfstHpCAZ9thixdLgWYLateZ0pZ8DWQkx/xEOx5ALVb1yu+cPScs+9DRtaIFm8Xs0JH5NR/OBXFFOgFNB2EtQ3CA5zPT+YconAe1g085YUjiUlyA6RP+SYbF3bRwooYStvNdQNSx50GhutMFxW5cTJuzqWnx6wLwuWdjPdKy0d87KA8LbFUWGMHbIbv5fCgLQvIzmzCKAsda3oCJcw7nCCU8Z155c6V0+9COYBwJAJwKNdqxDf8vTn2sLdEbgKpewlp/DYit9dIjWZNx/zBYzCLN+IuOuZ+t1v3uPLMa2I3Exmy6pryEIIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(136003)(346002)(39840400004)(396003)(366004)(8936002)(8676002)(83380400001)(4326008)(86362001)(53546011)(54906003)(66946007)(66556008)(6916009)(66476007)(2906002)(1076003)(6486002)(38100700002)(41300700001)(508600001)(6512007)(5660300002)(316002)(6506007)(26005)(186003)(9686003)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnM1aU0wKytWdEZBRFBjYnNqb000TjdrdkJFMlVDUG9EQTFtRDZwZWgrejBt?=
 =?utf-8?B?bWJZbjZLUndYdmlCeGpwZU9TaTR0UDJSV2psV01QME5Qb3MrWnFvU2FpcHJv?=
 =?utf-8?B?VXM1MG1USjdWMHlMcEtEbVJiQTkyQ250eG5MWG1IT1Z5QUtXcFhZSTQ5aXUr?=
 =?utf-8?B?MGdlNW14VjB0UlA1Z0ZvQnNNK21SQUcvSWVWWCt1TXhxNXNvWVlyb25FM0Ny?=
 =?utf-8?B?SnJseGVTVUdxbzRRTm9DL2JyNThyaVF2Z3k0UFBlWGszZmpsMHBmd0ZObmtO?=
 =?utf-8?B?c0YxcXVTUDJWUUZnaTlzYXZlS0NzUEJJWkMzMXlZREpUYktYaS9FN1BtRXg1?=
 =?utf-8?B?LzBsWHlNQ1Jya3FEUjRaeXVkdVpwM2tES0ZMNlBJNjR0THpuU0JkcXI5MEdC?=
 =?utf-8?B?eTh0UCtrMkgzQ2F1OTZIUTBPY2pqbDlaMGdvMlUvb0ZSQ1dZc1lsVk54QnZu?=
 =?utf-8?B?ZVdHWEtMeEhZNDRZbjlWTUJSMVJoVVJRQUNLVFhmQ0ZqcW1VZ0JML2lMeC9T?=
 =?utf-8?B?Lzd1Rk5LdElnZE9zVXlOcWlHZEcxVHdSUk41Z0kxbjM5clMrS0hkMzUwWndU?=
 =?utf-8?B?SkM0SytuS01UV3ltc3c5Q3Y5T2VrRzN4SlYxdlhGRmgwYVhxRGlDdXUyNmVI?=
 =?utf-8?B?MWQ2clVEdTVvVk9Db2MxdnNWdHoyT3hoMEZsOVZRdkVoc2xPSEVHSHNocWZB?=
 =?utf-8?B?UWRMbkpMd2x4ZTdHaVJSUkZpanp0ZnJ0d1ZZVi84ZmJGMmd2dE1PZHZmZ2Mw?=
 =?utf-8?B?TzQ3WHkrYzZOU2tjQ2YydTVEK2RvSGRLUUpNRzFvRkV3aVY1WS81TmwyeGUz?=
 =?utf-8?B?NzJxNDNSb0ZxZm1BRnI3ajNEeHphampvQ21uQ0hWL0wzeUh1OTU3cmZnZlNP?=
 =?utf-8?B?S3NuQUVUc0xmZkhnTm9KeU83M2ZDMS9CZnlEY2UyL1hQYTE4djlrak80S0FB?=
 =?utf-8?B?L201YkROaFRrY2VNZUJpUDRMUndXdHNZNTIyT2dObHkxVTVpYndBemFVcHZo?=
 =?utf-8?B?Z1JGQUd2OVF3Y0xVT0NvcnA1aUJiSHhIdHBmTXVlTEVodWRMR0NjOEdDUUVP?=
 =?utf-8?B?UUEyd3Jyc3dZTnlFaUovQTY5eGRmV2l3VHlOZWJJVVY5eGdENVYvSkhtV2VB?=
 =?utf-8?B?VGYwM2F3b3lyQUVndythQUZVMHpvOWhYdUhpaTAzMlpnU2JsNzQ1Wm9HZXZO?=
 =?utf-8?B?TjBpV21PV3hGVU1VUHhCVzMyS29welREeG5EbHhXRUhtb1F6MnFvbFE1VmQr?=
 =?utf-8?B?OTF1cXZVUkh3M0NjOXNkSHRBVFBnSmgvNWhxbloya3J1bEptbnFrUHBVRVVJ?=
 =?utf-8?B?TUJseDFBMCtvY1dSN2JPYUxldmorU3h4UjhyR3FteXV1UE5qbzFXQ2YydTk4?=
 =?utf-8?B?U0NvU2hOSC9uTWNaWFZtVUZRdzY0YVZLdmFRQkNDK01qZ0VnajdHQ25NNlp1?=
 =?utf-8?B?K0hqNTQ3VlhHK01MVENJOWl3dFRqUklaVmlxZkl1aGFhUkNDT0lHNG5RekRK?=
 =?utf-8?B?R3ZsUFZVN0tzbXNITTZJL1dIZG1WRG5UdzJzaTAzV2JlZjBEMlpBY1ROb0pX?=
 =?utf-8?B?eHBlVnVjUFNBd1lmTkpsc1cwbDd5VTVibXVYTHZyOUpWdk80eDZ3Y1lOSnBU?=
 =?utf-8?B?Ry8zWjdvMFRRM2REYTViOTRxSkR0ZWlpTktlL1ByWUdDdHJRdzVPdDN1UEdE?=
 =?utf-8?B?bHc4TkZaYndGb2c3UnFtdnBtTThTMUREdkRDREVNRUxEU0paMFpOeXZ3ckxv?=
 =?utf-8?B?ZFdVcldySjFqcDdoRjdmMENRcUZjL0l3ZUdXT1ZMcEdhVlh4dW1FRVNSS0Vs?=
 =?utf-8?B?T2VORTBrY2NWUzNUSW1JK1BRckFNTTkyUGV6RDdLVUR6elJtOHJQT2VnbTNM?=
 =?utf-8?B?eHBNK2M5Z25lZDhZbGR1MXllajlmWWhqWmVCcXpaSHNQZTBrUmhJb1ZkQm45?=
 =?utf-8?B?djh1V2tRd1VoZFJNT2xFSThUNWFzKzh0WEtVMzhUUWNJWHBHU20wYnBWVlpN?=
 =?utf-8?B?c0N6bjMveW1FbmZZSGlkVmhTNkVJcTNzRTFWVlFyMCt5dzdwRUhMdjk1UlpT?=
 =?utf-8?B?RkNNaEtXUmhRdWlBRS9TRGpQVEU4V0xhdzlTZ2trUzVpampDdTltdXA1dXd2?=
 =?utf-8?B?Mk15RXdMaFpUMFJ2WWFML2RKUXZNMlhUQnlEamJidzlzSGt5aVNTN0tTVkJi?=
 =?utf-8?B?L2RZbUVMdmx5dWw0RkFYMy9PbWZHdWZZZktkRXNQaklBRHZxNlN4MHhvZnZ4?=
 =?utf-8?B?aXFmSHFlVUVud1pkY2JhOENqSGlPYmtsOW9IYmdXT052RFZOYjkvcjZDanZM?=
 =?utf-8?B?WjNnNlFJRVRRMld2OFdPRkpJQ1dMWGI2Z1RHTGdnSkJtamdZRlBsK3pFZUNX?=
 =?utf-8?Q?3bb2N608VEbbrgR4=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 283a0fc5-742a-4125-0f5e-08da48630c7a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 08:52:27.5884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l94Ldz+Ws6jTEpgjnmFsIl8EqBoLgeh/CGpuaXwxFaXJgyu52PnpDaoXXcqO96jdOKq7LOKH5Rl6IzTKORDesIzFWjf93+L2CGT2x8g1aRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6184
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01.06.2022 00:05, Junio C Hamano wrote:
>Fabian Stelzer <fs@gigacodes.de> writes:
>
>>>Thanks for replying, Fabian.
>>>
>>>My main issue is that ecdsa-sha2-* keys currently seem incompatible
>>>with `gpg.ssh.defaultKeyCommand = "ssh-add -L"`
>>>
>>>The git-config documentation of `gpg.ssh.defaultKeyCommand` says:
>>>
>>>> To automatically use the first available key from your ssh-agent set this to "ssh-add -L".
>
>This is puzzling.  One chooses the key to use when signing, and the
>key should go to the gpg.ssh.defaultkey, and also "ssh-add" is told
>about the key for convenient access.

I think you mean `user.siningKey` but yes, this is the best way to do this.

> Asking "ssh-add -L" about the
>keys it knows about and randomly pick the first one it happens to
>tell you about sounds totally backwards to me.
>
>I may have a key I use to sign, and one key each to go to various
>destinations, all of which "ssh-add -L" may know about.  It alone
>cannot fundamentally tell because it does not know what you intend
>to use each key for.
>
>Of course, as your own custom script, defaultKeyCommand may know
>which keys you intend to use for connecting and which keys you
>intend to use for signing.  It may even need to know which key you
>intend to use for each project you work with and your .git/config
>may have something to tell the script what "trait" the key to be
>used that appear in "ssh-add -L" output should have (perhaps the key
>is rotated very often so you cannot write the exact key in your
>configuration, but perhaps the comment at the end of each line have
>sufficient cue to tell them apart).  So, the custom script would
>need to go line by line to find the key to use in the first place,
>and if it is computationally capable enough to do so, it should be
>easy to prefix key:: in front.  IIRC, we designed the system in such
>a way that it is not an error to prefix key:: in front of ssh-* keys.
>
>In any case, perhaps we should extend the documentation a bit.  It
>generally is not sensible to just use "ssh-add -L" and pick one
>random key out of it, so we shouldn't be encouraging such a use, I
>suspect.

Yes, I think that reasonable. The script can do some advanced decision 
making / key lookup if needed. The use-case for me was to enforce/encourage 
use of the correct users keys on a shared development server in a corporate 
environment (i have a global directory of all the users keys and want to 
make sure everyone uses their correct one when signing).

I'll take a look at the docs and suggest a patch in a bit.

