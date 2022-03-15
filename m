Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41662C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 18:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349537AbiCOS20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 14:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241661AbiCOS2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 14:28:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8575A0A1
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 11:27:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s8so271281pfk.12
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B6kYA9hJyk2446oGR7O0xg1Ab3H9bzexJRqW0THmg/M=;
        b=nOhnNXpJMClHMyT+EzM5Jow5JMYGqirmeSnyh6LqeS5VPYjvxbo3wF3CSjOeVnpDDU
         m4i1y1hzZCCR8QkD8xMBq8vOAKQR4TlJ/02F3B8u5FflujyOsttRK/QrSUg4p7hDOl06
         XvRviF2aUkTa7S9ttPIdoOuTDGPlPe2m2ayXOMZhDzJ6UnYEisUr5qlpZCVLbVMuvCjh
         2kItxUOO5Rsr7OByoG0PkuyJSuEuVZKzymIyii7bzH6D6giZIgW9rK+fN5qV2INNZB93
         C24oykdAXrJyrfSwSGQnF2Xo5m4Cxoo6F43rLu8fiKzuXrMdbCY9lc363yaIy2gTonsw
         3pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B6kYA9hJyk2446oGR7O0xg1Ab3H9bzexJRqW0THmg/M=;
        b=ag8xeucFvm+dCTGrTfuABUOSO6rpeKIpGmofGVo19mdMbq8wPlHPZlahMQHAmFikN+
         /9P5hCvsqP6bhL0LxeE+ALrss/rAtC+8oyWV8xoeX+MP4SkTonCCCihB6QzF/sktQnsy
         6nHKMY2vBTuTi+PvXu1wwDvONsNcSYVgdtg7QUHDm7Qek6Mad0eFI/S+JlJ3t4QEIICy
         4qOOGAaoRUWDn7G6r9TO5j40q8JD1icPY90reN6GwOpmy1FYGB8ubyK/Wxo+2QWMtX3g
         S4vz4bj4yYsbXDIz3GEWtHWQkAZfbOGsLesVPg+dUIa4yN2rS1XjCUNaQRVRpoXwNTFv
         ZylA==
X-Gm-Message-State: AOAM53335xWJJPcZpROlcf57fY3j3SiJIZaDiKKKuBLjNCM78fVO0IfF
        MyeIy3eQX5URwjgJJZAOSoOj7A==
X-Google-Smtp-Source: ABdhPJw4WByTy4ts9dC7P57GzISaGBvTyhg3WFzvCRbAlwShHVQDoKvBUrmNk8Mk6iL7K3qCsd039w==
X-Received: by 2002:a63:20f:0:b0:378:9f08:a0a4 with SMTP id 15-20020a63020f000000b003789f08a0a4mr25534693pgc.17.1647368832552;
        Tue, 15 Mar 2022 11:27:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3c95:b7b0:13cc:7a5b])
        by smtp.gmail.com with ESMTPSA id ng12-20020a17090b1a8c00b001bfc847b555sm4000168pjb.46.2022.03.15.11.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 11:27:11 -0700 (PDT)
Date:   Tue, 15 Mar 2022 11:27:06 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 2/3] introduce submodule.hasSuperproject record
Message-ID: <YjDaeupPmWSp9u9w@google.com>
References: <20220310004423.2627181-1-emilyshaffer@google.com>
 <20220310004423.2627181-3-emilyshaffer@google.com>
 <kl6l7d91sccb.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kl6l7d91sccb.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 10, 2022 at 01:54:12PM -0800, Glen Choo wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
> > index ee454f8126..99d5260b8e 100644
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index c5d3fc3817..eda9ed550e 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -1839,6 +1839,11 @@ static int clone_submodule(struct module_clone_data *clone_data)
> >  		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
> >  				       error_strategy);
> >  
> > +	/*
> > +	 * Teach the submodule that it's a submodule.
> > +	 */
> > +	git_config_set_in_file(p, "submodule.hasSuperproject", "true");
> > +
> >  	free(sm_alternate);
> >  	free(error_strategy);
> 
> This git_config_set_* is superfluous - it sets the config in newly
> cloned submodules..
> 
> >  
> > @@ -2617,6 +2622,12 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
> >  
> >  	free(prefixed_path);
> >  
> > +	/*
> > +	 * This entry point is always called from a submodule, so this is a
> > +	 * good place to set a hint that this repo is a submodule.
> > +	 */
> > +	git_config_set("submodule.hasSuperproject", "true");
> > +
> >  	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
> >  		return do_run_update_procedure(&update_data);
> >  
> 
> but this is called over *all* submodules, so we're guaranteed to always
> set the config if "git submodule update" isn't interrupted halfway.
> 
> I don't think we guarantee correctness if it is interrupted halfway e.g.
> core.worktree can be unset if it is interrupted halfway (because
> ensure-core-worktree is called adjacent to run-update-procedure, not
> inside of update-clone).
> 
> So I think it's better to just drop the previous hunk - it will
> disappear anyway in gc/submodule-update-part2.

Ah, this makes sense. Sure, will do.

 - Emily

