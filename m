Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D162C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 16:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiF1Qcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 12:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbiF1QcK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 12:32:10 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3ED9FCA
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 09:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/P1mgdad+Nq8QttS4e1K/wHems18qsiGX6GTjpDFfMM3e48VRshZ/35YbkS2VNCrQxuQqPMXnrkqptJxKsDln3Y5Um6DTLw10cDhqoNvraG7INTcWjueqFk0IJyancsvuUGiyCErju5Ob/gKKFszmRCRD1YAVh/gjwLxAICB74jNHVJl0i+nj0jl93txKoYC3HNbnE0tnnI1KFhwykHzx6WLse4k14I8gxNmbL/UKZLl0g9/tQ6jlJqwPjFdLJ8FYMDUxsWQMwahQaaLnaBKMM/uwmNidPGI3lb796MajqDsZzTQ5VPElramQ4qcnnVLusqrWWBbLQRek463PYUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQLdJaRPkUWEeKz2vkVa9ACjyd4bazur6n5elyOKQ+w=;
 b=FHTL+YzwV38atrlHQ1f4OhMMmho2UjkmR1g6T6HvFcEMCKrY/qg8zE7IfnObMvqRdz2bg0F74CSasPhA/jSuZZ45uIzjg4siQ2iksE8fg6fhfM6lrs8R0YY+4/vpRlAd40SVpYQR6RPk//6s65Mm+1IprP5JXOFHKx+YhDrtQBAPBvdYtg4mT/zqQw4NnvLwgx2FBOa1ksXbYy/5PYFjG+tEjwLrLvznVud29gqGjxH3xKWYkfgfx2llGvnBYePTw+etIJxD4Y2Ii+nGx57HA3Kl/Ozj4Ubj5aFqz9EDYuR7dhRWtfPEW2kJh2648wbXVWoimFhNQ7AR3alIzdIUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQLdJaRPkUWEeKz2vkVa9ACjyd4bazur6n5elyOKQ+w=;
 b=mCFxaJY1Ont/UPugYIS1nLWgaX4ACxO8SrOnEB27WcagKCkUhVhQ2K7FTQcBy4VjooiGWSI9SJ9rso7CHfBsDVXYJYYqCXZSHdS4zY+mGQkU6XnSUbzvboGILUEyToxqAuc5DclCoxsPrgseTF/b7IE2qut6G6WGmZwz4nmgX1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by DU0PR10MB5583.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 16:23:43 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f970:9fb2:7f69:3ca]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f970:9fb2:7f69:3ca%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 16:23:43 +0000
Date:   Tue, 28 Jun 2022 18:23:42 +0200
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Marcos Alano <marcoshalano@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Unable to use security key to commit signing using SSH keypair
Message-ID: <20220628162342.ootjobbjtxg7b7ay@fs>
References: <97adcd90-b4d3-1114-205b-3445dd48b497@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <97adcd90-b4d3-1114-205b-3445dd48b497@gmail.com>
X-ClientProxiedBy: AS9PR05CA0049.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::9) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ce3463-ff46-4ab9-9c7a-08da592291ce
X-MS-TrafficTypeDiagnostic: DU0PR10MB5583:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTEO8mniybT3w+H3+lDehcf2OC6HqbKwvWtDvBkW+36uJPMmCS5qRqVTDEI01KPwq6o9Gd+WUOFkPHkD2gGbgv24i4ZH7j3gz2YSGzHYBoMdlCj0ORZ//afsRR5QWErPoY8B+GGY8XMzYYBGFPh13OGeXScVPaABrkd5z6PDt3bvs1IRMNRjV1mz1CYDZrjr50QQYU+47U55nWzPeKy7I4Vi83Cf8a6sQ/M5g0kiPWVhypXta4Ai8pUGqlDKv7YT0lN0fn5gtnI0TfxyILFIDYiKBxRABqrKFKQP3sdFuHwBLtGi8LXVTA33CFaRbehSoCyIM58eP5yb6eO4w+qvoJxbvxpzqoaNmNio2To3geqpXP5SMMgwrIMHe8/inso1nXTBnvoZAbRyLW8fwVRD11eC8dzs054UClSsdRE0mj5x3LEWoGkIMYfH8SDlmn+9FVhS/nfIES1vziZnEyMdPwRD9IE+z0Po6VBulJaj3BbqyyJt93mIx8OEXeO2BR0XUtlDaJL1oZDBgN1kCt7+41TlcwQXtb8N7u3i5jpKkHFynRU2XbemMN6c+TaeaAM6+wO15uBqurGBd0C16ekrakpGihKTEiEhizeWNIuNlRoXvDfZG8R9KM5ROKeGciGx7nrpcEBGqeLLHm01ToUruIiiR9w8flQ8Yvej8IutSXjg6D7+p90eXKqWmZwo2uVzeKaONuENM01VSn99rt6Cuu3uUaYJNRDbIYLvbAy3rxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(136003)(366004)(396003)(346002)(39840400004)(376002)(33716001)(15650500001)(66946007)(4326008)(38100700002)(8936002)(316002)(66476007)(66556008)(2906002)(5660300002)(6486002)(86362001)(478600001)(1076003)(41300700001)(83380400001)(186003)(6506007)(53546011)(6916009)(8676002)(6512007)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2UzRXJHQUNKK0QwVVFkMWR5aVJUZTdDemZ1aStBcWxtelYySXR5SEVSbVJh?=
 =?utf-8?B?WlVReWdmdWtZdGRYK2JPcXQ3QzZPWlRmSlBQamZicmtJNkxPMnFmdnh3S1dV?=
 =?utf-8?B?S1MxREwwTjNKQjVQY1dLNEZyRTlWLzkyWTBRZWpiMkN5aGY1bVRRbWVCM2pT?=
 =?utf-8?B?YTR0Vno0R2p1cjRqWnFIelRHSmNhcEJSQ0l4Um1mcjJ2MUVYZ09LMWYyUE5t?=
 =?utf-8?B?Z044M3JCYUxOWWZ3MFpZK3RBR0JGbE9sNFlmV0d1R0x2RUdmUGYyRU9JSXl5?=
 =?utf-8?B?L1V1eFBIVEE0bmVrQnc3WlI3RUpta3dwV0pUYlJXOTNFZXZndjJnVFhYRDhM?=
 =?utf-8?B?UDZneWZUcHh5THBFeHIwZkJvYWl4Rk9HQ2Q1azYyZ2ZDZG0zSjBWY04yYW81?=
 =?utf-8?B?QUVxSG5Xd1RLQW5MMkt2ckJ0dkNGVVlWWVRCbVJNOGpIdHdkSHVMNTRDSjB4?=
 =?utf-8?B?Sm1oRWZSTVpCa08yUUR5MmVjVEY3bS9qVnJMMk5sdXdKakdrdkhsOTJoQjIy?=
 =?utf-8?B?ZkY1ZURSUWVxZnNZSlVhdG5PNUFMWW1CeTkvS0RBdFpPblRxSU41WTloQXEr?=
 =?utf-8?B?TllPMUk0SVo2ZDNrUFYvWldidzhpQ25OZTA3WkpaUHF4UVpNaWFBUnBzSjFM?=
 =?utf-8?B?N2wrZU9iMXhKMmtOOUZMTkJldDRhYlJMNS8xUFVNUE1mTUtjblF1L0NjRk4v?=
 =?utf-8?B?Q29teDZsam5iWkozdkl4WnM0di9TUkU1WDF0NnJSckFzeWpWUEZkaDZ1d2I1?=
 =?utf-8?B?WDFSeVZJVFFQdWxsaU5PVE9SQzgyWGpGaXd2bzBYMm5XY3JNcm1WVGVVNmVE?=
 =?utf-8?B?QVJvS0JZN3N6WlBFcE41ZmFzK2d5Q0tlTW1sMDcybzdOdzVRWDR5S2VUb2Vq?=
 =?utf-8?B?aUlaYzJ1WHdseFdRM3FCZ3VZc004N3lzTVZhUnVQais0NlJ5WWJHMm54R2JG?=
 =?utf-8?B?akZhWEJua0JJNmZKblNNMjBHZDlhRFVYWExnVHl6a3IyVVdMd1VDeTcyYkdN?=
 =?utf-8?B?VzFQT1NFU0JwUG9pY3N5ckpRdFlISFp0YXRsdXBLL3pZMTNwNlJFb1ZSUFVy?=
 =?utf-8?B?bWFRdlg2N2paQjJDK0d2YWNjQkxtNlRyUnpXUHR4c0JCWStwSW8rVDJQQ0Vl?=
 =?utf-8?B?by9LMkNiVVNIQmlBci9zMVpJTWNyYnI3REE0Yk5PNS9jQnkrZi9DcEpRb05F?=
 =?utf-8?B?MDBjUjBhNUdIeDFMYXJuRFhFeExKY0w0eWIydFFtOEJaMU14ZmgwR2kxbTNG?=
 =?utf-8?B?Wm1JU01PRTkzallzVXczUnlBM1R1MlUvazV0ZldNK0MyWTEybUZ0U092YVk4?=
 =?utf-8?B?VjZtUGwwRUN3WXpJTFJxQ2ZsTWRPOHk5OWZzMEFxMW5COHlYbm4weTArQ2Rt?=
 =?utf-8?B?c2pkemRjYWxaWTRmRUJpL1RKdFBYNzVlaWRmZEt1MlR1UmxQNlU2NHNJZGFW?=
 =?utf-8?B?bmJHTmNuUldrbk9aWmxjTDljN2c2YklsRUZTYklrQ0gxUlpUNlpEOENodnBN?=
 =?utf-8?B?cElqL3BiOFVtWnpjWU83L3hzdC9Za1duaFEyVWt3YndTUmM5amQyMzEzaTdu?=
 =?utf-8?B?ci82dU9yRjdnakwwZEVweXpVSForejN1TWlRT3ZuenJsbUVmeUJZamt5WkRs?=
 =?utf-8?B?dUNqSmpSK0xOUlg2MnBJeVNxYTU0WmJEcE1DaFp2THZzZWYxY2lLazZyRkk0?=
 =?utf-8?B?MEJ6UGRMeS8yNlJYYnc0ZFpCRGJsTG9Bbzl0b1J3SXI2dEMxSXBGRjczdVhv?=
 =?utf-8?B?dmRBa3IzS0pYUkd1SWVBbTlQUklMbS9KQmVHN2xpQVlsbVZmZ0gwZGd4cUlH?=
 =?utf-8?B?M0R4Nk95c2hWV1N1WkZEaTRsUTlyQUlkRXpxTXNGdUJzSlhPLzZnZDZ0VmVW?=
 =?utf-8?B?NS8rVkFvdWtEMmE1N1FGbzBVdnZuY1VGU1J1cmQ2M0VFYWZlS015TWJYeHZT?=
 =?utf-8?B?Zmd3WlBRUU95Q0hWRmU4M0Vrd0p2SnlQVi8rNzZLSkRQYk8xNVNkY2RPTHJp?=
 =?utf-8?B?enAxcFNqejVCZFZ5SDIzczQ2K2FEOHVVMk0rdVJFZ0N4Um85Mk1CaHFqNnR3?=
 =?utf-8?B?UDI5bTFzWUZseHpRYzltUDJ3eFRoZG1tSTBpR081YzVxTTI1aXVuYTdtdzAy?=
 =?utf-8?B?RVhiRDBpYUN5czVyYnFMUGVqZ1dMWXNYdlRsL2JBc3ZvOUpoRHpiMmFTZWJJ?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ce3463-ff46-4ab9-9c7a-08da592291ce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 16:23:43.7436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlI+akwIdY3jKbyFnPVFV0PpJKemHH5BxMuWx48ZOoSdswgTjfH4L9DyExsv2fZ/V2vyAG6Lx65oXgi0i10ZP/6ClJMux6kvhbP0/p/HVZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5583
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27.06.2022 21:09, Marcos Alano wrote:
>Hello fellows!
>
>I'm able to sign commits using SSH keypair, but the keypair must be 
>located in a file. If I try to use a SSH keypair in a security key 
>(like an YubiKey) I get an error. I used this commands to do the test:
>```
>ssh-keygen -t ed25519-sk -f ~/.ssh/id_ed25519_sk
>git config --global gpg.format ssh
>git config --global user.signingkey "$(cat ~/.ssh/id_ed25519_sk.pub)"

Did you try just putting the public keys path into user.signingkey?
Literal keys would need to be prefixed with `key::`

git config --global user.signingkey ~/.ssh/id_ed25519_sk.pub
should be just fine.

Also, the private key needs to be available in your ssh agent. If in doubt 
you can check with a `ssh-add -L`.

>git commit -S --allow-empty --message="Testing"
>```
>
>Bnd I get this error:
>```
>error: Couldn't load public key sk-ssh-ed25519@openssh.com <my key 
>id>: No such file or directory?
>
>fatal: failed to write commit object
>```
>I did the same thing with a plain ed25519 keypair and worked.
>
>Am I doing anything wrong or security keys aren't supported yet?
>
>Thank you for any help,
>-- 
>Marcos Alano
