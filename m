From: Seth Robertson <in-gitvger@baka.org>
Subject: [PATCH] Re: .gitignore Bug Report on the behavior of *
Date: Sat, 25 Sep 2010 16:40:39 -0400
Message-ID: <201009252040.o8PKedbo004741@no.baka.org>
References: <201009251923.o8PJNJYE031841@no.baka.org>
        <201009252203.48820.j6t@kdbg.org>
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Sep 25 22:40:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzbYC-000319-9x
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 22:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442Ab0IYUkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 16:40:46 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:50403 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab0IYUkp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 16:40:45 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id o8PKeeRX019641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Sep 2010 16:40:40 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id o8PKedbo004741;
	Sat, 25 Sep 2010 16:40:39 -0400
In-reply-to: <201009252203.48820.j6t@kdbg.org>
Comments: In reply to a message from "Johannes Sixt <j6t@kdbg.org>" dated "Sat, 25 Sep 2010 22:03:48 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157197>


In message <201009252203.48820.j6t@kdbg.org>, Johannes Sixt writes:

    On Samstag, 25. September 2010, Seth Robertson wrote:
    > # Properly shows X and B/XX as untracked, as I expected
    > echo X > X; echo XX > B/XX; git status
    >
    > # I expected B/XX to show up as untracked
    > rm -f .gitignore B/.gitignore
    > echo '*' > .gitignore; echo '!*' > B/.gitignore; git status

    You should update your expectations to match what you got. ;-)

    To show why your expectations are wrong, consider a *huge* and
    *deep* directory with thousands and thousands of subdirectories,
    call it "usr", that should be ignored. The .gitignore at the
    top-level would just say:

      /usr

    Do you really expect git to walk down this ignored directory, just to make
    double-sure that really, really down there does nowhere exist a .gitignore
    that says "oh, wait, don't ignore *this* file"?

Hmm.  No, not really, but having a .gitignore in a directory which has
tracked git files in it seems somehow different, and at least to me the
documentation of .gitignore suggests a different algorithm.  How about
this for a documentation patch?

Signed-off-by: Seth Robertson <in-gitvger@baka.org>
----------------------------------------------------------------------
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 7dc2e8b..4f825d8 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -33,6 +33,8 @@ precedence, the last matching pattern decides the outcome):
    as the path, or in any parent directory, with patterns in the
    higher level files (up to the toplevel of the work tree) being overridden
    by those in lower level files down to the directory containing the file.
+   Any pattern causing a directory to be ignored will cause
+   any `.gitignore` file under that dirctory to be ignored.
    These patterns match relative to the location of the
    `.gitignore` file.  A project normally includes such
    `.gitignore` files in its repository, containing patterns for
