From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/3] Avoid forking a process when checking merge bases
Date: Sun, 17 May 2009 18:35:41 +0200
Message-ID: <200905171835.41213.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 17 18:37:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5jMl-0000eC-HX
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 18:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbZEQQh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 12:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbZEQQh0
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 12:37:26 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:51266 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199AbZEQQh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 12:37:26 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id BB02E818179;
	Sun, 17 May 2009 18:37:21 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DAEB08180A3;
	Sun, 17 May 2009 18:37:18 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119401>

The goal of this patch series is to check if good revisions are
ancestor of the bad revision without forking a process to launch
"git rev-list $good ^$bad".

To do that it introduces an "unparse_commit" function that may be
usefull in other cases, for example see:

http://article.gmane.org/gmane.comp.version-control.git/114916

Ps: sorry to send this cover letter late because of a bug in the
script I used to send the series.

  bisect: rework some rev related functions to make them more reusable
  commit: add function to unparse a commit and its parents
  bisect: check ancestors without forking a "git rev-list" process

 bisect.c                    |   79 
+++++++++++++++++++-----------------------
 commit.c                    |   20 +++++++++++
 commit.h                    |    2 +
 t/t6030-bisect-porcelain.sh |   13 +------
 4 files changed, 59 insertions(+), 55 deletions(-)
