Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918D9C433E1
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 14:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DF120768
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 14:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/D+opW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFZOms (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFZOmr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 10:42:47 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A7BC03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 07:42:47 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h23so7654585qtr.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eMpZyMkOVkpVMYmgZdqjxnfRmiGLWzwqX74w8hC+Lek=;
        b=r/D+opW2mbVP9Bmt2XXe5W1kg58Y6lI8TGPVDcUtPWIsmYX+gP5bHcZJFw+dhRZDiy
         /utguWOFelvWcXGf2NKnBYbxNjYZjlpcfPBkf/X8NqXh2qMycqQgBHV5KZ7iyEY3iR+H
         Pgbd4+5Hj2ygtISPfnh5llZ0r5/cUGVr4PRlty20/zQarMObKyPNvKQg3chngePoORyN
         zBWzKeQM51UYLrznR96JgFBthl+yVoP5CIkYWZB0HCwUJrdfafqYr5NhLdz//tz2q84V
         8AavB8E7NwsahM09Exd2N8yOLb2cVJID1ft1pcete6P/Du4nc7S3P2uwwchwN2JcEmNt
         dC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eMpZyMkOVkpVMYmgZdqjxnfRmiGLWzwqX74w8hC+Lek=;
        b=gD8IjUEuUtF0QVsO3Wm5Dse5W6diwzL4pcucVpceNQ/KnPC8LyFL5Uc4Ik6fIIBGmK
         E4ain1JOwyBt2tI4XZ33nQwykbQ8z9KPZlDp6Ji0lHGtelVS6Osu5msA0b3FpKXzxNtF
         6sF4qIbHKPCwCvK33pankzMXlLfBwlku93rNpAp699++h6kj0Cl0bBsGyK/SYsw1iKog
         9KGvhx9W91EoXEiDriGqC3OwjJDCWlsBTNFzzFTDuPZlqF+72wgK69f7yhsn7TYA6zQh
         KN/T51WFw5Bry+O4vswpAVQ8TFbmBrZ3/fXHwLT5TthRKMUIb8fz+N9ob6yfhoFqJHE+
         XW3Q==
X-Gm-Message-State: AOAM532W28OFCRWIzOpDA/LErWoTQtqCCT38BuBEi8taoMwGDITz+1Ap
        ywLOiE1MpF7vexz7BefmnWw=
X-Google-Smtp-Source: ABdhPJygxB+80ArkcH3fPKFODna+43pyM/piGIBkiR6gSfOd2qT66BzPcP7yq2x1B3h3SQxtnuYkTg==
X-Received: by 2002:ac8:6d17:: with SMTP id o23mr3204380qtt.127.1593182567044;
        Fri, 26 Jun 2020 07:42:47 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r7sm8308410qtm.66.2020.06.26.07.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 07:42:46 -0700 (PDT)
Subject: Re: [PATCH v2 10/11] commit-graph: check all leading directories in
 changed path Bloom filters
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
 <9c2076b4ce46918fce8f05e609b057611ec56e13.1592934430.git.gitgitgadget@gmail.com>
 <8d8b1763-bbf3-682e-0649-f5a0885399e6@web.de>
 <0fe96c75-2946-8160-2ced-3d9781dca8c0@gmail.com>
 <20200626063436.GA11341@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <452d363a-d3c1-e80f-2354-13d2070afbee@gmail.com>
Date:   Fri, 26 Jun 2020 10:42:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200626063436.GA11341@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/26/2020 2:34 AM, SZEDER Gábor wrote:
> On Thu, Jun 25, 2020 at 11:05:04AM -0400, Derrick Stolee wrote:
> 
>>>> +	while (p > path) {
>>>> +		if (is_dir_sep(*p))
>>>> +			fill_bloom_key(path, p - path,
>>>> +				       &revs->bloom_keys[path_component_nr++],
>>>> +				       revs->bloom_filter_settings);
>>>> +		p--;
>>>> +	}
>>>
>>> This walks the directory hierarchy upwards and adds bloom filters for
>>> shorter and shorter paths, ("deepest first").  Good.
>>>
>>> And it supports all directory separators.  On Windows that would be
>>> slash (/) and backslash (\).  I assume paths are normalized to use
>>> only slashes when bloom filters are written, correct?  Then the lookup
>>> side needs to normalize a given path to only use slashes as well,
>>> otherwise paths with backslashes cannot be found.  This part seems to
>>> be missing.
>>
>> Yes, that's a good point. We _require_ the paths to be normalized
>> here to be Unix-style paths or else the Bloom filter keys are
>> incorrect. Thankfully, they are.
> 
> Unfortunately, they aren't always...
> 
> Path normalization is done in normalize_path_copy_len(), whose
> description says, among other things:
> 
>    * Performs the following normalizations on src, storing the result in dst:
>    * - Ensures that components are separated by '/' (Windows only)
> 
> and the code indeed does:
> 
>         if (is_dir_sep(c)) {
>                 *dst++ = '/';
> 
> Now, while parsing pathspecs this function is called via:
> 
>   parse_pathspec()
>     init_pathspec_item()
>       prefix_path_gently()
>         normalize_path_copy_len()
> 
> Unfortunately, init_pathspec_item() has this chain of conditions:
> 
>         /* Create match string which will be used for pathspec matching */
>         if (pathspec_prefix >= 0) {
>                 match = xstrdup(copyfrom);
>                 prefixlen = pathspec_prefix;
>         } else if (magic & PATHSPEC_FROMTOP) {
>                 match = xstrdup(copyfrom);
>                 prefixlen = 0;
>         } else {
>                 match = prefix_path_gently(prefix, prefixlen,
>                                            &prefixlen, copyfrom);
>                 if (!match) {
>                         const char *hint_path = get_git_work_tree();
>                         if (!hint_path)
>                                 hint_path = get_git_dir();
>                         die(_("%s: '%s' is outside repository at '%s'"), elt,
>                             copyfrom, absolute_path(hint_path));
>                 }
>         }
> 
> which means that it doesn't always calls prefix_path_gently(), which,
> in turn, means that 'pathspec_item->match' might remain un-normalized
> in case of some unusual pathspecs.
> 
> The first condition is supposed to handle the case when one Git
> process passes pathspecs to another, and is supposed to be "internal
> use only"; see 233c3e6c59 (parse_pathspec: preserve prefix length via
> PATHSPEC_PREFIX_ORIGIN, 2013-07-14), I haven't even tried to grok what
> that might entail.
> 
> The second condition handles pathspecs explicitly relative to the root
> of the work tree, i.e. ':/path'.  Adding a printf() to show the
> original path and the resulting 'pathspec_item->match' does confirm
> that no normalization is performed:
> 
>   expecting success of 9999.1 'test': 
>           mkdir -p dir &&
>           >dir/file &&
>           git add ":/dir/file" &&
>           git add ":(top)dir/file" &&
>           test_might_fail git add ":/dir//file" &&
>           git add ":(top)dir//file"
>   
>   orig:  ':/dir/file'
>   match: 'dir/file'
>   orig:  ':(top)dir/file'
>   match: 'dir/file'
>   orig:  ':/dir//file'
>   match: 'dir//file'
>   fatal: oops in prep_exclude
>   orig:  ':(top)dir//file'
>   match: 'dir//file'
>   fatal: oops in prep_exclude
>   not ok 1 - test
> 
> This is, of course, bad for Bloom filters, because the repeated
> slashes are hashed as well and commits will be omitted from the output
> of pathspec-limited revision walks, but apparently it also affects
> other parts of Git.
> 
> And the else branch handles the rest, which, I believe, is by far the
> most common case.

Thanks for this analysis. Clearly, there is already a bug here
when the input data is not pristine. I didn't see this message
when I submitted my v3, but normalizing the path data before
computing filters can (hopefully) be done as a small patch
before or after my v3 PATCH 10 without much conflict.

Thanks,
-Stolee
