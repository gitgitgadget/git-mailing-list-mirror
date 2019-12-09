Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9711C00454
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7243F20726
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNUBSB39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfLIPDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:03:17 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37867 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfLIPDR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 10:03:17 -0500
Received: by mail-qk1-f193.google.com with SMTP id m188so13297395qkc.4
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 07:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pi+ZljiIkvIMjCUSyUKejNzOquv0fOfvzkB2A+Blnrk=;
        b=qNUBSB39ZOU3kOxGh7I9T/2ZhixKTnXU7V09WfDAbJESuUr6Gyz3iMiX+JBqNbC9C3
         h6wrVRkF0Bhk+ASWgqxY3Aw/i/GyDXgUmUDGONJ+ZHV+JSlvc8kepziHurD762bhPqK1
         CxoPLNeYn5gdNn+mZv+WWiQ+M/p8ORuzW7xIWqc1dS5e69wtHQW40wNA23kND4rWm6iq
         AUQuV2eaqN1ZKFPyyqRzaC4BqriOdJuJSponM+SmHbS0+YHwLAE2F7JYKvY0CD0H6JBC
         /wGcdhGh9EtWhhElUBdA6WLW40LmHI/1ljPDF0vCIhbgufhWA/qjFYjR/ofzdhXZKEuA
         fX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pi+ZljiIkvIMjCUSyUKejNzOquv0fOfvzkB2A+Blnrk=;
        b=pZ1NlhAjfGJM8pugBok6h6cNCvAHllBjYLrO06sib1vaR7U5QzJ74tF+akZFrbbQVQ
         jeEM4h6K3bIra2aoB0U22U94gnLRhf/PYlSpBafor7uwOYByWhhAU5mRnysB434c/+T1
         lJUrluQiAYw+wy0Tojqu4lggodnQpCgYwlX7s2q6HuCYTW5I9S8XLCv/gsptYZeV169X
         YV9dzlAPsOCPs/2lmFxqHJ7AqNZdn+vuPCVSDteBc1+vxthWb6yElqSMR7OUFEpqyGBr
         nmDCIaMxJ7swaaV5sYZXdvXd51GdBiboNRMFpQp32DbI/JPytvEeaq5uCIV9EleT4y0r
         kYGQ==
X-Gm-Message-State: APjAAAX36uzMjzMS1zH78xPuekKf0EESg0iw58kZwhOOX3Z0cwv/prhf
        diUi9wpKD4i8Aw+2Ncd3ylElpP90
X-Google-Smtp-Source: APXvYqwcbLLfPInLhgcGPdopMizBbn8jrGnu+Umx2/YFS+WiCSfqVoKz3BJafN7JM5hxng3TtMl9xg==
X-Received: by 2002:a37:ae47:: with SMTP id x68mr950540qke.214.1575903795860;
        Mon, 09 Dec 2019 07:03:15 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id p35sm9709068qtd.12.2019.12.09.07.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 07:03:15 -0800 (PST)
Subject: Re: [PATCH 00/13] git-p4: python3 compatibility
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
 <20191207010938.GA75094@generichostname>
 <CABvFv3+viMXJO0z5HAQbCya7MU9tWd7P_LxUhu66T74XGN99yA@mail.gmail.com>
 <b21d153a-02f9-b9a1-7388-59b5a882d4f2@gmail.com>
 <CABvFv3Jf9i06OmBqOC2zfS+7Sm88PRYa19_rB8rELtMoN2E8CQ@mail.gmail.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <afa761cf-9c0e-cdcc-9c32-be88c5507042@gmail.com>
Date:   Mon, 9 Dec 2019 10:03:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABvFv3Jf9i06OmBqOC2zfS+7Sm88PRYa19_rB8rELtMoN2E8CQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/7/2019 2:59 PM, Yang Zhao wrote:
> On Sat, Dec 7, 2019 at 8:21 AM Ben Keene <seraphire@gmail.com> wrote:
>> On 12/7/2019 2:29 AM, Yang Zhao wrote:
>>> Ideally, I would prefer we land something minimal and working in mainline soon,
>>> then further collaborate on changes that clean up code and enable more features.
>>>
>>> My end-game is to have P4 Streams working in git-p4, and maybe LFS-like support
>>> that uses p4 as the backend. It would be great to not be the only one
>>> spending effort
>>> in that direction.
>> I have similar goals.  I would love to get the smallest set of non-breaking
>> changes in that allows the program to basically work with Python 3.5+.
>>
>> My rush has been because I need to use git-p4 for work and have been
>> working
>> on the project at the office.  Once I reach a point where I am able to
>> generally work (when t9800 is complete) I'll really not be free to spend
>> too
>> much work time on the project, but I am eager to see this through!
> I'm in a similar situation, but we use p4 Streams and so I actually need further
> development before being able to make a full switch. I am given more liberty
> in terms of how much work time I can dedicate to this, though.
>
> Given the situation, can you give my patch set a try in your work environment?
> It is currently passing everything except t9824-git-p4-git-lfs.

I downloaded your code and it looks like it works for Python 2.7.  I'm 
seeing errors with the following tests:

* 9816.5

     Traceback (most recent call last):
     File "/home/bkeene/git/git-p4", line 4227, in <module>
         main()
     File "/home/bkeene/git/git-p4", line 4221, in main
         if not cmd.run(args):
     File "/home/bkeene/git/git-p4", line 2381, in run
         ok = self.applyCommit(commit)
     File "/home/bkeene/git/git-p4", line 2106, in applyCommit
         p4_write_pipe(['submit', '-i'], submitTemplate)
     File "/home/bkeene/git/git-p4", line 207, in p4_write_pipe
         return write_pipe(real_cmd, stdin)
     File "/home/bkeene/git/git-p4", line 201, in write_pipe
         die('Command failed: %s' % str(c))
     File "/home/bkeene/git/git-p4", line 158, in die
         raise Exception(msg)
     Exception: Command failed: ['p4', '-r', '3', 'submit', '-i']

* 9816.6

     Traceback (most recent call last):
     File "/home/bkeene/git/git-p4", line 4227, in <module>
         main()
     File "/home/bkeene/git/git-p4", line 4221, in main
         if not cmd.run(args):
     File "/home/bkeene/git/git-p4", line 2381, in run
         ok = self.applyCommit(commit)
     File "/home/bkeene/git/git-p4", line 2106, in applyCommit
         p4_write_pipe(['submit', '-i'], submitTemplate)
     File "/home/bkeene/git/git-p4", line 207, in p4_write_pipe
         return write_pipe(real_cmd, stdin)
     File "/home/bkeene/git/git-p4", line 201, in write_pipe
         die('Command failed: %s' % str(c))
     File "/home/bkeene/git/git-p4", line 158, in die
         raise Exception(msg)
     Exception: Command failed: ['p4', '-r', '3', 'submit', '-i']

* 9816.7

  Traceback (most recent call last):
    File "/home/bkeene/git/git-p4", line 4227, in <module>
      main()
    File "/home/bkeene/git/git-p4", line 4221, in main
      if not cmd.run(args):
    File "/home/bkeene/git/git-p4", line 2381, in run
      ok = self.applyCommit(commit)
    File "/home/bkeene/git/git-p4", line 2106, in applyCommit
      p4_write_pipe(['submit', '-i'], submitTemplate)
    File "/home/bkeene/git/git-p4", line 207, in p4_write_pipe
      return write_pipe(real_cmd, stdin)
    File "/home/bkeene/git/git-p4", line 201, in write_pipe
      die('Command failed: %s' % str(c))
    File "/home/bkeene/git/git-p4", line 158, in die
      raise Exception(msg)
  Exception: Command failed: ['p4', '-r', '3', 'submit', '-i']

* 9816.9

     Traceback (most recent call last):
     File "/home/bkeene/git/git-p4", line 4227, in <module>
         main()
     File "/home/bkeene/git/git-p4", line 4221, in main
         if not cmd.run(args):
     File "/home/bkeene/git/git-p4", line 2381, in run
         ok = self.applyCommit(commit)
     File "/home/bkeene/git/git-p4", line 2106, in applyCommit
         p4_write_pipe(['submit', '-i'], submitTemplate)
     File "/home/bkeene/git/git-p4", line 207, in p4_write_pipe
         return write_pipe(real_cmd, stdin)
     File "/home/bkeene/git/git-p4", line 201, in write_pipe
         die('Command failed: %s' % str(c))
     File "/home/bkeene/git/git-p4", line 158, in die
         raise Exception(msg)
     Exception: Command failed: ['p4', '-r', '3', 'submit', '-i']

* 9810.16

     Traceback (most recent call last):
     File "/home/bkeene/git/git-p4", line 4227, in <module>
         main()
     File "/home/bkeene/git/git-p4", line 4221, in main
         if not cmd.run(args):
     File "/home/bkeene/git/git-p4", line 2436, in run
         rebase.rebase()
     File "/home/bkeene/git/git-p4", line 3913, in rebase
         system("git rebase %s" % upstream)
     File "/home/bkeene/git/git-p4", line 305, in system
         raise CalledProcessError(retcode, cmd)
     subprocess.CalledProcessError: Command 'git rebase 
remotes/p4/master' returned non-zero exit status 1

The last test was a breaking test that stopped the test make.


> If you're OK with it, I would prefer that we work from my version as a base and
> add some of your quality-of-life enhancements on top. I can do the merges myself
> if you are pressed for time.
>
> Thanks,
> Yang

I am not a Python developer and my code is further behind than yours, so
it makes complete sense to use yours as the base.


