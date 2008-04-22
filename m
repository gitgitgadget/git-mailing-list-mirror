From: Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: [PATCH] git-svn bug with blank commits and author file
Date: Tue, 22 Apr 2008 06:07:47 -0400
Message-ID: <480DB8F3.5080000@aei.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020301030909090700080109"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 12:09:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoFQU-0006hX-Tm
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 12:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758650AbYDVKHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 06:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759205AbYDVKHv
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 06:07:51 -0400
Received: from mail001.aei.ca ([206.123.6.130]:52832 "EHLO mail001.aei.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757007AbYDVKHu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 06:07:50 -0400
Received: (qmail 19913 invoked by uid 89); 22 Apr 2008 10:07:48 -0000
Received: by simscan 1.2.0 ppid: 19910, pid: 19911, t: 0.0023s
         scanners: regex: 1.2.0 attach: 1.2.0
Received: from mail002.aei.ca (HELO mail002.contact.net) (206.123.6.132)
  by 0 with (DHE-RSA-AES256-SHA encrypted) SMTP; 22 Apr 2008 10:07:48 -0000
Received: (qmail 24161 invoked by uid 89); 22 Apr 2008 10:07:48 -0000
Received: by simscan 1.2.0 ppid: 24153, pid: 24155, t: 0.5705s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.92.1/m: spam: 3.2.4
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01)
X-Spam-Level: 
X-Spam-Status: No, hits=-3.8 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from dsl-132-252.aei.ca (HELO ?192.168.1.116?) (66.36.132.252)
  by mail.aei.ca with SMTP; 22 Apr 2008 10:07:48 -0000
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
X-Enigmail-Version: 0.95.0
OpenPGP: id=DE417216;
	url=http://pgpkeys.mit.edu:11371/pks/lookup?op=get&search=0xDE417216
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80094>

This is a multi-part message in MIME format.
--------------020301030909090700080109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

* Sorry for resending; added a patch tag and corrected typo in subject *

When trying to import from svn using an author file, git-svn bails out
if it encounters a blank author. The attached patch changes this
behavior and allow using the author file with blanks authors.

I came across this bug while importing from a cvs2svn repo where the
initial revision (1) has a blank author. This doesn't break the behavior
of bailing out when an unknown author is encountered.

The patch was made against Git's HEAD.

If you reply please make sure to cc me as I'm not subscribed to the list.

Thanks,

- --
Thomas Guyot
dermoth@aei.ca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIDbjz6dZ+Kt5BchYRAjdFAJ0WA9TiIJ6tefjaPkd40Y2Tjv6NPACbBwmB
a6eFU84MpJ9MW1nErxDiqHY=
=k3jA
-----END PGP SIGNATURE-----

--------------020301030909090700080109
Content-Type: text/plain;
 name="git-svn.perl-no_author.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-svn.perl-no_author.patch"

--- git-svn.perl.orig	2008-04-19 05:58:10.000000000 -0400
+++ git-svn.perl	2008-04-19 19:50:40.000000000 -0400
@@ -2375,8 +2375,7 @@
 	my ($author) = @_;
 	if (!defined $author || length $author == 0) {
 		$author = '(no author)';
-	}
-	if (defined $::_authors && ! defined $::users{$author}) {
+	} elsif (defined $::_authors && ! defined $::users{$author}) {
 		die "Author: $author not defined in $::_authors file\n";
 	}
 	$author;


--------------020301030909090700080109--
