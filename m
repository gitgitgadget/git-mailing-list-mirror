From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes_merge_commit(): do not pass temporary buffer to
 other function
Date: Tue, 27 Sep 2011 09:59:30 -0700
Message-ID: <7vd3elyl8t.fsf@alter.siamese.dyndns.org>
References: <1317098813-30839-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 27 18:59:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8b0L-0002tO-Mv
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 18:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900Ab1I0Q7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 12:59:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35298 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821Ab1I0Q7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 12:59:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4829A4923;
	Tue, 27 Sep 2011 12:59:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NXiL9wPlb9tQS4168jdB8K3hVsA=; b=NBL3+2
	9ETsP4VypnBgj9NYj30w53rrgokvlGxpzRS+kuoQxbp0VC5HUXPakK0Ee7vTS2TE
	ohcNgXWQKB1eW2VcvjKWI3ondJ+1fkJEEUnatDPEZTzGOowAqKi9eSaBk39sDL9M
	W4VE2PlvWJWdrSW/Zj/xRQisWtSyXpvD/0/GI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=px9uhFaZCUcj7ZasY3GgZ8u5gscc3YTn
	oNo6NtNgIgrww7o0hoa1Cx5TfXsFldS3nH4JTfG8D42Zz7NPyUOSBYstO6YpijUF
	qfYypjQ7KJjlOKTdVQbJERL6FoovaTF/3ZYveRN+e9xRt9JYE9hNiIK59YY4LQIi
	WXR19u6gpOY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4001B4922;
	Tue, 27 Sep 2011 12:59:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9E1F4921; Tue, 27 Sep 2011
 12:59:31 -0400 (EDT)
In-Reply-To: <1317098813-30839-1-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Tue, 27 Sep 2011 06:46:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11D7DE88-E92A-11E0-AFFC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182252>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I discovered this problem when an innocent modification to unrelated
> code triggered test failures.
>
>  notes-merge.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git notes-merge.c notes-merge.c
> index e1aaf43..baaf31f 100644
> --- notes-merge.c
> +++ notes-merge.c

It is Ok to play with -p0 yourself but please don't do that in the public.

> @@ -680,7 +680,7 @@ int notes_merge_commit(struct notes_merge_options *o,
>  	 * Finally store the new commit object SHA1 into 'result_sha1'.
>  	 */
>  	struct dir_struct dir;
> -	const char *path = git_path(NOTES_MERGE_WORKTREE "/");
> +	char *path = xstrdup(git_path(NOTES_MERGE_WORKTREE "/"));
>  	int path_len = strlen(path), i;
>  	const char *msg = strstr(partial_commit->buffer, "\n\n");
>  
> @@ -720,6 +720,7 @@ int notes_merge_commit(struct notes_merge_options *o,
>  			    result_sha1);
>  	OUTPUT(o, 4, "Finalized notes merge commit: %s",
>  	       sha1_to_hex(result_sha1));
> +	free(path);
>  	return 0;
>  }
