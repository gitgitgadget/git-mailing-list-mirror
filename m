Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D22C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 22:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563D4613AE
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 22:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhFHW1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 18:27:54 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:55810 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhFHW1y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 18:27:54 -0400
Received: by mail-pj1-f45.google.com with SMTP id k7so193987pjf.5
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3nPse6O362up2NXxHMZFdrUpFzBKmaVEz10RS4KaEDc=;
        b=suyuKHKQOFg122NXs7CJ/fyUQ1OBYzhXqGPtsnS/ZQ0JxcHRHkEpo+xSFohPyWvls8
         EFK8paGAoGcvqC3F+zOYXvZw3BHlKC3efKoqsS0ugAc3H5K66fr4T7jwIKOj1lkFC8Si
         XF1qe/CsmKkK5ey3I5WVqjrHHxIetM7sSH/cwvzYCX1VFt3Ebm9/4qaxSV4g6w+59HQR
         kN16seU6nfleBvpns5aABeS4r26/AiGSxZuSyxHhcmHGQk6VC8GTcZg0OVVUv7ngi9I4
         icOTpDVpfhIX9h8sV5sA7unFGIHsJN3Kppn58N1An4+78lxEHU83t+wxUqm/AL/ArayF
         XB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3nPse6O362up2NXxHMZFdrUpFzBKmaVEz10RS4KaEDc=;
        b=mxKtlnOrOE9/JUH1f+HANE8cX5WPig+CZbq3OaoBL+msvr61IlkdnzWWx0a8qzKa+q
         80SOw1da/8mHQSifECgBs4oorH6XIW86phiXMSPUiLDwpXx2pblWV2ffkIg5Tzskh+VS
         JQieB/eP/zgp4si8dfmqrnNvsUm66GRiqJFDRo6T2sjuHuU8405wEpQD+MpNPbec4IlZ
         uZTRPc3aLWQyFGXdEq0Eut+sNLyCAYdlUwEiBFD1u31Ce2iCdI2d4mVJWxE9gFyWpkkS
         au35HnITbIerSrL5gBqXIKoOhejLJqkFGnVMUB+Tp9tJFKl0tYD6knF82ndwnCdG9AET
         PKNQ==
X-Gm-Message-State: AOAM5314agqLg0p88kHSF0xCI92yJs5q3m8r8Mz0qG9+zEZUBSHnkm+U
        SzLPpbYEAYQKPAMMyeP9NqV67A==
X-Google-Smtp-Source: ABdhPJwKGoRBv2DR9xrGKRDKYemI1bwLuJ4Q2OsWhT4A329/Gz6nabMgg9sXWQWcV9F3+kwCtqys6g==
X-Received: by 2002:a17:902:854a:b029:ef:3f99:91a7 with SMTP id d10-20020a170902854ab02900ef3f9991a7mr1964109plo.74.1623191100611;
        Tue, 08 Jun 2021 15:25:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:f819:e238:f61a:a961])
        by smtp.gmail.com with ESMTPSA id u24sm969345pfm.200.2021.06.08.15.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 15:24:59 -0700 (PDT)
Date:   Tue, 8 Jun 2021 15:24:53 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0?= Bjarmason' 
        <avarab@gmail.com>, 'Junio C Hamano' <gitster@pobox.com>,
        'Jeff Hostetler' <git@jeffhostetler.com>,
        'Bagas Sanjaya' <bagasdotme@gmail.com>
Subject: Re: [PATCH v5] tr2: log parent process name
Message-ID: <YL/uNYuADscBJUu2@google.com>
References: <20210608185855.668050-1-emilyshaffer@google.com>
 <20210608221059.1935021-1-emilyshaffer@google.com>
 <023201d75cb4$02006d10$06014730$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023201d75cb4$02006d10$06014730$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 08, 2021 at 06:16:57PM -0400, Randall S. Becker wrote:
> 
> On June 8, 2021 6:11 PM, Emily Shaffer wrote:
> >It can be useful to tell who invoked Git - was it invoked manually by a user via CLI or script? By an IDE?  In some cases - like 'repo' tool -
> >we can influence the source code and set the GIT_TRACE2_PARENT_SID environment variable from the caller process. In 'repo''s case,
> >that parent SID is manipulated to include the string "repo", which means we can positively identify when Git was invoked by 'repo' tool.
> >However, identifying parents that way requires both that we know which tools invoke Git and that we have the ability to modify the source
> >code of those tools. It cannot scale to keep up with the various IDEs and wrappers which use Git, most of which we don't know about.
> >Learning which tools and wrappers invoke Git, and how, would give us insight to decide where to improve Git's usability and performance.
> >
> >Unfortunately, there's no cross-platform reliable way to gather the name of the parent process. If procfs is present, we can use that;
> >otherwise we will need to discover the name another way. However, the process ID should be sufficient to look up the process name on
> >most platforms, so that code may be shareable.
> >
> >Git for Windows gathers similar information and logs it as a "data_json"
> >event. However, since "data_json" has a variable format, it is difficult to parse effectively in some languages; instead, let's pursue a
> >dedicated "cmd_ancestry" event to record information about the ancestry of the current process and a consistent, parseable way.
> >
> >Git for Windows also gathers information about more than one generation of parent. In Linux further ancestry info can be gathered with
> >procfs, but it's unwieldy to do so. In the interest of later moving Git for Windows ancestry logging to the 'cmd_ancestry' event, and in the
> >interest of later adding more ancestry to the Linux implementation - or of adding this functionality to other platforms which have an
> >easier time walking the process tree - let's make 'cmd_ancestry' accept an array of parentage.
> 
> We are probably going to have to discuss this one at more length. On
> NonStop, in some cases, I have access to the program arguments of the
> parent (rather like ps -ef) in POSIX-land, but not from the other
> personality. I do have access to the program object name, in both
> sides, although if someone replaces the object - which is not actually
> possible for a running program, but a rename is - the object may end
> up being somewhat meaningless or mangled. My suspicion is that I'm
> going to have to supply different things for the two personalities,
> but I'm not sure what as of yet.

I guess I'm having trouble understanding - it sounds like you're
describing one process with a graph of ancestry instead of a line. Does
that mean we shouldn't be tracing the ancestry the way we are?

 - Emily
