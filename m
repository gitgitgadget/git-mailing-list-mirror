From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Thu, 06 Oct 2011 00:06:48 -0700
Message-ID: <7v39f638fr.fsf@alter.siamese.dyndns.org>
References: <4E8C6F2F.1070306@6wind.com>
 <7v8voz8hgq.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dyn3kk7SfNZzxjoD-hK9jBQr2igmOqJojeYNHLubtSY=w@mail.gmail.com>
 <7vpqib5ciw.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dysix9fOCuvm5+aU7-AC4wmsxH4-MOX+yhaHEqzeN1cPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 09:06:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBi2i-0001ZQ-P4
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 09:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934414Ab1JFHGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 03:06:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934333Ab1JFHGv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 03:06:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7F99413C;
	Thu,  6 Oct 2011 03:06:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jkYUxIQSntDIAkutAJUTADGiMgg=; b=EgkhM4
	EDWocZNf4nANgalUzyDKXtq+HRrpFXc5/M1gmt8CK5cZDhpvpKREGA+BEvmlHQNZ
	EjIZqHvhXC9BwVCgu1yvMZJrrul4GwXSB37HIRzXnhSySN17Ez9YmYg0JXj9Heia
	acl/51sPSHZRR9Z4sD6QNNeo5la3k2voLs/2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KXT6QNqP4qKBPayTx0Ex3DBo0j7xrTKX
	IjVHXzc+GRUS/GcrPYMZvf+3Il3epGBNQ+cChqAkLtwo1HylC1W6wXPtRL6pI5Bh
	6MyGZGOutQLCgU4/1uzGAN8ro7NR1AOs8KlMuYhe1WOLcVynUNHrfZq0ZMdDumCm
	1sVsdq0zg6U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFDA8413A;
	Thu,  6 Oct 2011 03:06:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F6C44139; Thu,  6 Oct 2011
 03:06:50 -0400 (EDT)
In-Reply-To: <CAG+J_Dysix9fOCuvm5+aU7-AC4wmsxH4-MOX+yhaHEqzeN1cPg@mail.gmail.com> (Jay
 Soffian's message of "Wed, 5 Oct 2011 18:23:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C341289E-EFE9-11E0-ADB0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182931>

Jay Soffian <jaysoffian@gmail.com> writes:

> Something like this?
>
> diff --git i/builtin/revert.c w/builtin/revert.c
> index 3117776c2c..f7fcc88871 100644
> --- i/builtin/revert.c
> +++ w/builtin/revert.c
> @@ -384,6 +384,7 @@ static int do_pick_commit(void)
>  	char *defmsg = NULL;
>  	struct strbuf msgbuf = STRBUF_INIT;
>  	int res;
> +	int record_cherry_pick_head = 0;
>
>  	if (no_commit) {
>  		/*
> @@ -477,7 +478,7 @@ static int do_pick_commit(void)
>  			strbuf_addstr(&msgbuf, ")\n");
>  		}
>  		if (!no_commit)
> -			write_cherry_pick_head();
> +			record_cherry_pick_head = 1;
>  	}
>
>  	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
> @@ -514,6 +515,9 @@ static int do_pick_commit(void)
>  	free_message(&msg);
>  	free(defmsg);
>
> +	if (record_cherry_pick_head)
> +		write_cherry_pick_head();
> +
>  	return res;
>  }

I switched to "maint" to look at this patch in context without the
sequencer complication.

The basic idea to delay writing the file feels sound, but when a conflict
happens, print_advice() runs and tries to clear CHERRY_PICK_HEAD, but you
are then writing the file out much later than that at the end of the
function.

This patch seems to break a few tests. t3404, t3506 and t3507 are among
them.

Also, if you are using the recursive strategy, a cherry-pick that did not
start would die() in do_recursive_merge(), and your hunk at -477,7 to
remove call to write_cherry_head() would be sufficient, but if you are
using another strategy, then try_merge_command() would return with 2 and I
think you would want to skip it for the same reason in that case.
