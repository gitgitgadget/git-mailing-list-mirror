Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504ED1362
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E4Exw82m"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781D8BC
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 22:10:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AB11E1AFC62;
	Mon, 30 Oct 2023 01:10:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=26+BniLk+O1QrS13axb88yP4e9oyRG1mjjGexlj1qgQ=; b=E4Ex
	w82mHrzemiIwanXybCh9sO82NZbdljxCGJhVvtAl04LSY6pYbEm5YOOq+eqZDDlP
	v/uBIjREx/RmJJ2nyz+MqQXkfdwMDJ5EZC0e1OQ6xntRE0pkkwWlPl34vrWfz1pd
	qk8oB/BCt7sXVmd+TMizmpRB0bpSby1zEwatKKE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A20121AFC61;
	Mon, 30 Oct 2023 01:10:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F7E21AFC60;
	Mon, 30 Oct 2023 01:10:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/2] Avoid passing global comment_line_char repeatedly
Date: Mon, 30 Oct 2023 14:10:32 +0900
Message-ID: <20231030051034.2295242-1-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-526-g3130c155df
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 A8BEDF7E-76E2-11EE-BFC7-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Two strbuf functions used to produce commented lines take the
comment_line_char as their parameter, but in practice, all callers
feed the global variable comment_line_char from environment.[ch].

Dropping the parameter from the callchain will make the interface
less flexible, and less error prone.  If we choose to change the
implementation of the customizable comment line character (e.g., we
may want to stop referencing the global variable and instead use a
getter function), we will have fewer places we need to modify.

Junio C Hamano (2):
  strbuf_commented_addf(): drop the comment_line_char parameter
  strbuf_add_commented_lines(): drop the comment_line_char parameter

 add-patch.c          |  8 ++++----
 builtin/branch.c     |  2 +-
 builtin/merge.c      |  8 ++++----
 builtin/notes.c      |  9 ++++-----
 builtin/stripspace.c |  2 +-
 builtin/tag.c        |  4 ++--
 fmt-merge-msg.c      |  9 +++------
 rebase-interactive.c |  8 ++++----
 sequencer.c          | 14 ++++++--------
 strbuf.c             |  9 +++++----
 strbuf.h             |  7 +++----
 wt-status.c          |  6 +++---
 12 files changed, 40 insertions(+), 46 deletions(-)

--=20
2.42.0-526-g3130c155df

