From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH 0/4] Enhance git-rebases flexibiilty in handling empty commits
Date: Fri, 30 Mar 2012 15:48:38 -0400
Message-ID: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 21:49:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDhok-0005RE-Cf
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 21:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761300Ab2C3Ts6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 15:48:58 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:60942 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756919Ab2C3Ts5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 15:48:57 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SDhoZ-000115-CG; Fri, 30 Mar 2012 15:48:53 -0400
X-Mailer: git-send-email 1.7.7.6
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194392>

Hey all-
	Based on your feedback from my earlier thread on this subject, I've come
up with this series as a first pass in enhancing git-rebases ability to handle
empty commits.  I'm not sure if its exactly what everyone wants, but I think its
a good start, and it works for what I need it to do here.

I started with adding a -keep-empty option to git-cherry-pick, which allows
non-fast forward commits that are empty to be cherry-pick without failing, and
requiring a separate git commit --allow-empty.

Building on that, I've added --keep-empty option to git-rebase.  For an
automatic rebase adding --keep-empty simply passes the --keep-empty flag along
to git cherry-pick so that the empty commits are preserved instead of discarded

for interactive rebases, I changed the default selection editor text somewhat.
By default, empty commits are allowed in this list.  With patch 4 here, empty
commits are commented out automatically, unless --keep-empty is selected (in
which case all commits are pick-ed).  The user sees additional text indicating
that empty commits are commented and if they wish to be kept, then they must be
uncommented.  The pick_one function then intellegently passes the --keep-empty
option allong to cherry-pick as needed.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Jeff King <peff@peff.net>
CC: Phil Hord <phil.hord@gmail.com>
CC: Junio C Hamano <gitster@pobox.com>
