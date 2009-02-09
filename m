From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] Deleting the "current" branch in a remote repository
Date: Mon,  9 Feb 2009 01:09:19 -0800
Message-ID: <1234170565-6740-1-git-send-email-gitster@pobox.com>
References: <7v8wogzr3v.fsf@gitster.siamese.dyndns.org>
Cc: jk@jk.gs, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 10:10:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWSAL-0004Ri-Ge
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 10:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbZBIJJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 04:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbZBIJJa
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 04:09:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbZBIJJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 04:09:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D1FEC2ABFD
	for <git@vger.kernel.org>; Mon,  9 Feb 2009 04:09:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4572F2ABE6 for
 <git@vger.kernel.org>; Mon,  9 Feb 2009 04:09:27 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc0.28.g2593d
In-Reply-to: <7v8wogzr3v.fsf@gitster.siamese.dyndns.org>
X-Pobox-Relay-ID: 5A640A0A-F689-11DD-948F-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109051>

The first two are preparatory clean-up and bugfix patches.

The third one introduces receive.denyDeleteCurrent configuration that
defaults to "annoyingly loud warning", which we will flip to "refusal with
insn" at the end.

The fourth and fifth one are not about push and are more or less
independent.  They deal with what happens when you ended up with a
dangling symbolic ref in a tracking hierarchy.  I think a check
and warning similar to the fourth one may be needed in git-push (and
git-send-pack) when it pushes a void to remove a branch from a remote, and
in turn removes the corresponding tracking branch at the local end.

Then finally the last one flips the default for receive.denyDeleteCurrent
to refuse.

I think the first five ought to be in 1.6.2-rc1 but I lack the energy and
time to finish the testing, re-eyeballing and documentation tonight.  It
would be very nice to see friends from other timezones to help me with
these tasks ;-)


Junio C Hamano (6):
  builtin-receive-pack.c: do not initialize statics to 0
  t5400: allow individual tests to fail
  receive-pack: receive.denyDeleteCurrent
  remote prune: warn dangling symrefs
  Warn use of "origin" when remotes/origin/HEAD is dangling
  receive-pack: default receive.denyDeleteCurrent to refuse

 builtin-receive-pack.c |   70 ++++++++++++++++++++++++++++++++++++++--------
 builtin-remote.c       |    6 ++++
 refs.c                 |   72 ++++++++++++++++++++++++++++++++++++------------
 refs.h                 |    5 +++
 sha1_name.c            |    6 ++-
 t/t5400-send-pack.sh   |   44 ++++++++++++++++++++--------
 6 files changed, 157 insertions(+), 46 deletions(-)
