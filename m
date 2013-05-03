From: worley@alum.mit.edu (Dale R. Worley)
Subject: Suggestion for improving the manual page for "git submodule"
Date: Thu, 2 May 2013 21:23:55 -0400
Message-ID: <201305030123.r431Nt6w015228@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 03 03:31:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY4q8-0004vP-9m
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 03:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760841Ab3ECBbH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 May 2013 21:31:07 -0400
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:50352
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750984Ab3ECBbG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 May 2013 21:31:06 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 May 2013 21:31:06 EDT
Received: from omta08.westchester.pa.mail.comcast.net ([76.96.62.12])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id XDB91l0020Fqzac5CDPxlK; Fri, 03 May 2013 01:23:57 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta08.westchester.pa.mail.comcast.net with comcast
	id XDPw1l00C1KKtkw3UDPwd8; Fri, 03 May 2013 01:23:57 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r431NtpV015229
	for <git@vger.kernel.org>; Thu, 2 May 2013 21:23:56 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r431Nt6w015228;
	Thu, 2 May 2013 21:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1367544237;
	bh=vfyJtyRPszFjgAiYsJrPfFsS04r6iXdroipUQ8i/JYU=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject:MIME-version:Content-type;
	b=c5Kd2BD+NOAHKW1XbJq5Q9h04jQTHVhZurnEUUHu8V5CoGFyWT9/5dLbe68DTMLmS
	 VPrirGt+Tzdrb8VqzL0vZf8gT0ByL3QnXI82dRxff78p7rjjqYmB4od2PSXB+Mmuhc
	 NeoYwIanCZKRP0bUaoTLEmmXOk/yY4mAm5Pczb7pHGr0j4KMafUyy7X1wd0Uh8v+R+
	 Ku6Koi8JRz7MeMeN8ImW6L51YxiqEq1VftqKyjAxUIKLPRbAdysQ1TCl5g64K/fe5c
	 BJrJkBW8aooV3XzTS7b1RXtfnyWNJugOG+a7zWe5jbOTdXt+eTN7iVyW/qA7dWFMi8
	 3br+Py1pOjUbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223267>

Several people have made similar mistakes in beliving that "git
submodule init" can be used for adding submodules to a working
directory, whereas "git submodule add" is the command that should be
used.  That *is* documented at the top of the manual page for "git
submodule", but my error was enhanced by a subtle error in the
documentation of "init".

The text as it is written suggests that init's behavior is driven by
the contents of .submodules.  But in fact, its behavior is driven by
the existing gitlinks in the file tree, possibly limited by the <path>
arguments.  (Which is *why* "git submodule init" can't *add*
submodules; it only processes *existing* submodules.)

I would like to suggest that the manual page be updated to remove the
error in the description of the init subcommand, along with another
addition to tell the submodule logical name that is used by the "add"
subcommand:

--- man1	2013-04-26 12:02:16.752702146 -0400
+++ man3	2013-05-02 21:06:00.020353100 -0400
@@ -61,6 +61,8 @@
            to exist in the superproject. If <path> is not given, the
            "humanish" part of the source repository is used ("repo" fo=
r
            "/path/to/repo.git" and "foo" for "host.xz:foo/.git").
+           The <path> is used as the submodule's logical name in its
+           configuration entries.
=20
            <repository> is the URL of the new submodule=E2=80=99s orig=
in repository.
            This may be either an absolute URL, or (if it begins with .=
/ or
@@ -109,7 +111,9 @@
            too (and can also report changes to a submodule=E2=80=99s w=
ork tree).
=20
        init
-           Initialize the submodules, i.e. register each submodule nam=
e and
+           Initialize the submodules, i.e. register each submodule for=
 which
+           there is a gitlink recorded (or the specific gitlinks speci=
fied by
+           <path> ...) by copying the name and
            url found in .gitmodules into .git/config. The key used in
            .git/config is submodule.$name.url. This command does not a=
lter
            existing information in .git/config. You can then customize=
 the
@@ -118,6 +122,10 @@
            submodule update --init without the explicit init step if y=
ou do
            not intend to customize any submodule locations.
=20
+           (Because init only operates on existing gitlinks, it cannot
+           be used to create submodules, regardless of the contents of
+           .gitmodules.  Use the add subcommand to create submodules.)
+
        update
            Update the registered submodules, i.e. clone missing submod=
ules and
            checkout the commit specified in the index of the containin=
g

Dale
