From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH v2] request-pull: avoid mentioning that the start point is
 a single commit
Date: Fri, 29 Jan 2010 15:17:59 +0100
Message-ID: <20100129141759.GY12429@genesis.frugalware.org>
References: <20100129011817.GT12429@genesis.frugalware.org>
 <7vfx5pjrgm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 15:18:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Narfo-0007b0-G3
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 15:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606Ab0A2OSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 09:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754502Ab0A2OSF
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 09:18:05 -0500
Received: from virgo.iok.hu ([212.40.97.103]:56165 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab0A2OSE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 09:18:04 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 36C3C58055;
	Fri, 29 Jan 2010 15:18:00 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2294144965;
	Fri, 29 Jan 2010 15:17:59 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E3EF71240002; Fri, 29 Jan 2010 15:17:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfx5pjrgm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138318>

Previously we ran shortlog on the start commit which always printed
"(1)" after the start commit, which gives no information, but makes the
output less easy to read. Avoid doing so.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, Jan 28, 2010 at 11:33:13PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> I suspect that the last one would be the easiest for the requestee to
> judge the freshness of the branch.
>
> Why isn't the "The following changes..." line not part of the --format
> thing, by the way?

OK, I changed it accordingly, though I did not the change the output of
the "commit <hash>" line. So the output diff is:

         The following changes since commit 103209c6782586d92b04ee1fc71c0fd6f6385f5f:
        -  Junio C Hamano (1):
        -        Merge branch 'jc/maint-reflog-bad-timestamp'
        +
        +  Merge branch 'jc/maint-reflog-bad-timestamp' (2010-01-27 14:57:37 -0800)

         are available in the git repository at:

 git-request-pull.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 630cedd..8fd15f6 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -65,11 +65,11 @@ if [ -z "$branch" ]; then
 	status=1
 fi
 
-echo "The following changes since commit $baserev:"
-git shortlog --max-count=1 $baserev | sed -e 's/^\(.\)/  \1/'
+git show -s --format='The following changes since commit %H:
 
-echo "are available in the git repository at:"
-echo
+  %s (%ci)
+
+are available in the git repository at:' $baserev
 echo "  $url $branch"
 echo
 
-- 
1.6.6.1
