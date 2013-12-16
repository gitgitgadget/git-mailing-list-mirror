From: worley@alum.mit.edu (Dale R. Worley)
Subject: "git fsck" fails on malloc of 80 G
Date: Mon, 16 Dec 2013 11:05:32 -0500
Message-ID: <201312161605.rBGG5Wm5027739@hobgoblin.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 16 17:11:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsalm-0000qJ-IZ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 17:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab3LPQLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 11:11:42 -0500
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:46523
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754183Ab3LPQLl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Dec 2013 11:11:41 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2013 11:11:41 EST
Received: from omta14.westchester.pa.mail.comcast.net ([76.96.62.60])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id 2CCi1n0031HzFnQ5CG5axw; Mon, 16 Dec 2013 16:05:34 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta14.westchester.pa.mail.comcast.net with comcast
	id 2G5a1n0071KKtkw3aG5avE; Mon, 16 Dec 2013 16:05:34 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id rBGG5Wlr027740
	for <git@vger.kernel.org>; Mon, 16 Dec 2013 11:05:33 -0500
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id rBGG5Wm5027739;
	Mon, 16 Dec 2013 11:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1387209934;
	bh=UUK3K8ru5x5T6diHdgtmOVbaOgqlXra2C5/ZeuYa9XQ=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=G2G7zi049k+RlzenUUpBcaqn6BdTKN6/BznKE3LQGXp7AO+S+N+YYBgHNrKvqqarm
	 s5MhXTc597VMkYYmg7S8JsFf7BB/E5avI1/J0SnmhA8DmMa4xkY9xOqoniCd6cSOa9
	 5ToBFyc3fCq0+5cgWUu4z+zNmE4p55IT0JwsBTNP+7ftohM6bQ161JhZolMk0+nlnk
	 Q1ZZi4iPHysr6sMZk/8aQc86MxuZpBDLsFGYcZw5CK2mh67V0WPQY9t32EwhRn88WL
	 BxueCHUVTwlEfgBfo+aEwipMiCDO/riu3s96d0RaamCgihXpGbWbJP+aKAMoDXEZcz
	 oXCfIiW74DfIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239337>

I have a large repository (17 GiB of disk used), although no single
file in the repository is over 1 GiB.  (I have pack.packSizeLimit set
to "1g".)  I don't know how many files are in the repository, but it
shouldn't exceed several tens of commits each containing several tens
of thousands of files.

Due to Git crashing while performing an operation, I want to verify
that the repository is consistent.  However, when I run "git fsck" it
fails, apparently because it is trying to allocate 80 G of memory.  (I
can still do adds, commits, etc.)

# git fsck
Checking object directories: 100% (256/256), done.
fatal: Out of memory, malloc failed (tried to allocate 80530636801 bytes)
#

I don't know if this is due to an outright bug or not.  But it seems
to me that "git fsck" should not need to allocate any more memory than
the size (1 GiB) of a single pack file.  And given its purpose, "git
fsck" should be one of the *most* robust Git tools!

Dale
