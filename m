From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Failure in t5516, tests 15 and 16
Date: Tue, 26 Jun 2007 21:29:45 -0400
Message-ID: <CFDE3792-403B-4582-B7FB-BC142B79AE63@silverinsanity.com>
References: <4FAE3A62-A0D1-4C88-8413-88F1D75A2730@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 27 03:30:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3MM5-0003Q3-2E
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 03:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128AbXF0B3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 21:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756174AbXF0B3v
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 21:29:51 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:34963 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006AbXF0B3u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 21:29:50 -0400
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 350DB1FFC1CF
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 01:29:49 +0000 (UTC)
In-Reply-To: <4FAE3A62-A0D1-4C88-8413-88F1D75A2730@silverinsanity.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50997>


On Jun 22, 2007, at 10:50 AM, Brian Gernhardt wrote:

> Tests 15 and 16 in script "t5516-fetch-push.sh" fails with "notice:  
> HEAD points to an unborn branch (master)".  Is this just bad tests  
> or an actual failure?  This is with current master  
> (45fd8bd32dd68ce6b14a406d0abbd6f56490131c) on OS X.

Okay, I just did used the wonderful "git bisect run" to find out  
where this error started happening.  The answer appears to be in the  
first commit the tests appeared in:  
1ed10b886bc69c129c06772ee4310c00e001657f

I dislike that immensely.  Can anyone help me figure out why the test  
fails?  There is no error message printed.  I thought the "HEAD  
points to an unborn branch" was the error, but that doesn't seem to  
be it.

Again, the test results are below.

~~ Brian

----- 8< -----

* expecting success:

         mk_test &&
         if git show-ref --verify -q refs/tags/frotz
         then
                 git tag -d frotz
         fi &&
         git branch -f frotz master &&
         git push testrepo frotz &&
         check_push_result $the_commit heads/frotz &&
         test "$( cd testrepo && git show-ref | wc -l )" = 1

Initialized empty Git repository in .git/
notice: HEAD points to an unborn branch (master)
notice: No default references
Deleted tag frotz.
updating 'refs/heads/frotz'
   from 0000000000000000000000000000000000000000
   to   9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f
Generating pack...
Done counting 5 objects.
Deltifying 5 objects...
  100% (5/5) done
Writing 5 objects...
  100% (5/5) done
Total 5 (delta 0), reused 0 (delta 0)
Unpacking 5 objects...
  100% (5/5) done
refs/heads/frotz: 0000000000000000000000000000000000000000 ->  
9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f
notice: HEAD points to an unborn branch (master)
* FAIL 15: push with colon-less refspec (3)


                 mk_test &&
                 if git show-ref --verify -q refs/tags/frotz
                 then
                         git tag -d frotz
                 fi &&
                 git branch -f frotz master &&
                 git push testrepo frotz &&
                 check_push_result $the_commit heads/frotz &&
                 test "$( cd testrepo && git show-ref | wc -l )" = 1


* expecting success:

         mk_test &&
         if git show-ref --verify -q refs/heads/frotz
         then
                 git branch -D frotz
         fi &&
         git tag -f frotz &&
         git push testrepo frotz &&
         check_push_result $the_commit tags/frotz &&
         test "$( cd testrepo && git show-ref | wc -l )" = 1


Initialized empty Git repository in .git/
notice: HEAD points to an unborn branch (master)
notice: No default references
Deleted branch frotz.
updating 'refs/tags/frotz'
   from 0000000000000000000000000000000000000000
   to   9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f
Generating pack...
Done counting 5 objects.
Deltifying 5 objects...
  100% (5/5) done
Writing 5 objects...
  100% (5/5) done
Total 5 (delta 0), reused 0 (delta 0)
Unpacking 5 objects...
  100% (5/5) done
refs/tags/frotz: 0000000000000000000000000000000000000000 ->  
9ad36e1e54b2130a20d55abb4f0f3ca8494ead3f
notice: HEAD points to an unborn branch (master)
* FAIL 16: push with colon-less refspec (4)


                 mk_test &&
                 if git show-ref --verify -q refs/heads/frotz
                 then
                         git branch -D frotz
                 fi &&
                 git tag -f frotz &&
                 git push testrepo frotz &&
                 check_push_result $the_commit tags/frotz &&
                 test "$( cd testrepo && git show-ref | wc -l )" = 1



* failed 2 among 16 test(s)
