From: Chani <chanika@gmail.com>
Subject: partial checkouts
Date: Sat, 23 May 2009 14:00:55 -0700
Message-ID: <200905231401.11651.chanika@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2642552.6JIZSLBpOL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 23:02:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7yM5-0000BB-6J
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 23:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbZEWVB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 17:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbZEWVB7
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 17:01:59 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:34016 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbZEWVB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 17:01:58 -0400
Received: by pxi1 with SMTP id 1so1919789pxi.33
        for <git@vger.kernel.org>; Sat, 23 May 2009 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=7fWNmPxbNjoyWqbeWlQ3zE0+OWGQ40s3HTFpMtmmDY0=;
        b=OWBcApOFOtvlpwcv57x76uN0JantkynWufSTXpOUE6TqGxiY5lJU+gllvnFLRatjvj
         sCstxuBL7drZx/8oo7ixycB3VQ6EBRA8mulmmq2/WnvFkG+GKC+E+Je1Usxbhw/192N4
         3brGKSzLQJqzNd/YY2Ktvvc6uBu6H7+owGhYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=X+aqUhRhRwP6j9EuOgvVQ/XqIvv2Qu1EbKaUtnu1k4zscbpcHMqZPZW1MEuoll1zfg
         L7kzkksBMG/1XOioAqCuTDxq5JvzBF6WM8449/3tDL46MA+R+78DS0vGq5WUgemZB/SL
         TcX1utl+VIXvpxUUxMg3fxXMCjZAnA+WUOdsA=
Received: by 10.142.230.11 with SMTP id c11mr1735680wfh.246.1243112519693;
        Sat, 23 May 2009 14:01:59 -0700 (PDT)
Received: from brain.localnet ([96.49.70.32])
        by mx.google.com with ESMTPS id 24sm6926978wff.11.2009.05.23.14.01.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 14:01:59 -0700 (PDT)
User-Agent: KMail/1.11.90 (Linux/2.6.27-ARCH; KDE/4.2.87; i686; svn-970258; 2009-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119802>

--nextPart2642552.6JIZSLBpOL
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

so I'm trying to convert KDE's translation helper scripts to support git=20
repositories for kde modules. the translators themselves are staying in svn=
=20
for now, but we want to start migrating kde modules over to git.

I've hit a bit of a problem, though.
inside the translators' folder, there's a folder called documentation/ - an=
d=20
inside that is a bunch of svn externals pointing to the doc/ folder of ever=
y=20
kde module. (this is, then, all of kde's english documentation.)
translators occasionally need to run a script that reads from the=20
documentation/ folder.

now, what happens when one of those modules switches to git? first, the svn=
=20
external goes away. that's ok, I can work around that by having the update_=
xml=20
script (the one translators need to run) fetch the doc folder itself, right?
but where does it fetch it from? doc/ is now a subdirectory in a git=20
repository, and git doesn't support checking out only one folder, not even =
if=20
all I want to do is read the files in it.

checking out the entire git repo isn't really feasible, because once KDE=20
finishes switching to git that'll mean checking out all of KDE.
I don't think that turning every doc folder into a submodule is feasible,=20
either - they sound kinda awkward to work with, and I can imagine lots of=20
people getting confused and messing them up...

right now all I've thought of is one ugly hack: have a server that checks o=
ut=20
all the kde git repos, pulls daily, copies all the doc/ folders into a=20
documentation folder, and offers that folder up on the interwebs so that=20
update_xml can rsync from it or download a tgz of it or something.
there appear to be lots of images in the documentation, so it's not a small=
=20
download - 200mb and growing. it still hasn't finished downloading all the=
=20
externals...

I'm kinda wondering if there'd be a way to use git-filter-branch to make a =
repo=20
that only tracks the doc/ folder for a module - but I've no idea whether it=
'd=20
have to be recreated from scratch every time someone changes something in t=
he=20
real repo's doc/

can anyone think of a less ugly solution?
what are the chances of git supporting this kind of partial checkout someda=
y?

=2D-=20
This message brought to you by eevil bananas and the number 3.
www.chani3.com

--nextPart2642552.6JIZSLBpOL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoYZAcACgkQeGbAwpIS3GyBTACglQvDtfjP9PPzN44x4OKBRDOk
Fm8AoOEy8jT9W+1QnRPBVnj/BxiAyfVE
=3Gi/
-----END PGP SIGNATURE-----

--nextPart2642552.6JIZSLBpOL--
