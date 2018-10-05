Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC24D1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 19:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeJFCgu (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 22:36:50 -0400
Received: from mout.web.de ([212.227.15.3]:36305 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbeJFCgu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 22:36:50 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Luu81-1fhjjj24OH-0101Cw; Fri, 05
 Oct 2018 21:36:30 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Luu81-1fhjjj24OH-0101Cw; Fri, 05
 Oct 2018 21:36:30 +0200
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
 <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
 <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
 <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
 <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
 <20181005165157.GC11254@sigill.intra.peff.net>
 <dca35e44-a763-bcf0-f457-b8dab53815cf@web.de>
 <20181005190847.GC17482@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c05f192b-4e89-48b0-1c23-b43ec6fdb74b@web.de>
Date:   Fri, 5 Oct 2018 21:36:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181005190847.GC17482@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nx9kK+Wlq3jYhs1R4rJylj8g6GnNHI5JhkMx7pziNwJIw7DYaE7
 MOuQslZpHbig8SX4QC6KWsv8crHl/UCc/36wH+DyaMNJoqaLnamlSEmeKeTLl+QHZR5BlgX
 hwJvjOdPGcT4pYBLKQA/3yaXsHbRrlYb9FH6ciXieI66rL4ayoQzO5s5o41mvoPBNB5aTRs
 y71qZ/8jB5q5n1IbomfKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SY0wTdUymyk=:rONqllsk1DFy2duCXbHGG8
 vE8fXgZB8m2eSeMyTI1yuG84Id5WIvur8v/q6XxefLhn0GvJG+GIpHLlIAPzZ4ogGyPR2sZ+c
 nraQ+3mpk9E593TZJR6naZvTd/6Vq3lS20TDYQq4IXPYAqNpgYjMUTaU4WFSLbtHBW7otMStd
 ibSNA4waR7sjYz0a95JscR3gGh+T8sFZ+6YtDfSPLam+fqSLvHJduIVjIloQqY/i/qOaPaLUP
 6M7geQjWiOswXZEMur0Amb3c3ntXaPYKGUKtm5PA/+Bvh1d/AG1bI5Do80Y4TGHbLwv0WucfT
 hhD/jtb27rfbc4XccQA6yZVv9wG9qnFOpThjlax5BVOM8lST7bIKAvJE+GVWnGZ4sAskqew/R
 yix/a735+Y4S9d4VKCVCQmRj6Y8p5fSbsOmWGES8f+2cLOlzF7GbvgtNi1/hk5WBE8YfWqtgT
 /pCu2bO1Bydvr68gUWBL7cigx614/ObIqiMBQsRZ2qjuvHK8HCKcKxRN47zkzW2LiN3/zD2eA
 pzjc6IdFVI89tNf2MVQeh4fmd+5Kxk+6l9ota0NFIKPvjPpecj55+lfYCVbk2ao5zgn7d/na5
 eemmTigwS/v6Zt8bMd4bGZbjwzSK5JLpaykc2zQfLtvViOUINCs5cuNRy8Cu9hBZ21ZRL3KPQ
 qRHHVnSel78tjzaIuL49krqJLwj6WWVlDMoSRE/BhqVQVJ2rg3FiiAagNr2TM3R4tky+l1s42
 mg/CkqPXJ03ABS6JerO1tSA3pohwSbpMBCOLI+wDeWXsO6V0Bgty0xHZekA+fUj7p4YNA1m2e
 lhYT4IYPIGt8p1T4Oo0uONnfZlpDWHl3latwU6lh9IQ6lqxazk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.10.2018 um 21:08 schrieb Jeff King:
> On Fri, Oct 05, 2018 at 08:48:27PM +0200, René Scharfe wrote:
>> +#define DEFINE_SORT(name, type, compare)				\
>> +static int compare##_void(const void *one, const void *two)		\
>> +{									\
>> +	return compare(one, two);					\
>> +}									\
>> +static void name(type base, size_t nmemb)				\
>> +{									\
>> +	const type dummy = NULL;					\
>> +	if (nmemb > 1)							\
>> +		qsort(base, nmemb, sizeof(base[0]), compare##_void);	\
>> +	else if (0)							\
>> +		compare(dummy, dummy);					\
>> +}
> 
> I do like that this removes the need to have the code block aspart of
> the macro.
> 
> Did you measure to see if there is any runtime impact?

No, but I wouldn't expect any -- the generated code should be the same
in most cases.

Here's an example: https://godbolt.org/z/gwXENy.

> As an aside, we may need to take a "scope" argument in case somebody
> wants to do this in a non-static way.

Sure.  (They could easily wrap the static function, but a macro
parameter is simpler still.)

> It would be nice if we could make
> this "static inline", but I don't think even a clever compiler would be
> able to omit the wrapper call.

It could, if it was to inline qsort(3).  Current compilers don't do
that AFAIK, but I wouldn't be too surprised if they started to.

The typed comparison function can be inlined into the one with the void
pointers, though.

René
