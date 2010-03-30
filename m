From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: mirror git repos: rsync vs. --mirror
Date: Tue, 30 Mar 2010 20:54:09 +0000
Message-ID: <robbat2-20100330T205331-531407911Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 23:01:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwiZB-00015s-L8
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 23:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167Ab0C3VBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 17:01:36 -0400
Received: from [208.71.112.51] ([208.71.112.51]:55301 "EHLO mail.isohunt.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753360Ab0C3VBf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 17:01:35 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Mar 2010 17:01:35 EDT
Received: (qmail 28388 invoked from network); 30 Mar 2010 20:54:12 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (CAMELLIA256-SHA encrypted) ESMTPS; Tue, 30 Mar 2010 20:54:12 +0000
Received: (qmail 2525 invoked by uid 10000); 30 Mar 2010 20:54:09 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143602>

I'm trying to see about the state of automated mirroring git
repositories between different systems, eg. a private backend and a
public frontend, and ran into a catch between two possible options, each
with a downside. If there are other means besides these, I'm all ears
for them.

rsync:
------
How:
- Simply rsync the git repository, atomically, and use --delete-after.
Benefits:
- Guaranteed to match between master/slaves.
Caveats:
- Need to know that the master repo is in a good state.
- If a repo is repacked, there is a lot more traffic in the next sync.

git clone --mirror && git fetch:
--------------------------------
How:
- Setup with: "git clone --mirror URL"
- Cronjob with: "git fetch"
Benefits:
- Extremely fast
- Light on traffic
Caveats:
- Branches and tags deleted in master persist in slaves :-(
- Seperate gc/repack needed on slaves.

The traffic vs. deleted branches/tags is the main tradeoff here, esp. as
repos get larger.

Can git-fetch perhaps be made to delete the branches/tags?

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
