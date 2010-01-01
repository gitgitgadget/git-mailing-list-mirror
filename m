From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 3/4] reset: add a few tests for "git reset --merge"
Date: Thu, 31 Dec 2009 21:15:48 -0800
Message-ID: <7v7hs2o16j.fsf@alter.siamese.dyndns.org>
References: <20091230055008.4475.95755.chriscool@tuxfamily.org>
 <20091230055448.4475.42383.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jan 01 06:16:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQZs1-00019b-7r
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 06:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab0AAFQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 00:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271Ab0AAFQN
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 00:16:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41054 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab0AAFQN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 00:16:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 79C2B8CCBC;
	Fri,  1 Jan 2010 00:16:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=V3ijR4/Ob5k6QKrxy8E7qOJ2YOs=; b=qg/s1ReokcfjYOHJJM8Kyf2
	bxfx4C+1iXADqew7NyRNfVrCUHfa1Yo+CrXpZ/lTChhLW33RVsTtb9z9KrOSAXHS
	YhwEokXEMdEjWzRvxTtz+aRcxwN9IBCtYpEHonqLVKqdj1PfF2MQExiMkQSrxbT2
	S6L1pHqh8zaahiJdchLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=loigkDUH4Nc/P0D/BN7qR871bqGv9ne6GLSk+lQFdW7MPniHU
	ZdD7WAD2Cd+ZEn42q+/BbLSq8oT0FyumuOgzkLlHWRCnvaE4yVSf5M+dkJcI4dyB
	bo6ndWWNO4HRa8KGnmMcI1IMN3EzKfb1jupPfbJxzdWHv6ekllI2PCCxQU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C42DF8CCBB;
	Fri,  1 Jan 2010 00:16:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 422B48CCB8; Fri,  1 Jan
 2010 00:15:50 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C0C7DE96-F694-11DE-B62C-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136002>

Christian Couder <chriscool@tuxfamily.org> writes:

> Commit 9e8eceab ("Add 'merge' mode to 'git reset'", 2008-12-01),
> added the --merge option to git reset, but there were no test cases
> for it.
>
> This was not a big problem because "git reset" was just forking and
> execing "git read-tree", but this will change in a following patch.
>
> So let's add a few test cases to make sure that there will be no
> regression.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Looks good.

> +# The next test will test the following:
> +#
> +#           working index HEAD target         working index HEAD
> +#           ----------------------------------------------------
> +# file1:     C       C     C    D     --merge  D       D     D
> +# file2:     C       D     D    D     --merge  C       D     D
> +test_expect_success 'reset --merge is ok with changes in file it does not touch' '
> +    git reset --merge HEAD^ &&
> +    ! grep 4 file1 &&
> +    grep 4 file2 &&
> +    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
> +    test -z "$(git diff --cached)"
> +'
> ...
> +# The next test will test the following:
> +#
> +#           working index HEAD target         working index HEAD
> +#           ----------------------------------------------------
> +# file1:     C       C     C    D     --merge  D       D     D
> +# file2:     C       C     D    D     --merge  D       D     D
> +test_expect_success 'reset --merge discards changes added to index (2)' '
> +    git reset --hard second &&
> +    echo "line 4" >> file2 &&
> +    git add file2 &&
> +    git reset --merge HEAD^ &&
> +    ! grep 4 file2 &&
> +    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
> +    test -z "$(git diff)" &&
> +    test -z "$(git diff --cached)"
> +'

These two seem to duplicate the same case for file1; is it necessary?

I am not pointing it out as something that needs to be removed; I am just
puzzled and wondering if there is some interaction between the ways two
paths are handled and the test is trying to check that (which I do not
think is the case).
