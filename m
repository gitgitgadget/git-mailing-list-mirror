Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24034199E9B
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724517; cv=none; b=k1TTKViW76zDBzxmiaXaEzdwPbLe/dnaGoxwdzFtD0liTP9WuoUdrwPEN6pSfsU47T3WqQUsDN1C0ERzxis72uOm+ln6gRLYMgUlW7Vc7hZONJ0HFA7KJDa2n5m4IE8ONNZHaPmOfvGQNCMUWHyxPQY6OaBPDg8dn25b0q9ECd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724517; c=relaxed/simple;
	bh=oWtYlSDzS6XJVR2EE7ZoZIbR4WwBZTn50chqkYfSMDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyZZRxkO5x2cWVP8lthXPCxvz6e3p4dT3grAYgoLBJ36rNhjAQ3ZX2HuFlCTTwFi0WkcT/zT5rJXmmHkJ3xzTnASvzJc6zWiBHYHHz8TLQ3JsZlxhSEUtosyF0lG/85/R8DCxD+n5CpMcvbRi+kWhKIQHf3TU0vIu3HNRjUjI/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=F9FDqjeZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="F9FDqjeZ"
Received: (qmail 6679 invoked by uid 109); 30 Sep 2024 19:28:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=oWtYlSDzS6XJVR2EE7ZoZIbR4WwBZTn50chqkYfSMDU=; b=F9FDqjeZFmMyW9saQE2UEdcis4nT83c21lmEKONiZLJ495XoObxjFZgbpcZQ8TzIueyEv/KDy8N/dgBJ0Xvwct8hE5jkWylPvsyxkLzGJrSU1xtQVTQDi8APXp8sB7ubg5qkrbiRry9wxihz51cnGofoKk24m3+cb0c797YWJYfLRfP8IgiusUj+KRrw5lRVfZA18b0C1aUaCsOT0QPq7XgMupt0qqtfLlYLHhu/YX55hIHRABhzG4MhkcP7i/7ajxImMNOa8Aocd5z2WUDuO4pXoKjktPE//hxA7N0bVavQp4b1ppa4EIRkkT+Wclz490tM3CH5VOiUnhTPTkTtDA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Sep 2024 19:28:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17300 invoked by uid 111); 30 Sep 2024 19:28:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Sep 2024 15:28:26 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Sep 2024 15:28:26 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] refs: mostly remove core.preferSymlinkRefs
Message-ID: <20240930192826.GA1803946@coredump.intra.peff.net>
References: <20240918232825.2627999-1-gitster@pobox.com>
 <20240918232825.2627999-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240918232825.2627999-3-gitster@pobox.com>

On Wed, Sep 18, 2024 at 04:28:23PM -0700, Junio C Hamano wrote:

> diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
> index d369330562..4e517cdc13 100755
> --- a/t/t0600-reffiles-backend.sh
> +++ b/t/t0600-reffiles-backend.sh
> [...]
> @@ -468,26 +468,40 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
>  	esac
>  '
>  
> -test_expect_success SYMLINKS 'symref transaction supports symlinks' '
> +test_expect_success SYMLINKS 'symlinks used as symrefs are still supported' '
>  	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD || :" &&
>  	git update-ref refs/heads/new HEAD &&
> -	test_config core.prefersymlinkrefs true &&
> -	cat >stdin <<-EOF &&
> -	start
> -	symref-create TEST_SYMREF_HEAD refs/heads/new
> -	prepare
> -	commit
> -	EOF
> -	git update-ref --no-deref --stdin <stdin 2>stderr &&
> +	# manually do this, as core.prefersymlinkrefs no longer
> +	# affects how a symref is created (as a textual symref).
> +	ln -f -s refs/heads/new .git/TEST_SYMREF_HEAD &&

There are two other tests that probably should get the same treatment.
In the patch below I've just deleted them, but I think since they are
really about the reading side, they'd probably want a similar manual
setup.

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 2d984eb4c6..72eb5f62e7 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -407,18 +407,6 @@ test_expect_success 'checkout w/--track from tag fails' '
 	test "z$(git rev-parse main^0)" = "z$(git rev-parse HEAD)"
 '
 
-test_expect_success 'detach a symbolic link HEAD' '
-	git checkout main &&
-	git config --bool core.prefersymlinkrefs yes &&
-	git checkout side &&
-	git checkout main &&
-	it=$(git symbolic-ref HEAD) &&
-	test "z$it" = zrefs/heads/main &&
-	here=$(git rev-parse --verify refs/heads/main) &&
-	git checkout side^ &&
-	test "z$(git rev-parse --verify refs/heads/main)" = "z$here"
-'
-
 test_expect_success 'checkout with --track fakes a sensible -b <name>' '
 	git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
 	git update-ref refs/remotes/origin/koala/bear renamer &&
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 95e9955bca..b4d7206bea 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -50,15 +50,6 @@ test_expect_success 'prompt - branch name' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success SYMLINKS 'prompt - branch name - symlink symref' '
-	printf " (main)" >expected &&
-	test_when_finished "git checkout main" &&
-	test_config core.preferSymlinkRefs true &&
-	git checkout main &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
-
 test_expect_success 'prompt - unborn branch' '
 	printf " (unborn)" >expected &&
 	git checkout --orphan unborn &&


I noticed these because I had a similar proposal long ago, which never
got merged (I don't think because anybody particularly disagreed, but it
fell through the cracks and never got picked up again):

  https://lore.kernel.org/git/20151230065343.GA26964@sigill.intra.peff.net/

What you have here is (modulo the two hunks above) more complete than
what I have, so I don't think there's anything else to try to salvage
from it. A little bit of the history in the linked commit message is
interesting as to how we ended up here, but ultimately not really that
important.

-Peff
