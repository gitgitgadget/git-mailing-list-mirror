From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What does the 100 in R100 mean?
Date: Fri, 14 May 2010 14:20:52 +0200
Message-ID: <201005141420.52657.trast@student.ethz.ch>
References: <20100514112145.GQ12846@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Todd A. Jacobs" <nospam@codegnome.org>
X-From: git-owner@vger.kernel.org Fri May 14 14:21:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCtt1-0003qq-9S
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 14:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900Ab0ENMU5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 08:20:57 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:27665 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709Ab0ENMU4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 08:20:56 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 14 May
 2010 14:20:54 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 14 May
 2010 14:20:52 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <20100514112145.GQ12846@penguin.codegnome.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147085>

Todd A. Jacobs wrote:
> When I'm looking at the output for renamed files in git-log or
> git-whatchanged, renamed files always seem to say "R100." So, I looke=
d
> in the man page, followed the internal references to --diff-filter, a=
nd
> remain stumped as to what the digits stand for. I couldn't even find =
an
> explanatory comment in the git source code.
>=20
> Obviously, R is for "(R)enamed." What is the "100" for? If it's being
> returned as a flag to --name-status and friends, it should probably b=
e
> documented somewhere.

It is, but in the "wrong" section:

RAW OUTPUT FORMAT
[...]
       Possible status letters are:
       =B7   A: addition of a file
       =B7   C: copy of a file into a new one
       =B7   D: deletion of a file
       =B7   M: modification of the contents or mode of a file
       =B7   R: renaming of a file
[...]
       Status letters C and R are always followed by a score (denoting
       the percentage of similarity between the source and target of
       the move or copy), and are the only ones to be so.

The patch below might rectify that, but it's not that reader-friendly
because it has to point at the git-diff manpage where diff-format.txt
is not included.  The ifdef is also an incomplete test because
diff-{files,index,tree} include diff-format.txt but don't set
git-diff.

diff --git i/Documentation/diff-options.txt w/Documentation/diff-option=
s.txt
index 98cc779..424971c 100644
--- i/Documentation/diff-options.txt
+++ w/Documentation/diff-options.txt
@@ -107,8 +107,12 @@ any of those replacements occurred.
 	Show only names of changed files.
=20
 --name-status::
-	Show only names and status of changed files. See the description
-	of the `--diff-filter` option on what the status letters mean.
+	Show only names and status of changed files. See the "RAW
+	OUTPUT FORMAT" section
+ifndef::git-diff[]
+	in linkgit:git-diff[1]
+endif::git-diff[]
+	for what the status codes mean.
=20
 --submodule[=3D<format>]::
 	Chose the output format for submodule differences. <format> can be on=
e of


--=20
Thomas Rast
trast@{inf,student}.ethz.ch
