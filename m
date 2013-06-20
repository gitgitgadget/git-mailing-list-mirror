From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] pull: pull into void by fast-forwarding from empty tree
Date: Thu, 20 Jun 2013 21:34:17 +0530
Message-ID: <CALkWK0k-SaYz2uCpeXnTTL7HvBQ=r1PhWCJeDvdpuKL6qhDoig@mail.gmail.com>
References: <45f6841746e5dcea03a97fc3ea24aef274728023.1371731513.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?U3RlZmFuIFNjaMO8w59sZXI=?= <mail@stefanschuessler.de>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 20 18:05:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UphMA-0005BP-4y
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 18:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758181Ab3FTQFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 12:05:00 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:63258 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757947Ab3FTQE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 12:04:59 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so17190677iea.3
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=U0n4PZ9GWVfNrooVQh4oI606YA8Qx61T5wRiFcE6USw=;
        b=azql7jFkH3HHMAhqqXFFk8zCk+/WwTBHAecO7njWbo84rB8ceuTm1hwyEkw2sE7nph
         329VDmU6jE0OK1FN5Ifc8haPfQ5FOhrvvNVWFRFGZlnIhzRjUoiFzqCFUbd5aeooRmmA
         /g9HDxN3xOnyIBe4UY9Jdbom9bmCMsfLJ1dNLVsrxHrYz3dFJkflaJvEpRvUiSjjDab/
         eZBkPstktj41U6GD5QAf27FTcASFUaWR7eTFRHdPDF8ADLb9sbt7UiEJtzNTasFnaXWe
         FqBqsp+WgicI7rgn4lw+dmnfSdbOsHnx4Ib/tlS7Zl+6fY1ax280mHUhgwBH7RAlj1GS
         +EsA==
X-Received: by 10.50.1.37 with SMTP id 5mr36392igj.29.1371744298970; Thu, 20
 Jun 2013 09:04:58 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 20 Jun 2013 09:04:17 -0700 (PDT)
In-Reply-To: <45f6841746e5dcea03a97fc3ea24aef274728023.1371731513.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228510>

Thomas Rast wrote:
> diff --git a/git-pull.sh b/git-pull.sh
> index 638aabb..1f84383 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -266,10 +266,17 @@ case "$merge_head" in
>         ;;
>  esac
>
> +# Pulling into unborn branch: a shorthand for branching off
> +# FETCH_HEAD, for lazy typers.
>  if test -z "$orig_head"
>  then
>         git update-ref -m "initial pull" HEAD $merge_head "$curr_head" &&
> -       git read-tree -m -u HEAD || exit 1
> +       # Two-way merge: we claim the index is based on an empty tree,
> +       # and try to fast-forward to HEAD.  This ensures we will not
> +       # lose index/worktree changes that the user already made on
> +       # the unborn branch.
> +       empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904

Perhaps replace this magic with $(git hash-object -t tree /dev/null)
or $(git mktree </dev/null)?
