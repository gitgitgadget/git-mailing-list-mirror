Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F6120248
	for <e@80x24.org>; Tue, 12 Mar 2019 23:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfCLX2J (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 19:28:09 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:35349 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCLX2J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 19:28:09 -0400
Received: by mail-ed1-f48.google.com with SMTP id g19so3825527edp.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 16:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=MwXm3WB43CKvDwx4VG08HmilTaFW+bJ4zNIAUVi6J1c=;
        b=nb0xu3sSxmySPVI44Gx60A0DrQ6yesCKZl3wLuSv4054wR2PnanWKBSyRAWf9Kvwzl
         cnwfk26m5INScEFdy9AnJemch3WZWWi7t+ZveD59rs1+EIlYTpla9WcU+BDCtXQe6980
         SIbn9hPfwTvwI3GydWXpZhXOLZGOK1TeoDfcKSbHy56hIL4xs4a/uQ8i2msOXIW3CY85
         WHAuSCOjrAoWVUBAYv8q735w7oznFHE2OTXr8wuYVZOY0x7flD5NZxpRlpzFLnH2i40p
         VHs9r36KxcaOovek6ZVvkFp3G3v5Sq8pjU3U+DatZzsbPuwnm+ahNHlRAVJqTvSPQ5cP
         mL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=MwXm3WB43CKvDwx4VG08HmilTaFW+bJ4zNIAUVi6J1c=;
        b=N1vzn4rO8z3XzmFk6AgCdWROzZbbBvyzP50i/t5hFTRD/ixxBNFQZrqG1mm5H4ZuOT
         dRE/sXeefVdFL2uFtsuEm1gFS9lFf8ppTnzGigPfmuRozRZzxpZTF6hu5cV8DD4hBpk/
         t/QSjUxNHe5U8r4oOin6C2p6d6IJ/nouqeXH4kvnn8gP/XyGp//s5KIa8RcGK9KaGWLw
         g0hU6V+VZiOmdEJdlKDKvKLSkvZuu+nMyG9yMQQIyJfhaYFuihup2BH48neHbrp0iQhs
         EXCxxMfBS1iZEYJjE36tQibGt+RRwBtEuQjMhXWStIYjvSf/nYG7EMPX4IqKx6OcS1dp
         JkdQ==
X-Gm-Message-State: APjAAAUmG4wsSHqlFEhvtd5mihB1ldjWu0WrHS+vU4NA/1VuQ7vPkBlr
        XGD4awhBx/Zeo++aYelH6bgxNSw8
X-Google-Smtp-Source: APXvYqxTeKFpFF0B4bVlJdW5cYCGshqDengre14rkJR0YhZHJaAZV4SvmtlxIVwL8M8PzmjzRBmx8g==
X-Received: by 2002:a50:a4f1:: with SMTP id x46mr5464691edb.62.1552433286697;
        Tue, 12 Mar 2019 16:28:06 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id n10sm42767ejl.22.2019.03.12.16.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 16:28:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: BUG: Race condition due to reflog expiry in "gc"
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
Date:   Wed, 13 Mar 2019 00:28:05 +0100
Message-ID: <87tvg7brlm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm still working on fixing a race condition I encountered in "gc"
recently, but am not 100% sure of the fix. So I thought I'd send a
braindump of what I have so far in case it jolts any memories.

The problem is that when we "gc" we run "reflog expire --all". This
iterates over the reflogs, and takes a *.lock for each reference.

It'll fail intermittendly in two ways:

 1. If something is concurrently committing to the repo it'll fail
    because we for a tiny amount of time hold a HEAD.lock file, so HEAD
    can't be updated.

 2. On a repository that's just being "git fetch"'d by some concurrent
    process the "gc" will fail, because the ref's SHA1 has changed,
    which we inspect as we aquire the lock.

To reproduce this have a repo getting a bunch of commits and "fetch"
from it in a loop[A]. Then try to "gc" in it (or "reflog expire
--all"). You'll get case #2 above (#1 can also be manually reproduce):

    $ git gc; echo $?
    error: cannot lock ref 'refs/remotes/origin/HEAD': ref 'refs/remotes/origin/HEAD' is at d13c708ae0435c88c8f7580442b70df9a40224d0 but expected 7fb5b7dd9988d040a9d29c0456874472bea2b439
    error: cannot lock ref 'refs/remotes/origin/master': ref 'refs/remotes/origin/master' is at d13c708ae0435c88c8f7580442b70df9a40224d0 but expected 7fb5b7dd9988d040a9d29c0456874472bea2b439
    fatal: failed to run reflog
    128

This behavior is due to a combination of:

 - 62aad1849f ("gc --auto: do not lock refs in the background", 2014-05-25)
 - f3b661f766 ("expire_reflog(): use a lock_file for rewriting the
   reflog file", 2014-12-12)

Discussion around those changes:

    https://public-inbox.org/git/1400978309-25235-1-git-send-email-pclouds@gmail.com/
    https://public-inbox.org/git/CAGZ79kaPzMPcxMqsTeW5LjYNc7LbpjHE5eBPHWKvUkBU3NvGJw@mail.gmail.com/

I haven't yet found a reason for why we'd intrinsically need this lock,
and indeed this doesn't produce corruption AFAICT:

    diff --git a/refs/files-backend.c b/refs/files-backend.c
    index ef053f716c..ffb9fbbf3a 100644
    --- a/refs/files-backend.c
    +++ b/refs/files-backend.c
    @@ -3043,7 +3043,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
     	if (!lock) {
     		error("cannot lock ref '%s': %s", refname, err.buf);
     		strbuf_release(&err);
    -		return -1;
    +		return 0;
     	}
     	if (!refs_reflog_exists(ref_store, refname)) {
     		unlock_ref(lock);

But that just "solves" #2, not #1, and also no-oping the OID check in
verify_lock() still has all tests pass, so we're likely missing the
relevant race condition tests.

A.

    (
        cd /tmp &&
        rm -rf git &&
        git init git &&
        cd git &&
        while true
        do
            head -c 10 /dev/urandom | hexdump >out &&
            git add out &&
            git commit -m"out"
        done
    )

    (
        cd /tmp &&
        rm -rf git-clone &&
        git clone file:///tmp/git git-clone &&
        cd git-clone &&
        while true
        do
            git reset --hard &&
            git pull
        done
    )
