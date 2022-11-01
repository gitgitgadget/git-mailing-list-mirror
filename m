Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E31C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 23:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiKAXOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 19:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiKAXOs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 19:14:48 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-oln040092066108.outbound.protection.outlook.com [40.92.66.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAC7DED7
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 16:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbIjB9kDeOME15BigXqYGydboYoOWBdu23KONkH/si6qWUVt7qM8qeWhfEGNdVqm3jGajd18neIBHp7LH6jKkEbZ8rOk8PEK+Rcsi1kBBlZZYryGIj842uwrrXnu4AOgDcNpXjL1m82JrHmGuD1tGU3bPmo1ypl6D1gCNDT6d64dPycX6MGaMV0LjPaA59kIzYiqDLvK5uE0QPxyqqOQTtQfzfgWuNySYYgd51106Oe1CyQlO3nFHYqHLzGvhxzE0GhOEzNzJmeA3a9Na+TE+urx2Odv4tskoxXJ0jgpOwU8LZkaXLy+594TssJCAJPt11/PcW9+3IeHW1dVIXBHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVgArnAlOLkmu21iCVIFryoyOiac9Bk5KkLCR0+S4kI=;
 b=ICeQD7HKALMgMMK1YCzpsugpe1fBe+8roQE0XQZx0cb17/qOpSN+RoN6tc9t2xvqCK+inUE5tndVSJJkQ0tl/KqcxnFkp/JN5B1IZD+UQwG4wB+NAcfCDB9UL16laKWxBmqW6N/FWUxjt68LfH3IyX1GGIo8VGPk+3HCOrO5pIhdeO7j5GQtARIiZ3WJ24QivCKyp+nyvqYw/esRLEzIKfhcFUrVLYYawFE06k5WOI2bZeDqQFuYhSKVkuvyDa3hipJI7B5GbQcOwLOhmVULELup2uqYSbiIZMY0HwoedVE4V3yd9+7hr6ciOgEoYzsxAGDNaWKx0CYyxz2BRVGoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVgArnAlOLkmu21iCVIFryoyOiac9Bk5KkLCR0+S4kI=;
 b=q82M7CuRKXUt8LznCYvy72aeqxlI8Q2NN3pmMsFVSqNE1WfXqvrKvK4W36nBhfawCeEYbW9eXh/Da7lo3zAoHgyOvI6ccmqtklVqb8zaUXZPRvikAmzNwzgUBA5SYHKqnFL/qM59+ssO/9mjID2+os9rhbOHBc+lgLwp81wdDM8oA+iyYsgJEKaAJCwauYUK+UrKas9yPgbwQm8Oe1XvP+mhiSjW++mgONPU14X5PurYXnUVb6lNOF5SaYQXhDBnD2q/nou/t9ckSvwzzb+2HfceoGDKiHzbBdKAN/mpIZpPJ+Y4Naz7PHwYLykGPrGn1aZ6zk54dGW2YBwXZ63ZVw==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by PAXPR03MB8081.eurprd03.prod.outlook.com (2603:10a6:102:230::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 23:14:44 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::a3b1:6b8c:97ce:8e66]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::a3b1:6b8c:97ce:8e66%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 23:14:44 +0000
Message-ID: <AS2PR03MB981549CCF945BF26DD212BDBC0369@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Tue, 1 Nov 2022 16:14:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v2 6/6] t5556-http-auth: add test for HTTP auth hdr logic
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
 <f3f13ed8c8238f396163dd0e6a3d6c948c2b879b.1666372083.git.gitgitgadget@gmail.com>
 <8593dd49-4d95-ed4f-b414-8170efc138d4@github.com>
 <d61d8881-ce58-de02-2c3b-e3cc812e316a@jeffhostetler.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <d61d8881-ce58-de02-2c3b-e3cc812e316a@jeffhostetler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [trYNLRNPUppyuCaxySK7m39rUTjo5/rsxsZIQ0PD3orr/yDrDKldI+quOB9Eb7Nl]
X-ClientProxiedBy: BY5PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:180::19) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <da943b86-cc2a-2596-ba2e-775ba94528ef@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|PAXPR03MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9f8cdb-b905-4ef1-dfd1-08dabc5edc28
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1m2rto7wAGfN81beenn3qpDiT7rbyi01tVXJCLI6meOi71K3P5ek/0jj/GdXvSLxQC8WeULtdwXiCAj1u2t8EHfHVWOUZCAZ7gYsIjOccADkFTozmxv/j7Ytx/Vi/wat8u/hMvXOk/q8vVKWKFoxx/FOLNRv+lg61y6K50EYgK9Nf1mYa/nIPPo0uEEkLOb4OnMmqYgYSnmRbMdkwbCdkNc/67r3ZeJnKr10o4+rH4Wh/rdreUfUnUNpLJ8tN+y+30J3mPe533Qdx0oc+h8ySXf32b8oTuWDy/e+SQBQfQQU/fN0JQaB2QXMQ39XzwgTGiewl0mH95rioo9vYyhQZOgVMWx6cXrNPxAsya5Y47eng+KYUiCg8YfAkx7B2ov+AOI9FYQIfsYxKVMHvyeVM8qblkjJu64Qphd1OpfZd40T03Kdyq2UczwzTUUKBzy+K7TrYfhzFOOcNhZIm7gqD2nC0g95n7//zualzUr/0yXNgsZQlP/v7fwHO6DhQebPeNEWLGZz7cOfMm3ZNH5D+OeiwuC1qfoc7iOAMIGeVhEORYN3oYI9w6MVpcG8IGdAxwu197T+k9r6I9MoP5k1UaM2FiM4elrGiut+okZdeQuTPPfWGvX+EUFrHvsTjN3X1QFUbyUxNOYEHoM+ak0v/PBpcMJwLrsvnCz/MnpGwH44ueyNrpS6q7LYeBVTLL+J
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWYvWi9WZmtEYjNTN1Y5RTJhYmNSVmpXU1JRbFBEckNtVThacjRXVG5lUEpB?=
 =?utf-8?B?VDIrNkdSeXYzQ0N4cXFTSzBFR1NqZ0xEWU0rOUFkcFd2U3hpaHdnSmx0RGk3?=
 =?utf-8?B?cU92QTFtSVBQNnllN0FibFdwWDBBVUZsUXpoQ2V3ajRLZTdWM2RaaS9LMDU2?=
 =?utf-8?B?aTlsSGtIOEZTYS9LcGoxUVR2ZDVkaU1lblJsQitDcHh6SnplZTNVUDdoVCsr?=
 =?utf-8?B?SVJOQVpoWVhVN0hHVHFtQ3lORGl2MWc3bjQrRk50d1RjQzVlZE9rOEJsdS9z?=
 =?utf-8?B?K0lNT0FPKytMWS9mRzhZYnoyUkNkaXRFQVZyTFRITEJEVng5cDVkQnhJaHAv?=
 =?utf-8?B?cHltbUNObzQydlB0UDlKR0p3bWFSeDNwa29NM1NxaTB4OW9TT2cxRWRPb0lX?=
 =?utf-8?B?WnVMQ053SWdRUStMeFFMTmRzZ3Fad21XSVlNZm9kOW9rRm9oVVY0dkQ3QXh5?=
 =?utf-8?B?SnprbnIzUmZoeXVuRlFNUFF4V1QyWngvalc3cUhtTDZvTmZmeGJQQkZGTTZY?=
 =?utf-8?B?cys0Q2tQZ0NjZjVSSVM0RG1sU1Z5b0dCcDk0ZjF4ZjFKdzhiRXpLeHp6TzBo?=
 =?utf-8?B?MmdKWnJVYVJHK2ZLYU5MOURvWEhkYi90d1ZuN1ROTk1YVmY5NmcvRk1UK2Ji?=
 =?utf-8?B?ZFNVMFU3dk5BditOSGQ5b3NZdmdJUkpsRVdMK3AzUGEvVk1EVWJCa2ljdFJu?=
 =?utf-8?B?N2FIQkoyUmJWQVJjYzR3MHlyN3dQenNueVprNTdTY2RHL3gzUkFjY25ZVzFn?=
 =?utf-8?B?cTNuTmMxYWVBNnNpTEdvbnVsRmZtS2dvR1prOHkvbXJ4YW10ZXZwd1NpWW5R?=
 =?utf-8?B?UnVsSGFPbzFBNmVtYkZEelVoOG9RU1BzemRndktxV21qSTArWTlmWStEcUJu?=
 =?utf-8?B?dmVoRXN2K2kwU2phWVlwaWVaUkJaeEFkRHIrai94NFZobHFrbkVvS002YUZn?=
 =?utf-8?B?bVNJcmk3MS9IZ1ZMcVpWQ1lIZVhJM0RGdTh0TkJCMTRUbkFCdS92VU5aSkIz?=
 =?utf-8?B?Mk44TkRSYlhhNmwvYVZvYTN5c1BYOHM1L0lMS0dSV1Y1TkNJcXFKMURmSk5t?=
 =?utf-8?B?enRsSEhxRGtsNTEvTWJ4MnpoRHRUZmU4c0F1dWVUWFNlSGRqMDFRb0M3NzlX?=
 =?utf-8?B?UTJPUFVTUlh1WS9abW5oSEtwOFJTL3kxRFNyc0lTQTYzUGhDNXkxWkI1M0gx?=
 =?utf-8?B?ZUVrcTFUYXZDTm8rbUIwbjExekJObUxpTnpOWFJ6OHBFcmJpUlRKNWNLVnJu?=
 =?utf-8?B?VmdLOEZ4eFN3Wk1lNVM4dDFVcUFMQWJxR1Zja0lWbThqYkd0RHVjandWM0h6?=
 =?utf-8?B?OEtoeDl2Y2FYRCttUTZKbThxWk1TemJTZGZRQkVESCtOYUcrSkxPbjg4ZTQ1?=
 =?utf-8?B?S1pySm5TN0tRaTZybFo5YmlYUXc0MWhWamM5OStuSTEwZEpDT3NuelBqRHdW?=
 =?utf-8?B?VWtnVCt2RUlKaDZFeU96b2dRSkF3dnpLdWdiZktqR3cwc2JmcnZjK1F5bEg4?=
 =?utf-8?B?NnFVdDFZTWtLekJFZm1HRmdRWU1tN3ZCUlZ0QmJydE5uaFVLQ3RDalB5TFAz?=
 =?utf-8?B?S1hJaU5sa0tYNHViWFRCQWZ5dFJaY3liYlRFUm9rblRyTkh0a2UzUlg3b0Zm?=
 =?utf-8?B?VkYybHpjT3lhcm9uTXlqK3BPeHVqUmdrenRyd2pOWDBRNTB4SnN6aHgzcDJr?=
 =?utf-8?B?QzFMUjVTYjRJNHBFL1BVUVo0eHoxbXIxK0I4TjJ6Rkd0bkV0SUtzM3JOMmg0?=
 =?utf-8?B?Z25BUmhTR04wejBqelpIQTZjUm9oTi96eGdZYVJBbHdaR1FKREZNams1SU80?=
 =?utf-8?B?bzhvM3FRNnhubWFibEw3QT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9f8cdb-b905-4ef1-dfd1-08dabc5edc28
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 23:14:43.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB8081
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-10-28 12:14, Jeff Hostetler wrote:
>
>
> On 10/28/22 11:08 AM, Derrick Stolee wrote:
>> }
>>
>>> diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
>>
>>> @@ -0,0 +1,1134 @@
>>> +#include "config.h"
>>> +#include "run-command.h"
>>> +#include "strbuf.h"
>>> +#include "string-list.h"
>>> +#include "trace2.h"
>>> +#include "version.h"
>>> +#include "dir.h"
>>> +#include "date.h"
>>> +
>>> +#define TR2_CAT "test-http-server"
>>> +
>>> +static const char *pid_file;
>>> +static int verbose;
>>> +static int reuseaddr;
>>> +
>>> +static const char test_http_auth_usage[] =
>>> +"http-server [--verbose]\n"
>>> +"           [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]\n"
>>> +"           [--reuseaddr] [--pid-file=<file>]\n"
>>> +"           [--listen=<host_or_ipaddr>]* [--port=<n>]\n"
>>> +"           [--anonymous-allowed]\n"
>>> +"           [--auth=<scheme>[:<params>] [--auth-token=<scheme>:<token>]]*\n"
>>> +;
>>
>> These are a lot of options to implement all at once. They are probably
>> simple enough, but depending on the implementation and tests, it might
>> be helpful to split this patch into smaller ones that introduce these
>> options along with the tests that exercise each. That will help
>> verify that they are being tested properly instead of needing to track
>> back and forth across the patch for each one.
>
> how many of these options were inherited from test-gvfs-protocol or
> from upstream git-daemon?  If most came from git-daemon, it's probably
> easier to see that this was a cut-n-paste from it if it comes over in
> one commit, since all of the OPT_ processing, usage(), and static global
> state vars will come over together I would think -- rather than to build
> up the arg parsing bit by bit.  More on this in a minute...
>

Only --anonymous-allowed, --auth and --auth-token are added over git-daemon.

>
>>> +
>>> +/* Timeout, and initial timeout */
>>> +static unsigned int timeout;
>>> +static unsigned int init_timeout;
>>> +
>>> +static void logreport(const char *label, const char *err, va_list params)
>>> +{
>>> +    struct strbuf msg = STRBUF_INIT;
>>> +
>>> +    strbuf_addf(&msg, "[%"PRIuMAX"] %s: ", (uintmax_t)getpid(), label);
>>> +    strbuf_vaddf(&msg, err, params);
>>> +    strbuf_addch(&msg, '\n');
>>> +
>>> +    fwrite(msg.buf, sizeof(char), msg.len, stderr);
>>> +    fflush(stderr);
>>> +
>>> +    strbuf_release(&msg);
>>> +}
>>> +
>>> +__attribute__((format (printf, 1, 2)))
>>> +static void logerror(const char *err, ...)
>>> +{
>>> +    va_list params;
>>> +    va_start(params, err);
>>> +    logreport("error", err, params);
>>> +    va_end(params);
>>> +}
>>> +
>>> +__attribute__((format (printf, 1, 2)))
>>> +static void loginfo(const char *err, ...)
>>> +{
>>> +    va_list params;
>>> +    if (!verbose)
>>> +        return;
>>> +    va_start(params, err);
>>> +    logreport("info", err, params);
>>> +    va_end(params);
>>> +}
>
> ...Maybe it would be easier to see/diff this large new test server
> if we copied `daemon.c` into this source file in 1 commit and then
> converted it to what you have now in 1 commit -- so that only new
> code shows up here.  For example, all of the above logreport, logerror,
> and loginfo routines would show up as new in the copy commit, but not
> in the edit commit.  However, that may lead to too much noise when
> you actually get into the meat of the auth changes, maybe.

I take from git-daemon and the test-gvfs-protocol helper from microsoft/git
fork, but then also delete lots of not required pieces too just as much as
I have added. Copying git-daemon.c, to then delete, and then add feels like
lots of noise.

>> I wonder how much of this we need or is just a nice thing. I would
>> err on the side of making things as simple as possible, but being
>> able to debug this test server may be important based on your
>> experience.
>
> i'd vote to keep it.
>
> [...]
>>> +static void kill_some_child(void)
>>
>>> +static void check_dead_children(void)
>>
>> These technically sound methods have unfortunate names.
>> Using something like "connection" over "child" might
>> alleviate some of the horror. (I initially wanted to
>> suggest "subprocess" but you compare live_children to
>> max_connections in the next method, so connection seemed
>> appropriate.)
>
> These names were inherited from `daemon.c` IIRC. I wouldn't change
> them since it'll just introduce noise when diffing.  Especially,
> if we do the copy commit first.

Indeed. These functions are untouched from daemon.c. I do plan to split
this mega-patch up however in to a single 'add the boilerplate' based on
git-daemon patch, then add the extra pieces like HTTP request parsing and
the auth pieces in a v3.

> [...]
>>> +static struct strvec cld_argv = STRVEC_INIT;
>>> +static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>>> +{
>>> +    struct child_process cld = CHILD_PROCESS_INIT;
>>> +
>>> +    if (max_connections && live_children >= max_connections) {
>>> +        kill_some_child();
>>> +        sleep(1);  /* give it some time to die */
>>> +        check_dead_children();
>>> +        if (live_children >= max_connections) {
>>> +            close(incoming);
>>> +            logerror("Too many children, dropping connection");
>>> +            return;
>>> +        }
>>> +    }
>>
>> Do we anticipate exercising concurrent requests in our
>> tests? Perhaps it's not worth putting a cap on the
>> connection count so we can keep the test helpers simple.
>
> again, this code was inherited from `daemon.c`, so we could leave it.
>
> [...]
>>> +            mod = xmalloc(sizeof(struct auth_module));
>>> +            mod->scheme = xstrdup(p[0]->buf);
>>> +            mod->challenge_params = p[1] ? xstrdup(p[1]->buf) : NULL;
>>
>> Here, you xstrdup() into a 'const char *', but you are really
>> passing ownership so it shouldn't be conts.
>
> There is a strbuf_detach() that will let you steal the buffer from the
> strbuf if that would help.

Will update in v3 to drop the const.

> [...]
>> This was a lot to read, and the interesting bits are all mixed in
>> with the http server code, which is less interesting to what we
>> are trying to accomplish. It would be beneficial to split this
>> into one or two patches before we actually introduce the tests.
>
> agreed. it is big, but it does make sense.  perhaps doing the
> copy daemon.c commit and then see how this commit diffs from it
> would make it more manageable. (not sure, but worth a try.)
>
> [...]
>>  From what I read, I don't think there is much to change in
>> the end result of the code, but it definitely was hard to read
>> the important things when surrounded by many lines of
>> boilerplate.
>
> agreed. i think the end result is good.
>
> Thanks
> Jeff
>
>
