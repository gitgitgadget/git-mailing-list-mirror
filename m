From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] "git add -A/--no-all" finishing touches
Date: Thu, 25 Apr 2013 16:06:30 -0700
Message-ID: <7vhaiu1a89.fsf@alter.siamese.dyndns.org>
References: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
	<1366663435-13598-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 01:06:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVVFZ-00061q-Fx
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 01:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758745Ab3DYXGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 19:06:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38934 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758712Ab3DYXGn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 19:06:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37D9819DFE;
	Thu, 25 Apr 2013 23:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=THOlIoJVwKqtysx+3vc5wL6OC7M=; b=IWemNh
	7BzNSmPFZxTntVd051ovR9ir9FFfU3wzWF5mdT20ATBsaS5BCsH+1M+cNIqH0qZi
	/mHsyxn9qYFaNsbtos/dV6f2IA9h5dXvbvaTjlUygaZrignmnYb66Uzy6LPzR1D8
	PAkiwHORJbTTMGch7Du4d99xFhLj3HIbLNgvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dRQJhV/69ZsVAUzaEc0uiwPEfXVFR2aP
	NKOA0hi7l2KiZLzpljMN9Y2a4RSAEJlUE1Vf6sU+ddzm/o6D1PkD8EXnRHj9x7UM
	Ne5hq+5hfXxXiL1rm8MqATTP+Is7kw+FOgYlQm8NcmqXL/6i6ezRFww8Yc9hGJwR
	AyuyGMaOyOc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B40C19DFB;
	Thu, 25 Apr 2013 23:06:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83DF819DF7;
	Thu, 25 Apr 2013 23:06:31 +0000 (UTC)
In-Reply-To: <1366663435-13598-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Mon, 22 Apr 2013 13:43:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C48CF908-ADFC-11E2-9C29-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222460>

Junio C Hamano <gitster@pobox.com> writes:

> Applying Jonathan's idea on top of the early part that has graduated
> to 'master', here is to add "--ignore-removal" (which is a more
> natural way to say "--no-all") and use it in the warning message.
>
> Junio C Hamano (2):
>   git add: --ignore-removal is a better named --no-all
>   git add: rephrase -A/--no-all warning
>
>  Documentation/git-add.txt | 10 ++++++----
>  builtin/add.c             | 23 +++++++++++++++++------
>  2 files changed, 23 insertions(+), 10 deletions(-)

I am planning to fast-track this to 'master' for 1.8.3, to
complement Jonathan's "add -u/-A without pathspec" warning.

It would be nice if people can eyeball the behaviour of tonight's
'next', find glitches (if any) and help polishing it before the
feature freeze.

One thing I noticed about Jonathan's warn_pathless_add() thing is
that even though it knows for which path we would behave differently
between the current version and Git 2.0, the warning message does
not say which path outside the current directory would be added if
not restricted with an explicit ".", and leaves the reader in
suspense.

We may want to fix it by tweaking the end of the message, perhaps?

 builtin/add.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index d4b40f2..24a2d6f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -36,7 +36,7 @@ struct update_callback_data {
 static const char *option_with_implicit_dot;
 static const char *short_option_with_implicit_dot;
 
-static void warn_pathless_add(void)
+static void warn_pathless_add(const char *path)
 {
 	static int shown;
 	assert(option_with_implicit_dot && short_option_with_implicit_dot);
@@ -67,12 +67,16 @@ static void warn_pathless_add(void)
 		  "  git add %s .\n"
 		  "  (or git add %s .)\n"
 		  "\n"
-		  "With the current Git version, the command is restricted to "
-		  "the current directory.\n"
+		  "With the current Git version, the command is limited to the current"
+		  "directory, and paths like '%s'\n"
+		  "that %s are not added.\n"
 		  ""),
 		option_with_implicit_dot, short_option_with_implicit_dot,
 		option_with_implicit_dot, short_option_with_implicit_dot,
-		option_with_implicit_dot, short_option_with_implicit_dot);
+		option_with_implicit_dot, short_option_with_implicit_dot,
+		path,
+		(!strcmp(short_option_with_implicit_dot, "-u")
+		 ? _("are modified") : _("are new")));
 }
 
 static int fix_unmerged_status(struct diff_filepair *p,
@@ -136,7 +140,7 @@ static void update_callback(struct diff_queue_struct *q,
 		 */
 		if (implicit_dot &&
 		    strncmp_icase(path, implicit_dot, implicit_dot_len)) {
-			warn_pathless_add();
+			warn_pathless_add(path);
 			continue;
 		}
 		switch (fix_unmerged_status(p, data)) {
