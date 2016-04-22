From: Ben Woosley <ben.woosley@gmail.com>
Subject: Re: make test Unexpected passes
Date: Fri, 22 Apr 2016 23:16:16 +0000 (UTC)
Message-ID: <loom.20160423T011428-888@post.gmane.org>
References: <571A8404.5030200@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 01:55:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atkur-0001e1-3U
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 01:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbcDVXzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 19:55:11 -0400
Received: from plane.gmane.org ([80.91.229.3]:49548 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbcDVXzK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 19:55:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1atkuh-0001XF-88
	for git@vger.kernel.org; Sat, 23 Apr 2016 01:55:07 +0200
Received: from c-73-189-198-63.hsd1.ca.comcast.net ([73.189.198.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Apr 2016 01:55:07 +0200
Received: from ben.woosley by c-73-189-198-63.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Apr 2016 01:55:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 73.189.198.63 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292292>

Ramsay Jones <ramsay <at> ramsayjones.plus.com> writes:

> 
> Hi Ben, Junio,
> 
> Tonight, the testsuite passed with a couple of 'unexpected passes', viz:
>
> In the first case, t3421-*.sh, git bisect fingered commit f32ec670
> ("git-rebase--merge: don't include absent parent as a base", 20-04-2016).
>
> ATB,
> Ramsay Jones
> 
 
Yep,

These know breakages:

ok 50 - rebase -m --onto --root
ok 54 - rebase -m without --onto --root with disjoint history

Have to do with rebasing a root/orphan branch with the -m flag,
which defaults to -- merge=recursive, which is the case the patch fixed.

Here are the necessary changes:

--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -253,7 +253,7 @@ test_run_rebase () {
 	"
 }
 test_run_rebase success ''
-test_run_rebase failure -m
+test_run_rebase success -m
 test_run_rebase success -i
 test_run_rebase success -p
 
@@ -268,7 +268,7 @@ test_run_rebase () {
 	"
 }
 test_run_rebase success ''
-test_run_rebase failure -m
+test_run_rebase success -m
 test_run_rebase success -i
 test_run_rebase failure -p
 
-- 
2.8.1.211.g8e54d77
