From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Replace "git-" with "git " in *.[ch] comments and
 notifications
Date: Fri, 29 Aug 2008 17:56:58 -0700
Message-ID: <7vvdxj2ucl.fsf@gitster.siamese.dyndns.org>
References: <20080829234751.GA2396@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Sat Aug 30 03:01:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZEqe-000125-UB
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 03:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbYH3A5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 20:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYH3A5F
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 20:57:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44689 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbYH3A5E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 20:57:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0DAEC57B45;
	Fri, 29 Aug 2008 20:57:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4A1BB57B44; Fri, 29 Aug 2008 20:57:00 -0400 (EDT)
In-Reply-To: <20080829234751.GA2396@zakalwe.fi> (Heikki Orsila's message of
 "Sat, 30 Aug 2008 02:47:51 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8EFC0A96-762E-11DD-A761-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94352>

Heikki Orsila <heikki.orsila@iki.fi> writes:

> diff --git a/archive.c b/archive.c
> index e2280df..042f587 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -282,7 +282,7 @@ static int parse_archive_args(int argc, const char **argv,
>  		OPT_STRING(0, "remote", &remote, "repo",
>  			"retrieve the archive from remote repository <repo>"),
>  		OPT_STRING(0, "exec", &exec, "cmd",
> -			"path to the remote git-upload-archive command"),
> +			"path to the remote git upload-archive command"),
>  		OPT_END()
>  	};

Are you sure about this one?  How would one spell the command line?

	$ git archive --exec='/usr/local/bin/git upload-archive'

I somehow think this wouldn't fly well.

I do not think a single patch with the above hunk (which I think is a
mistake) and other bits that are obviously good (e.g. the first hunk to
builtin-apply.c we see below) is reviewable, but I cannot think of a
better alterantive.  Sigh...

> diff --git a/builtin-apply.c b/builtin-apply.c
> index 2216a0b..1e14904 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -274,7 +274,7 @@ static void say_patch_name(FILE *output, const char *pre,
>  static void read_patch_file(struct strbuf *sb, int fd)
>  {
>  	if (strbuf_read(sb, fd, 0) < 0)
> -		die("git-apply: read returned %s", strerror(errno));
> +		die("git apply: read returned %s", strerror(errno));
>  
>  	/*
>  	 * Make sure that we have some slop in the buffer

Good.

> @@ -506,17 +506,17 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
>  		name = orig_name;
>  		len = strlen(name);
>  		if (isnull)
> -			die("git-apply: bad git-diff - expected /dev/null, got %s on line %d", name, linenr);
> +			die("git apply: bad git diff - expected /dev/null, got %s on line %d", name, linenr);
>  		another = find_name(line, NULL, p_value, TERM_TAB);
>  		if (!another || memcmp(another, name, len))
> -			die("git-apply: bad git-diff - inconsistent %s filename on line %d", oldnew, linenr);
> +			die("git apply: bad git diff - inconsistent %s filename on line %d", oldnew, linenr);

I am not sure about this one.  This is not talking about the git-diff
program, but about a variant of "diff" with git flavour (similar to the
word "unified diff" -- there is no "unified" command with subcommand
"diff").   So rolling this kind fo change into a topic that tries to get
rid of "dashed form of commands" feels quite wrong, even though as a
general wording improvement, I think it is better than the original (and I
would even suggest rewording to "git patch", to make sure we are not
talking about the "git-diff" program).

I did not look at the rest.
