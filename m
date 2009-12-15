From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git on QNX
Date: Tue, 15 Dec 2009 13:42:57 -0800
Message-ID: <7v6387zzfi.fsf@alter.siamese.dyndns.org>
References: <905315640912151323s4b158565o2e74ce018b64dc72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, mkraai@beckman.com
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 22:43:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKfAr-0001p2-HZ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 22:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757074AbZLOVnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 16:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756684AbZLOVnM
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 16:43:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756587AbZLOVnL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 16:43:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AA9B785A40;
	Tue, 15 Dec 2009 16:43:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uZg/wzbrKDJqh6fX7JlHrD38srg=; b=BaBqRO
	37Smq1xR+0Dk2eONr5SxSNn2o1ucLLZoMv9J9DoGadbZ977zGP6b5fFp2Wm+M5G3
	qdabY2ueWgW/gXpi1Hti4HesLSxGaDecNcnrlwInN6p9LIPHjH8kKVeKgLHMk0K0
	3DqSoq6GUczjd0DQsmEZjcUOaQHkMV6ruBaLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fpEN0cUl/a6J40R9KK64h1qRUzuHBMok
	XKICfWEyfCMPSwvXwTdqhS1XkXKCwmGR8Zt/sqldcISnrfi+SIh+3k6QOOspPRrq
	hF2/RTmQ844wdWi4Ptszn1/nSlinrGUyL3XxpJ0n4pKbNf9nd4XolfUMibnLzR3v
	rl7kXCw+l0c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 31E5C85A3F;
	Tue, 15 Dec 2009 16:43:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1ED1D85A3E; Tue, 15 Dec
 2009 16:42:58 -0500 (EST)
In-Reply-To: <905315640912151323s4b158565o2e74ce018b64dc72@mail.gmail.com>
 (Tarmigan's message of "Tue\, 15 Dec 2009 13\:23\:37 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D278CA62-E9C2-11DE-A95A-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135302>

Tarmigan <tarmigan+git@gmail.com> writes:

> diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
> index 8ed4a6f..5cbc16c 100644
> --- a/builtin-fetch-pack.c
> +++ b/builtin-fetch-pack.c
> @@ -778,7 +778,7 @@ static int fetch_pack_config(const char *var,
> const char *value, void *cb)
>  	return git_default_config(var, value, cb);
>  }
>
> -static struct lock_file lock;
> +static struct lock_file lockfile;
>
>  static void fetch_pack_setup(void)
>  {
> @@ -958,14 +958,14 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
>  			  )
>  			die("shallow file was changed during fetch");
>
> -		fd = hold_lock_file_for_update(&lock, shallow,
> +		fd = hold_lock_file_for_update(&lockfile, shallow,
>  					       LOCK_DIE_ON_ERROR);
>  		if (!write_shallow_commits(&sb, 0)
>  		 || write_in_full(fd, sb.buf, sb.len) != sb.len) {
>  			unlink_or_warn(shallow);
> -			rollback_lock_file(&lock);
> +			rollback_lock_file(&lockfile);
>  		} else {
> -			commit_lock_file(&lock);
> +			commit_lock_file(&lockfile);
>  		}
>  		strbuf_release(&sb);
>  	}

Is this because QNX uses "lock" as some global identifier for some other
purpose?  I think moving the file-scope-static definition to the scope
it is used in without renaming would make a cleaner patch.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5c59687..857e938 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -79,6 +84,7 @@
>  #include <stdlib.h>
>  #include <stdarg.h>
>  #include <string.h>
> +#include <strings.h>
>  #include <errno.h>
>  #include <limits.h>
>  #include <sys/param.h>

Other hunks are QNX specific enough but this hunk is worrisome; you cannot
tell how you are hurting other platforms with this change.  Can you tell
declarations of which functions are missing on QNX without this change?
