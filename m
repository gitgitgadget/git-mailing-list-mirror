From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] format-patch: rename "no_inline" field
Date: Thu, 21 Feb 2013 12:17:04 -0800
Message-ID: <7va9qxv2v3.fsf_-_@alter.siamese.dyndns.org>
References: <CAOkDyE_96Ef5CjoxNk3mbsNi+ZAuv6XeHcO7r8RQ-Of5ELsuKw@mail.gmail.com>
 <1361282783-1413-1-git-send-email-git@adamspiers.org>
 <1361282783-1413-2-git-send-email-git@adamspiers.org>
 <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <7v1ucc5b7n.fsf_-_@alter.siamese.dyndns.org>
 <20130220020046.GC7860@pacific.linksys.moosehall>
 <7vppzv3dd8.fsf@alter.siamese.dyndns.org>
 <20130220104720.GD7860@pacific.linksys.moosehall>
 <7vehg9v2xj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:17:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8caE-0000iM-Aq
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 21:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815Ab3BUURJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 15:17:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753092Ab3BUURH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 15:17:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0D4CBD13;
	Thu, 21 Feb 2013 15:17:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CyO8tmyJqm6Suhsn7c65H9eCzSs=; b=hjnmn2
	QI3hjTaj2wSLUcaXg/egXJiITURy+nBNOUByYB/OVTtInTYuE08YKJnfRqa1GDEU
	ZjBwJC/15zLJ4XdbFnIWWGNe320fRfC73WWntROjyw4pWCetzG6Hk6VuhIj1+IzJ
	l/FRT1fC/hmu66XTMHWhIwHblGE8xef3DkBYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sfoMF+PWAX5Vf5SpQ5DyX5hruMsH5y5Q
	56AO40X3U9efaOaJ9jqEaYyMTMH/4XxaCWDFqL4KayXWLVUtvTw/CKqjKl4OAsiZ
	Fcbyh6qzbLjRMlmbHi51gJuBM7eYi7Iej4dr4QOs6C7n/lEY2u+XT5NymB0gX7Uf
	j2PqjTzWiGk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FDA5BD11;
	Thu, 21 Feb 2013 15:17:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B759EBD0A; Thu, 21 Feb 2013
 15:17:05 -0500 (EST)
In-Reply-To: <7vehg9v2xj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 21 Feb 2013 12:15:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A93E89B6-7C63-11E2-AEBC-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216790>

The name of the fields invites a misunderstanding that setting it to
false, saying "No, I will not to tell you not to inline", make the
patch inlined in the body of the message, but that is not what it
does.  The result is still a MIME attachment as long as
mime_boundary is set.  This field only controls if the content
disposition of a MIME attachment is set to "attachment" or "inline".

Rename it to clarify what it is used for.  Besides, a toggle whose
name is "no_frotz" is asking for a double-negation.  Calling it
"disposition-attachment" allows us to naturally read setting the
field to true as "Yes, I want to set content-disposition to
'attachment'".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a general "clean-up" patch that does not add any feature
   nor fixes any bug.

 builtin/log.c | 6 +++---
 log-tree.c    | 2 +-
 revision.h    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8f0b2e8..30265d8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -983,7 +983,7 @@ static int attach_callback(const struct option *opt, const char *arg, int unset)
 		rev->mime_boundary = arg;
 	else
 		rev->mime_boundary = git_version_string;
-	rev->no_inline = unset ? 0 : 1;
+	rev->disposition_attachment = unset ? 0 : 1;
 	return 0;
 }
 
@@ -996,7 +996,7 @@ static int inline_callback(const struct option *opt, const char *arg, int unset)
 		rev->mime_boundary = arg;
 	else
 		rev->mime_boundary = git_version_string;
-	rev->no_inline = 0;
+	rev->disposition_attachment = 0;
 	return 0;
 }
 
@@ -1172,7 +1172,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	if (default_attach) {
 		rev.mime_boundary = default_attach;
-		rev.no_inline = 1;
+		rev.disposition_attachment = 1;
 	}
 
 	/*
diff --git a/log-tree.c b/log-tree.c
index 5dc45c4..34ec20d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -408,7 +408,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 " filename=\"%s\"\n\n",
 			 mime_boundary_leader, opt->mime_boundary,
 			 filename.buf,
-			 opt->no_inline ? "attachment" : "inline",
+			 opt->disposition_attachment ? "attachment" : "inline",
 			 filename.buf);
 		opt->diffopt.stat_sep = buffer;
 		strbuf_release(&filename);
diff --git a/revision.h b/revision.h
index 5da09ee..90813dd 100644
--- a/revision.h
+++ b/revision.h
@@ -142,7 +142,7 @@ struct rev_info {
 	const char	*extra_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
-	int		no_inline;
+	int		disposition_attachment;
 	int		show_log_size;
 	struct string_list *mailmap;
 
-- 
1.8.2.rc0.129.gcce6fe7
