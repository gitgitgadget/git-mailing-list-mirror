From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] More on pulling signed tags
Date: Wed,  4 Jan 2012 14:10:55 -0800
Message-ID: <1325715058-11984-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 04 23:11:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiZ3J-0000WP-V0
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 23:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757115Ab2ADWLC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 17:11:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757052Ab2ADWLB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 17:11:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 207BC6792
	for <git@vger.kernel.org>; Wed,  4 Jan 2012 17:11:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=0yGUjT/BxDmhmO271A8GgisXLN8
	=; b=p9wNyPIk91VCePHi6WgNKRN/wYspCKZyjO7Kmff0NPCJ22saPQMhK5RMPG/
	GObjTNJq6pMP1V8MMT/qpWkO0mBBOwLVSjpZFwMxuWM6rMcwvMKUkeBjv9/SPOjx
	62NZvXNnyHKIQdMizV3Hb6mpqtBLFByYAEiIgOTXnGvS2s44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=JL12qoF5WID9VFLiUO4ZXMiRFjPEa
	LrEDo/s9ROSZ3YXrFAQkYDF6kQXDVHJ9YU+RBZAbT9uPT/cZBLHjT1HED+3zoTWy
	WXuk96a9GIBXMhJxRTGWyTuFCL8yqwiy7CzSuOXeHZoTrs7CBugb1hrXkuDb2HKR
	KmJAtimMW4vq+M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 186346791
	for <git@vger.kernel.org>; Wed,  4 Jan 2012 17:11:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AD096790 for
 <git@vger.kernel.org>; Wed,  4 Jan 2012 17:10:59 -0500 (EST)
X-Mailer: git-send-email 1.7.8.2.340.gd18f0f
X-Pobox-Relay-ID: FB800A4E-3720-11E1-B129-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187947>

This extends on the earlier topic to pull and merge signed tags. So far,
we did record them for later auditing, but did not have an easy way to
perform the auditing, other than manually extracting the information from
the commit object.

Applies on top of the merge between the current 'master' and the
'jc/signed-commit' topic still in 'next', as the latter topic already has
necessary infrastructure to hook into the "log" machinery to show the
signatures embedded in commit objects with the "--show-signature" option.

Help on adding tests, docs and tying loose ends are very much appreciated.

A sample workflow with the command may look like this:

  $ git checkout v1.7.8^0
  $ git pull $elsewhere v1.7.8.2
  $ git show -s --show-signature
  commit e00ee29c760ae27c177ec16adb8c94b85909f464
  parent #2, tagged 'v1.7.8.2'
  gpg: Signature made Wed 28 Dec 2011 12:03:39 PM PST using RSA key ID 96AFE6CB
  gpg: Good signature from "Junio C Hamano <gitster@pobox.com>"
  gpg:                 aka "Junio C Hamano <junio@pobox.com>"
  gpg:                 aka "Junio C Hamano <jch@google.com>"
  Merge: 406da78 f3f778d
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Wed Jan 4 14:05:03 2012 -0800

      Merge tag 'v1.7.8.2' of ../git into HEAD

      Git 1.7.8.2
  $ git commit -S --amend --no-edit
  commit df409f0d0b1f3f521dd0fd2baf6ecf01495c0191
  gpg: Signature made Wed 04 Jan 2012 02:05:26 PM PST using RSA key ID 96AFE6CB
  gpg: Good signature from "Junio C Hamano <gitster@pobox.com>"
  gpg:                 aka "Junio C Hamano <junio@pobox.com>"
  gpg:                 aka "Junio C Hamano <jch@google.com>"
  parent #2, tagged 'v1.7.8.2'
  gpg: Signature made Wed 28 Dec 2011 12:03:39 PM PST using RSA key ID 96AFE6CB
  gpg: Good signature from "Junio C Hamano <gitster@pobox.com>"
  gpg:                 aka "Junio C Hamano <junio@pobox.com>"
  gpg:                 aka "Junio C Hamano <jch@google.com>"
  Merge: 406da78 f3f778d
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Wed Jan 4 14:05:03 2012 -0800

      Merge tag 'v1.7.8.2' of ../git into HEAD

      Git 1.7.8.2

Junio C Hamano (3):
  verify_signed_buffer: fix stale comment
  log-tree.c: small refactor in show_signature()
  log-tree: show mergetag in log --show-signature output

 gpg-interface.c |    5 +--
 log-tree.c      |  104 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 92 insertions(+), 17 deletions(-)

-- 
1.7.8.2.340.gd18f0f
