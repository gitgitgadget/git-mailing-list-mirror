From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] log: add log.mailmap configuration option
Date: Sat, 22 Dec 2012 20:26:16 -0800
Message-ID: <7v8v8ppf6f.fsf@alter.siamese.dyndns.org>
References: <1356195512-4846-1-git-send-email-apelisse@gmail.com>
 <1356195512-4846-3-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 05:26:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tmd9B-0003CI-Vm
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 05:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106Ab2LWE0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 23:26:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62898 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983Ab2LWE0X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 23:26:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E0A5A66A;
	Sat, 22 Dec 2012 23:26:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mxg4w0wSy1eJimkudoc6SClkC2Q=; b=MvsBZg
	JvbjZxbN7cRL0DG4oJLc4c6gJiLKgb+ppwKmX/Z+p/wL6oq8mr5NhzcG9d9mba0T
	AqIQ7wIfkPU9XqNja3FNYTRikRVpZoBZeoud0Zya/6sOeSrZnRdO1uCt7Y0gNXoZ
	BfUJwkry19Y5wPKriXNHcNEeJnu1PLgmvoc5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UnIa73yOtl9mhG+29N1a1CC5yInxI5Qh
	TwHfMXnrJtvluQErDOF12M8/am71S6JWKpO2PtX0RHF3FIohqLYmmCylJ5yWUU0y
	iClGgXalO62wkX8NFlvbF04L3PtR2N52ByIVFrfCFCxgUiFQ44hqzUyi5qFYTET3
	xHJ4go1cY5I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BE2EA669;
	Sat, 22 Dec 2012 23:26:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAD9CA668; Sat, 22 Dec 2012
 23:26:17 -0500 (EST)
In-Reply-To: <1356195512-4846-3-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Sat, 22 Dec 2012 17:58:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E52B8DAA-4CB8-11E2-8E58-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212080>

Antoine Pelisse <apelisse@gmail.com> writes:

> This patch provides a new configuration option 'log.mailmap' to
> automatically use the --use-mailmap option from git-show, git-log and
> git-whatchanged commands.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
> I'm wondering if it would be needed to add a no-use-mailmap option to
> log command so that it can cancel this configuration option.

The usual way for adding a new feature is to add a --enable-feature
long-option without any configuration variable to let users try it
out in the field, and then add the configuration to let it be
default for users who opt in.  The first step should also allow a
command line option to disable (which should come for free if you
use parse-options API correctly).

>  Documentation/config.txt |    4 ++++
>  builtin/log.c            |    8 +++++++-
>  t/t4203-mailmap.sh       |   24 ++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index bf8f911..226362a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1509,6 +1509,10 @@ log.showroot::
>  	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
>  	normally hide the root commit will now show it. True by default.
>
> +log.mailmap::
> +	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
> +	linkgit:git-whatchanged[1] assume `--use-mailmap`.
> +
>  mailmap.file::
>  	The location of an augmenting mailmap file. The default
>  	mailmap, located in the root of the repository, is loaded
> diff --git a/builtin/log.c b/builtin/log.c
> index d2bd8ce..f6936ff 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -31,6 +31,7 @@ static int default_abbrev_commit;
>  static int default_show_root = 1;
>  static int decoration_style;
>  static int decoration_given;
> +static int use_mailmap;
>  static const char *fmt_patch_subject_prefix = "PATCH";
>  static const char *fmt_pretty;
>
> @@ -138,7 +139,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  	if (source)
>  		rev->show_source = 1;
>
> -	if (mailmap) {
> +	if (mailmap || use_mailmap) {
>  		rev->mailmap = xcalloc(1, sizeof(struct string_list));
>  		read_mailmap(rev->mailmap, NULL);
>  	}
> @@ -358,6 +359,11 @@ static int git_log_config(const char *var, const char *value, void *cb)
>  	}
>  	if (!prefixcmp(var, "color.decorate."))
>  		return parse_decorate_color_config(var, 15, value);
> +	if (!strcmp(var, "log.mailmap")) {
> +		use_mailmap = git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	if (grep_config(var, value, cb) < 0)
>  		return -1;
>  	return git_diff_ui_config(var, value, cb);
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index e16187f..7d4d31c 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -255,6 +255,21 @@ test_expect_success 'Log output with --use-mailmap' '
>  '
>
>  cat >expect <<\EOF
> +Author: CTO <cto@company.xx>
> +Author: Santa Claus <santa.claus@northpole.xx>
> +Author: Santa Claus <santa.claus@northpole.xx>
> +Author: Other Author <other@author.xx>
> +Author: Other Author <other@author.xx>
> +Author: Some Dude <some@dude.xx>
> +Author: A U Thor <author@example.com>
> +EOF
> +
> +test_expect_success 'Log output with log.mailmap' '
> +	git -c log.mailmap=True log | grep Author >actual &&
> +	test_cmp expect actual
> +'
> +
> +cat >expect <<\EOF
>  Author: Santa Claus <santa.claus@northpole.xx>
>  Author: Santa Claus <santa.claus@northpole.xx>
>  EOF
> @@ -263,6 +278,15 @@ test_expect_success 'Grep author with --use-mailmap' '
>  	git log --use-mailmap --author Santa | grep Author >actual &&
>  	test_cmp expect actual
>  '
> +cat >expect <<\EOF
> +Author: Santa Claus <santa.claus@northpole.xx>
> +Author: Santa Claus <santa.claus@northpole.xx>
> +EOF
> +
> +test_expect_success 'Grep author with log.mailmap' '
> +	git -c log.mailmap=True log --author Santa | grep Author >actual &&
> +	test_cmp expect actual
> +'
>
>  >expect
>
> --
> 1.7.9.5
