Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D526C61DB3
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 04:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbjAIEfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 23:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbjAIEea (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 23:34:30 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2256FCF3
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 20:27:41 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 36so5060423pgp.10
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 20:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5C3AyPnSsK0P3NGfh0E0mA607vARuDPAiXzZTm8y/M=;
        b=EFnw3/WB3sOnIcHfAQHmDp7kn/VRJnhW2ccXzRv2u6r0iJAk9ElJ+iYx9RVwqd4gJZ
         qLThFGkHiQ2FH/7wno2ll9ho7gJ2NztcumoRlbE1hHLKuF4ViuhkyqCR6DXl8c961owP
         36T2HtCyQFjtko9K4wSfK2gLvq36Cflxrcw04Ha6JIO4zmtG1+ioe2siHwMeI0GxsayM
         nYK3r+3uUus99B5hOlfk9uVHFAxIbTPZ8GEGMKxglD8mZRjS1WI6hyzR6I1LkkBO/EuT
         7AbKqUrZRndjqWTJp8K58GImceSYbxL4A56Q6omMPYyWLAJ1eTpCXxZ9nbE4jWkltDQQ
         J7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5C3AyPnSsK0P3NGfh0E0mA607vARuDPAiXzZTm8y/M=;
        b=oGCsC247Z9k4QA8MyFTw621tXNgG6Sd6sAP3X9fovjZFgeWjhQ2bN0C+JZzENiDmLW
         pTq6vAfmM4bKjoSVgh38xOwjfnPIRmZeAFSP4KgPe4EshT1OgbSpsCxDaH6utA5kJxro
         j/VYE5po9VkuMElvIoSUxhIphE/5eleKC22wZCvvBWZWvseYPP09+JP8Zg7a7Veu3s4k
         8zIN8Qp0NessJEXv6FXtTPx8nDDEC3SYqB0uil7rSIRRL3Hfqw4yanX0aLSQ/oqOgLt1
         tooF1N3keaWZLpR+PclRg86IMnDCogYk4iyjQbpB54zKVUEznTkYChULDkx6QsF3CqjB
         ooWQ==
X-Gm-Message-State: AFqh2krNm1ft/BSQuz4DwtZgY4Dss/wHyh+pxGFMyskt7AAqBageA9e8
        aWq83mRqcguRZH7p98BJZWo=
X-Google-Smtp-Source: AMrXdXvlJYdTSP2swNFbZf+AWmr+YLzJN1t09qWSE5uvo0xfi70p7yNMKwCgVl7aCcF3fL3OQ7k/ww==
X-Received: by 2002:aa7:8c15:0:b0:583:1268:f994 with SMTP id c21-20020aa78c15000000b005831268f994mr15539160pfd.33.1673238461132;
        Sun, 08 Jan 2023 20:27:41 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b131-20020a621b89000000b005815217e665sm4953292pfb.65.2023.01.08.20.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 20:27:40 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] do full type check in BARF_UNLESS_COPYABLE
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
        <9bc1bd74-f72c-1b43-df7c-950815babb03@web.de>
        <4f161041-b299-f79a-e01b-cc00e2880850@web.de>
        <xmqqy1qdxz67.fsf@gitster.g>
        <3e04e283-cad0-7be4-d85c-65d0a52289e2@web.de>
Date:   Mon, 09 Jan 2023 13:27:40 +0900
In-Reply-To: <3e04e283-cad0-7be4-d85c-65d0a52289e2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 8 Jan 2023 11:10:59 +0100")
Message-ID: <xmqqfsckwcw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> We compare the types of the elements, so effectively we do this:
>
>    __builtin_types_compatible_p(__typeof__(const char *),  __typeof__(char *))
>
> ... which returns 0.

True.  I wonder if (const const char *) and (const char *) are
deemed compatible?  Even if so, probably we cannot write

	__builtin_types_compatible_p(const __typeof__(*(dst)),
				     const __typeof__(*(src)))

so that line of thoguht would lead nowhere X-<.

> We can remove the const like we already do for Visual Studio.  But
> then we have to add two casts when passing on argv2, like in
> mingw_execv(), because adding a const to a pointer of a pointer
> must be done explicitly in C (even though Visual Studio seems to
> do it implicitly without complaining).  Feels a bit silly. :-|

Indeed.  Let's see what folks, whom "git blame" tells us to be area
experts around here, think.  The "if _MSC, add const" was added in
12fb9bd8 (msvc: mark a variable as non-const, 2019-06-19) by JeffH,
and try_shell_exec() function itself came from f1a4dfb8 (Windows:
Wrap execve so that shell scripts can be invoked., 2007-12-04),
added by J6t.

> --- >8 ---
> Subject: [PATCH 1.5/4] mingw: make argv2 in try_shell_exec() non-const
>
> Prepare for a stricter type check in COPY_ARRAY by removing the const
> qualifier of argv2, like we already do to placate Visual Studio.  We
> have to add it back using explicit casts when actually using the
> variable, unfortunately, because GCC (rightly) refuses to add it
> implicitly.  Similar casts are already used in mingw_execv().
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  compat/mingw.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index d614f156df..e131eb9b07 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1839,16 +1839,13 @@ static int try_shell_exec(const char *cmd, char *const *argv)
>  	if (prog) {
>  		int exec_id;
>  		int argc = 0;
> -#ifndef _MSC_VER
> -		const
> -#endif
>  		char **argv2;
>  		while (argv[argc]) argc++;
>  		ALLOC_ARRAY(argv2, argc + 1);
>  		argv2[0] = (char *)cmd;	/* full path to the script file */
>  		COPY_ARRAY(&argv2[1], &argv[1], argc);
> -		exec_id = trace2_exec(prog, argv2);
> -		pid = mingw_spawnv(prog, argv2, 1);
> +		exec_id = trace2_exec(prog, (const char **)argv2);
> +		pid = mingw_spawnv(prog, (const char **)argv2, 1);
>  		if (pid >= 0) {
>  			int status;
>  			if (waitpid(pid, &status, 0) < 0)
> --
> 2.38.1.windows.1
