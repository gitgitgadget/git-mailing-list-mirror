From: Brian Gernhardt <benji@silverinsanity.com>
Subject: git-cvsserver test failures (still)
Date: Wed, 3 Oct 2007 15:50:18 -0400
Message-ID: <A78B5F62-4FCC-4650-9B0D-0F64FEDB8423@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 21:50:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdAEY-00042m-Ts
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 21:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbXJCTuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 15:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909AbXJCTuG
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 15:50:06 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59546 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbXJCTuF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 15:50:05 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id E72AA28BC04D
	for <git@vger.kernel.org>; Wed,  3 Oct 2007 19:50:03 +0000 (UTC)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59872>

Periodically I am reminded that the git-cvsserver does not pass it's  
tests (t9400-git-cvsserver.sh) on my machine, so I once again ask for  
help.  The failing tests are: (they say skip because this is from the  
last "find other errors" run)

* skip 9: req_Root failure (strict-paths)
* skip 11: req_Root failure (w/o strict-paths)
* skip 13: req_Root failure (base-path)

No other tests fail, including other req_Root failure tests :

*   ok 6: req_Root failure (relative pathname)
*   ok 7: req_Root failure (conflicting roots)
*   ok 15: req_Root failure (export-all w/o whitelist)

All three tests fail with the exact same error log:

E /Users/brian/dev/git/t/trash/gitcvs.git/ does not seem to be a  
valid GIT repository
E
error 1 /Users/brian/dev/git/t/trash/gitcvs.git/ is not a valid  
repository
E Invalid root /Users/brian/dev/git/t/trash/gitcvs.git

This appears to be from git-cvsserver.perl:148-9:

     req_Root('root', $line) # reuse Root
        or die "E Invalid root $line \n";

This fails the test suite because die() exits with code 255 (checked  
with "perl -e 'die'; echo $?"), which is outside what  
test_expect_failure accepts (see t/test-lib.sh:179).

My questions become:
1) Why hasn't this hit anyone else?
2) Is this where these tests are supposed to fail?
3) If it is, should the code be using print and exit 1 instead of die?
4) If not, should the test be altered to end with "|| false" or  
similar so the test passes?

I'd happily submit a patch to fix this, but don't know what the  
correct fix is.

~~ Brian Gernhardt
