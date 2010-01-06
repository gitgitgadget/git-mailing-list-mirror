From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] t5541-http-push.sh: add test for unmatched,
 non-fast-forwarded refs
Date: Tue, 05 Jan 2010 17:04:31 -0800
Message-ID: <7viqbgoxgg.fsf@alter.siamese.dyndns.org>
References: <20091224154057.33611ae7.rctay89@gmail.com>
 <20091224154005.a642c8ec.rctay89@gmail.com>
 <20091224154158.15ba580f.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:04:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSKKR-0006BM-Mj
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 02:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab0AFBEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 20:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755171Ab0AFBEr
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 20:04:47 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab0AFBEq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 20:04:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 35FFC8E24B;
	Tue,  5 Jan 2010 20:04:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=YsbJnB6dVXsDKOdFsFZO6I/dyMA=; b=xWGwJGbHuAr7UBUNuA9Vb+o
	OxZuX78rzsA8rHtVm/8Xy3Ky6MtlEoeRolFNMIxzCRtLbAuhX5r6U4wbkw908fkl
	coThma7oDqZArXX4LfGdsjd5Y5YRec8FbZIJxGfb10/BJzF4ZxsjVdHGUxbcYjqA
	/KEjYY62d2NwhEpfSsL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=yNyMZHqoTK4RElBhgSoBYrzMBuh36Y9wVrQ0Rgi5ZlK8msk7R
	OSJh5xYVu84ldN2dPRVhDIUTNe3w1FwyMloDLuhFJmT9GfA04lnJ5m/kFz3bupSy
	yEi/bNSVKgF2w8PtoevJiUp4hXNvv46rYhpTExnM2dpsjx1Xpo7w2HGXJE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AFD0F8E24A;
	Tue,  5 Jan 2010 20:04:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FDE28E246; Tue,  5 Jan
 2010 20:04:32 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7738D270-FA5F-11DE-976F-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136227>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Test that when non-fast-forwarded refs cannot be matched without an
> explicit refspect, the push fails with a non-fast-forward ref status and
> help message.
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  t/t5541-http-push.sh |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
> index f49c7c4..5ebe04a 100755
> --- a/t/t5541-http-push.sh
> +++ b/t/t5541-http-push.sh
> @@ -111,5 +111,25 @@ Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
>  section of '"'git push --help'"' for details." output
>  '
>
> +test_expect_failure 'push fails for non-fast-forward refs unmatched by remote helper' '
> +	# create a dissimilarly-named ref so that git is unable to match the refs
> +	git push origin master:retsam
> +
> +	echo "change changed" > path2 &&
> +	git commit -a -m path2 --amend &&
> +
> +	# push master too. This ensures there is at least one '"'push'"' command to
> +	# the remote helper and triggers interaction with the helper.
> +	!(git push -v origin +master master:retsam >output 2>&1) &&

A dumb question.  Why is this done in a sub-shell?

> +
> +	grep "^ + [a-z0-9]\+\.\.\.[a-z0-9]\+[ ]*master -> master (forced update)$" output &&
> +	grep "^ ! \[rejected\][ ]*master -> retsam (non-fast-forward)$" output &&

[a-z0-9] seems too broad to catch hexadecimal.  "\+" to introduce ERE
elements to grep that expects BRE is a GNU extension, IIRC.  You could use
egrep if you really want to say one-or-more, but I think in this case it
is better to simply replace it with a zero-or-more '*'.  Why is a single
SP made into character class with "[ ]" pair?

> +
> +	grep \
> +"To prevent you from losing history, non-fast-forward updates were rejected
> +Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
> +section of '"'git push --help'"' for details." output
> +'
> +
>  stop_httpd
>  test_done
> --
> 1.6.6.rc1.249.g048b3
