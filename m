From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/10] teach replace objects to sha1_object_info_extended()
Date: Mon, 30 Dec 2013 12:32:30 -0800
Message-ID: <xmqqob3yqdup.fsf@gitster.dls.corp.google.com>
References: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Dec 30 21:32:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxjVw-00068M-DY
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 21:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188Ab3L3Ucg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 15:32:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932117Ab3L3Ucf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 15:32:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 255A85F34F;
	Mon, 30 Dec 2013 15:32:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YfQJzDsIecW7vD3PGGd5e6878yc=; b=O3ZiAM
	2eQPVWjQ/vTrmShW9GhhTgiKtA8tSvH999XtWOYYRAAfncEexGEKS9l3sGv8MncD
	E0yGtQ7sF1lu+AnfQ7cqnmUyZbDV5lp7MjB+hpurLd3G1SAcdzkAvxDEnXerXb2M
	qRFmPHrP7rm1gwEEWrFTexa+kUNrVHA0eFJqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XU7OGAsTFw668Vzv92XOg6OcoS739Nza
	GyDpKUTdz/geLuIGYiMlMUcMBy4+QD4i4yRPqnAsw8ESCGlHEQ9S+wJd9U6oRRUW
	2L5zBiE1KwBXpJUfN5deGzc1Wr18kTR1qbTvrZSM6hbavTsrbhr9lTJxYjxBDlTE
	lvNzoH6R+n4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 163325F34E;
	Mon, 30 Dec 2013 15:32:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54CCA5F34C;
	Mon, 30 Dec 2013 15:32:33 -0500 (EST)
In-Reply-To: <20131228105505.2272.58873.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 28 Dec 2013 12:00:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8304FD38-7191-11E3-9E64-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239823>

Christian Couder <chriscool@tuxfamily.org> writes:

> The only changes compared to version 3 are the following:

I'll queue this instead on top, as the series is already in 'next'.

Thanks.

-- >8 --
From: Christian Couder <chriscool@tuxfamily.org>
Date: Sat, 28 Dec 2013 12:00:05 +0100
Subject: [PATCH] replace info: rename 'full' to 'long' and clarify in-code symbols

Enum names SHORT/MEDIUM/FULL were too broad to be descriptive.  And
they clashed with built-in symbols on platforms like Windows.
Clarify by giving them REPLACE_FORMAT_ prefix.

Rename 'full' format in "git replace --format=<name>" to 'long', to
match others (i.e. 'short' and 'medium').

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt |  4 ++--
 builtin/replace.c             | 24 ++++++++++++++----------
 t/t6050-replace.sh            |  4 ++--
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 7a07828..0a02f70 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -72,7 +72,7 @@ OPTIONS
 
 --format=<format>::
 	When listing, use the specified <format>, which can be one of
-	'short', 'medium' and 'full'. When omitted, the format
+	'short', 'medium' and 'long'. When omitted, the format
 	defaults to 'short'.
 
 FORMATS
@@ -84,7 +84,7 @@ The following format are available:
 	<replaced sha1>
 * 'medium':
 	<replaced sha1> -> <replacement sha1>
-* 'full'
+* 'long':
 	<replaced sha1> (<replaced type>) -> <replacement sha1> (<replacement type>)
 
 CREATING REPLACEMENT OBJECTS
diff --git a/builtin/replace.c b/builtin/replace.c
index 1672870..2336325 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -20,11 +20,15 @@ static const char * const git_replace_usage[] = {
 	NULL
 };
 
-enum repl_fmt { SHORT, MEDIUM, FULL };
+enum replace_format {
+      REPLACE_FORMAT_SHORT,
+      REPLACE_FORMAT_MEDIUM,
+      REPLACE_FORMAT_LONG
+};
 
 struct show_data {
 	const char *pattern;
-	enum repl_fmt fmt;
+	enum replace_format format;
 };
 
 static int show_reference(const char *refname, const unsigned char *sha1,
@@ -33,11 +37,11 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 	struct show_data *data = cb_data;
 
 	if (!fnmatch(data->pattern, refname, 0)) {
-		if (data->fmt == SHORT)
+		if (data->format == REPLACE_FORMAT_SHORT)
 			printf("%s\n", refname);
-		else if (data->fmt == MEDIUM)
+		else if (data->format == REPLACE_FORMAT_MEDIUM)
 			printf("%s -> %s\n", refname, sha1_to_hex(sha1));
-		else { /* data->fmt == FULL */
+		else { /* data->format == REPLACE_FORMAT_LONG */
 			unsigned char object[20];
 			enum object_type obj_type, repl_type;
 
@@ -64,14 +68,14 @@ static int list_replace_refs(const char *pattern, const char *format)
 	data.pattern = pattern;
 
 	if (format == NULL || *format == '\0' || !strcmp(format, "short"))
-		data.fmt = SHORT;
+		data.format = REPLACE_FORMAT_SHORT;
 	else if (!strcmp(format, "medium"))
-		data.fmt = MEDIUM;
-	else if (!strcmp(format, "full"))
-		data.fmt = FULL;
+		data.format = REPLACE_FORMAT_MEDIUM;
+	else if (!strcmp(format, "long"))
+		data.format = REPLACE_FORMAT_LONG;
 	else
 		die("invalid replace format '%s'\n"
-		    "valid formats are 'short', 'medium' and 'full'\n",
+		    "valid formats are 'short', 'medium' and 'long'\n",
 		    format);
 
 	for_each_replace_ref(show_reference, (void *) &data);
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index d0c62f7..719a116 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -306,7 +306,7 @@ test_expect_success 'test --format medium' '
 	test_cmp expected actual
 '
 
-test_expect_success 'test --format full' '
+test_expect_success 'test --format long' '
 	{
 		echo "$H1 (commit) -> $BLOB (blob)" &&
 		echo "$BLOB (blob) -> $REPLACED (blob)" &&
@@ -314,7 +314,7 @@ test_expect_success 'test --format full' '
 		echo "$PARA3 (commit) -> $S (commit)" &&
 		echo "$MYTAG (tag) -> $HASH1 (commit)"
 	} | sort >expected &&
-	git replace --format=full | sort > actual &&
+	git replace --format=long | sort > actual &&
 	test_cmp expected actual
 '
 
-- 
1.8.5.2-311-g6427a96
