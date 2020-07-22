Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAFFC433EA
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 22:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F582086A
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 22:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5Kh0xYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgGVWsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVWsi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 18:48:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA317C0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 15:48:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a1so3007991edt.10
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 15:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OIvPmy161fFsHWnNShM7lWfi6FIk3u6qpXe9QLRa5Bg=;
        b=u5Kh0xYA2eCksvvBT3dhJAKDMj9Iq+QRAhwclVv/sv9oAc0TM85ezlgV/W4m1zQdw9
         ekpjB8rm4QhzZ+PCiQgFWvmr02YDnrcOfroCwHAw2HF+mOYVVkS+ex1ZxrLZkte02gWe
         e/AYLpZ66PPz7+8ScbheP31m5TUKg0Gkkc6Q6GbOcgpW28fiPy0jKcM0+dBmQD2OrzMi
         h276u6aCp2l5ZOyZ2yPX/0cySvs6AqoCxiakdtKXUg3k38T/n425+LhIxLwmgxWs5sXR
         CcD7KDN6tR0EQiow2sSI1b8Jlt/7gLYegQYagEvNx0kelDHDCjWr/a75xJDbNdTeChOd
         1hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OIvPmy161fFsHWnNShM7lWfi6FIk3u6qpXe9QLRa5Bg=;
        b=Q4r4mtw1nRj5HjmwLPBCF76LxkLmO3qgWoJX3ac0f7Go5+aLLe7KLVAN01UH33BzEe
         INn4fx6MasBvYqcMKua4CD+PnJQhCBviepHyvYcTCXRYCnC3pOdHvgM6wzGiZ+2yWvxG
         6e9J9cet9BKF97vSLMZ5j7RmnPEMH5sJh/cMzTHKMWCL6vGLLWFM00PuWDKBXUzrmVe/
         bHvxW1ixBXEpuecI1pzlymDySVfEyjwm3/in6vJtbEO6c+dICxKSwErEe2wuKdJ8CHbm
         GsSVtAZzBhfapG5uAtZDBITlSIrz5ZF/fgcKgwuZLuDyn6HPyveCcxMYkR+jfEju7MCh
         8Hjw==
X-Gm-Message-State: AOAM532efick2pTvJx9Cq0rmoaTuKzq6x41r/0wpW4H7/fCK4mmpczU3
        U0IBXLME6XqRVZ/L6pH38L5upqV9TGA=
X-Google-Smtp-Source: ABdhPJxDiuSBNK135+TFRz+mF0P77e9RWyljLuNmZeg/bWkFnYLjS9zu08KOObnt+6LGsIDqe6UlKw==
X-Received: by 2002:aa7:dd8e:: with SMTP id g14mr1653977edv.208.1595458114464;
        Wed, 22 Jul 2020 15:48:34 -0700 (PDT)
Received: from ?IPv6:2a02:120b:2c36:8d20:f46f:28e1:511e:2a36? ([2a02:120b:2c36:8d20:f46f:28e1:511e:2a36])
        by smtp.gmail.com with ESMTPSA id h24sm688398ejg.53.2020.07.22.15.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 15:48:33 -0700 (PDT)
Subject: Re: Improving merge of tricky conflicts
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
 <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
From:   Bono Stebler <bono.stebler@gmail.com>
Message-ID: <7c3cf4f4-c8aa-66d6-ae6f-88271e21d5ae@gmail.com>
Date:   Thu, 23 Jul 2020 00:48:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your reply, and everyone else in the thread. I've played 
with diff3 and while it is slightly better in some cases, I feel there 
is a much better solution. To illustrate:

Commit 1: https://i.snipboard.io/Ssm7M9.jpg
Commit 2: https://i.snipboard.io/l2pqdT.jpg
Diff3: https://i.snipboard.io/teb1RS.jpg

What I would actually want: https://i.snipboard.io/8dOHgV.jpg

After looking at it and some research, I've managed to mostly automate 
it. You need to manually set the filename, which isn't as convenient as 
having the details directly in the file, but it beats rummaging in 
commits manually by a lot:

# Patch failed at 0001 smol commit

FILENAME="conflicting.txt"

THEIRS=$(head -1 .git/rebase-apply/0001 | awk '{ print $2 }')

OURS=$(git rev-parse HEAD)

THEIRS_DIFF=$(git -c color.ui=always show -U0 $THEIRS $FILENAME | tail 
-n +12)

OURS_DIFF=$(git -c color.ui=always show -U0 $OURS $FILENAME | tail -n +12)

printf "<<<<<<<<\n$OURS_DIFF\n========\n$THEIRS_DIFF\n>>>>>>>>\n"

Voilà, feel free to use that or suggest improvements, I am by no means a 
bash or git wizard!

Cheers,
B

On 22/07/2020 07:50, Johannes Sixt wrote:
> Am 22.07.20 um 01:29 schrieb B. Stebler:
>> I have been looking for a tool to display merge conflicts, that instead
>> of showing the two versions of the conflicting section, would show the
>> diff for that section in both conflicting commits.
> Perhaps you want to configure `merge.conflictStyle=diff3`? It does not
> exactly show a diff, but it writes the base version of the conflicted
> part in addition to "ours" and "theirs".
>
> -- Hannes
