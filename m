Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49711C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 19:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2955660FEA
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 19:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhFPTVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 15:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhFPTVl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 15:21:41 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E390BC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 12:19:33 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id b18-20020a0568301052b0290449ba7eff3cso1816961otp.7
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=p05YHCK+sm2rJ6sB6t8tygjAtvEWd+3AK9K8VF4mp6g=;
        b=Arg5dwChY85/Gve+qYysx/pKTMwrmSuI13/GaBz9ACjWrjUfwpESfFQUd2eIwS0qGC
         M2b3z1dbHFLXnUKcICxx92RK6jID47Jyji8oFe2zqNzP52hN7VgHSrBqAS0jHo9rXupw
         VBofrYmZiobzzMV7VoNBWvHwGH5G+gbCC1f+79Dky9IJM9BZuvqqky8RR3bXFdprf3pT
         ajAnVbW9SyKXbqb8p2ho8MBA48m4BA6GgmTNd5GJl5vDazf2PW/+qjQ/6nbJdZLMPUAB
         hobOYWdS2T/0tukx2oeHn2AtF0vP/At+Ymlrr5sYfLqKGNFjQk+meg2L2ffQyLCIYcTQ
         yPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=p05YHCK+sm2rJ6sB6t8tygjAtvEWd+3AK9K8VF4mp6g=;
        b=VEvJU2j1Q/IXRRyoyqhCGvrx86QW+J2cSAcd6pbGz50lOjMS2awKq1IqVDSa1OLpih
         pDYy2eNUvKGLpbZjRzofwoA+73pF++xo976yzuWQ70kK1ZEmLtwqR53cwL7s708r+VfU
         pgetQCJdggupbGT34v397AFxZQqzP2YGPtgrsC1XTEHtB5mS/FCuD5i1G0YE3Dp9BFIE
         HiCUwFhwtmpGre/QfaE3ZtdBPBZiykzBzLUhUfxMe1tMx3B5aOlDec9/2NUfge7mH49Q
         ubMko6pCgU6mO4GvdAwc6TZgDv7b9APa5SsaOTPgMU/lJYjDeNSlR+MbiuOkdsCvwb/v
         oJ/Q==
X-Gm-Message-State: AOAM5331lmd9RPfsiNbSnUQO5Pa3paNyy3NZbu1ay4OfTj728EcUFwPF
        gc//xDIuHTtYs9mFfbVVXes=
X-Google-Smtp-Source: ABdhPJzIGI/0dxMlQJ20gvAW51DcMWORmQMKKR7OZ4UKEmqThRlWNGh7nAII15gMWAm/Lh2MSS2B9g==
X-Received: by 2002:a05:6830:1548:: with SMTP id l8mr1149860otp.95.1623871173276;
        Wed, 16 Jun 2021 12:19:33 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id m66sm605235oia.28.2021.06.16.12.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:19:32 -0700 (PDT)
Date:   Wed, 16 Jun 2021 14:19:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Harrison McCullough <mccullough.harrison@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60ca4ec28b0f9_56f520855@natae.notmuch>
In-Reply-To: <YMo3j6mqiKBTTEbS@generichostname>
References: <CAHLeu+y3DxLv7M4SM2f5yVxtKXbpAWD7Ad2m+rVKpKfKiA6PVw@mail.gmail.com>
 <YMo3j6mqiKBTTEbS@generichostname>
Subject: Re: Error in bash completion
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu wrote:
> Hi Harrison,
> 
> On Wed, Jun 16, 2021 at 09:44:38AM -0600, Harrison McCullough wrote:
> > What did you do before the bug happened? (Steps to reproduce your issue)
> > 
> > 1. Create a Bash function, e.g. `ga() { git add "${@:-.}"; }`
> > 2. Use the `__git_complete` function to add Bash tab completion for your custom
> >    Bash function, e.g. `__git_complete ga git_add`
> > 3. Attempt to tab complete a file path, e.g. `ga my-incomplete-file-path<TAB>`
> > 
> > 
> > What did you expect to happen? (Expected behavior)
> > 
> > Bash tab-completes the file path.
> > 
> > 
> > What happened instead? (Actual behavior)
> > 
> > Bash tab-completes the file path but also displays an error:
> > 
> > $ ga fi-bash: [: -lt: unary operator expected
> > le3.txt
> 
> This happened as a result of my changes at e94fb44042
> (git-completion.bash: pass $__git_subcommand_idx from __git_main(),
> 2021-03-24) and 87e629756f (git-completion.bash: rename to
> $__git_cmd_idx, 2021-04-22).
> 
> The tl;dr is that $__git_cmd_idx must be set to the index of the
> git command you're executing (e.g. for `git add`, the index of `add`).
> As a workaround for you, try setting __git_cmd_idx=0 where you define
> ga().
> 
> Now, a question to the wider list: does git-completion.bash have a
> public interface? I've been working off the assumption that any time a
> user uses the internals, it's at their own risk. Is this a valid
> assumption to make?

Traditionally that was a valid assumption, although in reality people
have been using __git_complete for many years.

Since 5a067ba9d0 (completion: add proper public __git_complete,
2020-12-30) __git_complete became officially public, and the internal
one is ___git_complete.

Perhaps we could set __git_cmd_idx in __git_complete, but we would also
need to consider the zsh equivalent of __git_complete, which is compdef.

-- 
Felipe Contreras
