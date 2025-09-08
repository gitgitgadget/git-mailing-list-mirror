Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873B4310771
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349721; cv=none; b=NvuOOFpH0JnhuSZWYvRDbo9X1rXnVv3iuFR7465Bq2ySZkkOlw/SwaZJ0ZfOO/nCUjoxQiqSAkwl4Sm86GEJUqKpLVGbIc3aFuC/cO3oBf4aSIqm6GopyK7unpfOPPrTIT4gh6ZU+O7FwCGtdfyZcxOyrVg7SA/v7D6BcyC5xBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349721; c=relaxed/simple;
	bh=t5a7XtUfMjgfvfXyzzOi27T/X1rLnsKTavPPI87exFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFsnW7qLodyKJaGBmBWsDcv6a6WJGdZjBIiT+pAIieSqFZ7oagEjFTd6GqDigWGIbKM67C7ubwYUc1hkc0OYbs89ObI94UePqz7b0et3mfdtRdYzt5n5q+UG0XRPKuHwmkJCZLaWX8Cd+5Rpcqh2SSJPklwk6L2hZyxA/pgyYJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JyjYebCI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JyjYebCI"
Received: (qmail 21803 invoked by uid 109); 8 Sep 2025 16:41:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=t5a7XtUfMjgfvfXyzzOi27T/X1rLnsKTavPPI87exFo=; b=JyjYebCIV/P1p+u1A5cWTHKreMN7dOKOite6L5S2LdGsTTH4mBwqBPYBnkb0wWs3uexRHEg0dANkWlo02ArhOGvGkqHdPrKEQRL4zPHiEHNTnHREZ1gmtkzhO5Pvq1Asn0cvBsCzwizA2a/7UNCEqbtl31HwWSQyGPYq+KUhw7jlAUo/zdMWOmB722+Os7SaQv5y+uWPenChTj01tOLZnbD9pQl2D/Ygpa52c7q6CpK9D0RxE+V2aDqZ3WcVcbPBwY7IWs2SVZ0mOoaFOionM6QNVwP+E3PedwkuY9VDlbejfLHsMRaP0VPpG3yfwuWWTPaLZ8Rdaj2u0zWpKqm/iA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Sep 2025 16:41:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 36147 invoked by uid 111); 8 Sep 2025 16:41:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Sep 2025 12:41:58 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Sep 2025 12:41:57 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Isaac Oscar Gariano <isaacoscar@live.com.au>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] oddities around add-interactive and color
Message-ID: <20250908164157.GA1323487@coredump.intra.peff.net>
References: <SYBP282MB296329544B33E3C16DD99FD28C33A@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
 <20250820220439.GA1668511@coredump.intra.peff.net>
 <20250821070740.GA3356411@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821070740.GA3356411@coredump.intra.peff.net>

On Thu, Aug 21, 2025 at 03:07:40AM -0400, Jeff King wrote:

> So here's a series which I think addresses everything I found. These
> bugs have been lurking for a while, but I guess not many people tend to
> set color variables to anything exotic.

And here's a v2 based on Patrick's review. I also touched up a few lines
whose indentation did not pass clang-format (not new, but ones I was
touching or moving around). The only thing I punted on was refactoring
the GIT_COLOR_* defines, as I think it extends well beyond the code I'm
touching here (see the reply I left in the thread).

-Peff

  [1/4]: stash: pass --no-color to diff plumbing child processes
  [2/4]: add-interactive: respect color.diff for diff coloring
  [3/4]: add-interactive: manually fall back color config to color.ui
  [4/4]: contrib/diff-highlight: mention interactive.diffFilter

 add-interactive.c             | 88 ++++++++++++++++++++++-------------
 add-interactive.h             |  7 ++-
 add-patch.c                   | 12 ++---
 builtin/stash.c               |  5 +-
 contrib/diff-highlight/README |  8 ++++
 t/t3701-add-interactive.sh    | 53 +++++++++++++++++++++
 t/t3904-stash-patch.sh        | 19 ++++++++
 7 files changed, 150 insertions(+), 42 deletions(-)

1:  d1d3c0e7f4 ! 1:  d02117a0d6 stash: pass --no-color to diff-tree child processes
    @@ Metadata
     Author: Jeff King <peff@peff.net>
     
      ## Commit message ##
    -    stash: pass --no-color to diff-tree child processes
    +    stash: pass --no-color to diff plumbing child processes
     
         After a partial stash, we may clear out the working tree by capturing
    -    the output of diff-tree and piping it into git-apply. So we most
    -    definitely do not want color diff output from that diff-tree process.
    -    And it normally would not produce any, since its stdout is not going to
    -    a tty, and the default value of color.ui is "auto".
    +    the output of diff-tree and piping it into git-apply (and likewise we
    +    may use diff-index to restore the index). So we most definitely do not
    +    want color diff output from that diff-tree process.  And it normally
    +    would not produce any, since its stdout is not going to a tty, and the
    +    default value of color.ui is "auto".
     
         However, if GIT_PAGER_IN_USE is set in the environment, that overrides
         the tty check, and we'll produce a colorized diff that chokes git-apply:
    @@ builtin/stash.c: static int stash_patch(struct stash_info *info, const struct pa
      		     oid_to_hex(&info->w_tree), "--", NULL);
      	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
      		ret = -1;
    +@@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
    + 
    + 			cp_diff.git_cmd = 1;
    + 			strvec_pushl(&cp_diff.args, "diff-index", "-p",
    ++				     "--no-color",
    + 				     "--cached", "--binary", "HEAD", "--",
    + 				     NULL);
    + 			add_pathspecs(&cp_diff.args, ps);
     
      ## t/t3904-stash-patch.sh ##
     @@ t/t3904-stash-patch.sh: test_expect_success 'stash -p with split hunk' '
    @@ t/t3904-stash-patch.sh: test_expect_success 'stash -p with split hunk' '
      
     +test_expect_success 'stash -p not confused by GIT_PAGER_IN_USE' '
     +	echo to-stash >test &&
    -+	# Set both GIT_PAGER_IN_USE and TERM. Our goal is entice any
    ++	# Set both GIT_PAGER_IN_USE and TERM. Our goal is to entice any
     +	# diff subprocesses into thinking that they could output
     +	# color, even though their stdout is not going into a tty.
     +	echo y |
     +	GIT_PAGER_IN_USE=1 TERM=vt100 git stash -p &&
     +	git diff --exit-code
     +'
    ++
    ++test_expect_success 'index push not confused by GIT_PAGER_IN_USE' '
    ++	echo index >test &&
    ++	git add test &&
    ++	echo working-tree >test &&
    ++	# As above, we try to entice the child diff into using color.
    ++	GIT_PAGER_IN_USE=1 TERM=vt100 git stash push test &&
    ++	git diff --exit-code
    ++'
     +
      test_done
2:  5d40a0ed74 ! 2:  f2600751b9 add-interactive: respect color.diff for diff coloring
    @@ add-interactive.c: static void init_color(struct repository *r, struct add_i_sta
     +			   s->context_color,
     +			   diff_get_color(s->use_color_diff, DIFF_CONTEXT));
     +	init_color(r, s->use_color_diff, "diff.old", s->file_old_color,
    -+		diff_get_color(s->use_color_diff, DIFF_FILE_OLD));
    ++		   diff_get_color(s->use_color_diff, DIFF_FILE_OLD));
     +	init_color(r, s->use_color_diff, "diff.new", s->file_new_color,
    -+		diff_get_color(s->use_color_diff, DIFF_FILE_NEW));
    ++		   diff_get_color(s->use_color_diff, DIFF_FILE_NEW));
     +	strlcpy(s->reset_color_diff,
     +		s->use_color_diff ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
      
    @@ t/t3701-add-interactive.sh: test_expect_success 'colorized diffs respect diff.ws
     +	test_write_lines s n n |
     +	force_color git \
     +		-c color.interactive=false \
    ++		-c color.interactive.prompt=blue \
     +		-c color.diff=true \
     +		-c color.diff.frag="bold magenta" \
     +		add -p >output.raw 2>&1 &&
     +	test_decode_color <output.raw >output &&
    -+	test_grep "<BOLD;MAGENTA>@@" output
    ++	test_grep "<BOLD;MAGENTA>@@" output &&
    ++	test_grep ! "BLUE" output
     +'
     +
      test_expect_success 'diffFilter filters diff' '
3:  44cb772e07 ! 3:  8979bff0c5 add-interactive: manually fall back color config to color.ui
    @@ Commit message
         It is tempting to teach want_color() to look up the value of
         repo_config_get_value("color.ui") itself. But I think that would have
         disastrous consequences. Plumbing commands, especially older ones, avoid
    -    porcelain config like color. by simply not parsing it in their config
    +    porcelain config like "color.*" by simply not parsing it in their config
         callbacks. Looking up the value of color.ui under the hood would
         undermine that.
     
4:  31c0a6f81e = 4:  a2b328389a contrib/diff-highlight: mention interactive.diffFilter
