From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "completion: fix shell expansion of items"
Date: Tue, 25 Sep 2012 16:28:20 -0700
Message-ID: <7vfw65vg17.fsf@alter.siamese.dyndns.org>
References: <1348107315-25095-1-git-send-email-felipe.contreras@gmail.com>
 <20120920014608.GA27782@sigill.intra.peff.net>
 <20120920181152.GA4689@goldbirke>
 <20120925043119.GA6208@sigill.intra.peff.net>
 <20120925223725.GA12658@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 01:28:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGeYM-0007tF-Ax
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 01:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467Ab2IYX2X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2012 19:28:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732Ab2IYX2W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Sep 2012 19:28:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 265BA8265;
	Tue, 25 Sep 2012 19:28:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rPhrnSjdZ+jE
	yYp+1GaH0eqkmCE=; b=w9i7eAsLzpZVF6Oay1gylDpiPK7aC1/C/LIuJ5Zvp2ae
	gvMnRc5J4z54k/aXj4ctbEv8dUdadoF3bz5jce24Za1DOnQuYnEWNIJ1Ga281x8N
	JelK4Wpmh9/b7cLqS9+r5CKYUc193b62VKwUEUuPon2f1yjUXQZ02iW29/tskY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YLjeuf
	9AARGD5j/4qSfMXz8MsUvP5KKqbUbVzOlah3dI5dShwPiz3HWkxtTnC0glUXWTev
	LIDR/3DvB7Z2KUb4dbzQuF1EDuMMFg330dS4u2bWSisRYzuewtJc/vYJB3JgYOKk
	ej/Rvr5IrJ0COLSstCDs8D1XQOfxg3YHzkS1o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1416C8264;
	Tue, 25 Sep 2012 19:28:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E3078259; Tue, 25 Sep 2012
 19:28:21 -0400 (EDT)
In-Reply-To: <20120925223725.GA12658@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of "Wed, 26 Sep 2012 00:37:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1BEB95A-0768-11E2-B130-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206385>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Tue, Sep 25, 2012 at 12:31:19AM -0400, Jeff King wrote:
>> Yeah, doing "git checkout jk/<tab>" is not working at all, and I not=
iced
>> the buggy commit is on the maint track, but has not yet been release=
d.
>> I'm not sure of the solution, but I think we should do this in the
>> meantime:
>>=20
>> -- >8 --
>> Subject: Revert "completion: fix shell expansion of items"
>
> I agree with the revert, too.
>
> I looked into this issue, but quickly got lost in quoting-escaping
> hell.  Ideally we could do some quoting in __gitcomp_nl(), so it woul=
d
> work for all kinds of input, but I couldn't come up with anything
> working.  Alternatively, we could modify __gitcomp_nl()'s callers, or
> rather the helper functions supplying input to __gitcomp_nl() to do
> the quoting or escaping themselves.  Actually, that's quite easy for
> local refs, at least, because for-each-ref's builtin quoting support
> does the trick:
>
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index c48cd19f..3dc1ec8c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -313,7 +313,7 @@ __git_refs ()
>  			refs=3D"refs/tags refs/heads refs/remotes"
>  			;;
>  		esac
> -		git --git-dir=3D"$dir" for-each-ref --format=3D"%($format)" \
> +		git --git-dir=3D"$dir" for-each-ref --shell --format=3D"%($format)=
" \
>  			$refs
>  		if [ -n "$track" ]; then
>  			# employ the heuristic used by git checkout
>
> With this change completion of local refs works well, even in the
> presence of branches ${foo.bar} and foo'bar.
>
> Unfortunately, there are many callsites for __gitcomp_nl(), and it is
> invoked with refs from remote repos, heads, tags, refspecs, remotes,
> config variables, symbols from ctags, or output from stash or
> ls-tree...  although some of these are OK as they are now (remotes,
> config variables).

Whatever you do, please make the first step of that endeavour an
addition to the t/t9902 to prevent the same breakage from happening
again.

Thanks.
