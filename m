From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/6] sha1_name: implement @{push} shorthand
Date: Tue, 31 Mar 2015 17:41:02 -0400
Message-ID: <CAPig+cR9U9Tm1Lbk_wQpfvY7okEKvYgMvNRzT1ci2u9ALr0HpQ@mail.gmail.com>
References: <20150331173339.GA17732@peff.net>
	<20150331173834.GF18912@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 23:41:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd3ui-0007ay-0w
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 23:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbbCaVlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 17:41:06 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:33615 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbCaVlE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 17:41:04 -0400
Received: by lajy8 with SMTP id y8so22932687laj.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ia2gClowreXkmZUEYmFgTW8YEwd2zaUdhwpPysbcNpQ=;
        b=W2WSrLxOBKBvH23sfCoUYrycOQFVK58Cysj8lbzsdPp352lt7t8RaMkKGYIMofz/f9
         1bSqYCmKBNXfq2nsP7/KY4GXsqp8xxaaAoOSmUSJBoYF8s0m7FG7Dfc/3rW9Cz7LGL+o
         go+FhTRjHBnalpLFlOrk69AMnMgQ57WuTLGl75otmZRLc4pbREOWhfY49pBRRuExeP8Q
         6yS9pFCpN8HcNC/bfhOld/tceQ1KWTwnr9Z1F4fXy3PAN02gC3ZL3rYF4MYW8RC3v5BY
         BF5HzHVDl4DlJSuStf1T8tHNxSFN+soBQKKN4QteXIq83EqZYkFp7BIWfNfknsi9pZ4Z
         gOXw==
X-Received: by 10.152.43.3 with SMTP id s3mr33049259lal.101.1427838062914;
 Tue, 31 Mar 2015 14:41:02 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Tue, 31 Mar 2015 14:41:02 -0700 (PDT)
In-Reply-To: <20150331173834.GF18912@peff.net>
X-Google-Sender-Auth: FnRRG9FI4bqAXoKnKg0wM1brGHg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266561>

On Tue, Mar 31, 2015 at 1:38 PM, Jeff King <peff@peff.net> wrote:
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 0796118..5d9df25 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -98,6 +98,31 @@ some output processing may assume ref names in UTF-8.
>    `branch.<name>.merge`).  A missing branchname defaults to the
>    current one.
>
> +'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
> +  The suffix `@{push}` reports the branch "where we would push to" if
> +  `git push` were run while `branchname` was checked out (or the current
> +  `HEAD` is no branchname is specified). Since our push destination is

s/is no/if no/

> +  in a remote repository, of course, we report the local tracking branch
> +  that corresponds to that branch (i.e., something in `refs/remotes/`).
> ++
> +Here's an example to make it more clear:
> ++
> +------------------------------
> +$ git config push.default current
> +$ git config remote.pushdefault myfork
> +$ git checkout -b mybranch origin/master
> +
> +$ git rev-parse --symbolic-full-name @{upstream}
> +refs/remotes/origin/master
> +
> +$ git rev-parse --symbolic-full-name @{push}
> +refs/remotes/myfork/mybranch
> +------------------------------
> ++
> +Note in the example that we set up a triangular workflow, where we pull
> +from one location and push to another. In a non-triangular workflow,
> +`@{push}` is the same as `@{upstream}`, and there is no need for it.
> +
>  '<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
>    A suffix '{caret}' to a revision parameter means the first parent of
>    that commit object.  '{caret}<n>' means the <n>th parent (i.e.
