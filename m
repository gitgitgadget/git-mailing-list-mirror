Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469681F463
	for <e@80x24.org>; Sat, 21 Sep 2019 15:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438302AbfIUPwY (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Sep 2019 11:52:24 -0400
Received: from mout.web.de ([212.227.15.4]:55379 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438252AbfIUPwY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Sep 2019 11:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569081136;
        bh=u/FpUaa4/1SwinRU2FdwUEekpC24eUjUAQhbmE1zZtM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KDRjcc56AHjMX+dTc8b5P7RLNJbPAQU0JMFZZo40xF1O6ui+7DGugRfjt2j5ELkVW
         XCdiizRI+jdKHa8dKA2zkdCP5abEDD30dz8FO/YM9F8VyIHNW3Qie0ZPUOdG272bOU
         MdiGFXT6FXZKiFo6E4TDch3AZlR+EoSpvoq3onsQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgZLb-1iWGhT20l5-00Nye3; Sat, 21
 Sep 2019 17:52:16 +0200
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-9-szeder.dev@gmail.com>
 <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
 <20190920181302.GA26402@szeder.dev>
 <813f9deb-4448-ed4e-b124-5b85f1ca7147@web.de>
 <20190921142121.GA10866@szeder.dev>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <14079466-78f9-a724-269d-9209e9e6ab26@web.de>
Date:   Sat, 21 Sep 2019 17:52:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190921142121.GA10866@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NfX02NKTpK9i8x386u/9YTXDZUwcKp/XvExiTWhGUq3dakTVcHW
 QVz62RgJboJvRvyDg1RKTQr+q+1Z1HMfZJF3HeCV5Z2rvAoNNy9K0owDmYmGNJE3fl1N7vy
 9pRj1FiB9x5I7BEh2umpTvZIFQ4rTBBqv+LqLQAtPBeDDKMinT4SBDH/l5MjqKWAeya5Y/k
 nsighMMUQc/Yfkoykg5/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8CM0QfBJtfA=:7JzCjT9Xtdl72XawyEDWDA
 jIC/ccw9j9q4C+c8dlSe+BKMSKzWv8QAVY4cpxmShJCTl69lUMZ4+8SxoJzOvqC3VQcUxJXYE
 doeXl1l+kJzfMcx+D2qKBz4Ha/J1GRXKuY8PJXyr4dMEupFQgjwv2yIxy1RYJHlZxI8/DA9WO
 FTPas+FzeMXRxIJhR8U2Jh3jhroPfwwTVhSo1nA0ra5kavRxi+WTfoTmbWS+1ys4RHFgGbjkk
 6fheBHttcRuNgV044F+WciqyKiiCJ5WqlKnK+lUIBGahRyyz0jAzI6JISV6jPL0PX2S5+ockD
 vnNFUnDoMBo4dZdHm2kdvy9meOJ6tFCc3zmeWnHhRW4kw5cNmxZ99CJU+0U/PliWSJARIwp/m
 z/clWNINbxy0HHRTDFL3mgDLtncVFdjDHpXkj+/kGV2GkLrudRfduezwh3hFNJrpeYccTf7vj
 eup5lZf+JDvdcMGzRsO0Zdizgt6XwPHoJsTL8hIx9qXresAAjuQZ0VVhilxcEbPV5ytJ3F0Np
 Cr+dWhGQORWHTrjazceR2sX1Y60K87EJqmzXdxKJqq1lUtbbjIjNMN3TMfHw5d9gj0uxB8LhO
 QmnuUIXEqy52vm8nj+iEWq3BPib6d2b5AqQkpwKqmptrK0rr53d+6wZbEqCXzRoJ0IPhHyw5N
 CBcKHoJ7MWLbO2fOpFGQLXuwM21snAGZUXcTrmCNa7JL06cjaD5JfnwmYqEe6pPQzLGt0uMh7
 l6gmo6algqbnLYqjWFKchnugXQ0cH5dgk1YW2C8oXsZPXESg6ZRF9yipcD2nnsfQnKE+i8OWp
 AIvGzVi3nitY3gn+cJcRjn8l9X/7mq7eGiSueIRpExlMWHlQfs4+cGN7d2G/tujlu1cOjzD97
 CCCqycKHM4HA3oG1pZtm0lZO+M1HD4fp2oGujITuGNugANffoaeEs/TYtACkTSiMLEaz/XVpt
 pi8ZAqhbFpQ+eqwRUPJeLbuvhb+ICG5vOuOkmbehYnUW2sHsKuPlX7zjFqAxjjiDL6MZ5/TKn
 Te0+xf4B60/3lqFYZI/WqDPbia18sCW+SlyIY8WGh1JlgIfX0JWFlWDMO5pEc6HyvrgagPvcH
 jxE9XH6VQMRtuLMzI527gr6RE0xo7duzS7CTlSRhB5xaCzZelO0xBb9K1aQFsmIG+vKP6viuo
 Ndq/gBpGUlVwcM3dDBnIFZavRrI1GwEXwhz9mw1zI+eCztYMvKDIj//Gqqe5z/7tYKdiyy2Fz
 MXxSjFq9HqrHy4JTKOYIDXVdzQoFG3MsfOQuUhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.09.19 um 16:21 schrieb SZEDER G=C3=A1bor:
> On Sat, Sep 21, 2019 at 02:37:05PM +0200, Ren=C3=A9 Scharfe wrote:
>> Am 20.09.19 um 20:13 schrieb SZEDER G=C3=A1bor:
>>>>> @@ -280,12 +269,16 @@ static int name_ref(const char *path, const st=
ruct object_id *oid, int flags, vo
>>>>>  	if (o && o->type =3D=3D OBJ_COMMIT) {
>>>>>  		struct commit *commit =3D (struct commit *)o;
>>>>>  		int from_tag =3D starts_with(path, "refs/tags/");
>>>>> +		const char *tip_name;
>>>>
>>>> This should not be const because you allocate the buffer it points to
>>>> right here in the function, in each execution path.
>>>
>>> Marking it as const indicates that this function doesn't modify the
>>> buffer where the pointer points at.
>>
>> Right, and that's at odds with this code:
>>
>>>>> +		if (deref)
>>>>> +			tip_name =3D xstrfmt("%s^0", path);
>>>>> +		else
>>>>> +			tip_name =3D xstrdup(path);
>>
>> ... which allocates said memory and writes a string to it.
>
> ... before assigning it to the const pointer.
>

Sure, you can cast anything to anything else, and slapping on a const
qualifier is even allowed to be done implicitly for pointers to objects
(but not for pointers to pointers).  Removing it later (e.g. for
free(3)) is a warning sign; such sites need to be checked manually, as
the compiler won't do it.

The declaration says we don't modify the buffer, but then we actually
create it, which is as big a modification as can be.  That's a bit
misleading.  Is protection against accidental updates worth the
misdirection, and where would they come from?  Usually code without
such tricks is easier to read and maintain.

Ren=C3=A9
