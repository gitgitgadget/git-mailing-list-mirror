From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] realloc failed
Date: Sun, 22 May 2011 12:34:14 -0700
Message-ID: <7v8vtyy1ft.fsf@alter.siamese.dyndns.org>
References: <20110521100126.E3CD.BA9123DE@callcc.net>
 <7vhb8o25tt.fsf@alter.siamese.dyndns.org>
 <20110521145056.E3F5.BA9123DE@callcc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kazuki Tsujimoto <kazuki@callcc.net>
X-From: git-owner@vger.kernel.org Sun May 22 21:34:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOEPz-0001dX-QD
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 21:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185Ab1EVTeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 15:34:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab1EVTeW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 15:34:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5C82F460B;
	Sun, 22 May 2011 15:36:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=su3epyX7Itshr7R6y0l1heUhVi8=; b=PaJjv0zxIJwUpfFU00et
	dxPt88ef8fDlauFZHlr7hVfgaG64XfSXI6D/kJ/8XQTytJo2TCyNhfQBWdH5+G0a
	Uk3hoLRqZtNjUHD1Gt2XBr1cf3nlL839+s9k3LQQvkeKXVOEIZuIbgLbK5PmI+Ak
	YtaZ7H9j9j8c8hxaLHHBSvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=DkCO4fldC9XbW/xswLpKCDkL20gzp5ANF5HuVI2AqmwSjB
	kcIS+W3a2NNhpCqHrKo5yuNnYfAOa9IVFgOmkJNDHm4yK3LppbKN8PfQ6ZGMUXaH
	xmPWx2d6S/la+7t19rDXnWAzM/TzE7NHuUmBMbrF9X+O4Wv6YZ3sOo+0iEQXU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B8D2460A;
	Sun, 22 May 2011 15:36:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 27E0B4609; Sun, 22 May 2011
 15:36:22 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C85858DE-84AA-11E0-89E6-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174196>

Kazuki Tsujimoto <kazuki@callcc.net> writes:

> From: Junio C Hamano <gitster@pobox.com>
> Date: Fri, 20 May 2011 18:35:58 -0700
>
>> Care to send a patch with test (see Documentation/SubmittingPatches)?
>
> Thanks for your comment.
> Here is a patch with test.
>
> [PATCH] Avoid "realloc failed" error in alias expansion including -c option

Just for your future reference.

Retitle the "Subject:" to the above line, and move everything above after
the "---" line. Another style that is usable in a discussion thread is to
use a scissors-line "-- >8 --" to say "ignore everything above this line"
(I'll use this message as a demonstration), but we didn't have a long
thread here, so just a straight patch with comment after "---" is preferred
in this case.

>
> When the -c option is specified, setenv will be called.
> Therefore, set envchanged flag to true so that git exits with
> "alias '%s' changes environment variables" error.
>
> Signed-off-by: Kazuki Tsujimoto <kazuki@callcc.net>
> ---
>  git.c                   |    2 ++
>  t/t1020-subdirectory.sh |   15 +++++++++++++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/git.c b/git.c
> index a5ef3c6..e04e4d4 100644
> --- a/git.c
> +++ b/git.c
> @@ -153,6 +153,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  				usage(git_usage_string);
>  			}
>  			git_config_push_parameter((*argv)[1]);
> +			if (envchanged)
> +				*envchanged = 1;
>  			(*argv)++;
>  			(*argc)--;
>  		} else {

Sorry, but I have to say that you are solving a wrong problem with a wrong
approach.

The realloc() failure you saw is caused by this sequence:

        option_count = handle_options(&new_argv, &count, &envchanged);
        ...
        new_argv -= option_count;
        ...
        new_argv = xrealloc(new_argv, sizeof(char *) * (count + *argcp));

The "handle_options()" function advances new_argv, trying to strip the
earlier items it recognized, and indicates how many it stripped by its
return value. When the caller wants to resize the arguments array, it
no longer points at the beginning of the buffer returned by malloc(),
and compensates what handle_options() did by subtracting option_count
before calling realloc().

The immediate cause of the problem is that handle_options() returns a
wrong count when it sees a "-c <config-specification>". If you look at its
implementation, you see "handled++" paired with "(*argv)++" everywhere but
the place it parsed "-c".

There is no inherent reason to forbid "-c <config-specification>" in
the alias, e.g. "-c ui.color=no diff". Your patch may avoid the failure
from the realloc, but breaks uses of such aliases.

The "envchanged" thing is there to avoid a situation like this:

 * You have an alias "foo" in .git/config;

 * You run "git --git-dir=/some/where/else foo";

 * We may read that "foo" alias from .git/config in your current
   directory, or we may notice the "--git-dir" on the command line, and
   may not to even read from that particular .git/config file that has
   "foo". Depending on the implementation of git (and its vintage), this
   will lead to an unexpected behaviour.

So a patch to fix the "immediate cause" would probably look like this
instead.

-- >8 --
Subject: handle_options(): do not miscount how many arguments were used

The handle_options() function advances the base of the argument array and
returns the number of arguments it used. The caller in handle_alias()
wants to reallocate the argv array it passes to this function, and
attempts to do so by subtracting the returned value to compensate for the
change handle_options() makes to the new_argv.

But handle_options() did not correctly count when "-c <config=value>" is
given, causing a wrong pointer to be passed to realloc().

Fix it by saving the original argv at the beginning of handle_options(),
and return the difference between the final value of argv, which will
relieve the places that move the array pointer from the additional burden
of keeping track of "handled" counter.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index ef598c3..df4306d 100644
--- a/git.c
+++ b/git.c
@@ -66,7 +66,7 @@ static void commit_pager_choice(void) {
 
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
-	int handled = 0;
+	const char **orig_argv = *argv;
 
 	while (*argc > 0) {
 		const char *cmd = (*argv)[0];
@@ -116,7 +116,6 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
-			handled++;
 		} else if (!prefixcmp(cmd, "--git-dir=")) {
 			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
 			if (envchanged)
@@ -156,9 +155,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 
 		(*argv)++;
 		(*argc)--;
-		handled++;
 	}
-	return handled;
+	return (*argv) - orig_argv;
 }
 
 static int handle_alias(int *argcp, const char ***argv)
