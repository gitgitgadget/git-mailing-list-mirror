Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483ECC83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 15:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D7821707
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 15:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EC5DZOgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgD2P5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgD2P5F (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 11:57:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F36C03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 08:57:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p25so1250267pfn.11
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9xXHbUX6efzhGZjPGeoMrRRzHXbd7Y3bYzuxm+Zg9P8=;
        b=EC5DZOgm7YK/frjigjlaFRbuT0hmmIU9+ZthJMPM5+frRjfPLQs6FWlNdaanFeRpgS
         FNfqb8DK4bPHWv2xTAF+tcTH+MvpbBdvTRqqnZSF9XMK59td/5KRDLh2jKm6SIqwHp0P
         /EOL+dIO1fr/ls5cckhca+aX/dZh+PmDKUNjB5jyiaAP+AEeVBUa5e4Mx4WJnVlSd3eh
         0UvSNzFlKxljmh17ZYc6aKB42B2U0LiRszrx6CKSRsUsDeiTAbksO8RsO6XR/RaZUPSO
         c+LQopOxquJPXwdBlDa1JqFO+eYCrRaMie4vL3ZJ+vRcFb48NUxQc+R3y780sDZICxhy
         zrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9xXHbUX6efzhGZjPGeoMrRRzHXbd7Y3bYzuxm+Zg9P8=;
        b=TthjytP0OXXfz+cxynvCi2MkqVTdWDzh2E+UcTKAyKTJaQXNT8cwAgmMtpbmE3J9Jp
         akqZHjjAGy10uZdyKeMhwz3FlhnbfYzam+k7eqgYdOVwmRBWhpubJ+ct166NkVRg7iqC
         77RHCbWgOl6qg7M/7OMGwpSCzVKo08ZrED6tqNpPaD6H5JxnWLRWN4PSRHCdgnmXt2iM
         /ZLU4MT283fxV346TaTyxmlibjebG+hqwOyFoqZPfKLlP4CxIbOTpp1p5fnRkJRORYye
         C9oS+Lv/Rqumy5EKUWQP8+AIn7xk24tXS5LnB+GOKBe9MeBzpr128/TrRpd6hI0XPdrU
         vY/w==
X-Gm-Message-State: AGi0PuatAL0eeIIG52up+zNAU6Jq7EYQOd4WZpVj6A/aYvDCsZzF+Kuv
        roJU65FNAwx8Y7Rh0eNojMzJjx4+ELb1ZA==
X-Google-Smtp-Source: APiQypKTxPPh1QiXbSn/gdhc82P9lUYMX0qwVgoiWk9HAPgY4WecmGAJ4ff3nrXi/s+9mfTyBBFVXw==
X-Received: by 2002:a63:5a5d:: with SMTP id k29mr14492941pgm.176.1588175823988;
        Wed, 29 Apr 2020 08:57:03 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id e135sm1387716pfh.37.2020.04.29.08.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 08:57:03 -0700 (PDT)
Date:   Wed, 29 Apr 2020 09:57:01 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2020, #03; Tue, 28)
Message-ID: <20200429155701.GA83442@syl.local>
References: <xmqqimhjyy9c.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqimhjyy9c.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 04:41:03PM -0700, Junio C Hamano wrote:
> * tb/diff-tree-with-notes (2020-04-20) 1 commit
>   (merged to 'next' on 2020-04-22 at c06610c916)
>  + diff-tree.c: load notes machinery when required
>
>  "git diff-tree --pretty --notes" used to hit an assertion failure,
>  as it forgot to initialize the notes subsystem.

Thanks, I'm happy to see this merged.

> * tb/reset-shallow (2020-04-24) 2 commits
>   (merged to 'next' on 2020-04-28 at 9510639ae8)
>  + shallow.c: use '{commit,rollback}_shallow_file'
>  + t5537: use test_write_lines and indented heredocs for readability
>
>  Fix in-core inconsistency after fetching into a shallow repository
>  that broke the code to write out commit-graph.
>
>  Will merge to 'master'.

Likewise. I promised you and Jonathan Nieder a follow-up series in [1]
to move some of the declarations in commit.h to a new shallow.h, and to
introduce a 'struct shallow_lock'. I have those patches locally, but
I'll send them shortly.

> * tb/commit-graph-fd-exhaustion-fix (2020-04-24) 4 commits
>   (merged to 'next' on 2020-04-28 at 6d5fd6bc49)
>  + commit-graph: close descriptors after mmap
>  + commit-graph.c: gracefully handle file descriptor exhaustion
>  + t/test-lib.sh: make ULIMIT_FILE_DESCRIPTORS available to tests
>  + commit-graph.c: don't use discarded graph_name in error
>  (this branch uses tb/commit-graph-split-strategy.)
>
>  The commit-graph code exhausted file descriptors easily when it
>  does not have to.
>
>  Will merge to 'master'.

I'm _very_ glad to see this one merged ;).

> * tb/commit-graph-perm-bits (2020-04-27) 6 commits
>  - commit-graph.c: make 'commit-graph-chain's read-only
>  - commit-graph.c: ensure graph layers respect core.sharedRepository
>  - SQUASH??? force known umask if you are going to check the resulting mode bits
>  - commit-graph.c: write non-split graphs as read-only
>  - lockfile.c: introduce 'hold_lock_file_for_update_mode'
>  - tempfile.c: introduce 'create_tempfile_mode'
>
>  Some of the files commit-graph subsystem keeps on disk did not
>  correctly honor the core.sharedRepository settings and some were
>  left read-write.
>
>  Expecting a reroll.

Reroll coming shortly, sorry about the trouble here.

> * tb/commit-graph-split-strategy (2020-04-15) 7 commits
>  + commit-graph.c: introduce '--[no-]check-oids'
>  + commit-graph.h: replace 'commit_hex' with 'commits'
>  + oidset: introduce 'oidset_size'
>  + builtin/commit-graph.c: introduce split strategy 'replace'
>  + builtin/commit-graph.c: introduce split strategy 'no-merge'
>  + builtin/commit-graph.c: support for '--split[=<strategy>]'
>  + t/helper/test-read-graph.c: support commit-graph chains
>  (this branch is used by tb/commit-graph-fd-exhaustion-fix.)
>
>  "git commit-graph write" learned different ways to write out split
>  files.
>
>  Will merge to 'master'.

I know this series has been kind of a slog, but I would like to hold off
on the last patch to introduce '--no-check-oids' here. The other patches
all seem to be set (and were mostly already reviewed when I sent this
series for the first time), but the last patch still is under discussion
[2].

My thought is that we could either replace that patch with one to
silently ignore non-commits always, or keep it and rename it to
'--[no-]verify-oids' with some minor documentation changes.

In either case, the rest of the series is ready to merge, and other
topics depend on it, so I figure that we can merge the first 6 patches
and hold off on the last one for now.

Sound good?

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20200424171301.GB61470@syl.local/
[2]: https://lore.kernel.org/git/20200424105957.GB5925@szeder.dev/
