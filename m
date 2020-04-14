Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42430C2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD712076A
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O34Mz4jY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633149AbgDNUb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633141AbgDNUbX (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 16:31:23 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AF0C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:31:22 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id v7so14955225qkc.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=R1EHp0fmaOIqP3nOpUn8DG+8vxZ5I/+4e5eadmVl05s=;
        b=O34Mz4jY3vu+mwcmEj1cg2wi6cG/61S/1rZsKslMf7VFS5CRTTjAL3QsstzcrcQgdR
         A+I+UEGeQYDUVcWfKkNuMkLdN8z6kgdqwVo4cUArJHgn0oRMdFTIinZlmmJTiUxFwZTu
         MWzl05gYUArUc6epTNPitEc2VHosF0Sm6Y8RGgLlykGYDWsiMz1rCWixniEsBh4Yb3gB
         GuUUoWnWZsTzG1EHoS/pvMt+f4rtlF3ELMYcHQlpPI27zIZONe0eLvnFHzC22MHR5W3p
         uJ55of+ZgrxMcElxnMZgr/mWcP/2f9mw+qWz8sXqVKMhMBZA/IE8Wwun/M6wpF3Iy0+8
         sQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R1EHp0fmaOIqP3nOpUn8DG+8vxZ5I/+4e5eadmVl05s=;
        b=Cx7XOMb5osF0ooFTl9Yd/2eth/9Fai0pDjFI48e3agDuQVxrKlgd8hgI8/pfypepT5
         DLDxBoux+VjE+rkMnQSJR6fMl4hOP6v/3p9NYRdo6Ge6bt9u/kpWz+i1TOJ1sh02CjYo
         Pvu8N54kriScBmLwokqXWGoUsO25ztEPaerTQPBGY61+42ZwQbdtGs1uYI63Sq0jRNap
         8vg+zF3XtFs+QzMldsgWBp04JaFC2t8pXF66IOuF1fn+Tpe6JpE6GoodmS61Kecbe3jy
         4pz+b/OpVQsp3vqXNGy27ZrGRwKch+EOyKwUAEN4EO98as+cRYG1RTXcnfnkoOsTT/Dh
         CD9w==
X-Gm-Message-State: AGi0PuaQ3YRdThrJFAQ+0pTsQzm7uOhTgR2KnN4kTQTbV6CmE3VBx4st
        YnzinrUcLQ2y6MX6jWesWhnkrgR5M/Y=
X-Google-Smtp-Source: APiQypJeYZRoQENpxgtp/0sGRD8g9rKYv8bNk5A3zqzIXfWSUTUk46bAyBtutfaskzRE0xsJ0cRfpw==
X-Received: by 2002:a37:7d81:: with SMTP id y123mr23452730qkc.102.1586896280970;
        Tue, 14 Apr 2020 13:31:20 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f1sm11205518qkl.72.2020.04.14.13.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 13:31:20 -0700 (PDT)
Subject: Re: Is fetch.writeCommitGraph (and thus features.experimental) meant
 to work in the presence of shallow clones?
To:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CABPp-BHGubUX5o9KsQaoh_UFjFh2PaMkkJhCao+5LGnFc0dQNg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aca12331-f8e3-28a2-acb6-df9d7e2e70e1@gmail.com>
Date:   Tue, 14 Apr 2020 16:31:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHGubUX5o9KsQaoh_UFjFh2PaMkkJhCao+5LGnFc0dQNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2020 4:22 PM, Elijah Newren wrote:
> Hi,
> 
> I was building a version of git for internal use, and thought I'd try
> turning on features.experimental to get more testing of it.  The
> following test error in the testsuite scared me, though:
> 
> t5537.9 (fetch --update-shallow):
> 
> ...
> + git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/*
> remote: Enumerating objects: 18, done.
> remote: Counting objects: 100% (18/18), done.
> remote: Compressing objects: 100% (6/6), done.
> remote: Total 16 (delta 0), reused 6 (delta 0), pack-reused 0
> Unpacking objects: 100% (16/16), 1.16 KiB | 1.17 MiB/s, done.
> From ../shallow/
>  * [new branch]      master     -> shallow/master
>  * [new tag]         heavy-tag  -> heavy-tag
>  * [new tag]         light-tag  -> light-tag
> error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> fatal: unable to parse commit ac67d3021b4319951fb176469d7732e6914530c5
> 
> Passing -c fetch.writeCommitGraph=false to the fetch command in that
> test makes it pass.
> 
> There were also a couple other tests that failed with
> features.experimental=true (in t5500), but those weren't scary -- they
> were just checking exact want/have lines and features.experimental is
> intended to change those.  This test from t5537 was the only one that
> showed some unexpected fatal error.

Well, commit-graphs are not supposed to do anything if we have
shallow clones. We definitely don't load a commit-graph in that
case. Seems like we need an extra check in write_commit_graph()
to stop writing in the presence of shallow commits.

-Stolee
