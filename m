Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE9C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 11:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A0B65017
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 11:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCELIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 06:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCELHv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 06:07:51 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348ADC061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 03:07:51 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id w7so1068745wmb.5
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 03:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JdLN0cZSXkKCJaKdb2+Fo/53my85KHmjEiVtu3FeLzg=;
        b=bbyNhFgLN+0xo3wz5SPhKm6D5crLtlCIjyezVKnpfpbLEaNJLHp0iuyQvpQ5uWbuYw
         f+o3IwuFrMFneTjzhO3khvPdDar40PJ4X9H0qkY1P4xewLm9/eDKx3HOuYGHflkM+phQ
         94vI5HRwoR0ZV4kCTS1ZwTsRHXOlqMag0DqvnCmrMtx7V8VjbgNBkOlD4AraV5fMuDOx
         gXcuxt5b1k9ZfCParZ40BwEXSeMsQlXZTWgqAwKbvJ9V9Q9fgNuRkueXN7T3v+LA/hp0
         jfV1xTwuL/e2JUiYCA0kQX2Eio9PW/KhanLA7DuRxYStSI53Y/uoy/FzTCGVJ3rnmsbk
         Q2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JdLN0cZSXkKCJaKdb2+Fo/53my85KHmjEiVtu3FeLzg=;
        b=Sn9lRC7nlHjikPkyUVQJsdPDxd7Xz/1heOMVewGYjT8dQLjUW20EoT9Occ8VegkHO5
         0J1XpkAwDiR1JtzQ+aCWvtgBvCzzVN4PR0yi7bYGYQynFvQoZh/j8vW4xuam8Mn/rbe2
         n+yXHwRoeEZl/Z/tZ/9/vs2AK1X9JYl+xBXyT+IIfQRegQm7fDKWtmxrIArBU0XUK3kb
         FLSHKUcj4otE/8s41uAJZHFt+N5A27QDO4PDz6mhOVWAocHIvSIEVDTwQjPOnupAJVWL
         uXL0kToN5nxpz6XU3DbpRv7zccO4ZUc1MkRR4fFCNTF4bpvqNld+DpYJmTvL9PF/HulQ
         ovyA==
X-Gm-Message-State: AOAM530T0DMbEGPbFIXfiiCmjMx+7ILGitrC3hcF6lARejIh5hcCSkmx
        deXiZqLJpANQ4CqK7MqJ4hc=
X-Google-Smtp-Source: ABdhPJyWi6mvGmZEm1wTSn8Zg4cMyeI9AAbPIV1JzdpT9vyM8ZmkZk17nGjg/MHLeCyqPwePVuJlCA==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr8431716wml.100.1614942470009;
        Fri, 05 Mar 2021 03:07:50 -0800 (PST)
Received: from [192.168.178.32] (pd9e1c3b3.dip0.t-ipconnect.de. [217.225.195.179])
        by smtp.gmail.com with ESMTPSA id m3sm3797696wmc.48.2021.03.05.03.07.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Mar 2021 03:07:48 -0800 (PST)
To:     Elijah Newren <newren@gmail.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <120922f1-67a9-9ae2-2e9c-56e20935e0f9@gmail.com>
 <CABPp-BFju3vJYMRH8fXBcHu1sDkthWsdO9rJzSNKB7E3pfGiHQ@mail.gmail.com>
From:   Ephrim Khong <dr.khong@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dr.khong@gmail.com; keydata=
 mQENBF2KH3QBCACy66z3LoDOvFnn3Jl07bZvGy8IWXoClBLBEVQEDMgX6/2VskvAiDFYXjYY
 CBnpMZS7pkHyMj2nAuk8rfz8ofhTMxW1YthQGAGJt0eYMp9dymKG4O9c6Lzwlb54lwWet1AE
 x326ePst0QaBkvksN8HmoqNrTZVth2U+IiAI5y7RJB65ZsXmHoXBt4pfPEoQ01WFTXBrQ2ZR
 LHcweZQdU1uhwPjCB6JV9pNTclzFfQyqqga/JbbDbbplhL5XhA15VJq+3CJSM3Y0M1UGEOUv
 5dcWC15x65jlX4yDIrXUYkWq48byHlC8B75n9EnMAvmkFZ09ntSjwsRJmLILxr8cz9jtABEB
 AAG0J0JlcnRyYW0gRHJvc3QgPGJlcnRyYW0uZHJvc3RAbXZ0ZWMuY29tPokBVAQTAQgAPhYh
 BLWZoXdIkApCXec/7OxiOFtXzt5/BQJgAaaWAhsDBQkDw4IsBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEOxiOFtXzt5/k0MH/3G9nXfyfOiTQlANSQwQrXfpsvX+OJHCjLIpWgIUzMlN
 1LNacOn3fKxUWhiy/eXzNUAumL8lqRuLcjz6BcEhSIp7aWOYNqiQ0zSl7Qo3QxcL4k1tuAXz
 aOo1l9Kk9SzviPN7SGjCK4jrMKlEjBoA3G8OtxaJfk9XQRbkYVJFiIaTHh5puz2aoFgTCtB6
 qWpBfd59rmmYo16VbgK7qx0HaVijFQK6YyUFwnYVzCpGj4xCtrWs0awexbgzRmBUn3hEtD8P
 oMLbf/SaPqYhbH/iRUT8YAteWNi4teD9PQX436FOWXzFTR0DnURlNB9CfDj4YjGm9jeZ31i7
 8KdCEL+7/P25AQ0EXYofdAEIANMR2v+vHOPGHZUG/KrziIdliwF+VIUh58z92nIlvdrb+B2K
 QCVseYwkYvqMJkLaad5DbA2POwU1AofvXhGiNiNhiC02mwO+gHnX6Bz0SubfytdZd70SBcrD
 YNHsqJKHYPRS/AwWA5xRPTt7elsGrMkx7QU3QBeJhYPjEfjOjSAFNuPbSKKBw1oG8cZFihse
 D44MeDUJeODVWI7wl5VfIzW7cQ1HfmhPMC4I7cdz0D19RmTsvwDY5Er8uCiuKD/otnH/GeHp
 PYNSXxcAOjyuCbZOi/ps1BQp1UXJudIxS6w1Z9weJ3dgndd4ZmwcSPq+VHT2xcypM77Iff/g
 nvWK7zcAEQEAAYkBPAQYAQgAJhYhBLWZoXdIkApCXec/7OxiOFtXzt5/BQJdih90AhsMBQkD
 w4IsAAoJEOxiOFtXzt5/f58H/2tYnryojtNWwuVE1iJwBol1FJ+wg+NgqxQ+lgYu/JfoxNJY
 fDAPv5bNsfIoC7D6zJwZ+d6XFjb5tQITXT5fFJYgTaVKE9p+acsgXPoERLqF2NNK5hVHPz5K
 fENTojGN9aLElsyPDmFrnYZYqrvm1Ex4qcQ4mkIWI20CLfK84+Wi/6o/dE/uYu1chKNbfkZh
 B8krQZMfy1FAkrPbaIvuG6HgFd7gTWNmg2O4g7RRM/n+SgBFocnHY4bBc7WNgS+9h5imFeQk
 2Xy+Vjg5pJ+Q5b+6ULbGNUonKFhT9++RFH/FA2A4rYKoyEW3MbZKQAgqOVLDknad5HOaDFA7
 Mt212FU=
Subject: Re: Tracking a merge bug
Message-ID: <7b960460-dd3a-abaf-b97b-9b29cbc52990@gmail.com>
Date:   Fri, 5 Mar 2021 12:07:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BFju3vJYMRH8fXBcHu1sDkthWsdO9rJzSNKB7E3pfGiHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26.10.2020 16:50, Elijah Newren wrote:
> On Mon, Oct 26, 2020 at 8:11 AM Ephrim Khong <dr.khong@gmail.com> wrote:
>>
>> I am trying to find the root cause for what I believe might be a strange
>> bug in git merge.  I have a feature branch A which branched off master
>> not too long ago, and want to bring it up to date with master:
>>
>>     git checkout A
>>     git merge master
>>
>> which yields
>>
>>     error: add_cacheinfo failed to refresh for path 'c/d/e.sh'; merge
>> aborting.
> 
> "add_cacheinfo failed to refresh"?  Wow, that's a new one.  Some years
> back we had a "add_cacheinfo failed for path" corresponding to the
> other error site within that function, but we fixed that one up long
> ago.  I've never seen anything hit the refresh failure.

Thank you for looking into this and sorry for the delay. I ran into this
again and did some more testing.

The merge works if I copy the complete repository to a different
filesystem (in this case a local SSD) with cp -a. It was originally on a
network share.

An strace on the affected file seems to show that git creates and writes
the file, attempting to set the executable bit. But the subsequent lstat
reports that no executable bit is set (and that is correct, when looking
at the file after the merge errors out):

	
> lstat("tools/ci/nightly/run_benchmarks.sh", 0x7ffc2f148c20) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "tools/ci/nightly/run_benchmarks.sh", O_WRONLY|O_CREAT|O_EXCL, 0777) = 4
> write(4, "#!/bin/bash\n#\n# Build and run hb"..., 1973) = 1973
> fstat(4, {st_mode=S_IFREG|0755, st_size=1973, ...}) = 0
> close(4)                                = 0
> 	
> lstat("tools/ci/nightly/run_benchmarks.sh", {st_mode=S_IFREG|0755, st_size=1973, ...}) = 0   #<-- first lstat, mode is OK
> unlink("tools/ci/nightly/run_benchmarks.sh") = 0
> openat(AT_FDCWD, "tools/ci/nightly/run_benchmarks.sh", O_WRONLY|O_CREAT|O_TRUNC, 0777) = 4
> write(4, "#!/bin/bash\n#\n# Build and run hb"..., 1973) = 1973
> close(4)                                = 0
> lstat("tools/ci/nightly/run_benchmarks.sh", {st_mode=S_IFREG|0640, st_size=1973, ...}) = 0   #<-- second lstat, mode is wrong
> 	
> write(2, "error: add_cacheinfo failed to r"..., 120error: add_cacheinfo failed to refresh for path 'tools/ci/nightly/run_benchmarks.sh' (2); merge aborting.

note how the last lstat() reports 0640, even though openat() wanted
0777. The same thing when merging on the SSD shows

> lstat("tools/ci/nightly/run_benchmarks.sh", 0x7ffd491745c0) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "tools/ci/nightly/run_benchmarks.sh", O_WRONLY|O_CREAT|O_EXCL, 0777) = 4
> write(4, "#!/bin/bash\n#\n# Build and run hb"..., 1973) = 1973
> fstat(4, {st_mode=S_IFREG|0755, st_size=1973, ...}) = 0
> close(4)                                = 0
> 		
> lstat("tools/ci/nightly/run_benchmarks.sh", {st_mode=S_IFREG|0755, st_size=1973, ...}) = 0
> unlink("tools/ci/nightly/run_benchmarks.sh") = 0
> openat(AT_FDCWD, "tools/ci/nightly/run_benchmarks.sh", O_WRONLY|O_CREAT|O_TRUNC, 0777) = 4
> write(4, "#!/bin/bash\n#\n# Build and run hb"..., 1973) = 1973
> close(4)                                = 0
> lstat("tools/ci/nightly/run_benchmarks.sh", {st_mode=S_IFREG|0755, st_size=1973, ...}) = 0
> 		
> openat(AT_FDCWD, "tools/ci/nightly/run_benchmarks.sh", O_RDONLY|O_CLOEXEC) = 4
> read(4, "#!/bin/bash\n#\n# Build and run hb"..., 1973) = 1973
> close(4)                                = 0

here, lstat() reports 0755 and the merge continues.

This could very well be an issue with the storage system backing my
network share, but maybe I overlooked something in that strace that git
is doing wrong or could do better. It does, for example, write the file
twice with identical content for some reason.

I have patched my git for now, and in read-cache.c, refresh_cache_ent()
call chmod() and re-run lstat() if the mode is incorrect. That fixes the
problem for now. It's not perfect, since chmod() ignores the umask, but
at least allows to merge.

> Any chance this repository is available for others to access to try to
> reproduce the problem?

Unfortunately it's not public. I have tried to cut out the offending
part, but was unable to reproduce it with a smaller test case yet.

Thanks
- Eph
