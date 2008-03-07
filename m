From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Re-fix get_pathspec()
Date: Fri,  7 Mar 2008 00:38:35 -0800
Message-ID: <1204879119-7528-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 09:42:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXYAH-0002XW-QV
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 09:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759893AbYCGImE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 03:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759163AbYCGImC
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 03:42:02 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330AbYCGIl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 03:41:59 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B1B82A7C
	for <git@vger.kernel.org>; Fri,  7 Mar 2008 03:41:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D7CDC2A7B for <git@vger.kernel.org>; Fri,  7 Mar 2008 03:41:56 -0500
 (EST)
X-Mailer: git-send-email 1.5.4.3.587.g0bdd73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76469>

After 1.5.4, we improved get_pathspec() to allow absolute paths, because
people wanted to cut&paste from file managers and such, so that you can
feed absolute paths to "git add" and friends.

However, the paths still must be inside work tree, so there must be a way
to ensure that.  d089eba (setup: sanitize absolute and funny paths in
get_pathspec()) botched the interface, by making the check the
responsibility of the callers, while keeping the interface to the function
intact, which meant that the callers needed to count returned pathspecs
and compared it with the number of paths fed to the function.

This miniseries cleans up the interface by making get_pathspec() to die
again.

Junio C Hamano (4):
  get_pathspec(): die when an out-of-tree path is given
  Revert part of 744dacd (builtin-mv: minimum fix to avoid losing files)
  Revert part of 1abf095 (git-add: adjust to the get_pathspec() changes)
  Revert part of d089eba (setup: sanitize absolute and funny paths in
    get_pathspec())

 builtin-add.c              |   12 ------------
 builtin-ls-files.c         |   11 +----------
 builtin-mv.c               |    6 +-----
 setup.c                    |    2 ++
 t/t3101-ls-tree-dirname.sh |    2 +-
 t/t7010-setup.sh           |    7 ++++---
 6 files changed, 9 insertions(+), 31 deletions(-)

