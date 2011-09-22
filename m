From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] A handful of "branch description" patches
Date: Thu, 22 Sep 2011 15:09:16 -0700
Message-ID: <1316729362-7714-1-git-send-email-gitster@pobox.com>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 00:09:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6rSV-0007F1-JD
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 00:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab1IVWJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 18:09:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62741 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955Ab1IVWJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 18:09:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 917766EC8
	for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=TWv9
	vphhgaSOxzElaHvtvAcD3FQ=; b=gJCdvnAA0bxhjxYp61a2AcLV7gxI/85Cw2LP
	iyLdwgb679F6M865s6bBxBMijHFyXVwD4uOhabmKelRcoZeVsvpjAkGA0KGOJFXv
	TZtorJ3cgpZT82lwFxmWkrMRfXvtzKHU8nNkc/DGKpwJbeEptuO18LEaGTZV+28L
	jtyj/KI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Mw2UZj
	8B3P4RSwDBM8Nu1SdpKPmhMcMMsvmaNjaSy+tNk4OE6YVw6tP3dlnYZGw4XbmvD2
	1EBuyn4UJsNk4Ib/NIMoiRyGDPPc3YGYhapVE22Ppn7AoLjDZw6Ece+63lIYFxcn
	8XzTqQpwjeP5xbNV0Nq7/+cBKOBKaPHI0Cc4k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89D276EC6
	for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02F366EC5 for
 <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:23 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc2.4.g5ec82
In-Reply-To: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 879566F2-E567-11E0-9B43-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181922>

Here are a few patches that I have queued in 'pu', redoing some of the
patches I already sent out to the list, around "branch description".

The original motivation was to make the push/pull workflow appear more
robust by allowing human-to-human communication to leave audit trail that
can be verified when it becomes necessary. Namely:

 * request-pull message carries the SHA-1 of what is expected to be
   merged; and

 * "signed push" leaves the SHA-1 of what was pushed to the remote,
   cryptographically signed.

Linus's reaction, as I understood him, was "if we are spending efforts to
add more information, the end result should be more informative to humans
not just to machines", and I agree.  An example of piece of information we
often talk about is branch description---what a particular branch is meant
to achieve. Both request-pull messages and declarations of what was pushed
are good places to record that piece of information.

So here is a partially re-rolled series to get us closer.

 * The logic to read from an existing branch description was in
   builtin/branch.c in the original series, but the first patch separates
   it out into branch.c as a helper function;

 * The second one is a digression; the branch description describes what
   the topic aims to achieve, so it was natural to use it to prime the
   cover letter while preparing a patch series with format-patch;

 * The third one that adds "branch --edit-description" is basically
   unchanged modulo small leakfix from the original round;

 * And the remainder of the series for request-pull is the same as the
   last round.

The second patch uses facility introduced in bk/ancestry-path topic, so
it would be the easiest to apply the series on top of a merge of c05b988
to 'master'.

I haven't updated the "signed push" patch to use this information yet.


Junio C Hamano (6):
  branch: add read_branch_desc() helper function
  format-patch: use branch description in cover letter
  branch: teach --edit-description option
  request-pull: modernize style
  request-pull: state what commit to expect
  request-pull: use the branch description

 Documentation/git-branch.txt |    5 +++
 branch.c                     |   31 ++++++++++++++++++
 branch.h                     |    5 +++
 builtin/branch.c             |   56 +++++++++++++++++++++++++++++++-
 builtin/log.c                |   71 +++++++++++++++++++++++++++++++++++++++--
 git-request-pull.sh          |   73 ++++++++++++++++++++++++++---------------
 t/t5150-request-pull.sh      |    6 +++
 7 files changed, 215 insertions(+), 32 deletions(-)

-- 
1.7.7.rc2.4.g5ec82
