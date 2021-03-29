Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E88DC433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A8861924
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhC2X7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 19:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhC2X72 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 19:59:28 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92122C061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:59:28 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t140so3111747pgb.13
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ATegyQYESF9Bf5oJvn+VT/0pLPiCRCqqOMris9PtZD4=;
        b=ExJEMRcXXyDDgqfZ2FsJGioIyC3QCkNdZjCPmQUyjtjtsHzOuO3XIKM2KJyuI/erga
         T0HVX9ifzH8e10fSLID7YMKcYCpi0vOI/cNrWjyE3FNWvcCl6C2tXkXd/n/2lgh5tJeY
         3Bb1agNEBgQXGorMRpgrr017TsLu8+lr1G3/ZqE2fVXl6ZUZe1aLwTQFZp/qt3PqUwVj
         tjS0xv0Qo7tXPmZSzqpIDPBOuxTapYRqhk90fsAGc+oB7iUfKFLBUKg6sZb3XxmdsOgl
         2VR+hr6GXn0WqcnafznACzs93+skUoY042AgNFDvNfuULoPQA5oAF3vpY+fVBWvpnumb
         t6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ATegyQYESF9Bf5oJvn+VT/0pLPiCRCqqOMris9PtZD4=;
        b=WWgELVr7unsDRdglgiaH8wgaJ6P4RgawtKMroM3GCPtuXQ+5TI4TKSxLay48RB3dsr
         7lZyQLXB20IXi79WuMtzhu6bBx+YqhX9FsXZFH7I7WtfY8hnijDIFObuRNSOQsCWjLtX
         cvCg3V5EuRuw0pXsu66T7EORC1zU7E0xt9CV9aqtJEMDjtrPK0TbiR1gsyGhyrihSemy
         moWvkwbVjONUYoq0ECik0vEUXKGIC5AgQ3mlCgv8lsdSPKAZKY5o8zIzt0irac+9QsVM
         AlTh1Ge1Y+WWWwhFSpx0GU371w61KFQ5Tw/HCyiNKab+XpzoQl/FkOy+DiKxZTVOk8tF
         RcJg==
X-Gm-Message-State: AOAM531irrcVkisFm1LyYoPJaN2YTbtDFh61JzE/h0D1fmXyRTzW/5vN
        AkPS3Cfc+WeYRcZHlJMU8VWBdQ==
X-Google-Smtp-Source: ABdhPJwFg+iz6EUGYHAQ0ZmYVYqtTmTfQyR1BDguscMN4UtjogH68XXj72zOyZXkd6DrwsOQ3JOYTg==
X-Received: by 2002:a63:3241:: with SMTP id y62mr23631747pgy.127.1617062367889;
        Mon, 29 Mar 2021 16:59:27 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:282c:288a:2054:f194])
        by smtp.gmail.com with ESMTPSA id y22sm17935390pfn.32.2021.03.29.16.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 16:59:27 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:59:21 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 24/37] receive-pack: convert push-to-checkout hook to
 hook.h
Message-ID: <YGJp2VcFZ8nrtho8@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-25-emilyshaffer@google.com>
 <xmqqk0qc7jpy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk0qc7jpy.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 02:24:41AM -0800, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > @@ -1435,12 +1436,19 @@ static const char *push_to_checkout(unsigned char *hash,
> >  				    struct strvec *env,
> >  				    const char *work_tree)
> >  {
> > +	struct run_hooks_opt opt;
> > +	run_hooks_opt_init_sync(&opt);
> > +
> >  	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
> > -	if (run_hook_le(env->v, push_to_checkout_hook,
> > -			hash_to_hex(hash), NULL))
> > +	strvec_pushv(&opt.env, env->v);
> > +	strvec_push(&opt.args, hash_to_hex(hash));
> > +	if (run_hooks(push_to_checkout_hook, &opt)) {
> > +		run_hooks_opt_clear(&opt);
> >  		return "push-to-checkout hook declined";
> > -	else
> > +	} else {
> > +		run_hooks_opt_clear(&opt);
> >  		return NULL;
> > +	}
> >  }
> 
> OK, we opt_init(), futz with opt, call run_hooks() and opt_clear()
> regardless of the outcome from run_hooks().  Narrow-sighted me
> wonders if it makes the use of the API easier if run_hooks() did the
> opt_clear() before it returns, but I haven't yet seen enough use at
> this point to judge.

Hrm, is that idiomatic? I guess it would be convenient, and as long as
it doesn't touch explicitly caller-managed context pointer it should be
safe, but wouldn't it be surprising?

 - Emily
