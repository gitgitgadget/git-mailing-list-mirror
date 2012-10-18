From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] Bring "format-patch --notes" closer to a real feature
Date: Wed, 17 Oct 2012 22:45:22 -0700
Message-ID: <1350539128-21577-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 07:45:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOivQ-0005GL-Dt
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 07:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154Ab2JRFpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 01:45:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59805 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088Ab2JRFpb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 01:45:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD4226D10
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=XJJ033wlhZJm0dokOKtIETT0oJE
	=; b=C6Z3aZpTTaUfltCDrUzM3hc8RZj4IvcpYR6FrR7Lp6SHiEZnA5QNFY7xQKY
	UMhHu387NNdLK+DBox4YxjArgOO4PyF/q3F9t/sHzg+nr2rOqTcQ82weI21cnYUy
	au0aFvh+Od1BTTwruei1L0qsZ40bO9LhV2Rbee0ZDjQ5XObw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=fR+LLHuGLaH251zKTim5qwbbdHAQn
	AM9+TNeG9kkz98RaeRuRutnX0K5SfTFEHjemUh+PpuKLaRFXw6U3mJw51W1+hlXN
	Bmz72v+3furL2RYbkCpuywmYSWpLFILtZp0UwKnjVBeiwxUmRQxWnulleQQvBEOV
	lphMftEQwpKbvw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B97E56D0E
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2383B6D0C for
 <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:30 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc3.112.gdb88a5e
X-Pobox-Relay-ID: 0695F6A2-18E7-11E2-9450-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207961>

This replaces the earlier "wip" with a real thing.

We never advertised the "--notes" option to format-patch (or
anything related to the pretty format options for that matter)
because the behaviour of these options was whatever they happened to
do, not what they were designed to do.

It had a few obvious glitches:

 * The notes section was appended immediately after the log message,
   and then the three-dash line was added.  Such a supplimental
   material should come after the three-dash line.

 * The logic to append a new sign-off with "format-patch --signoff"
   worked on the message after the note was added, which made the
   detection of existing sign-off lines incorrect.

This updates the handling of "--notes" option to correct these, in
an attempt to bring it closer to a real feature.

Junio C Hamano (6):
  pretty: remove reencode_commit_message()
  format_note(): simplify API
  pretty: prepare notes message at a centralized place
  pretty_print_commit(): do not append notes message
  format-patch: append --signature after notes
  format-patch --notes: show notes after three-dashes

 builtin/blame.c         |  5 +++--
 commit.h                |  4 +---
 log-tree.c              | 32 ++++++++++++++++++++++++++++----
 notes.c                 | 13 +++++++------
 notes.h                 |  6 +-----
 pretty.c                | 22 ++++------------------
 revision.c              |  2 +-
 revision.h              |  1 +
 t/t4014-format-patch.sh | 15 +++++++++++++--
 9 files changed, 59 insertions(+), 41 deletions(-)

-- 
1.8.0.rc3.112.gdb88a5e
