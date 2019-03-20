Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C802220248
	for <e@80x24.org>; Wed, 20 Mar 2019 22:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfCTWuA (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 18:50:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35730 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfCTWuA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 18:50:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so843981wmd.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 15:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CZclvmfEhWh4dbzjwae229tILuqWH1D1uNNnyQhYXlY=;
        b=K1EF6P/M/1mQchlBt4q96CrN0llJyifyh2wn1HT8EooyHhCpLxqx/gDyWXa0rH4x4u
         L1Wl+NkpeLGfW/iSA37gvFjGopb46wR1hr4IAhtgVhJDeMkc4V99/OyoEyRfxqgaG5ew
         DdTg3/8VIS/abq5subtvp2m8WsSeaHKlH/XUILx3qfIVOvAjUrfuUrS0K0GAQc7r569y
         qurIlx7VhZZKhTZC9smIgnKdfLZ2gMTD6PpA0f6DmTSpqYU+GBkz73H1RScfJomjW884
         fK+MGUXEAxYfWH4zqOg8jSVXvO4tT+FITsiYDdZikvYZIDZrh+CNmTa6k4kPV8oslOZb
         ZSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CZclvmfEhWh4dbzjwae229tILuqWH1D1uNNnyQhYXlY=;
        b=H+18ulVNFJZmtk7uxaB6/dt4C7vqkR9g92SpYIisIN5qzmhyT6l3NE0Sq1mtLLOLle
         EiEFLssEwASnvP5AJqb8l2pxWn5DtQOx/Bxm7TJBc4GYjPNnJase80gR7VmZnSnyyk70
         nhW2G8n36VduWC6jwqnBowH7tfySB+uIhDj1tEeqZg1+o1XpAm2tO3OzSDIKhGX8e7Ly
         jOuL+YEVKGIEt3WO1PxaOg1H2qFMA2k2MWhi/I+FY257zuTCeAsbN8bNmMgCP3s/vRAP
         4IACyhPO8Koz0HFy3tz7IM6ysDvZ1pUkW2pwyvgFNocqqcahtO291JEu3o+HqMWY4h4d
         Oc2A==
X-Gm-Message-State: APjAAAWyCi/iUly/1ekGOV4Vm2KA4FzwYOK44XoG8eQIv/9yswzqzl/w
        18hHTdBCmRGYR4NF9LJrfb0=
X-Google-Smtp-Source: APXvYqzh0EpLBTVfR2EMCVv5GalLSHd5LyC1fJ+rgXnQzSckVOiALti1sRMkenZR9bCgU6ivfYJMUQ==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr394209wmb.61.1553122198119;
        Wed, 20 Mar 2019 15:49:58 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id f20sm7676953wrg.91.2019.03.20.15.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 15:49:56 -0700 (PDT)
Date:   Wed, 20 Mar 2019 22:49:55 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Kraai <mkraai@its.jnj.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2] stash: setup default diff output format if necessary
Message-ID: <20190320224955.GE32487@hank.intra.tgummerer.com>
References: <20190319190503.GA10066@dev-l>
 <20190319231826.GB32487@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319231826.GB32487@hank.intra.tgummerer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the scripted 'git stash show' when no arguments are passed, we just
pass '--stat' to 'git diff'.  When any argument is passed to 'stash
show', we no longer pass '--stat' to 'git diff', and pass whatever
flags are passed directly through to 'git diff'.

By default 'git diff' shows the patch output.  So when we a user uses
'git stash show --patience', they would be shown the diff as expected,
using the patience algorithm.  '--patience' in this case only changes
the diff algorithm, but does not cause 'git diff' to show the diff by
itself.  The diff is shown because that's the default behaviour of
'git diff'.

In the C version of 'git stash show', we try to emulate that behaviour
using the internal diff API.  However we forgot to set up the default
output format, in case it wasn't set by any of the flags that were
passed through.  So 'git stash show --patience' in the builtin version
of stash would be completely silent, while it would show the diff in
the scripted version.

The same thing would happen for other flags that only affect the way a
patch is displayed, rather than switching to a different output format
than the default one.

Fix this by setting up the default output format for 'git diff'.

Reported-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Thanks Peff and Junio for your comments on the previous round.

Compared to v1, this uses the --patience flags for the tests now, and
mentions only the --patience flag in the commit message.  While the
original report was about -v, I do agree that --patience is more
relevant here.

I think this also deserves some explanation of what didn't change,
especially after what I said in [*1*].  We're still not using the
'diff_opt_parse()' option parser, as it doesn't understand '-v' for
example.  'setup_revisions()' understands that, but 'diff_opt_parse()'
doesn't, so we'd still have a change in behaviour at least there.
After discovering that I gave up on that approach.

The other thing that was pointed out is the 'diff_setup_done()' call
here.  'diff_setup_done()' is already called inside of
'setup_revisions()', so we don't need to do it again, unless we change
the output format, which is what we are doing here.  In fact this is
the same way it's implemented in 'builtin/diff.c'.

*1*: <20190320214504.GC32487@hank.intra.tgummerer.com>

 builtin/stash.c  |  4 ++++
 t/t3903-stash.sh | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index 51df092633..012662ce68 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -761,6 +761,10 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 		free_stash_info(&info);
 		usage_with_options(git_stash_show_usage, options);
 	}
+	if (!rev.diffopt.output_format) {
+		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+		diff_setup_done(&rev.diffopt);
+	}
 
 	rev.diffopt.flags.recursive = 1;
 	setup_diff_pager(&rev.diffopt);
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 97cc71fbaf..83926ab55b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -612,6 +612,24 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	test_cmp expected actual
 '
 
+test_expect_success 'stash show -v shows diff' '
+	git reset --hard &&
+	echo foo >>file &&
+	STASH_ID=$(git stash create) &&
+	git reset --hard &&
+	cat >expected <<-EOF &&
+	diff --git a/file b/file
+	index 7601807..71b52c4 100644
+	--- a/file
+	+++ b/file
+	@@ -1 +1,2 @@
+	 baz
+	+foo
+	EOF
+	git stash show --patience ${STASH_ID} >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'drop: fail early if specified stash is not a stash ref' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
-- 
2.21.0.226.g764ec437b0.dirty

