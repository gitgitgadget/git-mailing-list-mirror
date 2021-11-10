Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F013C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326B8611F2
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhKJXO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhKJXOY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 18:14:24 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D407C061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 15:11:36 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m14so17084511edd.0
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 15:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g1p8FQynOPxKcY4PcDEqGjUF9pA+BwKCjY7tpUQg1Ts=;
        b=EFLduOLxkynQIv1oEhYunVpQxL6l2yYJnxhhq9b6/adH/5QnJXCFD/XHUk/t0rwDyB
         2w4LBgFNIj7snTs2epz8M10eqQ1ZcMgwD8/A/9yJKWCN/ZucK91qKaccfcnId4SYgsgt
         Ozth6Z4bEwNqSAh+/s+sD+UTJfdY87WW4Eb8VBk2N2y0s9iN75ysx0UPjlCg4fucu0ML
         gS1k/VKTqC9REUf6qKgd4kOJyqgOOpwmUTfRRGPN+ZRiz1l81tWqamOkVOayyWcRBxR+
         Soip//FG3SABzkK+T6fK0svv5ECd43ni+zEYIKSN12Y35Ly0x9gvccTN7lDDmtylUwVQ
         eFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g1p8FQynOPxKcY4PcDEqGjUF9pA+BwKCjY7tpUQg1Ts=;
        b=sNt1xMU6NodzjAj9yafY4j6YAXUeKwusLWML/BCyBzRB0a0JVFfLmD7KTrUKHPua5j
         aSVSN3ApMYb/PNMBIsj0sVBzLVueQcNr+6rNMoBQ+SNkmXsmRTD4B85PulcP6YjHtJsT
         NLnKD5cBM9c9eF2ATv9AI1o3/IKiAnGGwieqzn7iE41Piec0Q6yqi7KU0es77UMezZcp
         T+extzj3f47YQYynyuY8S05Z6QPm6r4cROPC2uC+//uo057lQgKcxqPumo/ZoM1VCj6V
         l7BZvaU5s4ZOIcBKplXNUbDVgR2kAu58+GcB0FwkdYZSnGe8P+/8xFL1vlOAQtbR+Qc9
         cHig==
X-Gm-Message-State: AOAM531jIQfgPHaDVwUL8sLsYIhmeUyI8D+QcYfffZQcPUwaOg9F0Jp5
        ic8Jd4oukETOOoKTnHPcry8ey99MQIs=
X-Google-Smtp-Source: ABdhPJwgucLSC8zgFgLlCClUaY0TdjCJda7EXSj9zlc98nOhIT58oGpmMR6pioEUdB2OzeSO1eA4bw==
X-Received: by 2002:a17:907:7094:: with SMTP id yj20mr3560625ejb.265.1636585895124;
        Wed, 10 Nov 2021 15:11:35 -0800 (PST)
Received: from szeder.dev (94-21-146-29.pool.digikabel.hu. [94.21.146.29])
        by smtp.gmail.com with ESMTPSA id i13sm632225edc.62.2021.11.10.15.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 15:11:34 -0800 (PST)
Date:   Thu, 11 Nov 2021 00:11:32 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH 4/4] midx: report checksum mismatches during 'verify'
Message-ID: <20211110231132.GB5811@szeder.dev>
References: <cover.1624473543.git.me@ttaylorr.com>
 <94e9de44e3b52513c5ab48aecd74f809dc34cbe3.1624473543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94e9de44e3b52513c5ab48aecd74f809dc34cbe3.1624473543.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 02:39:15PM -0400, Taylor Blau wrote:
> 'git multi-pack-index verify' inspects the data in an existing MIDX for
> correctness by checking that the recorded object offsets are correct,
> and so on.
> 
> But it does not check that the file's trailing checksum matches the data
> that it records. So, if an on-disk corruption happened to occur in the
> final few bytes (and all other data was recorded correctly), we would:
> 
>   - get a clean result from 'git multi-pack-index verify', but
>   - be unable to reuse the existing MIDX when writing a new one (since
>     we now check for checksum mismatches before reusing a MIDX)
> 
> Teach the 'verify' sub-command to recognize corruption in the checksum
> by calling midx_checksum_valid().
> 
> Suggested-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  midx.c                      | 3 +++
>  t/t5319-multi-pack-index.sh | 5 +++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/midx.c b/midx.c
> index a12cbbf928..9a35b0255d 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1228,6 +1228,9 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
>  		return result;
>  	}
>  
> +	if (!midx_checksum_valid(m))
> +		midx_report(_("incorrect checksum"));
> +
>  	if (flags & MIDX_PROGRESS)
>  		progress = start_delayed_progress(_("Looking for referenced packfiles"),
>  					  m->num_packs);
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index d582f370c4..7609f1ea64 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -418,6 +418,11 @@ test_expect_success 'corrupt MIDX is not reused' '
>  	git multi-pack-index verify
>  '
>  
> +test_expect_success 'verify incorrect checksum' '
> +	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 1)) &&
> +	corrupt_midx_and_verify $pos "\377" $objdir "incorrect checksum"

This test is flaky and can fail with:

  ...
  + printf \377
  + dd of=.git/objects/pack/multi-pack-index bs=1 seek=3839 conv=notrunc
  1+0 records in
  1+0 records out
  1 byte copied, 5.0656e-05 s, 19.7 kB/s
  + test_must_fail git multi-pack-index verify --object-dir=.git/objects
  test_must_fail: command succeeded: git multi-pack-index verify --object-dir=.git/objects
  error: last command exited with $?=1
  + mv midx-backup .git/objects/pack/multi-pack-index
  not ok 44 - verify incorrect checksum

So the test corrupts the checksum trailer in the 'multi-pack-index'
file by overwriting its last byte with 0xff, but if that byte were
already 0xff, then the file would be left as is, and 'git
multi-pack-index verify' wouldn't find anything amiss.

Since SHA1 is essentially random, there's a 1:256 chance of that
happening, assuming that the file's content is random.  That't not
really the case, however, because both the test repository's objects
and the resulting packfiles are deterministic, and, consequently, the
content of the MIDX is somewhat deterministic.  Only "somewhat",
though, because several of those objects appear in multiple packfiles,
and the MIDX selects a copy in the most recently modified packfile, so
filesystem mtime resolution and second boundaries become significant,
and cause some variance in the contents of the OOFF chunk.

Recently a laptop crossed my way that is somehow exceptionally good at
generating MIDX files ending with 0xff:

  # ad-hoc checksum statistics:
  $ git diff
  diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
  index f1ee2ce56d..605713b518 100755
  --- a/t/t5319-multi-pack-index.sh
  +++ b/t/t5319-multi-pack-index.sh
  @@ -482,9 +482,13 @@ test_expect_success 'corrupt MIDX is not reused' '
   '
   
   test_expect_success 'verify incorrect checksum' '
  +	skip=$(($(wc -c <$objdir/pack/multi-pack-index) - 20)) &&
  +	printf "checksum: " >&5 &&
  +	od -x -w20 -j$skip --endian=big -An "$objdir/pack/multi-pack-index" >&5 &&
   	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 1)) &&
   	corrupt_midx_and_verify $pos "\377" $objdir "incorrect checksum"
   '
  +test_done
   
   test_expect_success 'repack progress off for redirected stderr' '
   	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir repack 2>err &&
  $ for i in {1..500} ; do ./t5319-multi-pack-index.sh |sed -n -e 's/^checksum:  //p' ; done |sort |uniq -c
       31 1a70 3b1c 8ed3 56a6 5101 2a38 057e 698d 6faf fbaa
      340 5fc0 552f 0ac0 c876 f229 d9e3 ef13 a314 5847 89ff
      129 ce7d 3710 fd21 ef7b 8316 2b99 4e6c e5d5 5e7c 7b08

That's almost 70% failure rate, though I haven't been able to trigger
this failure on any of the other machines that I have access to.

