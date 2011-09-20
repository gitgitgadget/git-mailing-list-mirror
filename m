From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] branch: teach --edit-description option
Date: Tue, 20 Sep 2011 16:02:43 -0700
Message-ID: <7vty864y24.fsf_-_@alter.siamese.dyndns.org>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
 <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
 <7vobynui8a.fsf@alter.siamese.dyndns.org>
 <7viposfgvd.fsf_-_@alter.siamese.dyndns.org>
 <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 01:02:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R69L0-0003Zq-G4
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 01:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab1ITXCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 19:02:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242Ab1ITXCp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 19:02:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08AAB50CE;
	Tue, 20 Sep 2011 19:02:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OLZ5bvgQ6ya8xDXDk/DU3G85+RY=; b=rdrLbm
	A9SPYYszCczXeIujCDr/a34KpgdsGSqbwclE70pwt1H95baWjyjCbJ3IdWLxcr44
	euGELf6uQsWVE6VcDLGzeN12VbiZzo0wJEB1B3LVj+RWNJ1NWMMqr11cDkFfQP+0
	FD+1s8JQf28OD3z6s24Cxa4tIExxx2zCWiZxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OLPnd8lwQrioJaw6hu0zcCWSG2d0GCL/
	qLpZ6GYnNtN74kcpYQr/qv810iPi9LWnInaXpJ8cH/ZNVrGaCuLcWrX0RdR1gfYE
	9Xhep4/VHP9rQzGVIBZwF7HdZXm8lnW+n5GqZWyUrYFrCn8Ni4B6M4W4PhCkVdZd
	CLRwjwkEcec=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F38AD50CD;
	Tue, 20 Sep 2011 19:02:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B8D650CC; Tue, 20 Sep 2011
 19:02:44 -0400 (EDT)
In-Reply-To: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 20 Sep 2011 16:01:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6488F3E-E3DC-11E0-AE0F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181805>

Using branch.$name.description as the configuration key, give users a
place to write about what the purpose of the branch is and things like
that, so that various subsystems, e.g. "push -s", "request-pull", and
"format-patch --cover-letter", can later be taught to use this
information.

The "-m" option similar to "commit/tag" is deliberately omitted, as the
whole point of branch description is about giving descriptive information
(the name of the branch itself is a better place for information that fits
on a single-line).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-branch.txt |    5 +++
 builtin/branch.c             |   68 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 79424a5..12bdffc 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
+'git branch' --edit-description [<branchname>]
 
 DESCRIPTION
 -----------
@@ -144,6 +145,10 @@ start-point is either a local or remote-tracking branch.
 	like '--track' would when creating the branch, except that where
 	branch points to is not changed.
 
+--edit-description::
+	Open an editor and edit the text to explain what the branch is
+	for, to be used by various other commands (e.g. `request-pull`).
+
 --contains <commit>::
 	Only list branches which contain the specified commit.
 
diff --git a/builtin/branch.c b/builtin/branch.c
index f49596f..94319c4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -606,11 +606,61 @@ static int opt_parse_merge_filter(const struct option *opt, const char *arg, int
 	return 0;
 }
 
+struct branch_desc_cb {
+	const char *config_name;
+	const char *value;
+};
+
+static int read_branch_desc(const char *var, const char *value, void *cb)
+{
+	struct branch_desc_cb *desc = cb;
+	if (strcmp(desc->config_name, var))
+		return 0;
+	free((char *)desc->value);
+	return git_config_string(&desc->value, var, value);
+}
+
+static const char edit_description[] = "BRANCH_DESCRIPTION";
+
+static int edit_branch_description(const char *branch_name)
+{
+	struct branch_desc_cb cb;
+	struct strbuf name = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	FILE *fp;
+
+	strbuf_addf(&name, "branch.%s.description", branch_name);
+	cb.config_name = name.buf;
+	cb.value = NULL;
+	git_config(read_branch_desc, &cb);
+
+	if (cb.value)
+		strbuf_addstr(&buf, cb.value);
+	if (!buf.len || buf.buf[buf.len-1] != '\n')
+		strbuf_addch(&buf, '\n');
+	strbuf_addf(&buf,
+		    "# Please edit the description for the branch\n"
+		    "#   %s\n"
+		    "# Lines starting with '#' will be stripped.\n",
+		    branch_name);
+	fp = fopen(git_path(edit_description), "w");
+	if (fwrite(buf.buf, 1, buf.len, fp) < buf.len) {
+		strbuf_release(&buf);
+		return error(_("could not write branch description template: %s\n"),
+			     strerror(errno));
+	}
+	strbuf_reset(&buf);
+	if (launch_editor(git_path(edit_description), &buf, NULL))
+		return -1;
+	stripspace(&buf, 1);
+	return git_config_set(name.buf, buf.buf);
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, force_create = 0;
 	int verbose = 0, abbrev = -1, detached = 0;
-	int reflog = 0;
+	int reflog = 0, edit_description = 0;
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
@@ -648,6 +698,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('m', NULL, &rename, "move/rename a branch and its reflog", 1),
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
+		OPT_BOOLEAN(0, "edit-description", &edit_description,
+			    "edit the description for the branch"),
 		OPT__FORCE(&force_create, "force creation (when already exists)"),
 		{
 			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
@@ -694,7 +746,19 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-	else if (argc == 0)
+	else if (edit_description) {
+		const char *branch_name;
+		if (detached)
+			die("Cannot give description to detached HEAD");
+		if (!argc)
+			branch_name = head;
+		else if (argc == 1)
+			branch_name = argv[0];
+		else
+			usage_with_options(builtin_branch_usage, options);
+		if (edit_branch_description(branch_name))
+			return 1;
+	} else if (argc == 0)
 		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
-- 
1.7.7.rc2.4.g5ec82
