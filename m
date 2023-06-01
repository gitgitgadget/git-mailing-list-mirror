Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D93EC7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 04:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjFAEni (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 00:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjFAEnd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 00:43:33 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFE8123
        for <git@vger.kernel.org>; Wed, 31 May 2023 21:43:27 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-626117a8610so4983726d6.1
        for <git@vger.kernel.org>; Wed, 31 May 2023 21:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685594607; x=1688186607;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dVGV16qBT0eYz4zK6iAUqWOLKrQeqJYeNg1zR4OjnQ=;
        b=fPreaI7yLKURX3TV2ILz+PpKJgOBwUxj+lVuOT+mNr63MLz+KA7fb39y5QgHGiRlaU
         xYioMXe3722vYhfVoFN5uC1M1rLqMZIvtD1KGqJjURfCN4VrwZP2iiQLmkcdgMYSmIj1
         dAjKuy/FBneENXV3OJStZbqGFy5Kf6t2EVEWReJgF+vPEGCQa/lQeaLcYieMtE/ZDCqe
         khZzKw/mP9WfWirRGNRUOlI5sHDw2mmjfNAOiEfJ+jeV4YMcNg4FRMKrQGg9+AeMfCEQ
         OBZKe21HulFvDyWR/XZ/lewn4JjjyX28MrYNBoofTKWUFNqnOWl63DNYx48ClkxbEc9Y
         iF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685594607; x=1688186607;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+dVGV16qBT0eYz4zK6iAUqWOLKrQeqJYeNg1zR4OjnQ=;
        b=bWtw6npCCxXGkXFjtkkaqO3wSCy+MVj+wbyGSIQellaGJgrX+VluM03IZnlCy9b8CW
         7dTvCsqJksYxbLYC2N6BE5xVaR+JOxauCzKyuRCH6X4QIlmkhPhkKfPxT4vrzxwG1I3T
         Ilbb6zP17fUdrhqM4WQmA5gVblrmtAW2PHcMuW1gmA0JxmbITn1dhfODbFYjCI/AHL1F
         1/bV8Quy6VMgMnBIpdMDAr+aX9eQfkUlDmie3fZdyVE3u2MZfbBbtgP7QevnDE53qpZM
         Ja8FqMUxvRzyI+D8qkwmODIrCw/RQqUGVXiQuG/rwLt5v6OMoXhw2LhXq9rLfDmXClqu
         2Iow==
X-Gm-Message-State: AC+VfDw79fYeJBJsctVdG/PCURAPzvA3ImNgfAiPP7qiJAN1f5lqSln0
        19Lth8bw3gOV/f+rfrLVYzc=
X-Google-Smtp-Source: ACHHUZ6Eh7LQBR9tW2pLlSp9iUK+OgopmGD/VeskXVguJ1ssnQqnfr1dtmVM9UdJuUVq6rl3r/NtRQ==
X-Received: by 2002:ad4:5aae:0:b0:621:2d89:524a with SMTP id u14-20020ad45aae000000b006212d89524amr9045948qvg.32.1685594606800;
        Wed, 31 May 2023 21:43:26 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c20200b001b06deeb319sm2217435pll.300.2023.05.31.21.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 21:43:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        derrickstolee@github.com, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 3/3] repository: move
 'repository_format_worktree_config' to repo scope
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
        <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
        <506a2cf8c73549bc8f9761b56532ef08ed220da4.1685064781.git.gitgitgadget@gmail.com>
        <kl6lr0qwno2q.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 01 Jun 2023 13:43:25 +0900
In-Reply-To: <kl6lr0qwno2q.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 31 May 2023 15:17:01 -0700")
Message-ID: <xmqqedmveqs2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> @@ -1423,6 +1422,9 @@ int discover_git_directory(struct strbuf *commondir,
>>  		return -1;
>>  	}
>>  
>> +	the_repository->repository_format_worktree_config =
>> +		candidate.worktree_config;
>> +
>>  	/* take ownership of candidate.partial_clone */
>>  	the_repository->repository_format_partial_clone =
>>  		candidate.partial_clone;
>
> This hunk does not copy .hash_algo. I initially wondered if it is safe
> to just copy .hash_algo here too, but I now suspect that we shouldn't
> have done the_repository setup in discover_git_directory() in the first
> place.

That's quite a departure from the established practice, isn't it?
Due to recent and not so recent header shuffling (moving everything
out of cache.h, dropping "extern", etc.), "git blame" is a bit hard
to follow, but ever since 16ac8b8d (setup: introduce the
discover_git_directory() function, 2017-03-13) added the function,
we do execute the "setup" when we know we are in a repository.

It would probably be worth mentioning that the "global state" Dscho
refers to in that commit is primarily about the current directory of
the Git process.  During the discovery, we used to go up one level
at a time and tried to see if the current directory is either the
top of the working tree (i.e.  has ".git/" that is a git repository)
or the top of a GIT_DIR-looking directory.  That was changed in
ce9b8aab (setup_git_directory_1(): avoid changing global state,
2017-03-13) in the same series and discusses what "global state" the
series addresses.

If a relatively recent and oddball caller calls the function when it
does not want any of the setup donw after finding out that we could
use the directory as a repository, a new early "pure discovery" part
should be split out of the function, and both the function itself
and the oddball caller should be taught to call that pure-discovery
helper, I think.

> If I'm wrong and we _should_ be doing the_repository setup, then I'm
> guessing it's safe to copy .hash_algo here too. So either way, I think
> we should introduce a helper function to do the copying, especially
> because we will probably need to repeat this process yet again for
> "repository_format_precious_objects".

I do not know (or care in the context of this thread) about the
"precious objects" bit, but .worktree-config is the third one on top
of .hash_algo and .partial_clone, and it generally is a good time to
refactor when you find yourself adding the third instance of
repetitive code.  So I agree with you that it is time to introduce a
helper function to copy from a "struct repository_format" to the
repository instance.

