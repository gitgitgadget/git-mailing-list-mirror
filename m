From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add "%w" to pretty formats, which rewraps the commit
 message
Date: Sun, 04 Oct 2009 23:25:07 -0700
Message-ID: <7v63augxx8.fsf@alter.siamese.dyndns.org>
References: <7vfxaercma.fsf@alter.siamese.dyndns.org>
 <1253655038-20335-1-git-send-email-heipei@hackvalue.de>
 <alpine.DEB.1.00.0909232232050.4985@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909232232560.4985@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909232233330.4985@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909232233590.4985@pacific.mpi-cbg.de>
 <20090923210055.GA25197@dualtron.vpn.rwth-aachen.de>
 <7v63b9gsg1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Gilger <heipei@hackvalue.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 08:27:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muh2g-000420-0D
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 08:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbZJEG0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 02:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbZJEG0E
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 02:26:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbZJEG0C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 02:26:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0EAEE6BA8F;
	Mon,  5 Oct 2009 02:25:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3L87JY5Izz5s4AjjjTOx415yHB0=; b=Ae1By0
	XXJEXR+sf9VdcHlVOvFIv6IH0RPicemM30KmsHcNVT5Db+v8yzwmrxBMTDiywQDJ
	1XAu0sRkjkFesFjaEDJe7ZE93Pqw/22NlNhUYcqPTrQvJRzjFKXl12RDdteXNRm4
	iBEOcox8cwdUCQRfc/K6jElSpzM94iJlxxBQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UPM85BhqWS0hRGQch2E1tnhdIoXUnDA0
	fX1h3PaNuBxy1mIGP4DaM17LWZ3L2xrDQF+8Rxc4VvzY22IyGTwBBIGABAXKqN8u
	iORI/uofqfzIBmpFS+2HFpPc1h8VhrweEzywA9hxuP0XOx4bL/Gc//m5I+WxDUoS
	OJCMcWCWjp0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D8B9F6BA8D;
	Mon,  5 Oct 2009 02:25:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CC7486BA88; Mon,  5 Oct 2009
 02:25:09 -0400 (EDT)
In-Reply-To: <7v63b9gsg1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 23 Sep 2009 16\:19\:26 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D8743D76-B177-11DE-BF6F-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129532>

Junio C Hamano <gitster@pobox.com> writes:

> One issue %w() sidesteps is handing of single liner commit log messages
> (this is not a new issue your %B(n) introduces).  "%s%n%b" will give us
> the original message only when the log has some contents in addition to
> the single-line summary.  Otherwise we will get an extra blank line.
>
> Perhaps we could extend the pretty-printer so that it understands %+x
> notation, which expands to %n%x when %x expands to a non-empty result, and
> otherwise it expands to empty, as a generic extension applicable to any
> format specifier 'x'.  If we have such a notation, "%s%+b", would be a
> reasonable way to say "give us the original commit log message here", and
> we won't need %w(i,j,w) -- we can instead say %S(i,j,w)%+B(i,j,w), or
> %s%+B(i,j,w) depending on what you want.

This teaches the machinery to add a separator LF before any non-empty
expansion of '%x' if you ask '%+x', and also removes LF if '%x' expands to
an empty string if you ask '%-x', for any supported expansion placeholder
'x' it supports.

With the first two patches Dscho posted (and then polished in his tree),
it shouldn't be too hard to update your %B(n) to %B(i,j,w) and also add
%S(i,j,w) in a similar way, to allow people to say %S(i,j,w)%+B(i,j,w)
instead of (or in addition to) his %w(i,j,w).



 pretty.c                   |   42 ++++++++++++++++++++++++++++++++++++++++--
 t/t6006-rev-list-format.sh |   22 ++++++++++++++++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index f5983f8..081feb6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -595,8 +595,8 @@ static void format_decoration(struct strbuf *sb, const struct commit *commit)
 		strbuf_addch(sb, ')');
 }
 
-static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
-                               void *context)
+static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
+				void *context)
 {
 	struct format_commit_context *c = context;
 	const struct commit *commit = c->commit;
@@ -739,6 +739,44 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	return 0;	/* unknown placeholder */
 }
 
+static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
+				 void *context)
+{
+	int consumed;
+	size_t orig_len;
+	enum {
+		NO_MAGIC,
+		ADD_LF_BEFORE_NON_EMPTY,
+		DEL_LF_BEFORE_EMPTY,
+	} magic = NO_MAGIC;
+
+	switch (placeholder[0]) {
+	case '-':
+		magic = DEL_LF_BEFORE_EMPTY;
+		break;
+	case '+':
+		magic = ADD_LF_BEFORE_NON_EMPTY;
+		break;
+	default:
+		break;
+	}
+	if (magic != NO_MAGIC)
+		placeholder++;
+
+	orig_len = sb->len;
+	consumed = format_commit_one(sb, placeholder, context);
+	if (magic == NO_MAGIC)
+		return consumed;
+
+	if ((orig_len == sb->len) && magic == DEL_LF_BEFORE_EMPTY) {
+		while (sb->len && sb->buf[sb->len - 1] == '\n')
+			strbuf_setlen(sb, sb->len - 1);
+	} else if ((orig_len != sb->len) && magic == ADD_LF_BEFORE_NON_EMPTY) {
+		strbuf_insert(sb, orig_len, "\n", 1);
+	}
+	return consumed + 1;
+}
+
 void format_commit_message(const struct commit *commit,
 			   const void *format, struct strbuf *sb,
 			   enum date_mode dmode)
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 59d1f62..18a77a7 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -162,4 +162,26 @@ test_expect_success 'empty email' '
 	}
 '
 
+test_expect_success 'del LF before empty (1)' '
+	git show -s --pretty=format:"%s%n%-b%nThanks%n" HEAD^^ >actual &&
+	test $(wc -l <actual) = 2
+'
+
+test_expect_success 'del LF before empty (2)' '
+	git show -s --pretty=format:"%s%n%-b%nThanks%n" HEAD >actual &&
+	test $(wc -l <actual) = 6 &&
+	grep "^$" actual
+'
+
+test_expect_success 'add LF before non-empty (1)' '
+	git show -s --pretty=format:"%s%+b%nThanks%n" HEAD^^ >actual &&
+	test $(wc -l <actual) = 2
+'
+
+test_expect_success 'add LF before non-empty (2)' '
+	git show -s --pretty=format:"%s%+b%nThanks%n" HEAD >actual &&
+	test $(wc -l <actual) = 6 &&
+	grep "^$" actual
+'
+
 test_done
.
