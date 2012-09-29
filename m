From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] revision: add --grep-reflog to filter commits by
 reflog messages
Date: Sat, 29 Sep 2012 12:11:19 -0700
Message-ID: <7vbogoiqzs.fsf@alter.siamese.dyndns.org>
References: <7vr4pmm3qz.fsf@alter.siamese.dyndns.org>
 <1348893689-20240-1-git-send-email-pclouds@gmail.com>
 <1348893689-20240-3-git-send-email-pclouds@gmail.com>
 <20120929053013.GB3330@sigill.intra.peff.net>
 <7vpq55idbe.fsf@alter.siamese.dyndns.org>
 <CACsJy8A1UroqCezJFjqOqBQg+puX=jc1Q-CMSB4f=CHULY=OyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 21:11:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TI2Rq-0006Iq-LY
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 21:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758892Ab2I2TLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 15:11:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758813Ab2I2TLX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 15:11:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 607E29F84;
	Sat, 29 Sep 2012 15:11:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pv5GkF4irUo+uPcps2jUBjJJ49U=; b=TnbiqN
	noROOjz1sW7CFFUi+P1E+DkVR0YgskcT8im/x2zKPEURurlR1luLAB5InO3AWamK
	JB3CvzPVFlYQPBpOtNBS8WVLw0NhyREUSFO9llJOkd3bxyDhkP68bnCDJaTUNIAW
	jveV/+OV/sdUVNnPPZvcAN1klXkIqxuDSbbuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j9s87L2MjWA7cN/KP95DVr86e/t+c5HF
	vcRIm94phcGPUEUvkuVrrUprcdcdkcuUegt+0RtJjOVPkvyWEBRlvIekrFfqQwXK
	Kx6NBpBCMDJvcjxAobv/sFWKZAr1gnar1PmDuOnMid+8fX3AAi6P5Nr/LgQN/Hdl
	unFA9R1YVw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E3FE9F83;
	Sat, 29 Sep 2012 15:11:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F3CA9F82; Sat, 29 Sep 2012
 15:11:21 -0400 (EDT)
In-Reply-To: <CACsJy8A1UroqCezJFjqOqBQg+puX=jc1Q-CMSB4f=CHULY=OyA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 29 Sep 2012 13:13:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74530FEA-0A69-11E2-B4E8-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206656>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> reflog, in terms of both the number of commits and message length, is
> usually short enough that slowdown does not really show, especially
> when used with git-log, an interactive command.

You shouldn't do things you can easily tell you do not need to,
especially when the effort to avoid doing unnecessary allocation,
copying and deallocation is not excessively larger than the saving.

I personally think that lack of perceived performance impact is not
an excuse to be sloppy. These things tend to add up.

> That's why I put "Ignored unless --walk-reflogs is given" in the
> document. But an error would be fine too. I suppose an error is
> preferable in case users do not read document carefully?


A reader who reads documentation carefully will spot that it is a
sloppy coding that such a nonsense combination of two options are
not caught and diagnosed as an error, when accepting and silently
ignoring the option would not help anybody.

An alternative may be to turn -g on when --grep-reflog is given.
Starting from a version that forbids --grep-reflog without -g will
let us change the command line parser to do so in the future without
backward incompatibility, but you cannot do so if you start from a
version that accepts and silently ignores.

How about squashing this in?  I've future-proofed commit_match() a
bit while at it; it would be cleaner to add new fake headers if the
function is done this way.

 Documentation/rev-list-options.txt |  4 ++--
 grep.c                             |  2 ++
 grep.h                             |  1 +
 revision.c                         | 13 +++++++++++--
 t/t7810-grep.sh                    |  4 ++++
 5 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index aa7cd9d..ca22106 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -56,8 +56,8 @@ endif::git-rev-list[]
 	Limit the commits output to ones with reflog entries that
 	match the specified pattern (regular expression). With
 	more than one `--grep-reflog`, commits whose reflog message
-	matches any of the given patterns are chosen. Ignored unless
-	`--walk-reflogs` is given.
+	matches any of the given patterns are chosen.  It is an
+	error to use this option unless `--walk-reflogs` is in use.
 
 --grep=<pattern>::
 
diff --git a/grep.c b/grep.c
index d70dcdf..edc7776 100644
--- a/grep.c
+++ b/grep.c
@@ -64,6 +64,8 @@ void append_header_grep_pattern(struct grep_opt *opt,
 {
 	struct grep_pat *p = create_grep_pat(pat, strlen(pat), "header", 0,
 					     GREP_PATTERN_HEAD, field);
+	if (field == GREP_HEADER_REFLOG)
+		opt->use_reflog_filter = 1;
 	do_append_grep_pat(&opt->header_tail, p);
 }
 
diff --git a/grep.h b/grep.h
index 6e78b96..c256ac6 100644
--- a/grep.h
+++ b/grep.h
@@ -107,6 +107,7 @@ struct grep_opt {
 #define GREP_BINARY_TEXT	2
 	int binary;
 	int extended;
+	int use_reflog_filter;
 	int pcre;
 	int relative;
 	int pathname;
diff --git a/revision.c b/revision.c
index 109bec1..9ad72df 100644
--- a/revision.c
+++ b/revision.c
@@ -1908,6 +1908,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	if (revs->reflog_info && revs->graph)
 		die("cannot combine --walk-reflogs with --graph");
+	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
+		die("cannot use --grep-reflog without --walk-reflogs");
 
 	return left;
 }
@@ -2217,12 +2219,19 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	struct strbuf buf = STRBUF_INIT;
 	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
 		return 1;
-	if (opt->reflog_info) {
+
+	/* Prepend "fake" headers as needed */
+	if (opt->grep_filter.use_reflog_filter) {
 		strbuf_addstr(&buf, "reflog ");
 		get_reflog_message(&buf, opt->reflog_info);
 		strbuf_addch(&buf, '\n');
-		strbuf_addstr(&buf, commit->buffer);
 	}
+
+	/* Copy the commit to temporary if we are using "fake" headers */
+	if (buf.len)
+		strbuf_addstr(&buf, commit->buffer);
+
+	/* Find either in the commit object, or in the temporary */
 	if (buf.len)
 		retval = grep_buffer(&opt->grep_filter, buf.buf, buf.len);
 	else
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 3a5d0fd..f698001 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -572,6 +572,10 @@ test_expect_success 'log grep (9)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --grep-reflog can only be used under -g' '
+	test_must_fail git log --grep-reflog="commit: third"
+'
+
 test_expect_success 'log with multiple --grep uses union' '
 	git log --grep=i --grep=r --format=%s >actual &&
 	{
-- 
1.7.12.1.484.g1764bc0
