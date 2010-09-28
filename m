From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pull request for msysGit patches
Date: Tue, 28 Sep 2010 12:10:04 -0700
Message-ID: <7vocbhsn03.fsf@alter.siamese.dyndns.org>
References: <87ocbitd33.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Sep 28 21:10:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0fZJ-0001Jk-BU
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 21:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab0I1TKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 15:10:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270Ab0I1TKR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 15:10:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0857DD841C;
	Tue, 28 Sep 2010 15:10:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UlbYqoXMR5cyTSQS/J92WyThjPA=; b=NPUsn9
	cAK9voKwsEgZnO0PalR3xzlTX0Nj1Oh/vd8sZCAY+gvnTpFRrTgpmGNxPvbS+Q74
	9OOWNXYqD2MO/UKfKNHwUrN93bEcJOzHsqmkexyV4oXvXC38qc+oM5XH2XAgQf5Y
	70orsNI4leE6rbuEWo1BEJTj2uR71bYtdjENg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UhfFqx5Ck4zpQeGVj2KQ5+AeiMXL9aT2
	aeeWPmwouZBrbFl+ZsRl8+lWD6lPItuaSXv8hphILNE+5g/Qv2CPWEivUkEjqtfD
	Hid1OnByWqSin3u4ZkYEZf6UhEbR8H9UMgZkcdDps+YQOZEZZfNaIN7YKfbMtCxp
	XMQHgw/3jBQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B5525D841B;
	Tue, 28 Sep 2010 15:10:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 354BAD841A; Tue, 28 Sep
 2010 15:10:06 -0400 (EDT)
In-Reply-To: <87ocbitd33.fsf@fox.patthoyts.tk> (Pat Thoyts's message of
 "Tue\, 28 Sep 2010 10\:46\:40 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 046945A8-CB34-11DF-BC64-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157461>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> Junio,
>
> The msysGit tree currently tracks some 50+ patches on top of 'next'. I
> have gathered 42 of these that look good to move upstream. 
> Please pull from
>   git://repo.or.cz/git/mingw/4msysgit.git work/pt/for-junio
> also visible for inspection at
>   http://repo.or.cz/w/git/mingw/4msysgit.git/shortlog/refs/heads/work/pt/for-junio

Sorry, I cannot pull anything based directly on top of 'next'.  However,
except for the one that touch t/t3032-merge-recursive-options.sh at the
tip, the series seem to apply cleanly to the tip of 'master'.

There seem to be many patches that touch outside compat/ area.  Have they
been reviewed and discussed here already?

A quick and superficial review follows.

----------------------------------------------------------------
abspath.c

@@ -108,10 +108,15 @@ const char *make_nonrelative_path(const char *path)
 		if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
 			die("Too long path: %.*s", 60, path);
 	} else {
+		size_t len;
+		const char *fmt;
 		const char *cwd = get_pwd_cwd();
 		if (!cwd)
 			die_errno("Cannot determine the current working directory");
-		if (snprintf(buf, PATH_MAX, "%s/%s", cwd, path) >= PATH_MAX)
+		len = strlen(cwd);
+		/* For cwd c:/, return c:/foo rather than URL-like c://foo */

For the patch to be regression free, the logic described by this comment
requires get_pwd_cmd() to return a string with trailing dir-sep only at
slash.  IOW, if you see any non-root path returned with a trailing dir-sep
for whatever reason, you are changing the behaviour in that case as well,
and that clearly is not "fix at the root level".

But if you label this as "avoid duplicated dir-sep", everything flows
smoothly ;-).

+		fmt = len > 0 && is_dir_sep(cwd[len-1]) ? "%s%s" : "%s/%s";

Please have () around "len > 0 && is_dir_sep(cwd[len-1])" for readability.

+		if (snprintf(buf, PATH_MAX, fmt, cwd, path) >= PATH_MAX)
 			die("Too long path: %.*s", 60, path);

----------------------------------------------------------------
get_home_directory()

The patch looks fine, but the commit log message is way insufficient.  Can
you restate what problem it addresses, and why it is the best solution?

----------------------------------------------------------------
Hide dotfiles

It is somewhat unfortunate that this Windows-only hack needs to touch
cache.h and environment.c.

hidedotfiles may currently be the only platform specific configuration
variable, but we might want to futureproof by abstracting this out,
perhaps by adding a call to platform_core_config() at the end of
git_default_core_config(), provide a default implementation that is a
no-op, and allow platforms to override it, or something like that?

----------------------------------------------------------------
pack-objects.c usage string
connect.c use of unchecked git_getpass()

Good eyes, but these should not be part of the series but applied to
maint.  If possible please send them separately.

----------------------------------------------------------------
compat/regex/regexec.c

Thanks for fixing up my mess ;-)

----------------------------------------------------------------
git-am.sh

This is questionable.  Does this mean that on POSIX boxes I cannot have my
patch mailbox named 0:pt.patch, 1:pt.patch, etc.?

Adding "is_absolute_path" helper that has a different implementation
depending on the platform in git-sh-setup and using it here would limit
the extent of damage?

----------------------------------------------------------------
git-merge-octopus.sh

Transliterating a-z to A-z may happen to work because A-z is A-Z with a
lot of garbage concatenated at the end that won't be used, but it feels
sloppy.

Why isn't upcasing necessary for all the other uses of environment
variables?  For example, we pass reflog action by exporting a variable,
and we use GIT_AUTHOR_NAME and friends to override configuration
variables.  Do they get upcased?

What I am getting at is that this might be just fixing a symptom, and
between applying similar band-aid to many other places and finding out why
undesired upcaing happens and fixing that, I'd rather see the latter done.

----------------------------------------------------------------
git-send-email.perl

Similar comment as is_absolute_path(), although in Perl environment I
suspect we can just use an existing package without adding our own.

----------------------------------------------------------------
t/test-lib.sh

Is "DIFF=${DIFF:-diff}" needed?  How is the existing initialization (in
'maint') of GIT_TEST_CMP working?

----------------------------------------------------------------

I didn't look at tests very deeply.  Other changes outside compat/ that I
didn't mention above looked fine.

Thanks.
