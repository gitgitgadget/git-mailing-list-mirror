From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] cvsimport: add test illustrating a bug in cvsps
Date: Tue, 24 Feb 2009 06:00:01 +0100
Message-ID: <49A37ED1.5090506@alum.mit.edu>
References: <49A2EFC6.5000104@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Heiko Voigt <git-list@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 06:01:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbpQG-00046v-Eh
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 06:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbZBXFAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 00:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbZBXFAJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 00:00:09 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:43257 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbZBXFAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 00:00:07 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.129] (77-21-84-251-dynip.superkabel.de [77.21.84.251])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n1O503qO006093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 24 Feb 2009 06:00:04 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20090105 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <49A2EFC6.5000104@hvoigt.net>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111207>

Heiko Voigt wrote:
> Some cvs repositories may have time deviations in their recorded commits. This
> is a test for one of such cases. [...]

Based on the numbering of your test, it looks like you've seen my
proposed patch [1].  If my patch is accepted, it would make sense for
yours to use the lib-cvs.sh library that I started.  But I guess that
can be changed if and when my patch is accepted.

To share the most test code, it would help to choose the same CVS module
name for each test when possible.  I imitated t9600 and named the CVS
modules in my tests "module", and for now the library assumes that name.
 Unless there is a special reason to use the module name "time", you
might think of renaming it, and similarly renaming your conversion
directory "module-git".

> +test_expect_success 'import with criss cross times on revisions' '

Since this test is known to fail, I think it should be
"test_expect_failure".

> diff --git a/t/t9603/cvsroot/CVSROOT/.empty b/t/t9603/cvsroot/CVSROOT/.empty
> new file mode 100644
> index 0000000..e69de29

I suggest adding a .gitignore file instead of .empty to keep the CVSROOT
directory around, and in it to list the filenames "history" and
"val-tags" (which are created by some cvs commands).  This will preserve
a clean "git status" even after running the test.

> diff --git a/t/t9603/cvsroot/time/a,v b/t/t9603/cvsroot/time/a,v
> new file mode 100644
> index 0000000..66a96aa
> --- /dev/null
> +++ b/t/t9603/cvsroot/time/a,v
> [...]

To avoid complaints from "git diff --check" about trailing whitespace in
the *,v files, you can add a file .gitattributes in your cvsroot
directory, containing the line "* -whitespace".  There is also trailing
whitespace in t9603-cvsimport-time.sh that can simply be deleted.

Michael

[1] http://www.spinics.net/lists/git/msg95366.html
