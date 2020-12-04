Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBC4C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 14:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FBD72251F
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 14:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgLDOiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 09:38:15 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:23669 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgLDOiP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 4 Dec 2020 09:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1607092627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
        bh=uLPqO6eQCrlENV8u2CeOIR3cT6sNrHwov7iefoLz6jY=;
        b=FCG/ETNiYd6oZfYzGz/ID699zMtdDzIK4cXgKxvTDKblsUXG95OruBTDNf+9buJcVYY0PU
        PMMiYHM+bHtgVrYGjvso8NORL6yCCkPZcRUDlosgJdmurdmZDk1dEkREwNZPFC3dMn+U9X
        kpATLrVMhNjs1ZtQZ7twnzoXJnxZW18=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2052.outbound.protection.outlook.com [104.47.5.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-6_rJgsTiMBuy34rXSF9pfQ-1; Fri, 04 Dec 2020 15:37:06 +0100
X-MC-Unique: 6_rJgsTiMBuy34rXSF9pfQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAamCX8wDfOFIMjo9KopaYXBBDE71kmJQ1M2afJQ8d6uv11Kxy9aCWaRNZI1D1ebhtwYyyOA0uyvFaD6GwIe7kL7PqcSYRNUHwmt8V+xBt3wAi4z3/SrnJwWTw9HHycRUw9IyvyZV9JzThHVLsBZaQ+//kwIvMmAVrPOsW9ZbzH0IB66XI0bJMJxdiplBIMCqs8V/4y6cmkW846ntzkTOx2ZWkV7uGuyXitqcHQNyHCkFxDduYjDY9jAriBu9msXOouo9ZzrDgS85KhhuHoZtRE72PF5O+MdOMMXeRZCmnRBV7YLw+zJhw32uThSdFqJ9LUZLx4c36rNzHKy8PlG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVySoOOd/A1o/brFzs2baWfDrxZClJmtyEvF+3d8UJg=;
 b=T99utDVjiK9ELg8tvwBEEuuamB3+DBz/p6lwRyRrvq+A+OiulTh7XaUhbl6XDgEnKL6e/86cJJRnsrmNOf7uw30IW3SpdOLQO3CDcTeisOtHjD5O35FX/KjA3lUYSYN6anzJPtflX4BiC+deYy00+fQs7w25r9mu8mwQg2g4+7i1KpSvTKWKFbhqqcRj/nfSm05eEpBdjQScyqk3GUb+IvOtsSkNZwPiOrHTNWjxIa5/zhSpRn5d03I9Mrn3/cdZVyINMwAvrVYFfHu87Vp5zY1iFeex2thIGPEGzHp1ZPL2uoAO7BFIlprWBFnGbmdebtrvFE1E2ULCoYc1l2kaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7662.eurprd04.prod.outlook.com (2603:10a6:102:f2::15)
 by PR3PR04MB7369.eurprd04.prod.outlook.com (2603:10a6:102:89::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 4 Dec
 2020 14:37:05 +0000
Received: from PA4PR04MB7662.eurprd04.prod.outlook.com
 ([fe80::79e5:d0c6:76ea:f726]) by PA4PR04MB7662.eurprd04.prod.outlook.com
 ([fe80::79e5:d0c6:76ea:f726%4]) with mapi id 15.20.3632.018; Fri, 4 Dec 2020
 14:37:05 +0000
To:     git@vger.kernel.org
From:   Sofia Syrianidou <sofia.syrianidou@suse.com>
Subject: diff-filter=R can't identify renaming if not done directly
Autocrypt: addr=sofia.syrianidou@suse.com; keydata=
 xsBNBF3o/3YBCADOzq759hJ3xUw2qqTy6Gqzdhciel+7/tnXUfxSf+o4dnC9KRJC2MivLiDX
 9Dl6RBQG51aexZIFWQ5oea3WJvzmuPThUCs3ZvsS0h1YVZ5+VPPvrOqBr6Hx3GbDWmvzyuh+
 XD8jlmnCIJejVHhrJ3P46s2InGdrYnZ0CNIxLnfhP28W9Vln2GFnZPRlTeziE60vRKVDivB4
 ysPk3YauKVpu6/TAsC6kF1NRttCjOUZiv1mFNDfsUqG69PQRTV4it6VypxUrsvYsx3jXyrh0
 xlCvIDghNaE85w4mmHlVU4gwkCfGhobMfVRQ/FjYCTdM3SqUpNVKi4hpQ5wDzKAkCi07ABEB
 AAHNOlNvZmlhIFN5cmlhbmlkb3UgKFFBIFNMRSB0ZWFtKSA8c29maWEuc3lyaWFuaWRvdUBz
 dXNlLmNvbT7CwKUEEwEIADgWIQRr3Nj+evSzvTLsfVYrpHZVGQHhywUCXej/uwIbAwULCQgH
 AgYVCgkICwIEFgIDAQIeAQIXgAAhCRArpHZVGQHhyxYhBGvc2P569LO9Mux9ViukdlUZAeHL
 4aIIAKf0+Po/evmKXn7L4Xq5YpglWyEkia92y6iIrR/qOkgc/jYbKyJ1iUuNpFlW/Gir3SGF
 w9zlrIRnHMNCiSZFazipXRf728OjiVUjIhGs6m1T0pUx0stlXzJ+y6xIzSjZTb6DI8G5nfmU
 emKe0seEYmkx8ArLGZORW323SG2B9i0QjFQ7z5GDiq6L4PiFaW1QDaozQDzBlYIRSUgfNSeY
 vbpVkP2Z7mCxD6YximPksECiOE13qJJeggXKL5CipTQ82m2sI4Ib6JvP/beHwMGUfAiplgHD
 iHD8YxbqDIaGvp1PmPRvtHJ2x/0RAHzkUNGJR1FxQGcUWEqg/kKicE+ZtZnOwE0EXej/dgEI
 AK0mEp7x/bkBilqoPgyiaQYQG19SGmKwaYrNvY1lrjF5nGNrE4FwqLu0WlYC8qUzWrOm+Ik3
 l6sOe8pRx3u+sWlBOGb1C7h20QAFLfMPeRQBrfdUyrQRS6keBbelkcnY1v0MiAFvNABpr2FT
 VnAkxf9iBr5bqjTJ16lhV8YjF9sFFpbhXNGSayn4I0CPcQ9k0FG4mo1KoqY3b7ss+4ZsmMub
 9BTKtbAuFmc+K5+eAj7cKahPQfKdNR7O94axd97krZzfeVxtuKXbqVvOxrrF2j3exuu7TKVt
 uFfGReSDKIgv9STjJ9ZqdGDQlE9+56Sfww9QHa2G0smaXqZiVYCV7b8AEQEAAcLAjQQYAQgA
 IBYhBGvc2P569LO9Mux9ViukdlUZAeHLBQJd6P92AhsMACEJECukdlUZAeHLFiEEa9zY/nr0
 s70y7H1WK6R2VRkB4cunCQf/WZX0p1klXveao7o1KCtzDec3tMJGZPksiH1kjcRlKQocLzUg
 yfzMuWMM/3Bm0kpu24Ij8vvhirATLFpEBkAPYJ2rmJFvoqfnHqbxfS7rA4U5IJFnFXRYp/Zv
 flGiYV+DjJ8gtu2lROyUKarEmAcikK68aNGS6hS3S/64dmfqVOubLvEtzXnZpx4RaZqAu+yt
 AZsdXigEI4XpDd/bmn+3+rwqSvZBVV8kAubZY3etJBjvziic/uPas3PE2b597VMyBfiSd9Vu
 FqOji2HVeCtZceyIC2/uE10tqK3sz5eG9bDNHuUKJZ1X3YyUVcdXcy+iAd723S2zsa9xxkSm
 MlI/HQ==
Message-ID: <19eb8038-20d6-385f-50e5-26c7a0bd8e90@suse.com>
Date:   Fri, 4 Dec 2020 15:37:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [2a02:8308:290:ce00:36f6:4bff:fe61:ea04]
X-ClientProxiedBy: AM0PR05CA0076.eurprd05.prod.outlook.com
 (2603:10a6:208:136::16) To PA4PR04MB7662.eurprd04.prod.outlook.com
 (2603:10a6:102:f2::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:8308:290:ce00:36f6:4bff:fe61:ea04] (2a02:8308:290:ce00:36f6:4bff:fe61:ea04) by AM0PR05CA0076.eurprd05.prod.outlook.com (2603:10a6:208:136::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 14:37:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03310806-7c12-4cfd-d887-08d8986211dd
X-MS-TrafficTypeDiagnostic: PR3PR04MB7369:
X-Microsoft-Antispam-PRVS: <PR3PR04MB7369F1BFFB1D866B5373EDF7F0F10@PR3PR04MB7369.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRetppNOLYiHLHKPwpIZ3KebmYLWMEMxuxcDuzx29XDhbgK5J4O4Dv2ms18Lp7AguIRepJ6Ku+ofmH8xkUiZDcFsM4gkHzAstHzw0PNp3ogNZqb5CQRujWoTF6yu6W7Wei3BjDx/Z8nb+zPAMQ7rA3k13ogEmmerQOq0qd4sk5SU1qiZ8HWtF/RJ3JknNL1yZ6Ry57E0meM+zS2SsEXUf3Aa4nLOrTad8nLdPqmy/saqk+oiaC1iCGrBVIq9Qrk77tAVnkxSNw+EZusAhOsP4TbwIfGfAVO3nYVB0Jpujj55Ta9CJcjaxGNmBEyZoCBCbcqQyU+6lMothEQnQk7M1R8bb3IyX+GtoA/PTHb1hS06JJ/kaPTrb9J07cA66OWvZx8UJf6MMR8brROiCHXjkKeHVJW2/9OijhvtojSWeKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7662.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39860400002)(366004)(136003)(5660300002)(66946007)(6916009)(44832011)(31686004)(2616005)(2906002)(66476007)(66556008)(6486002)(316002)(83380400001)(31696002)(36756003)(186003)(8676002)(8936002)(16526019)(4744005)(86362001)(478600001)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3k2C8Cjp89jMQdGpCE8sczNlnTOU3j5b8h7wBUfFlZvadocKnEKmQQIHZA+Y?=
 =?us-ascii?Q?huudq3gCfzzLccT8KJcDmNjZZOesFHK3Ayyw6H+Gtcm5WHbzvF3GP9FrjYYI?=
 =?us-ascii?Q?S0sW3QnhDBsw7oei/BUPAwxIsNxiKA1JO4qgEMXk+TGf/t1tJcIsTueRXjDL?=
 =?us-ascii?Q?6RIvXGGfWcZ/JEI7Il5eHFZOxkB+0l9QPGuP0YhKTs+OpcGbmkro32c8oGbr?=
 =?us-ascii?Q?C3If5rXvanDVJN1OWR2w39ey94WhRHlZu0HT+7zvH8IKFDxl3Bz9VuLw4Frz?=
 =?us-ascii?Q?SDNh4P/Bhs294vncX8qskSAzN+vWmcZCBPc+pQARiVVsmYG1s1GFrF1XzlAy?=
 =?us-ascii?Q?XdVdPdlIbxAIaRQCwVTY9yw65l5y5CCPWL1L8yspj8CnMdkClSkyh86zVPPy?=
 =?us-ascii?Q?rTgcG5Obi3pADiQwe3waTrwBOlWfQxAeczdWeXl+K+UQfj203NMjeORz+w9O?=
 =?us-ascii?Q?9osnvT5KQWPcNEVVz2JDv9bZNphIyO7MyxwIzb5DuJZMkQyyDBAbXUKUiHvA?=
 =?us-ascii?Q?L6mK1f6fWrw6PurA1qMwZ0CFf/de3b81UIV75nKaOZapaQHjQE4+G3GvI7yR?=
 =?us-ascii?Q?xkSdkwhw8SKkNrVX+vKfWzm+Vkkqxc4jaVblsPt5LkbRuWmBKEBaJLc5FeFY?=
 =?us-ascii?Q?i6oJWgwGlH8JzYg5jnmtFKBFzJB8ohVOifEx48GxvANes1a9mAcyxu+wBbaO?=
 =?us-ascii?Q?FChGReuM/DaP8LnBaYnRIpOfeJR09AvfxqaOmkqoAHj/QhdZR2Z8QYez9FWV?=
 =?us-ascii?Q?GRjkK4lpFTRibMdP9YSXLC1cEszQ6y4z5cIz9ofqmMtNNkMN+nHPOhUinVrV?=
 =?us-ascii?Q?el0cXJ26ENMFc+nD2ONRIAvIgG4Kp8FAdHQnwFgEq4Ne4okNBYhTfbaUEBMg?=
 =?us-ascii?Q?g2eyl087jX/3RmGoSQMZ3yRLu36xMMYa+TLZCBchH02VWea4G6ebqGbIALQH?=
 =?us-ascii?Q?OIMH4krJSaobs70A21rGNKuiKHQTnxoRgNkFs4xRSA/GyGpXagsVPNYl4uBa?=
 =?us-ascii?Q?OzGbKKEqnLDhy4E89rrirxhgxOKCak2pH+O5AieR2mFoN1SGYndiKf4rgAf6?=
 =?us-ascii?Q?NM9PF8Xq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03310806-7c12-4cfd-d887-08d8986211dd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7662.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 14:37:04.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYlr9RFBpDC+nW871AQnGvau78+vehPA81LuXr3OTFQQ+NIMKKYauIVWccSP5/YC8Dm/4k2YU41On3JeGHU9EYzwscq5CdixszffsrnRcYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7369
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, quick question about using diff-filter in linux. In the scenario
that in my repository, I first copy file1 to file2, then move file2 to
file3 and delete file1, "git diff" returns


diff --git a/file1 b/file3

similarity index 100%

rename from file 1

rename to file3


=C2=A0 but running "git diff --diff-filter=3Dr" doesn't return anything. On=
ly
flag T will return the change. Can this be considered as a bug?

