From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: can I always ignore a file during a merge?
Date: Wed, 27 Jun 2012 19:39:03 -0400
Message-ID: <p06240817cc114629c20f@[192.168.1.122]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 01:45:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk1vB-0005KB-UM
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 01:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076Ab2F0XpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 19:45:11 -0400
Received: from deanbrook.org ([72.52.70.192]:41410 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754013Ab2F0XpK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 19:45:10 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jun 2012 19:45:10 EDT
Received: from ::ffff:96.240.224.49 ([96.240.224.49]) by deanbrook.org for <git@vger.kernel.org>; Wed, 27 Jun 2012 16:39:22 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200772>

Is there a way to merge from branchA to branchB and from branchB to branchA while completely ignoring changes to a file that is 
tracked and exists in both branches?

---- details ----

I have two branches in my project (master and energy2d)  automatically being built and tested on travis-ci:

   http://travis-ci.org/#!/concord-consortium/lab

When failures in tests occur notifications are sent to emails in a configuration file checked into each branch:

   master:
   https://github.com/concord-consortium/lab/blob/master/.travis.yml

   energy2d:
   https://github.com/concord-consortium/lab/blob/energy2d/.travis.yml

I regularly merge work in the energy2d branch into master and the Google Summero of Code student I am working with regularly 
merges changes in master into energy2d.

I would like to be able to merge both directions while completely ignoring changes in the travis-ci configuration files in each 
branch.

I have tried creating a .gitattributes file in each branch with the following content:

   .travis.yml merge=ours

But when interpreted by the default merge strategy "recursive" this only applies when there are conflicts -- however this 
current difference is not seen as a conflict:

   $ git diff energy2d .travis.yml
   diff --git a/.travis.yml b/.travis.yml
   index 8ea58dc..ec89f91 100644
   --- a/.travis.yml
   +++ b/.travis.yml
   @@ -8,7 +8,8 @@ notifications:
      email:
        recipients:
          - stephen.bannasch@gmail.com
   -      - janikpiotrek@gmail.com
   +      - sfentress@concord.org
   +      - rpk@pobox.com
    language: node_js
    node_js:
      - 0.6

Which means every time we merge the .travis.yml file is updated on the branch we are merging to.
