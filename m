From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] for-each-repo: new command used for multi-repo
 operations
Date: Wed, 23 Jan 2013 12:54:17 -0800
Message-ID: <7v1udbhb7q.fsf@alter.siamese.dyndns.org>
References: <1358971180-10652-1-git-send-email-hjemli@gmail.com>
 <1358971180-10652-2-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 21:54:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty7LF-0007zg-Mi
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 21:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764Ab3AWUyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 15:54:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65345 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028Ab3AWUyU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 15:54:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFEC0BD00;
	Wed, 23 Jan 2013 15:54:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vIzIdewTGMgcR4/R1fOpm3Ho3tE=; b=jODCAY
	R7pKLFGYNbsIrP+g5ejKHRtpjUx99p8MMzhfwZOZfgnnLyy524UFe+vTANgEQ1GK
	fmrzstftXg+DRGOjerv/85E1F9d7eb9BtoSQMXi0fXlK0hcPAJdLycUw3IeieuCt
	Qf9wyLEUTaDBPuBGwk/+XDd7kVZDotP8brlcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WLj3tyxtfxr/X4HNHU318sPPSk7XUzF5
	Z2tQTSsh8maWA7P8Btf9eooZUnEhCkXOZ/N5xIIDLKIJCLs61rk8UIbUg5gfNfMT
	qk8rHhRBbVDOUMrk81vPnxRvEIBMYRfWdEw1ICmiQMIUw1M+IwYjN6dEz8KNyleo
	crLQb0tOVzY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5E0DBCFF;
	Wed, 23 Jan 2013 15:54:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9512BCFB; Wed, 23 Jan 2013
 15:54:18 -0500 (EST)
In-Reply-To: <1358971180-10652-2-git-send-email-hjemli@gmail.com> (Lars
 Hjemli's message of "Wed, 23 Jan 2013 20:59:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E51BB1A-659F-11E2-9EA9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214363>

Lars Hjemli <hjemli@gmail.com> writes:

> diff --git a/Documentation/git-for-each-repo.txt b/Documentation/git-for-each-repo.txt
> new file mode 100644
> index 0000000..be49e96
> --- /dev/null
> +++ b/Documentation/git-for-each-repo.txt
> @@ -0,0 +1,62 @@
> +git-for-each-repo(1)
> +====================
> +
> +NAME
> +----
> +git-for-each-repo - Execute a git command in multiple repositories

"multiple non-bare repositories", I think.

> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git for-each-repo' [--all|--clean|--dirty] [command]
> +
> +DESCRIPTION
> +-----------
> +The git-for-each-repo command is used to locate all git repositoris

Likewise; "all non-bare Git repositories".

> diff --git a/t/t6400-for-each-repo.sh b/t/t6400-for-each-repo.sh
> new file mode 100755
> index 0000000..4797629
> --- /dev/null
> +++ b/t/t6400-for-each-repo.sh
> @@ -0,0 +1,48 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2013 Lars Hjemli
> +#
> +
> +test_description='Test the git-for-each-repo command'
> +
> +. ./test-lib.sh
> +
> +test_expect_success "setup" '
> +	test_create_repo clean &&
> +	(cd clean && test_commit foo) &&
> +	git init --separate-git-dir=.cleansub clean/gitfile &&
> +	(cd clean/gitfile && test_commit foo && echo bar >>foo.t) &&
> +	test_create_repo dirty-wt &&
> +	(cd dirty-wt && mv .git .linkedgit && ln -s .linkedgit .git &&
> +	  test_commit foo && rm foo.t) &&
> +	test_create_repo dirty-idx &&
> +	(cd dirty-idx && test_commit foo && git rm foo.t) &&
> +	mkdir fakedir && mkdir fakedir/.git
> +'
> +
> +test_expect_success "without flags, all repos are included" '
> +	echo "." >expect &&
> +	echo "clean" >>expect &&
> +	echo "clean/gitfile" >>expect &&
> +	echo "dirty-idx" >>expect &&
> +	echo "dirty-wt" >>expect &&
> +	git for-each-repo | sort >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success "--dirty only includes dirty repos" '
> +	echo "clean/gitfile" >expect &&
> +	echo "dirty-idx" >>expect &&
> +	echo "dirty-wt" >>expect &&
> +	git for-each-repo --dirty | sort >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success "--clean only includes clean repos" '
> +	echo "." >expect &&
> +	echo "clean" >>expect &&
> +	git for-each-repo --clean | sort >actual &&
> +	test_cmp expect actual
> +'

Please add tests to show some command executions (e.g. test output
from "git ls-files", or something).

> +static void handle_repo(char *path, const char **argv)
> +{
> +	if (path[0] == '.' && path[1] == '/')
> +		path += 2;
> +	if (match != ALL && match != get_repo_state())
> +		return;
> +	if (*argv) {
> +		color_fprintf_ln(stdout, GIT_COLOR_YELLOW, "[%s]", path);
> +		run_command_v_opt(argv, RUN_GIT_CMD);

This seems to allow people to run only a single Git subcommand,
which is probably not what most people want to see.  Don't we want
to support something as simple as this?

	git for-each-repository sh -c "ls *.c"

> +	} else
> +		printf("%s\n", path);

Assuming that the non *argv case is for consumption by programs and
scripts (similar to the way "ls-files" output is piped to downstream),
we prefer to (1) support "-z" so that "xargs -0" can read paths with
funny characters, and (2) use quote_c_style() from quote.c when "-z"
is not in effect.

> +}
> + ...
> +			setenv(GIT_DIR_ENVIRONMENT, gitdir, 1);
> +			strbuf_setlen(path, len - 1);
> +			setenv(GIT_WORK_TREE_ENVIRONMENT, path->buf, 1);
> +			handle_repo(path->buf, argv);

When you are only showing the path to a repository, I do not think
you want setenv() or chdir() at all. Shouldn't these be done inside
handle_repo() function?  As you are only dealing with non-bare
repositories (and that is what you print in "listing only" mode
anyway), handle_repo() can borrow path (not path->buf) and append
and strip "/.git" as needed.

Also, while it is a good idea to protect this program from stray
GIT_DIR/GIT_WORK_TREE the user may have in the environment when this
program is started, I think this is not enough, if you allow the
*argv commands to run worktree related operations in each repository
you discover.  You would need to chdir() to the top of the working
tree.

The run-command API lets you specify custom environment only for the
child process without affecting yourself by setting .env member of
the child_process structure, so we may want to use that instead of
doing setenv() on ourselves (and letting it inherited by the child).
