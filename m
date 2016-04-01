From: Miklos Vajna <vmiklos@collabora.co.uk>
Subject: Re: Signed-off-by vs Reviewed-by
Date: Fri, 1 Apr 2016 16:10:36 +0200
Message-ID: <20160401141036.GG800@collabora.co.uk>
References: <20160331123507.GC19857@collabora.co.uk>
 <CAFZEwPMzcqrd8NEP6MH5saXL2KdUKAyN51uuoS5=aeU0aPWjJQ@mail.gmail.com>
 <20160331143501.GE19857@collabora.co.uk>
 <xmqqtwjmpq6b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WkfBGePaEyrk4zXB"
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 16:10:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alzmn-0005VZ-CS
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 16:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbcDAOKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 10:10:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50420 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbcDAOKn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 10:10:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: vmiklos)
	with ESMTPSA id CC1FE260BB9
Content-Disposition: inline
In-Reply-To: <xmqqtwjmpq6b.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290538>


--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

On Thu, Mar 31, 2016 at 09:28:44AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> The internal "parse the existing trailer block and manipulate it by
> adding, conditionally adding, replacing and deleting it" logic was
> done as an experimental "interpret-trailers" program, but polishing
> it (both its design and implementation) and integrating it to the
> front-line programs (e.g. "git commit") hasn't been done.

I had a look at interpret-trailers, and one use-case I miss is: being
able to define a trailer type, but only add it when asked explicitly.

Example:

----
$ git config trailer.review.key "Reviewed-by: "
$ git config trailer.review.command 'echo "$(git config user.name) <$(git config user.email)>"'
$ echo foo|git interpret-trailers
foo

Reviewed-by: A U Thor <author@example.com>
$ echo foo|git interpret-trailers --trailer review
foo

Reviewed-by: A U Thor <author@example.com>
----

I can imagine e.g. a new configuration vaulue named
trailer.<token>.ifMissing explicit, and when that's set, the trailer
would be only added if it's spelled out explicitly using '--trailer
<token>'.

Does this sound like a good idea, or did I miss some way how this is
already possible? :-)

> As to the last step of "integration", we cannot use short-and-sweet
> single letter options like '-s' (for sign-off) for each and every
> custom trailer different projects use for their own purpose (as
> there are only 26 of the lowercase ASCII alphabet letters), so the
> most general syntax for the option has to become "--trailer <arg>"
> or some variation of it, and at that point "-s" would look like a
> short-hand for "--trailer signed-off-by".

Hmm, I think the above has to be implemented first, otherwise it'll be
hard to make "-s" an alias of "--trailer signed-off-by". (I mean having
git understand what "signed-off-by" is, still adding it conditionally.)

Regards,

Miklos

--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlb+gVsACgkQe81tAgORUJbOSQCeMSuOf/JWvAXzQQx+9d9cbcdG
+AIAn0of8Id6+oH/UAIvzi/KISyEEK0c
=lyAb
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--
