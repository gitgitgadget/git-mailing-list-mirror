Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A3FC07E95
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 14:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC47610D0
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 14:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbhGSNp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhGSNp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 09:45:58 -0400
Received: from mail.aixigo.de (mail.aixigo.de [IPv6:2001:67c:13b0:ffff::60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70954C061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 06:52:46 -0700 (PDT)
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
        by mail.aixigo.de (OpenSMTPD) with ESMTPS id b709562b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 19 Jul 2021 16:26:35 +0200 (CEST)
Received: from vmdpcl078.ac.aixigo.de ([172.19.100.218])
        by mailhost.ac.aixigo.de (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTPS id 16JEQYmd2771825
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Mon, 19 Jul 2021 16:26:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aixigo.com;
        s=default; t=1626704795;
        bh=WaKm0Bb2YI0RhT8RCFsaEPkHNYO2UP57g9cKoww5O8g=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=M8pL/7Sb7ibbQXofjSihpU4ulaIYcX5mzummKlc2JYTpdcfTWJKUWw9/RU3QzY3R+
         vTFx19iuTudjFWP9CxIr8TO2kIKw35cnyghpwEBH0c7nbn0G9NceS+0f7vZYYpLzjA
         fZ+zsd65H2EhggQmcNyEoj24DyApxvsHJfu+wPFY=
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com>
 <CABPp-BEHZcfZNL+PG1vmqXGf4Qs3eoULb4NDDgbmOB30HzJu_Q@mail.gmail.com>
 <60f1b7853b8a2_ade9208c1@natae.notmuch>
 <00b50aa6-9b61-9f80-1d8d-2db3ed5e7638@aixigo.com>
 <60f1c9378d5a1_3302085c@natae.notmuch>
From:   Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Subject: Re: pull.rebase config vs. --ff-only on command line
Message-ID: <fa757764-db25-849d-d8d5-e28908059f6b@aixigo.com>
Date:   Mon, 19 Jul 2021 16:26:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <60f1c9378d5a1_3302085c@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/16/21 8:00 PM, Felipe Contreras wrote:
> Matthias Baumgarten wrote:
>> On 7/16/21 6:44 PM, Felipe Contreras wrote:
>>> Elijah Newren wrote:
>>>> On Fri, Jul 16, 2021 at 7:52 AM Matthias Baumgarten
>>>> <matthias.baumgarten@aixigo.com> wrote:
>>>>> this is my first time contacting you guys and girls so I hope this mail
>>>>> achieves the expected standard. I've discovered the following behaviour
>>>>> of git:
>>>>>
>>>>> If pull.rebase is configured to true and git pull --ff-only is executed
>>>>> it seems like the config wins, i.e. issuing "Successfully rebased and
>>>>> updated refs/heads/...", which is not what I would expect. I always
>>>>> believed that command line options would overwrite configured options.
>>>>>
>>>>> Is my assumption that command line options always win wrong or is this a
>>>>> bug?
>>>>
>>>> It's a bug.
>>>
>>> No it isn't.
>>>
>>> Elijah is elevating to fact his opinion of what --ff-only should be
>>> changed to.
>>>
>>> But it has not been changed. Today --ff-only is meant only for the merge
>>> mode of `git pull`, and like other merge-only options (e.g. --ff,
>>> --no-ff, and --squash) it's ignored in the rebase mode.
>>
>> Shouldn't every explicitly given merge option (like --ff-only) overwrite
>> any configured option that would not even result in a merge, i.e.
>> forcing a merge and thus forcing ff-only?
> 
> Perhaps. Other developers have suggested that before.
> 
> The problem is that everyone wants to make --ff-only the default, and
> then we start to get into a tricky situation, because what should these
> do:
> 
>    git -c pull.ff=only pull
>    git -c pull.ff=only pull --merge
>    git -c pull.ff=only pull --rebase

If my assumption were true, and every explicit (cli given) option would 
overwrite implicitly given ones (i.e. configured options), wouldn't

  * git -c pull.ff=only pull, do a fast-forward (or merge)
  * git -c pull.ff=only pull --merge, force a merge commit
  * git -c pull.ff=only pull --rebase, force rebase

> 
> One of these will always fail, when it shouldn'tWould this even apply under the above assumption?
> 
> I proposed a solution for that, but is has been ignored.
I'm sorry!
> 



-- 
aixigo AG
Karl-Friedrich-Str. 68, 52072 Aachen, Germany
phone: +49 (0)241 559709-390, fax: +49 (0)241 559709-99
email: matthias.baumgarten@aixigo.com
web: https://www.aixigo.com
District Court Aachen – HRB 8057
Board: Christian Friedrich, Tobias Haustein
Chairman of the Supervisory Board: Dr. Roland Schlager
