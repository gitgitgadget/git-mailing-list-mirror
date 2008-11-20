From: Roger Leigh <rleigh@codelibre.net>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 11:20:51 +0000
Message-ID: <20081120112051.GB22787@ravenclaw.codelibre.net>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <C33ABF98-2E52-4928-BF79-CB3B6A8460DB@feinheit.ch> <49252204.2070906@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Cc: Matthias Kestenholz <mk@feinheit.ch>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 20 13:42:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L38r2-0004pe-PI
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 13:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbYKTMkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 07:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbYKTMkV
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 07:40:21 -0500
Received: from nagini.codelibre.net ([80.68.93.164]:33628 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbYKTMkU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 07:40:20 -0500
Received: by nagini.codelibre.net (Postfix, from userid 1000)
	id 90F6F18891; Thu, 20 Nov 2008 12:40:12 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <49252204.2070906@op5.se>
X-GPG-Key: 0x25BFB848
X-Debian: testing/unstable
X-OS-Uptime: 11:02:39 up 58 min,  1 user,  load average: 0.15, 0.15, 0.16
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101415>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2008 at 09:38:28AM +0100, Andreas Ericsson wrote:
> Matthias Kestenholz wrote:
>> Hi,
>>
>> On 19.11.2008, at 12:37, Roger Leigh wrote:
>>
>>> I'm using git to store some generated files, as well as their sources.
>>> (This is in the context of Debian package development, where entire
>>> upstream release tarballs are injected into an upstream branch, with
>>> Debian releases merging the upstream branch, and adding the Debian
>>> packaging files.)
>>>
>>> The upstream release tarballs contains files such as
>>> - yacc/lex code, and the corresponding generated sources
>>> - Docbook/XML code, and corresponding HTML/PDF documentation
>>>
>>> Would it be possible for git to store the mtime of files in the tree?
>>
>> This subject comes up from time to time, but the answer always
>> stays the same: No. The trees are purely defined by their content, and
>> that's by design.
>>
>> If you do not want to regenerate files that are already up-to-date,
>> you need multiple checkouts of the same repository.
>
> Or a make-rule that touches the files you know are up to date. Since you
> control the build environment, that's probably the simplest solution.

This is the approach I'm currently taking, since it's simple and
doesn't require any tool changes.  Ideally, I'd like to avoid
such hackiness, though.

I understand all the arguments I've seen in favour of not using the
mtime of the files when checking out.  They make sense.  However,
in some situations (such as this), they do not--git is breaking
something that was previously working.  In my case, I'm
injecting *release tarballs* into git, and the timestamps on the
files really do matter.  Regarding issues with branching and branch
switching, I always do builds from clean in this case.

If an option was added to git-checkout to restore mtimes, it need
not be the default, but git could record them on commit and then
restore them if asked /explicitly/.

For this, and some other uses I have in mind for git, it would be
great if git could store some more components of the inode
metadata in the tree, such as:
- mtime
- user
- group
- full permissions
- and also allow storage of the full range of file types (i.e.
  block, character, pipe, etc.)

This would allow git to be used as the basis for a complete
functional versioned filesystem (which I'd like to use for my
lightweight virtualisation tool, schroot, which currently
uses LVM snapshots for this purpose).


Regards,
Roger

--=20
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkklSBMACgkQVcFcaSW/uEg/lQCfZV5VG/0ttdp7ATbuOhHYS0Ys
nScAoK1pOtkuqiLVn7xbcd5EKgsoLRlg
=TuTn
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
