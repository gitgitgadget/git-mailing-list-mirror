Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338E1C2BA2B
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 07:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E650120732
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 07:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1QSSyAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDKHNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 03:13:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44145 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDKHNH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 03:13:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id z26so3912673ljz.11
        for <git@vger.kernel.org>; Sat, 11 Apr 2020 00:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NsB09VjF/GxuLtswY/gP9zQjlenym69TAehimUHdv80=;
        b=e1QSSyAI3BHQOUmb4gznql1oRCmRYoM1xicKWs9k68zkOpqahXGmKY/npn2APte/3k
         fXO/je1y9Ps50Vj7Jkt4yBSGowG5CmtnEi0CPpWE1oOKmv1w7X7GpR3+aIEGxBNYBoiS
         5B3w2l8JVoo1RC77LREPbypBpNzyQ2RaAP8KhupT0e986UqaA/J2uye5DImqBHQCxlRp
         Ag0z/BQByeOwTezmJu6IvmRXw6T4MCWr6scUTpQj7+CL+j3yQDSZ5lBz3Iz2DMcqym2b
         IN45Ww1ULSWMX4TKgs7OdDYPAR4UavmktQAmv2ywvvNYytQB5dQFn0ad+Wfp6KIXTeyL
         NWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsB09VjF/GxuLtswY/gP9zQjlenym69TAehimUHdv80=;
        b=FY9HPuC2E7FdZ77/9XAC3j78R4xi6pIx9mkSx/PvY3l62Ero9/erCVRc01EGU/ji89
         KhxfqpMzY0WKind5uh80A/lkYdMvv4FefxRfFuCWVUwHWEvg4oQoyRuhkFAUbm3KT2m9
         25aOXFInfSIxdarpwrnmwblJAe3z1g3JIB5Z4w8ohUZ3ioMZSN3Mr2RQpB2ItnIVZmIF
         uVBixiAWzuvG5mw7DRzorArL1J12klF8zF/IbtUZWza7PZxLi4ysOyHn3ReiVHf5KLlH
         +xYe7f1jmkXaSeLkpYnWT3NBp1Bm3ph1ar+PmtaHRet823bFpOfDs66+2FLHyasf2oUh
         yjeQ==
X-Gm-Message-State: AGi0PuYTtxnxe7AjuAwsVDOKXOBd8lh8bFh+Majqe+GKQppV4it7EVi6
        j6mNT/DPLHCw22gyBiXuvSOsR9HF
X-Google-Smtp-Source: APiQypLGXGxN9C902Inv2KZ92eWMlarAqedAXUc6fyjzBP8Ag3bifL9qYdF14gUvqVDJNp4tqU3i7Q==
X-Received: by 2002:a2e:a40b:: with SMTP id p11mr5004078ljn.173.1586589185468;
        Sat, 11 Apr 2020 00:13:05 -0700 (PDT)
Received: from localhost.localdomain (host-189-203-22.junet.se. [207.189.203.22])
        by smtp.gmail.com with ESMTPSA id x5sm2694396ljh.97.2020.04.11.00.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 00:13:04 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] merge: use skip_prefix to parse config key
Date:   Sat, 11 Apr 2020 09:11:45 +0200
Message-Id: <20200411071145.6839-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200410165644.GA79836@coredump.intra.peff.net>
References: <20200410165644.GA79836@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 10 Apr 2020 at 18:56, Jeff King <peff@peff.net> wrote:
>
> On Fri, Apr 10, 2020 at 09:44:56AM -0700, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > In other words, if k were "branch.A.B.mergeoptions", it can only be
> > the 'branch.*.mergeoptions' variable attached to branch "A.B", but
> > when checking for branch=="A", the first two skip_prefix() would
> > pass and the only thing that protects us from misparsing is that
> > "B.mergeoptions" is not what we are looking for.
>
> Yes, exactly.
>
> > > The more general form would be:
> > [...]
> > Yes, but even with such a helper, i.e.
> > [...]
> > what Martin wrote, especially if it is reflowed to match the above, i.e.
> > [...]
> > I find it just as, if not more, easy to read.
>
> Yeah, sorry if I was unclear; I think the left-to-right is perfectly
> fine for this case.

Thanks both for an interesting discussion. Junio left a remark about
"[easy to read] especially if it is reflowed" which I recognized from my
own thinking yesterday. Then I went for fewer lines in what arguably
looks a bit crammed. Since I was not the only one to find readability in
the larger number of lines, here it is as v2.

Junio, if you go "meh, what I've already picked up will do just as
fine", feel free to act on that, i.e., to not act on this v2.

> Another option for known-value cases like this is to do it outside of
> the callback handler, like:
>
>   char *key = xstrfmt("branch.%s.mergeoptions");
>   const char *value;
>   if (!git_config_get_string_const(key, &value))
>      ...
>   free(key);
>
> The allocation is a bit awkward [...]

I very briefly thought about such an approach here, but still in the
callback handler, where the allocation would be quite a bit more
awkward, since we'd do it over and over.

Something I considered a bit more seriously was a helper that takes
three strings ("branch", branch and "mergeoptions") and does the check.
But as you mention in this thread, it's a bit special that we're looking
for a specific subsection (that is not a compile-time constant). So it
felt like the kind of "nice-to-have" helper that you'd end up using just
once or twice. (That said, I didn't look to see if I could find other
instances.)

Martin

-- >8 --
Instead of using `starts_with()`, the magic number 7, `strlen()` and a
fair number of additions to verify the three parts of the config key
"branch.<branch>.mergeoptions", use `skip_prefix()` to jump through them
more explicitly.

We need to introduce a new variable for this (we certainly can't modify
`k` just because we see "branch."!). With `skip_prefix()` we often use
quite bland names like `p` or `str`. Let's do the same. If and when this
function needs to do more prefix-skipping, we'll have a generic variable
ready for this.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/merge.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index d127d2225f..df83ba2a80 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -597,10 +597,12 @@ static void parse_branch_merge_options(char *bmo)
 static int git_merge_config(const char *k, const char *v, void *cb)
 {
 	int status;
+	const char *str;
 
-	if (branch && starts_with(k, "branch.") &&
-		starts_with(k + 7, branch) &&
-		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
+	if (branch &&
+	    skip_prefix(k, "branch.", &str) &&
+	    skip_prefix(str, branch, &str) &&
+	    !strcmp(str, ".mergeoptions")) {
 		free(branch_mergeoptions);
 		branch_mergeoptions = xstrdup(v);
 		return 0;
-- 
2.26.0

