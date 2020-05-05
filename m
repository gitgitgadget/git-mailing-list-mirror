Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C712C3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54EF520658
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MDy2j9Dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgEEBNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 21:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726598AbgEEBNg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 21:13:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55D7C061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 18:13:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fu13so271069pjb.5
        for <git@vger.kernel.org>; Mon, 04 May 2020 18:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=exNgNNLbUK6KVBCW7XwPw58u+E59NxXYhCs4uWIOh18=;
        b=MDy2j9Dx4Sq4JPEdQUUh1Clilj5r4/31Rnkp1qsP+59pfmbfT4jkP1Lixr2YY3gc3s
         L+JArFDZ5y6X/G0of+N3ysXkYv7G0RE3n2PTKk6uhIFyXwmsGf1MSJNZxXnF8Jo+NqMv
         zHsuQCSRNjrkEcqYpusn9ukKkDEymSbhguUTpJUvGKOJ0A4qF3/laXzk8eVbjPqKTtUQ
         yBaVJRUYyTnE464FV7xd7VXZMKV30Nm9ihXdLe9HbJ01tQnr6oVZLrwym/HysZsEn340
         5mmEkzsquamWBvH4mFIxbYI80yO34Vkv162zoA/YpqHpxsentkVO2wRvv1nNCz04GGcx
         tRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=exNgNNLbUK6KVBCW7XwPw58u+E59NxXYhCs4uWIOh18=;
        b=ZPIVVn9fxv/psHEiadgdlfENi8xzqQMDt8iCyBViG+ePA5wTOusJ/30gsrQx81czm5
         ui6mgIf/N0czPRhp4hqL8yp2G2hVlr21mwgPO0nCcTlzS6yeJG8RImqF0i/sXZJIAGHz
         Z9m/UqZXbdFgmDX1br7K0SVfU6UkkI1LutWXI8jlEfHvJlREJ59H81+0OSUKDOO0AjG7
         hOh6HbE3d76wJYRxmHGGNzoJNM9bkDlqV2AkkFYD9KfqdG2f5VPpqv/A2267IwpepbHV
         mHt4q6PPy5pqeusv1Zl9IxigSx2hWdqI/bSDBv+6YZAAoN/W5E80Ssj17gApPDFTEjzg
         WjFQ==
X-Gm-Message-State: AGi0PuaIQPf8yMyipDLquczIXeICF8bjfKAEn480VBuLYJskEBiYIbG2
        OwIQAn5+aqJM916NwcLat5SHmH3+IK2Phw==
X-Google-Smtp-Source: APiQypKxU7WQgB8cCm5WND2KO7pr8d6MjFA8+1Z7CqaruEV6w+qQn3v9L+vI8pY6ITgYXvLAO6hxFQ==
X-Received: by 2002:a17:902:b685:: with SMTP id c5mr791043pls.154.1588641213699;
        Mon, 04 May 2020 18:13:33 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w126sm301847pfb.117.2020.05.04.18.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 18:13:32 -0700 (PDT)
Date:   Mon, 4 May 2020 19:13:31 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 0/8] commit-graph: drop CHECK_OIDS, peel in callers
Message-ID: <cover.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

These are a few patches to address [1] by getting rid of the
'COMMIT_GRAPH_WRITE_CHECK_OIDS' flag. A more complete discussion about
why we might want to get rid of that flag can be found in the second
patch, as well as in [1], but the basic gist is as follows:

  - It is often convenient to pipe the output of 'git for-each-ref' into
    'git commit-graph write --stdin-commits', but handling multi-layer
    tags is frustrating (at the very least, you have to peel them
    yourself in 'for-each-ref', incurring a higher-than-necessary cost
    outside of the commit-graph invocation)

  - It would be much more convenient if 'git commit-graph write
    --stdin-commits' ignored OIDs that peel down to non-commit objects
    silently, while still warning the caller about objects that (a)
    don't exist, or (b) invalid hash inputs (for e.g., "HEAD", or
    "refs/heads/foo").

  - By making this change, we are allowing *more* possible behaviors
    than in previous versions, and the only case that we are breaking
    (that 'git commit-graph write --stdin-commits' complains on
    non-commit OIDs) can be addressed by peeling outside of
    'commit-graph write' [2].

The first six patches move peeling refs out from the commit-graph
internals, and into the callers.

This has no impact on the '--stdin-commits' case, but is a potential
improvement for '--reachable', where it is more efficient to call
'peel_ref()' than 'lookup_commit_reference_gently()'. There is an
intermediate state (that is resolved in the final patch) where we can
have more than one progress meter (since the progress meter moved with
the perhaps-expensive operations out of the commit-graph internals,
too), but the final patch addresses this.

The last two patches lift the restriction on input to '--stdin-commits'
resolving to commit objects, instead making the behavior to silently
drop non-commit OIDs, and continue complain about invalid OIDs, and
valid-but-missing OIDs.

Finally, this topic isn't based on anything that isn't already in
'master', so I think the days of many tangle commit-graph topics are
behind us.

Thanks in advance for your review.

Thanks,
Taylor

Taylor Blau (8):
  commit-graph.c: extract 'refs_cb_data'
  commit-graph.c: show progress of finding reachable commits
  commit-graph.c: peel refs in 'add_ref_to_set'
  builtin/commit-graph.c: extract 'read_one_commit()'
  builtin/commit-graph.c: dereference tags in builtin
  commit-graph.c: simplify 'fill_oids_from_commits'
  t5318: reorder test below 'graph_read_expect'
  commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag

 Documentation/git-commit-graph.txt |  6 ++-
 builtin/commit-graph.c             | 73 ++++++++++++++++++++----------
 commit-graph.c                     | 61 +++++++++++--------------
 commit-graph.h                     | 10 ++--
 t/t5318-commit-graph.sh            | 25 ++++++----
 5 files changed, 98 insertions(+), 77 deletions(-)

--
2.26.0.113.ge9739cdccc
