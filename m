From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/9] Extending the shelf-life of "git describe" output
Date: Wed, 20 Jun 2012 23:35:23 -0700
Message-ID: <1340260532-11378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 08:35:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShazU-0006FX-WB
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 08:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab2FUGff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 02:35:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43820 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225Ab2FUGfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 02:35:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35EE48B0E
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=qzgNv57yvR3vGtIUj2OcsS+DE7w
	=; b=j1Rl1BRDQAx6FPhVD7NMlazmY1bQVrIoeSe3C6pcnFxbYP74OkJ6Zc92GeW
	+BOcV4PfzCozubHRRX6cymnDU3xDqnaK9Tyl0DoOgOprrbA8YvcvKVY3wEqQUeOa
	slNM9fWcpYDF6iAl9m9yB4i5746Si5u0N0xRl9OLBEMOYfXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=cQa1NUeSCDD8XIr4eCNNjhO1rpyPd
	DynFTl/kN0GS67uUhzPc/BIlFjcDVTtPqwAf/staRa7mDBFl053/QPyPDiJvNlB8
	mbtC0zZa+/zuYn1NpjjCNZm50qLi6yiFRrfMREn7tn/KU5qG6Jc3VgOo4uP/YMl5
	FeXfMKBd9Lpzs4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CC678B0D
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 988098B0C for
 <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.2.gd284367
X-Pobox-Relay-ID: 4DA45504-BB6B-11E1-BB54-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200387>

This is take 2.  The first round was $gmane/200165.

A major difference from v1 is the [PATCH 6/9].  The earlier approach
was to filter out candidates that match the given prefix for
additional criteria as they are found in the loop, but this round
tries to optimize for the common case of not having ambiguities.  We
postpone running additional test until we find the second object
that match the prefix (in other words, if there is only one object
that has the prefix, we do not apply the "we know this name refers
to a commit" hint, and let the caller deal with a non commit object,
just like the current code does).

Junio C Hamano (9):
  sha1_name.c: indentation fix
  sha1_name.c: clarify what "fake" is for in find_short_object_filename()
  sha1_name.c: rename "now" to "current"
  sha1_name.c: refactor find_short_packed_object()
  sha1_name.c: correct misnamed "canonical" and "res"
  sha1_name.c: restructure disambiguation of short names
  sha1_name.c: allow get_short_sha1() to take other flags
  sha1_name.c: teach get_short_sha1() a commit-only option
  sha1_name.c: get_describe_name() by definition groks only commits

 sha1_name.c | 282 +++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 182 insertions(+), 100 deletions(-)

-- 
1.7.11.2.gd284367
