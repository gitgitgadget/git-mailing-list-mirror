From: =?UTF-8?B?RmxvcmlhbiBLw7ZiZXJsZQ==?= <FloriansKarten@web.de>
Subject: Re: [egit / jgit] Implementation of a file tree iteration using ignore
 rules.
Date: Sat, 10 May 2008 17:11:59 +0200
Message-ID: <4825BB3F.4060006@web.de>
References: <48244F88.8060109@web.de> <20080510001132.GF29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 10 17:12:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juqkm-0002pX-2d
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 17:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbYEJPL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 11:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbYEJPL7
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 11:11:59 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:33888 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbYEJPL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 11:11:57 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 32468DA5244F;
	Sat, 10 May 2008 17:11:56 +0200 (CEST)
Received: from [84.150.90.150] (helo=[192.168.1.50])
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Juqjr-0006ms-00; Sat, 10 May 2008 17:11:56 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <20080510001132.GF29038@spearce.org>
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX1/MkXukbRbbrFqVADju5QmXrTbdV31Pg2y1tXQE
	RloFKIgK0flt4+TSfGx1aQb/LgF19ffGudAx/JK4nnlz3mg3Bg
	nVsuP1cRvSeoHI9O55GQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81687>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

| This is an interesting start.  Did you see the existing "Main" class
| in org.spearce.jgit/src/org/spearce/jgit/pgm?  It sets up and invokes
| a TextBuiltin, which is sort of like the "Command" class you added in
| your first patch.  Though TextBuiltins are created on-the-fly and thus
| are harder/impossible to use to format a "jgit help".
I noticed that the class appeared after a rebase, but didn't have a
closer look to it yet.

|
| I think your approach of building up a table of commands is likely
| the better one long term, so I am interested in seeing the two unify,
| taking the best from each (from Main and MainProgram that is).
|
| Please note that jgit is restricted to Java 5 APIs only right now.
| The "MainProgram" class you introduced uses Arrays.copyOfRange()
| which does not compile under Java 5.  I guess it is new in Java 6?
Yes it is new in Java 6. A patch fixing this is contained in the patch
set I send to the mailing list.
| What is missing here is really two things:
|
|  #1)  Take .gitignore and .git/info/exclude (and other patterns) into
|       account as WorkingTreeIterator (base class of FileTreeIterator)
|       loops over the entries in a directory.

I had a look at the WorkingTreeIterator and it seems to me that it is
possible to reuse my Rules class there.

We could simply give the iterator a member variable of type Rule.

The method loadEntries of WorkingTreeIterator could then use the rules
class to filter out unwanted files and directories.

The constructor  WorkingTreeIterator(final WorkingTreeIterator p) could
use the Rules#getRulesForSubDirectory to create a Rules instance from
the parent Rules instance.

Also note that my Rules implementation would ignore the directory a in
the case of "/a\n!/a/b.txt". This means that a directory may not appear
in the list entries, but must be used to create another iterator.

I suggest to put all the classes from the package
org.spearce.jgit.treewalk and the package
org.spearce.jgit.lib.fileiteration into one package. Please tell me
which package and I will send a patch, or do it yourself. I don't have
any outstanding changes.

I don't see a easy way of porting my Rules implementation to the
TreeFilter framework, but as you may noticed it is may not necessary to
do so.

| I think the command you are looking for is `git send-email`.
Thanks, after switching to a newer version of git I was able to use that
command.

Best regards,
Florian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIJbr659ca4mzhfxMRAn/ZAKCYERVJfHgZmvGFXEP+uCT0rD2RawCgqBIW
Xa4NTcAWjt8j0oMPdKMjbbY=
=koEN
-----END PGP SIGNATURE-----
