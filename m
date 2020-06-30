Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280A5C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 23:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76DE20722
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 23:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdxbmiWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgF3Xjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgF3Xjn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 19:39:43 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B837C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 16:39:43 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id q22so10564192qtl.2
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yz29EhnEHVwibfpMJ3UE8kSvq2KVTKCzks7zMxNaaqQ=;
        b=GdxbmiWdHu5uJhzQ0diyqAa4LfT3qPFFpBRjuWuIeff1wxJL1mFwM6KJMIxTavHdZm
         xK5wXW/MGEEguvGbzIJ4zWtMj53DDXNdI+6HdD8U8IM+d5ZhOyN5ZOtZx6UVkt6YXnDS
         /pCsh9uhWai9BluCDIJGspsNF4a3/YBYxERM8JTsBcUlYzk8X/euVrpgfkIM5LD1x8IL
         W48qi4Vg1rh+wOJeiKN+Tz70Lq4qTukenjs/GmWo1fvlqUZ/v3lMpbq9r1fJiKS8tQEm
         UVZcuIvckUiE0j8kSNWIonVNzG7sIIjpBXtVxN49O1lkkXojKNC7c1lsH8+ew5PRxYAM
         Dgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yz29EhnEHVwibfpMJ3UE8kSvq2KVTKCzks7zMxNaaqQ=;
        b=rG8XN/qw3cw+9tKN4nR8jq2tu8UViss2eYvMhi4BI2OMxJHP2RDrbWVm5a1srnUacL
         /ju3qlTZ6XSKvQFcam3X2pAyMEFsqu2PgSRl/82v3ihihBLkVPA2EGiRuhOHad9PMSHp
         8cVxmnHlimmuwu62qn7jm1n8lNFhnSChCSRfovm+KzgVALLPqFYmXPk0oOxyIgR+frLs
         wG0ld2BlQAT2HZYQzWe01ewdETQ3UL7qF+jpa3EnqcMmiTtU6wR0Arv49LAi3bhp6DLx
         xgz6fbCxEh2nJrEqpv+W6bOoc2OhzxslRJXIA1axDw8j1jbf7oyJfPMQ4iAZ/6SsumI8
         C/lw==
X-Gm-Message-State: AOAM53302/lMmb2smUoFjsuEr5hh7YjavWhJu++CAxG8CPtlMdLzHDPR
        x8eE82aiiE1suPMumOE9D/EzphPhfC8=
X-Google-Smtp-Source: ABdhPJzLDnhT8FtoN5RVM8Eac2/ODJxVKCGrtAA+vh4vrEHsO2MFlRkRgHmHrQ+dIyxHTFAeeAkztQ==
X-Received: by 2002:ac8:191b:: with SMTP id t27mr22544206qtj.16.1593560382405;
        Tue, 30 Jun 2020 16:39:42 -0700 (PDT)
Received: from generichostname (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id w77sm4408184qka.34.2020.06.30.16.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 16:39:41 -0700 (PDT)
Date:   Tue, 30 Jun 2020 19:39:39 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] test-lib-functions: restrict test_must_fail usage
Message-ID: <20200630233939.GA1301999@generichostname>
References: <cover.1593529394.git.liu.denton@gmail.com>
 <01e29450fe51a4ba13e07c611d8795ffd0282b9e.1593529394.git.liu.denton@gmail.com>
 <CAPig+cSNK1MDitZyh7Ax-eRAh6NjG_QsoF0feEo4475GjZ5ezw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSNK1MDitZyh7Ax-eRAh6NjG_QsoF0feEo4475GjZ5ezw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, Jun 30, 2020 at 04:56:22PM -0400, Eric Sunshine wrote:
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > +# Returns success if the arguments indicate that a command should be
> > +# accepted by test_must_fail(). If the command is run with env, the env
> > +# and its corresponding variable settings will be stripped before we
> > +# test the command being run.
> > +test_must_fail_acceptable () {
> > +       while test "$1" = "env"
> 
> I was surprised to see a 'while' loop for stripping 'env'. Did you
> actually run across cases in the test suite in which 'env' was
> invoking 'env'? If so, were such cases legitimate (as opposed to
> accidental)? Perhaps the commit message or an in-code comment could
> help readers understand why it needs to strip multiple 'env's.

There are no cases of nested envs. When I was writing this, I wanted to
be as permissive as possible in case someone wrote something like this.
Now that you bring it up, though, I don't think it makes sense to
support this use case because I can't come up with any legitimate reason
to have nested envs. (If something comes up in the future, we can
reinstate this behaviour.)

> > +       do
> > +               shift
> > +               while test $# -gt 0
> > +               do
> > +                       case "$1" in *?=*) ;; *) break ;; esac
> > +                       shift
> > +               done
> > +       done

> Would it make sense to error out if "$1" has no value? That is, if the
> author wrote:
> 
>     test_must_fail &&
> 
> or
> 
>     test_must_fail env foo=bar &&
> 
> then that surely is a programmer error, which could be diagnosed here
> (though the original 'test_must_fail' didn't bother diagnosing that
> problem so it may be overkill and outside the scope of this series to
> do so here).

This is caught by the 

	case "$1" in
	git|__git*|test-tool|test-svn-fe|test_terminal)
		return 0
		;;
	*)
		return 1
		;;
	esac

part. It only emits

	test_must_fail: only 'git' is allowed:

if this happens but it's probably fine as I don't think we should do
much hand-holding for this case.

And I'll use the remainder of your suggestions.

Thanks,

Denton
