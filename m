From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] receive-pack: ignore duplicated commands which can
 occur with symrefs
Date: Thu, 15 Apr 2010 15:57:06 -0700
Message-ID: <7v39ywiat9.fsf@alter.siamese.dyndns.org>
References: <1271364848-32805-1-git-send-email-jaysoffian@gmail.com>
 <1271364848-32805-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 00:57:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Xzu-0006vY-0v
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 00:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757889Ab0DOW5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 18:57:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757820Ab0DOW5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 18:57:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3CF2ABEF3;
	Thu, 15 Apr 2010 18:57:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kXnkurAC4SWlPGxtXpWa7urru8Y=; b=bh65dN
	+/HjwP4yGOSNjEuAbE6RsTXDJEqoC9eAJwduTTT9lGpauLaPvj2iR9sTgCbDPzYn
	wYm/crFz925RKMQQtOPnkmq6pr42ZnWbLogugNrOYq22XB7ByWRErn3f1SwNKaa0
	s/Wq/FhBVi2uVVXXu0c6LqL+Ao2bjW8mxpx0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p1xqzeR2BBgYPfHqkL6tjgkWSug05sQB
	WG1yTM1+2NqGFy/mb7oPCcmx8MFK/TkIMR++F8PNA5xT9h1Qlz6ntcw4A87gCONr
	h/sqSNbBGWWDPEuCygo38ReGSrvgrD++IvdCK88REPYKjyJnHE3bPCAUrXQi2fnD
	Fh7KWEoHl4o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 91A0AABEF1;
	Thu, 15 Apr 2010 18:57:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A692EABEF0; Thu, 15 Apr
 2010 18:57:07 -0400 (EDT)
In-Reply-To: <1271364848-32805-2-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Thu\, 15 Apr 2010 16\:54\:08 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39E75E92-48E2-11DF-BF94-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145032>

Jay Soffian <jaysoffian@gmail.com> writes:

> When pushing to a remote repo, normally the sending side tries to
> filter out any aliased updates (e.g, foo:baz bar:baz). However, it
> is impossible for the sender to know if two refs are aliased on the
> receiving side via symrefs. Here is one such scenario:
>
> $ git init origin

Indent this line a bit.

> (cd origin && touch file && git add file && git commit -a -m intial)
> git clone --bare origin origin.git
> rm -rf origin
>
> git clone origin.git client
>
> git clone --mirror client backup.git &&
> (cd backup.git && git remote set-head origin --auto)
>
> (cd client &&
> 	git remote add --mirror backup ../backup.git &&
> 	echo change1 > file && git commit -a -m change1 &&
> 	git push origin &&
> 	git push backup
> )

Consistently use prompt and indent these to match the first "init".

>
> The push to backup fails with:
>
> Counting objects: 5, done.
> Writing objects: 100% (3/3), 244 bytes, done.
> Total 3 (delta 0), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> error: Ref refs/remotes/origin/master is at ef307ff6d0026900f84bae7bfe2f5d695238ca66 but expected 262cd5762e76e0aca2c185a3995095318772e2f2

Indent this as well, and trim the object names as the exact values do not
matter.

> remote: error: failed to lock refs/remotes/origin/master
> To ../backup.git
>    262cd57..ef307ff  master -> master
>    262cd57..ef307ff  origin/HEAD -> origin/HEAD
>  ! [remote rejected] origin/master -> origin/master (failed to lock)
> error: failed to push some refs to '../backup.git'

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 3fc73cf..a2e3bc8 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -9,6 +9,7 @@
>  #include "object.h"
>  #include "remote.h"
>  #include "transport.h"
> +#include "string-list.h"
>  
>  static const char receive_pack_usage[] = "git receive-pack <git-dir>";
>  
> @@ -486,10 +487,30 @@ static void run_update_post_hook(struct command *commands)
>  	}
>  }
>  
> +static int aliased_ref(struct command *cmd, struct string_list *list)
> +{

Nit; what this does sounds more like "aliased update" to me.

> +	struct string_list_item *item;
> +	unsigned char sha1[20];
> +	int flag;
> +
> +	const char *dst_name = resolve_ref(cmd->ref_name, sha1, 0, &flag);
> +
> +	if (!(flag & REF_ISSYMREF))
> +		return 0;
> +
> +	if ((item = string_list_lookup(dst_name, list)) != NULL) {
> +		struct command *other_cmd = (struct command *) item->util;
> +		return (!(hashcmp(cmd->old_sha1, other_cmd->old_sha1) &&
> +			hashcmp(cmd->new_sha1, other_cmd->new_sha1)));

This will also catch two symrefs that point at the same underlying ref.
If all three are updated consistently then all will be fine.  If even one
of them is inconsistent, we will try the update() and give an error
message.

We _could_ give even stronger error message to help diagnosing the
situation if we wanted to.

Very nice.
