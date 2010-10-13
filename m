From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [RFC] Hidden refs
Date: Wed, 13 Oct 2010 11:22:11 -0400
Message-ID: <4CB5CEA3.8020702@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 17:21:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6398-0000aQ-AK
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 17:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab0JMPVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 11:21:30 -0400
Received: from smtp142.iad.emailsrvr.com ([207.97.245.142]:35310 "EHLO
	smtp142.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab0JMPV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 11:21:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp44.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 23A33128245;
	Wed, 13 Oct 2010 11:21:29 -0400 (EDT)
X-Orig-To: git@vger.kernel.org
X-Orig-To: mbranchaud@xiplink.com
X-Virus-Scanned: OK
Received: by smtp44.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 03F4C1284FC;
	Wed, 13 Oct 2010 11:21:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158938>

Hi all,

We want to have our build system record, in our repo, which commits
correspond to which builds.

Nominally, this is a job for tags.  But we don't want to have to look at
these tags all the time.  We particularly just want to tag the repo when we
make an actual release -- tags are a Big Deal for us.

Notes are an option, though they feel a bit heavy for this application.  And
although we can store the build notes in their own refspace, it would (I
believe) be a little clunky to make commands like checkout and log work with
the commits that were noted by the build system.

It struck me that it would be neat to have hidden refs in the refs/
directory.  I experimented a bit with a "refs/.builds" directory:

* "git update-ref refs/.builds/One" fails with "Cannot lock the
  ref 'refs/.builds/One'."  So I created a ref the regular way
  (refs/blah/One) and copied the "One" file into refs/.builds/.

* Commands like show, checkout, and log all worked fine with
  "refs/.builds/One"

* "git show-ref" ignores the entries in refs/.builds/.

* So the .builds/ refs don't show up in gitk -- yay!

* "git push origin +refs/.builds/One fails with "remote part of refspec is
not a valid name in +refs/.builds/One".

* Completion in bash doesn't work with entries in refs/.builds/.

So I'm wondering if it makes sense to properly support hidden directories in
refs/, and what it would take to do so.  (I image, for example, that things
would behave quite differently on Windows...)

Thoughts?

		M.
