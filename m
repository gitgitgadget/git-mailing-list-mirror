From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/7] rebase: write better reflog messages
Date: Wed, 19 Jun 2013 10:53:22 -0700
Message-ID: <7v8v260yy5.fsf@alter.siamese.dyndns.org>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
	<1371581737-10013-7-git-send-email-artagnon@gmail.com>
	<51C1442A.2010904@viscovery.net>
	<7vy5a611hb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 19 19:53:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpMZW-0005ZJ-R0
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 19:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266Ab3FSRx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 13:53:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34244 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757212Ab3FSRxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 13:53:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D715E29A95;
	Wed, 19 Jun 2013 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Eoq8Gkbox6uW2WMAf+g3rFOgWGE=; b=J+b+gf
	+QIEYc+scf1n7iPPjYLYUHZfEMZBmfbLuIHwH41Tfk8K9voO66ctBNWSHMA8cXsU
	YuM82BtahU45Wbw+mlEgUU4gUkN7pAym99auALGld/Tb9fiYKdvqRdH5XdpXZpYj
	SErSPsgmdNHAEkqoDtytFHxfEBIefVj/DpTRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oz3yizSsDt75AV56zH/1cU0/0axNQ/JO
	JMabfq32yWxfMArjsL5UsUFaFzDEMmQYeLlgeH40n0kOXSbm8fJLc1sSC9Xwx76R
	PJr9Ynl/HgmxD+UXHBMqQWlTqevp4jep+rZENMoI47UwYWViRw7PVsN53Ra0XXT4
	ojIGlV7EfQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDE2B29A94;
	Wed, 19 Jun 2013 17:53:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F3E529A8F;
	Wed, 19 Jun 2013 17:53:24 +0000 (UTC)
In-Reply-To: <7vy5a611hb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 19 Jun 2013 09:58:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23240024-D909-11E2-87DD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228405>

Junio C Hamano <gitster@pobox.com> writes:

> Excellent question, and I think this illustrates why the recent
> reroll that uses an approach to use base_reflog_action is not
> complete and needs further work (to put it mildly).
> ...
> That essentially boils down to the very original suggestion I made
> before Ram introduced the base_reflog_action.

So how about doing something like this?

Incidentally, I noticed that GIT_LITERAL_PATHSPECS:: heading in the
enumeration of environment variables is marked-up differently from
others, which is a low-hanging fruit somebody may want to fix.

 Documentation/git-sh-setup.txt |  8 +++++---
 Documentation/git.txt          | 10 ++++++++++
 git-sh-setup.sh                | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 5d709d0..4f67c4c 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -41,9 +41,11 @@ usage::
 	die with the usage message.
 
 set_reflog_action::
-	set the message that will be recorded to describe the
-	end-user action in the reflog, when the script updates a
-	ref.
+	Set GIT_REFLOG_ACTION environment to a given string (typically
+	the name of the program) unless it is already set.  Whenever
+	the script runs a `git` command that updates refs, a reflog
+	entry is created using the value of this string to leave the
+	record of what command updated the ref.
 
 git_editor::
 	runs an editor of user's choice (GIT_EDITOR, core.editor, VISUAL or
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2e23cbb..e2bdcc9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -846,6 +846,16 @@ GIT_LITERAL_PATHSPECS::
 	literal paths to Git (e.g., paths previously given to you by
 	`git ls-tree`, `--raw` diff output, etc).
 
+'GIT_REFLOG_ACTION'::
+	When a ref is updated, reflog entries are created to keep
+	track of the reason why the ref was updated (which is
+	typically the name of the high-level command that updated
+	the ref), in addition to the old and new values of the ref.
+	A scripted Porcelain command can use set_reflog_action
+	helper function in `git-sh-setup` to set its name to this
+	variable when it is invoked as the top level command by the
+	end user, to be recorded in the body of the reflog.
+
 
 Discussion[[Discussion]]
 ------------------------
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 2f78359..e5379bc 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -103,6 +103,40 @@ $LONG_USAGE"
 	esac
 fi
 
+# Set the name of the end-user facing command in the reflog when the
+# script may update refs.  When GIT_REFLOG_ACTION is already set, this
+# will not overwrite it, so that a scripted Porcelain (e.g. "git
+# rebase") can set it to its own name (e.g. "rebase") and then call
+# another scripted Porcelain (e.g. "git am") and a call to this
+# function in the latter will keep the name of the end-user facing
+# program (e.g. "rebase") in GIT_REFLOG_ACTION, ensuring whatever it
+# does will be record as actions done as part of the end-user facing
+# operation (e.g. "rebase").
+#
+# NOTE NOTE NOTE: consequently, after assigning a specific message to
+# GIT_REFLOG_ACTION when calling a "git" command to record a custom
+# reflog message, do not leave that custom value in GIT_REFLOG_ACTION,
+# after you are done.  Other callers of "git" commands that rely on
+# writing the default "program name" in reflog expect the variable to
+# contain the value set by this function.
+#
+# To use a custom reflog message, do either one of these three:
+#
+# (a) use a single-shot export form:
+#     GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: preparing frotz" \
+#         git command-that-updates-a-ref
+#
+# (b) save the original away and restore:
+#     SAVED_ACTION=$GIT_REFLOG_ACTION
+#     GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: preparing frotz"
+#     git command-that-updates-a-ref
+#     GIT_REFLOG_ACITON=$SAVED_ACTION
+#
+# (c) assign the variable in a subshell:
+#     (
+#         GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: preparing frotz"
+#         git command-that-updates-a-ref
+#     )
 set_reflog_action() {
 	if [ -z "${GIT_REFLOG_ACTION:+set}" ]
 	then
