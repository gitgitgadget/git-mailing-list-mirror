From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] Speeding up "git status" and "git diff --cached"
Date: Sat, 23 May 2009 12:24:33 -0700
Message-ID: <1243106678-6343-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 21:24:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wpu-0001xr-Gc
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 21:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbZEWTYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 15:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbZEWTYl
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 15:24:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbZEWTYk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 15:24:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 11CACB56B3
	for <git@vger.kernel.org>; Sat, 23 May 2009 15:24:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 886EBB56B2 for
 <git@vger.kernel.org>; Sat, 23 May 2009 15:24:40 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
X-Pobox-Relay-ID: 5CEAFCE2-47CF-11DE-A446-F6BA321C86B1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119788>

Here is a refined version of an earlier patch series to use cache-tree
information to optimize comparison between the index with an existing
commit.

Recently there was a discussion to auto-commit any change to the index
that are going to be discarded to some kind of "trash" branch; I am not
personally interested in writing a patch to do so, but this will also help
such a feature by making it cheaper to see if there are differences worth
saving.

Junio C Hamano (5):
  write-tree --ignore-cache-tree
  cache-tree.c::cache_tree_find(): simplify inernal API
  t4007: modernize the style
  Optimize "diff-index --cached" using cache-tree
  Avoid "diff-index --cached" optimization under --find-copies-harder

 builtin-write-tree.c |   12 ++++++--
 cache-tree.c         |   44 +++++++++++++++++++++++++++--
 cache-tree.h         |   10 ++++++-
 diff-lib.c           |    3 ++
 t/t4007-rename-3.sh  |   74 +++++++++++++++++++++++++-------------------------
 unpack-trees.c       |   17 +++++++++++
 unpack-trees.h       |    1 +
 7 files changed, 117 insertions(+), 44 deletions(-)
