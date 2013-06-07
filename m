From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Preparing for --date-order=author
Date: Thu,  6 Jun 2013 22:11:09 -0700
Message-ID: <1370581872-31580-1-git-send-email-gitster@pobox.com>
References: <7vfvwuww39.fsf@alter.siamese.dyndns.org>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 07:11:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkoxL-00007r-Am
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 07:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798Ab3FGFLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 01:11:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50593 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab3FGFLP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 01:11:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ECB020C22;
	Fri,  7 Jun 2013 05:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ihod
	u+BCopsdPTGSzVr4NzZdIVQ=; b=nE+d92eDW1cC4CR8jPlykzmxDCeKs8vMVwKL
	A11KZyUvUPI+F+onZiLBhPMUE/zuhIvWN9T7X3GYRYyNJkQpdtm+GI5n+M1oStt8
	MVNoZ2kOWsv6B8RDZ5SxkvVRFctvNFnk7lcu1X+bBPnaglFm5ph+Ag+7v7gSbCDi
	UV22QuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	bSq75QZO8x1vwJA5jUrxsTkb0c7Dpk2TRgpOcgcmbxcF4zQNDRrqxgTBsFnoc/pq
	aWI/lbjU8sSnLr6YX4qbnH2uTUnW0y9IEXZ+KYONt2N7ifD1M62h7gPAtnh9+A2B
	9OglYla9Bs46PSdrMCB8ytMG5uhG+12V0DMrl9XC3FM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83D4920C21;
	Fri,  7 Jun 2013 05:11:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3DA420C1E;
	Fri,  7 Jun 2013 05:11:13 +0000 (UTC)
X-Mailer: git-send-email 1.8.3-451-gb703ddf
In-Reply-To: <7vfvwuww39.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: ACDCE8A4-CF30-11E2-ADA2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226592>

These three patches introduce a commit-queue API to manage a set of
commits in a priority queue, with a caller-specified comparison
function.  The priority queue replaces the singly-listed commit_list
in the topological sort function.

The series applies on top of the commit-info-slab API sesries Peff
and I did two months ago.  These three patches do not use the slab
API yet, but a follow-on patch to introduce REV_SORT_BY_AUTHOR_DATE
needs to use commit-slab to record author date for the commits being
sorted, and consult it in its comparison function when comparing the
author dates of commits.

Junio C Hamano (3):
  toposort: rename "lifo" field
  commit-queue: LIFO or priority queue of commits
  sort-in-topological-order: use commit-queue

 Makefile              |  2 ++
 builtin/log.c         |  2 +-
 builtin/show-branch.c | 14 +++++----
 commit-queue.c        | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 commit-queue.h        | 34 +++++++++++++++++++++
 commit.c              | 70 +++++++++++++++++++++++++-----------------
 commit.h              | 14 +++++++--
 revision.c            | 10 +++---
 revision.h            |  6 +++-
 9 files changed, 193 insertions(+), 43 deletions(-)
 create mode 100644 commit-queue.c
 create mode 100644 commit-queue.h

-- 
1.8.3-451-gb703ddf
