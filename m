Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F661C7EE24
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245239AbjEOTYm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245188AbjEOTYP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:24:15 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A92816086
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:50 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-55a010774a5so194794117b3.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684178629; x=1686770629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pt0W8TK070UZbAvvyy4ks588uT7F0hnS1aN3mrWip98=;
        b=ZLguvgXRNrpD6kR+DJZbbc4277bt/vfhDai4OyZujrNqd/szIVyLLtSl9nw6Y9LfxG
         fFic1G7NGuyC95nPVyNtDX2uJm5JNx/CL6bQpY5vr19VtbPBvynKRQmWo7Fs/fUV89eP
         +CTsLSxttuvjtPednVpIJ1LuyqRYSZorPIS4SAFs0Qxbp8D09hnNs3OlodRhjdRKBO3U
         xU7MZu+XaA1BpFGCPRHsqVhksSLTtoTv4pC8xlFVFmAM/+Hm9vPztNmtUPnhIRHj19UL
         M0vShhDEiTQ7exaE+LU+8QaCW4OQKzI74z4xeUArqfDmDNTxa8TRMz7zPjSuQR+hrOqi
         Z+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178629; x=1686770629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt0W8TK070UZbAvvyy4ks588uT7F0hnS1aN3mrWip98=;
        b=SuR3cMPdPVORTXlqFRbU/XtTia79BjiE1O1XVzR8riBFR/kEuY9Lj4KqUKqoK3TwG/
         cidWeeLciHgzRXTROpjorFtKDdmEFgbyKK8vn8/WCIxvn8OSX1uqH7UCXMhQnzxvg+we
         1jXcIYDaNuzvOKDgce+I9YckJdOeLWZFV3cu9i7XrY7QiH1eNMGtdWjCLbIYNwI0JPwd
         Ghd/KwjpUXunDdrxqc3xnipqlh+RKJd3uo8iEVD+5cUsWtbfqgVW9++xYy5NLQsaiKgq
         6PeDCnO9KgHXIswyiQwYLYqtGVUDEZZzkDn/DtARfufQ4H6xMhHZBLwaj3jNQ/08/ZbJ
         0pvw==
X-Gm-Message-State: AC+VfDxXaqDkSF6zteZmM1E499Rv+nAtk0yC0rN+cXq6m2SVregkTNj3
        YgzvDFO3ptfDvF3FiFAPwH/H3xe+UCALRV8/Nx8NEw==
X-Google-Smtp-Source: ACHHUZ6Oo8d0hITLGOXU29l2o5FSyJMAYU0laelFpjRxadkat/Vcfpzi18dgB7hWQS7I5AOcRxuJXw==
X-Received: by 2002:a0d:ca88:0:b0:55a:9255:9267 with SMTP id m130-20020a0dca88000000b0055a92559267mr31024439ywd.36.1684178629229;
        Mon, 15 May 2023 12:23:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u7-20020a814707000000b0055dfbb44d56sm4557ywa.144.2023.05.15.12.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:23:49 -0700 (PDT)
Date:   Mon, 15 May 2023 15:23:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 14/16] builtin/receive-pack.c: avoid enumerating hidden
 references
Message-ID: <f6a3a5a6bafdb4c7c07f49092a9a15b482b4ee2c.1684178576.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684178576.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that `refs_for_each_fullref_in()` has the ability to avoid
enumerating references matching certain pattern(s), use that to avoid
visiting hidden refs when constructing the ref advertisement via
receive-pack.

Note that since this exclusion is best-effort, we still need
`show_ref_cb()` to check whether or not each reference is hidden or not
before including it in the advertisement.

As was the case when applying this same optimization to `upload-pack`,
`receive-pack`'s reference advertisement phase can proceed much quicker
by avoiding enumerating references that will not be part of the
advertisement.

(Below, we're still using linux.git with one hidden refs/pull/N ref per
commit):

    $ hyperfine -L v ,.compile 'git{v} -c transfer.hideRefs=refs/pull receive-pack --advertise-refs .git'
    Benchmark 1: git -c transfer.hideRefs=refs/pull receive-pack --advertise-refs .git
      Time (mean ± σ):      89.1 ms ±   1.7 ms    [User: 82.0 ms, System: 7.0 ms]
      Range (min … max):    87.7 ms …  95.5 ms    31 runs

    Benchmark 2: git.compile -c transfer.hideRefs=refs/pull receive-pack --advertise-refs .git
      Time (mean ± σ):       4.5 ms ±   0.2 ms    [User: 0.5 ms, System: 3.9 ms]
      Range (min … max):     4.1 ms …   5.6 ms    508 runs

    Summary
      'git.compile -c transfer.hideRefs=refs/pull receive-pack --advertise-refs .git' ran
       20.00 ± 1.05 times faster than 'git -c transfer.hideRefs=refs/pull receive-pack --advertise-refs .git'

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/receive-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1a8472eddc..bd5bcc375f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -337,7 +337,8 @@ static void write_head_info(void)
 {
 	static struct oidset seen = OIDSET_INIT;
 
-	for_each_ref(show_ref_cb, &seen);
+	refs_for_each_fullref_in(get_main_ref_store(the_repository), "",
+				 hidden_refs.v, show_ref_cb, &seen);
 	for_each_alternate_ref(show_one_alternate_ref, &seen);
 	oidset_clear(&seen);
 	if (!sent_capabilities)
-- 
2.40.1.572.g5c4ab523ef

