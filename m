Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1301F404
	for <e@80x24.org>; Sat, 25 Aug 2018 18:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeHYW3T (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 18:29:19 -0400
Received: from mout.web.de ([212.227.15.3]:56179 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbeHYW3T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 18:29:19 -0400
Received: from [192.168.178.36] ([91.20.53.4]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M09z2-1ffH4R2CVg-00uN13; Sat, 25
 Aug 2018 20:49:23 +0200
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
 <bc9f21c6-b362-2e3f-1820-7da93a76a7c8@ramsayjones.plus.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a2577ecd-52a4-1343-a0b8-bbf1883db619@web.de>
Date:   Sat, 25 Aug 2018 20:49:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <bc9f21c6-b362-2e3f-1820-7da93a76a7c8@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jag+laWS/fSXMw5m1xRJfi8x9C3NiAGEDLy91lv9DjfWEFwItbG
 1VkgJbqE4wLogh3w0mT59IB5PLE8tdjyn60383/gjR+HSthVt0327tUCSYZghMgDfiscopH
 rEU8G2wxxNpjfUXfJLiCKHOWtEr3pV1Kx8uAEqF3saHQ3/yj+PfsymBH9emw5d9Uf8lKa5e
 EIpwmHeqNML5aGeqq9BDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qSNQHYBcZAE=:tYeSosZytqLiaHGMoj0wkx
 o7hILk9W32KO3VS96fEuBYs5ZZPtiuopy8odJIDKynz6j3/G57pusU3/7ZFrzdpCsO6SCbHR/
 iJYdscEwqf+i6MQaoLfmFt+9ZYzbvx+98hug5ekJJWAYgx2vIjINXH+89v23UsPxC6Ee5+REv
 asnjL71Q+KV/TM9Zy6rxau2Q0o8QvMbZu3GMxll8z26oZdHaCALQErd9H+RhulV97E0qERsHD
 NOWGgNicQsL+RcCSw/1Qxkryo36tAPdSOWm1/K/aky2/mdnmlpjBT7HfONTTmhsgijWO7d0mY
 xtRwqL0QYO6Zs03RqgOH0ZrehPXqvdSH5R+/XtUe1bl0QIaBHtc1SAnCkkr+k4+8x3yD6ut1O
 b/Swi3CB7ho7T8sgQmqZv82686iZXjOud4tJqa50ccfIWikR7344SyHLs05Y8xSG6Oj9Ec3U/
 xHI88L0wBinjHegXKzyUsEN6n604jzmD9SAjtfKFHMLY0Gzw2vVdychPUFQRL1COML82hzAOD
 znEi/whoQbJd/KlWRGAKhJcoMX1OZ6SERnJfYAx8uF3JXiWwOLT5dTL/9SXRJVQUAR3tQu9HV
 CDpCYM6ChQMA5eUl1kDl8RYnIjz8hNnc1qS/WcyQRs0jNHog+PkONEkjQwWOPnu1KB+F4ZnZM
 6ShTzGQgZ9YwG3h7+xxZ3PL7g3ULDpJHQPsCRCJ1/VsedFDQEq5B48k6GMDqA9AAQogKX01wT
 DRle5SSlC0RsriloI3dl4k1lBgw3QWUxdBZJnkVKW4mPzvmf9XKD/3DhTtFf1fLlI1eh8mEiR
 9/+byDu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.2018 um 22:48 schrieb Ramsay Jones:
> On 11/08/18 16:47, René Scharfe wrote:
>> @@ -34,12 +36,12 @@ struct fsck_options {
>>      fsck_error error_func;
>>      unsigned strict:1;
>>      int *msg_type;
>> -    struct oid_array *skiplist;
>> +    struct oidset skiplist;
>>      struct decoration *object_names;
>>  };
>>  
>> -#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
>> -#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL }
>> +#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT }
>> +#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT }
> 
> Note that a NULL initialiser, for the object_names field, is missing
> (not introduced by this patch). Since you have bumped into the 80th
> column, you may not want to add that NULL to the end of these macros
> (it is not _necessary_ after all). However, ... :-D

Exactly my thoughts -- except the "However" part. :)

I even thought about reordering the struct to move the NULL-initialized
elements to the end, allowing us to drop them from the initializer, but
felt that this would be a bit too much..

René
