From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] tag: die when listing missing or corrupt objects
Date: Mon, 06 Feb 2012 10:13:27 -0800
Message-ID: <7vty337rug.fsf@alter.siamese.dyndns.org>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <20120206081342.GB3966@sigill.intra.peff.net>
 <7vk4408ir6.fsf@alter.siamese.dyndns.org>
 <7vfweo8ikq.fsf@alter.siamese.dyndns.org>
 <20120206083832.GA9425@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Tom Grennan <tmgrennan@gmail.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 19:13:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuT4P-0007JO-3n
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 19:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233Ab2BFSNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 13:13:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40842 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111Ab2BFSNa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 13:13:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C84626C16;
	Mon,  6 Feb 2012 13:13:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DnVNbmT5WCcJWkjG2FoILKkFlKU=; b=iVNles
	fEPD6WWseLqnFvTz2K5xemflbaTTEVfVrjN2D8OHo/kXJZ/F/le4NJPW/h84zF1v
	uyZs6uBbZ/SVonFVW7Nuo0lcJKvDuNiVEvSFvktBydQYqf2HaQ9Mrng5sDYwt0rM
	/LAb+5hx3K6QJhZeXw3ISFZjBftYFKKkGNQY0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xCFLaa0PfwAq3+e8CrwKfsIaO+KLpEEE
	ISusxQvY8S+VcPKOMQHSNIKiwFAlgiiN+2rmsCYUnq+9rmx4fBOYseVpTPE89pRy
	SW3D2vT+fP00/ixPc2OSxOJHnKlVpXP/UflqCNMndHQPX5GXycRRJyAF/E1+O0fq
	g/1zrE9dRRI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C05FD6C15;
	Mon,  6 Feb 2012 13:13:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 214B36C13; Mon,  6 Feb 2012
 13:13:29 -0500 (EST)
In-Reply-To: <20120206083832.GA9425@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 6 Feb 2012 03:38:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4537363A-50EE-11E1-A87E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190085>

Jeff King <peff@peff.net> writes:

> OK, that's easy enough to do. Should we show lightweight tags to commits
> for backwards compatibility (and just drop the parse_signature junk in
> that case)? The showing of blobs or trees is the really bad thing, I
> think.

For now, dropping 3/3 and queuing this instead...

---
Subject: tag: do not show non-tag contents with "-n"

"git tag -n" did not check the type of the object it is reading the top n
lines from. At least, avoid showing the beginning of trees and blobs when
dealing with lightweight tags that point at them.

As the payload of a tag and a commit look similar in that they both start
with a header block, which is skipped for the purpose of "-n" output,
followed by human readable text, allow the message of commit objects to be
shown just like the contents of tag objects. This avoids regression for
people who have been using "tag -n" to show the log messages of commits
that are pointed at by lightweight tags.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/tag.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 1e27f5c..6d6ae88 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -95,19 +95,20 @@ static void show_tag_lines(const unsigned char *sha1, int lines)
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
 		die_errno("unable to read object %s", sha1_to_hex(sha1));
-	if (!size) {
-		free(buf);
-		return;
-	}
+	if (type != OBJ_COMMIT || type != OBJ_TAG)
+		goto free_return;
+	if (!size)
+		die("an empty %s object %s?",
+		    typename(type), sha1_to_hex(sha1));
 
 	/* skip header */
 	sp = strstr(buf, "\n\n");
-	if (!sp) {
-		free(buf);
-		return;
-	}
-	/* only take up to "lines" lines, and strip the signature */
-	size = parse_signature(buf, size);
+	if (!sp)
+		goto free_return;
+
+	/* only take up to "lines" lines, and strip the signature from a tag */
+	if (type == OBJ_TAG)
+		size = parse_signature(buf, size);
 	for (i = 0, sp += 2; i < lines && sp < buf + size; i++) {
 		if (i)
 			printf("\n    ");
@@ -118,6 +119,7 @@ static void show_tag_lines(const unsigned char *sha1, int lines)
 			break;
 		sp = eol + 1;
 	}
+free_return:
 	free(buf);
 }
 
