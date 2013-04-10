From: Magnus Therning <magnus@therning.org>
Subject: Re: git-http-backend: anonymous read, authenticated write
Date: Wed, 10 Apr 2013 22:45:44 +0200
Message-ID: <20130410204544.GA2472@mteis.lan>
References: <20130409054553.GA1537@mteis.lan>
 <20130409171247.GD21972@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:46:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1uK-0002Dn-6b
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936666Ab3DJUqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:46:10 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:40821 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934621Ab3DJUqI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:46:08 -0400
Received: by mail-lb0-f182.google.com with SMTP id z13so971675lbh.27
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 13:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=6Li81N1Z2Th+N32NiB6Us9qXs+voNm8hYIilh3USTjI=;
        b=bTBWHfkmNwaCJ2GUTof/+ImcmmEcaV0Og8doF0GmZdutEaGQNkMhniVortYLAPqSKF
         zGYDYE1XucZ5pl84hGG14PU0GcnKcd4SMkgSI51oF3xWK4fMehn63p5D8hOSVJp42wih
         mXEIOVCfTDc6vDoVpiQW8N88FcNwXQ6FXdfLsUpXQ7yl3favHAitWkPsBhPgojCsVQwi
         duK1NnWTzE8E3ewgLuKu/GITmSqnVUtv54fojdMp8k4VC8JRKtWMT6cjy2amrO4wZUze
         kNxMrmW7Vf1RcC4L6esgUjPmgqpsXCgGdxvnsGZyrDlYy+n4mdMidxgbanYWunVEjKDX
         o/Xg==
X-Received: by 10.152.6.10 with SMTP id w10mr1824751law.30.1365626766547;
        Wed, 10 Apr 2013 13:46:06 -0700 (PDT)
Received: from mteis.lan (92-32-222-34.tn.glocalnet.net. [92.32.222.34])
        by mx.google.com with ESMTPS id t6sm537696lae.3.2013.04.10.13.46.04
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 13:46:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130409171247.GD21972@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQk8V8kYvFObQzQL3Ianl7ASfkgM4ncqSfzbettBtU0aeEC1yJ+KmG6DgmLxmToGW8TnLjkM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220758>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2013 at 01:12:47PM -0400, Jeff King wrote:
> On Tue, Apr 09, 2013 at 07:45:53AM +0200, Magnus Therning wrote:
>=20
>> I've been trying to set up git-http-backend+lighttpd.  I've managed
>> to set up anonymous read-only access, and I then successfully
>> configured authentication for both read and write.  Then I get
>> stuck.  The man-page for git-http-backend says that the following
>> snippet can be used for Apache 2.x:
>>=20
>>     <LocationMatch "^/git/.*/git-receive-pack$">
>>         AuthType Basic
>>         AuthName "Git Access"
>>         Require group committers
>>         ...
>>     </LocationMatch>
>>=20
>> However, when I put in this match on location in my lighty config
>> and try to push I'm not asked for a password, instead I'm greeted
>> with
>>=20
>>     % git push=20
>>     error: The requested URL returned error: 403 Forbidden while accessi=
ng http://magnus@tracsrv.local/git/foo.git/info/refs?service=3Dgit-receive-=
pack
>=20
> Something in your config is blocking access to info/refs there. It
> should not be the block shown above, which handles only the actual POST
> of the data. The sequence of http requests made is:
>=20
>   1. GET $repo/info/refs?service=3Dgit-receive-pack
>=20
>      This makes initial contact and gets the ref information which push
>      uses to decide what it is going to push. So it is read-only, and in
>      an anonymous-read setup, does not need to be protected.
>=20
>   2. POST $repo/git-receive-pack
>=20
>      This actually pushes up the objects and updates the refs, and
>      must be protected.
>=20
> The setup listed above does work with apache; it is tested as part of
> our test suite (you can see the actual config in t/lib-httpd/apache.conf).
> So what in lighttpd is giving us the 403? Can you share your whole
> config?

I was putting together a *long* response, with my different
configurations when it suddenly hit me how to make it work.

So, this is the accesslog for a successful `git push`:

192.168.1.84 tracsrv.local - [10/Apr/2013:22:24:59 +0200] "GET /git/foo.git=
/info/refs?service=3Dgit-receive-pack HTTP/1.1" 401 351 "-" "git/1.8.2.1"
192.168.1.84 tracsrv.local - [10/Apr/2013:22:24:59 +0200] "GET /git/foo.git=
/info/refs?service=3Dgit-receive-pack HTTP/1.1" 401 351 "-" "git/1.8.2.1"
192.168.1.84 tracsrv.local magnus [10/Apr/2013:22:25:04 +0200] "GET /git/fo=
o.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 200 202 "-" "git/1.8.2=
=2E1"
192.168.1.84 tracsrv.local magnus [10/Apr/2013:22:25:09 +0200] "POST /git/f=
oo.git/git-receive-pack HTTP/1.1" 200 73 "-" "git/1.8.2.1"

That is, *both* the GET and POST queries require a valid username
(trying to push without a valid user will fail with a 403 already on
the GET query).  Maybe Apache 2.x simply behaves *very* differently
=66rom lighttpd, but I still can't see how a rule to require a valid
user only on the POST can ever work.

>> AFAICS this means the man-page is wrong, and that I instead ought
>> to match on the "service=3Dgit-receive-pack" part.  Is that a correct
>> conclusion?
>=20
> No. It is not a bad idea to _also_ match on info/refs, but I think
> it's a little trickier (you need to reliably match the query string
> to differentiate it from a fetch, which IIRC is a little hard in
> apache, at least).

This is what triggered me to find a working config.  Matching on the
query string is actually *very* easy in lighttpd.  Here's the relevant
bit of a working configuration[1]:

    alias.url +=3D ( "/git" =3D> "/usr/lib/git-core/git-http-backend" )
    $HTTP["querystring"] =3D~ "service=3Dgit-receive-pack" {
        $HTTP["url"] =3D~ "^/git" {
            cgi.assign =3D ( "" =3D> "" )
            setenv.add-environment =3D (
                "GIT_PROJECT_ROOT" =3D> "/srv/git",
                "GIT_HTTP_EXPORT_ALL" =3D> ""
            )
            include "trac-git-auth.conf"
        }
    } else $HTTP["url"] =3D~ "^/git/.*/git-receive-pack$" {
        cgi.assign =3D ( "" =3D> "" )
        setenv.add-environment =3D (
            "GIT_PROJECT_ROOT" =3D> "/srv/git",
            "GIT_HTTP_EXPORT_ALL" =3D> ""
        )
        include "trac-git-auth.conf"
    } else $HTTP["url"] =3D~ "^/git" {
        cgi.assign =3D ( "" =3D> "" )
        setenv.add-environment =3D (
            "GIT_PROJECT_ROOT" =3D> "/srv/git",
            "GIT_HTTP_EXPORT_ALL" =3D> ""
        )
    }

> But if you drop the protections on "/git-receive-pack$", then an
> attacker can just POST whatever they want into your repository.

This setup is for a server on the internal network, but still, your
comment holds.  The reason for wanting to allow reading without
authentication is that then I can signal a CI server to pull without
having to give it credentials.

/M

[1]: The configuration for the authentication looks like this at the
moment, but it's only for testing:

    auth.backend =3D "plain"
    auth.backend.plain.userfile =3D "/srv/git/pwds.plain"
    auth.require =3D (
        "/" =3D> (
            "method" =3D> "basic",
            "realm" =3D> "git",
            "require" =3D> "valid-user"
            )
        )
--=20
Magnus Therning                      OpenPGP: 0xAB4DFBA4=20
email: magnus@therning.org   jabber: magnus@therning.org
twitter: magthe               http://therning.org/magnus

Most software today is very much like an Egyptian pyramid with
millions of bricks piled on top of each other, with no structural
integrity, but just done by brute force and thousands of slaves.
     -- Alan Kay

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iF4EAREIAAYFAlFlz3gACgkQxZ8oagHN9cHnbQD+PvhcCJFmzSHnfKskqxtbCsKT
nhFUCVbJNK3bpKrFlT4BAIjSmwQHn3nMpeYIqLdidJRNrmOLI2UbAZzBHit1Dq+0
=XaKs
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
