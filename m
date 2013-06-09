From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] log --author-date-order
Date: Sun,  9 Jun 2013 16:24:33 -0700
Message-ID: <1370820277-30158-1-git-send-email-gitster@pobox.com>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 01:24:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uloyb-0004YT-FA
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 01:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450Ab3FIXYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 19:24:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61070 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095Ab3FIXYj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 19:24:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 169F326E4C;
	Sun,  9 Jun 2013 23:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QmoH
	AzCuw8Fmd2SkvYe9RJwNaj4=; b=Os8rDP25jVWum9XDqGur6C+hwuFQBeFSNFyo
	n+s8Yg6s0eoASVE9hk8nHW9o6Lh4b0FYPL2DFZ3S+l7LYB5Gr08e2nhj2i3ZYsqr
	twFR/QU8lSMCBaDXJb33zxPAzKIV5FLbWE1Z07Bt1LMC3Cu24iUqwQiHSAjm2/C9
	IXqtJlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Sk7qVpMIh5CJ3qy+LKuNktPX4lL1/o1JRbA6wfVhmhni8ZpkP7376FrEUHqj/eLM
	Ij61G6DHf072C1TgG24JjZHGNwWwQD+AwuUfK/aKDb0ReSq05p6ep0LoMDzO/FDk
	ilbdm696GqnJ5wVQ3BaoxS3xd+zJvg+kciMv9vbi6CE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D68D26E4B;
	Sun,  9 Jun 2013 23:24:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84B0326E4A;
	Sun,  9 Jun 2013 23:24:38 +0000 (UTC)
X-Mailer: git-send-email 1.8.3-477-gc2fede3
In-Reply-To: <1370581872-31580-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C10B3A38-D15B-11E2-AA76-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227208>

Not much changed in the first three patches since the edition from
last week.  A clean-up to clarify the toposort API, introduction of
priority queue API, and then its use in topological sort logic.

The final patch adds "log --author-date-order" to build on top of
them.

Adding tests to t4202 and/or t6012 is left as an exercise to readers.

Junio C Hamano (4):
  toposort: rename "lifo" field
  commit-queue: LIFO or priority queue of commits
  sort-in-topological-order: use commit-queue
  log: --author-date-order

 Documentation/rev-list-options.txt |   4 ++
 Makefile                           |   2 +
 builtin/log.c                      |   2 +-
 builtin/show-branch.c              |  14 ++--
 commit-queue.c                     |  84 ++++++++++++++++++++++++
 commit-queue.h                     |  34 ++++++++++
 commit.c                           | 129 +++++++++++++++++++++++++++++--------
 commit.h                           |  15 ++++-
 revision.c                         |  13 ++--
 revision.h                         |   6 +-
 10 files changed, 260 insertions(+), 43 deletions(-)
 create mode 100644 commit-queue.c
 create mode 100644 commit-queue.h

-- 
1.8.3-451-gb703ddf
