From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/20] contrib/examples/git-clone.sh: avoid "test <cond> -a/-o <cond>"
Date: Mon, 09 Jun 2014 16:23:58 -0700
Message-ID: <xmqqha3td5v5.fsf@gitster.dls.corp.google.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
	<1402066563-28519-3-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:24:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8vD-0004qv-Eb
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbaFIXYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 19:24:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62884 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051AbaFIXYF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 19:24:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF9C11D439;
	Mon,  9 Jun 2014 19:24:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=+1WedAy1RZ+XK3O5u5sNzDdJ0Sg=; b=COtcCWW4VJ3d/sCL8HVj
	AZxtgk0IBs7IMo8J4HSRwCMJ9JMNbKA02PrTq7S593Ehivje6+OKSgRET1p3WbV/
	9B4Cg96wNMvyj2fgjT93q2vaJwfLysWWW4NMN8aHoT2VWu05HXH3WI96gBQ6sO5G
	3vdmBMsWRMvoJiXXjCbGM7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=k+odM4GdY9KE+57nx6rwrzfBHuVppanCTaD02IgquLEQSi
	9/dKZwVM7CGekO1v8bNdb18DZBr3iY55UV+BR9hJBYiQuUpOzcYMmwLx3cqKJSs9
	ANc3+3tokTW5dEjQ8Wb6/K0TKEtLYjBZIoE4sTOnj6P+ZU74cQUgPYQ/cAOVY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B6A781D438;
	Mon,  9 Jun 2014 19:24:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 415F41D434;
	Mon,  9 Jun 2014 19:24:00 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 23023A34-F02D-11E3-9055-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251142>

Elia Pinto <gitter.spiros@gmail.com> writes:

> The construct is error-prone; "test" being built-in in most modern
> shells, the reason to avoid "test <cond> && test <cond>" spawning
> one extra process by using a single "test <cond> -a <cond>" no
> longer exists.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  contrib/examples/git-clone.sh |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/examples/git-clone.sh b/contrib/examples/git-clone.sh
> index b4c9376..08cf246 100755
> --- a/contrib/examples/git-clone.sh
> +++ b/contrib/examples/git-clone.sh
> @@ -516,7 +516,7 @@ then
>  
>  	case "$no_checkout" in
>  	'')
> -		test "z$quiet" = z -a "z$no_progress" = z && v=-v || v=
> +		test "z$quiet" = z && test "z$no_progress" = z && v=-v || v=
>  		git read-tree -m -u $v HEAD HEAD
>  	esac
>  fi

Hmph.  If we want to see them both empty, 

	test "$quiet,$no_progress" = ,

would have been a better way to spell this, but that is outside the
scope of this series.

But I wonder if we really want to update the contrib/examples/,
which is a record of how historically we have implemented various
scripted Porcelains using lower level plumbing commands.
