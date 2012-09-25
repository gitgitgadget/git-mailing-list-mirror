From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "completion: fix shell expansion of items"
Date: Tue, 25 Sep 2012 09:03:46 -0700
Message-ID: <7vpq5aw0m5.fsf@alter.siamese.dyndns.org>
References: <1348107315-25095-1-git-send-email-felipe.contreras@gmail.com>
 <20120920014608.GA27782@sigill.intra.peff.net>
 <20120920181152.GA4689@goldbirke>
 <20120925043119.GA6208@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 25 18:04:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGXc8-0008Gq-DJ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 18:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757316Ab2IYQDv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2012 12:03:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277Ab2IYQDu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Sep 2012 12:03:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1023B8AAA;
	Tue, 25 Sep 2012 12:03:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OZjbN40MWjar
	4LNs9dR9Oo7nJuw=; b=oIh8xndC0AEmoNRDk27p72nSFvBe1kGj/QyNGSeIwp77
	FWh0ULwoEcWGmDSeL1rDEeHbrmqrtj8tTi7NGpkXnZgBP8PII4DjyWiqMxqBkqy3
	djMRSYNJTj6tMgF3fU+dsyMLLJ51a7Hc2I9Lrlzw+dGoKc2LsiuNew+VKXr32QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=X6+W8w
	s4DLlTImHmru8E0HUbuK1dxwVdLBKCj5D1AHTAJooznr/o12g5rvzXVHwbf2Mri3
	hFWMpi7yXn/paeG71MR5dbFDUK9UPWVH7rEHMpoVYNl+yGuTFSpSpZkIm9cIcgOO
	YPLRH7D4Bzv2iK+fG3Cag4JKRJGjceyiXg5/Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1B948AA9;
	Tue, 25 Sep 2012 12:03:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5573E8AA7; Tue, 25 Sep 2012
 12:03:48 -0400 (EDT)
In-Reply-To: <20120925043119.GA6208@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 25 Sep 2012 00:31:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97567960-072A-11E2-8844-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206363>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 20, 2012 at 08:11:52PM +0200, SZEDER G=C3=A1bor wrote:
>
> Yeah, doing "git checkout jk/<tab>" is not working at all, and I noti=
ced
> the buggy commit is on the maint track, but has not yet been released=
=2E
> I'm not sure of the solution, but I think we should do this in the
> meantime:

Thanks.  Reverting is the right solution; it will leave a note in
the history why a seemingly simple patch was a bad idea to remind
us.

It is sad that existing test did not cover something fundamental
like this, though.  Anybody who's worked on completion wants to make
the test coverage better?

> -- >8 --
> Subject: Revert "completion: fix shell expansion of items"
>
> This reverts commit 25ae7cfd19c8f21721363c64163cd5d9d1135b20.
>
> That patch does fix expansion of weird variables in some
> simple tests, but it also seems to break other things, like
> expansion of refs by "git checkout".
>
> While we're sorting out the correct solution, we are much
> better with the original bug (people with metacharacters in
> their completions occasionally see an error message) than
> the current bug (ref completion does not work at all).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  contrib/completion/git-completion.bash | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 5a5b5a0..d743e56 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -225,13 +225,6 @@ fi
>  fi
>  fi
> =20
> -# Quotes the argument for shell reuse
> -__git_quote()
> -{
> -	local quoted=3D${1//\'/\'\\\'\'}
> -	printf "'%s'" "$quoted"
> -}
> -
>  # Generates completion reply with compgen, appending a space to poss=
ible
>  # completion words, if necessary.
>  # It accepts 1 to 4 arguments:
> @@ -268,7 +261,7 @@ __gitcomp_nl ()
>  __gitcomp_nl ()
>  {
>  	local IFS=3D$'\n'
> -	COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$(__git_quote "$1=
")" -- "${3-$cur}"))
> +	COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}=
"))
>  }
> =20
>  __git_heads ()
