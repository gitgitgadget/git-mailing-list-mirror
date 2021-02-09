Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD83CC433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FA064E56
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbhBIXIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 18:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbhBIWdn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:33:43 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C451EC06174A
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 14:31:36 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 8so84909plc.10
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 14:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L5J3eX7vXqKkBlfX0XmZVKzNkUbsQ3hj4ePrmauEHcQ=;
        b=kOTG+fx74WyNwSgwl0gxMYmdjAmlPHkl55Gdj5RDVGOhXJsK7Lw5xMB3whgyY2+Jys
         KJRQqws/+HqiaFT3x5MPxh7CGCAAoVGzoxXHyCYuXeXH6OgZygwGa8s/OF+68rsuhC5O
         Iz8bT2anrwD/sOWIYJ2VGeqgcKycO804mk5q2oPbNp6sga/NcwbBj7iHwZIyi1OAIim7
         HbE2LRPqberzA/pMmDIltNT4Kn11JEfQtikG6WI6vnFWFk4vZQvaJkCDfHHWIwrTO0tr
         AU6yafOASmF9PgRuurOGScPDxtLL+BVWVP8AWe6IsjStYZzNnoZ12xyABo98vIXC34tx
         svJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L5J3eX7vXqKkBlfX0XmZVKzNkUbsQ3hj4ePrmauEHcQ=;
        b=blOojfG/srKUNyeKQxWAwoZC/HZBQe+34w1m+Um6Kqo1nOilw/YMm7kFTdWYRI7Zyd
         Zp8XTZdtAwqiOrg+2CIM/l6IkpLUmcX3nDQU9bGiMsvZ2gqzr8OzMYsVuMVyI81Xo/vt
         dzG/J6VXFtCLZQkhSUCCZ9oF+5Y1Uk+bOcV6JNJEt01lBY7W8ncuzUaOVSVfBfK5eS9V
         szbo+hXfVxpD9r4/4EfPh+oywZHUpyzIIY+cCP7QqnxqT1pgeCn6QnNL6wVhQeTiRKZq
         kQtxFA044CicFy7OKwpYwxarGKeijKoeBsW6/1tC7wKhEAQmJHqq+J+l+HM1QXpwXYvu
         /i0g==
X-Gm-Message-State: AOAM532be2wIfLfo3Wcz6pSYCM7KraOZw8McTO+6pjwW7e66CbS+oSg8
        9yck3InMCfyjXXmQwFKIBzTnvA==
X-Google-Smtp-Source: ABdhPJztQZYjKwgNE3M1DypZjeVd7GW16qkqBiHU7dfnwjQHWcSRxn7+jBuTR/n0YRkDWGLinaw/RQ==
X-Received: by 2002:a17:902:bb95:b029:dc:e7b:fd6e with SMTP id m21-20020a170902bb95b02900dc0e7bfd6emr232359pls.12.1612909896090;
        Tue, 09 Feb 2021 14:31:36 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:7413:906e:c6f8:81a1])
        by smtp.gmail.com with ESMTPSA id d18sm68433pjz.40.2021.02.09.14.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 14:31:35 -0800 (PST)
Date:   Tue, 9 Feb 2021 14:31:29 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 05/17] hook: respect hook.runHookDir
Message-ID: <YCMNQe/ibc/xOL97@google.com>
References: <20201222000220.1491091-6-emilyshaffer@google.com>
 <20210131033503.1022138-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131033503.1022138-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 30, 2021 at 07:35:03PM -0800, Jonathan Tan wrote:
> 
> > Include hooks specified in the hook directory in the list of hooks to
> > run. These hooks do need to be treated differently from config-specified
> > ones - they do not need to run in a shell, and later on may be disabled
> > or warned about based on a config setting.
> > 
> > Because they are at least as local as the local config, we'll run them
> > last - to keep the hook execution order from global to local.
> 
> This commit message doesn't seem to match the code change. Firstly,
> we're teaching hook.runHookDir, not respecting it (since it did not
> exist before this commit), and it's about showing it in "list" and not
> about running it at all.

Yeah, thanks for noticing. Now that I'm rereading it, it looks like this
is the old commit message for "include hookdir hook in list". Yikes.
> 
> Perhaps just "hook: teach hook.runHookDir" as the subject and as the
> body:
> 
>   For now, this just affects the output of "git hook list". In the
>   future, this will affect the behavior of "git hook run" and when Git
>   runs hooks before or after its operations.
> 
> > +	switch (should_run_hookdir) {
> > +		case HOOKDIR_NO:
> > +			strbuf_addstr(&hookdir_annotation, _(" (will not run)"));
> > +			break;
> > +		case HOOKDIR_INTERACTIVE:
> > +			strbuf_addstr(&hookdir_annotation, _(" (will prompt)"));
> > +			break;
> > +		case HOOKDIR_WARN:
> > +		case HOOKDIR_UNKNOWN:
> 
> Hmm...UNKNOWN is the same as WARN? This doesn't agree with what is said
> in patch 1:
> 
>   +In case this list is expanded in the future, if a value for `hook.runHookDir` is
>   +given which Git does not recognize, Git should discard that config entry. For
>   +example, if "warn" was specified at system level and "junk" was specified at
>   +global level, Git would resolve the value to "warn"; if the only time the config
>   +was set was to "junk", Git would use the default value of "yes".
> 
> But having said that, I would prefer if Git just errored out in this
> case.

Eh, I think I'd still like it to be tolerant. Thanks for keeping me
honest :) I added a test to enforce the tolerant behavior, too.

> 
> The rest looks good.

Thanks.
