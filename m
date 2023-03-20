Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84745C761AF
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 16:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjCTQi7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjCTQie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 12:38:34 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1A316335
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:33:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y35so5782782pgl.4
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679329983;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ml2iTs3NVlkKR+5oeqG/DAJNbbVAFqu0nRSEHEKJLA=;
        b=cixRBsh2Mbg2haCMrBwLdCcOWgVsgXDhj37xJIiafCj7Q1/bn7q/eRUUUjDVeKDqcg
         YWtVPrKHNhkbdx9aAgXCe/BnjgDZxN6njcy3W8pA31K9LkpsoVCVwiDu4VzL2YA6fpVZ
         9gcyBxceVz5OKiUPauy/0OUXxUXkmoLaeg4l8fr71P5YMh7FBtXwmzoNxHfP06CA1e6j
         LFO6fEtSsE5np7lFurwDFX8Q7KYmm/kFsEs0sBtrpjokXUootAXp4F31/A1S7URZ+92K
         6PRU0vFjzlTEvM59unQKKctugkdkgJY9iDECnS+WebjtbOKVumgUDbGoweaUBjepR53r
         xn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329983;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ml2iTs3NVlkKR+5oeqG/DAJNbbVAFqu0nRSEHEKJLA=;
        b=Zm/oRdqCQre8+EpL2MF36by1RG7Mcn201CgQoVaHGj5Cdw74T0BEY9keETUoJzn5Dv
         vrkvV6UpQyF3yh2gnJbS4ghbMstq3LYxeZ37L/+nXgDuo3d0jU+h+HllEFJ15DPPEc1/
         MU8qiChlnTU82tw5PkTLkLlPU6qwyDHXMUbbAtm5frIAKiW7VD8/N8pXlf5Kvh1Z7xbi
         FRZscRQyrwJ9HuLyORSG7Q8qv/XpmmmbM0+HATmKu9iyTx2yfVhgddxGdy26wKlGCA3T
         +UGyeKrGI1aCXOLoWv2qA2VOAD0vI+AUj1z+xjWhuPcEnmbS2SequRka/J7/BloZCsSq
         zfrg==
X-Gm-Message-State: AO0yUKU5XwxpDPN5z5mUXNTmuaQ/DHeQjGlRjSAnOG0rApaqPm446ibP
        FHwfh6WWAMikf5V5/o6jURXcr8urh7E=
X-Google-Smtp-Source: AK7set+UlByPyjCyDqqJb+lXMLKJHVIWhJhbDV2Jj4Hy7ieA6fSvOCMXmsvP51EcwFfRruNqU74J5A==
X-Received: by 2002:aa7:96b3:0:b0:5e2:da34:4aaf with SMTP id g19-20020aa796b3000000b005e2da344aafmr16818414pfk.4.1679329982796;
        Mon, 20 Mar 2023 09:33:02 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id h4-20020aa786c4000000b00627ed4e23e0sm3285405pfo.101.2023.03.20.09.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:33:02 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Paul Eggert <eggert@cs.ucla.edu>
Subject: Re: [PATCH 2/2] git-compat-util: use gettimeofday for current time
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
        <20230319064353.686226-3-eggert@cs.ucla.edu>
        <20230319193449.M629601@dcvr>
Date:   Mon, 20 Mar 2023 09:33:01 -0700
In-Reply-To: <20230319193449.M629601@dcvr> (Eric Wong's message of "Sun, 19
        Mar 2023 19:34:49 +0000")
Message-ID: <xmqqh6ufo01u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Paul Eggert <eggert@cs.ucla.edu> wrote:
>> Use gettimeofday instead of time(NULL) to get current time.
>> This avoids clock skew on glibc 2.31+ on Linux, where in the
>> first 1 to 2.5 ms of every second, time(NULL) returns a
>> value that is one less than the tv_sec part of
>> higher-resolution timestamps such as those returned by
>> gettimeofday or timespec_get, or those in the file system.
>> There are similar clock skew problems on AIX and MS-Windows,
>> which have problems in the first 5 ms of every second.
>
> Wow, this is enlightening... and unfortunate :<
>
> I decided to check glibc archives to find more discussion on it.
> So far, I've found:
>
>   https://inbox.sourceware.org/libc-alpha/20230306160321.2942372-1-adhemerval.zanella@linaro.org/T/
>
> and the original bug:
>   https://sourceware.org/bugzilla/show_bug.cgi?id=30200
>
> And this is due to the time64 changes in glibc 2.31+?
> (<= 2.30 isn't affected?)
>
> <snip>
>
>> Yet another possibility would be to fix the Linux kernel so
>> that the time syscall is consistent with the other timestamp
>> syscalls.  I suppose this has not been done due to
>> performance implications.  (Git's use of timestamps is rare
>> enough that performance is not a significant consideration
>> for git.)  However, this wouldn't fix Git's problem on older
>> Linux kernels, or on AIX or MS-Windows.
>
> Agreed on the older kernels and other OSes part.

Yeah, this is interesting.  I however wonder if we should follow our
usual pattern of implementing git_time() with the identical function
signature as what we replace (i.e. system's time()), and #undef/#define
the symbol we replace with git_time, though.  Wouldn't it make [1/2]
a lot smaller and future-proof?

