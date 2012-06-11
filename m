From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv10 4/4] status: better advices when splitting a commit
 (during rebase -i)
Date: Mon, 11 Jun 2012 13:21:46 -0700
Message-ID: <7vsje161lx.fsf@alter.siamese.dyndns.org>
References: <1339075029-27109-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339327058-29371-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339327058-29371-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 11 22:21:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeB7Z-0007xa-St
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 22:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab2FKUVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 16:21:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61123 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab2FKUVt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 16:21:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C7B783C9;
	Mon, 11 Jun 2012 16:21:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dNHcpxC8/LvrzpolBANXqsexu4Y=; b=a/PYln
	Z0Fs1jT+gpcFzuHw/qvfNveFeAaPy0pSMMkTWONmE5NZSnQccuQlGE4VtQVRtReA
	XRJoZ/7sqpSFVA0n4+YJW+r2zYusdSRCdq+p4Uk4bthCDcA55hdu/+6Ei79CgKhN
	tvH53I89iqn80giFY4xfCDk4tCAH/lgk6YWHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xfyQ/jWlTzHeUTH4r7C0ROyvSE+V0XKk
	k5Wrf06oX0Hu+JFgrriI/Smmv/oUXgDoN/A1OGH+FKZLYIOT5w0DHeNd45+OOcVK
	RHTDpOMWFh79QKNnW8a0jBDbiXazajalVpi/jQKdtWAWr9ybS/yiBg7T3oSFTPMu
	GyemNqgodqI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8244183C8;
	Mon, 11 Jun 2012 16:21:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F31D483C6; Mon, 11 Jun 2012
 16:21:47 -0400 (EDT)
In-Reply-To: <1339327058-29371-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Lucien Kong's message of "Sun, 10 Jun 2012 13:17:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 122419AC-B403-11E1-B92B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199717>

Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:

> Add new informative help messages at the output of 'git status' when
> the user is splitting a commit. The code figures this state by
> comparing the contents of the following files in the .git/ directory:
> 	  - HEAD
> 	  - ORIG_HEAD
> 	  - rebase-merge/amend
> 	  - rebase-merge/orig-head

It may be just me but I would find it easier to read if you had a
blank line before this four-item enumerated list.

> diff --git a/wt-status.c b/wt-status.c
> index fcde045..5496a1f 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -12,6 +12,7 @@
>  #include "refs.h"
>  #include "submodule.h"
>  #include "column.h"
> +#include "strbuf.h"
>  
>  static char default_wt_status_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
> @@ -817,6 +818,51 @@ static void show_am_in_progress(struct wt_status *s,
>  	wt_status_print_trailer(s);
>  }
>  
> +static char *read_line_from_git_path(const char *filename)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	FILE *fp = fopen(git_path("%s", filename), "r");
> +	if (!fp) {
> +		strbuf_release(&buf);
> +		return NULL;
> +	}
> +	strbuf_getline(&buf, fp, '\n');
> +	if (!fclose(fp)) {
> +		return strbuf_detach(&buf, NULL);
> +	} else {
> +		strbuf_release(&buf);
> +		return NULL;
> +	}
> +}

With this code, read_line_from_git_path("HEAD") will read:

	[0-9a-f]{40} when the HEAD is detached;

        ref: refs/heads/<current-branch-name> when textual symref is
        in use (and you are on the branch); or

	[0-9a-f]{40} stored in refs/heads/<current-branch-name> when
	symlink symref is in use (and you are on the branch).

> +static int split_commit_in_progress(struct wt_status *s)
> +{
> +	int split_in_progress = 0;
> +	char *head = read_line_from_git_path("HEAD");
> +	char *orig_head = read_line_from_git_path("ORIG_HEAD");
> +	char *rebase_amend = read_line_from_git_path("rebase-merge/amend");
> +	char *rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
> +
> +	if (!head || !orig_head || !rebase_amend || !rebase_orig_head || !prefixcmp(head, "ref: "))
> +		return split_in_progress;

I think the above

	!prefixcmp(head, "ref: ")

is probably a mistake; shouldn't it be

	strcmp(s->branch, "HEAD")

which is used in wt_status_print() to diagnose that you are on a
detached HEAD (which is the normal case)?  Otherwise head may point
at the commit object name read from "refs/heads/current" through a
symbolic link .git/HEAD that points at "refs/heads/current".
