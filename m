From: in-git-vger@baka.org
Subject: Re: need to create new repository initially seeded with several branches
Date: Wed, 31 Aug 2011 11:40:49 -0400
Message-ID: <201108311540.p7VFen5S015756@no.baka.org>
References: <1314804325568-6746957.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "ryan@iridiumsuite.com" <ryan@iridiumsuite.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 18:29:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QynfK-0000Fv-6N
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 18:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862Ab1HaQ3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 12:29:20 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from tsutomu.baka.org ([66.114.72.182]:57359 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756858Ab1HaQ3S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 12:29:18 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id p7VFen13029037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 31 Aug 2011 11:40:49 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id p7VFen5S015756;
	Wed, 31 Aug 2011 11:40:49 -0400
In-reply-to: <1314804325568-6746957.post@n2.nabble.com>
Comments: In reply to a message from ""ryan@iridiumsuite.com" <ryan@iridiumsuite.com>" dated "Wed, 31 Aug 2011 08:25:25 -0700."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180479>


In message <1314804325568-6746957.post@n2.nabble.com>, "ryan@iridiumsui=
te.com" writes:

    I would like to turn this into a git repository.  One branch being =
master,
    the second develop and finally a third branch that is extended off =
the
    develop branch.

I will assume in my instructions that develop is "extended" off of mast=
er.

----------------------------------------------------------------------
cd /path/to/new/master
# Make this a git repo
git init
# Add all files to git
git add .
# Commit all files to git
git commit -m "initial master version"
# Make new develop branch
git checkout -b develop
# Cause git to delete all files in the internal index
git read-tree --reset -i 4b825dc642cb6eb9a060e54bf8d69288fbee4904
# Cause git to delete all files in the working directory
git clean -dfx
# Copy all files from the develop directory
cp -r /path/to/new/develop .
# Add all files to git (and delete them too)
git add -A .
# Commit
git commit -m "Initial develop branch"
# Make new extended branch
git checkout -b extended
# Cause git to delete all files in the internal index
git read-tree --reset -i 4b825dc642cb6eb9a060e54bf8d69288fbee4904
# Cause git to delete all files in the working directory
git clean -dfx
# Copy all files from the extended directory
cp -r /path/to/new/extended .
# Add all files to git (and delete them too)
git add -A .
# Commit
git commit -m "Initial develop branch"
----------------------------------------------------------------------

The only "magic" is the read-tree/git-clean stuff.  The 4b82=E2=80=A6 v=
alue is
the SHA of an empty tree.  It could be replaced by a:

find . -maxdepth 1 ! -name '.git' -a ! -name '..' -a ! -name '.' -print=
0 | xargs -0 rm -rf

But that is 9 extra characters.

Untested, but it should work.

					-Seth Robertson
