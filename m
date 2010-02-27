From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Allow explicit ANSI codes for colors
Date: Sat, 27 Feb 2010 13:21:22 -0800
Message-ID: <7vfx4mv0h9.fsf@alter.siamese.dyndns.org>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com>
 <1267246670-19118-2-git-send-email-lodatom@gmail.com>
 <20100227085144.GD27191@coredump.intra.peff.net>
 <ca433831002271024t5af1dba9m6ca719c114e54892@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 22:21:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlU6W-0006hd-Fo
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 22:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933592Ab0B0VVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 16:21:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933277Ab0B0VVe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 16:21:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 751E29DB7A;
	Sat, 27 Feb 2010 16:21:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=je0jGtjpOmvTqmVcc5cu9lE8rm0=; b=DXRID+
	Cj4rVwB09e1C3PIpIB4dV9ncLn9QGKUo3SzF4S8/BOcqiVvzj9MZoepSK2x6f0vt
	aoZpOfYKuVLOn2/aWg2BZVaW/ShVbg85OdUCbbd7yQ5d2ZNsU3v9TTAFGBwxRXEc
	7bOoX33c/UvzuYJj/XpLObgpDD73yxcCEk73U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oAbPHZNVMVyEbntcgsd0zl4l0bka28p/
	F71ftDeaiYLCgxWB4TQ5s/VXgAqdfrSYNOPjFKMg9IMKi8Pug7Mfv+SWYW1QHe79
	VN3fxe+uhheS+BIIfeKKA8bNRdF0G5SvJwksEBlY6eqqfG/CWuJPQOLxt/pVe4oZ
	BughCaV1vDg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DDDD9DB79;
	Sat, 27 Feb 2010 16:21:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 313279DB78; Sat, 27 Feb
 2010 16:21:24 -0500 (EST)
In-Reply-To: <ca433831002271024t5af1dba9m6ca719c114e54892@mail.gmail.com>
 (Mark Lodato's message of "Sat\, 27 Feb 2010 13\:24\:53 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 112F5340-23E6-11DF-8F49-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141228>

Mark Lodato <lodatom@gmail.com> writes:

> On Sat, Feb 27, 2010 at 3:51 AM, Jeff King <peff@peff.net> wrote:
>> I am not against this patch if it gets us some flexibility that is not
>> otherwise easy to attain,
>
> Besides disallowing multiple attributes (e.g. bold blink), the current
> parser does not have a way to specify colors for 16-color mode colors
> 8-15, 256-color mode colors 0-7, or any 88-color mode colors.  There
> are also other esoteric attributes [1] that some user might want to
> use, such as italic or franktur.  I don't know if anyone will ever use
> this feature, but it wasn't hard to implement.

The purist side of me has been hoping that we could later wean off this
ANSI centric view of the terminal attribute handling and move us to
something based on terminfo.  This patch makes it even harder by going
quite the opposite way.

But the pragmatic side of me has long held a feeling that nobody who would
use git uses real terminals these days anymore, and there is no terminal
emulator that does not grok ANSI sequences.  msysgit folks have even done
their own ANSI color emulation in their "Console" interface layer, so that
may be another reason that we are practically married to ANSI sequence and
there is not much gained by introducing terminfo as another layer of
abstraction to build GIT_COLOR_* on top of.

What I am saying is that the purist in me actively hates [PATCH 1/5], but
the pragmatist in me admits it would not hurt in practice.

>> but wouldn't it be more user friendly for us
>> to support "red blink bold ul italic"?
>
> Yes, I think this should be done whether or not the patch in question
> is accepted.

Hmm, I do not care much about italic, blink nor ul, but perhaps other
people do.  Combining attributes like "reverse bold" would probably make
sense.

 color.c |   35 +++++++++++++++++++++++++++--------
 1 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/color.c b/color.c
index 62977f4..f210d94 100644
--- a/color.c
+++ b/color.c
@@ -47,7 +47,8 @@ void color_parse_mem(const char *value, int value_len, const char *var,
 {
 	const char *ptr = value;
 	int len = value_len;
-	int attr = -1;
+	int attr[20];
+	int attr_idx = 0;
 	int fg = -2;
 	int bg = -2;
 
@@ -56,7 +57,7 @@ void color_parse_mem(const char *value, int value_len, const char *var,
 		return;
 	}
 
-	/* [fg [bg]] [attr] */
+	/* [fg [bg]] [attr]... */
 	while (len > 0) {
 		const char *word = ptr;
 		int val, wordlen = 0;
@@ -85,19 +86,37 @@ void color_parse_mem(const char *value, int value_len, const char *var,
 			goto bad;
 		}
 		val = parse_attr(word, wordlen);
-		if (val < 0 || attr != -1)
+		if (0 <= val && attr_idx < ARRAY_SIZE(attr))
+			attr[attr_idx++] = val;
+		else
 			goto bad;
-		attr = val;
 	}
 
-	if (attr >= 0 || fg >= 0 || bg >= 0) {
+	if (attr_idx > 0 || fg >= 0 || bg >= 0) {
 		int sep = 0;
+		int i;
+
+		if (COLOR_MAXLEN <=
+		    /* Number of bytes to denote colors and attributes */
+		    (attr_idx
+		     + (fg < 0 ? 0 :
+			((fg < 8) ? 2 : 8)) /* "3x" or "38;5;xxx" */
+		     + (bg < 0 ? 0 :
+			((bg < 8) ? 2 : 8)) /* "4x" or "48;5;xxx" */
+			    ) +
+		    /* Number of semicolons between the above */
+		    (attr_idx + (0 <= fg) + (0 <= bg) - 1) +
+		    /* ESC '[', terminating 'm' and NUL */
+		    4)
+			goto bad;
 
 		*dst++ = '\033';
 		*dst++ = '[';
-		if (attr >= 0) {
-			*dst++ = '0' + attr;
-			sep++;
+
+		for (i = 0; i < attr_idx; i++) {
+			if (sep++)
+				*dst++ = ';';
+			*dst++ = '0' + attr[i];
 		}
 		if (fg >= 0) {
 			if (sep++)
