From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] wt-status: i18n of section labels
Date: Wed, 12 Mar 2014 12:22:57 -0700
Message-ID: <xmqqtxb3kyr2.fsf_-_@gitster.dls.corp.google.com>
References: <20131008085036.11434.25160.reportbug@x230-buxy.home.ouaza.com>
	<20131219104613.GA18379@x230-buxy.home.ouaza.com>
	<20131219194319.GB20443@google.com>
	<xmqqa9cvmeod.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Raphael Hertzog <hertzog@debian.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
	<avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 20:23:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNokD-0002nu-Nj
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 20:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbaCLTXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 15:23:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831AbaCLTXC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 15:23:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BB23715EA;
	Wed, 12 Mar 2014 15:23:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DKqo8bQM0s4NwjbG0wDB5pm79Ck=; b=Co72B6
	n3XmiMG1ogcdiks1GR3wfLgjdTHIHoSxAQeYA1jFjTcEqVOgzmljmxHFVbWS3Eex
	ckmzeTuuiSTKhyHmovz4Py5gBzvLS63mjgYgHfbn2uZ+b3/TTe25rMNOgBpmVmG0
	YBg9G1A60VbiWstXrV62sAtsq1Z6LAXk8wNmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L8Vkm1dQTs64+4jNTIB7LPTZea0TBpXC
	MKIsDL607xSF/1eTzmWz1awdBVc5TGyCUo0X4z0PLj5t1UnmoOSUlJ9y4e+FBPOH
	ddcShWLphBLlYkOL/QbvlricIPi7EkHLbsyc9fjif06ZGmCuWEa36I5tBYIIYN9o
	Bakmc09oFgk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 170D0715E9;
	Wed, 12 Mar 2014 15:23:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E89A715E5;
	Wed, 12 Mar 2014 15:22:59 -0400 (EDT)
In-Reply-To: <xmqqa9cvmeod.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 12 Mar 2014 11:53:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B8C60012-AA1B-11E3-BFCF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243968>

From: Jonathan Nieder <jrnieder@gmail.com>
Date: Thu, 19 Dec 11:43:19 2013 -0800

The original code assumes that:

 (1) the number of bytes written is the width of a string, so they
     can line up;

 (2) the "how" string is always <= 19 bytes.

Also a recent change to a similar codepath by 3651e45c (wt-status:
take the alignment burden off translators, 2013-11-05) adds this
assumption:

 (3) the "colon" at the end of the label string does not have to be
     subject to l10n.

None of which we should assume.

Refactor the code to compute the label width for both codepaths into
a helper function, make sure label strings have the trailing colon
that can be localized, and use it when showing the section labels in
the output.

cf. http://bugs.debian.org/725777

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Differences relative to Jonathan's original in $gmane/239537 are:

   - labels made by wt_status_diff_status_string() have trailing
     colon; the caller has been adjusted (please double check)

   - a static label_width avoids repeated strlen(padding);

   - unmerged status label has "at least 20 columns wide"
     reinstated, at least for now, to keep the existing tests from
     breaking.  We may want to drop it in a separate follow-up
     patch.

 wt-status.c | 121 +++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 78 insertions(+), 43 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 4e55810..a00861c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -245,51 +245,92 @@ static void wt_status_print_trailer(struct wt_status *s)
 
 #define quote_path quote_path_relative
 
-static void wt_status_print_unmerged_data(struct wt_status *s,
-					  struct string_list_item *it)
+static const char *wt_status_unmerged_status_string(int stagemask)
 {
-	const char *c = color(WT_STATUS_UNMERGED, s);
-	struct wt_status_change_data *d = it->util;
-	struct strbuf onebuf = STRBUF_INIT;
-	const char *one, *how = _("bug");
-
-	one = quote_path(it->string, s->prefix, &onebuf);
-	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
-	switch (d->stagemask) {
-	case 1: how = _("both deleted:"); break;
-	case 2: how = _("added by us:"); break;
-	case 3: how = _("deleted by them:"); break;
-	case 4: how = _("added by them:"); break;
-	case 5: how = _("deleted by us:"); break;
-	case 6: how = _("both added:"); break;
-	case 7: how = _("both modified:"); break;
+	switch (stagemask) {
+	case 1:
+		return _("both deleted:");
+	case 2:
+		return _("added by us:");
+	case 3:
+		return _("deleted by them:");
+	case 4:
+		return _("added by them:");
+	case 5:
+		return _("deleted by us:");
+	case 6:
+		return _("both added:");
+	case 7:
+		return _("both modified:");
+	default:
+		return _("bug");
 	}
-	status_printf_more(s, c, "%-20s%s\n", how, one);
-	strbuf_release(&onebuf);
 }
 
 static const char *wt_status_diff_status_string(int status)
 {
 	switch (status) {
 	case DIFF_STATUS_ADDED:
-		return _("new file");
+		return _("new file:");
 	case DIFF_STATUS_COPIED:
-		return _("copied");
+		return _("copied:");
 	case DIFF_STATUS_DELETED:
-		return _("deleted");
+		return _("deleted:");
 	case DIFF_STATUS_MODIFIED:
-		return _("modified");
+		return _("modified:");
 	case DIFF_STATUS_RENAMED:
-		return _("renamed");
+		return _("renamed:");
 	case DIFF_STATUS_TYPE_CHANGED:
-		return _("typechange");
+		return _("typechange:");
 	case DIFF_STATUS_UNKNOWN:
-		return _("unknown");
+		return _("unknown:");
 	case DIFF_STATUS_UNMERGED:
-		return _("unmerged");
+		return _("unmerged:");
 	default:
-		return NULL;
+		return _("bug");
+	}
+}
+
+static int maxwidth(const char *(*label)(int), int minval, int maxval)
+{
+	int result = 0, i;
+
+	for (i = minval; i <= maxval; i++) {
+		const char *s = label(i);
+		int len = s ? utf8_strwidth(s) : 0;
+		if (len > result)
+			result = len;
+	}
+	return result;
+}
+
+static void wt_status_print_unmerged_data(struct wt_status *s,
+					  struct string_list_item *it)
+{
+	const char *c = color(WT_STATUS_UNMERGED, s);
+	struct wt_status_change_data *d = it->util;
+	struct strbuf onebuf = STRBUF_INIT;
+	static char *padding;
+	static int label_width;
+	const char *one, *how;
+	int len;
+
+	if (!padding) {
+		label_width = maxwidth(wt_status_unmerged_status_string, 1, 7);
+		label_width += strlen(" ");
+		if (label_width < 20)
+			label_width = 20;
+		padding = xmallocz(label_width);
+		memset(padding, ' ', label_width);
 	}
+
+	one = quote_path(it->string, s->prefix, &onebuf);
+	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
+
+	how = wt_status_unmerged_status_string(d->stagemask);
+	len = label_width - utf8_strwidth(how);
+	status_printf_more(s, c, "%s%.*s%s\n", how, len, padding, one);
+	strbuf_release(&onebuf);
 }
 
 static void wt_status_print_change_data(struct wt_status *s,
@@ -305,21 +346,16 @@ static void wt_status_print_change_data(struct wt_status *s,
 	struct strbuf onebuf = STRBUF_INIT, twobuf = STRBUF_INIT;
 	struct strbuf extra = STRBUF_INIT;
 	static char *padding;
+	static int label_width;
 	const char *what;
 	int len;
 
 	if (!padding) {
-		int width = 0;
-		/* If DIFF_STATUS_* uses outside this range, we're in trouble */
-		for (status = 'A'; status <= 'Z'; status++) {
-			what = wt_status_diff_status_string(status);
-			len = what ? strlen(what) : 0;
-			if (len > width)
-				width = len;
-		}
-		width += 2;	/* colon and a space */
-		padding = xmallocz(width);
-		memset(padding, ' ', width);
+		/* If DIFF_STATUS_* uses outside the range [A..Z], we're in trouble */
+		label_width = maxwidth(wt_status_diff_status_string, 'A', 'Z');
+		label_width += strlen(" ");
+		padding = xmallocz(label_width);
+		memset(padding, ' ', label_width);
 	}
 
 	one_name = two_name = it->string;
@@ -355,14 +391,13 @@ static void wt_status_print_change_data(struct wt_status *s,
 	what = wt_status_diff_status_string(status);
 	if (!what)
 		die(_("bug: unhandled diff status %c"), status);
-	/* 1 for colon, which is not part of "what" */
-	len = strlen(padding) - (utf8_strwidth(what) + 1);
+	len = label_width - utf8_strwidth(what);
 	assert(len >= 0);
 	if (status == DIFF_STATUS_COPIED || status == DIFF_STATUS_RENAMED)
-		status_printf_more(s, c, "%s:%.*s%s -> %s",
+		status_printf_more(s, c, "%s%.*s%s -> %s",
 				   what, len, padding, one, two);
 	else
-		status_printf_more(s, c, "%s:%.*s%s",
+		status_printf_more(s, c, "%s%.*s%s",
 				   what, len, padding, one);
 	if (extra.len) {
 		status_printf_more(s, color(WT_STATUS_HEADER, s), "%s", extra.buf);
