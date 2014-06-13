From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] remotes.c: update calls to new signature for repack_without_refs
Date: Fri, 13 Jun 2014 12:40:37 -0700
Message-ID: <xmqqwqck1tu2.fsf@gitster.dls.corp.google.com>
References: <1402674666-6634-1-git-send-email-sahlberg@google.com>
	<1402674666-6634-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 21:40:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvXLH-0008Kc-Vt
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 21:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbaFMTkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 15:40:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50801 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbaFMTko (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 15:40:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 774DA2092C;
	Fri, 13 Jun 2014 15:40:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=proYLT8rF3XiDOHH1lQ+ZlUbmhY=; b=B25hYs
	o4xxymiu83sHLlXlB00qg0lvBSCEye89mKVU6BcZLDppTskect6SGwiN6tWVtPTP
	2xyJ1Rm3F6StNMRraPuiZFNyHNLpy4DgPP+lxqilWjCpRBLQpAwUyQN1C+KLhgyq
	pCiQxxYOak0V6xb5/3HJhEXllR4IC4kuZVH8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q5PLHKQIflBZTAIR/0eaTWAweSnNUXpq
	p0VLg5eATqGdqOvv+GRCcq1UwdfC9eC/qJGPow9hzCheetBW08as+1YGLF9LAXhJ
	4TLEdck2fjYRWunhGo1arJMlY7jhh/DOq0tZoeYS3VNGVYZciAHmfY8SzB0bLYZv
	+v+c7P32kH8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E0B92092B;
	Fri, 13 Jun 2014 15:40:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 607EB20924;
	Fri, 13 Jun 2014 15:40:39 -0400 (EDT)
In-Reply-To: <1402674666-6634-2-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Fri, 13 Jun 2014 08:51:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 991E5FEC-F332-11E3-B571-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251630>

Ronnie Sahlberg <sahlberg@google.com> writes:

> This should be merged into patch:
> 00c74db refs.c: add an err argument to repack_without_refs
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/remote.c | 5 +++--
>  refs.h           | 3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index c9102e8..401feb3 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -755,7 +755,7 @@ static int remove_branches(struct string_list *branches)
>  	branch_names = xmalloc(branches->nr * sizeof(*branch_names));
>  	for (i = 0; i < branches->nr; i++)
>  		branch_names[i] = branches->items[i].string;
> -	result |= repack_without_refs(branch_names, branches->nr);
> +	result |= repack_without_refs(branch_names, branches->nr, NULL);
>  	free(branch_names);
>  
>  	for (i = 0; i < branches->nr; i++) {
> @@ -1333,7 +1333,8 @@ static int prune_remote(const char *remote, int dry_run)
>  		for (i = 0; i < states.stale.nr; i++)
>  			delete_refs[i] = states.stale.items[i].util;
>  		if (!dry_run)
> -			result |= repack_without_refs(delete_refs, states.stale.nr);
> +			result |= repack_without_refs(delete_refs,
> +						      states.stale.nr, NULL);
>  		free(delete_refs);
>  	}
>  
> diff --git a/refs.h b/refs.h
> index 1b236f7..db463d0 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -162,7 +162,8 @@ extern void rollback_packed_refs(void);
>   */
>  int pack_refs(unsigned int flags);
>  
> -extern int repack_without_refs(const char **refnames, int n);
> +extern int repack_without_refs(const char **refnames, int n,
> +			       struct strbuf *err);
>  
>  extern int ref_exists(const char *);

How does this related to v16?  The reason I ask is because even
though v16 0/48 says it is to be applied on 'next' it won't at least
for me X-< and this is one of the early places where the patches
fail to apply without adjustment.
