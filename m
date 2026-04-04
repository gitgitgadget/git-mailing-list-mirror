Received: from delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18034C14A
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775346064; cv=none; b=oUD0UYBNKlicWPKjZEFoZ1K7jNTgEwcLbnwaSKTnE9t7JmQfXZeQohZEZVe6DnVigef2PzggORx9QQDXVRvR61GT5gcV+OY+0eDJ2JYkbPkOUiTLWsgchRI7ESbwjARgn8pdIxgCwhRmBgcZi8EMsgQai2XvWifq34ouyoBzYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775346064; c=relaxed/simple;
	bh=rMvJ3E5qIWYfxE+L+8Ty4YOUo+MMouIyUVkF8oWt7To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQe4vkgH7htBF49xUZrK0eBtGOo1iZVyY0P7O30YaB18SQMwrQUZQNZ9SKLRZyQD44lDKli8w5HRRDhyPaKimERH1gn6D/VhZ/T4sc0GKgi40s2V7F3Z0fh4UXHQHdwMxQ0HwkTeWn6Dx3Q+pBjGZIO/QNCEga3ByFEIY3yudw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Ljpi0GJR; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Ljpi0GJR"
Date: Sun, 5 Apr 2026 01:40:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1775346060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UNZPrL+k21Txb2e3SbxjbzEVRdCHVZiep8c2whi3LtM=;
	b=Ljpi0GJRBicW24uazHFv6J7kt4f24BBNCOvLt/7BdAYEJbF1U0+wgUlAYx8fkGoJlEBkct
	TprDx2E6JMbx/LuzW0jqkSjmIjeSYTg+PnZt5fYdfbVR1VYrpQfYFOe+X6QTwg+w4YBekH
	fxattyZdOUuudzwH6uSZZd0MrmkEKlYarhgglbL1v6O4LAKjLjZAFyXT6h6ShZp2xeJmIl
	4M6roF1mGzlXWGZy/I1k6ZxXeJP6KEqTHnOrjdMBcx535vIlfsKmPnBqbaWtxpmZQh1CFK
	XFBPu2JRpiJvwbMIC7ks+BTeSA3ztviRk/o6qY4/8GkN0WXUT4MyYKUPqqWx5w==
Authentication-Results: delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org, ben.knoble@gmail.com, quentin.bernet@bluewin.ch, 
	gitster@pobox.com, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v2] stash: infer "push" when push-specific options are
 given
Message-ID: <adGfyHbIKixz4dnx@exploit>
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
 <20260404160357.11534-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404160357.11534-1-deveshigurgaon@gmail.com>
X-Spamd-Bar: /

On Sat, Apr 04, 2026 at 04:03:57PM +0000, Deveshi Dwivedi wrote:
> +test_expect_success 'assume push when options imply push' '
> +	git reset --hard &&
> +	echo changed >file &&
> +	git add file &&
> +	git stash -m "implied push" file &&
> +	git stash pop &&
> +
> +	git add file &&
> +	git stash --staged file &&
> +	git stash pop &&
> +
> +	git add file &&
> +	git stash --keep-index file &&
> +	git stash pop &&
> +
> +	echo untracked >untracked-file &&
> +	git stash --include-untracked untracked-file &&
> +	test_path_is_missing untracked-file &&
> +	git stash pop &&
> +	rm -f untracked-file
> +'
> +

This leaves 'file' in the staging area. Using "git reset --hard" like
you did at the start is probably the easiest way to clean up.


Apart from the testing, since the following is not true anymore...

  For quickly making a snapshot, you can omit "push".  In this mode,
  non-option arguments are not allowed to prevent a misspelled
  subcommand from making an unwanted stash entry.  The two exceptions to
  this are `stash -p` which acts as alias for `stash push -p` and
  pathspec elements, which are allowed after a double hyphen `--` for
  disambiguation.

...you should probably change the documentation for "git push" as well.
