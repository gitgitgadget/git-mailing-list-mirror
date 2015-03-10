From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: decorate detached HEAD differently
Date: Mon, 09 Mar 2015 19:03:18 -0700
Message-ID: <xmqqh9tt623d.fsf@gitster.dls.corp.google.com>
References: <CAPc5daWz-Xa7q6f9RzgTP4has8DcCG4QgK7SMGNbH6KGnEyr2Q@mail.gmail.com>
	<015d6992d2c2165045117f763d9ce3131979c2db.1425658434.git.git@drmicha.warpmail.net>
	<xmqq61aeymlv.fsf@gitster.dls.corp.google.com>
	<54FD64D1.6080103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Julien Cretel <j.cretel@umail.ucc.ie>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 03:03:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV9W8-0008C4-1T
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 03:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbbCJCD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 22:03:28 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751321AbbCJCD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 22:03:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEAE53F8D2;
	Mon,  9 Mar 2015 22:03:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V4moj7sK+gF1jhH1x8+IGvdnCK4=; b=DE/8xF
	6DTYqWRoijV6RzzoN9sxuwQPB0Nh+hfuJgipLRsOSSvJALRhVOrZWcw1z3Jk3gSg
	LLTOm5R2JZBXxABukKhdOOPrnOXZlvBTui/s+AlTbn9nv/XQAByb+8vG4TRYK3Vm
	inHt9yH2voNd0AZedWZ8hCKUrtqwj0wQ0X7eM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iYRpkXXkkTig8YJCU1tBBtV6UpPSJBpu
	nxwL7TcIEGr/6TgqJb/z6VS81XWkdruGzuxrWkJY+iOGx7nUTdOa6HI+4khN4PNU
	qddt44FTpYYpkqkrW0iZMNO8hlsrSihrxLJ37QvJhBuKz2nmdcgenHOW1u2fLK7V
	/bSpGdycQkg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6ADE3F8D1;
	Mon,  9 Mar 2015 22:03:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4199B3F8D0;
	Mon,  9 Mar 2015 22:03:20 -0400 (EDT)
In-Reply-To: <54FD64D1.6080103@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 09 Mar 2015 10:16:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9FFCCE96-C6C9-11E4-A874-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265205>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 06.03.2015 20:03:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>     
>>>     Note that now a checked branch is listed twice, once as target of the
>>>     HEAD, once as branch: They are two different refs and colored differently.
>> 
>> The pointee of HEAD would always be branch and will always appear on
>> the output when you show HEAD->$name_of_that_branch; is it feasible
>> to drop the duplicate, I wonder?
>
> It's doable but not nice, because we cannot take the order in which refs
> are processed for granted.

That is true, but when we format them into a single line in the
header in response to --decorate (or %d), don't we have all of them
already at hand---does the order still matter?

Here is an illustration of what I had in mind, made on a random
commit I happened to have checked out that does not have your
patches on this topic.  Half of the change is a new helper function,
and the other half is mostly reindenting.

 log-tree.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 8 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 7f0890e..e0c5865 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -173,6 +173,43 @@ static void show_children(struct rev_info *opt, struct commit *commit, int abbre
 }
 
 /*
+ * Do we have HEAD in the output, and also the branch it points at?
+ * If so, find that decoration entry for that current branch.
+ */
+static const struct name_decoration *current_pointed_by_HEAD(const struct name_decoration *decoration)
+{
+	const struct name_decoration *list, *head = NULL;
+	const char *branch_name = NULL;
+	unsigned char unused[20];
+	int rru_flags;
+
+	/* First find HEAD */
+	for (list = decoration; list; list = list->next)
+		if (list->type == DECORATION_REF_HEAD) {
+			head = list;
+			break;
+		}
+	if (!head)
+		return NULL;
+
+	/* Now resolve and find the matching current branch */
+	branch_name = resolve_ref_unsafe("HEAD", 0, unused, &rru_flags);
+	if (!(rru_flags & REF_ISSYMREF))
+		return NULL;
+	if (!skip_prefix(branch_name, "refs/heads/", &branch_name))
+		return NULL;
+
+	/* OK, do we have that ref in the list? */
+	for (list = decoration; list; list = list->next)
+		if ((list->type == DECORATION_REF_LOCAL) &&
+		    !strcmp(branch_name, list->name)) {
+			return list;
+		}
+
+	return NULL;
+}
+
+/*
  * The caller makes sure there is no funny color before calling.
  * format_decorations_extended makes sure the same after return.
  */
@@ -184,6 +221,7 @@ void format_decorations_extended(struct strbuf *sb,
 			const char *suffix)
 {
 	const struct name_decoration *decoration;
+	const struct name_decoration *current_and_HEAD;
 	const char *color_commit =
 		diff_get_color(use_color, DIFF_COMMIT);
 	const char *color_reset =
@@ -192,15 +230,32 @@ void format_decorations_extended(struct strbuf *sb,
 	decoration = get_name_decoration(&commit->object);
 	if (!decoration)
 		return;
+
+	current_and_HEAD = current_pointed_by_HEAD(decoration);
 	while (decoration) {
-		strbuf_addstr(sb, color_commit);
-		strbuf_addstr(sb, prefix);
-		strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
-		if (decoration->type == DECORATION_REF_TAG)
-			strbuf_addstr(sb, "tag: ");
-		strbuf_addstr(sb, decoration->name);
-		strbuf_addstr(sb, color_reset);
-		prefix = separator;
+		/*
+		 * When both current and HEAD are there, only
+		 * show HEAD->current where HEAD would have
+		 * appeaed, skipping the entry for current.
+		 */
+		if (current_and_HEAD && decoration == current_and_HEAD)
+			;
+		else {
+			strbuf_addstr(sb, color_commit);
+			strbuf_addstr(sb, prefix);
+			strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
+			if (decoration->type == DECORATION_REF_TAG)
+				strbuf_addstr(sb, "tag: ");
+
+			if (current_and_HEAD &&
+			    decoration->type == DECORATION_REF_HEAD)
+				strbuf_addf(sb, "HEAD->%s", current_and_HEAD->name);
+			else
+				strbuf_addstr(sb, decoration->name);
+			strbuf_addstr(sb, color_reset);
+
+			prefix = separator;
+		}
 		decoration = decoration->next;
 	}
 	strbuf_addstr(sb, color_commit);
