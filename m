Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55430C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 18:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188C2206D5
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 18:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED5Jppf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfLISy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:54:57 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38458 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLISy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 13:54:57 -0500
Received: by mail-qk1-f194.google.com with SMTP id k6so14067831qki.5
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 10:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KvY2f8GTkj1CNxplWYEfl9aQ8O1fvYT9QFVZF6nC8x4=;
        b=ED5Jppf/W6jxged6YFPQl+XatgEkdf3z/5UplJ3ID7jzzLjPcPaxyJvSCFRZEvpEeG
         hZ3x2aiwbdfkcZI8hwt59u1z2slGzCuNoESXgRox+8jdd3n9x197qFt7laAQVk9uVl5V
         br1rwPL81RhwSKg+EXxkYvV5ead9HTb0Vp1lzqOI3I3E3liQ5AM/COuPV0a6Ml//zot+
         ff32VBiip2/8vBicvtPYkrDnFvuO2hahXb4wxu8LoTgt4QlQo0VqMtLBI75D9EBF6v0y
         YmPCtEUZEP9uQY2EhlyWnwCwlYm6APDxrXty0j0qC9PKcNX/urcJGQrL5GZGpNukETQw
         Y83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KvY2f8GTkj1CNxplWYEfl9aQ8O1fvYT9QFVZF6nC8x4=;
        b=VUHEa/r4jsftoqpS11IR0tRauemDePR5fYrY4Qe2QOtStLiO2WZAjl1thr3R+okL1n
         XmRaAIt4LJmAJL4SxacQaO1lkcBFD95o7RHLIn6hMAIBR/NxFnMZyqDD/1lsJmzobTw6
         yQuUMdln8XpdeiC9/bdkdBIN3rJ0xlFEsVvz1vZuubpBP2XMy8hAmxF5hcS8XT3eYgZE
         lZwHhbhKJpART7vFTq0HpGOx4Sp1ogxgP9SzV0yEO5aFZRo0P3KoFww78GaVA6wmp0jD
         agvsNx5Xg5di5hLzMrXZ9DdSjiqXplPGcq+VvSWRefnoVKImG/cOT114YYSQjeAnZtvT
         aQ9A==
X-Gm-Message-State: APjAAAWJTDxa13RtFARgcxQCOVUUSkGm3sbkR2xA62tFXFT84f5voPO8
        UgJk26eWoKW0wm+Jax188mzyQxJa
X-Google-Smtp-Source: APXvYqyQU5Oz5grFn6eNLlqsaNTA4fyeciaZHeixQHM9T2crXyNJn6hEWf8FeIMdyz3GLUa6NLGt6Q==
X-Received: by 2002:a05:620a:74f:: with SMTP id i15mr6758768qki.93.1575917695389;
        Mon, 09 Dec 2019 10:54:55 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id r5sm116334qkf.44.2019.12.09.10.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 10:54:54 -0800 (PST)
Subject: Re: [PATCH 00/13] git-p4: python3 compatibility
From:   Ben Keene <seraphire@gmail.com>
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
 <20191207010938.GA75094@generichostname>
 <CABvFv3+viMXJO0z5HAQbCya7MU9tWd7P_LxUhu66T74XGN99yA@mail.gmail.com>
 <b21d153a-02f9-b9a1-7388-59b5a882d4f2@gmail.com>
 <CABvFv3Jf9i06OmBqOC2zfS+7Sm88PRYa19_rB8rELtMoN2E8CQ@mail.gmail.com>
 <afa761cf-9c0e-cdcc-9c32-be88c5507042@gmail.com>
Message-ID: <ec301179-f9dc-4148-8634-2abc9263af5f@gmail.com>
Date:   Mon, 9 Dec 2019 13:54:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <afa761cf-9c0e-cdcc-9c32-be88c5507042@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/9/2019 10:03 AM, Ben Keene wrote:
>
> On 12/7/2019 2:59 PM, Yang Zhao wrote:
>> On Sat, Dec 7, 2019 at 8:21 AM Ben Keene <seraphire@gmail.com> wrote:
>>> On 12/7/2019 2:29 AM, Yang Zhao wrote:
>>>> Ideally, I would prefer we land something minimal and working in 
>>>> mainline soon,
>>>> then further collaborate on changes that clean up code and enable 
>>>> more features.
>>>>
>>>> My end-game is to have P4 Streams working in git-p4, and maybe 
>>>> LFS-like support
>>>> that uses p4 as the backend. It would be great to not be the only one
>>>> spending effort
>>>> in that direction.
>>> I have similar goals.  I would love to get the smallest set of 
>>> non-breaking
>>> changes in that allows the program to basically work with Python 3.5+.
>>>
>>> My rush has been because I need to use git-p4 for work and have been
>>> working
>>> on the project at the office.  Once I reach a point where I am able to
>>> generally work (when t9800 is complete) I'll really not be free to 
>>> spend
>>> too
>>> much work time on the project, but I am eager to see this through!
>> I'm in a similar situation, but we use p4 Streams and so I actually 
>> need further
>> development before being able to make a full switch. I am given more 
>> liberty
>> in terms of how much work time I can dedicate to this, though.
>>
>> Given the situation, can you give my patch set a try in your work 
>> environment?
>> It is currently passing everything except t9824-git-p4-git-lfs.
>
> I downloaded your code and it looks like it works for Python 2.7. I'm 
> seeing errors with the following tests:
>
> * 9816.5
>
>     Traceback (most recent call last):
>     File "/home/bkeene/git/git-p4", line 4227, in <module>
>         main()
>     File "/home/bkeene/git/git-p4", line 4221, in main
>         if not cmd.run(args):
>     File "/home/bkeene/git/git-p4", line 2381, in run
>         ok = self.applyCommit(commit)
>     File "/home/bkeene/git/git-p4", line 2106, in applyCommit
>         p4_write_pipe(['submit', '-i'], submitTemplate)
>     File "/home/bkeene/git/git-p4", line 207, in p4_write_pipe
>         return write_pipe(real_cmd, stdin)
>     File "/home/bkeene/git/git-p4", line 201, in write_pipe
>         die('Command failed: %s' % str(c))
>     File "/home/bkeene/git/git-p4", line 158, in die
>         raise Exception(msg)
>     Exception: Command failed: ['p4', '-r', '3', 'submit', '-i']
>
> * 9816.6
>
>     Traceback (most recent call last):
>     File "/home/bkeene/git/git-p4", line 4227, in <module>
>         main()
>     File "/home/bkeene/git/git-p4", line 4221, in main
>         if not cmd.run(args):
>     File "/home/bkeene/git/git-p4", line 2381, in run
>         ok = self.applyCommit(commit)
>     File "/home/bkeene/git/git-p4", line 2106, in applyCommit
>         p4_write_pipe(['submit', '-i'], submitTemplate)
>     File "/home/bkeene/git/git-p4", line 207, in p4_write_pipe
>         return write_pipe(real_cmd, stdin)
>     File "/home/bkeene/git/git-p4", line 201, in write_pipe
>         die('Command failed: %s' % str(c))
>     File "/home/bkeene/git/git-p4", line 158, in die
>         raise Exception(msg)
>     Exception: Command failed: ['p4', '-r', '3', 'submit', '-i']
>
> * 9816.7
>
>  Traceback (most recent call last):
>    File "/home/bkeene/git/git-p4", line 4227, in <module>
>      main()
>    File "/home/bkeene/git/git-p4", line 4221, in main
>      if not cmd.run(args):
>    File "/home/bkeene/git/git-p4", line 2381, in run
>      ok = self.applyCommit(commit)
>    File "/home/bkeene/git/git-p4", line 2106, in applyCommit
>      p4_write_pipe(['submit', '-i'], submitTemplate)
>    File "/home/bkeene/git/git-p4", line 207, in p4_write_pipe
>      return write_pipe(real_cmd, stdin)
>    File "/home/bkeene/git/git-p4", line 201, in write_pipe
>      die('Command failed: %s' % str(c))
>    File "/home/bkeene/git/git-p4", line 158, in die
>      raise Exception(msg)
>  Exception: Command failed: ['p4', '-r', '3', 'submit', '-i']
>
> * 9816.9
>
>     Traceback (most recent call last):
>     File "/home/bkeene/git/git-p4", line 4227, in <module>
>         main()
>     File "/home/bkeene/git/git-p4", line 4221, in main
>         if not cmd.run(args):
>     File "/home/bkeene/git/git-p4", line 2381, in run
>         ok = self.applyCommit(commit)
>     File "/home/bkeene/git/git-p4", line 2106, in applyCommit
>         p4_write_pipe(['submit', '-i'], submitTemplate)
>     File "/home/bkeene/git/git-p4", line 207, in p4_write_pipe
>         return write_pipe(real_cmd, stdin)
>     File "/home/bkeene/git/git-p4", line 201, in write_pipe
>         die('Command failed: %s' % str(c))
>     File "/home/bkeene/git/git-p4", line 158, in die
>         raise Exception(msg)
>     Exception: Command failed: ['p4', '-r', '3', 'submit', '-i']
>
> * 9810.16
>
>     Traceback (most recent call last):
>     File "/home/bkeene/git/git-p4", line 4227, in <module>
>         main()
>     File "/home/bkeene/git/git-p4", line 4221, in main
>         if not cmd.run(args):
>     File "/home/bkeene/git/git-p4", line 2436, in run
>         rebase.rebase()
>     File "/home/bkeene/git/git-p4", line 3913, in rebase
>         system("git rebase %s" % upstream)
>     File "/home/bkeene/git/git-p4", line 305, in system
>         raise CalledProcessError(retcode, cmd)
>     subprocess.CalledProcessError: Command 'git rebase 
> remotes/p4/master' returned non-zero exit status 1
>
> The last test was a breaking test that stopped the test make.
>
>
>> If you're OK with it, I would prefer that we work from my version as 
>> a base and
>> add some of your quality-of-life enhancements on top. I can do the 
>> merges myself
>> if you are pressed for time.
>>
>> Thanks,
>> Yang
>
> I am not a Python developer and my code is further behind than yours, so
> it makes complete sense to use yours as the base.


So, I just attempted to run a base case on windows: git p4 clone //depot 
and I'm getting an error:

Depot paths must start with "//": /depot

