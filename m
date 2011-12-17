From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Sat, 17 Dec 2011 15:40:09 +0530
Message-ID: <20111217101009.GA19248@sita-lt.atc.tcs.com>
References: <jbvj5o$skt$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Cc: git@vger.kernel.org
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 11:10:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbrDo-0008Cd-Pn
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 11:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782Ab1LQKKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 05:10:25 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57098 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab1LQKKX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 05:10:23 -0500
Received: by iaeh11 with SMTP id h11so5663635iae.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 02:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PVEIxCt6sdzc3adK/KRQtsHy9Ol3j4q4/dd/qzvESbg=;
        b=nmg7HAxthagHfxDUFpskuv9ZFIfAoyL5N2zygR9STBO1HWaWbsKMB+7EkM6nF48gRm
         BBM5oMQKv/Otkc0zw/JW5amQ6k0ctZQzW7FiZ3CvHGIv0pgEBd27DjPIsY5OWcNkhvHO
         rHwo6UwpgqQ23G7hYry/0xJSyXCbigCHOBI5g=
Received: by 10.50.173.74 with SMTP id bi10mr14059991igc.4.1324116623537;
        Sat, 17 Dec 2011 02:10:23 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.189.63])
        by mx.google.com with ESMTPS id wn9sm7551205igc.6.2011.12.17.02.10.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 02:10:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <jbvj5o$skt$1@dough.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187365>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 10, 2011 at 01:26:32PM +0100, Gelonida N wrote:
> Hi,
>=20
> What is the best way to fastforward all fastforwardable tracking
> branches after a git fetch?

I know this is a somewhat closed topic, but I took some time to
clean up a program I have been using for a while, including some
changes based upon ideas elsewhere in this thread.  The program
"git-branch-check" is attached, and requires perl > 5.10.0.

Note that this does a lot more than just fast-forward all
branches, although it can do that as well.

I alias it (in ~/.gitconfig) to 'bc', so I just run "git bc".
Running with "-h" shows usage:

    Usage: /home/sitaram/bin/git-branch-check [options] [branches]

    Check or fast forward branches.  Default: act upon all local branches i=
f no
    arguments supplied, or just the current branch if '-c' is passed.
            -c      act upon current branch only
            -ff     don't just check, try to fast forward also
            -md     max diff (default 100; see below for details)
            -h      help
    'max diff':
        hide output for two branches different by more than so many commits

My usual usage is just "git bc -c", which may give me:

       1        pu...origin/pu
       1        pu...github/pu
      13        pu...master
           5    pu...q
           7    pu...vrs

This quickly tells me my 'pu' is one ahead of both my own
gitolite server as well as github's copy, and that it is 13
commits ahead of master.  The (unreleased and frequently
rebased) feature branches 'q' and 'vrs' are ahead of pu, which
means a rebase is not pending.  Without the "-c" I may see the
status of master versus its own upstream and other remotes,
etc., also.

The purpose of the max diff limit (default 100) is to hide, for
example, the pair 'master' and 'man' from the git.git repo.
Otherwise you'd see something like:

    27249 973    master...man

which is pretty meaningless.  The sum of those two numbers
should be less than the max.

"git bc -ff" will attempt to fast forward all selected branches
that are ancestors of their respective upstreams.  The current
branch will not be ff-ed if the tree is dirty, since you can't
do this by 'git branch -f'; it has to be an actual merge
command.

The output is not (currently) pipable to other programs because
I use colors (obtained from 'git config --get-color') and
currently it is not conditional on STDOUT being a tty.

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO7GqBAAoJEKRCkIUIgjelCsEP/1AK1w3i1IiKRKNb7HxNT+UN
aejuATL2yEuas/5un2foJjGJENr7+RkOD1Jj7xQOndVVcojl/U9el9F7XqAyMdJH
hqAJSL2Wg8b6Gz2+uwNZ0yeZ6Yjo+z0h/XY0M+0WXnaOKV3zSQWiGWk5pkrsNsO7
n0XZMXPJZaPkjy83bq7wHcDiCP/f379Ho8n8XeYmRIdZj8IgZ4w1z+09KUG0oTrD
2Kt4bq0hEpTkMvcoeJ68VTE4mfUsFRm3pOYeoTcnMrIp0hjbdoMGR/EKJ6Z8aGLY
wLpviU46ruxesvCOgtGO6wIDMqz0qLZMNHSR+NrkzPJU8A6bf5NvrLRnwwwX5N6e
4EeHgk6sQhzFLIY39PhIpAwe3dDb78dYVpIhMw/KLENi8NB4jMkB5GY26S8vjYy0
+bAIBw6IMVOkuh/315h4x3jrhyiH7XDkdaQMnUYKhqhslIU9Cnz1KdFtztLqZ8k7
CyZJx+di8f2J4LqkA6E02M73EzTI3CQ93ZKjzMGEYiGX4Ttp9sKT3D6st88+1Plo
UcVi6GQCApIvpYQ0QtdrX/WKOtkFLKSYrTz3m2dwBg6mVAx6r0Al88zQVhG4gzWR
6r5+UH8lfheqrhfQZXXXRKHaMsq0hgFsRwO9Kn34VQswoUp9ladWv6u7+V7YL5q7
2RQ6FuJeiP6vFId3jzTt
=dX2+
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
