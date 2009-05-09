From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 00/10] bisect: port git bisect merge base checking to C
Date: Sat, 09 May 2009 17:55:37 +0200
Message-ID: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 18:03:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2p1j-00065t-M0
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbZEIQDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbZEIQDl
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:03:41 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:37207 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbZEIQDi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:03:38 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id EBB20D4815A;
	Sat,  9 May 2009 18:03:32 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id EB247D4807D;
	Sat,  9 May 2009 18:03:29 +0200 (CEST)
X-Mailer: git-mail-commits v0.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118663>

This patch series continues porting "git bisect next" code
from shell in "git-bisect.sh" to C in "bisect.c".

After this series, the bisect ref lookup is done only once in the
C code, instead of once in the shell code and once in the C code.

  bisect: use "sha1_array" to store skipped revisions
  bisect: implement "rev_argv_push" to fill an argv with revs
  bisect: store good revisions in a "sha1_array"
  bisect: use new "struct argv_array" to prepare argv for
    "setup_revisions"
  bisect: remove too much function nesting
  bisect: make skipped array functions more generic
  bisect: automatically sort sha1_array if needed when looking it up
  bisect: implement the "check_merge_bases" function
  bisect: add "check_good_are_ancestors_of_bad" function
  bisect: make "git bisect" use new "--next-all" bisect-helper function

 bisect.c                 |  342 ++++++++++++++++++++++++++++++++++++++--------
 bisect.h                 |    2 +-
 builtin-bisect--helper.c |   14 +-
 git-bisect.sh            |  127 +-----------------
 4 files changed, 296 insertions(+), 189 deletions(-)
