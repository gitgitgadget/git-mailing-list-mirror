Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D2DC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABB161059
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348478AbhIIOTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbhIIOTc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:19:32 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581B3C10CA31
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 05:40:59 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id s16so993291qvt.13
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ksBp+1iRSckBeO5Avr/l1kMtdjPVxRhL9v4VKtebjN8=;
        b=bmM5PwzaFMViKfF8vgBTdiNXjDLjEiSGqsB68AjhAZZD0w2epLLP1aQZkYr4j4Pi6D
         Qe/Z172ojDDWUr/twuvSQml5mpZtQP5BGzyJ3alcgFxX3Lku+d/cj96Ic0EWhomAsGgR
         Y70h75/zBI0EEXQyvZBLkAx4zlTVM//LetLnjRupDBULKcBP+OCbmPofWvWD3cupKWV+
         ulIaNQkLsuFZSWdgedhAWCfja58cJstJlqtND+Tf2o/TAPvKhpv9yqRaw++VYujyK858
         GUgf0GSsS+P2mDSVlDn/rfI3sb8r/JU4DPSIQZ+BiRp+CZaDu0ndcEQkBXaGQa0uyfDk
         qC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ksBp+1iRSckBeO5Avr/l1kMtdjPVxRhL9v4VKtebjN8=;
        b=QGQq/gVH/oriY69woT7D42XZWspVNQM6kfN1805XulMhHrmt9rUXVBlgok3G3upzmI
         Yb5+5xKBGTnUITQfP7eNeGwG+LhBTcLcigrcVy9C7qER+P1aewGJuxWFeVqHwHe0p3TO
         SyGQFX6PwlvrFu+hFI/r4HtfCPUWZrFKUUaKE5q4HAkBDBVXCl30PTRjyUWoJX9vfdAG
         y+CyxXDvJyIeE7/rtY4UlaaRWloX7niBp7FpzNKzef09rYWzvt9PBX5htDjFfNjBuk09
         qJ2nm3Rsgq38p1ECcgKwtOp7AYnUFr6TtbjUmi2k9WY8rw0/GwPyrlyTJZECl5kqTTFl
         ik3w==
X-Gm-Message-State: AOAM5334mfLphmjibcSEjdCgRIEvQGjFB7uAagG8qim+RytUIy7t3ZW/
        TAQVlsxUfhVAzvEz0q+O85I=
X-Google-Smtp-Source: ABdhPJzZUHD9ickrYUE5ExpE7cVhfP1twiYq49o3PqV5WUkdbwOq2Dl1KU3EH90yUP0XxUVn2LncQA==
X-Received: by 2002:a0c:9a8a:: with SMTP id y10mr2659508qvd.15.1631191258404;
        Thu, 09 Sep 2021 05:40:58 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id h4sm1190889qkp.86.2021.09.09.05.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 05:40:57 -0700 (PDT)
Subject: Re: [PATCH 4/5] rebase -i: don't fork git checkout
To:     phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
 <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com>
 <f05dc55f-a7e4-b8f7-7b0c-5000bf48f803@gmail.com>
 <c42d4051-59cd-094a-4570-32cf4d38ec27@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <e7224105-83c6-7f12-f63a-474bd477583a@gmail.com>
Date:   Thu, 9 Sep 2021 08:40:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c42d4051-59cd-094a-4570-32cf4d38ec27@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 2021-09-09 à 06:09, Phillip Wood a écrit :
> Hi Philippe
> 
> On 08/09/2021 19:14, Philippe Blain wrote:
>> Hi Phillip,
>> 
>> Le 2021-09-08 à 09:41, Phillip Wood via GitGitGadget a écrit :
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> 
>>> The "apply" based rebase has avoided forking git checkout since 
>>> ac7f467fef ("builtin/rebase: support running "git rebase
>>> <upstream>"", 2018-08-07). The code that handles the checkout was
>>> moved into libgit by b309a97108 ("reset: extract reset_head()
>>> from rebase", 2020-04-07) so lets start using it for the "merge"
>>> based rebase as well. This opens the way for us to stop calling
>>> the post-checkout hook in the future.
>>> 
>> 
>> While in general I think it's a good thing to avoid forking, this
>> change might result in behavioral differences. Any config that
>> affects 'git checkout' but not the internal 'reset.c::reset_head'
>> function might play a role in the rebase UX.
>> 
>> One that immediately came to mind is 'submodule.recurse'. This
>> initial 'onto' checkout was pretty much the only part of 'git
>> rebase' that did something useful for submodules, so it's kind of
>> sad to see it regress.
> 
> Thanks for pointing that out. As a non-submodule user my question
> would be is it actually useful for the initial checkout to work that
> way if the rest of rebase (and the checkout for the am backend)
> ignores submodules? reset.c::reset_head() just uses unpack trees like
> checkout so if rebase read 'submodule.recurse' then reset_head()
> would work like 'git checkout' and also 'git rebase --abort' and the
> "reset" command in the todo list would start checking out submodules.
> I'm reluctant to do that until the merge backend also handles
> submodules unless there is a good reason that such partial submodule
> support would help submodule users.

Yeah, it's not that useful, I have to admit; it can also be very confusing
since some parts of rebase are affected, and some not. For example, any time
the rebase stops, like for 'edit', 'break', and when there are conflicts, the
submodules are not updated. So I think a full solution is better than a partial
solution; in the meantime I'm thinking the change you are proposing would actually
be less confusing, even if it slightly changes behaviour...

As an aside, I *think* reading submodule.recurse in rebase like it's done in checkout
et al., i.e. something like this:

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 33e0961900..125ec907e4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -26,6 +26,7 @@
  #include "rerere.h"
  #include "branch.h"
  #include "sequencer.h"
+#include "submodule.h"
  #include "rebase-interactive.h"
  #include "reset.h"
  
@@ -1106,6 +1107,9 @@ static int rebase_config(const char *var, const char *value, void *data)
  		return git_config_string(&opts->default_backend, var, value);
  	}
  
+	if (!strcmp(var, "submodule.recurse"))
+		return git_default_submodule_config(var, value, data);
+
  	return git_default_config(var, value, data);
  }
  

would actually also affect the merges
performed during the rebase, since that would affect the "global" state in submodule.c.
I hacked exactly that the other day but did not test extensively...

Cheers,
Philippe.
