Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38728C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 11:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB95610F9
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 11:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhILLg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 07:36:59 -0400
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:20822
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229635AbhILLg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 07:36:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHGekmDJ5QexnnsDJMBMzZRm6nn155PofQSXDQibD9issQbLF/fJOzg2bHNJUws6zLkvzzoN1mReRgtkd95HarNnyyXOhDeK0WVhy2fPZfmyrigEZH9OvUYnh4SeHMcxD0ldABpsnC28AKKrIAiVEVC24SAZjRA7lKJ0XTxDg1fpzyckVA0mq4gzD75W5HFVRyOyVY912zuw1l2f+pOkdrPS6Y0Zlz52Y/0Lb/kkdtznaq1Y4rBIctmFzcuIeVaaPKczT7Jmym0AFN38uPQOcpdS8jgCrl6CFt6BYusylEZ3yEyY2jOPG3mE0gxfsB4jYJbgyqi6q598hDvNV77Ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CBzPb0o75buoCbq4LMy1NngQt+bXLaKrwwaJPzbzh0w=;
 b=FGa+toLaN/FtDjM9KRnA/ZH4jr/sxr4WZlWy9MVDG6nDhtjpIv+c6XelNSST1m0R3rkVIVEmEOrSxvjFDk1rZQDEA3tCmODKLAgd/pbiyvIh/c9E/CsGVlLwzj6aSgMZycQEBp3QShfEkbGIyq6HFXS71izqXXzzGpjvy32fIF3JKSgZBRlikVWwUg28RpZU+n+i6R05Q9z6kwJabmPpqVwafGgxsLvzySqu7cbCrhMM0j7VFESXVFYf/tlA+4uBfO9sOFzSSLsQ9qQcNB3ZcSWBawWNKeJVHgVl8CZYrw1+jk47EPrXppmZCdgrfFjbnFTE2XN/yKlKRf5W6brocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBzPb0o75buoCbq4LMy1NngQt+bXLaKrwwaJPzbzh0w=;
 b=HUrrkZb/2+pFL+s19v9Y/xEAmvG7fVkbqtCny61Cwlw9a9chI6GPnAnmFryoAKJkLvqy3XGRzppydvmal8T/LH009qYA64o7KBmNInIwNRXAlCkCC/6yy1TBe8bbj5DyelZnSfMwtdy0HQGAmluszThUBAZDmlLvzieG3yYDKT8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Sun, 12 Sep
 2021 11:35:43 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4500.018; Sun, 12 Sep 2021
 11:35:43 +0000
To:     Git List <git@vger.kernel.org>
From:   Fabian Stelzer <fs@gigacodes.de>
Subject: Question about timezones in commit & tag dates
Message-ID: <b39aab0a-bf53-9e33-59a7-d4f1a06e72a7@gigacodes.de>
Date:   Sun, 12 Sep 2021 13:35:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR2P264CA0006.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::18)
 To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:178:20a0:d22:c58d:d0a4:a83a] (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by PR2P264CA0006.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Sun, 12 Sep 2021 11:35:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e194fab0-822c-43e4-d09b-08d975e17444
X-MS-TrafficTypeDiagnostic: PR3PR10MB4015:
X-Microsoft-Antispam-PRVS: <PR3PR10MB401587878DF4650DC7E6D14DB6D89@PR3PR10MB4015.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1oPAri3fvkHdVesRZ0ZgDNt/J6ikwwZz9mgXFjdWH/6i7sekR8M+SaAuBxAO7Whpmkb49lolKQrGr0wqEEiTsuJmvdEvKX+Cyj8jgRY1T9io3E8UzVj5CPt+el9Bvj1LNX0OjGOKqhsPmvpr93J1yFBeR49rfDaaR9VHjWb/u29mlezwRVh0QRzpN5BEeG2dxYyPEKNK4m8lMdDSJvAL9QsnbvgTVWRiHxjtulTRZCaJadvL+KruVhlJEiok3BRxR8CfZWAle/gXKr7SFIhCWvOroyx8MVCiCN5wYkHTl0qPnn0GSL1aq9ONJWwbBEBpLL08fZgAiEy4xtNM2Id/9pyjZztuirlmm5muFu/NQgluDSV4FMspboIJTK0lny5/Ana1GFmZb3YCCpTYKPiDoP9aYrQN3BOPe3MQ/EXY4EmHY8SEsvMwkBz5icTZkAtQLiGIG+TrWmj6M6L/pqyjloN/GdgswC6Ft+Mgw2jfAnMGjh6zKk6UYtXIOGDamjetaMT+BfMsANPUOayXeu0IjlYrLmsPRmT07Kq1Qihn/dJr8NaWPcahTCw7qCWXkx+ukzCMaQ1WZzwqy6ebz6BjxcASGIR+IDEEbWY27ZGz2/LBpvVru+GxBFAMQrf8CITXIIWS7Bhct5+M1RBe86NYIyM9dPYRw5xAuhLrUVR5BWtflHuMdrvkYSudKAShzLeTBnCiRDJ+Uedc4jDUGtISZ4w0UZUKECzgxiSYVDEiD64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(376002)(39840400004)(186003)(52116002)(66556008)(66476007)(2616005)(66946007)(31696002)(316002)(31686004)(6486002)(8676002)(2906002)(8936002)(36756003)(6916009)(86362001)(5660300002)(478600001)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGpIZEZYSWFSbjBibStxQ3V1dS8zRnozd25OVk0ydmJubUFqdWhSWlZ0STN3?=
 =?utf-8?B?SHhBU0I5cUV3SENxd1ZrUXZSRUFZT1lqM2hHL3R3cTI2WmNaOXpPVU5yaVhJ?=
 =?utf-8?B?U1g1bUVDeFg3UEQ3d1Fmc3FBbjlYRUFWaXVUak0vZzIwQXBOc1pDcWlCcjBW?=
 =?utf-8?B?Y3NvQkF4V056SjhUZG9ZdUMzK1hXYThwU1ZuL1haUk5EanRUekZOZWtIaE44?=
 =?utf-8?B?bU1xb2QzS2VhSGxiYmJpbFhLVzBFUlc5OVljVDY1bXFTSWNtR3I1d2l6Wkdp?=
 =?utf-8?B?bFlRUHl4UFBTMzIwQ1M1ZG04QTRFelQ1K2lhYzAwS1NMaXNqT2Zva2F3RE9N?=
 =?utf-8?B?cHFpc0VwdzY1YkFNeXRLNC9nRUd3MnYxeWNxQUI0cllodFJNcU41WXkrdVc4?=
 =?utf-8?B?UTZGcFptWk9GUkg3YjBCQi9lWW5SNlBSdkxNM2hIYll5NHFFalJYMXkvQU9m?=
 =?utf-8?B?RHFaaHp4TldzbG5HTndWTCtkSFBPV3hxK2RURlp6YURoY2w3T09PSkVudWZK?=
 =?utf-8?B?RTJuSW4vUjM5OWlnS1JnTXprR3ZOd3VTZ0xsMGJLRHRjeDNGQkE0QjJ4ZG9D?=
 =?utf-8?B?MS9Sa1VLNnJUbUd0Z2lidDU1dG0vV0RPK3lBZXRjdlMvVUdSWmtpYjV4V294?=
 =?utf-8?B?QXFmTms5aVcxRjRsVXpPWlUwTjZFZXpNQ1NiOUZkZjE3Zm4yVDV2NG1sbHU1?=
 =?utf-8?B?TVJjY3NPUHVvVmtQNmxXV3lQRUN3SjBVM2t3MithTnNZZDlLZ0VaVmxxYnFF?=
 =?utf-8?B?OG5FdjhJSmFvdmlyVmNwYkZZRzdaamF2ci94TVpoaVRDZmVWemxKeURNSFk5?=
 =?utf-8?B?aHFqU1lOY3RwWWdJNHJXVTB6OWhoTjJOekVMMTBLays2dG8zMy93UGU0YUNm?=
 =?utf-8?B?OUl5TUtKd2hpYm0yQ2s5cks4WEYvU1dOajRtR3lpb1JaRUVaTjZPd29CK0Jv?=
 =?utf-8?B?RzVpN1NSVUV4YWx3VXZpeFhYZ2xFNmNKSlZ2WVBNcXAwMk5JRGJBOTd3RXFU?=
 =?utf-8?B?YlFwbHozbzdVYTVuV2hWWW50QUpxTGRXMXRSMHFpaGRkL1BFbFNCdGZ4ZW56?=
 =?utf-8?B?ZCtkckUvUVRXeVlSMGFSUXJlWGNFbVdmWTU0MzNuUFAwWWRxL3ROT1NjZVRk?=
 =?utf-8?B?NGs1ejYva0xsKzJLRkZsT1lvTExrVFlyN0RVOW5xSFZNT3lEbHFNWUhaaWYr?=
 =?utf-8?B?RXdqa1Fxc1VvNmhXWkFHUFRheEVlWml6WEdMM29wZm5OanRTVTFrM3NyNTAv?=
 =?utf-8?B?ZnVUb3pzb3NpcWNMQTREeUVHZjE2bXZNK053ZU83Slk5LzNrdFhaSUJjaDND?=
 =?utf-8?B?a1c2ZG1mU05aemNGNXlDZktNTjFWY2N6MGhxTm50UnZlL3pmaHBsV0hqT0NJ?=
 =?utf-8?B?VnZEczZMMVpUU1dpNktBSHBsRktlOGRlM2dkWmZXTGJ5RDljSVhXeTRJWVpT?=
 =?utf-8?B?eW9qTisrbVhnN1ErTmdLZVMrNFNGeXBxSmlvZk9hMjgvR01sQlRaVHl3QU5z?=
 =?utf-8?B?MG9HR1kxeDBmVThhK0RxQzRXNXMxZ3h0NnFUZVNKU1FMK25SZEFoNndQY3Zw?=
 =?utf-8?B?ZE5CYVdYZG54aUJmdFcxTkVDRzZ6cHp2bkRQak1lVTJoNEphS0VmRVh1SWxa?=
 =?utf-8?B?WDNWbVBlYlkyY3BoTXBxdlBEdThNTEUxS2ZqM21sZGFmQU4wOUZYUzA0d2Yv?=
 =?utf-8?B?QzZlTUdES2w2akg1YUd0WUZMVWh3V09LYVNISXlUbUtvNy96NVhBNFJ4Q1BR?=
 =?utf-8?B?N0czUDREWU5UbzBwTXFtNm9TSnd4WVFYdGtuazBtTTVJdkhwWk1JTkk5ek91?=
 =?utf-8?B?a29VcnBDQmR5cFJOZFNUM0F5NXV2SDFmSFdMUlVUWm5zT09WcTJ3RWVZdEdJ?=
 =?utf-8?Q?Q2rxHLvOCvqEC?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e194fab0-822c-43e4-d09b-08d975e17444
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2021 11:35:43.0076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qG1WZhmVUok7C1t/xrZO+abdDRxnJqUTLNW8QHYvcnLQaJg9vDemoy2ZfhFQXbVsvQmX5bu6IBfMOdNurAAk89cPi2pAILL3abwZgEdAFLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4015
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
while working on correct key rollover and verifying signatures for past
commits for the ssh signing topic i am trying to understand how Git
deals with timestamps for commits & tags.
For ssh signing the user will manage expiration times within their
allowedSigners file. Those timestamps do not carry a timezone and i
would assume a user (or automatic generation of this file) will assume
the systems timezone for them.
Therefore i wanted to pass the commit & tags timestamps adjusted to the
system timezone to make sure key rollover will have no gaps or failed
verification's especially when commit and system timezone differ greatly
and might roll over to another day.

However the commit & tags structs only seem to carry the objects
timestamp as is, simply ignoring any timezone information. For the ssh
feature i can easily enough parse the ident line again from the object
header. But while looking at the usage of the existing date fields i can
see that objects are sometimes sorted on and compared by these dates.
When commands provide cut off times (--since) i think they might include
or exclude commits erroneously when they were made in a different
timezone around the cutoff date. ("log --since" indeed gives me some
unexpected results when mixing multiple timezones. Based on some simple
testing i think it just stops output when a commit falls outside of this
window, even though there might be one before it wich is within)

Is my understanding of this correct and this the expected behaviour?
I think generally for git this does not matter much. But in certain
situations this is problematic.

I would have assumed that git would either add the timezone as well or
adjust the commit timestamp upon populating the date field in the commit
struct to UTC but i could not find anything like it.

Best regards,
Fabian
