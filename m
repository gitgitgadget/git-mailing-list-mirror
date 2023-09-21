Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6087E7D0A4
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 18:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjIUSzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 14:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjIUSzH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 14:55:07 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95969EE06B
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 11:45:15 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d8168d08bebso1632985276.0
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 11:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695321914; x=1695926714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f/1tR3ObxYB6UmXXEQqMimGnV6jv1OnHVHb7TMWwqg8=;
        b=iarCYTTfYDDZVD+l1d8Lo7Bw1r53lzGnNp404XxF6byKUPkHvFmUiJiLRDOrf8LmUQ
         hjbCpU6ygOhXxwMyWDBoXHWUmmhFcdqHnhZB4yxhRN58SRJelg9aYDpF7oQMYPam78x+
         ndDH6aJspjo0Luru04seAByCOs0g7cfWn5Be9naghXSO9xb/rHit2PW+ZPCGHLj91Hd3
         GfOuBRN+C39izSyu9fuNf+1kq4sPp4rE0iD2WV0VQruTudL2hQCEHviYB7lmFJqKPROJ
         iKqKcPzypPmf9egx8BHKVbkrLEWkccEMoknzNlPtbDRAM9c8zto7XpqAZfzpHBZ4udk5
         +lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321914; x=1695926714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/1tR3ObxYB6UmXXEQqMimGnV6jv1OnHVHb7TMWwqg8=;
        b=prrFzbXTxvZeOiOb5CBqS8G7ayFYem7iRG5EbgHQ5QXc91kK3Uw4Xm7BovMbox+B4k
         XLQ2Vaw+dXZ3JPUX73AObpUFqFkbPzEASZBwbqSXiDqyCS6Kts/T55MRpCCZ7bmsU9GL
         Lwl3+OvpEGhxmJphXaz+CeTX8ESLaPeijbsswzDVVIeSJc6R9HIjRz31E+9o2ZpHEINg
         cSkVxMUFSRTO/yZGUKFUhMwYIO8R5YBrs+SMQtTJvV+jlO9tdvo//aGkv3E69q2SSps+
         XgReXrvzeZ9T+p37qk8Jwe07TH/Q7P0/+OPH6OhsAXwuQkJc2IJ+xexztnWbbYrN3+pH
         oSbg==
X-Gm-Message-State: AOJu0YyNfvrUYBJv4a8NWuVKh0W+13HNTpFwLqTPCHkX53N5Ak7mB2pO
        kxKjrgCd6sR56hLX/hWxbBfr1Q==
X-Google-Smtp-Source: AGHT+IFtQ/oI7mNDuMsyovra9vN3k8ojWItPVlwrnuF790hjdcRb0KNlI51D9gCgmF5ivHVp8O/DTQ==
X-Received: by 2002:a81:a1d6:0:b0:59b:51d9:1d6e with SMTP id y205-20020a81a1d6000000b0059b51d91d6emr6688938ywg.6.1695321914587;
        Thu, 21 Sep 2023 11:45:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g143-20020a815295000000b005897fd75c80sm465438ywb.78.2023.09.21.11.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 11:45:14 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:45:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] revision: make pseudo-opt flags read via stdin behave
 consistently
Message-ID: <ZQyPOScCKhHeZNrr@nand.local>
References: <b93d4c8c23552abab64084b62f27944e7e192c0c.1695290733.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b93d4c8c23552abab64084b62f27944e7e192c0c.1695290733.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2023 at 12:05:57PM +0200, Patrick Steinhardt wrote:
> When reading revisions from stdin via git-rev-list(1)'s `--stdin` option
> then these revisions never honor flags like `--not` which have been
> passed on the command line. Thus, an invocation like e.g. `git rev-list
> --all --not --stdin` will not treat all revisions read from stdin as
> uninteresting. While this behaviour may be surprising to a user, it's
> been this way ever since it has been introduced via 42cabc341c4 (Teach
> rev-list an option to read revs from the standard input., 2006-09-05).

I'm not sure I agree that `--all --not --stdin` marking the tips given
on stdin as uninteresting would be surprising to users. It feels like
`--stdin` introduces its own "scope" that `--not` should apply to.

I might be biased or looking at this differently than how other users
might, but `--all --not --stdin` reads like "traverse everything except
what I give you over stdin", and deviating from that behavior feels more
surprising than not.

Either way, since this comes from as far back as 42cabc341c4, I think
that we're stuck with this behavior one way or the other ;-).

> With that said, in c40f0b7877 (revision: handle pseudo-opts in `--stdin`
> mode, 2023-06-15) we have introduced a new mode to read pseudo opts from
> standard input where this behaviour is a lot more confusing. If you pass
> `--not` via stdin, it will:
>
>     - Influence subsequent revisions or pseudo-options passed on the
>       command line.

I agree here that this behavior is legitimately surprising and should
probably be considered a bug.

>     - Influence pseudo-options passed via standard input.
>
>     - _Not_ influence normal revisions passed via standard input.
>
> This behaviour is extremely inconsistent and bound to cause confusion.
>
> While it would be nice to retroactively change the behaviour for how
> `--not` and `--stdin` behave together, chances are quite high that this
> would break existing scripts that expect the current behaviour that has
> been around for many years by now. This is thus not really a viable
> option to explore to fix the inconsistency.
>
> Instead, we change the behaviour of how pseudo-opts read via standard
> input influence the flags such that the effect is fully localized. With
> this change, when reading `--not` via standard input, it will:
>
>     - _Not_ influence subsequent revisions or pseudo-options passed on
>       the command line, which is a change in behaviour.
>
>     - Influence pseudo-options passed via standard input.
>
>     - Influence normal revisions passed via standard input, which is a
>       change in behaviour.

These all same very sane to me. Let's read on...

> Thus, all flags read via standard input are fully self-contained to that
> standard input, only.
>
> While this is a breaking change as well, the behaviour has only been
> recently introduced with Git v2.42.0. Furthermore, the current behaviour
> can be regarded as a simple bug. With that in mind it feels like the
> right thing to do retroactively change it and make the behaviour sane.

I agree. I am not so sympathetic to scripts that rely on this behavior,
which feels like it is obviously broken.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> Reported-by: Christian Couder <christian.couder@gmail.com>
> ---
>  Documentation/rev-list-options.txt |  6 +++++-
>  revision.c                         | 10 +++++-----
>  t/t6017-rev-list-stdin.sh          | 21 +++++++++++++++++++++
>  3 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index a4a0cb93b2..9bf13bac53 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -151,6 +151,8 @@ endif::git-log[]
>  --not::
>  	Reverses the meaning of the '{caret}' prefix (or lack thereof)
>  	for all following revision specifiers, up to the next `--not`.
> +	When used on the command line before --stdin, the revisions passed
> +	through stdin will not be affected by it.

Hmmph. This seems to change the behavior introduced by 42cabc341c4. Am I
reading this correctly that tips on stdin with '--not --stdin' would not
be marked as UNINTERESTING?

(Reading this back, there are a lot of double-negatives in what I just
wrote making it confusing for me at least. What I'm getting at here is
that I think `--not --stdin` should mark tips given via stdin as
UNINTERESTING).

>  --all::
>  	Pretend as if all the refs in `refs/`, along with `HEAD`, are
> @@ -240,7 +242,9 @@ endif::git-rev-list[]
>  	them from standard input as well. This accepts commits and
>  	pseudo-options like `--all` and `--glob=`. When a `--` separator
>  	is seen, the following input is treated as paths and used to
> -	limit the result.
> +	limit the result. Flags like `--not` which are read via standard input
> +	are only respected for arguments passed in the same way and will not
> +	influence any subsequent command line arguments.
>
>  ifdef::git-rev-list[]
>  --quiet::
> diff --git a/revision.c b/revision.c
> index 2f4c53ea20..a1f573ca06 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2788,13 +2788,13 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
>  }
>
>  static void read_revisions_from_stdin(struct rev_info *revs,
> -				      struct strvec *prune,
> -				      int *flags)
> +				      struct strvec *prune)
>  {
>  	struct strbuf sb;
>  	int seen_dashdash = 0;
>  	int seen_end_of_options = 0;
>  	int save_warning;
> +	int flags = 0;

OK, I think this confirms my assumption that the `--not` in `--not
--stdin` does not propagate across to the input given over stdin. I am
not sure that we are safely able to change that behavior.

I wonder if we could instead do something like:

  - inherit the current set of psuedo-opts when processing input over
    `--stdin`
  - allow pseudo-opts within the context of `--stdin` arbitrarily
  - prevent those psuedo-opts applied while processing `--stdin` from
    leaking over to subsequent command-line arguments.

Here's one approach for doing that, where we make a copy of the current
set of flags when calling `read_revisions_from_stdin()` instead of
passing a pointer to the global state.

--- 8< ---
diff --git a/revision.c b/revision.c
index a1f573ca06..d8dad35d52 100644
--- a/revision.c
+++ b/revision.c
@@ -2788,13 +2788,13 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 }

 static void read_revisions_from_stdin(struct rev_info *revs,
-				      struct strvec *prune)
+				      struct strvec *prune,
+				      int flags)
 {
 	struct strbuf sb;
 	int seen_dashdash = 0;
 	int seen_end_of_options = 0;
 	int save_warning;
-	int flags = 0;

 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
@@ -2906,7 +2906,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				}
 				if (revs->read_from_stdin++)
 					die("--stdin given twice?");
-				read_revisions_from_stdin(revs, &prune_data);
+				read_revisions_from_stdin(revs, &prune_data,
+							  flags);
 				continue;
 			}
--- >8 ---

Thanks,
