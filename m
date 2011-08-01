From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test ls-files with relative paths
Date: Mon, 01 Aug 2011 13:14:14 -0700
Message-ID: <7vhb60j3e1.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5XJbYT9yczZiVPpeA3mpROuKQdw+-AOJjUmRp4W6M5uzg@mail.gmail.com>
 <b535c21e1becdf8aeeb1d3f8ddaa7f5415830844.1311767679.git.git@drmicha.warpmail.net> <20110729130330.GA31941@toss.lan> <7vipqiknjh.fsf@alter.siamese.dyndns.org> <20110801180320.GA17556@toss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	rrt@sc3d.org, john@szakmeister.net
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Aug 01 22:14:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnysa-0001yb-AF
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 22:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174Ab1HAUOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 16:14:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821Ab1HAUOT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 16:14:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A910D47ED;
	Mon,  1 Aug 2011 16:14:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7aCknNBQOuzhHnFz25KuTqgf/4k=; b=bY+pZy
	KAAabhYmf3LUvyXGf94XnGFbbwu1B0eDs2Ng/zyd76r4Lf+4NIC4/4fZcoWXmzgh
	TpOYlACnLW04tGPErR1Q44QD0hWZss8AOzE9H7+iCzm4Qit+RBENkfTFvKgat8NR
	x89E3jb7ml7xBfFCGrijTPPylLK3vxrUzjZZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fyaEqp6pBD/dTpy1FiLn+0UcgUe5L6ws
	ojoAyJGuhoanvrYGVIflM+inBbRgfUd/ij2G2jmoYY1++a8Ff821xWuhkidIPOtO
	sJH87jejzOTZzgHBY6VulMZ+Wju6Gn3CM1QRCseFRSpYCK4cj8FyhYdnlMwTMSpT
	WsNIhEdXVV8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ED6E47EC;
	Mon,  1 Aug 2011 16:14:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25C9E47EB; Mon,  1 Aug 2011
 16:14:16 -0400 (EDT)
In-Reply-To: <20110801180320.GA17556@toss> (Clemens Buchacher's message of
 "Mon, 1 Aug 2011 20:03:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4B33614-BC7A-11E0-9BDE-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178406>

Clemens Buchacher <drizzd@aon.at> writes:

> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
> On Sun, Jul 31, 2011 at 05:01:22PM -0700, Junio C Hamano wrote:
>> 
>> Sounds sane; tests?
>
> Certainly. I'm not testing partial commit since it uses the same
> codepath as ls-files --error-unmatch anyways.
>
>  t/t3005-ls-files-relative.sh |   74 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 74 insertions(+), 0 deletions(-)
>  create mode 100755 t/t3005-ls-files-relative.sh

Thanks.  This should be a part of the primary patch, not a standalone patch.

> +test_expect_success 'prepare' '
> +	: >never-mind-me &&
> +	git add never-mind-me &&
> +	mkdir top &&
> +	(
> +		cd top &&
> +		mkdir sub &&
> +		x="x xa xbc xdef xghij xklmno" &&
> +		y=$(echo "$x" | tr x y) &&
> +		touch $x &&
> +		touch $y &&

These are not meant to be quoted; good.

> +		cd sub &&
> +		git add ../x*
> +	)
> +'
> +
> +test_expect_success 'ls-files with mixed levels' '
> +	(
> +		cd top/sub &&
> +		f=$(cat <<-EOF
> +		../../never-mind-me
> +		../x
> +		EOF
> +		) &&
> +		echo "$f" >expect &&
> +		git ls-files $f >actual &&

This is a funny way to do this; why not cat the here-document into expect
and feed $(cat expect) to ls-files?  I suspect that it would become easier
to read and certainly less confusing without need on the readers' side to
scratch their heads wondering "does this $f need to be quoted?"  and such.

> +test_expect_success 'ls-files -c' '
> +	(
> +		cd top/sub &&
> +		for f in ../y*
> +		do
> +			echo "error: pathspec ${sq}${f}${sq} did not match any file(s) known to git."

Why not $sq$f$sq?  The above looks harder to read with the braces.

> +		set ../x* &&
> +		IFS="$new_line" && echo "$*" >>expect && unset IFS &&

That's a funny way to say "ls ../x*" isn't it?
