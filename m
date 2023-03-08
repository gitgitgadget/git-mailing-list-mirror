Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3614DC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 20:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCHUmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 15:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjCHUmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 15:42:16 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A5B1F91A
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 12:42:14 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id n5so20640pfv.11
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 12:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678308134;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59Ck2BtvXyIcP44UJM0bW+Y2aQJ7kPQhKCDUjVr7c88=;
        b=ZZixx0MmEUP2LICs/hrCWgzZ8RzoxcO0mWxg7nWKmrKzjwE5niTiIkfiTVS9e+6nd7
         jQhSQ2gKDcR/bgTnqFL9wMpvzJp9Gboj+PUENaaWjw2NNxx5N8hLlnXCn9DEHQ6++L6n
         dXDU+jU6hZ9towRnYougdBZt45ONADpP+xHmV0a44YY/gwmwfpPY47G5og2ydFYEBcRU
         PIQSO8RaA9Ps3NxQYRsstL9UCbr82k9HHCEzV3RT8ialxUzOYZ74Qbk8DbzXbjR7Xql7
         05KfbtZxveJUT/lM5j/IO3FoY9ctON60GcgR42i5Ngoq0S6fDdVefzFZBzMWtbg7D08P
         74og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678308134;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=59Ck2BtvXyIcP44UJM0bW+Y2aQJ7kPQhKCDUjVr7c88=;
        b=o3bGFO3VeV8N44vaoA8OzDK/paAuGCqStTsSwn/xqUwKWJu5MCtI8ygU22sXnmgF9J
         m221r1SAJCgzzQhpsuPaH98///kqDkTAhiiL7e3wIlQX95pgT4fl4a3aNJ3Davu09oI3
         PU3d5Gj78G/r6N1OEeHsA+3MIcbQmQtfKmW0x8sJDxr3F1KsaAT0LayD1m62b7JOlXOT
         33/8DObAK4DEDCfZ+MWUXvtiolz+UXsHNVPRSBvRyz6dS/zYnJkL6IQS7JJsyp5sPFYc
         4ZRiy/D/R9S91BYuS2TYQ49m3TsfzKGCKr7Yda//rNNkgf6kXFMb3oPTSR+bd9q5oJSz
         sMbg==
X-Gm-Message-State: AO0yUKVlJcJEl+j9NBjAstnG9pLm4MV1AI+3GQ+qtZj7cw+QonUgP1Ge
        2FsGFpfHe+XvrFePxQw1XBU=
X-Google-Smtp-Source: AK7set/b95p7y4HnD3RooYTpTyGt3Moo9IkJQjAwxxp3I/YxsxaeOJne8gOBhiMbHu9Zwa7ACqYjXQ==
X-Received: by 2002:aa7:9552:0:b0:5a8:b2c1:97c7 with SMTP id w18-20020aa79552000000b005a8b2c197c7mr17438762pfq.34.1678308134327;
        Wed, 08 Mar 2023 12:42:14 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79151000000b005cc52ea452csm9782377pfi.100.2023.03.08.12.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:42:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Roy Eldar <royeldar0@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH RESEND 2/2] status: improve info for detached HEAD after
 clone
References: <20230308192050.1291-1-royeldar0@gmail.com>
        <20230308192050.1291-3-royeldar0@gmail.com>
Date:   Wed, 08 Mar 2023 12:42:13 -0800
In-Reply-To: <20230308192050.1291-3-royeldar0@gmail.com> (Roy Eldar's message
        of "Wed, 8 Mar 2023 21:20:50 +0200")
Message-ID: <xmqqsfefrn4q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Roy Eldar <royeldar0@gmail.com> writes:

> diff --git a/wt-status.c b/wt-status.c
> index 3162241a57..f0a5fb578a 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1632,6 +1632,13 @@ static int grab_1st_switch(struct object_id *ooid UNUSED,
>  	struct grab_1st_switch_cbdata *cb = cb_data;
>  	const char *target = NULL, *end;
>  
> +	if (skip_prefix(message, "clone: from ", &message)) {
> +		oidcpy(&cb->noid, noid);
> +		strbuf_reset(&cb->buf);
> +		strbuf_add_unique_abbrev(&cb->buf, noid, DEFAULT_ABBREV);
> +		return 1;
> +	}
> +
>  	if (!skip_prefix(message, "checkout: moving from ", &message))
>  		return 0;
>  	target = strstr(message, " to ");

Two comments:

 - The original seems to duplicate the logic already in use for
   parsing @{-1} in object-name.c::grab_nth_branch_switch().

 - Adding new code here would mean that the result of parsing @{-1}
   and what wt_status_get_detached_from() will report becomes
   inconsistent, no?  After such a clone, "git checkout @{-1}" would
   say "there is no @{-1}" but "git status" would say it was
   detached from some hexadecimal object.

Thinking about the latter, I think it does not add much value to say
that we detached from something that is not a ref, so not adding
"clone: from " logic to grab_nth_branch_switch() is probably the
right thing to do anyway.

But then does it even make sense to have this new logic here?

Yes, the head may be detached at some object that is not a local or
remote branch.  But what is so bad about reporting the fact
faithfully, i.e., that we are not on any branch?  What commit object
we are at can be seen by "git show" or "git rev-parse HEAD" or any
other usual ways anyway, so...

I personally do not very much appreciate the extra info that is
given by saying "HEAD detached at X" and "HEAD detached from X",
compared to saying just "Not currently on any branch", especially
when these X are not concrete branch names or tag names but just
hexadecimal string that needs to be fed to "git describe" to be
turned into something that makes sense to humans, and that is
probably the reason why I am not a good judge about the change this
patch makes.  Others who like the "detached at/from X" may be better
judges to decide if this change makes sense.

Thanks.

