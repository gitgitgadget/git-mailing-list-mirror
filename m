From: Heiko Voigt <git-list@hvoigt.net>
Subject: [PATCH v2 0/1] cvsimport: add test illustrating a bug in cvsps
Date: Mon, 02 Mar 2009 18:59:08 +0100
Message-ID: <49AC1E6C.7060100@hvoigt.net>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 02 19:00:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeCRb-0000Ye-52
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 19:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963AbZCBR7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 12:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754331AbZCBR7O
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 12:59:14 -0500
Received: from darksea.de ([83.133.111.250]:38858 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752435AbZCBR7N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 12:59:13 -0500
Received: (qmail 22180 invoked from network); 2 Mar 2009 18:58:58 +0100
Received: from unknown (HELO macbook.lan) (127.0.0.1)
  by localhost with SMTP; 2 Mar 2009 18:58:58 +0100
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <49A37ED1.5090506@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111953>

Hallo,

here is the second version of my patch with one more test for cvsimport.
This mail is just for documentation what has been fixed since the first
version.

Michael Haggerty schrieb:
> Heiko Voigt wrote:
>> Some cvs repositories may have time deviations in their recorded commits. This
>> is a test for one of such cases. [...]
> 
> Based on the numbering of your test, it looks like you've seen my
> proposed patch [1].  If my patch is accepted, it would make sense for
> yours to use the lib-cvs.sh library that I started.  But I guess that
> can be changed if and when my patch is accepted.

Indeed, I saw your patches which actually let me start to work on tests
of the problems I have found in cvsimport. I have already switched to
your library because I did not like to copy that code in the first
place. So this patch is now dependent on your series.

> To share the most test code, it would help to choose the same CVS module
> name for each test when possible.  I imitated t9600 and named the CVS
> modules in my tests "module", and for now the library assumes that name.
>  Unless there is a special reason to use the module name "time", you
> might think of renaming it, and similarly renaming your conversion
> directory "module-git".

Done.

> 
>> +test_expect_success 'import with criss cross times on revisions' '
> 
> Since this test is known to fail, I think it should be
> "test_expect_failure".

Adapted. I was not aware that this function marked a known bug. Sounded
to me like "if this test does succeed its an error".

> 
>> diff --git a/t/t9603/cvsroot/CVSROOT/.empty b/t/t9603/cvsroot/CVSROOT/.empty
>> new file mode 100644
>> index 0000000..e69de29
> 
> I suggest adding a .gitignore file instead of .empty to keep the CVSROOT
> directory around, and in it to list the filenames "history" and
> "val-tags" (which are created by some cvs commands).  This will preserve
> a clean "git status" even after running the test.

Done.

>> diff --git a/t/t9603/cvsroot/time/a,v b/t/t9603/cvsroot/time/a,v
>> new file mode 100644
>> index 0000000..66a96aa
>> --- /dev/null
>> +++ b/t/t9603/cvsroot/time/a,v
>> [...]
> 
> To avoid complaints from "git diff --check" about trailing whitespace in
> the *,v files, you can add a file .gitattributes in your cvsroot
> directory, containing the line "* -whitespace".  There is also trailing
> whitespace in t9603-cvsimport-time.sh that can simply be deleted.

That would have been another possibility. I actually deleted the
whitespace in the ,v files which seems to cause no problems. 

I share Michael's opinion that fixing these issues in cvsps are probably
not worth the effort. It did fix a few but ultimately gave up when
finding this one. Knowing that there are other tools available that do
the job more robust I would vote to switch to a new import tool if that
is possible. Also the users could be pointed to a more robust one in the
documentation like cvs2svn or parsecvs (which I found quite useful
because tag exactness was not that important)

cheers Heiko
