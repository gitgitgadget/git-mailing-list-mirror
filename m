From: Todd Zullinger <tmz@pobox.com>
Subject: Re: Git fails to detect subcommand when hook is symlinked to a
 builtin
Date: Fri, 18 Mar 2011 21:14:45 -0400
Message-ID: <20110319011445.GL26236@inocybe.localdomain>
References: <20110318151415.GC26236@inocybe.localdomain>
 <7vhbb0rkv4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="M9Kk/RdPrqDAodVL"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:15:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0kl6-0008Ta-D0
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 02:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570Ab1CSBOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 21:14:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755534Ab1CSBOw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 21:14:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8455A3C45;
	Fri, 18 Mar 2011 21:14:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=6vgIR2EuaBkNs7sakxG29+fZPaM=; b=hrZbjZa
	rOmtRGLaILTsJWmFE00bnjXxYES7tfg4jhXQBXWeH0F5Vqdj3k71j21VR4cgOtQE
	4RUJJPVZM1qJW7mDh8EnR+ihCd8DIMblHqYYOi7edAG5Sm84dtOaeeM5mUGv9Zug
	/hQ+72a14ExHkRBl9wsVwXtrA5oeTrgGj6II=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=RYxkD5lkiONClVX4OJWgsddnEC0uoTpRa
	0fNjG+p13lYjao1rdWz7Q7qhwa9Z84mhojmBPJmhlV9vmcipGeP09tBAseEOJ3ck
	4hGddDBKXV6mvK0faaF0FXdaV7lshJndYc/DA9TGiI20yFgHP10CqQ1JfZKNCvGo
	HIhsAv2ifA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E2613C44;
	Fri, 18 Mar 2011 21:14:48 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB5BD3C43; Fri, 18 Mar 2011
 21:14:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vhbb0rkv4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Pobox-Relay-ID: 48811978-51C6-11E0-B4D3-C1F4E168B6F2-09356542!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169381>


--M9Kk/RdPrqDAodVL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> I have a suspicion that we may end up saying "don't do that", but
> let's ponder a bit with some technical background first.  The "git"
> wrapper and builtin commands are all the same binary, and as a
> consequence, their main() function needs to decide what to do based
> on argv[0].  If argv[0] is "git", we know argv[1] is the name of the
> subcommand, and if argv[0] is "git-foo", it might be the internal
> call from the "git" wrapper that was invoked with argv[] =3D { "git",
> "foo", ... }, but we don't expect that argv[0] to be things like
> "post-update".

I can certainly understand that. :)

> But it is curious why the resulting behaviour changed recently.  The
> symptom hints that the link target (git-update-server-info in your
> case) used to be given as argv[0] (which still wouldn't have been
> kosher---you are not supposed to use dashed form since 1.5.4 or so
> without adding $GIT_EXEC_PATH at the beginning of your $PATH, and
> that is why I said the first sentence in this reply), but we
> recently changed something and now we are getting
> "hooks/post-update" in argv[0].
>
> I suspect the recent change to run hooks via run_command() interface
> has something to do with it.  From what version did you update to
> 1.7.4.1?

I should have mentioned it, but I failed to do so.  Sorry about that.

This was moving from 1.5.5.6 to 1.7.4.1. The packages for EPEL (extra
stuff for RHEL/CentOS) lagged behind for quite some time.  The
fedorahosted.org system was using 1.5.5.6 for a long time with the
symlinked post-update hook in place.  But it's not necessarily
anything that changed recently in git.  It could have been changes all
the way back in 1.6.0, which seems like an eternity in git time.

We already fixed up the repositories on fedorahosted for this, but I
figured I should ask, in case this change was not intended and might
catch other folks doing git hosting.

(The only other minor change that caught us was that some of the repos
did not have core.bare =3D true and pushes to these oddly configured
repositories failed.  Clearly, that was a misconfiguration from the
time the repos were setup.  Otherwise, for moving from 1.5.5.6 to
1.7.4.1, things went quite smoothly.  That's thanks in no small part
to the great attention to detail you and the other folks on this list
have.  Thank you!)

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The United States is a nation of laws, badly written and randomly
enforced.
    -- Frank Zappa


--M9Kk/RdPrqDAodVL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJNhAOFJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjnUsH/A/FZWHA+3ZhT++p1rtmYVW2e/tdb5iXuWGt
Ooxk/MqyDMl851L81Q7oHULedzzrvqhosgt6jVwjffL02lLaaDEg9O1xMOIFd6z9
MEYgahQXJuAtW/pFzaHfXwnnKIeLwyN5OaALHvhBin4ff46GHu0nQ9N1CtQKENEk
XVT3Yaf/KZ/Zi47wbSCGgYIVBuZVm27uJsx2CtxaTTOfPiIIPai12WKNMVJjanYw
H18BoyE4pzHDr+IGJCENDwg1NHvyHLqk8h/4ouMtuv0iSDhIyQAPYq//vqlBifuN
odXfGDUR+x/GAxGuJkml6fwW++Crxz0yacGpdSsAHkdkIc8T6tw=
=SZ/r
-----END PGP SIGNATURE-----

--M9Kk/RdPrqDAodVL--
