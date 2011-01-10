From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid unportable nested double- and backquotes in shell
 scripts.
Date: Mon, 10 Jan 2011 10:09:37 -0800
Message-ID: <7vlj2s636m.fsf@alter.siamese.dyndns.org>
References: <20110108090105.GB14536@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 10 19:09:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcMBj-0005nx-J3
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 19:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab1AJSJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 13:09:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab1AJSJp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 13:09:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BCC713F78;
	Mon, 10 Jan 2011 13:10:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NN5xQ1rj++HEXzKbnJXfZDR7uNo=; b=abVkRS
	ZCug8UyUUQ8NQ79tAHrXBwwYicqlRtpapxwDy+kyd0cCefVZNVqxyeLF/iS9/BNj
	EqW9LU+sYVCUagPSjh2BW8x1ByKOrt7AIswYLf1m+mFmGsNEWZvrhvnUbsNLiwyv
	9GC7OSCZy8JeqCBy0HfTxvyOWmeMKHgsDYPho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kB82OnK1FkrDRSUIKYCQfGwOsmupevE7
	+nmQU4g0FGua7CaUAapLQHwbCqc1U2AcIBrlSbRywyorI5z2j0DPg6mdwLhrzSuW
	gBRYt0KxQmaWoOuJsudIYhUJov0NNaDgWms0YYfd1l3JfdorWSZmvGDVXVDW7rZi
	3wvHYP7AQHc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 996C73F74;
	Mon, 10 Jan 2011 13:10:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 888D33F73; Mon, 10 Jan 2011
 13:10:19 -0500 (EST)
In-Reply-To: <20110108090105.GB14536@gmx.de> (Ralf Wildenhues's message of
 "Sat\, 8 Jan 2011 10\:01\:05 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E407E1FE-1CE4-11E0-BADE-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164890>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:

> diff --git a/contrib/examples/git-fetch.sh b/contrib/examples/git-fetch.sh
> index a314273..06caf6b 100755
> --- a/contrib/examples/git-fetch.sh
> +++ b/contrib/examples/git-fetch.sh
> @@ -67,7 +67,7 @@ do
>  		keep='-k -k'
>  		;;
>  	--depth=*)
> -		shallow_depth="--depth=`expr "z$1" : 'z-[^=]*=\(.*\)'`"
> +		shallow_depth=--depth=`expr "z$1" : 'z-[^=]*=\(.*\)'`
>  		;;
>  	--depth)
>  		shift

I do not very much like the idea of updating contrib/examples, one of
whose purposes is to document the historical implementation, to ship a
version that has never been battle tested in the field.

There also seem to be a few more uses of `` (the majority used $() even
back then) that are still left behind.  To make it more useful to serve as
an example (which is the other purpose of contrib/examples), it would make
more sense to update them all at once.

> diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
> index 289fc31..3d2ae3e 100755
> --- a/t/t9107-git-svn-migrate.sh
> +++ b/t/t9107-git-svn-migrate.sh
> @@ -94,7 +94,7 @@ test_expect_success 'migrate --minimize on old inited layout' '
>  		echo "$svnrepo"$path > "$GIT_DIR"/svn/$ref/info/url ) || exit 1;
>  	done &&
>  	git svn migrate --minimize &&
> -	test -z "`git config -l | grep "^svn-remote\.git-svn\."`" &&
> +	! git config -l | grep "^svn-remote\.git-svn\." &&
>  	git config --get-all svn-remote.svn.fetch > fetch.out &&
>  	grep "^trunk:refs/remotes/trunk$" fetch.out &&
>  	grep "^branches/a:refs/remotes/a$" fetch.out &&
