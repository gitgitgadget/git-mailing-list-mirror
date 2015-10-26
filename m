From: Paul Wise <pabs3@bonedaddy.net>
Subject: Re: [PATCH] fetch: only show "Fetching remote" when verbose mode is
 enabled
Date: Mon, 26 Oct 2015 08:04:07 +0800
Message-ID: <1445817847.23160.31.camel@bonedaddy.net>
References: <1445741384-30828-1-git-send-email-pabs3@bonedaddy.net>
	 <xmqqwpuakd9y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-RXh0SKfyTmAMmYFDG1is"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 01:24:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqVaS-0004hy-0J
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 01:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbbJZAYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 20:24:03 -0400
Received: from ns1.bonedaddy.net ([70.91.141.202]:52352 "EHLO
	ns1.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbJZAYC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 20:24:02 -0400
X-Greylist: delayed 1180 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Oct 2015 20:24:02 EDT
Received: from chianamo (localhost [127.0.0.1])
	by ns1.bonedaddy.net (8.14.9/8.14.4) with ESMTP id t9Q04HIf025534;
	Sun, 25 Oct 2015 20:04:18 -0400
In-Reply-To: <xmqqwpuakd9y.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280167>


--=-RXh0SKfyTmAMmYFDG1is
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2015-10-25 at 11:34 -0700, Junio C Hamano wrote:

> I ignored your patch when you sent it the first time the last week,
> due to the same issues I had with this round (see below) and forgot
> about it.

Thanks for the feedback this round.


> I cannot tell if you are trying to say if that is problematic, or if
> you are trying to say if it is a good thing.

It is just a description of the current behaviour when fetching a
single remote and is used as a justification for changing the behaviour
when fetching multiple remotes to match the behaviour when fetching a
single remote, because that suits my myrepos use-case better.

> I cannot tell what "This" refers to.

Replace "This" with "This patch".

> Your earlier sentence was about the behaviour of fetching from one
> remote, e.g. "git fetch this".=C2=A0=C2=A0And this second sentence makes =
it
> sound as if that behaviour has some influence on how verbosely "git
> fetch group" (where 'this' and 'that' are members of 'remotes.group')
> to fetch from multiple remotes behaves.

There is no correlation between the verbosity of fetching one remote
and fetching multiple remotes but I would like them to have the same
verbosity level by default. I would like the default verbosity level to
be to not print anything when nothing was fetched. This is the default
verbosity level for fetching a single remote but not multiple remotes.

> Also (and this is the more important part of my complaint), I cannot
> tell if you are saying that it is *bad* for fetching multiple to be
> just as verbose, or if it is *good*, or what.

I think it is good, as long as they both default to printing nothing
when no commits/tags/etc were fetched.

> If you are fetching from two places, and only one of them has
> something new, you would see

I am not interested in that case, only in the case where multiple
remotes are being fetched and no commits/tags/etc were fetched,
essentially I want to turn this output:

$ git fetch --all
Fetching origin
Fetching mirror

Into this output:

$ git fetch --all

> That does not sound like a valid excuse to change the behaviour of
> the command everybody, not just "myrepos tool" (whatever it is),
> uses.=C2=A0=C2=A0Your explanation does not seem to give us enough informa=
tion
> to answer this question intelligently: shouldn't you be fixing
> myrepos instead, perhaps by making it run 'git fetch' with more
> verbose mode, if it wants to see more information, or running 'git
> fetch' and parsing different parts of its output?

myrepos is a tool for managing multiple repos of different types:

https://myrepos.branchable.com/

It definitely wouldn't be appropriate to add screen scraping and
parsing of different version control systems to myrepos.

myrepos doesn't care about the output of repository tools beyond
whether there was any output or not. myrepos will pass --verbose and
other flags on to git fetch if the user passes --verbose to it.

> Having said all that, this time I read the change and the change
> itself feels 40% sensible, even for those who do not care about
> "myrepos" at all.
All I want is for "Fetching remote" to not be printed when there are no
changes fetched and I haven't used the --verbose option.

I realise now that my patch is actually incorrect in that it also
suppresses=C2=A0"Fetching remote" messages when some changes were fetched.

I will come back with a correct patch that is better explained.

> I'd sell it like the attached, if I were doing this patch.=C2=A0=C2=A0The=
 last
> paragraph is where the remaining 60% went ;-)

Thanks, I will try to re-use that for the next patch.

> Note that the current output was deliberately designed like this to
> give an easy reminder for the user what the components of 'group'
> are.=C2=A0=C2=A0With this change, we are selfishly and unilaterally break=
ing a
> feature that was designed to help them, but if they strongly care,
> they can complain and revert this change.

To be honest I didn't know this group feature existed and I am
surprised that anyone would want anything other than --all.

I am not sure what the solution here is but perhaps the behaviour
demonstrated below is acceptable to users of this feature:

# When no changes were fetched
$ git fetch group

# When some changes were fetched
$ git fetch group
Fetched origin
From
git://one.of.the.places.xz/
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aadb70a..74301d6=C2=A0 master=C2=A0=C2=
=A0=C2=A0=C2=A0 ->
this/master
No changes from someone someoneelse otherperson

# When no changes were fetched in verbose mode
$ git fetch --verbose group
Fetching origin
Fetching someone
Fetching someoneelse
Fetching otherperson

# When some changes were fetched in verbose mode
$ git fetch --verbose group
Fetching origin
=46rom git://one.of.the.places.xz/
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aadb70a..74301d6=C2=A0 master=C2=A0=C2=
=A0=C2=A0=C2=A0 -> this/master
Fetching someone
Fetching someoneelse
Fetching otherperson

--=C2=A0
bye,
pabs

http://bonedaddy.net/pabs3/


--=-RXh0SKfyTmAMmYFDG1is
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJWLW33AAoJEDEWul6f+mmjSSYP/AsYaQo6QoV7dX//lKHg5vD+
Bog4mLGrrulB07bZ+Hxt165y8flLsMu9MnsOX55C2ctsRSC/+6wLk7x9aKsv7qwY
O4vM3reWIWvel/zCl4j+cpA7meUjkYyS3rrQB2R2ij/s7WalRAYLqDRUH+qVJDUJ
HuT84Ee+csXWjn/YVq3Fk8vjKhWZjv/1zeqN9OIGnIgu6t2RBt4u/6AI5PWauLNZ
FlJWbbtA4DtX6j8JvNlDwpOZQn0cL4bFinnxgFC0CSM2EwjO+wCcQrc0j5ovTCVj
ydmOw1SSE8hEbrbRHNhTfDDrluCZo9KO67YNm3sVwpE30uvA+czYwgHKYACQiTtj
ZC6CselwqKhcJp5rkcGlB70yCSErqlDIijhMao/KeghWUwwdIpYx5yxuyp2/NN94
35MyKa0a1LTuodiKbEKo4l2fi9J3K+Dz6pjMLwNmiyrY3/HhmQovrfuUMb95ZdIV
zOKjBY7fuZcFfFTtem9X4rzr4URM17cwc6nN3bk38FT3UAUuLDosMAdCcF0lW8Rb
FXRAIQfQoioIAdfkcMGwCSWSw7T7Dj1sG7rDyea2YZu36dndsLjCuQ9uUKXmqmUp
7pC18yJwdqmD2iadlZzucf0O5LoSwzZXJLmcWka4/3/zTIx3d4tKkKpB+/eMdmml
Bl0b9Qfe6Z3X22vNSfqQ
=viMB
-----END PGP SIGNATURE-----

--=-RXh0SKfyTmAMmYFDG1is--
