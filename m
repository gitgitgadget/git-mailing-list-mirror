Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1BDC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 08:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiGOIfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 04:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiGOIfp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 04:35:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66CC8148A
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 01:35:43 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z23so7745421eju.8
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 01:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/n4T5AhlVDoQYvKo5ARb2/HptxWHDZps4S5VzOf3wJU=;
        b=IZIRFv/hXntK3yNPdJfWfPvoKOaKXTauc/9Or75T1PstlyQz7caxIcDCaJoGM+xrC3
         /uftgkeOwevgVreobZJccGNIhyV469QmxjcZxgCly89zuOfQN9uiqoJl1Bsd298Xa94K
         1Aii6jy3Jdg+7tYvDQMbn8S4LR2kT3XDFOW2UGgmRk9UolXe2cA0A70kZlt1AOy7v12A
         smliC8NdMquBHZfYTIMAImwYPaEzF7mx17JqLjP8ieRASb1YaxmtO4RcwmuAsblHtTsq
         kAL32R14IU6pXxh/b5xxCvEToZKprrH56R/hxQ8fBvRyQDSRT5GIpRzscboxQCcExftZ
         r2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/n4T5AhlVDoQYvKo5ARb2/HptxWHDZps4S5VzOf3wJU=;
        b=ATXFDkisf/ntKs22cBf1Cq4wP4gB5968mTwZhctkZvDOZ+BILn2jHhU7xtAW0iOveH
         Mec4t3DhmW2j32Q7sXfBpu4q5pOE/0oHTEGyNPepxoAP/EdPpzO3Od75k1cDt+pCGn79
         ffbwhB8mVJZCJkCp+7qhDZ5Ez4Fuy+CzHe+O1Urdua23li3n13XrZjGosOPhbvIC3GhV
         RwwtrSgA+FNV1r9RxZnJhoM3coTZZH1gG2hgzaMHFCeW86TP8gbvFvuFi9GBpvuDbgnM
         a/OkkMZ5PnUOkAY1VXHOOXsqkVjADUlWAgu4IS0js97uj/b9bnipUW0JfOop0KsHONNF
         VmEw==
X-Gm-Message-State: AJIora96cbcKeWaJ0pPBA0dnBENvLFZCzi1BSKjepSKdvMBIE+2HI5KD
        xVHlv+tfE6i8Ap4rC4+5LuU=
X-Google-Smtp-Source: AGRyM1uoGfn/62OPHIcUVDtc1f7KfliYT1yn1Si7AiOmjBmIi1rQPqtZ16+CxLV/vMgpfdlBWBp1Qg==
X-Received: by 2002:a17:907:1690:b0:72b:4f11:66c4 with SMTP id hc16-20020a170907169000b0072b4f1166c4mr12198510ejc.562.1657874142410;
        Fri, 15 Jul 2022 01:35:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ek9-20020a056402370900b0042de3d661d2sm2373172edb.1.2022.07.15.01.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 01:35:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oCGnV-002bXH-1b;
        Fri, 15 Jul 2022 10:35:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pierre Garnier <pgarnier@mega.com>
Subject: Re: [PATCH] refs: work around network caching on Windows
Date:   Fri, 15 Jul 2022 10:30:04 +0200
References: <pull.1291.git.1657872416216.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1291.git.1657872416216.gitgitgadget@gmail.com>
Message-ID: <220715.86a69a22oy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 15 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Pierre Garnier <pgarnier@mega.com>
>
> Network shares sometimes use aggressive caching, in which case a
> just-created directory might not be immediately visible to Git.
>
> One symptom of this scenario is the following error:
>
> 	$ git tag -a -m "automatic tag creation"  test_dir/test_tag
> 	fatal: cannot lock ref 'refs/tags/test_dir/test_tag': unable to resolve reference 'refs/tags/test_dir/test_tag': Not a directory
>
> Note: This does not necessarily happen in all Windows setups. One setup
> where it _did_ happen is a Windows Server 2019 VM, and as hinted in
>
> 	http://woshub.com/slow-network-shared-folder-refresh-windows-server/
>
> the following commands worked around it:
>
> 	Set-SmbClientConfiguration -DirectoryCacheLifetime 0
> 	Set-SmbClientConfiguration -FileInfoCacheLifetime 0
> 	Set-SmbClientConfiguration -FileNotFoundCacheLifetime 0
>
> This would impact performance negatively, though, as it essentially
> turns off all caching, therefore we do not want to require users to do
> that just to be able to use Git on Windows.
>
> The underlying culprit is that `GetFileAttributesExW()` that is called from
> `mingw_lstat()` can raise an error `ERROR_PATH_NOT_FOUND`, which is
> translated to `ENOTDIR`, as opposed to `ENOENT` as expected on Linux.
>
> Therefore, when trying to read a ref, let's allow `ENOTDIR` in addition
> to `ENOENT` to indicate that said ref is missing.
>
> This fixes https://github.com/git-for-windows/git/issues/3727

This really has much wider implications, as we hard depend on POSIX
semantics in various other places. E.g. we'll the SHA-1 collision
detection sanity check (not sha1dc, the "does it exist?") would be racy
on such a system, wouldn't it?

>  refs/files-backend.c  | 2 +-
>  refs/packed-backend.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 8db7882aacb..b2a880f62f0 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -381,7 +381,7 @@ stat_ref:
>  	if (lstat(path, &st) < 0) {
>  		int ignore_errno;
>  		myerr = errno;
> -		if (myerr != ENOENT || skip_packed_refs)
> +		if ((myerr != ENOENT && myerr != ENOTDIR) || skip_packed_refs)
>  			goto out;
>  		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
>  				      referent, type, &ignore_errno)) {
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 97b68377673..23d478627a7 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -480,7 +480,7 @@ static int load_contents(struct snapshot *snapshot)
>  
>  	fd = open(snapshot->refs->path, O_RDONLY);
>  	if (fd < 0) {
> -		if (errno == ENOENT) {
> +		if (errno == ENOENT || errno == ENOTDIR) {
>  			/*
>  			 * This is OK; it just means that no
>  			 * "packed-refs" file has been written yet,
>
> base-commit: bbea4dcf42b28eb7ce64a6306cdde875ae5d09ca

So I'm skeptical that this can work at all, but in any case wrapping
this non-POSIX hack in an #ifdef for the relevant platform is somtething
I really think we should have here, or "#ifdef NON_POSIX_FS_HACK" or
something.

You don't want to be carefully reviewing this code thinking wtf, only to
discover later that it's impossible on a well-behaved FS.

Also, NFS has similar options (which I've seen hard break git repos &
corrupt them in the past)< how do its various dangerous caching options
behave in these scenarios?

IOW if we're supporting non-POSIX behavior on platform A, are we
inadvertently making the non-POSIX behavior on platform B even worse?
Even more of a reason to wrap it in ifdefs...

But I really think the answer to this is similar to brian's FAQ patches
for git repos on "cloud mounts", I.e. document carefully that it's
likely to corrupt your repo in unexpected ways.

So I'd be much more comfortable with a workaround that stole what we do
for the *.lock spinning here, i.e. we'd detect this errno, say "wtf,
non-POSIX?" then spin for N ms, and hope to get "past the race".

That would be guaranteed not to suffer from odd corruption issues (as
the behavior wouldn't change, we'd just wait and hope to "catch up")>

Wouldn't that be narrower & better here?
