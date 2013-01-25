From: Junio C Hamano <gitster@pobox.com>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Thu, 24 Jan 2013 19:59:58 -0800
Message-ID: <7vzjzx7w01.fsf@alter.siamese.dyndns.org>
References: <20130123143816.GA579@krypton.darkbyte.org>
 <20130123200222.GB19832@sigill.intra.peff.net>
 <510124F5.9090505@atlas-elektronik.com>
 <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
 <51013FDD.5030004@atlas-elektronik.com>
 <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
 <20130124232721.GA16036@sigill.intra.peff.net>
 <7va9ry87a0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>, Jonathon Mah <jmah@me.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:00:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyaSo-0003fn-0T
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 05:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab3AYEAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 23:00:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab3AYEAB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 23:00:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BFA9C402;
	Thu, 24 Jan 2013 23:00:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kry3gCxGzseQJl2xpc9z4ofAaNs=; b=iFK1qY
	qwQUfg2Tejuk1rHgBDDhdoXjkPYGbXm9a5yuFbDVchcFcKrWQVr8HBGld46Bgngt
	xkWEXAaA8dTF1BZRkxdE0eWC2LNNnoylvZEVEJMUuhA4bV7xIRloNWVc/52gRZYB
	l5qTJpJskeaWr+QytC6pGXuP3sN8TeaGN28NI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B2Ue5rbwpXFXohvFMzPT3Bzlv3OTH8Vq
	MtTGLAV7/Ui9UTaS3tt1ArliFTzLzHv+H9Anc/m9LqSDeMHF8oQlv8hMIGGX+Cri
	T6/mNvvS03w7XEfzvOBVsRtforeOWFn0cc/7u69+SE7SdT5l/0onw0Z28hmi8G7m
	Nol6Mo3epF4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FA92C401;
	Thu, 24 Jan 2013 23:00:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3253AC3FE; Thu, 24 Jan 2013
 23:00:00 -0500 (EST)
In-Reply-To: <7va9ry87a0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 24 Jan 2013 15:56:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B08B4806-66A3-11E2-9127-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214484>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> ... (e.g., how should "log" know that a submodule diff might later want
>> to see the same entry? Should we optimistically free and then make it
>> easier for the later user to reliably ensure the buffer is primed? Or
>> should we err on the side of keeping it in place?).
>
> My knee-jerk reaction is that we should consider that commit->buffer
> belongs to the revision traversal machinery.  Any other uses bolted
> on later can borrow it if buffer still exists (I do not think pretty
> code rewrites the buffer contents in place in any way), or they can
> ask read_sha1_file() to read it themselves and free when they are
> done.

I've been toying with an idea along this line.

 commit.h        | 16 ++++++++++++++++
 builtin/blame.c | 27 ++++++++-------------------
 commit.c        | 20 ++++++++++++++++++++
 3 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/commit.h b/commit.h
index c16c8a7..b559535 100644
--- a/commit.h
+++ b/commit.h
@@ -226,4 +226,20 @@ extern void print_commit_list(struct commit_list *list,
 			      const char *format_cur,
 			      const char *format_last);
 
+extern int ensure_commit_buffer(struct commit *);
+extern void discard_commit_buffer(struct commit *);
+
+#define with_commit_buffer(commit) \
+	do { \
+		int had_buffer_ = !!commit->buffer; \
+		if (!had_buffer_) \
+			ensure_commit_buffer(commit); \
+		do
+
+#define done_with_commit_buffer(commit) \
+		while (0); \
+		if (!had_buffer_) \
+			discard_commit_buffer(commit); \
+	} while (0)
+
 #endif /* COMMIT_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index b431ba3..8b2e4a5 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1424,25 +1424,14 @@ static void get_commit_info(struct commit *commit,
 
 	commit_info_init(ret);
 
-	/*
-	 * We've operated without save_commit_buffer, so
-	 * we now need to populate them for output.
-	 */
-	if (!commit->buffer) {
-		enum object_type type;
-		unsigned long size;
-		commit->buffer =
-			read_sha1_file(commit->object.sha1, &type, &size);
-		if (!commit->buffer)
-			die("Cannot read commit %s",
-			    sha1_to_hex(commit->object.sha1));
-	}
-	encoding = get_log_output_encoding();
-	reencoded = logmsg_reencode(commit, encoding);
-	message   = reencoded ? reencoded : commit->buffer;
-	get_ac_line(message, "\nauthor ",
-		    &ret->author, &ret->author_mail,
-		    &ret->author_time, &ret->author_tz);
+	with_commit_buffer(commit) {
+		encoding = get_log_output_encoding();
+		reencoded = logmsg_reencode(commit, encoding);
+		message   = reencoded ? reencoded : commit->buffer;
+		get_ac_line(message, "\nauthor ",
+			    &ret->author, &ret->author_mail,
+			    &ret->author_time, &ret->author_tz);
+	} done_with_commit_buffer(commit);
 
 	if (!detailed) {
 		free(reencoded);
diff --git a/commit.c b/commit.c
index e8eb0ae..a627eea 100644
--- a/commit.c
+++ b/commit.c
@@ -1357,3 +1357,23 @@ void print_commit_list(struct commit_list *list,
 		printf(format, sha1_to_hex(list->item->object.sha1));
 	}
 }
+
+int ensure_commit_buffer(struct commit *commit)
+{
+	enum object_type type;
+	unsigned long size;
+
+	if (commit->buffer)
+		return 0;
+	commit->buffer = read_sha1_file(commit->object.sha1, &type, &size);
+	if (commit->buffer)
+		return -1;
+	else
+		return 0;
+}
+
+void discard_commit_buffer(struct commit *commit)
+{
+	free(commit->buffer);
+	commit->buffer = NULL;
+}
