From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Fri, 20 Aug 2010 13:46:10 -0700
Message-ID: <7vtymp9fn1.fsf@alter.siamese.dyndns.org>
References: <4C6A1C5B.4030304@workspacewhiz.com>
 <7viq39avay.fsf@alter.siamese.dyndns.org> <20100818233900.GA27531@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Aug 20 22:46:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmYUE-00032t-9c
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 22:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702Ab0HTUqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 16:46:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688Ab0HTUqU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 16:46:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 192A1CFB66;
	Fri, 20 Aug 2010 16:46:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H8PZE+bKOEm3Wi0dj85ngekuyYU=; b=L5sl6O
	1Bv1nsRnTVjCtWLi+XOaK+3ISMlDwqbMv8KFICJ2NjtpKuhWBbOvb5rZ6NFol4nD
	Z1g36zRcqBsXcWw5XfR3psBAA6tMEFORCQCKoXAu9Nd7tcc9l6YtD7t2l91fuVs/
	O5y68d8eLcMveW+MPPo1NjciakFrRxQxobXKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F/CrQ6/DLdKh6uBaPmxVuKkyKxxx1IC3
	pVYuzbLpCL8K95arDvvjPncm9Jmwh5AQ1+0xwkrXXm7Ko9Wbiyo4zY1dKP2h+5Fk
	2VSf6gLMlYIJ23ZVD9V9EnxdCj+DsS9mvnRnBRXTXO5VjesMKeEzCvwADgz58Uxf
	6HhjX+g0V/Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B2ECFB62;
	Fri, 20 Aug 2010 16:46:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B4C4CFB5E; Fri, 20 Aug
 2010 16:46:11 -0400 (EDT)
In-Reply-To: <20100818233900.GA27531@localhost> (Clemens Buchacher's message
 of "Thu\, 19 Aug 2010 01\:39\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F9FF2864-AC9B-11DF-8595-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154080>

Clemens Buchacher <drizzd@aon.at> writes:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 5affb6f..121a6a3 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -389,6 +389,11 @@ static int merge_working_tree(struct checkout_opts *opts,
>  		topts.gently = opts->merge && old->commit;
>  		topts.verbose_update = !opts->quiet;
>  		topts.fn = twoway_merge;
> +		if (overwrite_ignored) {
> +			topts.dir = xcalloc(1, sizeof(*topts.dir));
> +			topts.dir->flags |= DIR_SHOW_IGNORED;
> +			topts.dir->exclude_per_dir = ".gitignore";
> +		}
>  		tree = parse_tree_indirect(old->commit ?
>  					   old->commit->object.sha1 :
>  					   (unsigned char *)EMPTY_TREE_SHA1_BIN);

What is this patch based on?  I don't see a branch that has these two
lines adjacent to each other as the preimage...

>  		topts.fn = twoway_merge;
>  		tree = parse_tree_indirect(old->commit ?
