Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E48BC3F2CD
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 18:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4664120836
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 18:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUVdWKBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgCBSSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:18:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40159 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBSSg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 13:18:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id e26so65610wme.5
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 10:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3afAqGfuSQzlVH8LVoyqnFr2nCw0QB9fJ+gNAvF50Mc=;
        b=aUVdWKBK5aTftXd897ubmt+rIjpf7hdQHGTz1uizPrO08KEvG1q32ZjahOfRynZ3vG
         o29+CqPIZ3Ypvdn1+RyBq4H4S44R4eWYzzRkI2ZvJQiYQPwkLCAPB7SHqvYp7D+vV/cv
         sI6CGToigjkL3RbbNaXf2GWDPvl4wSrcjsqxFbUe59qcXnuTodxplR4+Hf+QjBFEVfsg
         H6q9sGYgniU+/JeyV8tzUTDbcYAVI9l0ZzTuePbb7yS6Et56IHJ42BzbH6hssLfh/Wjf
         t1BvDKYYoXKNFyPViMOLnH/dvsGujCHWnaqqIRResGML6p+Yzi344z+mf4aqOfvMOy6+
         DIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3afAqGfuSQzlVH8LVoyqnFr2nCw0QB9fJ+gNAvF50Mc=;
        b=Vc5pqQFxdw0IXw36Pn+ntoSgSQUaUNMZD50goR3Qk+lV0qAx0pzRYyfH8lEU6PiJ5j
         6Rts8pcQqoRrvFeCtnE6VoYWmiIEKKIOWLBzPt188toJnYJCOwXtZWT+L2eRqB2cdZrI
         McSSfyVkl+XqrO0/Dwz6JpmL9YdauEh0g3sGxubFij4RqrYrVA1tH051Wi/HKNHWxLX/
         a78h9XsKFEh8LtA5Yo+JmqpBRCs2KsX6xTD/1F4nmBbEYavenIHZItZoOF2k3hGYpa+Z
         FmPPe11wkLs8See0m8EY1UulQfWkCKUySbN5fAOiA7gC/34hC88ba83QnX83IMrh0PWd
         SELg==
X-Gm-Message-State: ANhLgQ3F2zjI/VSUlXqKR+mngSzBAKunOhqd9JHOqao5fII98Sw2dy94
        HblVEpry8moNbedxsB3GpJ4=
X-Google-Smtp-Source: ADFU+vspiltt4baL9iJ8hIsGyXG1evoTjvfmWHIH0ZKjhDZkZaoPE3bBnLunRQ6Q/cQLzEF0cS2DrA==
X-Received: by 2002:a7b:c8c9:: with SMTP id f9mr282541wml.43.1583173114092;
        Mon, 02 Mar 2020 10:18:34 -0800 (PST)
Received: from localhost ([2.28.70.205])
        by smtp.gmail.com with ESMTPSA id q12sm31121408wrg.71.2020.03.02.10.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 10:18:33 -0800 (PST)
Date:   Mon, 2 Mar 2020 18:18:32 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Son Luong Ngoc <son.luong@booking.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: [PATCH 1/2] stash: get git_stash_config at the top level
Message-ID: <20200302181832.GA1571684@cat>
References: <61922A39-13DC-4B17-94FC-7F67DF308347@booking.com>
 <xmqq36ayob9a.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36ayob9a.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/25, Junio C Hamano wrote:
> Son Luong Ngoc <son.luong@booking.com> writes:
> 
> > I have been trying to build git from source and noticing that some
> > tests have been failing since 2.25 with the flag
> > "GIT_TEST_STASH_USE_BUILTIN=false"
> >
> > I think in 2.25 t3903.103 started to fail (rebase related) and
> > current master t3904 may be failing also.
> >
> > Is "GIT_TEST_STASH_USE_BUILTIN=false" is still being tested with
> > or are we totally deprecating this flag?
> 
> In the longer term, when "git stash" gains new features that did not
> exist in the original scripted version, tests that observe how these
> features work would start failing when using the scripted version.
> 
> I picked some people from "git shortlog --no-merges builtin/stash.c"
> and placed them on the CC line---perhaps they may know more.  It
> happens that Johannes is also familiar with "rebase", which you
> said is involved in the test failure, so I'd imagine he would be the
> best person to ask.

Thanks for the report Son, and sorry for taking so long.  I'm a little
behing on reading my emails right now.

I think it is time to get rid of legacy stash.  Nobody seems to have
noticed this test failure until now, but according to your bisection
it looks like this test has been failing since 2.23, which I confirmed
locally.   In addition, the last bugfix that was related to the
rewrite was in 2.25, though that was really a fix for another fix in
2.24 that we failed to catch earlier.

I think 2.26 should still ship with the option, but after that we can
probably get rid of it.  So here's a couple of patches to do just
that, for merging after 2.26 ships.

--- >8 ---
In the next commit we're adding another config variable to be read
from 'git_stash_config', that is valid for the top level command
instead of just a subset.  Move the 'git_config' invocation for
'git_stash_config' to the top-level to prepare for that.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 879fc5f368..f371db270c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -712,7 +712,7 @@ static int git_stash_config(const char *var, const char *value, void *cb)
 		show_patch = git_config_bool(var, value);
 		return 0;
 	}
-	return git_default_config(var, value, cb);
+	return git_diff_basic_config(var, value, cb);
 }
 
 static int show_stash(int argc, const char **argv, const char *prefix)
@@ -749,7 +749,6 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	 * any options.
 	 */
 	if (revision_args.argc == 1) {
-		git_config(git_stash_config, NULL);
 		if (show_stat)
 			rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT;
 
@@ -1573,7 +1572,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	trace_repo_setup(prefix);
 	setup_work_tree();
 
-	git_config(git_diff_basic_config, NULL);
+	git_config(git_stash_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
 			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
-- 
2.25.1.377.g2d2118b814

