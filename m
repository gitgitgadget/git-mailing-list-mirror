Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF15C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 11:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE6F2082E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 11:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4xS5CqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLQLdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:33:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35203 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfLQLdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 06:33:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so10924293wro.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 03:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6XcQbay6y0UBJmTFNMrsJekQgCprJ7j8eZyYTUQUS/A=;
        b=o4xS5CqKzlmMKt+oP19gpnPfZBC22mTG0Nebyz9LVd5aOwkJUwTJIWmk9i7dHrDGYc
         2mnKZUM5SDKVAVkwd/HcMxCEKCoekRsAIz9jXj6GokUS+bPWHDVf9/irXe/HJqGK39aG
         9rDtf4EGIF0apUCL0sjBGpP57t2Vu3AkwWiBz+5reJ6qyJOppPEL4SQBDZOXCzal434k
         YBnSumnFZl1pSLLltJGRzIszkctzUnGkQhmLw8uAvPYhzirwtZ1q0XukVk2Sj3MAyYuZ
         RX1SplWx/TsEkTSQpI6ZrlWsxgxvbKp/DWotPktjyQsgQEmOc1g0xsrLU9xjR7FdSEnt
         areQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6XcQbay6y0UBJmTFNMrsJekQgCprJ7j8eZyYTUQUS/A=;
        b=Kon7EsMf3hOXw+8b+TxPS6ihCUnsc4XHfX6qZ9wRxFxh95YEPV9GTffjQwm9hHJ5PS
         revgJERoXilcDvx9YtlbTeNR7VkLJAyZDM9SV6auBJ/SkkMi4GX6hUTfbPJsyrXlKWzk
         0vCavSgti6qQlUUmaM4gErC6Jjgmv06hgnyV+/OGiki/o3t6DIMnliDdDHUqdJ5KVWUP
         P0gMKWfAjsTJkge/Bub7/oHoShMVGvCy+pJPQyq6qpiipWNq7ZCgu9E3j6J81UEReSjL
         gNCqEhZd4X8GMF98uUU6TbjRF7ocpiOVApWGVjwpSUuEzspB4MSZPIuWZ3XHkeXdJ23M
         bJcQ==
X-Gm-Message-State: APjAAAVsdvzsj9WzkLpvz7vxRgV1tQ+P2NOMWvz//OhkvL7Erqpd+q11
        GYHi3oNFhoJ+mxwhjylr4Qs3bQk6
X-Google-Smtp-Source: APXvYqw3uG3nTRKLzQqy/HPLWbQJXHqWWQBJpnbVDqjLIt0vZN2lM6akdacT2CGsREJL5hwKmAvERg==
X-Received: by 2002:adf:dc86:: with SMTP id r6mr38678553wrj.68.1576582387049;
        Tue, 17 Dec 2019 03:33:07 -0800 (PST)
Received: from szeder.dev (x4dbe1cfe.dyn.telefonica.de. [77.190.28.254])
        by smtp.gmail.com with ESMTPSA id o16sm2771899wmc.18.2019.12.17.03.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 03:33:06 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:33:01 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "Thomas Rast <tr@thomasrast.ch>, Junio C Hamano" <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/2] Documentation/git-log: document accepted line-log
 diff formats
Message-ID: <20191217113301.GA8609@szeder.dev>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com>
 <0ed04a8629a64d15062e13c1f1739b01436a897b.1576559263.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ed04a8629a64d15062e13c1f1739b01436a897b.1576559263.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 17, 2019 at 05:07:42AM +0000, Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> Currently the line-log functionality (git log -L) only supports
> displaying patch output (`-p`, its default behavior) and suppressing it
> (`-s`). A check was added in the code to that effect in 5314efaea (line-log:
> detect unsupported formats, 2019-03-10) but the documentation was not
> updated.
> 
> Explicitly mention that `-L` implies `-p`, that patch output can be
> suppressed using `-s`, and that all other diff formats are not allowed.
> 
> Additionnally, mention that the ':<funcname>' form implies `--function-context`.
> 
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  Documentation/git-log.txt | 6 +++++-
>  Documentation/gitk.txt    | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index b406bc4c48..1c52bf184d 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -77,7 +77,11 @@ produced by `--stat`, etc.
>  	not give any pathspec limiters.  This is currently limited to
>  	a walk starting from a single revision, i.e., you may only
>  	give zero or one positive revision arguments.
> -	You can specify this option more than once.
> +	You can specify this option more than once. Implies `--patch`.
> +	If ``:<funcname>'' is given, implies `--function-context`.

':<funcname>' doesn't imply '--function-context', but defines a line
range starting at the function-name-looking line that first matches
"funcname" and ending just before the next function-name-looking line,
and line-log will then show that line range as context for each
commit.  Although in many cases it shows diffs that look like as if
'--function-context' were given, there are corner cases where they
clearly differ, e.g. when following the history of a function that was
at one point combined with the function directly below it.

Note the two commits in the middle that show two functions although
only one of them was actually modified in each of those commits:

  $ git log --oneline -L:func:file.c
  04b0c16 Combine funcA() and funcB() into func()
  
  diff --git a/file.c b/file.c
  --- a/file.c
  +++ b/file.c
  @@ -1,9 +1,4 @@
  -int funcA()
  +int func()
   {
  -	return A;
  -}
  -
  -int funcB()
  -{
  -	return B;
  +	return A + B;
   }
  ed0d4d9 Modify funcB()
  
  diff --git a/file.c b/file.c
  --- a/file.c
  +++ b/file.c
  @@ -1,9 +1,9 @@
   int funcA()
   {
   	return A;
   }
   
   int funcB()
   {
  -	return b;
  +	return B;
   }
  0d4e9b5 Modify funcA()
  
  diff --git a/file.c b/file.c
  --- a/file.c
  +++ b/file.c
  @@ -1,9 +1,9 @@
   int funcA()
   {
  -	return a;
  +	return A;
   }
   
   int funcB()
   {
   	return b;
   }
  c3f8a44 Add funcA() and funcB()
  
  diff --git a/file.c b/file.c
  --- /dev/null
  +++ b/file.c
  @@ -0,0 +1,9 @@
  +int funcA()
  +{
  +	return a;
  +}
  +
  +int funcB()
  +{
  +	return b;
  +}

Now compare that to the same two middle commits shown with '-p
--function-context', which doesn't show the unmodified function:

  $ git log --oneline -p --function-context file.c
  04b0c16 Combine funcA() and funcB() into func()
  diff --git a/file.c b/file.c
  index 89571b3..33301ea 100644
  --- a/file.c
  +++ b/file.c
  @@ -1,9 +1,4 @@
  -int funcA()
  +int func()
   {
  -	return A;
  -}
  -
  -int funcB()
  -{
  -	return B;
  +	return A + B;
   }
  ed0d4d9 Modify funcB()
  diff --git a/file.c b/file.c
  index 13592c8..89571b3 100644
  --- a/file.c
  +++ b/file.c
  @@ -5,5 +5,5 @@ int funcA()
   
   int funcB()
   {
  -	return b;
  +	return B;
   }
  0d4e9b5 Modify funcA()
  diff --git a/file.c b/file.c
  index 11e1e87..13592c8 100644
  --- a/file.c
  +++ b/file.c
  @@ -1,6 +1,6 @@
   int funcA()
   {
  -	return a;
  +	return A;
   }
   
   int funcB()
  c3f8a44 Add funcA() and funcB()
  diff --git a/file.c b/file.c
  new file mode 100644
  index 0000000..11e1e87
  --- /dev/null
  +++ b/file.c
  @@ -0,0 +1,9 @@
  +int funcA()
  +{
  +	return a;
  +}
  +
  +int funcB()
  +{
  +	return b;
  +}

