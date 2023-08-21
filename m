Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA538EE49A5
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 19:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjHUTFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 15:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjHUTFq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 15:05:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5EE4E
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 12:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RF9N8ETMN6FQx/Z9Zq5RS56zd2vdAJVFFZK3A4ZdGVIHUR4MgOQWD28UT9baMfHV7MFCQlc3qRDzPYh3LLRZTdE657/GIo4v0nOnyYkouLuBV+hr+b0I4O0QMv4A7LKjOyX5mMPTzgPIv6/hyx9XxTQ9H+lnIjB3XY448cKePzaFyqprJRSEMBbh9KfJ6JN0XTvkw2wvKxmYCzruXfDuoxRpoHVJ3iS+n+oN5Jnpj0M46l1hjPRzKT3cEQVhLuMIp3wqWtuiCK9gh5DGmLb9EB+pC8+COYiSvnnbkZ+wKQCIMkPvFg6rGC5ShXjZbYEZRgJMQgJ01AVO2U1zwlD8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMezQ6pT1i/ArW40tgfdiLZ6u4AMtRI293C3nP2etg8=;
 b=BsK+Mf2MGBqUZxjAQBoertCoiV59JPgst/5p0i9NXawk1KVpgSflhXTY0OHfz8mG8FxGZyw1BjGxzuGT+aMM/2kIm6LO731qzAXuZY4ijBbkiSclzY1y+hw0dfX6erFDKus8BZw8ZdMSw8k+ixcnZBc1BLf4nIb3UvRgVIMtvf4MBp9KRQ44B9hJLIpiu/N95qx2aH/6jSAw7n9rVIRh2Bi/0iGCRFZMaIRNdAUkJZeHgvyIZpq692E7OgNoQgHfUdCdX7UErRzDKoUFhVDG7KTu+jurM1kK0Ry0rV9AaQT0B7LlpoPR8Fy1sXc8ICSgHfLWJbAXfxJQRSEctBVzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMezQ6pT1i/ArW40tgfdiLZ6u4AMtRI293C3nP2etg8=;
 b=V9l7NvgxicWwBS7FevO7NOTKBmxkboOztjSAvldcYkGt89GSwcJVE1qvI8abARRVdDLwdRlrizK6eJCk4OjiSHXUCi/uM+1GeXzW/DcCTFu/5GINsdjcFamFAhaV705h81WOLbagh836W4uEk9y4gp8cho6HUSvA/GN21KB45FTG8tSSvtDE2hvL5aKyeLqxWK+IAR4y8tz1BH9q+oO6MVMnj48Os3M4du+/BIU047LQBatX+Ish4V9+pLrMY2sEpn3kdVvx71HMQO6sFeIM8R8LiHGJD2neN+vpPCtaROrfIgfaI4VPl4izuJCp20x9otp556jcjt+2JDyIPwsv3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAVPR10MB7035.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:300::10)
 by DB8PR10MB3880.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:166::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 19:05:28 +0000
Received: from PAVPR10MB7035.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2dfd:85ea:13f:b6af]) by PAVPR10MB7035.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2dfd:85ea:13f:b6af%3]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 19:05:28 +0000
Message-ID: <ed291567-2c47-40f9-bcf0-89bbd6b4b49c@siemens.com>
Date:   Mon, 21 Aug 2023 21:05:25 +0200
User-Agent: Thunderbird Daily
Subject: Re: [REGRESSION] cache.h in 2.41.0 uses undefined macros DT_*
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <627378df-4655-4a8a-abcb-c15ab6602101@siemens.com>
 <xmqqmsykqsep.fsf@gitster.g>
Content-Language: en-US
From:   "Osipov, Michael (IN IT IN)" <michael.osipov@siemens.com>
In-Reply-To: <xmqqmsykqsep.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::9) To PAVPR10MB7035.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:300::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR10MB7035:EE_|DB8PR10MB3880:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bc63bf-8418-4f16-82a7-08dba279950d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RE4E6CZSBFU9KfQvQRfPyfC6l6F1gUM0MaqACRQJR2WHzXqHeLcQ9L5hki6aWI+YEsfSmBnpzzdh/8ooQD03garUZEYkW7X6gqyu+/z2izF2mtt3If1opcHrph/FvHzPb2PTzQ2a0C9Ly7+H2P1Z8yDJREBSxiXgFDoV3ZF8HZaAm3++PABcnZBEXw9X+cMBQLesnhdm9KI8tkIlAmrgw5HvLVbFoqmdfMwH3+wP3yGVMWV+3+j+zeosO4gMsL2wSD1coeoQLwebexKTBlsJo4DEVZJYl5NTykP78uZfuFuy0FOMaimlj3Ge8/DoPkRg8ZNFP/lld3dC7MeBmyDwsYju9hrtw039AUodICHvcEh4Y3DszxhhQ1wjO+c9vERhsm1CMj+qODSbHffT2wIrcMeqq61DMUc25i3Q3VHzIZRTE2cGhgqkMXUlqgtwyVKg1bMDEpUU0qQ5dWS7jhpVbTs73Vv96zdLMvxE2xkhGcg5NTshgzUskmj4+ritAggslgVCzxeRGBus1sbnL35G4PXFMxLtCV3kgj1vn4SzC90m+YQ4hUhS2lZd92pD/bbPQtv+xxrgUAujdNSlZ7cwVPReCcNEsuaX8pF4qMx0xz8oOLodhL3SqdPoPQmpjh1zaY+0OOcIomjcZViFKMkOmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR10MB7035.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(82960400001)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(966005)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(83380400001)(4744005)(2906002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm5meEhkUkp1YkhkaTBWN05NQ2pZWHVQSVJXM0ZiQkJXOW1MOXBMUjRyQkhw?=
 =?utf-8?B?NXBQWGFvckkzS2x6NHhZam90dHpRUUdoakRRbmo1SURiVXRGMytUTnFtSFhW?=
 =?utf-8?B?elN4K3hjMVJDSkFPdlZCQXpzV3BNcVF3NlFHOVgyRmhGWjN0ekpWQjk2aVRx?=
 =?utf-8?B?blBBTHBvcW5kaWpmT3liNSs4aWZhMCtRNmJhRmN6MDF5YmRaRGpxMkpxQTVr?=
 =?utf-8?B?MmVmMHFUUjFjS2hIcndvNmlvQWM1Q1NLNUgzODRuYkVNbEVtSHBINjRrT21x?=
 =?utf-8?B?NjJoRjNlaEkzZEF2cHhqKzgzUHlsUy8rRDNtUXBsZ1NrYkN0UHRwNWpnbVVr?=
 =?utf-8?B?cXBNcksrWTJqR0JjK29nQktYUGZzait6UUNOa2RKS09FS2RKeTk0UXNtTTY2?=
 =?utf-8?B?N3lLSURoTzQrUlkzUUJvQXJXQXFiVFdsaFJFMDY5b2ZubUNXUUt2Zm5EckZH?=
 =?utf-8?B?WUJLcU4zOEFsb0lnVlZQdVVWYjRrOXJ5NTJjbzI4dFloM3N3cGJBYjJXS3lm?=
 =?utf-8?B?Y1ljSlRQeUJoN1JXcjg3TUwxYjNseFcyTEswdVN5bXd4dSt6eEZaYkRXR2JG?=
 =?utf-8?B?QVRaMXcvTERYMzFPODY4bUtwTXc0Zmhhc1pRZVNHR0FxZHZxU3NTUzhQaGZS?=
 =?utf-8?B?WDRwTXh6UEhDNldlU1NkbkNpRWVvQkFhTnRRNGxGdjVwSXlwSDEveFcvemVj?=
 =?utf-8?B?alFVRzh1YngxV0FNN05SRitFSXFtQUcxLzl1UGlIbzQzVU83WHloZmU4cWhO?=
 =?utf-8?B?ZkdGR3BhTitUMis4aktpQ1IxUHNaRlhkYkZUUFJiaHYxZVQrZUFkV0FwY0lV?=
 =?utf-8?B?eTRuWnF3SkJaSHh3Z09idlU3OUdnNGlSRmt2SWVWUElKUUxELzZkdXQwdUpV?=
 =?utf-8?B?Y3lVeStGU1luU05KK0k0cldnbDhIZVZCT1htSXB3eTREMW12V2g3ZlFXb3g3?=
 =?utf-8?B?RSt5ZHRxY1RUekQyVmpDbCsxc1ZFdWJXK0hmWmZQcllCVWdhVVphVG1xbXkz?=
 =?utf-8?B?YXE2ckNlNHJLMVpSZC9wUVlrQytBNmdYZU9kRGZNVnhRVDBQN0dTQnY4Y3Qr?=
 =?utf-8?B?RHJuOERaY0J3VnB5ZDUvRFFPRlpkUDMrWGVKMVc5NFI5YkY3RkU3U2lVeitD?=
 =?utf-8?B?dWtZczZidlVzS3dUbmhyRDFqV01kb1VMeFcySjNGTWV6RG1lbURmOFdBUVNC?=
 =?utf-8?B?SUhOSmtnK2FUZ2RWMHBSMXkzVFlKY25jTjM1ZlIrTS9HY00yV3pKR0poYVBF?=
 =?utf-8?B?aXJGd2daSHpNa21XNDVyV3RkQktEeGlZK3QyTmphS1BKeGdOYzV4MkMwZi9K?=
 =?utf-8?B?Wjk3WG1PcndqQmNrNmNtUDRJaTBrajdDcmlrT01kRU04RXhWc3hyd3U2ZDkx?=
 =?utf-8?B?ajk3UkZkb3d3L2xPby9ISkVwRzNVU3NQQUN0NkRqK2JLVWl6ak1sL0NUMmRP?=
 =?utf-8?B?Y09tbmYzTldSYi9CZTJRRXpqS2luV3dGWlA3NE52am00YU4rSWM5LzR1dVQ0?=
 =?utf-8?B?K2ZnV3hPd0xRY0l6LzZySTJtUEl0ZTRJRzZuY0hGeTJ3aXpVWjRUQ3QzM2du?=
 =?utf-8?B?MDNMdUNyZWNTR0FEV0U4N3ZobW5yS1VkcFdHVlUwUGZYaUZlVklqYkFSeThu?=
 =?utf-8?B?UStMc3oreXppVXpnb3lVN2RHbFV4ZUE3eHFQWVk3L0FoQ2FvQWFlVXdqalh5?=
 =?utf-8?B?VnMyMjd0bk80enZnTkZSeElDRGFjdjBNYkJNanRRbVVzT3o1a2xoemxDMWNr?=
 =?utf-8?B?RDBpVXB3VFc3bmNxK0VGVGdIbVB5TjhqbWIvUnFHYXdwNjE1dlYrd0R6K0h6?=
 =?utf-8?B?cUY3LzBFcitMaVlWam1EZFFzOHhuZXJIUk5GWERnSHV5eDRJRUhGUno4U1lJ?=
 =?utf-8?B?Yjd3VnM0N0c2eE95OXU3SSs1YndLMVVnVUZ2MnRsK2owZjByRDVvNFFTZDNl?=
 =?utf-8?B?bk83T0VmREJOaThaZ25ZM3dWSGJ5U0NTcEVWK0Q3Q2xSZytpSUdkVzNqL3V2?=
 =?utf-8?B?aVVCdmZaWm5sNit4UmVBQjB2RnA0NjhNSC9zMThuOFpmSmxLa2xiQmNZaEhR?=
 =?utf-8?B?dEpjSS9XdWNNRmRRV3hveDVHVzl5clZtZjNhWG4zSVZlNHVjeUI4TTNUQXl0?=
 =?utf-8?B?VWR0ak9kb09HQWFmaGM0SEpCRXQwRlBRMEZtQzAzQXRSZzdSTXhRZVVkSkFi?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bc63bf-8418-4f16-82a7-08dba279950d
X-MS-Exchange-CrossTenant-AuthSource: PAVPR10MB7035.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:05:28.0233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8GFf/XrGPbPivHMp/iRheWnECTnbl1xjt/Z38NBaizzLn+1+9N26TELpMlkRQXGqPvYv84vdeV7Ct+8DssVqhOS8uM93u/6Wh0S25aprsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3880
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-08-21 18:19, Junio C Hamano wrote:
> I think [*1*] on June 6th fixed it, and the fix has been in 'master'
> for the last 2 months, and has been in the release candidate releases
> for 2.42 that have been issued in the past weeks.
> 
> Thanks.
> 
> [Reference]
> 
> *1* https://lore.kernel.org/git/20230606205935.3183276-1-asedeno@google.com

That's exactly it!

Just downloaded fresh 2.42.0 release tarball and it worked instantly.

Issue solved,

Regards,

Michael
