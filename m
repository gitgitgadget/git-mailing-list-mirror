From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Sun, 10 Jan 2010 22:39:36 -0800
Message-ID: <7vvdf9402f.fsf@alter.siamese.dyndns.org>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
 <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 07:40:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUDwV-0004qY-22
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 07:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692Ab0AKGjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 01:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603Ab0AKGjx
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 01:39:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab0AKGjw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 01:39:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 26BF08F579;
	Mon, 11 Jan 2010 01:39:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FbKbyY/QHonqjUhRyC0KPIKkX5o=; b=d8B0lg
	zSucfREepaJpxIWVZh8jnMCDjuGaFahqRljworh06YQBcwCCas2A0sFdbqIYoNnm
	kOYR9tDUsbAVky1QZC11urPbHAM3ZjlGFxt9z5IId6Euw1GxU7iyzQCfw5LF+ruw
	/KY+KbR7Yixms4OrduAmt3FBRGbk7uvTzqCAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YHFVXhzKBKOzt/OCBsFn5Y4Rs01vM+L3
	adpMKJ/LFdihbwdSeWO0jaskFjdCqASh5ajOVHYZUgwJCxSu71YPHkhuMRMlETmZ
	pqi7FfKaBRpSFKN8aOhTg9Fo26aAhvDhuPvfbyWj49axuhYxSqynupi0pZZ30Kr6
	Z6ubeUQanIk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C14DB8F572;
	Mon, 11 Jan 2010 01:39:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77C838F570; Mon, 11 Jan
 2010 01:39:38 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
 (Linus Torvalds's message of "Mon\, 4 Jan 2010 08\:03\:04 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1ADA1E00-FE7C-11DE-A07D-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136607>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It doesn't matter. Since we do the line-by-line thing, the input is always 
> so short that DFA vs NFA vs BM vs other-clever-search doesn't matter. 
> There is no scaling - the grep buffer tends to be too small for the 
> algorithm to matter.
>
> And the reason we do things line-by-line is that we need to then output 
> things line-per-line.

Here is an experimental patch; first, some numbers (hot cache best of 5 runs).

(baseline -- builtin grep)

    $ time git grep --no-ext-grep qwerty
    drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"...

    real    0m1.521s
    user    0m1.260s
    sys     0m0.256s

    (baseline -- external grep)

    $ time git grep --ext-grep qwerty
    drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"...

    real    0m0.773s
    user    0m0.416s
    sys     0m0.376s

    (with experimental patch -- builtin grep)

    $ time ../git.git/git grep --no-ext-grep qwerty
    drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"...

    real    0m0.692s
    user    0m0.440s
    sys     0m0.252s

The idea is to see the earliest location in the entire remainder of the
buffer the pattern(s) we are looking for first appears, and skip all the
lines before that point.  For this optimization to be valid, we should not
be looking for anything complex (e.g. "find lines that have both X and Y
but not Z" is out).  We cannot use the optimization when "-v" is given,
either, because then we need to find the first line that does _not_ match
given set of patterns.

---

 grep.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/grep.c b/grep.c
index bdadf2c..940e200 100644
--- a/grep.c
+++ b/grep.c
@@ -615,6 +615,65 @@ static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
 	}
 }
 
+static int should_lookahead(struct grep_opt *opt)
+{
+	struct grep_pat *p;
+
+	if (opt->extended)
+		return 0; /* punt for too complex stuff */
+	if (opt->invert || opt->unmatch_name_only)
+		return 0;
+	for (p = opt->pattern_list; p; p = p->next) {
+		if (p->token != GREP_PATTERN)
+			return 0; /* punt for "header only" and stuff */
+	}
+	return 1;
+}
+
+static int look_ahead(struct grep_opt *opt,
+		      unsigned long *left_p,
+		      unsigned *lno_p,
+		      char **bol_p)
+{
+	unsigned lno = *lno_p;
+	char *bol = *bol_p;
+	struct grep_pat *p;
+	char *sp, *last_bol;
+	regoff_t earliest = -1;
+
+	for (p = opt->pattern_list; p; p = p->next) {
+		int hit;
+		regmatch_t m;
+
+		if (p->fixed)
+			hit = !fixmatch(p->pattern, bol, p->ignore_case, &m);
+		else
+			hit = !regexec(&p->regexp, bol, 1, &m, 0);
+		if (!hit || m.rm_so < 0 || m.rm_eo < 0)
+			continue;
+		if (earliest < 0 || m.rm_so < earliest)
+			earliest = m.rm_so;
+	}
+
+	if (earliest < 0) {
+		*bol_p = bol + *left_p;
+		*left_p = 0;
+		return 1;
+	}
+	for (sp = bol + earliest; bol < sp && sp[-1] != '\n'; sp--)
+		; /* find the beginning of the line */
+	last_bol = sp;
+
+	for (sp = bol; sp < last_bol; sp++) {
+		if (*sp == '\n')
+			lno++;
+	}
+	*left_p -= last_bol - bol;
+	*bol_p = last_bol;
+	*lno_p = lno;
+	return 0;
+}
+
 static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 char *buf, unsigned long size, int collect_hits)
 {
@@ -624,6 +683,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	unsigned last_hit = 0;
 	int binary_match_only = 0;
 	unsigned count = 0;
+	int try_lookahead = 0;
 	enum grep_context ctx = GREP_CONTEXT_HEAD;
 	xdemitconf_t xecfg;
 
@@ -652,11 +712,15 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			opt->priv = &xecfg;
 		}
 	}
+	try_lookahead = should_lookahead(opt);
 
 	while (left) {
 		char *eol, ch;
 		int hit;
 
+		if (try_lookahead
+		    && look_ahead(opt, &left, &lno, &bol))
+			break;
 		eol = end_of_line(bol, &left);
 		ch = *eol;
 		*eol = 0;
