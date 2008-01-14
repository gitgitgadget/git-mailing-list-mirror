From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] builtin-commit.c: remove useless check added by faulty cut and paste
Date: Tue, 15 Jan 2008 06:23:25 +0900
Message-ID: <200801142128.m0ELSBoE030025@mi0.bluebottle.com>
References: <7v8x2uqabt.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 22:24:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEWnY-0001A5-RX
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 22:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbYANVYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 16:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbYANVYV
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 16:24:21 -0500
Received: from mi0.bluebottle.com ([206.188.25.15]:42954 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYANVYU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 16:24:20 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m0ELSBoE030025
	for <git@vger.kernel.org>; Mon, 14 Jan 2008 13:28:11 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=qOmNZIYRV/NrFb40P0RF/m0Hv45fSVrDjhYQMVEs5xy8eKxEVQK8LfNlS7eYAbQWj
	a3H+gIEnNCA42ZZWgJR29OKCzgGRNNzNVQvRWdAI5kFMn8E/sHwjPVJSmgnlbg/
Received: from nanako3.mail.bluebottle.com ([212.62.97.23])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m0ELO7bV019242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jan 2008 13:24:15 -0800
In-Reply-To: <7v8x2uqabt.fsf_-_@gitster.siamese.dyndns.org>
X-Trusted-Delivery: <2a84c7fbec90139f87490d27cc0630fe>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70479>

Quoting Junio C Hamano <gitster@pobox.com>:

> When I did 2888605c649ccd423232161186d72c0e6c458a48
> (builtin-commit: fix partial-commit support), I mindlessly cut
> and pasted from builtin-ls-files.c, and included the part that
> was meant to exclude redundant path after "ls-files --with-tree"
> overlayed the HEAD commit on top of the index.  This logic does
> not apply to what git-commit does and should not have been
> copied, even though it would not hurt.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin-commit.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/builtin-commit.c b/builtin-commit.c
> index 6d2ca80..265ba6b 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -156,8 +156,6 @@ static int list_paths(struct path_list *list, const char *with_tree,
>  
>  	for (i = 0; i < active_nr; i++) {
>  		struct cache_entry *ce = active_cache[i];
> -		if (ce->ce_flags & htons(CE_UPDATE))
> -			continue;
>  		if (!pathspec_match(pattern, m, ce->name, 0))
>  			continue;
>  		path_list_insert(ce->name, list);

I think I may be wrong, but is this change really correct?

You are calling overlay_tree_on_cache() which does use CE_UPDATE flag to mark
duplicate entries.  And that is the same algorithm as used when git-ls-files
is called with its --with-tree option.  I think this if statement is not
mindless but is the right thing to have the same logic as you have in
git-ls-files.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Finally - A spam blocker that actually works.
http://www.bluebottle.com/tag/4
