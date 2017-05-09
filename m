Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82EC52018D
	for <e@80x24.org>; Tue,  9 May 2017 23:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750986AbdEIXu7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 19:50:59 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35499 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdEIXu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 19:50:58 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so1716044pfd.2
        for <git@vger.kernel.org>; Tue, 09 May 2017 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7cUhFiEFThQ9F3GHLKK95EeSriu3NPFkgEsv6jVkFaU=;
        b=smEJrkOoN+dMa9kd1Qz1o4Kj0sUKUKHPES34OeI4x3ySSSiPRHp7ks+JjQLGVLSv+S
         V6moCBaIOJEEsStchT0LpPvZ9UHsUp8rpVNSMy1yzBEsvlzOuRUwnEIVv+vo99uqWsqp
         Jsl0TpgK+jM4xyDeEJeCptx1GfxKs3LBJd5TA1qzvBWdPRug2tX92wPb1SdsyJv73C8w
         OGCoDURIljwC4If7stMwPXR/3qPVdKUA/KhHmQ+XbXaxtYnCtsUxxMaTL89nUBpKLXbM
         pIRHz2/cTuD4vzjrjwPga3BDIHkNWEWNX5g9BXZiK6APDrhZG+hY5hVXljVNrMxwRo4G
         4TJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7cUhFiEFThQ9F3GHLKK95EeSriu3NPFkgEsv6jVkFaU=;
        b=C+FMQBrClhRGj+NEeff1d2ua8W+z64hz9bsxtsri1FExjTNHdiuT/R1jZJtxk7IzHX
         ZfMxSINMHJVP5LkwotSxNSqiR/flXP0DE1TqvuKY5zzu9GVE+FqEOKuHAWmPYlTCnrV5
         Su6KuMYTeha1wXQ2lzWJBi6lLtgF2YF1Ic23ahAlrD0GhnMGQxv3Iyz+qExm6RLA90zw
         PKtBBweJlrPBHucVbr0fpTXYL5ZgwjyPsCI9abehuNflu15MYNo+wq4NnQDq/4tvnJ6u
         xWt3F6FrVVo4JCXxRb4Xqjh0GMtOeECbL2kZlbQIY9Pn4I8Sgo2/DHQM465sp70GXF1/
         mVgA==
X-Gm-Message-State: AODbwcAR4esG97B//bZolhcNYv8DvnCJXnwJf0aEeKNsF+X8nq+oH3eO
        2gMQjMTl3lX8WQ==
X-Received: by 10.84.231.206 with SMTP id g14mr3881996pln.152.1494373857907;
        Tue, 09 May 2017 16:50:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9133:cf19:b689:27d6])
        by smtp.gmail.com with ESMTPSA id s186sm1589396pfb.98.2017.05.09.16.50.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 16:50:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] travis-ci: retry if Git for Windows CI returns HTTP error 502 or 503
References: <20170503215015.17949-1-larsxschneider@gmail.com>
        <xmqqpofi35ik.fsf@gitster.mtv.corp.google.com>
        <1ADD08FD-1DC0-4AC5-9E69-AC1A5DCBED83@gmail.com>
Date:   Wed, 10 May 2017 08:50:56 +0900
In-Reply-To: <1ADD08FD-1DC0-4AC5-9E69-AC1A5DCBED83@gmail.com> (Lars
        Schneider's message of "Tue, 9 May 2017 18:40:01 +0100")
Message-ID: <xmqqmvalzj1b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>>> It would be great if we could test this is a little bit in pu.
>> 
>> This has been in 'pu' for a while.  
>> 
>> As the patch simply discards 502 (and others), it is unclear if the
>> failing test on 'next' is now gone, or the attempt to run 'pu'
>> happened to be lucky not to get one, from the output we can see in
>> https://travis-ci.org/git/git/jobs/229867212
>> 
>> Are you comfortable enough to move this forward?
>
> Yes, please move it forward. I haven't seen a "502 - Web server 
> received an invalid response" on pu for a while. That means the
> patch should work as expected.

Will do, thanks.

> Unrelated to this patch I have, however, seen two kinds of timeouts:
>
> (1) Timeout in the "notStarted" state. This job eventually finished
> with a failure but it did start only *after* 3h:
> https://travis-ci.org/git/git/jobs/230225611
>
> (2) Timeout in the "in progress" state. This job eventually finished
> successfully but it took longer than 3h:
> https://travis-ci.org/git/git/jobs/229867248
>
> Right now the timeout generates potential false negative results. 
> I would like to change that and respond with a successful build 
> *before* we approach the 3h timeout. This means we could generate
> false positives. Although this is not ideal, I think that is the better 
> compromise as a failing Windows build would usually fail quickly 
> (e.g. in the compile step).
>
> What do you guys think? Would you be OK with that reasoning?
> If the Git for Windows builds get more stable over time then
> we could reevaluate this compromise.

I'd rather see a false breakage on Windows build (i.e. "this might
have succeeded given enough time, but it didn't finish within the
alloted time") than a false sucess (i.e. "we successfully launched
and the build is still running, so let's assume the test succeeds").
Because I do not pay attention to what the overall build page [*1*]
says about a particular branch tip, and I instead look at the
summary list of the indiviaul "Build Jobs", e.g. [*2*]), seeing
errored/failed on [*1*] does not bother me personally, if that is
what you are getting at.


[References]

*1* https://travis-ci.org/git/git/builds/
*2* https://travis-ci.org/git/git/builds/230235081
