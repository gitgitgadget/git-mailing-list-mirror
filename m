From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git workflow for beta/production
Date: Tue, 15 Mar 2011 08:10:33 -0400
Message-ID: <1300191033.18178.41.camel@drew-northup.unet.maine.edu>
References: <324BE2A8-5987-4324-AE27-D5CC01341710@appnexus.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joseph Huttner <jhuttner@appnexus.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 13:11:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzT5k-0000Ae-8l
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 13:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757526Ab1COMKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 08:10:55 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:55844 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757105Ab1COMKy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 08:10:54 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p2FCAf4M010059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Mar 2011 08:10:41 -0400
In-Reply-To: <324BE2A8-5987-4324-AE27-D5CC01341710@appnexus.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p2FCAf4M010059
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1300795844.18939@wdsl/J0n88RGMGlVKkj8aQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169065>


On Mon, 2011-03-14 at 15:27 -0700, Joseph Huttner wrote:
> I am in search of a new Git workflow.  Previously, my team was
> essentially using using gitflow by Vincent Driessen (nvie).  It worked
> very well, but the needs of project have changed, so here are the new
> requirements:
> 
> 1.  A "Beta" environment that contains stable code for all features
> being considered for "Production."
> 2.  A "Production" environment.  Rock-solid, well-tested code only.  
> 
> The catch is that after a feature has been stomped on in Beta, it
> **may** go to Production, but only if Product Managers still think it
> is an important feature.  In other words, there is no guarantee that a
> feature in Beta will ever make it to Production.  It may be axed
> completely, in which case it would never get to Production and would
> be taken out of Beta.  Also, there is no guarantee that features that
> do make it to Production will go in in the order that they went in to
> Beta.  

Hi Joseph,
First off, don't discard the baby with the bathwater. If Nvie's workflow
was working for you don't discard it completely and outright--that's
just asking for problems. Second, don't be afraid to be aggressive about
rewinding your "beta" branch (as noted that's "next" around here at
git.git, but "pu" might be an even better model).
It sounds to me as if just one additional "branch family"--a "customer"
beta--could be added to Nvie's base structure to accomplish what you
need. The policy on this new track would be to expect it to be
rewound/rebased/restructured frequently. From there whole features would
be picked out (per management decision) and put into the equivalent of
the "[proposed] release" branches and whole public releases pushed from
there to master ("release" would therefore also be rewound as
needed--hopefully not very often) for packaging. The major change in
code flow is that things no longer migrate back from "release" to
"development" (bleeding-edge), "beta" (aka a "customer beta"--which is
what your management team seems to be asking for), or anywhere other
than master--basically making "release" a clean-room version of beta
with no new code in it.
I would not advise outright discarding of any "hotfixes" branch you
have, I would just make it merge to master only via "beta" and "release"
except in cases of emergency. Let the management team decide what
qualifies as that kind of emergency.

Why continue to have the "release" branch at all? Well, it sounds to me
as if you are being asked to make absolutely certain that what makes it
to master (and therefore what makes it to your packagers) is tested as a
whole unit. You can't do that cherry-picking directly from beta to
master (customer production code). Having the "clean-room" post-beta
"rc" branch gives you a safe place to do this--good for cases when
somebody insists on including "feature y" from the customer beta without
also including "feature x" forgetting that y depends on x to build or
run properly. This should have all been hashed out in beta--but that's
harder to do when beta is considered to be a "new feature customer demo"
branch as well as "beta" branch. So, the moral of the story is roll
stuff into a safe place after the "feature demo" beta for approval and
unit testing before pushing to master and risking causing confusion in
the ranks of the packaging team. (It is never good when a customer hears
that a vendor didn't mean for them to be sent version n.xx of the
production code but instead meant to send them n.xy.)

Good luck!

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
