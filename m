From: Mikko Rantalainen <mikko.rantalainen@peda.net>
Subject: Porcelain support for daggy-fixes?
Date: Thu, 10 Jun 2010 16:55:10 +0300
Message-ID: <4C10EEBE.5030400@peda.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 10 16:03:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMiLm-0004w5-Sj
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 16:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759173Ab0FJODN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 10:03:13 -0400
Received: from posti8.jyu.fi ([130.234.5.35]:39056 "EHLO posti8.jyu.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040Ab0FJODM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 10:03:12 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jun 2010 10:03:12 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by posti8.jyu.fi (8.13.8/8.13.8) with ESMTP id o5ADtImf019193;
	Thu, 10 Jun 2010 16:55:18 +0300
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Received: from posti8.jyu.fi ([127.0.0.1])
	by localhost (posti8.jyu.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nsjkrsAtYsMq; Thu, 10 Jun 2010 16:55:11 +0300 (EEST)
Received: from [130.234.78.125] (semyol-329-b.ktl.jyu.fi [130.234.78.125])
	(authenticated bits=0)
	by posti8.jyu.fi (8.13.8/8.13.8) with ESMTP id o5ADtAhm019186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Jun 2010 16:55:11 +0300
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148876>

Introduction: http://monotone.ca/wiki/DaggyFixes/

I understand that this can already be done with git. The method is

1) store the current HEAD somewhere
2) figure out the proper parent for the bug fix
3) checkout the parent
4) implement the fix
5) commit the fix
6) checkout HEAD
7) merge with the commit from step 5

Is there some way to do this more automatically? The way I think this
should be done:

1) fix a bug that you just found (let's imagine for a second that you
just happened to know how to fix the bug without knowing the history of bug)
2) git commit (the bugfix is now the tip of the HEAD)
3) git daggy-fix

And you're done.

Here the magical "daggy-fix" would do the following:

"Remove" the change HEAD^..HEAD from the current branch, try to
recursively apply the patch to ancestors of HEAD and locate oldest
parent that the patch can be automatically applied to without a
conflict. Let's call this parent BUG (best guess for the original commit
that introduced the bug). Commit the patch as a new child of BUG and
then merge with HEAD^ (from the moment daggy-fix was executed). Checkout
the new HEAD to replace the original HEAD.

In short, replace the current tip of the current branch with the merge
of last commit rebased as the bugfix for historical commit and HEAD^.

Logical syntax for this command could be

git daggy-fix fix-commit-id bug-commit-id

where
fix-commit-id is the commit that should be relocated and re-merged
bug-commit-id is the commit that introduced the bug (no need for
automatic detection of the parent)

both commit id's are optional.

Does this sound reasonable or is there already some better way?

-- 
Mikko
