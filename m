Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9460DC4167B
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 04:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjAAEs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 23:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAAEsz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 23:48:55 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8412463B3
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 20:48:54 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id bn6so16226721ljb.13
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 20:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AEyXk42DjXFIrv14PcUj1mVNre6s1/EKamr/t9G0XM0=;
        b=mu045yBD6oYyP9x4oFrB3SZrmSleVi+ZDQ1A+aYAyihamdqv/+Wd6EVbwVYnvAh9DN
         A9jjsnSeFeWUJUyHNoLJivVhcepKIrqz95xmxww2dm7F5nvtHcsfO5cD2jngJJM7gN5c
         QsQhL49gQ3KKU6IjuASlh5VHWgDiEHEeVi/luZjKcYDo1ZF/kTtfaTWgLk/BBYz6IU5R
         zQrscxJgIxYrlFu75cqNT5aFOJIICcA5U78S9SU7HjHilCt/5b9M2Op1mNpXW2QjZGtb
         x2yVxVnLjOCr5XQzMZIynt3A8Ih0dYwaQKSr2LjT+aSyeygykmdsoswDRrcqst9WdJNO
         XSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEyXk42DjXFIrv14PcUj1mVNre6s1/EKamr/t9G0XM0=;
        b=RtoAJIdQsn5aVn5XNd0jMnyOrgZPlrAxJupT4Ed+1e6GOk6GkbZSs/JVAY9mtlvnAb
         zXuXDBHWnQe8ces9gr7cMn94PBQcsXyJl4FtB1McfO8rmv6KUVtuenxzsuCYIXxhJUKl
         gVPPeHud9vEpIJ+cxQ/V4Gs/cmooAVy7NxbqoY96xInVgLuYX8oqikih8K9iJnwi7UrC
         HSAWZFLM4UG/yNsGZe3j+lwqRKU8aWCcEq/yrZrU3PGubj4pAWnqX9z9yjw/M/rQVDDr
         2AAwVt8o4FbbYTlQmNRsrawdgfxYlqw9XXtDFu98leJhoT/9kTUmfaECHoVWfUQMcQ9n
         Ltbg==
X-Gm-Message-State: AFqh2kpsB3WsuFMLlcGnbp4wiT/LsmqAKaCFfoIqxjTKNRAu53t1sg0J
        t4zzhiuf01v+OZIeaYLSSK2FALl4y9jXhMc6nO1mkh9Jusa2bfT2
X-Google-Smtp-Source: AMrXdXv7mB7ttb+Y+m91k4RC5XVFER1CsTFqfoHyrBg3T0Mk37wIaaBn2vvsvowuDbRjbcNroUqK2f7DTx3vKdh6ptQ=
X-Received: by 2002:a05:651c:c91:b0:27f:c7b3:31b3 with SMTP id
 bz17-20020a05651c0c9100b0027fc7b331b3mr1097668ljb.361.1672548532739; Sat, 31
 Dec 2022 20:48:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:aa6:c266:0:b0:23b:5e81:46ba with HTTP; Sat, 31 Dec 2022
 20:48:51 -0800 (PST)
In-Reply-To: <CAJcAo8sJo8mE5V8_3eGj3miirNOJfQGsDH+=7HmSrwvLC=Ch3w@mail.gmail.com>
References: <CAJcAo8tjMLFisK5_13iD_JGo2xVQDJRX3wAC7wRD_V2GKFGevQ@mail.gmail.com>
 <xmqqlemmhp97.fsf@gitster.g> <CAJcAo8sJo8mE5V8_3eGj3miirNOJfQGsDH+=7HmSrwvLC=Ch3w@mail.gmail.com>
From:   Samuel Wales <samologist@gmail.com>
Date:   Sat, 31 Dec 2022 21:48:51 -0700
Message-ID: <CAJcAo8sBT26BNg4j9EPCqwxpFF36QVMEqQnUDhqXQ3UH3AOPjA@mail.gmail.com>
Subject: Re: is this data corruption?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

of course i am still hoping, if possible,for generic adice on
repairing a repo, detecting a bug, whether it is a bug, what looks
curiously strange, maybe some more questions like the previous one
about what does --cached say, what does --histogram and --patience do,
etc., any of this whether or not a repro is possible.  will repro if
possible just seems impossible.

On 12/31/22, Samuel Wales <samologist@gmail.com> wrote:
> hi,
>
> thanks for reading/thinking.
>
>> Sorry, but I do not see any "-" versions in the above.  Simple and
> minimum reproduction recipe would be useful for the list to help.
>
> the - versions are identical.  as i wrote, there are 2 - versions in
> addition.  i didn't want to make a pointlessly long email.
>
> it would be great if i could provide a reproduction recipe.  i don't
> know how i couold do that in this case.  for example, when i try to
> pare down the repo and make private things obscured, i run into the
> proble that when i do staging, things change around, thus erasing that
> particular bug.  and other stuff like my limited knowledge of git.
>
> i'm afraid i am stuck with hoping for other types of solutions like
> "i've seen this before" or "that's not possuble unless..."or something
> a priori like that.  but if you have an idea of how to create a
> minimal repro in less than a week, let me know.
>
>
> On 12/31/22, Junio C Hamano <gitster@pobox.com> wrote:
>> Samuel Wales <samologist@gmail.com> writes:
>>
>>> the problem that seems like data corruption is that a few lines appear
>>> twice as - and once as +.  but in the current version of the files,
>>> those lines exist only once.  here are the lines.  there are 2 -
>>> versions and one + version:
>>>
>>> +***************** REF bigpart is a partition
>>> +biglike and homelike are distracting nonsense i think except
>>> +to describe inferior filesets.  anomalous subset of home
>>> +might be called homelike or so.
>>
>> Sorry, but I do not see any "-" versions in the above.  Simple and
>> minimum reproduction recipe would be useful for the list to help.
>>
>> https://www.chiark.greenend.org.uk/~sgtatham/bugs.html
>>
>> Thanks.
>>
>
>
> --
> The Kafka Pandemic
>
> A blog about science, health, human rights, and misopathy:
> https://thekafkapandemic.blogspot.com
>


-- 
The Kafka Pandemic

A blog about science, health, human rights, and misopathy:
https://thekafkapandemic.blogspot.com
