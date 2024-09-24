Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B9D11CA0
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727202734; cv=none; b=u+Zw5gektiWiBZIkBkM4SW84MZBQx/A6sLNgkhfrL8MfMiLkZfjDivHdysQ9Pz3lk7kEr5zNppEah8DgT9UjBO9zIumO7Swio55/sishnePJ5DXH+W+qqdgtD7Lnr++lugMXv77LqzfC+OMOur8w1iE9lXNIHp6B3TF0YQnipoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727202734; c=relaxed/simple;
	bh=cUdWI3y9vP3wjhtncYjeNjUb5Tq1KRzv6Tgrl6TNaaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=urdRfdLYcUP0RgroLXpKFuqukQALQdoCmjFPit3LkiKPyW4TBT3BHPHE5YFqMnobiOYIHEvOhDVDceWgUAj4EbKpN4aORLnVqSniBxbmBvu1lyilVeOQTD/Xo7WIDjWDQxWd9ATjf8uq5qMJqxLA1DRKW/q8x7GV+Dlk/MKc8ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kaip324V; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kaip324V"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F4ED1B88D;
	Tue, 24 Sep 2024 14:32:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cUdWI3y9vP3wjhtncYjeNjUb5Tq1KRzv6Tgrl6
	TNaaY=; b=kaip324V6oB7Sv/ekpF1CgCnm+R89cCmaJelLXpiP+q/SzV2nqnu3a
	rPZohtWhb1mWiuuePkbGtn7IVJdV5PIU3IZuwZyIyFBdjpeGVJELAF7Eh+XmxZCy
	Ll5O4nz2QSd1DdElNFOGIvjRwCm0eFdKWkQyfyYQGWxwlqq/4t4mM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 33C4F1B88C;
	Tue, 24 Sep 2024 14:32:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65AC41B88B;
	Tue, 24 Sep 2024 14:32:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 3/4] apply: remove the_repository global variable
In-Reply-To: <4ce463defa807fb99eef6ce7abcd758fc2065c13.1727185364.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Tue, 24 Sep 2024 13:42:43
	+0000")
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<4ce463defa807fb99eef6ce7abcd758fc2065c13.1727185364.git.gitgitgadget@gmail.com>
Date: Tue, 24 Sep 2024 11:32:07 -0700
Message-ID: <xmqq7cb0ucm0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4F882F4E-7AA3-11EF-AAB5-9B0F950A682E-77302942!pb-smtp2.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Remove the_repository global variable in favor of the repository
> argument that gets passed in through the builtin function.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  builtin/apply.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 84f1863d3ac..d0bafbec7e4 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
>  #include "gettext.h"
>  #include "hash.h"
> @@ -12,14 +11,14 @@ static const char * const apply_usage[] = {
>  int cmd_apply(int argc,
>  	      const char **argv,
>  	      const char *prefix,
> -	      struct repository *repo UNUSED)
> +	      struct repository *repo)
>  {
>  	int force_apply = 0;
>  	int options = 0;
>  	int ret;
>  	struct apply_state state;
>  
> -	if (init_apply_state(&state, the_repository, prefix))
> +	if (init_apply_state(&state, repo, prefix))
>  		exit(128);

Hmph, the reason why we do not segfault with this patch is because
repo will _always_ be the_repository due to the previous change.

I am not sure if [1/4] is an improvement, though.  We used to be
able to tell if we were running in a repository, or we were running
in "nongit" mode, by looking at the NULL-ness of repo (which was
UNUSED because we weren't taking advantage of that).  

With [1/4], it no longer is possible.  From the point of view of API
to call into builtin implementations, it smells like a regression.

A more honest change for this hunk would rather be something like:

        -	if (init_apply_state(&state, the_repository, prefix))
        +	if (!repo)
        +		repo = the_repository;
        +	if (init_apply_state(&state, repo, prefix))

without [1/4].  This change does not address "apply still depends on
having access to the_repository even when it is being used as a better
GNU patch" issue at all.

So, no, while I earlier said I was happy with [1/4], I no longer am
enthused by the change.
