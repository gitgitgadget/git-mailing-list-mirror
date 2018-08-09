Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE3171F405
	for <e@80x24.org>; Thu,  9 Aug 2018 19:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeHIV1Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 17:27:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42226 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeHIV1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 17:27:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so6021481wrs.9
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 12:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YrLnzKwKWZQaSIZTS2WAz032tko2YR05eof7YIW5OGQ=;
        b=XJ8cOzn81ClXiaoapjs2sGz4R/FQQ5TM3mLTARMH15hjtaYbRZNlYtRTh2SnwzaTiy
         TOs1LLArDS80y/fPenVEsNccLj5XwA+X8xyp4tTLXY9XoXnNUi42AmarE8tgLIDiBy9h
         UKvIKNOBbi/T/jM1nbYyUMfcVlZ+XEBYS88S8Upon4XrmG0WwpLbJqnbvMAv2n+JbJAY
         2uP/CUT/4hr+5Qk3E0ScpX8XNkWRFNjVu/HkRVVdFdFTkWygd4iKUBlFxmr3nrXhA9F+
         RFaxMkEnmRsofNmJafiEatrghvASBrPftHQMGNOyLGjuVDmhfUyNBIpyilU/dxr0kKSw
         sMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YrLnzKwKWZQaSIZTS2WAz032tko2YR05eof7YIW5OGQ=;
        b=Qkmjz9YyiSvUhAgluraXEVoJDdMpctbgFdrcCqTZbz359H5vLFuHxTcEfLK5iXnuN7
         fu4CLATkXqtakviwQBLZbwGEpc5ow2ZQ25GOhWpmkcBnEOwquc4yZshID8xVXKp3ylTI
         ZoXhA5hMKj6mY3EHUIGWSw5n7fnXY9pUwh61etK+SSU/WEboVZaQ05z6WmqrS3wej+4J
         IVMo5QJv/17rAWlLw36mbxQTlTllclPMoSw/KMurHYglrizmX4Cj/HRaa58jP6eYEzf6
         d7AgIf2CEBN7arOirtWu2gWGgdvzEr2a5VZv5e4p6gQsq1NNDATmRuBKxkuwgb7eE0KY
         v+BA==
X-Gm-Message-State: AOUpUlGak9ym6AwfXKjKGmg60V/S7z1tz2HSBg+4RPYKqT4uh2T1Z9L8
        kvpLcQFO98Yyh8d56qgG9TQ=
X-Google-Smtp-Source: AA+uWPxhRstPTwp+XRqulN7UcRQv3v0TEO8JXoXSAfI1ZVEYR9GDCrqpKP/EoXD8EFvuSDLqXc3KMg==
X-Received: by 2002:adf:cd82:: with SMTP id q2-v6mr2316243wrj.118.1533841264276;
        Thu, 09 Aug 2018 12:01:04 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 9-v6sm14955635wrb.48.2018.08.09.12.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 12:01:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] Introduce a function to lock/unlock file descriptors when appending
References: <pull.17.git.gitgitgadget@gmail.com>
        <e449ed75fe3705692175017f98438815aeccf0fb.1533836122.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Aug 2018 12:01:03 -0700
In-Reply-To: <e449ed75fe3705692175017f98438815aeccf0fb.1533836122.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 09 Aug 2018
        10:35:25 -0700 (PDT)")
Message-ID: <xmqqtvo3bc0g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This function will be used to make write accesses in trace_write() a bit
> safer.
> ...
> To set a precedent for a better approach, let's introduce a proper
> abstraction: a function that says in its name precisely what Git
> wants it to do (as opposed to *how* it does it on Linux):
> lock_or_unlock_fd_for_appending().
>
> The next commit will provide a Windows-specific implementation of this
> function/functionality.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> squash! Introduce a function to lock/unlock file descriptors when appending

If we can keep the custom, narrow and easy-to-port API (like this
patch introduces) focused and resist feature creep over time, then
it would be worth spending effort to come up with such a custom
helper that is easy to port.  So I agree with the approach in
general but I tend to think "set a precedent for a better approach"
is a way-too-early and wishful verdict.  We do not know if we can
really keep that custom API easy-to-port-and-maintain yet.

In short, even though I agree with the approach, most of the
verbiage above is unnecessary and mere distraction.

> ---
>  git-compat-util.h |  2 ++
>  wrapper.c         | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 9a64998b2..13b83bade 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1202,6 +1202,8 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
>  #define getc_unlocked(fh) getc(fh)
>  #endif
>  
> +extern int lock_or_unlock_fd_for_appending(int fd, int lock_it);
> +
>  /*
>   * Our code often opens a path to an optional file, to work on its
>   * contents when we can successfully open it.  We can ignore a failure
> diff --git a/wrapper.c b/wrapper.c
> index e4fa9d84c..6c2116272 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -690,3 +690,17 @@ int xgethostname(char *buf, size_t len)
>  		buf[len - 1] = 0;
>  	return ret;
>  }
> +
> +#ifndef GIT_WINDOWS_NATIVE
> +int lock_or_unlock_fd_for_appending(int fd, int lock_it)
> +{
> +	struct flock flock;
> +
> +	flock.l_type = lock_it ? F_WRLCK : F_UNLCK;
> +	flock.l_whence = SEEK_SET;
> +	flock.l_start = 0;
> +	flock.l_len = 0xffffffff; /* arbitrary number of bytes */

If this can be an arbitrary range, do we need to cover this many (or
only this few, depending on your point of view) bytes?

Would it be sufficient to cover just the first one byte instead?  Or
perhaps give l_len==0 to cover all no matter how large the file
grows, which sounds like a better range specification.

> +	return fcntl(fd, F_SETLKW, &flock);
> +}
> +#endif
