From: Mike Hommey <mh@glandium.org>
Subject: Re: What's cooking in git.git (Jun 2016, #01; Thu, 2)
Date: Sat, 4 Jun 2016 08:26:53 +0900
Message-ID: <20160603232653.GA24538@glandium.org>
References: <xmqq4m9aqn4d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 01:27:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8yV1-0002gi-6d
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 01:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbcFCX1K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 19:27:10 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:52280 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbcFCX1J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 19:27:09 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b8yUP-0007QQ-MP; Sat, 04 Jun 2016 08:26:53 +0900
Content-Disposition: inline
In-Reply-To: <xmqq4m9aqn4d.fsf@gitster.mtv.corp.google.com>
 <57511086.40206@web.de>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296426>

On Fri, Jun 03, 2016 at 08:59:46AM -0700, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>=20
> > There where 2 comments in the review.
> > The most important thing is that now
> > git://[example.com:123]/path/to/repo is valid, but it shouldn't.
> > This patch fixes it:
> >
> > @@ -673,7 +669,7 @@ static enum protocol parse_connect_url(const ch=
ar *url_orig, char **ret_user,
> >          * "host:port" and NULL.
> >          * To support this undocumented legacy we still need to spl=
it the port.
> >          */
> > -       if (!port)
> > +       if (!port && protocol =3D=3D PROTO_SSH)
>=20
> Hmph, which one of these (if any) is valid, which ones aren't and
> why?
>=20
>     git://[example.com:123]/path/to/repo
>     ssh://[example.com:123]/path/to/repo
>     [example.com:123]:/path/to/repo
>=20
> I am wondering about the latter two, because both of them would
> become PROTO_SSH at some point in the codepath.  And I am wondering
> about the first two, because they look the same at the syntactic
> level and if one is allowed the users would expect the other would
> also be (or vice versa).

In fact, the parser doesn't even reject the one that is considered
invalid (the first).

It just happens to not work because example.com:123 is not a valid
hostname, and can't be resolved, which is then the error presented to
the user.

Which brings me to:

On Fri, Jun 03, 2016 at 07:07:18AM +0200, Torsten B=F6gershausen wrote:
> The other thing is that I asked for a test case for
> git://[example.com:123]/path/to/repo
> which shouldn't be hard to do.

Since the parser doesn't error out, the only way to test this is to
check that the parser thinks the output for it is host=3Dexample.com:12=
3
port=3DNONE. Which sounds like an awful way to check for this.

(Also, the discussion back then was about
git://[example.com:123]:/path/to/repo, not
git://[example.com:123]/path/to/repo)

Mike
