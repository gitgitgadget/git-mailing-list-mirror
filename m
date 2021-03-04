Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D33C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 11:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77AC564F27
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 11:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbhCDLxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 06:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbhCDLw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 06:52:58 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9FDC061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 03:52:17 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id q14so32961641ljp.4
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 03:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JlPpYiMbmSr+TSW7KYLMphnpJ6dBQK70ZduYFBoyFbQ=;
        b=Ct0bggLyGghb+7oKVKsQtN/qjiBlYb67fnU1h4upiLqeUaqYGq/gmw201+p22rv9i3
         H7vKpsDhaxSuiBppR+uWHYgXLvYh5B13sJO9sdlek4d//Eh6uMPSmUfLOQOHRI+aGox2
         hxOPjVk2gdhkaq8+jXhQgEuvgTAYtTQ+u2MExLOaeTOTTHddtf539XGcsqk2pEGog8hD
         9dyM97d7MwTPPWhbQHgr2zk4sgh7A2i8dyfnNiRCucmtroMlV5QYiiIVo6dLJwy0x787
         DwEZMKQA1gC1dBP2NKUYQS5BHc2aiZH+B0DUoc29xbM7iFvhyAcIWgPR3ehDS5vJO57O
         oFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=JlPpYiMbmSr+TSW7KYLMphnpJ6dBQK70ZduYFBoyFbQ=;
        b=tWMEkJ5/l0G+3/9mcI7K3XHY1z1CficjtpkCJYYYzKEXXB0cyygv0x5oSt9dAlzybp
         5tG/RbAk4KlKXXovTQSknUIVT2X0VBu17wtl+jwkF3YbD5g8i7K+kg81aDbxo1rKoXLU
         NVcG+PRTQI3ywNYYUz5gtq/H2U5kyuJDS8sQU8UGHxC4qPxYUijXJioBaLMnInRPoWTO
         rSuvWls/NYZ2o1jbouIn6tpvqFAOynKEugq1yT17IlBn6K/xj0VVVzZ5LtiociAGzj94
         wUHHgmcT0DFpwx0fr/mxHC/0fUUoOwErTSoiDOt3mNBK96mkLrOcs5ecnXLSHEadn7LH
         YYNg==
X-Gm-Message-State: AOAM532fipMtsVZIfjHm/RhUrVRiQtW59TSJAIZGF9Y2JtA4boO4PBhc
        bqhO3hwUZNpgww5+N7fZPIkeI9bFuXQ=
X-Google-Smtp-Source: ABdhPJxtFuvJ6i7pJxxe73dJvM8d4mllQmeJkC/arsN0yqb+YZPsbmv43whUfRq+xda2F23/79uaXw==
X-Received: by 2002:a2e:9118:: with SMTP id m24mr2080699ljg.415.1614858736175;
        Thu, 04 Mar 2021 03:52:16 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b11sm2976366lff.159.2021.03.04.03.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 03:52:15 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git pull unclear manual
References: <874khsqq0o.fsf@osv.gnss.ru>
        <xmqqv9a7emx6.fsf@gitster.c.googlers.com>
Date:   Thu, 04 Mar 2021 14:52:14 +0300
In-Reply-To: <xmqqv9a7emx6.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 03 Mar 2021 17:18:45 -0800")
Message-ID: <87blbzm901.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Here is how "git help pull" begins:
>>
>> <q>
>> NAME
>>        git-pull - Fetch from and integrate with another repository or a local
>>        branch
>>
>> SYNOPSIS
>>        git pull [<options>] [<repository> [<refspec>...]]
>> </q>
>>
>> From this, how do one figures how to "integrate with ... local branch"?
>>
>> Is "git pull" useful to integrate with a local branch at all?
>
> Yes, you can refer to your local repository as ".", so
>
> 	git pull . another-branch
>
> will integrate the history of your local "another-branch" into
> the history of the branch you have currently checked out.

Nice, thanks!

Do you think the manual needs some improvement still?

I mean, I'd then expect something like this as the SYNOPSIS:

"git-pull - Fetch from and integrate with another or current repository"

with further clarification in the DESCRIPTION of how integration with
current repository could be useful.

The present description, if we drop "another repository" for the sake of
the argument, reads:

"git-pull - Fetch from and integrate with a local branch"

that sounds plain wrong to me.

Also, I got confused further as the manual consistently uses "remote
repository" to describe <repository>, and that doesn't easily maps to
"current repository" in my mind.

Further, the manual says that <refspec> is simply passed to the "git
fetch", and "git help fetch" adds to the confusion, as it says:

  git-fetch - Download objects and refs from *another repository*
  
  Fetch branches and/or tags (collectively, "refs") from one or more
  *other repositories*, along with the objects necessary to complete
  their histories.

that doesn't suggest "current repository" in some form is allowed
either.

BTW, why are these "other", "remote", "another" attributes there in
the manual in the first place? Why don't just say:

  git-fetch - Download objects and refs from repositories
  
  Fetch branches and/or tags (collectively, "refs") from one or more
  repositories, along with the objects necessary to complete their
  histories, into the current repository.

Thanks,
-- Sergey
