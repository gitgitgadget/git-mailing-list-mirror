From: Thomas Koch <thomas@koch.ro>
Subject: rethinking patch management with GIT / topgit
Date: Sat, 20 Mar 2010 18:02:51 +0100
Message-ID: <201003201802.51129.thomas@koch.ro>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, vcs-pkg-discuss@lists.alioth.debian.org
X-From: git-owner@vger.kernel.org Sat Mar 20 18:30:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt2V0-000327-6V
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 18:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab0CTRaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 13:30:00 -0400
Received: from koch.ro ([88.198.2.104]:60119 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465Ab0CTR37 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 13:29:59 -0400
X-Greylist: delayed 1616 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Mar 2010 13:29:59 EDT
Received: from 138-229.76-83.cust.bluewin.ch ([83.76.229.138] helo=jona.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1Nt21e-0004lo-2U; Sat, 20 Mar 2010 17:59:50 +0100
User-Agent: KMail/1.12.4 (Linux/2.6.32-2-amd64; KDE/4.3.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142727>

Hi,

I'd like to argue, that topgit (tg) fails to fullfill it's task and propose a 
different approach to the problem of patch management on top of git.

IMHO tg fails due to the following reasons:

- it's to complicate
- AFAIK nobody has solved the problem of managing different patchsets with tg
- it pollutes the patch branches with metadata (.topmsg, .topdeps)
- even after 1 1/2 years topgit isn't feature complete and development seems 
to stagnate
- there also aren't best practices documented
- it quickly fills the list of branches
- it's very easy to break something

Although the above is quite a harsh judgement, I'd like to note, that tg has 
had its merrit to promote one right idea: Patches should be managed in the 
form of branches by the means of the underlying VCS and not as simple 
patchfiles.

The new approach I'd like to propose is based on two core ideas:

1) merge commits to save history

git allows the free creation of merge commits with an arbitrary content tree. 
So we can create an octupus merge combining all patch-branches while the 
content of this merge can contain meta data about a patchset instead of the 
content of the merged commits.
Such a merge commit thus provides a pointer to all the history of all patches 
and can contain all metadata about the merged patch branches. Pushing only a 
branch or tag with this commit to a central repository thus pushes all the 
history of all contained patches.

2) collapse / expand branches

Managing a Debian package in stable, unstable and experimental can quickly 
doom you to manage at least three different patchsets with possibly three 
different roots. The list of branches grows in the douzens. Which branches 
belong to which patchset? Which branches are already pushed or pulled?
It may be an advantage to see only some main branches and the branches of one 
patchset I'm currently working on.
The tool I propose would manage each patchset in one branch per patchset. This 
branch has two roles:
- keep the metadata of the patchset as files in the content tree
- keep pointers to the top of the patch-branches in the parent pointers of the 
commit
With the help of such a patchset-metadata-branch I can:
- delete the patch-branches of one patchset while the commits are kept save
- recreate the patch-branches of one patchset

For Debian packaging one last function is needed: export a patchset as quilt 
series.

Is my explanation understandable? Could this approach work or did I miss 
something? Who has time to implement it (GSOC?)?

Best regards,

Thomas Koch, http://www.koch.ro
