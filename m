Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9ADCA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 12:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbjILMNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 08:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbjILMNS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 08:13:18 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D248C10D2
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 05:13:13 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-64bd231c95cso31886736d6.1
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 05:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694520793; x=1695125593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cy4eFJqQqqkpAKB97dt21OnUMJCiYxzxA5kUMWaV9xk=;
        b=gDa1HlM6vbzJKZYwgJK18oF9kyTtpHDOhT+Lt7BiX1yDsUvvRp2lB6pQzTpz0WIZyA
         ZkhWyAh6cbFuNDmDe5fOkuYdOI2ldSr0qQNBWdghnKj+WH9KU1GSvXZ5aElkiEyFefjr
         8NvtWaTzrUXca0JZyb54Wg8ceXXFI+auSD6bpDyOx6arnC1jULWUSe9iApbOe2bZCFJ+
         vUWtGHT0m2D7fq9oBmZ44maIYD4LmA8FmlrpQiMM80CiFYGrUJytn2ZMaGzWUW+bLLjL
         JyoNRZM12pfvO9N/TeqW0S7Vu1xzPrkl1AZakNkhLn5UAUc8D7P10QFN/3RewB8jcMPG
         gOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694520793; x=1695125593;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy4eFJqQqqkpAKB97dt21OnUMJCiYxzxA5kUMWaV9xk=;
        b=TvNqkHDea4lt2AYRqHc9A0VkMXTFdUIHxYVo94jQKde64dPC5XcNqQ/lJ4GadI1tnW
         /y/LmrhiHiGvlaViqBA7GuWJ7Zix7ZWtZCOyy9Je3+TMOFR3Q+qltxJktW5Iu5P3S4dS
         eUI8mdjmIokIVNLak4t445cRCcrU0iXkgo2exR6okTFvxh+chmyzsjXm7KqKZx//ANy4
         +J2uqvNMQP6RMcxDG5ZBPqTSZ6Lt70K+iC0auxdojDYvQ9EuPu75h73ggQQ6S2iwagOE
         xaBQxDsx7e5MrrZZp9bXLpx2klVQN7euhmKfRleMLR2T11G3cqtif0/6L33kNkRzVrmE
         XzmA==
X-Gm-Message-State: AOJu0Yy9cZx3yNxAntf3aRIBEsyRyGl8Ri/SR9jG/MLLr0Iqt3t8cHA9
        xUCZoPd9Dk232XLuf1/qbkE=
X-Google-Smtp-Source: AGHT+IHuEI0x0j1pS+WojDXDH4dvTaCsEVLTygZ+ZFsIIxDANLsYEIj8/h3hw3Wf+5SHeywfpnZfiQ==
X-Received: by 2002:ad4:42b0:0:b0:655:d6ff:891f with SMTP id e16-20020ad442b0000000b00655d6ff891fmr9020747qvr.60.1694520792878;
        Tue, 12 Sep 2023 05:13:12 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e8c7:b51a:6c64:3ea6:f949? ([2606:6d00:15:e8c7:b51a:6c64:3ea6:f949])
        by smtp.gmail.com with ESMTPSA id b4-20020a0cb3c4000000b00655935bca82sm3677615qvf.134.2023.09.12.05.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 05:13:12 -0700 (PDT)
Subject: Re: [PATCH] completion: improve doc for complex aliases
To:     Linus Arver <linusa@google.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Steffen Prohaska <prohaska@zib.de>
References: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>
 <owlyil8gkxrm.fsf@fine.c.googlers.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <c84c75cc-a7e2-ae29-71d0-ea41a61a2d23@gmail.com>
Date:   Tue, 12 Sep 2023 08:13:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <owlyil8gkxrm.fsf@fine.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Linus,

Le 2023-09-11 à 21:04, Linus Arver a écrit :
> Hi Philippe,
> 
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> The completion code can be told to use a particular completion for
>> aliases that shell out by using ': git <cmd> ;' as the first command of
>> the alias. This only works if <cmd> and the semicolon are separated by a
>> space. The examples have that space but it's not clear if it's just for
>> style or if it's mandatory.
>>
>> Explicitely mention it.
> 
> It would be even more helpful if you explain _why_ it is mandatory in
> the commit message. Is there some Bash-specific behavior or something
> else going on here?
> 
> If you are unable to explain why, then as an alternative you could
> explain the error or buggy behavior (any error messages encountered, for
> example) you observe on your system when you do not use the space (which
> is corrected by applying the suggestion you are adding in this patch).

Yeah, I guess I did not investigate why it did not work without the space,
it would be more complete if I did.

There's no error message though, it just does not work without the space 
(as I wrote in the commit message) in the sense that it won't suggest completion
for the git command '<cmd>'.

I'll investigate and update the commit message.

Thanks,
Philippe.
