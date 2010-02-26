From: Mark Lodato <lodatom@gmail.com>
Subject: Meta-variable naming convention in documentation
Date: Thu, 25 Feb 2010 23:55:08 -0500
Message-ID: <ca433831002252055l37292cf6v868cc407f0be7250@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 26 05:55:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NksEh-0005sV-1h
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 05:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935240Ab0BZEz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 23:55:29 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:37595 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935233Ab0BZEz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 23:55:28 -0500
Received: by ywh35 with SMTP id 35so3726991ywh.4
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 20:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type;
        bh=WYilzOpIURK3HShaliuWisCCI8XvdLrIJIkDrUaW2GU=;
        b=JzLsnlw5b+M32DntsMt4XAWlS+FsoP/VIUW0DXKZEuuA09a5xR+lBj7SNBmY/iZ5rY
         NjeqEfLDy4pf7C4H2s2o2fkpePQ8QYVThrCUMtZMGO3wS7Ia6PLkFzHZ1IFluULpnDRl
         o9pAvFbseMNOPBcg69GLmuxISQfbBpmYVFQEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=tcr3ODb0OE0hR/NPpBegrHuGYiIzYc8dOfp2AwAysIz1TFXkP1yeD5nEQ/9aJ92Ep+
         tyHFMJTTHA0CkQTG35CPSokd8HlZ5RJSsWBJ1dC9TTRIXzxssgtmvClxr1bpb78X58Am
         q4Bk2leq0QOEaHwiBm/LsDudFUIeJwEDLQSzI=
Received: by 10.90.146.4 with SMTP id t4mr713375agd.64.1267160128126; Thu, 25 
	Feb 2010 20:55:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141104>

Currently, git's documentation and usage statements are inconsistent in
the meta-variables (e.g., <path>) used to described positional arguments
that denote a path.  This post is an attempt to document the existing
issues and to propose a potential solution.

To begin, I ran each of the git sub-commands in git 1.7.0 and documented
its behavior.  Each row contains the program, the meta-variables, and
the type.  If the man page and the '-h' usage statement differ, I list
both.  For example, git-annotate uses "file" in both the man page and
the usage statement, while git-blame uses "<file>" in the man page but
"file" in the usage statement.

The following accept exact filenames.  No directory recursion or
globing is applied.  The first group die if the file does not exist,
while the second group "filters" (f) -- they silently ignore
non-matching files.

	program			man[/usage]		type
	-------			-----------		----
	git-annotate		file			file
	git-blame		<file>/file		file
	git-checkout-index	<file>			file
	git-hash-object		<file>			file
	git-mailsplit		<mbox>|<Maildir>	file
	git-merge-file		<current-file> ...	file
	git-merge-index		<file>/<filename>	file
	git-merge-one-file	<path>			file
	git-mergetool		<file>/file to merge	file
	git-mv			<args>/<source>		file
	git-pack-redundant	.pack filename/<...>	file
	git-send-email		<file>			file
	git-update-index	<file>			file
	git-am			<dir>			dir
	git-clone		<directory>		dir
	git-cvsserver		<directory>		dir
	git-daemon		<directory>		dir
	git-fetch-pack		<directory>		dir
	git-filter-branch	<directory>		dir
	git-format-patch	<dir>			dir
	git-fsck		<dir>			dir
	git-mailsplit		<directory>		dir
	git-peek-remote		<directory>		dir
	git-quiltimport		<dir>			dir
	git-receive-pack	<directory>		dir
	git-relink		<dir>			dir
	git-send-pack		<directory>		dir
	git-submodule		<path>			dir
	git-upload-archive	<directory>		dir
	git-upload-pack		<directory>		dir
	git-bundle		<file>			outfile
	git-mailinfo		<patch>			outfile
	git-pack-objects	base-name		outfile

	git-diff-tree		<path>			file	(f)
	git-ls-tree		paths/path		file	(f)

The following accept exact filenames or directories.  If a directory,
this matches all files within that directory recursively.

	git-archive		path			fdir

	git-bisect		<paths>/<pathspec>	fdir	(f)
	git-diff		<path>			fdir	(f)
	git-diff-files		<path>			fdir	(f)
	git-diff-index		<path>			fdir	(f)
	git-difftool		<path>/(nothing)	fdir	(f)
	git-log			<path>			fdir	(f)
	git-reset		<paths>			fdir	(f)
	git-rev-list		<paths>/paths		fdir	(f)
	git-show		(undoc)/<path>		fdir	(f)
	git-whatchanged		(undocumented)		fdir	(f)
	gitk			<path>			fdir	(f)

The following accept recursive directory matches or path globs.

	git-add			<filepattern>		glob
	git-checkout		<paths>/<file>		glob
	git-commit		<file>/<filepattern>	glob
	git-rm			<file>			glob

	git-clean		<path>/<paths>		glob	(f)
	git-grep		<path>/path		glob	(f)
	git-ls-files		<file>			glob	(f)
	git-status	<pathspec>/<filepattern>	glob?	(f)

* git-rm has --ignore-unmatch, which causes it to "filter"
* git-status only accepts globs for untracked files (currently a bug?)

Here are some examples showing what I mean by "type".  (May be useful to
have something like this in the documentation.)

    pattern            file  fdir  glob
    -------            ----  ----  ----
    path/to/base.ext   yes   yes   yes
    path                -    yes   yes
    *xt                 -     -    yes
    p*t                 -     -    yes
    base.ext            -     -     -
    b*                  -     -     -
    to                  -     -     -

>From the above, it appears that there are four major groups:
* 'file' or 'dir'
* 'fdir' (f)
* 'glob'
* 'glob' (f)

(The only exceptions are git-diff-tree, git-ls-tree, and git-archive.)

Therefore, I suggest that we stick to a consistent naming convention for
these four groups, and document them in git(1).  Here's is a proposal,
but I'm not tied to these names.
* <file> for 'file'
* <dir> for 'dir'
* <path> for 'fdir' (f)
* <filepattern> for 'glob'
* <pathspec> for 'glob' (f)

We would have to come up with something for the three exceptions above,
and some commands would benefit from more detailed meta-vars, such as
"<source>... <destination>" for git-mv.

Additionally, it would be nice if all non-filtering commands had
--ignore-unmatch, and all filtering commands had an option to die/warn
if any arguments did not match.  But, this is much more work than
a simple documentation change.

Anyway, what do you think of this proposal?  I am not sure that I have
my partitioning correct, but I would like to see some sort of
consistency in the documentation.  I would be happy to implement
whatever is decided.
