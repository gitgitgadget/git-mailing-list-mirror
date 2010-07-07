From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/6] Add additional testcases for D/F conflicts
Date: Wed, 07 Jul 2010 14:25:50 -0700
Message-ID: <7vocejt25d.fsf@alter.siamese.dyndns.org>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
 <1278480034-22939-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, agladysh@gmail.com
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 07 23:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWc8B-0002d4-NC
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 23:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958Ab0GGV0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 17:26:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756437Ab0GGV0E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 17:26:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CDEAC2D83;
	Wed,  7 Jul 2010 17:26:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=CW9Pg9PCSS2K/2F/MZ878xELU34=; b=NJfr0a8DIVB/m68HGefZrTo
	Gdt1cVANLBqjV5EbHO8Pf1ATNxWrjtO/M/lqsbFtZ/9WaAMvXShJcVijYWyH+jKe
	st8KTekf7UAsTFaZ13Kh9ZHpKVSAUTGsaF5A8xz3/1wwZaaqTI6yHDQE+ymGgivi
	XYDBT9tbciqcnP8ddMwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=iY5KTwDSSXD0y4v5uV5WAgP6s0pyd38g0no69DRqdHTi+GPIV
	HgiCdL6onaQBeE1kSntoauS603j67qP5Jy7XqCm6oY4xl3cjtjvv4dy690ShiqJ4
	G3Ql9mUw2MleU7r6xf7FqO4TV3If12lyGShl9HokKBWz5uCcyi0cNA/1Us=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BD81CC2D7E;
	Wed,  7 Jul 2010 17:25:57 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 329D6C2D72; Wed,  7 Jul
 2010 17:25:52 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3B8A2172-8A0E-11DF-B96E-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150506>

newren@gmail.com writes:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6035-merge-dir-to-symlink.sh |   37 +++++++++++++++++++++++++++++++++++--
>  t/t9350-fast-export.sh          |   24 ++++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 2 deletions(-)
>
> diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
> index 3202e1d..3c176d7 100755
> --- a/t/t6035-merge-dir-to-symlink.sh
> +++ b/t/t6035-merge-dir-to-symlink.sh
> @@ -56,7 +56,7 @@ test_expect_success 'do not lose a/b-2/c/d in merge (resolve)' '
>  	test -f a/b-2/c/d
>  '
>  
> -test_expect_failure 'do not lose a/b-2/c/d in merge (recursive)' '
> +test_expect_failure 'Handle D/F conflict, do not lose a/b-2/c/d in merge (recursive)' '

If you retitle this, you would probably want to retitle the corresponding
test for resolve (the one before this test) the same way.

> +test_expect_failure 'Handle F/D conflict, do not lose a/b-2/c/d in merge (recursive)' '
> +	git reset --hard &&
> +	git checkout master &&
> +	git merge -s recursive baseline^0 &&
> +	test -h a/b &&
> +	test -f a/b-2/c/d
> +'

It may be a good idea to see what resolve does for all these new
tests.

You would not want to do the above test while "master" branch is checked
out.  Once this is fixed, the commit subsequent tests refer to as "master"
will be a different one, and that affects their outcome in a big way.
Avoid unnecessarily making tests depend on earlier ones.

> +test_expect_failure 'Handle F/D conflict, do not lose a/b-2/c/d in merge (recursive)' '
> +	git reset --hard &&
> +	git checkout master &&

Likewise.

> +	git merge -s recursive baseline^0 &&
> +	test -h a/b &&
> +	test -f a/b-2/c/d
> +'
> +
> +test_expect_success 'do not lose untracked in merge (recursive)' '
> +	git reset --hard &&
> +	git checkout baseline^0 &&
> +	touch a/b/c/e &&
> +	test_must_fail git merge -s recursive master &&
> +	test -f a/b/c/e &&
> +	test -f a/b-2/c/d
> +'

I suspect resolve may fail this one, but as you don't have a test for it, we
won't know...

> +test_expect_success 'do not lose modifications in merge (recursive)' '
> +	git add --all &&
> +	git reset --hard &&
> +	git checkout baseline^0 &&
> +	echo more content >> a/b/c/d &&
> +	test_must_fail git merge -s recursive master
> +'
> +
>  test_expect_success 'setup a merge where dir a/b-2 changed to symlink' '
>  	git reset --hard &&
>  	git checkout start^0 &&

> @@ -82,7 +107,7 @@ test_expect_success 'merge should not have conflicts (resolve)' '
>  	test -f a/b/c/d
>  '
>  
> -test_expect_failure 'merge should not have conflicts (recursive)' '
> +test_expect_failure 'merge should not have D/F conflicts (recursive)' '

The same comment on retitling applies here.
