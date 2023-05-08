Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41751C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjEHRxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEHRxs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:53:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1A63599
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:53:47 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaf70676b6so33643445ad.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683568426; x=1686160426;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=t0NvTy7w6geAPppNOVJLk4WJg6UguR/z67p+Hn66Xpw=;
        b=a4D0yS/XTIwlnRWhv9wnTyFAY7kJqujbHVR1tn+eplARQh+mL//i8eAM8fZsiO+AMX
         679tqzekFhVpxinzdjqWOD6ORGiWR8Ws3+LDpho1hwZpFtmEIPly3yQolcGOSiWEVYGz
         OxmhFFNFW9kFdR6hCISMwkcQd8sPgkXSLQKuDz23olDm3AkbPaGabI5Sz+5qpgu+EsRY
         3EHez5gYh7yc+YESQew6hT2LyxVGXnW3oM/8HUHQEga5E6cZWCiy/MTv2hMB9mqXc8HB
         bv3hKZxE2BkpFclVHqqytG7BrNRY1/N68/85YzMlm4WauA9YV1qE++EABAvUmh3gxaPh
         mmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683568426; x=1686160426;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0NvTy7w6geAPppNOVJLk4WJg6UguR/z67p+Hn66Xpw=;
        b=MHdPz7Lv/Fir2r0kx/1h1QuczPc0il7k6DFZm5CgMHVhDgOoBp3IMj3vnY4pPLWEVx
         b4UGPXWiztjQe2Bli9qxbCaoDpbvKWtb3Eji3hyqpj+xRw/6SLUzgKD+HzhK1i5qkogq
         J29zM5QJnZNRildQfu5ZJoFJoT8Wds5cMYKCNhx6FKerS7O36Z9cCXRA4fkN2rL15psa
         6Q8s0Rf6+o1MQ0mmymFhDgF2D6BDliAHyDzB+aCCm5h7ruo7nxgdC6Juh3ph+eSDTwax
         Q5YOx0IaANjAqMqihRpIm1yFAcGXheMFD+WSC/ppjkrlgegvN1yKKvmT9umZi8Ovw2E8
         Q7XQ==
X-Gm-Message-State: AC+VfDwij2u8yu9fnPnfjHwAy9iQj7q63Hyspjr8KtLaB+YWMVsM/AYy
        JHGg7r8TEpQ5ee49TLWHi0Q=
X-Google-Smtp-Source: ACHHUZ6SVGptxnfbFk3yIWO1jRqdndgrCKb9iTt8VorBoY7iqcmWhzTe9X6SwI4SDIhgXrBSRv6w+Q==
X-Received: by 2002:a17:902:db01:b0:1a6:9f09:866d with SMTP id m1-20020a170902db0100b001a69f09866dmr14103429plx.61.1683568426162;
        Mon, 08 May 2023 10:53:46 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b001ab1d5726dcsm7527729plg.243.2023.05.08.10.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:53:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/2] gitk: handle long command-lines
References: <pull.1469.git.1674559397.gitgitgadget@gmail.com>
        <af2111f8-2669-b952-6c4e-45ee0330ec14@gmx.de>
        <fce603aa-ceb7-d601-6a19-657e36d9059c@iee.email>
Date:   Mon, 08 May 2023 10:53:45 -0700
Message-ID: <xmqqbkiupv4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 27/03/2023 10:17, Johannes Schindelin wrote:
>> Hi Pau & Junio,
>>
>> this patch series saw a positive review from Junio (thank you! I know that
>> you try to stay away from Tcl code, so I appreciate the effort very much),
>> but apart from that it simply languished on the mailing list for more than
>> two months now.
>>
>> Paul, is there anything I can do to help you integrate this into `gitk`?
>> Or is it time to pass over `gitk` maintenance to the Git project?
>>
>> Ciao,
>> Johannes
>
> I just tripped over this problem while trying to de-stack my Git backlog
> https://github.com/git-for-windows/git/issues/4408 "sdk gitk interaction".

I have done the same "create temporary fork of gitk, queue the
patches, merge the result down while asking Paul to pull from me"
dance I did every once in a while in the past (it seems the last I
did it was in Sep 2019 [*]).

 * The last merge from Paulus is ef9b086d (Merge branch 'master' of
   git://git.ozlabs.org/~paulus/gitk, 2022-05-11), whose second
   parent (i.e. Paulus's tip) was 465f0386 (gitk: include y coord in
   recorded sash position, 2022-02-20).

 * The two patches that originate from GfW have been applied on top
   of 465f0386 in the gitk history; the result of this is 7dd272ec
   (gitk: escape file paths before piping to git log, 2023-01-24).

 * The js/gitk-fixes-from-gfw topic holds a -Xsubtree=gitk-git merge
   of 7dd272ec into my tree.  This was merged to 'next' and
   hopefully will finish the usual 'next' to 'master' journey
   soonish.

Paul, can you fetch js/gitk-fixes-from-gfw branch of
https://github.com/gitster/git/, which will give you 7dd272ec that
you can use to

 $ git merge 7dd272ec

to obtain these two commits from Johannes and Nico?

Alternatively, you can fetch 'seen' from any of the mirrors, as it
hopefully should always contain that topic from now on.

Thanks.


[References]

* https://lore.kernel.org/git/xmqqlfum7epn.fsf@gitster-ct.c.googlers.com/
