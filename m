From: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
Subject: [PATCH 1/2] git-svn: enable "svn.pathnameencoding" on dcommit
Date: Tue, 9 Feb 2016 00:20:31 +0900
Message-ID: <56B8B23F.2020901@f2.dion.ne.jp>
References: <56B8B1EA.5020901@f2.dion.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: normalperson@yhbt.net, alex.crezoff@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 16:29:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSnku-0006Ge-Or
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 16:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbcBHP3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 10:29:33 -0500
Received: from mail-ae0-f61.auone-net.jp ([106.187.230.61]:38584 "EHLO
	dmta02.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754439AbcBHP30 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 10:29:26 -0500
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2016 10:29:26 EST
Received: from amlmta050.auone-net.jp (amlmta050-MM [10.188.23.89])
	by dmta02.auone-net.jp (au one net mail) with ESMTP id B2B424001DF
	for <git@vger.kernel.org>; Tue,  9 Feb 2016 00:24:09 +0900 (JST)
Received: from [0.0.0.0] ([77.247.181.163])
	by amlmta050.auone-net.jp id 56b8b3160004f780000055dd000064fca00008b3cc6b;
	Tue, 09 Feb 2016 00:24:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <56B8B1EA.5020901@f2.dion.ne.jp>
X-MXM-DELIVERY-TYPE: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285775>

Without the initialization of $self->{pathnameencoding}, conversion in
repo_path() is always skipped as $self->{pathnameencoding} is undefined
even if "svn.pathnameencoding" is configured.

The lack of conversion results in mysterious failure of dcommit (e.g.
"Malformed XML") which happen only when a commit involves a change on
non-ASCII path.

Signed-off-by: Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>
---
 perl/Git/SVN/Editor.pm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index c50176e..d9d9bdf 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -41,6 +41,7 @@ sub new {
 	                       "$self->{svn_path}/" : '';
 	$self->{config} = $opts->{config};
 	$self->{mergeinfo} = $opts->{mergeinfo};
+	$self->{pathnameencoding} = Git::config('svn.pathnameencoding');
 	return $self;
 }
 
-- 
2.7.0
