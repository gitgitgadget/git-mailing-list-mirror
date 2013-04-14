From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Using commit slab to replace indegree
Date: Sat, 13 Apr 2013 23:04:46 -0700
Message-ID: <1365919489-17553-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 14 08:05:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URG3d-0000sz-D1
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 08:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785Ab3DNGEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 02:04:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab3DNGEw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 02:04:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD0D0E3C8;
	Sun, 14 Apr 2013 06:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=p+U6s2xD9TlOrywrQ1Xa/U75LuA
	=; b=h9PK+LPFbmSw8wJH35CSCLPFoi2PF8KnsS9mcSDbYhhOhz0vSz+2IOt4/zg
	cK9ogigH8sCXAP+H9IdqkvaqQDK5jjV3cEWtjSnQ+ZRBlA81C07PwiScggfIwwHc
	SIEXS+BmKVTMTBQAoJmd9LdYc7eaF517NsCYzpPxbHwZ6mgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=PyQzF0+ulG6JjHJhGIXzi
	rqQziIo7fSxzRWWiW6X8OYk8Z8lr4srQFVXCo42IisS4L7XskHNbz+xlulIEwaNy
	FP2XXBwvhpd+PZjQ6irMsmjGpqsNi6rlcnIxQngMXfeZaWHQoo/3iOW/jmdXnfuj
	vjL7thnKmHRYG8kxo4PJqc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B343AE3C6;
	Sun, 14 Apr 2013 06:04:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 371CAE3C5; Sun, 14 Apr 2013
 06:04:51 +0000 (UTC)
X-Mailer: git-send-email 1.8.2.1-514-gf369d36
X-Pobox-Relay-ID: 382C0544-A4C9-11E2-AE94-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221077>

The first one is Jeff's "here is what I have now" technology
demonstration.

The second attempts to iron out one kink in it, and then the third
one introduces a macro to allow other code to replicate exactly the
same code structure to support their uses.

Jeff King (1):
  commit: allow associating auxiliary info on-demand

Junio C Hamano (2):
  commit-slab: avoid large realloc
  commit-slab: introduce a macro to define a slab for new type

 commit-slab.h | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit.c      | 32 ++++++++++++++------
 commit.h      |  2 +-
 3 files changed, 119 insertions(+), 10 deletions(-)
 create mode 100644 commit-slab.h

-- 
1.8.2.1-514-gf369d36
