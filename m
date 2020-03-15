Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A05DC10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 13:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECB4205C9
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 13:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNPshZu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgCONlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 09:41:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43820 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgCONln (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 09:41:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id p125so14830959oif.10
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hgzjSYNpo3c3en97pcLCuozGXoHTGnsOvkVAqzxx86Y=;
        b=VNPshZu16wq2GkRkdnbo2y0lGxaHSTzrfYR5+ZW2qXRSszYpmMypM8gy1ClJ2Hg3m8
         JFZsWRgk8+tpmSkEnLVeRhU8+Rt0NUC4j1XCVYAWXrpzIU6QMmn36r/zBg+zLTOlWH4M
         bodWYEb9JMXBjh+p6e6vD9gQSxg565W+9ABFxCwKeGU7RvNVXJKS84VIIUhRYtombZ72
         j0OzRZGH8W5AjDRa7CSHK1aih5xXRQgwAoaerChIhqoCOvXQ+lCJTsAsByCQkiZN7xgs
         ODuYDj793sQu8PaJe1ShfcUlEYki5pCm/vg1fu7SMVMVPihrFZjrrt+hrEp8gnrvmjpi
         xhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hgzjSYNpo3c3en97pcLCuozGXoHTGnsOvkVAqzxx86Y=;
        b=f9ATe0/6wfjQk6zy4l8VYtsDm1EC5BT4mn8+Iqk9gUVBYsWszk2S66A/T9Q5YOXn+s
         CY7s2jLDvcKIUnq3m7UVHFb6wMGEGMWukRSg+dKpnw9FXuvgcp6A12U2Ibf7c88K0997
         BH1OmRBL6iTfMBw8JnHVMCOs0PkuQ5zQyozAB8qgEB4rNleaWY62eGpe2LUqZ3GTviT3
         EXrKr2YFQymqEw/4fDlB/A6UYFZG3D8O4VCziexGBYrvCs/vHnKSj2VnjO6PqIC3bLzU
         dw7/PZydhk28T8116qBDYu8HuKn+F1f7mRnNushlQlMdT81wpyGEAX/JVon7ygNUvDxl
         iyWA==
X-Gm-Message-State: ANhLgQ32KgabJTZ8/CekBeJsEVVVBq2fAWC+DLuVk7jdAV17cAc1LQkf
        qhbMgKfekKI3UYD1+mjJFZc=
X-Google-Smtp-Source: ADFU+vvoQthYaSLGnrjT23S6uQZkhsIGnIh8jV9wjEc3d8w8vz0wPx//ChDlLUzQcKRIhYoui3Kchg==
X-Received: by 2002:aca:f183:: with SMTP id p125mr7396305oih.74.1584279702941;
        Sun, 15 Mar 2020 06:41:42 -0700 (PDT)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k185sm10088061oib.5.2020.03.15.06.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2020 06:41:42 -0700 (PDT)
Subject: [RFC] Universal progress option (was Re: [PATCH] clone: use --quiet
 when stderr is not a terminal)
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <pull.581.git.1584133742475.gitgitgadget@gmail.com>
 <xmqqh7yqc16w.fsf@gitster.c.googlers.com>
 <a044478f-ca04-3475-90de-0332e80f552d@gmail.com>
Message-ID: <310a176a-1b30-a479-638e-33a51fb2c896@gmail.com>
Date:   Sun, 15 Mar 2020 09:41:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <a044478f-ca04-3475-90de-0332e80f552d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2020 8:20 AM, Derrick Stolee wrote:
> And I was coming back to this thread shortly after waking up since
> I realized why the test fallout was bigger than I anticipated: this
> change shouldn't enable "--quiet" but instead "--no-progress". The
> loss of messages like "Cloning from ..." is actually a problematic
> behavior change.
> 
> I'll send a v2 using "--no-progress" instead.

...and then I find out that "git clone --no-progress" does not stop
the "Updating files" message because it does not pass the progress
option to that subsystem.

Please eject this patch for now, since "--quiet" is too aggressive
and "--no-progress" doesn't work.

...pause for change of topic...

After seeing too many of these "let's plumb the user-facing progress
option from the builtin into the underlying subsystem" patches, I have
half a mind to completely rework how we handle "--[no-]progress".

Here is a proposal for making the progress API easier to use, and
hopefully clean up our code around it:

1. Add a GIT_PROGRESS environment variable that is a boolean for
   showing progress or not.

2. Update Git's option-parsing to check for --[no-]progress in
   every builtin (before the builtins do their own parsing). If
   present, this overrides GIT_PROGRESS. Otherwise, if GIT_PROGRESS
   is unset, initialize GIT_PROGRESS to the opposite of isatty(2).

3. Update start_progress_delay() and start_progress() to return
   NULL if GIT_PROGRESS=0.

4. Refactor the callers of start_progress[_delay]() to call it
   unconditionally and remove the variables used in the old
   conditions.

While typically adding global state is undesirable, the current
mechanism of passing progress flags from builtins down to lower
layers (and adding --[no-]progress to subcommands) has shown to
be difficult to keep consistent and makes the rest of the code
messier.

I'm interested in pursuing this refactor, but only if the
community thinks it is a good idea. There are probably better
alternatives, too. Please let me know.

Thanks,
-Stolee

   
