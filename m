From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Sun, 13 Jun 2010 23:30:26 -0700
Message-ID: <7vbpbeazy5.fsf@alter.siamese.dyndns.org>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 08:30:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO3Bz-0006Vm-5F
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 08:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549Ab0FNGah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 02:30:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52996 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab0FNGag (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 02:30:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 218A9BCAAB;
	Mon, 14 Jun 2010 02:30:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2mzAux1m/mWS3Uqhe2DHcDn+8R8=; b=t3hNPE
	/wBxElbq3tpR8cBDevBBL8HRqjE8Hud+4Dmw32E6d6KetIii7C+7HQVvmxiz66T/
	OK7HoEHYNcHyYHVAPnXBSvOy7suRQgJxkIlT2znw94wBi73q7eq2v0qFaU8rE/l3
	2Kb4jnpILh8HY4skkYAomV1JMdUGQIe7lGfAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iT1Q3eIr6b8gj8oCY9Vr9jAaNBqnEZZB
	v2oPCkMjmDz6HZaHRdw92Q/FQJUqX2aVtU/gDD/eWwXM19SiI3hopn3QN/6YGK7x
	5IQInSTZ/fsvB1s1HyUxtwtrhYiHt835o666Jnx9ZfyIU90938QBP4TfLjvoXvcH
	zueolbiiFZc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F0984BCAA9;
	Mon, 14 Jun 2010 02:30:31 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFCBBBCAA7; Mon, 14 Jun
 2010 02:30:28 -0400 (EDT)
In-Reply-To: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
 (Scott Chacon's message of "Fri\, 11 Jun 2010 09\:03\:44 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 54F3ED70-777E-11DF-B5A5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149078>

Scott Chacon <schacon@gmail.com> writes:

> It's difficult to process 21 commands (which is what is output
> by default for git when no command is given).  They have been
> re-grouped into 4 groups of 5-6 commands each, which is clearer
> and easier for new users to process.  More advanced commands
> such as bisect and rebase have also been removed as this should
> be output for beginners.

I am lazy, and I loathe having to maintain another hardcoded table (let
alone sequence of print_command() calls, like this patch does, yuck).

The two words, "21" and "group", in your proposed commit log message have
been nagging me for a while, and I finally figured out why this patch made
me feel very disturbed.  We already have a perfect source to generate the
necessary most commonly used command list with a good grouping hint, but
the patch does not make use of it.

So here is a counterproposal.

If readers notice that there are some commands that are out of fashion
(e.g. I don't think many people use show-branch anymore in the presence of
"log --oneline --graph" and friends) listed in the "git help" output, that
is a _good thing_.  It will give us an incentive to keep the Everyday
document up to date, and with the effort spent for that, "git help" will
automatically be kept up to date as well for free ;-)

-- >8 --
Subject: generate "git help" command list using the "Everyday" document

Alphabetized list of "commonly used commands" we currently give is hard to
approach.  Instead, using the "Everyday" document as a template, group
commands by the role the user plays, and present the commands in the order
they typically used while playing each role.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Makefile            |    2 +-
 builtin/help.c      |   14 ++++++++---
 generate-cmdlist.sh |   64 +++++++++++++++++++++++++++++++++++---------------
 3 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index 5fa893c..770bea8 100644
--- a/Makefile
+++ b/Makefile
@@ -1529,7 +1529,7 @@ $(BUILT_INS): git$X
 
 common-cmds.h: ./generate-cmdlist.sh command-list.txt
 
-common-cmds.h: $(wildcard Documentation/git-*.txt)
+common-cmds.h: $(wildcard Documentation/git-*.txt) Documentation/everyday.txt
 	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
 
 define cmd_munge_script
diff --git a/builtin/help.c b/builtin/help.c
index 3182a2b..546b3a7 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -276,15 +276,21 @@ void list_common_cmds_help(void)
 	int i, longest = 0;
 
 	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
+		if (!common_cmds[i].help)
+			continue;
 		if (longest < strlen(common_cmds[i].name))
 			longest = strlen(common_cmds[i].name);
 	}
 
-	puts("The most commonly used git commands are:");
+	puts("Some commonly used git commands per developer roles are:");
 	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("   %s   ", common_cmds[i].name);
-		mput_char(' ', longest - strlen(common_cmds[i].name));
-		puts(common_cmds[i].help);
+		if (!common_cmds[i].help) {
+			printf(" * %s\n", common_cmds[i].name);
+		} else {
+			printf("   %s  ", common_cmds[i].name);
+			mput_char(' ', longest - strlen(common_cmds[i].name));
+			puts(common_cmds[i].help);
+		}
 	}
 }
 
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 75c68d9..c6cab26 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -1,24 +1,50 @@
 #!/bin/sh
 
-echo "/* Automatically generated by $0 */
-struct cmdname_help
+echo "/* Automatically generated by $0 - do not edit */
+
+/*
+ * Special entries without 'help' are section headers.
+ */
+static struct cmdname_help
 {
-    char name[16];
-    char help[80];
-};
+	const char *name;
+	const char *help;
+} common_cmds[] = {"
+
+perl -e '
+my %seen = ();
+my $section = undef;
+
+while (<STDIN>) {
+	chomp;
+	if (/^\S.*\[\[(.+)\]\]$/) {
+		print "\n  { \"$1\", NULL },\n\n";
+		next;
+	}
+	while (s/linkgit:git-([-a-z]*)//) {
+		my $cmd = $1;
+		next if ($seen{$cmd}++);
 
-static struct cmdname_help common_cmds[] = {"
+		my $desc = undef;
+		open I, "<", "Documentation/git-$cmd.txt"
+			or die "Cannot read Documentation/git-$cmd.txt: $!";
+		while (<I>) {
+			next if (1../^NAME/);
+			if (/^git-$cmd /) {
+				s/^git-$cmd - //;
+				chomp;
+				$desc = $_;
+				last;
+			}
+		}
+		close I;
+		if (!defined $desc) {
+			die "Cannot read description for $cmd";
+		}
+		print "  { \"$cmd\", \"$desc\" },\n";
+	}
+}
+' <Documentation/everyday.txt
 
-sed -n -e 's/^git-\([^ 	]*\)[ 	].* common.*/\1/p' command-list.txt |
-sort |
-while read cmd
-do
-     sed -n '
-     /^NAME/,/git-'"$cmd"'/H
-     ${
-            x
-            s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
-	    p
-     }' "Documentation/git-$cmd.txt"
-done
-echo "};"
+echo "
+};"
