Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DABC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 23:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3796135A
	for <git@archiver.kernel.org>; Thu, 20 May 2021 23:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhETXZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 19:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhETXZP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 19:25:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF03DC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 16:23:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g18so11860611pfr.2
        for <git@vger.kernel.org>; Thu, 20 May 2021 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/gUqa5RZOhvrB+iSoXpMaOgSBWqlFJO30IZdE7WCYjM=;
        b=pIGufBOT9rF8n8AlmaGQ2OmJb80AxSdJNZ30fGmOXwkXiZ6PfrU/S1juqALjQZvj0i
         rhFvnHwhEB3K8Xn+ZYVBNR2CmPdPDcPSDM44keQO0GICfnY3NBJ0gM77dRQfYBVh3QZ0
         /1LDVsNT8kg5WCgUaCJ9UuDCjdtdC/EN+4O5lB78y+kaDlGiDNNKNcUQl4XwP4fY+Na8
         d9BixRn+tzjOMwK13eajYuwABA6l+6iPHP5OwPUuOlNnYyuU7TURqFbz2mPshcWgzS4P
         vnO1zOMmOZz8CvYTeeHjkfqBI3fJY6R5NdW6Q506yCW5B9IttDbSgMRq6LIPS/gWliuT
         uHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/gUqa5RZOhvrB+iSoXpMaOgSBWqlFJO30IZdE7WCYjM=;
        b=sCZfBpq9ZFmve1C3zn5qKjQu7ze6JWPjGvPufLDeuRSn1PVzhl7ADe0/7r0eOAL+Ie
         aySAtMsbpuuzRUbGQZR0qhdaBct2JI0LJi6A/+2MPRNb5I7dDJMdryNFMC2XUuL/7RZn
         7cHZzMADlFEgpl5NnXjEVZHRtWESWZAOsB5kxS0LOvWAxvsBZvxVftNkYv4g5EDA7mrJ
         Sb1yWlkHDrve+JGKEKMJYsQTKXKHwQOXiLmYsN5PT+fdnvRe6rHi+F9nPw6u1sRXL4et
         30GqIfvPHh6WHmF/5t7f3g8gAACQBvLaI8Q0LwvK400N2wQEVTfwa+KHGlZXIiiZR8+t
         81jg==
X-Gm-Message-State: AOAM530cTGWQmaqfg3a8A09ocZW/fLsN0KmWLEdJHQ6cyHwzkracvXW6
        5GWKBZEx8U3ttGK745PaFABAMihaFbg6oQ==
X-Google-Smtp-Source: ABdhPJym15bcyk99R5XvQFJMlNlTDcD/XyhQTP6Nw0lAsSt8bqRyoj1jU35QIEggrMelakOXuXQVXw==
X-Received: by 2002:a63:ed4d:: with SMTP id m13mr6791344pgk.433.1621553031208;
        Thu, 20 May 2021 16:23:51 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:8357:c9e5:a153:d09d])
        by smtp.gmail.com with ESMTPSA id d22sm2837546pgb.15.2021.05.20.16.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:23:50 -0700 (PDT)
Date:   Thu, 20 May 2021 16:23:45 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0?= Bjarmason' 
        <avarab@gmail.com>, 'Junio C Hamano' <gitster@pobox.com>,
        'Jeff Hostetler' <git@jeffhostetler.com>,
        'Bagas Sanjaya' <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] tr2: log parent process name
Message-ID: <YKbvgWpMngx76I5R@google.com>
References: <20210507002908.1495061-1-emilyshaffer@google.com>
 <20210520210546.4129620-1-emilyshaffer@google.com>
 <021601d74dc0$326f6620$974e3260$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <021601d74dc0$326f6620$974e3260$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 05:36:25PM -0400, Randall S. Becker wrote:
> 
> On May 20, 2021 5:06 PM, Emily Shaffer wrote:
> >To: git@vger.kernel.org
> >Cc: Emily Shaffer <emilyshaffer@google.com>; Ævar Arnfjörð Bjarmason <avarab@gmail.com>; Junio C Hamano <gitster@pobox.com>;
> >Jeff Hostetler <git@jeffhostetler.com>; Bagas Sanjaya <bagasdotme@gmail.com>
> >Subject: [PATCH v2] tr2: log parent process name
> >
> >It can be useful to tell who invoked Git - was it invoked manually by a user via CLI or script? By an IDE?  In some cases - like 'repo' tool -
> >we can influence the source code and set the GIT_TRACE2_PARENT_SID environment variable from the caller process. In 'repo''s case,
> >that parent SID is manipulated to include the string "repo", which means we can positively identify when Git was invoked by 'repo' tool.
> >However, identifying parents that way requires both that we know which tools invoke Git and that we have the ability to modify the source
> >code of those tools. It cannot scale to keep up with the various IDEs and wrappers which use Git, most of which we don't know about.
> >Learning which tools and wrappers invoke Git, and how, would give us insight to decide where to improve Git's usability and performance.
> >
> >Unfortunately, there's no cross-platform reliable way to gather the name of the parent process. If procfs is present, we can use that;
> >otherwise we will need to discover the name another way. However, the process ID should be sufficient regardless of platform.
> 
> I like this idea, but there are some platforms where this is unlikely to work. NonStop, in particular, can initiate git - and I frequently do - from a non-POSIX environment where process name is entirely different. In fact, it is something like $ABC (always beginning with a $, which makes life very difficult for shell scripts and screws up GIT_SSH_COMMAND, but I digress). I'm going to need to plug in something very platform-specific to make this work. getppid() always returns 1 in this situation, which is extraordinarily meaningless on the platform and does not represent the actual parent.

Ok. It sounds like you're saying I should be more conservative in the
commit message as well as in the #ifdef scope? Do you think this needs a
reroll to made the #ifdef more aggressive, or would you rather get to it
when you get to it?

It looks like the change in config.mak.uname won't affect NonStop; I
think also the compat/procinfo.c is probably indicative enough of "this
stuff is for procfs" that it won't look like it *should* work for
NonStop, which means that you should still get the stub for
'trace2_collect_process_info()'. But if you think the guards aren't
readable enough I can try to move them around a little more.

 - Emily
