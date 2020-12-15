Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E78DC2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4473622D05
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgLPABg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgLOXnF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 18:43:05 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F504C0613D3
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 15:42:24 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id lj6so472310pjb.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 15:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LYwhhA/i5DfyxdErMy8SqpiyOoA1CksqcceKtVR+utE=;
        b=tCSc4C+2fQiNv3gjkL71NgwOCfDmvDDckjC1MEEpgsoVrzmH9mMJ0dMsX+ZEikwsXG
         EaFMu919Gy/bofkMZexVdiV2baqdsaNix6/rGIlieC1oPB6UMy5qshzKVHZs2s+OAwJv
         2+dr2R6a63Gho35dGqwoosE6bOaTCbyuK8BqXWk4HsifJC4ukUogzF+Thuwkd7XEKjzO
         fB/SQSAZvIH+5ly73NeXtwPQYea6JQEMz9pnFoh6dim8drrFrhCBbDenSYqI21TMKjtq
         2nV7Sh4vTteyDYc6uXdy9zHawmfEO3nWwki0WxAq76j18OkOG1Xe8/d+ioh5XXKzzUuh
         uA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LYwhhA/i5DfyxdErMy8SqpiyOoA1CksqcceKtVR+utE=;
        b=QX1aAK/Z2iVhF7UI2MdpBRSJrWgQmbs/Ccqj43eS6m7u5agDGtGPRb88h7liVwCzD5
         jRqyyU5M1Gyr4HQ5obgknsPqRjzB4CBiGraAgUP8w3DyZCvsogXb3RBO9NkuJztUatgf
         8ARZRfA4waVBFW+yBzA4Izyg5SZ1mPPAPfnc6tuB0o/odMfj00r81YGs6FZes6VbrAui
         yxY8N8VDZealQGGyNkOeAn9RpP4PUSOqIVld3u1VRG9dns+a5lQBRopHFlR2cdecXzI0
         4sifiNONFKN4k7dHrWj7VSA3IQh+2O3YA+Ast8MNOcnMMDA75DrIeBmk6ji+MzDjEI12
         +a8A==
X-Gm-Message-State: AOAM532KJTyWrq7x2koDwHnAB7IP0XuL7MUGk31WsGBaI8wKSyTUr4Le
        S0f6b0o3Na6qfgzUmmYJ/aQ70VOlGpuoog==
X-Google-Smtp-Source: ABdhPJy9Vnb7pmubJLSwG3gQac5Khquzq0mJ/dYM6b/VlZm4dM89KVma81wcopBB1atPDv6bUPfK/Q==
X-Received: by 2002:a17:90a:7d08:: with SMTP id g8mr796660pjl.180.1608075743653;
        Tue, 15 Dec 2020 15:42:23 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id q23sm116120pfg.18.2020.12.15.15.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:42:23 -0800 (PST)
Date:   Tue, 15 Dec 2020 15:42:18 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 10/17] hook: convert 'post-rewrite' hook to config
Message-ID: <20201215234218.GE3783238@google.com>
References: <20201205014945.1502660-1-emilyshaffer@google.com>
 <20201205014945.1502660-11-emilyshaffer@google.com>
 <20201208230213.GM36751@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208230213.GM36751@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 08, 2020 at 03:02:13PM -0800, Josh Steadmon wrote:
> 
> On 2020.12.04 17:49, Emily Shaffer wrote:
> > diff --git a/sequencer.c b/sequencer.c
> > index 5a98fd2fbc..4befd862ff 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -35,6 +35,7 @@
> >  #include "rebase-interactive.h"
> >  #include "reset.h"
> >  #include "hook.h"
> > +#include "string-list.h"
> >  
> >  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
> >  
> > @@ -1143,33 +1144,23 @@ int update_head_with_reflog(const struct commit *old_head,
> >  static int run_rewrite_hook(const struct object_id *oldoid,
> >  			    const struct object_id *newoid)
> >  {
> > -	struct child_process proc = CHILD_PROCESS_INIT;
> > -	const char *argv[3];
> > +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
> > +	struct strbuf tmp = STRBUF_INIT;
> >  	int code;
> > -	struct strbuf sb = STRBUF_INIT;
> >  
> > -	argv[0] = find_hook("post-rewrite");
> > -	if (!argv[0])
> > -		return 0;
> > +	strvec_push(&opt.args, "amend");
> >  
> > -	argv[1] = "amend";
> > -	argv[2] = NULL;
> > -
> > -	proc.argv = argv;
> > -	proc.in = -1;
> > -	proc.stdout_to_stderr = 1;
> > -	proc.trace2_hook_name = "post-rewrite";
> > -
> > -	code = start_command(&proc);
> > -	if (code)
> > -		return code;
> > -	strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
> > -	sigchain_push(SIGPIPE, SIG_IGN);
> 
> Here and in a few other later patches, we're removing some signal
> handling that doesn't seem to be replicated in the run_hooks()
> implementation. Can you add a note to the commit message about why this
> is OK?

Yeah, I have added it to the commit message for next rollup. I think
offline you said you found it - but this signal handling was added when
I taught run_processes_parallel() to use a callback to provide stdin. It
lives in run-command.h now.

 - Emily
