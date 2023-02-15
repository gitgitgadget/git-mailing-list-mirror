Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C31CC64ED8
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 19:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBOTTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 14:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBOTTg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 14:19:36 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2067.outbound.protection.outlook.com [40.92.90.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2B02ED54
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 11:19:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdnKVcqwzZLjN0pl4dq6FjPHX8CYQuTxJGA1Iq+gZnh6b0+wqnntWHYRm478rS3mIt9pr8RnaP4PWsRkyK7vwTt+7rADaBYlgg+0QgymgkQk93KHDNoZVQH/4ZlJ6knEwBEHZKqSOgjEt/ASGGcfGNSup6u02SNhNXSCWZAgcO7B5Q8eYOcFKXReJ3/qPO9LNf0aVdgOuA7Znqk7I7eOFtcO4ufcYhUa5c0GgusXT/YcNbS6sVp8ZHJMeCobZVWAOCsyoAXKWoUYk++X/r2bu9J6q+31LyZzeAUm5VVfzvW0L+aicpYQlg7w98Cac9OScUYsaqJhVp63wCG17raeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMtWG8M63vT8CuK9jVMOYTjQUq6inUP4sTv1dmsvzNE=;
 b=fB6Q+Wkd5l06/R8h2r1HB343/0N5eZgDbNPNDNzataA8auzEQOl8RJ2Xsdjm3MBDbmzSgOQR+7L013e0gtAnspkbBxyuUez4SSMVSKwPFF9dSJKOo1vRMNoOr9uQo4EkWks2tfpZt5hEtfwyrEXzBXP6azQJ/KiJO+myPHA3rbHlw1dbtBRjgBU7JlyOfDR6dlbTbse1yOCiW3PDcDEi497y9/+7kU+DR8u5YJvTCbn2XCW3my4cwBj78DIEnkSciHLhZ/jq80x5K6IUHS7oLIb0nvtQN/aoLD11d44+lBn1CfTqcIBJoUbKjMvJet4vkgAEX8NCqpKUOGTapT453g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMtWG8M63vT8CuK9jVMOYTjQUq6inUP4sTv1dmsvzNE=;
 b=fkdDtFKSYEDJ6Kdh5aMqX1657D8KZ7Ul12DsXmqEElPlee7BdnygAQPuutzzHnHBtHsxSmft4S9/DujxddEr/3kCK8sffLz9xdJiNCG1ewiZymaRxL9VNzehY+9DXiZBUIZX8Kqw6NDP8bCPsPpC9DuSNrrolcJpGsbCHcZRFjMnI70L07D8BmGNPf9KNGB8dNB4HgyKH4IgDBvv43XgeK0m8ByRqIl3QYWLaGogUHkP5DGlmu5MRGEU4VpPbcyZWYlaEaZ0doJTuRdH0WD6+FRDQ+jBxieBC8KRCCQNpeN18qReSgFMIe+WB/ZxoLbdPdaPQgB/vbZo/KG6WIY3cg==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by DB9PR03MB8282.eurprd03.prod.outlook.com (2603:10a6:10:309::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Wed, 15 Feb
 2023 19:19:28 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::7674:1fe5:785:a469]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::7674:1fe5:785:a469%8]) with mapi id 15.20.6086.023; Wed, 15 Feb 2023
 19:19:28 +0000
Message-ID: <AS2PR03MB9815361C9F2E52C71F7284D0C0A39@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Wed, 15 Feb 2023 11:19:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v8 3/3] credential: add WWW-Authenticate header to cred
 requests
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
 <149aedf55010718e22669575a148988eed0d8dcb.1675711789.git.gitgitgadget@gmail.com>
 <230206.867cwu5xmu.gmgdl@evledraar.gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <230206.867cwu5xmu.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [BF2oyv6dXr3a46qyxzDW/vKx5IUQn9NzSJLpj0o19hTrUCpboJ3KJnt2+DrdtXEh]
X-ClientProxiedBy: BYAPR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:74::37) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <37f6dc68-f796-42bc-45e6-a61c6530a85a@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|DB9PR03MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 745d9a8b-fab3-4062-6caa-08db0f898e81
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2KLEy6VWUjdX08kpxTsLOgWMhtceTWdba751wNlNGpy2xYtRpjiowSSWcMQYjqZaUmm/9hgj8AIg1bHA1+i3h+JQzMrMcU5Rb/VoNpfBmReR5+AWCXoFu4eMPrIrpb6Ow906/NWLENdyt75+KdE7nvHT6Bzbuq/q7pSmp/54sGlHjuhYntG0VfaMy/zIQOe8+7Oc3BNbklbJK1EvawX8mVAoz8RuvS1mnNRnx+NtS7jYlNhiR9ViOc/4BWI1jpBtXlB80SjCqB9HqvOfvOhe8GCnrEXW62wBpEY7uHUM5lzgNjvze22bsfwkVegWBFtE5EUPvgRurfQGEpALHiIGMh+OoStxy52oIDmEJehdhYwTPrMfQgujLJd1Ao5TD3VdbTkAfXpFkmvmyDFelP96yHJhpLaRu82mUiBfCIDfpCC4opThZ7feJVtvESRg1KWubXPKdiRd1jyALcFs5qvAxyaESmGHE4ZHxXPPoL0FABo1DV7yn0YMekF0DDnYzt11y0lfSCdBZPZHIP6ucdl9D0rCTnCUkqsM469cLNPKMFGuS2uVcSUWvyDPPn8sYLn3Yjl4zaN6LJPju4usbOcgRuYtCHodvgdfOpm3udmBvZksCk82gYRjWynNK+S3zg5Sy9u8+CeXVPiT+qF6SkDGw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk9DQ090M29xUUI2dzAwc0V3cXhSU0xBKzR5cG04M25BQXU2c3hrMm9qaTF3?=
 =?utf-8?B?ZWtSYnhBY096Y3Q1MkUycWZxWlhBZC9KTjdNUm5IZnQzaWp3Mk01RXFUaHRK?=
 =?utf-8?B?WFhiZmQ0YnF6bndiNkduSGdoWExiVUV2c2RFM3ZpQjdld2M3SDJrc05LUkNy?=
 =?utf-8?B?aFdGNVJpL1VsRjdxR2tmN0Y5Z3RrcXZKRkZPUEFkNU1TODQzYU5BUEgxZTNE?=
 =?utf-8?B?NVRTU1JVKzZhYk0rT3dhWURrVnhISFZVZU9vck9KT252U3gxZGs5TXdNazZB?=
 =?utf-8?B?L3E5OEc0elJMRThYZEIwaytPb1NsalNaWUtrMjRwRURuTjhvL2xOcU9qbldK?=
 =?utf-8?B?cEc5cy9Tc2NzL2Fka1YzMWdmQ0ZpNkdZdnJEVjVIUXlRZWdTTUxjL0ZxcWFZ?=
 =?utf-8?B?TC9ocUoxd3Q1RGJZaEQxeGZ2dXJROHk2VkFOcVBuTjFoTERhcCtnMmR1ZEp5?=
 =?utf-8?B?eW9SQytkQWlORmhFVHlKcEpZanlScGw1d0pmVzh1VFJ4K1d6N0ZnYndLaUFB?=
 =?utf-8?B?YnErRWFKV0IweXdpYW9BWUpRUjEzeVVGS0IxT2g0OFkvd3o1UWN4YmQ1eCtq?=
 =?utf-8?B?N3NIS1FTU2JlLzdka1BzWVo4aE9JM0hPTEMyVzZDNlpWb3hJVGt0NG95N2xu?=
 =?utf-8?B?Z2t3aStqME5ibG1UU0drZVZWMldrRXArK0FzRUNNQ0Zla1V5TTlOZytocHFK?=
 =?utf-8?B?cFFyKzhRZWxsV05YNVV6bVBPUFJ0SXlaQkM2OG5jcHl3NlY2T0NLYjh3dGdz?=
 =?utf-8?B?dEFxT0R6Nk5raXk5Wi9kQjhLSjBYZjd0MnQ2akp0UklXMmFxeG96Um8ySkRp?=
 =?utf-8?B?ZVpLa1JaREU0WmVlRkdIczAweisvN25TRmpKcU1kOFhIQXJLeFBKU3lBTHpo?=
 =?utf-8?B?SmFXa3lBcjRCMHd0ZE45Nm5pcmZjUWY3YVV3cVY0Y05BdzhDZTgrQitvRnZx?=
 =?utf-8?B?NGhOUlI3VSsxT1B4NDRkRUYxWXFMamZsQ2VxODRzTWRyUGpJcFRISjFyb05w?=
 =?utf-8?B?UGlOYUtCbTJHcmV4ODJwWFFMYTIweklHSC9ZVmo3bkw1Z0dCU1JrMG5SL0V2?=
 =?utf-8?B?ZG9kcmxQOGtUMU5UcVl2bXQ1ZEpWcGNiYmU5QVp4QmhZYU9JMUdNYjdPemZM?=
 =?utf-8?B?Qmc0emZlbCtaVjJSOUhyTkJPcVozS0E0TEdtcWFNeWxpMkZiaHpqclZGNXlm?=
 =?utf-8?B?VHcrZXF0NThMYnBHWjY2TmxqQnBubEtmOVA1dnNuSFdLeDJ6Z2J3TjV2ZmVE?=
 =?utf-8?B?QnlIK2FUVS94MjJVSmVKZ0cvRXlydFlBRGVnT0NLeFhNcDJMQTVmWkw2aXJj?=
 =?utf-8?B?eGp1a3ozVzh1RHUzL3VxVXJOcG5ySmUvZ1E4eGlxc25EZlhLdDhPMGcvbHZY?=
 =?utf-8?B?ZjJ1TkxMaWc5YlVUSi93RlM1QWZlSU9uZUkrSlF6WmxvQWh3L0tZMUpDam96?=
 =?utf-8?B?OE1nN3hpU2QzOWlleXA3RWRxOUpPYUdsRG1Vb0RLSmZMdldCSEVpUUxDYUtC?=
 =?utf-8?B?MVdEV1IwblpMNUhUbDFGa2V4VHhjOFJXdURxYmVaejdWQ1lqN1RYeFIrRG0x?=
 =?utf-8?B?bk0xdG40L2tOMmJuR2MzTlhDRmVyWm5hdHZlTkFOT0REYnNSNUlzOFFXay9o?=
 =?utf-8?B?MW8yeWN5aW5kc2x2WHBGdGhiV1VVcXVaOU5wSFd4YzdmWnlzZkxYa3JJU1FU?=
 =?utf-8?B?N1pFa3Fqc3g5T3d2YkpGdHk4dTViRlVSRG5Jc2FQVVdKQXJ2WnVsei9PREVD?=
 =?utf-8?B?aVlYcnZjZFhTcDFLbzlkZDdjQTlyQVJxV09tYXNicW85dlIydFk5dmhNMHpN?=
 =?utf-8?B?ZUxxVU42R0VyYk5PcHBmUT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745d9a8b-fab3-4062-6caa-08db0f898e81
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 19:19:28.5246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8282
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-06 12:45, Ævar Arnfjörð Bjarmason wrote:

> 
> On Mon, Feb 06 2023, Matthew John Cheetham via GitGitGadget wrote:
> 
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
>> @@ -263,6 +263,16 @@ static void credential_write_item(FILE *fp, const char *key, const char *value,
>>  	fprintf(fp, "%s=%s\n", key, value);
>>  }
>>  
>> +static void credential_write_strvec(FILE *fp, const char *key,
>> +				    const struct strvec *vec)
>> +{
>> +	char *full_key = xstrfmt("%s[]", key);
> 
> FWIW you could avoid this allocation if you just renamed the current
> "credential_write_item()" to "credential_write_fmt()", and had it take a
> format instead of its current hardcoded "%s=%s\n".
> 
> Then you could have two wrappers, credential_write_item() and
> credential_write_items() (instead of "strvec"), the first passing
> "%s=%s\n", the other "%s[]=%s\n".
> 
> Just a thought.

Given this is the only `items/strvec` that I'm writing out, just inlining
the for-loop and calling `credential_write_item` directly with the key as
"wwwauth[]" would avoid the allocation without needing to make the write_item
function more complicated.

-static void credential_write_strvec(FILE *fp, const char *key,
-                                   const struct strvec *vec)
-{
-       char *full_key = xstrfmt("%s[]", key);
-       for (size_t i = 0; i < vec->nr; i++) {
-               credential_write_item(fp, full_key, vec->v[i], 0);
-       }
-       free(full_key);
-}
-
 void credential_write(const struct credential *c, FILE *fp)
 {
        credential_write_item(fp, "protocol", c->protocol, 1);
@@ -280,7 +270,10 @@ void credential_write(const struct credential *c, FILE *fp)
        credential_write_item(fp, "path", c->path, 0);
        credential_write_item(fp, "username", c->username, 0);
        credential_write_item(fp, "password", c->password, 0);
-       credential_write_strvec(fp, "wwwauth", &c->wwwauth_headers);
+       for (size_t i = 0; i < c->wwwauth_headers.nr; i++)
+               credential_write_item(fp, "wwwauth[]", c->wwwauth_headers.v[i],
+                                     0);
 }


>> +	for (size_t i = 0; i < vec->nr; i++) {
>> +		credential_write_item(fp, full_key, vec->v[i], 0);
> 
> The {} here can be dropped in any case.
> 
