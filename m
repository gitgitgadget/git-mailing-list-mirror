From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1300: document some aesthetic failures of the config
 editor
Date: Fri, 29 Mar 2013 11:51:51 -0700
Message-ID: <7vobe2nins.fsf@alter.siamese.dyndns.org>
References: <CAD7mMPW=jr6PaAc50h-Wpf42-UPrn0A5KmisqXNXqqLv78AEgg@mail.gmail.com>
 <20130329170032.GA3552@sigill.intra.peff.net>
 <87ip4ayvfn.fsf@linux-k42r.v.cablecom.net>
 <20130329172307.GA11099@sigill.intra.peff.net>
 <20130329175058.GA13506@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Phil Haack <haacked@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 19:52:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULePX-0000fj-Fm
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 19:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756802Ab3C2Svz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 14:51:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59471 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756482Ab3C2Svy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 14:51:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6FE9E884;
	Fri, 29 Mar 2013 18:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uAhgDlMgfW+yDxykP5w9+kKUvNU=; b=dmzlgD
	hWgdbVLW+LJH7YjuwoMBD9W35jdqqCHbFKEgW6wEuRs54bYbvjbMKHvhnUb2U5lO
	g5KdutWsJRi+k0a9cK0riwffAcOQN4dLWUFGtDuTYEUUN75jScvtkq6vEgWTje5S
	4Yf6mr7RRRkFs4txnwMHdaBbqJqjD1/eQTgk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qDBSAY4qBGJ2moC/fIvdPhY9o6eOivgg
	iu7CsKPFoUfuho75bhqzN+yrGgMN8sTp6sbUaDa2IBRlApt5hdM0oqiKrCWK19oV
	n5lPmWZdBK3yUlvdanLEejkEhokipyyDcCi2dLiUztjdJ8FmWlmLZiYl1GlxNlsi
	vLTU99boTYQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5DE7E883;
	Fri, 29 Mar 2013 18:51:53 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43409E87E; Fri, 29 Mar 2013
 18:51:53 +0000 (UTC)
In-Reply-To: <20130329175058.GA13506@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 29 Mar 2013 13:50:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8D7F4A2-98A1-11E2-81EA-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219521>

Jeff King <peff@peff.net> writes:

> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 3c96fda..d62facb 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -1087,4 +1087,36 @@ test_expect_success 'barf on incomplete string' '
>  	grep " line 3 " error
>  '
>  
> +# good section hygiene
> +test_expect_failure 'unsetting the last key in a section removes header' '
> +	cat >.git/config <<-\EOF &&
> +	[section]
> +	# some intervening lines
> +	# that should be saved
> +	key = value
> +	EOF
> +
> +	cat >expect <<-\EOF &&
> +	# some intervening lines
> +	# that should be saved
> +	EOF

I do not know if I agree with this expectation.

Most likely these comments are about the section, and possibly even
are specific to section.key, not applicable to the section in
general).  If we _were_ to remove the section header at this point,
we should be removing the comment two out of three cases (if it is
about section.key, it should go when section.key goes; if it is
about section, it should go when section goes; if it is a more
generic comment about this configuration file, it should stay).

A better approach may be to only insist on the "when adding, reuse
an empty section header" side of the coin.  Then we do not have to
worry about "we keep cruft that talks about some section but what
the comment says is illegible now the crucial bit of information,
section name the comment talks about, is gone".

> +
> +	git config --unset section.key &&
> +	test_cmp expect .git/config
> +'
> +
> +test_expect_failure 'adding a key into an empty section reuses header' '
> +	cat >.git/config <<-\EOF &&
> +	[section]
> +	EOF
> +
> +	q_to_tab >expect <<-\EOF &&
> +	[section]
> +	Qkey = value
> +	EOF
> +
> +	git config section.key value
> +	test_cmp expect .git/config
> +'

This side I would agree it is unconditionally a good thing to do.
