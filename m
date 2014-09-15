From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] mailinfo: do not treat ">From" lines as in-body headers
Date: Mon, 15 Sep 2014 13:15:35 -0700
Message-ID: <xmqq1trc63o8.fsf@gitster.dls.corp.google.com>
References: <20140913154556.GA12361@kroah.com>
	<20140913203645.GB24854@peff.net>
	<20140913204745.GA12291@msilap.einon.net>
	<20140913205751.GA17875@mwanda> <20140913210908.GG6549@mwanda>
	<20140913212504.GA25190@peff.net>
	<20140913225713.GB189120@vauxhall.crustytoothpaste.net>
	<20140914004725.GA28010@peff.net>
	<CAPc5daWxZdi+JTTsznefPk2U+Q8uWWYuBUa-rJA4knDZzwU38w@mail.gmail.com>
	<20140914010120.GA28498@peff.net> <20140914013038.GA5974@peff.net>
	<xmqqha087lwv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Einon <mark.einon@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 15 22:15:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTcgf-0004Z3-LZ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 22:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870AbaIOUPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 16:15:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53664 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755074AbaIOUPj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 16:15:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A0F043B25A;
	Mon, 15 Sep 2014 16:15:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6vviEvYt9j5Vh0K0GPEImkPE9d0=; b=rz6O0D
	Q4shyojChxFvth1UwuGtTgmkg+bxJ7YfkNKKO4kTmZnPEQ68jjzBNJC2MnaC/nOr
	QMP0FCTDfpZxD6/f075Hjh+RZLciBiliU+xPq7PZhvBDdw2k2SxdqAKYXZtZ3Z2F
	aZUmy4b5JPZ2upgLLFFtN6gYaX/NZk4ePog8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j2+fm4i8L59WKehOG8oLEEZRZTynS03s
	2+tYotkZ2QxM+RoBiQ14QU3Q+qfEuEPez8fcngxT1mZXyAAV6uc+eqTVP6wEYvrG
	F/Z/kfcF/ToCIoAo7Fgc2k4pSLGvwFRHLJQWD3Hcreh2RpQNJmeruh5nN3w3AbNn
	pV/6k+wvmIM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4985E3B259;
	Mon, 15 Sep 2014 16:15:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 532733B256;
	Mon, 15 Sep 2014 16:15:37 -0400 (EDT)
In-Reply-To: <xmqqha087lwv.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 15 Sep 2014 11:56:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0E6C021E-3D15-11E4-9362-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257078>

Junio C Hamano <gitster@pobox.com> writes:

> Why cache.h when this is still only between mail{info,split}.c both
> of which do not really deal with any "Git" data?
>
> For mailsplit, we are trying to detect mbox boundary various MUAs
> would use in their output, and is_from_line() may be appropriate,
> but I am not sure if the same logic is appropriate for mailinfo.
> What are we trying to protect us against?  Those who paste a single
> e-mail output from format-patch in full?  Do people paste a single
> e-mail received to their mailbox from somebody else and do we need
> to protect against that, skipping the ">From " thing, while risking
> to skip "From me at 10:30 30 minutes..."?
>
> If we only want to skip ">?From" in pasted format-patch output, we
> would want a rule in mailinfo that is tighter than is_from_line() in
> mailsplit.

That is, something like this on top of your patch.  Or is this a bit
too strict?

 Makefile            |  1 +
 builtin/mailinfo.c  |  3 ++-
 builtin/mailsplit.c |  1 +
 cache.h             |  6 ------
 mbox.c              | 15 +++++++++++++++
 5 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index dc5d2af..c0491a3 100644
--- a/Makefile
+++ b/Makefile
@@ -686,6 +686,7 @@ LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
 LIB_H += mailmap.h
+LIB_H += mbox.h
 LIB_H += merge-blobs.h
 LIB_H += merge-recursive.h
 LIB_H += mergesort.h
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index a434d39..ccccd69 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -6,6 +6,7 @@
 #include "builtin.h"
 #include "utf8.h"
 #include "strbuf.h"
+#include "mbox.h"
 
 static FILE *cmitmsg, *patchfile, *fin, *fout;
 
@@ -329,7 +330,7 @@ static int check_header(const struct strbuf *line,
 
 	/* for inbody stuff */
 	if (starts_with(line->buf, ">From") && isspace(line->buf[5])) {
-		ret = is_from_line(line->buf + 1, line->len - 1);
+		ret = is_format_patch_separator(line->buf + 1, line->len - 1);
 		goto check_header_out;
 	}
 	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 775588e..d8da1e4 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -8,6 +8,7 @@
 #include "builtin.h"
 #include "string-list.h"
 #include "strbuf.h"
+#include "mbox.h"
 
 static const char git_mailsplit_usage[] =
 "git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [(<mbox>|<Maildir>)...]";
diff --git a/cache.h b/cache.h
index eae58e7..fcb511d 100644
--- a/cache.h
+++ b/cache.h
@@ -1502,10 +1502,4 @@ void stat_validity_update(struct stat_validity *sv, int fd);
 
 int versioncmp(const char *s1, const char *s2);
 
-/*
- * Returns true if the line appears to be an mbox "From" line starting a new
- * message.
- */
-int is_from_line(const char *line, int len);
-
 #endif /* CACHE_H */
diff --git a/mbox.c b/mbox.c
index 75f3150..2ab2f85 100644
--- a/mbox.c
+++ b/mbox.c
@@ -30,3 +30,18 @@ int is_from_line(const char *line, int len)
 	/* Ok, close enough */
 	return 1;
 }
+
+#define SAMPLE "From e6807f3efca28b30decfecb1732a56c7db1137ee Mon Sep 17 00:00:00 2001\n"
+int is_format_patch_separator(const char *line, int len)
+{
+	const char *cp;
+
+	if (len != strlen(SAMPLE))
+		return 0;
+	if (!skip_prefix(line, "From ", &cp))
+		return 0;
+	if (strspn(cp, "0123456789abcdef") != 40)
+		return 0;
+	cp += 40;
+	return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) - (cp - line));
+}
