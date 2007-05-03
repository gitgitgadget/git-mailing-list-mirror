From: Roland Dreier <rdreier@cisco.com>
Subject: [PATCH StGIT] Fix deleting series trash directory
Date: Thu, 03 May 2007 11:29:41 -0700
Message-ID: <adalkg5ep62.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Thu May 03 20:30:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjg40-0001S8-4E
	for gcvg-git@gmane.org; Thu, 03 May 2007 20:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161548AbXECS34 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 14:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162230AbXECS34
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 14:29:56 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:45696 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161548AbXECS3u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 14:29:50 -0400
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-6.cisco.com with ESMTP; 03 May 2007 11:29:49 -0700
X-IronPort-AV: i="4.14,487,1170662400"; 
   d="scan'208"; a="144041411:sNHT82648647"
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id l43ITnCI006270;
	Thu, 3 May 2007 11:29:49 -0700
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by sj-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id l43ITnMF002664;
	Thu, 3 May 2007 18:29:49 GMT
Received: from xfe-sjc-211.amer.cisco.com ([171.70.151.174]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 3 May 2007 11:29:42 -0700
Received: from roland-conroe ([171.71.26.194]) by xfe-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 3 May 2007 11:29:41 -0700
Received: by roland-conroe (Postfix, from userid 33217)
	id D2EADE71BB; Thu,  3 May 2007 11:29:41 -0700 (PDT)
X-Message-Flag: Warning: May contain useful information
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
X-OriginalArrivalTime: 03 May 2007 18:29:41.0847 (UTC) FILETIME=[03F51670:01C78DB1]
DKIM-Signature: v=0.5; a=rsa-sha256; q=dns/txt; l=700; t=1178216989; x=1179080989;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=rdreier@cisco.com;
	z=From:=20Roland=20Dreier=20<rdreier@cisco.com>
	|Subject:=20[PATCH=20StGIT]=20Fix=20deleting=20series=20trash=20directory
	|Sender:=20;
	bh=UW6RBmfX5/8W74TulhIKf8jendcUCkS1gVffvm0lrXo=;
	b=G7H192mR2QwEt8CbkWlCWL1OQqNhhBusjDL6tYxDyo9lHmlzyEeJEvRhjBNG1baQMoI+XUh4
	1rzH01Bab6Emzcj5pMYu/Xuhhp76jiQdOBZqNOHSqDBqtFC8tjLySCKE;
Authentication-Results: sj-dkim-2; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46095>

When deleting a series, the loop that iterates through the files in
__trash_dir needs to add __trash_dir to the filename that it passes to
os.remove().

Signed-off-by: Roland Dreier <rolandd@cisco.com>
---
diff --git a/stgit/stack.py b/stgit/stack.py
index b0a01dd..4e5ddb3 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -665,7 +665,7 @@ class Series(StgitObject):
 
             # remove the trash directory
             for fname in os.listdir(self.__trash_dir):
-                os.remove(fname)
+                os.remove(os.path.join(self.__trash_dir, fname))
             os.rmdir(self.__trash_dir)
 
             # FIXME: find a way to get rid of those manual removals
