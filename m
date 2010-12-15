From: "Vallon, Justin" <Justin.Vallon@deshaw.com>
Subject: RE: disallowing non-trivial merges on integration branches
Date: Wed, 15 Dec 2010 17:04:26 -0500
Message-ID: <982E526FA742C94E9AC26DA766FD07090A337E@NYCMBX3.winmail.deshaw.com>
References: <loom.20101215T185931-347@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "'Adam Monsen'" <haircut@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 15 23:24:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSzlr-00044N-Af
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 23:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab0LOWYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 17:24:22 -0500
Received: from master.nyc.deshaw.com ([149.77.10.1]:51951 "EHLO
	master.nyc.deshaw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681Ab0LOWYU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Dec 2010 17:24:20 -0500
X-Greylist: delayed 1072 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2010 17:24:20 EST
Received: from winmail.deshaw.com ([149.77.228.32])
 by master.nyc.deshaw.com (8.13.8+Sun/8.13.7/2.0.kim.desco.357) with ESMTP id oBFM6QVX011267
 for <git@vger.kernel.org>; Wed, 15 Dec 2010 17:06:26 -0500 (EST)
Received: from NYCMBX3.winmail.deshaw.com ([149.77.72.43]) by
 maildrcas1.winmail.deshaw.com ([149.77.228.32]) with mapi; Wed, 15 Dec 2010
 17:06:26 -0500
Thread-Topic: disallowing non-trivial merges on integration branches
Thread-Index: AcuchcRFrSRm+dsnSsiHQjvWI0n/IAAG2osA
In-Reply-To: <loom.20101215T185931-347@post.gmane.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163793>

My two cents:

* Rebase is evil (grab your pitchforks!).

* One thing that I have found is that if you fetch/merge --no-ff in the authoritative repo, then you actually end up with a better graph.  Why?  If you allow fast-forward to the contributor, then in the case of a trivial merge on the contributor branch, the contributor will have merged master *into* the contributor branch, making the contributor the left-parent, and the master the right-parent.  If you 'merge --no-ff', then you insure that in the merge on master, the left-parent is master, and the right-parent is your contributor.  Then, you should be able to follow left-parents to trace your mainline.  Not sure if that would help your gitk graph.

* It sounds like you have a problem following the merges.  Maybe the grapher needs to be enhanced?

-- 
-Justin


-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of Adam Monsen
Sent: Wednesday, December 15, 2010 1:27 PM
To: git@vger.kernel.org
Subject: disallowing non-trivial merges on integration branches

Does anyone have or want to help with a hook script to prevent trivial merges?

Here's some context:

I'm using the phrase "trivial merge" to refer to a merge without conflicts, 
like, when two distinct files are edited.

In the Mifos project, the "head" repo at sf.net--for all intents and purposes--
is the authoritative place to find Mifos source code. At my request, many of the 
devs pushing to "head" have started using rebase more often than merge when 
their local copy of a branch diverges from the corresponding remote[1] (for 
example, I commit to my "master", but must fetch then merge or rebase before 
pushing to origin/master). Liberal use of rebase has really cleaned up our 
version history graph... it's much easier to see what was pushed and when, and 
the progression of patches. Trivial merges just don't add anything helpful to 
the commit history graph, IMHO. Non-trivial merges are of course still allowed. 
Rebasing commits extant in the "head" repo at sf.net is disallowed.

I've been working on a hook script[2] to disallow trivial merges to further 
enforce our policy. Well, really I'm just working on the test suite[3], another 
guy (also named Adam, coincidentally) is working on the hook script.

A blocking bug with the hook script (might be a design flaw) is that it prevents 
non-trivial merges.

Wanna help fix it?

I don't understand the hook script... is it doing something that makes sense?

This was my first time writing a test harness in Bash script. Kinda fun, 
actually. Git certainly lends well to scripting, and it feels intentional. Good 
stuff.

References (links) from the above email:
1. http://article.gmane.org/gmane.comp.finance.mifos.devel/9597
2. http://stackoverflow.com/questions/4138285
3. https://gist.github.com/737842

