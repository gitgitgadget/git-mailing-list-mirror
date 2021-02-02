Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF05DC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B23464EB9
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhBBDYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhBBDYj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 22:24:39 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA792C06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 19:23:59 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id d13so19813684ioy.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 19:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dj1bb3IfGEsQIGCn9vf095/azcZLhVx+/xF6l6Sx+9U=;
        b=fL3PeJrywS6h40//933n4tMXBWCwSE4D88Kxb0TZ5rF3WX1PasuSmgrYI02JvFVJHM
         i2zxGm5fE6Xao5ZHTX/5vkgx/nXXLIQsFGHcs64O2ERq1cIPkyZ5JePqW3qKu4PBHfl6
         GoXOpMwNpG/X7JP64F2wnhXjJsDxFzpHi6Bm83VFLjLpcE2b15gIvNstu458cS6DYW9g
         n2QbP9lOqLs8NvEnr69d3tg064FjyW19kI0I9DhhXh4YicqY6fmFHlnbd2G4D7ik00Pa
         CGcssS2pEw30MHTZ8a9qejq6JCaLXyMvSyvOi7drFtkoFPlTUB5IHsAihXiLFHxaCizD
         amHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dj1bb3IfGEsQIGCn9vf095/azcZLhVx+/xF6l6Sx+9U=;
        b=RyhbG5wlBmF5QZGVqzVX9DAvwmqgoPEXiM5mrbEsOY+xLGtW3XlEvAykUKxQP/Y+Bq
         uwnFc1MhH3nYmFJWdes6hC3SwG4qVBmOiCY4slsMyBfoV8VcL0c3z4IpWPj5EnT//QZn
         B3+zrvjHUWqk5rGcImCOXL822TkU+S/6Xglb1Msd47tINuEHDRSz/KIjyZ58g5xoPrV0
         eJWzlVIS84enhn1EFP4MvHLglDkIttAurEOnZuQNVYJprnZZh6hyYM8O42aVKLABmX9+
         5fLvJl2NHKqHj0Q/tjTNFGF0p5fN8pfPOVRW3oURlpaKZDMkJofpB2qQszmoTbNRwZeN
         kJVw==
X-Gm-Message-State: AOAM5325dT56EMdCkIxoT11tk7H9FYcBxTBnbCQSDOJV2AOWBJwsUT9x
        RgnLmnhFCAoTOFkexxgs25ALNf/FBKRa6w==
X-Google-Smtp-Source: ABdhPJxSeVIzWFJDdSaq/Lx9hPHgTfX0jyJOvMs5b3lLopUb/F28H3IFBZzY7zxeSpDhBpHyIeG+Tg==
X-Received: by 2002:a6b:f904:: with SMTP id j4mr4766418iog.138.1612236239167;
        Mon, 01 Feb 2021 19:23:59 -0800 (PST)
Received: from flurp.local (097-070-162-226.res.spectrum.com. [97.70.162.226])
        by smtp.gmail.com with ESMTPSA id d13sm9412398ioy.26.2021.02.01.19.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 19:23:58 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH v4 9/9] doc/git-rebase: add documentation for fixup
 [-C|-c] options
To:     Charvi Mendiratta <charvi077@gmail.com>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Marc Branchaud <marcnarc@xiplink.com>
References: <20210124170405.30583-1-charvi077@gmail.com>
 <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-10-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <f3e2b9ce-3dfe-e33a-6149-ca23397b1690@sunshineco.com>
Date:   Mon, 1 Feb 2021 22:23:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210129182050.26143-10-charvi077@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/29/21 1:20 PM, Charvi Mendiratta wrote:
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> @@ -887,9 +887,17 @@ If you want to fold two or more commits into one, replace the command
>   If the commits had different authors, the folded commit will be
>   attributed to the author of the first commit.  The suggested commit
> -message for the folded commit is the concatenation of the commit
> -messages of the first commit and of those with the "squash" command,
> -but omits the commit messages of commits with the "fixup" command.
> +message for the folded commit is the concatenation of the first
> +commit's message with those identified by "squash" commands, omitting the
> +messages of commits identified by "fixup" commands, unless "fixup -c"
> +is used.  In that case the suggested commit message is only the message
> +of the "fixup -c" commit, and an editor is opened allowing you to edit
> +the message.  The contents (patch) of the "fixup -c" commit are still
> +incorporated into the folded commit. If there is more than one "fixup -c"
> +commit, the message from the last last one is used.  You can also use

Erm, s/last last/last/ or even better s/last last/final/

> +"fixup -C" to get the same behavior as "fixup -c" except without opening
> +an editor.
> +
>   
>   'git rebase' will stop when "pick" has been replaced with "edit" or
>   when a command fails due to merge errors. When you are done editing

It seems like an extra blank line sneaked in between the updated 
paragraph and the paragraph which follows it.
