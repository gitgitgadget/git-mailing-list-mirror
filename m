Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFBF1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 21:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeDOVfl (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 17:35:41 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:46064 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752708AbeDOVfk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 17:35:40 -0400
Received: by mail-wr0-f177.google.com with SMTP id u11so20750077wri.12
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 14:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2xuxrauX0Dv4GTEUi7YesVCvtoH8P0jxXJNQguFYl0Y=;
        b=VSL38WVM/zKrVgz3ctEnpEEHlWsTohyFNF+G9bQZX2osHxt0TPPrCXe40g3yhRvuip
         hyjC6WlGbMvqH261dZFHCLzqvNLMDTKfioN0KuMeW5NjGa/3JV0Tusy8EaDi+DatTv77
         54n/2j/1AM8DAr7NlgiGbst9veS1iGi2IA6j3KSW0D03mRXOpweTXL7oXFPttDJAkLi2
         t+poHlU94YosLgH+aUBZpx+/t1pYXs7n/RByvXvSfKDI1JvFA87vx2ttH9c7gcFEcvV1
         lI6VKpumU7Q1NsZPGEobwIao8aCXxJOpP6dVEOrVHeJAY+pR2R2T/06ItR2FkgYnGBsw
         caTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2xuxrauX0Dv4GTEUi7YesVCvtoH8P0jxXJNQguFYl0Y=;
        b=BX8jGde/SRjOQ1jUmZyD+1T1mSsLAl3bUIytvSH1kItJ5s4U4ds2drGZkKHbgg7bcD
         zxfP8hWtWyPB8efYl/SNH1l7XdMBc698QzU5w30e/WPXDER3l9pUfdfPTc4cWtwO5pZz
         5zX9QthSkWbWR7sF2XJEpZN8twGgpzLGKdPQ2vtrPVtHTGLOvVq/UP1NFIzIcjYjq2Me
         ghsX/g872OPLjXobMWBqOxIBUP67hLL1hmNnP6x9SHO/2rog3PZqBAItYV79RijIqTIS
         hxAtNls+00PzchiRJL0AOLCVMnPZbkzu0p48NpB5iAEdTIdyDulQSJ2r4hKE+Zv/aYcg
         1LaQ==
X-Gm-Message-State: ALQs6tD7s4tjtoYiChUQB1qIeNLAy2xA22I9tvC6TAAv2kQc75IdocrI
        xGQ1/bzKXeRBrDXy9fkVOZ8=
X-Google-Smtp-Source: AIpwx4+Dvv5OXoaVWs2djmzgnnihInJb3EQjFwFZP0BMaNJzpM8Ro43GibfHTkBQmjHVnR1kJ0CFlQ==
X-Received: by 10.28.11.14 with SMTP id 14mr8697314wml.34.1523828138673;
        Sun, 15 Apr 2018 14:35:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v35sm3962814wrc.18.2018.04.15.14.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 14:35:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug: rebase -i creates committer time inversions on 'reword'
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org>
Date:   Mon, 16 Apr 2018 06:35:37 +0900
In-Reply-To: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org> (Johannes Sixt's
        message of "Fri, 13 Apr 2018 18:52:28 +0200")
Message-ID: <xmqq7ep817bq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> I just noticed that all commits in a 70-commit branch have the same
> committer timestamp. This is very unusual on Windows, where rebase -i of
> such a long branch takes more than one second (but not more than 3 or
> so thanks to the builtin nature of the command!).
>
> And, in fact, if you mark some commits with 'reword' to delay the quick
> processing of the patches, then the reworded commits have later time
> stamps, but subsequent not reworded commits receive the earlier time
> stamp. This is clearly not intended.

Hmm, I may be missing something without enough caffeine but I am
puzzled how that would be possible.  With a "few picks, an edit, and
a yet more picks" sequence, the first picks may share the same
timestamp due to the git_default_date caching (which I think is a
deliberate design choice we made), an edit that stops will let the
concluding "commit" (either by the end user or invoked internally
via "rebase --continue"), but because that process restarts afresh,
the commits made by "yet more picks" cannot share the timestamp that
was cached for the earliest ones from the same series, no?

Ah, do you mean we have an internal sequence like this, when "rebase
--continue" wants to conclude an edit/reword?

 - we figure out the committer ident, which grabs a timestamp and
   cache it;

 - we spawn "commit" to conclude the stopped step, letting it record
   its beginning time (which is a bit older than the above) or its
   ending time (which is much older due to human typing speed);

 - subsequent "picks" are made in the same process, and share the
   timestamp we grabbed in the first step, which is older than the
   second one.

I guess we'd want a mechanism to tell ident.c layer "discard the
cached one, as we are no longer in the same automated sequence", and
use that whenever we spawn an editor (or otherwise go interactive).

>
> Perhaps something like this below is needed.
>
> diff --git a/ident.c b/ident.c
> index 327abe557f..2c6bff7b9d 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -178,8 +178,8 @@ const char *ident_default_email(void)
>  
>  static const char *ident_default_date(void)
>  {
> -	if (!git_default_date.len)
> -		datestamp(&git_default_date);
> +	strbuf_reset(&git_default_date);
> +	datestamp(&git_default_date);
>  	return git_default_date.buf;
>  }
>  
