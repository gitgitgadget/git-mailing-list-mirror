From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/5] pretty-print: teach "--no-expand-tabs" option to "git log"
Date: Wed, 23 Mar 2016 16:23:46 -0700
Message-ID: <1458775426-2215-6-git-send-email-gitster@pobox.com>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
 <1458775426-2215-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 00:24:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ais8A-00083p-Kv
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 00:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbcCWXX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 19:23:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753575AbcCWXX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 19:23:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D4DDD50C20;
	Wed, 23 Mar 2016 19:23:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uABK
	wiREpLXEdUDH7hLMZkOysLw=; b=Q9xwsLlfcpmGVo/ce4tFUtf7YeinKAbgQkeZ
	CgCIfJs2xI8LOGtohNh0+wVrqJeCcrPUVhTIXimJiYV7wUYMj2urDRpy0mtArCUY
	3LDp3Zdix7rO9wfJ9ajH8I2UbFo4OaWbkMfAkEsvXXenOeJDUZfkZxGVZyQNYQut
	kwh39O4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	YfaTVAzSc3STOlqa0OyBlfYVQTBs4nNWHDfYGiN+cICucY/0/aY4GZGDbPMI6QYa
	YlX3fwxfK1VzfJq5gZTtzjFvbMK3Q7YmiURWs1sPF/AILtZ7TWf1tkfK2y7vZTsF
	YgUPZplJWMWyUG6MMfJkaUR6LALlnfxWWTjrB+qlVZU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD8EE50C1F;
	Wed, 23 Mar 2016 19:23:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 43CF750C1E;
	Wed, 23 Mar 2016 19:23:56 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-rc4-198-g3f6b64c
In-Reply-To: <1458775426-2215-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5060BAAE-F14E-11E5-A340-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289698>

The output formats of "git log" that indent the log message by 4
spaces have been updated to expand tabs by default in previous
steps, without a way to restore the original behaviour.

Introduce a new "--no-expand-tabs" option to allow this.

As the effect of options is cumulative,

    $ git log [--pretty=medium] --no-expand-tabs

would not expand, while this invocation

    $ git log --no-expand-tabs --pretty[=medium]

by virtue of having --pretty later on the command line, expands tabs
again.

We _could_ introduce --expand-tabs option as well, to allow

    $ git log --pretty=email --expand-tabs

but we don't bother, as the output format that do not expand tabs by
default are mostly meant to transfer the contents as literally as
possible.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
---
 Documentation/pretty-options.txt | 6 ++++++
 revision.c                       | 2 ++
 t/t4201-shortlog.sh              | 4 ++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 4b659ac..069b927 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -42,6 +42,12 @@ people using 80-column terminals.
 	verbatim; this means that invalid sequences in the original
 	commit may be copied to the output.
 
+--no-expand-tabs::
+	The formats that indent the log message by 4 spaces
+	(i.e. 'medium', 'full', and 'fuller') by default show tabs
+	in the log message expanded.  This option disables the
+	expansion.
+
 ifndef::git-rev-list[]
 --notes[=<ref>]::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
diff --git a/revision.c b/revision.c
index 8827d9f..b0d2a36 100644
--- a/revision.c
+++ b/revision.c
@@ -1916,6 +1916,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
 		get_commit_format(arg+9, revs);
+	} else if (!strcmp(arg, "--no-expand-tabs")) {
+		revs->expand_tabs_in_log = 0;
 	} else if (!strcmp(arg, "--show-notes") || !strcmp(arg, "--notes")) {
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index d1e8259..2fec948 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -114,8 +114,8 @@ EOF
 	test_cmp expect out
 '
 
-test_expect_failure !MINGW 'shortlog from non-git directory' '
-	git log HEAD >log &&
+test_expect_success !MINGW 'shortlog from non-git directory' '
+	git log --no-expand-tabs HEAD >log &&
 	GIT_DIR=non-existing git shortlog -w <log >out &&
 	test_cmp expect out
 '
-- 
2.8.0-rc4-198-g3f6b64c
