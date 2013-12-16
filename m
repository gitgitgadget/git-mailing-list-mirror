From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2013, #03; Thu, 12)
Date: Sun, 15 Dec 2013 21:34:08 -0800
Message-ID: <xmqqa9g1qrzj.fsf@gitster.dls.corp.google.com>
References: <xmqqwqj9r2ig.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 16 06:34:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsQox-0003CQ-Bg
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 06:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab3LPFeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 00:34:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab3LPFeS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 00:34:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D50E5BB72;
	Mon, 16 Dec 2013 00:34:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZzQo8tJbr9FFm5htP5fhx731JeA=; b=D+H4vn
	0EzDdJUyArFF6uSfDhleJahaZg7Vr1KipMrRxPMOgjwh+o+Pv3KniwGu3EzWgMla
	tW6u0ZC9pHxsyw+QxuHfAtIhrOuL3Fe6fw+ErJwDZfxV+yf3Yp09Mf22eCw2NNZM
	r/1MYY8/s2oXyXLjp6AfkBOKmOOSYPtu2bAtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GSRz8E2OEHJybBx9ee5hg5V7jwpkAQhC
	gBDU83xlAoIf78umTwDjQXdPnoEWDmAQyqJs6gNL9nCrY8Aw0BBnF4F7F/J+jMql
	jtr6TCD+SswZT3JV/pII6V/ghXK6Qw7P+ct3dDJSpSfCv7dydmsRv2CKBXK6BLdn
	4MOLnHwyFCU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 777165BB71;
	Mon, 16 Dec 2013 00:34:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDB055BB70;
	Mon, 16 Dec 2013 00:34:11 -0500 (EST)
In-Reply-To: <xmqqwqj9r2ig.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 12 Dec 2013 16:57:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B16537D0-6613-11E3-9C90-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239329>

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * nv/commit-gpgsign-config (2013-11-06) 1 commit
>  - Add the commit.gpgsign option to sign all commits
>
>  Introduce commit.gpgsign configuration variable to force every
>  commit to be GPG signed.
>
>  Needs tests, perhaps?

Besides, we would need at least something like this to make sure
that people have a way to selectively disable configured default
when necessary, perhaps like this.

-- >8 --
Subject: [PATCH] commit-tree: add and document --no-gpg-sign

Document how to override commit.gpgsign configuration that is set to
true per "git commit" invocation (parse-options machinery lets us
say "--no-gpg-sign" to do so).

"git commit-tree" does not use parse-options, so manually add the
corresponding option for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-commit-tree.txt | 5 +++++
 Documentation/git-commit.txt      | 4 ++++
 builtin/commit-tree.c             | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index cafdc96..a469eab 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -55,8 +55,13 @@ OPTIONS
 	from the standard input.
 
 -S[<keyid>]::
+--gpg-sign[=<keyid>]::
 	GPG-sign commit.
 
+--no-gpg-sign::
+	Countermand `commit.gpgsign` configuration variable that is
+	set to force each and every commit to be signed.
+
 
 Commit Information
 ------------------
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 1a7616c..7c42e9c 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -302,6 +302,10 @@ configuration variable documented in linkgit:git-config[1].
 --gpg-sign[=<keyid>]::
 	GPG-sign commit.
 
+--no-gpg-sign::
+	Countermand `commit.gpgsign` configuration variable that is
+	set to force each and every commit to be signed.
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 1646d5b..4bf852d 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -71,6 +71,11 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		if (!strcmp(arg, "--no-gpgsign")) {
+			sign_commit = NULL;
+			continue;
+		}
+
 		if (!strcmp(arg, "-m")) {
 			if (argc <= ++i)
 				usage(commit_tree_usage);
-- 
1.8.5.1-272-g523f7c4
