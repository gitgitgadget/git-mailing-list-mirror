Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80B1C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 21:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8417920731
	for <git@archiver.kernel.org>; Thu,  7 May 2020 21:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pq78LhJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgEGVI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 17:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGVI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 17:08:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94528C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 14:08:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s10so2584128plr.1
        for <git@vger.kernel.org>; Thu, 07 May 2020 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kAtqwD+kjCSRFTxG/InuXKJSLpL3/SaDKq78fVgT0fg=;
        b=pq78LhJaBZyV3um7XhpRCQg+AfCAKLUOHUuAJ2efBsi1pbbVxWgA7sb25BdpU5ZDs1
         Oy/xJTB+XIIc5t7NxH7bKhSEg/HE21QsPbGCFOkumr83zM1CB7CFdxZyTQLZaxTVNXMM
         rY/nNk5lKdqNGr7J8jLJ4+Bs2xzRhX1VmmeOKDVYcC92b8P5Xhagvo9lCLvClfYpiHOJ
         6r+sTEAcFjsR+5WhiYmc2sG6UBM1VVJ63QRvHqn/ZrkyIdG20estJUDqHONuzlxYCZhZ
         k4LgbTdtXb/Ht5dOT4NfsnX2KHe38ZJvat5X++1ZZw3M1jaFIFfprvDx7xua+d/ubYk7
         mgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kAtqwD+kjCSRFTxG/InuXKJSLpL3/SaDKq78fVgT0fg=;
        b=KmD1ezwtRXNLbGM1d0zbQ7W8AFIEHhZWvkXKT6TK4BcMpwBIkP+vf6XFj2K1tuEF3o
         +93dmME7XAKOHTqhc/RJs9gCk4LIAN1jspqvHWOW0qNmGcgotvwapotzH4Ytjicflzn0
         lVWBa5/DmMpYDRXcHFgPRPTIdmKITpQTMH0TLIjnimhvEhXaFFoOMx7uRR6AVWRmjh8q
         eRQP3gLyis9klh3ZfTeFQLXeVCGaDRN/3cCBkYkdpAb9GFZ8H5YArILF0vQgL48EQcSn
         iTqR/rzOrugrzZv1wNwVu1a1g67tKlRdeVSeczooXQRL5jBvnUAgcIlWHh12nIXbBTh5
         vH8g==
X-Gm-Message-State: AGi0PuaTv7h1vRfQnUV/T/Q6bUNwjCq39oHsIKKfJwyBeuZRTNi3WEZB
        55eJwvfIYjjeYSvdzp0WhAbqvQ==
X-Google-Smtp-Source: APiQypLFCvy20TTTqBGguGP7oa7icLM3IkG9zWcTs5pV3yA99pW7Wc/5Qxud8eoW0aIw9af583/9QQ==
X-Received: by 2002:a17:902:7048:: with SMTP id h8mr15215209plt.300.1588885734739;
        Thu, 07 May 2020 14:08:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id l15sm591294pjk.56.2020.05.07.14.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:08:54 -0700 (PDT)
Date:   Thu, 7 May 2020 14:08:49 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] bugreport: collect list of populated hooks
Message-ID: <20200507210849.GH77802@google.com>
References: <20200427233820.179891-1-emilyshaffer@google.com>
 <20200430012425.209122-1-emilyshaffer@google.com>
 <20200430015049.GA115238@google.com>
 <xmqqv9lgswar.fsf@gitster.c.googlers.com>
 <xmqqwo5wpqvg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwo5wpqvg.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 03:09:55PM -0700, Junio C Hamano wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> When we do that, this "mkdir .git/hooks" will fail because the
> >> directory already exists.  Ideas:
> >>
> >>  A. Include a preparatory patch in this series that removes that "mv"
> >>     command.  That way, this test can do
> >
> > While I do not think it is realistic to anticipate that the "test"
> > repository may someday come with a hooks/ directory, even if we did
> > so, we would not enable any hook by default in there.  So "move away
> > and restore" feels way overkill.
> >
> >>   B. Run "git init" ourselves so we know what we're getting:
> >
> > That is certainly safer, and simpler.  But perhaps the simplest
> > would be
> >
> >     C. Use "mkdir -p .git/hooks" so we won't get affected.
> 
> In the meantime, I added this SQUASH on top.  I do not claim that
> this is the best solution, but the idea is to refuse to be affected
> by what is left in .git/hooks either by the test framework or
> earlier tests in the same test script file.

Thanks for the patience with the reply - like many of us, my attention
is being pulled many directions right now :)

This solution looks very neat to me, minus one comment. I can send a
squash with the change I mention below.

 - Emily

> 
>  t/t0091-bugreport.sh | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> index 612c12a918..9450cc02e3 100755
> --- a/t/t0091-bugreport.sh
> +++ b/t/t0091-bugreport.sh
> @@ -58,11 +58,14 @@ test_expect_success 'can create leading directories outside of a git dir' '
>  '
>  
>  test_expect_success 'indicates populated hooks' '
> -	test_when_finished rm git-bugreport-hooks.txt &&
> -	test_when_finished rm -fr .git/hooks &&

I'm not sure it's necessary to lose these two lines. Especially the
generated bugreport I'd like to clean up.

> +	rm -fr .git/hooks &&
>  	mkdir .git/hooks &&
> -	write_script .git/hooks/applypatch-msg &&
> -	write_script .git/hooks/prepare-commit-msg.sample &&
> +	for hook in applypatch-msg prepare-commit-msg.sample
> +	do
> +		write_script ".git/hooks/$hook" <<-\EOF || return 1
> +		echo "hook $hook exists"
> +		EOF
> +	done &&

I like this placeholder script a lot.

>  	git bugreport -s hooks &&
>  	grep applypatch-msg git-bugreport-hooks.txt &&
>  	! grep prepare-commit-msg git-bugreport-hooks.txt
> -- 
> 2.26.2-447-gd61d20c9b4
> 
