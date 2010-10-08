From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: [PATCH/RFC] Unify argument and option notation in the docs
Date: Fri, 8 Oct 2010 02:52:56 +0200
Message-ID: <20101008005256.GA21738@headley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 02:54:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P41E0-0002QA-Cs
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 02:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008Ab0JHAyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 20:54:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47631 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab0JHAyG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 20:54:06 -0400
Received: by bwz11 with SMTP id 11so335124bwz.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=DsCi9qbbayYDOkvD7+K/TaJdbzr+KcAAU1M4Epg6sfI=;
        b=Zg3LudH7SbkR+l46oWQlmAyNb+hEAkSbwSBNOA0gdSgh5+WkhAQMCd2E9NoeBevyRv
         3dKFTvGAu4JyWw7tap5aKzBsrnZEXnZczV+3pCOG8oRWVLDQtLm9IOsQ4fC6SXcPARmW
         N1MM+4ZeXxXZSyWDzDIKB8jZoqc7ayj7SiVuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=vFbxr7Y9zJJJxGk7WwnybLBdxW6UtMgnIaCMiQt+Z4a/z2eEmDmv2MJCX0oWAx60IG
         D4Lz15DWWL1YKUGxUhSo9vk0MbW6ZuGnX3MuP/ZRUwMlz4IDRU8VLYsMW6E63h0Vfagj
         VzbiAJ5bSnc2DPU01j6X87i64asSgVvtWbmVc=
Received: by 10.204.121.84 with SMTP id g20mr1357479bkr.37.1286499241034;
        Thu, 07 Oct 2010 17:54:01 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id v7sm2122457bkx.4.2010.10.07.17.53.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 17:53:59 -0700 (PDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158467>

In general, the current usage is already pretty consistent, so it is
not too hard to induce the guidelines and correct the rest based on
them.

Some examples of what this patch is based on (i.e., the current
prevalent usage) follow (all coming from existing documentation):

Placeholders are enclosed in angle brackets:
  <file>
  --sort=<key>
  --abbrev[=<n>]

Possibility of multiple occurences is indicated by three dots:
  <file>...
  (One or more of <file>.)

Optional parts are enclosed in square brackets:
git-archive:
  [<extra>]
  (Zero or one <extra>.)

git-apply:
  [<patch>...]
  (Any number of <patch>. Note that the dots are inside, not outside
  the brackets.)

Parentheses are used for grouping:
git-bisect:
  [(<rev>|<range>)...]
  (Any number of either <rev> or <range>. Parens are needed to make it
  clear that `...' pertains to both <rev> and <range>.)

git-remote:
  git remote set-head <name> (-a | -d | <branch>)
  (One and only one of `-a', `-d' or `<branch>' _must_ (no square
  brackets) be provided.)

Limited number of occurences is indicated as follows:
git-diff:
  <commit>{0,2}
  (Up to two <commit>s.)
---

[It is conceivable I could submit this as a series of smaller patches,
but the problems this is solving didn't seem diverse enough to me to
warrant that.

As for the "methodology" used -- I grepped for places similar to what I
wanted to fix (cf.
<http://article.gmane.org/gmane.comp.version-control.git/158445>, then I
noticed other related problems and grepped for them etc. All the edits
are manual, though.]

Two questions:

1. Is `[--refs [--unpacked | --all]]' in `git-pack-object' documentation
correct? From my reading of builtin/pack-objects.c, `--unpacked' and
`--all' do the same thing and both imply --refs, so perhaps [--refs |
--unpacked | --all] would make more sense? (I also noticed that the
--reflog option is shown in the usage string but undocumented.)

2. I left in one special case, namely the GIT_* variables in `git(1)'
synopsis section as values for the `--exec-path' and other options.
Further in the text the usual <path> placeholders are used and I believe
those should be used in the synopsis as well, but whoever used the GIT_*
variables obviously did it to point out that they provide an alternative
way to set those options, so I figured I'd leave them in for now and ask
for opinions first.

 Documentation/diff-options.txt       |   14 +++++-----
 Documentation/git-am.txt             |    4 +-
 Documentation/git-apply.txt          |    6 ++--
 Documentation/git-archive.txt        |    4 +-
 Documentation/git-bundle.txt         |    6 ++--
 Documentation/git-checkout-index.txt |    2 +-
 Documentation/git-commit-tree.txt    |    2 +-
 Documentation/git-daemon.txt         |   48 +++++++++++++++++-----------------
 Documentation/git-fast-export.txt    |    2 +-
 Documentation/git-fetch.txt          |    2 +-
 Documentation/git-filter-branch.txt  |    2 +-
 Documentation/git-for-each-ref.txt   |    2 +-
 Documentation/git-index-pack.txt     |    4 +-
 Documentation/git-init.txt           |    2 +-
 Documentation/git-ls-files.txt       |    2 +-
 Documentation/git-ls-tree.txt        |   10 +++---
 Documentation/git-mailsplit.txt      |    2 +-
 Documentation/git-mergetool.txt      |    2 +-
 Documentation/git-pack-objects.txt   |   16 +++++-----
 Documentation/git-relink.txt         |    2 +-
 Documentation/git-remote.txt         |    2 +-
 Documentation/git-repack.txt         |   12 ++++----
 Documentation/git-rev-list.txt       |   18 ++++++------
 Documentation/git-rev-parse.txt      |    2 +-
 Documentation/git-shortlog.txt       |    2 +-
 Documentation/git-show-branch.txt    |    2 +-
 Documentation/git-svn.txt            |    2 +-
 Documentation/git-update-index.txt   |    4 +-
 Documentation/git-web--browse.txt    |   16 +++++-----
 Documentation/git.txt                |    6 ++--
 Documentation/merge-strategies.txt   |    2 +-
 Documentation/pretty-options.txt     |    4 +-
 Documentation/rev-list-options.txt   |   18 ++++++------
 Documentation/user-manual.txt        |    2 +-
 archive.c                            |    4 +-
 builtin/bundle.c                     |    4 +-
 builtin/checkout-index.c             |    2 +-
 builtin/commit-tree.c                |    2 +-
 builtin/fetch.c                      |    2 +-
 builtin/grep.c                       |    2 +-
 builtin/index-pack.c                 |    2 +-
 builtin/ls-files.c                   |    2 +-
 builtin/ls-tree.c                    |    2 +-
 builtin/mailsplit.c                  |    2 +-
 builtin/pack-objects.c               |   10 +++---
 builtin/remote.c                     |    2 +-
 builtin/rev-list.c                   |    8 +++---
 builtin/show-branch.c                |    2 +-
 builtin/update-index.c               |    2 +-
 daemon.c                             |   18 ++++++------
 fast-import.c                        |    2 +-
 git-am.sh                            |    2 +-
 git-relink.perl                      |    2 +-
 git.c                                |    4 +-
 upload-pack.c                        |    2 +-
 55 files changed, 152 insertions(+), 152 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f77a0f8..719f589 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -48,9 +48,9 @@ endif::git-format-patch[]
 --patience::
 	Generate a diff using the "patience diff" algorithm.
 
---stat[=width[,name-width]]::
+--stat[=<width>[,<name-width>]]::
 	Generate a diffstat.  You can override the default
-	output width for 80-column terminal by `--stat=width`.
+	output width for 80-column terminal by `--stat=<width>`.
 	The width of the filename part can be controlled by
 	giving another width to it separated by a comma.
 
@@ -66,14 +66,14 @@ endif::git-format-patch[]
 	number of modified files, as well as number of added and deleted
 	lines.
 
---dirstat[=limit]::
+--dirstat[=<limit>]::
 	Output the distribution of relative amount of changes (number of lines added or
 	removed) for each sub-directory. Directories with changes below
 	a cut-off percent (3% by default) are not shown. The cut-off percent
-	can be set with `--dirstat=limit`. Changes in a child directory is not
+	can be set with `--dirstat=<limit>`. Changes in a child directory are not
 	counted for the parent directory, unless `--cumulative` is used.
 
---dirstat-by-file[=limit]::
+--dirstat-by-file[=<limit>]::
 	Same as `--dirstat`, but counts changed files instead of lines.
 
 --summary::
@@ -248,13 +248,13 @@ endif::git-log[]
 	If `n` is specified, it has the same meaning as for `-M<n>`.
 
 ifndef::git-format-patch[]
---diff-filter=[ACDMRTUXB*]::
+--diff-filter=<spec>::
+	'<spec>' can be any combination of the characters `ACDMRTUXB*`.
 	Select only files that are Added (`A`), Copied (`C`),
 	Deleted (`D`), Modified (`M`), Renamed (`R`), have their
 	type (i.e. regular file, symlink, submodule, ...) changed (`T`),
 	are Unmerged (`U`), are
 	Unknown (`X`), or have had their pairing Broken (`B`).
-	Any combination of the filter characters may be used.
 	When `*` (All-or-none) is added to the combination, all
 	paths are selected if there is any file that matches
 	other criteria in the comparison; if there is no file
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 9e62f87..51297d0 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--reject] [-q | --quiet] [--scissors | --no-scissors]
-	 [<mbox> | <Maildir>...]
+	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort)
 
 DESCRIPTION
@@ -25,7 +25,7 @@ current branch.
 
 OPTIONS
 -------
-<mbox>|<Maildir>...::
+(<mbox>|<Maildir>)...::
 	The list of mailbox files to read patches from. If you do not
 	supply this argument, the command reads from the standard input.
 	If you supply directories, they will be treated as Maildirs.
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 4a74b23..881652f 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -12,10 +12,10 @@ SYNOPSIS
 'git apply' [--stat] [--numstat] [--summary] [--check] [--index]
 	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
-	  [-pNUM] [-CNUM] [--inaccurate-eof] [--recount] [--cached]
+	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
 	  [--ignore-space-change | --ignore-whitespace ]
-	  [--whitespace=<nowarn|warn|fix|error|error-all>]
-	  [--exclude=PATH] [--include=PATH] [--directory=<root>]
+	  [--whitespace=(nowarn|warn|fix|error|error-all)]
+	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
 	  [--verbose] [<patch>...]
 
 DESCRIPTION
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 8d3e666..4163a1b 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
 	      [-o | --output=<file>] [--worktree-attributes]
 	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
-	      [path...]
+	      [<path>...]
 
 DESCRIPTION
 -----------
@@ -73,7 +73,7 @@ OPTIONS
 <tree-ish>::
 	The tree or commit to produce an archive for.
 
-path::
+<path>::
 	Without an optional path parameter, all files and subdirectories
 	of the current working directory are included in the archive.
 	If one or more paths are specified, only these are included.
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 38e59af..6266a3a 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -11,8 +11,8 @@ SYNOPSIS
 [verse]
 'git bundle' create <file> <git-rev-list-args>
 'git bundle' verify <file>
-'git bundle' list-heads <file> [refname...]
-'git bundle' unbundle <file> [refname...]
+'git bundle' list-heads <file> [<refname>...]
+'git bundle' unbundle <file> [<refname>...]
 
 DESCRIPTION
 -----------
@@ -68,7 +68,7 @@ unbundle <file>::
 	packaged.
 
 
-[refname...]::
+[<refname>...]::
 	A list of references used to limit the references reported as
 	available. This is principally of use to 'git fetch', which
 	expects to receive only those references asked for and not
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 62f9ab2..0c0a9c1 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 		   [--stage=<number>|all]
 		   [--temp]
 		   [-z] [--stdin]
-		   [--] [<file>]*
+		   [--] [<file>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 349366e..5dcf427 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -8,7 +8,7 @@ git-commit-tree - Create a new commit object
 
 SYNOPSIS
 --------
-'git commit-tree' <tree> [-p <parent commit>]* < changelog
+'git commit-tree' <tree> [(-p <parent commit>)...] < changelog
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 01c9f8e..2f0ddf6 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -9,15 +9,15 @@ SYNOPSIS
 --------
 [verse]
 'git daemon' [--verbose] [--syslog] [--export-all]
-	     [--timeout=n] [--init-timeout=n] [--max-connections=n]
-	     [--strict-paths] [--base-path=path] [--base-path-relaxed]
-	     [--user-path | --user-path=path]
-	     [--interpolated-path=pathtemplate]
-	     [--reuseaddr] [--detach] [--pid-file=file]
-	     [--enable=service] [--disable=service]
-	     [--allow-override=service] [--forbid-override=service]
-	     [--inetd | [--listen=host_or_ipaddr] [--port=n] [--user=user [--group=group]]
-	     [directory...]
+	     [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]
+	     [--strict-paths] [--base-path=<path>] [--base-path-relaxed]
+	     [--user-path | --user-path=<path>]
+	     [--interpolated-path=<pathtemplate>]
+	     [--reuseaddr] [--detach] [--pid-file=<file>]
+	     [--enable=<service>] [--disable=<service>]
+	     [--allow-override=<service>] [--forbid-override=<service>]
+	     [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>] [--user=<user> [--group=<group>]]
+	     [<directory>...]
 
 DESCRIPTION
 -----------
@@ -48,7 +48,7 @@ OPTIONS
 	'git daemon' will refuse to start when this option is enabled and no
 	whitelist is specified.
 
---base-path=path::
+--base-path=<path>::
 	Remap all the path requests as relative to the given path.
 	This is sort of "GIT root" - if you run 'git daemon' with
 	'--base-path=/srv/git' on example.com, then if you later try to pull
@@ -61,7 +61,7 @@ OPTIONS
 	This is useful for switching to --base-path usage, while still
 	allowing the old paths.
 
---interpolated-path=pathtemplate::
+--interpolated-path=<pathtemplate>::
 	To support virtual hosting, an interpolated path template can be
 	used to dynamically construct alternate paths.  The template
 	supports %H for the target hostname as supplied by the client but
@@ -80,27 +80,27 @@ OPTIONS
 	Have the server run as an inetd service. Implies --syslog.
 	Incompatible with --port, --listen, --user and --group options.
 
---listen=host_or_ipaddr::
+--listen=<host_or_ipaddr>::
 	Listen on a specific IP address or hostname.  IP addresses can
 	be either an IPv4 address or an IPv6 address if supported.  If IPv6
 	is not supported, then --listen=hostname is also not supported and
 	--listen must be given an IPv4 address.
 	Incompatible with '--inetd' option.
 
---port=n::
+--port=<n>::
 	Listen on an alternative port.  Incompatible with '--inetd' option.
 
---init-timeout=n::
+--init-timeout=<n>::
 	Timeout between the moment the connection is established and the
 	client request is received (typically a rather low value, since
 	that should be basically immediate).
 
---timeout=n::
+--timeout=<n>::
 	Timeout for specific client sub-requests. This includes the time
 	it takes for the server to process the sub-request and the time spent
 	waiting for the next client's request.
 
---max-connections=n::
+--max-connections=<n>::
 	Maximum number of concurrent clients, defaults to 32.  Set it to
 	zero for no limit.
 
@@ -109,7 +109,7 @@ OPTIONS
 	--verbose, thus by default only error conditions will be logged.
 
 --user-path::
---user-path=path::
+--user-path=<path>::
 	Allow {tilde}user notation to be used in requests.  When
 	specified with no parameter, requests to
 	git://host/{tilde}alice/foo is taken as a request to access
@@ -129,12 +129,12 @@ OPTIONS
 --detach::
 	Detach from the shell. Implies --syslog.
 
---pid-file=file::
+--pid-file=<file>::
 	Save the process id in 'file'.  Ignored when the daemon
 	is run under `--inetd`.
 
---user=user::
---group=group::
+--user=<user>::
+--group=<group>::
 	Change daemon's uid and gid before entering the service loop.
 	When only `--user` is given without `--group`, the
 	primary group ID for the user is used.  The values of
@@ -145,16 +145,16 @@ Giving these options is an error when used with `--inetd`; use
 the facility of inet daemon to achieve the same before spawning
 'git daemon' if needed.
 
---enable=service::
---disable=service::
+--enable=<service>::
+--disable=<service>::
 	Enable/disable the service site-wide per default.  Note
 	that a service disabled site-wide can still be enabled
 	per repository if it is marked overridable and the
 	repository enables the service with a configuration
 	item.
 
---allow-override=service::
---forbid-override=service::
+--allow-override=<service>::
+--forbid-override=<service>::
 	Allow/forbid overriding the site-wide default with per
 	repository configuration.  By default, all the services
 	are overridable.
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index fcad113..e05b686 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -96,7 +96,7 @@ marks the same across runs.
 	in the commit (as opposed to just listing the files which are
 	different from the commit's first parent).
 
-[git-rev-list-args...]::
+[<git-rev-list-args>...]::
        A list of arguments, acceptable to 'git rev-parse' and
        'git rev-list', that specifies the specific objects and references
        to export.  For example, `master{tilde}10..master` causes the
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 400fe7f..d159e88 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 
 'git fetch' [<options>] <group>
 
-'git fetch' --multiple [<options>] [<repository> | <group>]...
+'git fetch' --multiple [<options>] [(<repository> | <group>)...]
 
 'git fetch' --all [<options>]
 
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index f51860d..796e748 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -117,7 +117,7 @@ OPTIONS
 	This is the filter for performing the commit.
 	If this filter is specified, it will be called instead of the
 	'git commit-tree' command, with arguments of the form
-	"<TREE_ID> [-p <PARENT_COMMIT_ID>]..." and the log message on
+	"<TREE_ID> [(-p <PARENT_COMMIT_ID>)...]" and the log message on
 	stdin.  The commit id is expected on stdout.
 +
 As a special extension, the commit filter may emit multiple
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index d66fd9d..fac1cf5 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
-		   [--sort=<key>]* [--format=<format>] [<pattern>...]
+		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index f3ccc72..c2bb810 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -59,10 +59,10 @@ OPTIONS
 	the newly constructed pack and index before refs can be
 	updated to use objects contained in the pack.
 
---keep='why'::
+--keep=<msg>::
 	Like --keep create a .keep file before moving the index into
 	its final destination, but rather than creating an empty file
-	place 'why' followed by an LF into the .keep file.  The 'why'
+	place '<msg>' followed by an LF into the .keep file.  The '<msg>'
 	message can later be searched for within all .keep files to
 	locate any which have outlived their usefulness.
 
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 246b07e..00d4a12 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -31,7 +31,7 @@ current working directory.
 Specify the directory from which templates will be used.  (See the "TEMPLATE
 DIRECTORY" section below.)
 
---shared[={false|true|umask|group|all|world|everybody|0xxx}]::
+--shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
 
 Specify that the git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 347f447..86abd13 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 		[--exclude-per-directory=<file>]
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree-ish>]
-		[--full-name] [--abbrev] [--] [<file>]*
+		[--full-name] [--abbrev] [--] [<file>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 1f89d36..76ed625 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
-	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev=[<n>]]
-	    <tree-ish> [paths...]
+	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
+	    <tree-ish> [<path>...]
 
 DESCRIPTION
 -----------
@@ -19,11 +19,11 @@ Lists the contents of a given tree object, like what "/bin/ls -a" does
 in the current working directory.  Note that:
 
  - the behaviour is slightly different from that of "/bin/ls" in that the
-   'paths' denote just a list of patterns to match, e.g. so specifying
+   '<path>' denotes just a list of patterns to match, e.g. so specifying
    directory name (without '-r') will behave differently, and order of the
    arguments does not matter.
 
- - the behaviour is similar to that of "/bin/ls" in that the 'paths' is
+ - the behaviour is similar to that of "/bin/ls" in that the '<path>' is
    taken as relative to the current working directory.  E.g. when you are
    in a directory 'sub' that has a directory 'dir', you can run 'git
    ls-tree -r HEAD dir' to list the contents of the tree (that is
@@ -72,7 +72,7 @@ OPTIONS
 	Do not limit the listing to the current working directory.
 	Implies --full-name.
 
-paths::
+[<path>...]::
 	When paths are given, show them (note that this isn't really raw
 	pathnames, but rather a list of patterns to match).  Otherwise
 	implicitly uses the root level of the tree as the sole path argument.
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index a634485..71912a1 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -7,7 +7,7 @@ git-mailsplit - Simple UNIX mbox splitter program
 
 SYNOPSIS
 --------
-'git mailsplit' [-b] [-f<nn>] [-d<prec>] [--keep-cr] -o<directory> [--] [<mbox>|<Maildir>...]
+'git mailsplit' [-b] [-f<nn>] [-d<prec>] [--keep-cr] -o<directory> [--] [(<mbox>|<Maildir>)...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index e4ed016..1f75a84 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -7,7 +7,7 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
 
 SYNOPSIS
 --------
-'git mergetool' [--tool=<tool>] [-y|--no-prompt|--prompt] [<file>]...
+'git mergetool' [--tool=<tool>] [-y|--no-prompt|--prompt] [<file>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 8ed09c0..65eff66 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -11,8 +11,8 @@ SYNOPSIS
 [verse]
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
-	[--local] [--incremental] [--window=N] [--depth=N]
-	[--revs [--unpacked | --all]*] [--stdout | base-name]
+	[--local] [--incremental] [--window=<n>] [--depth=<n>]
+	[--revs [--unpacked | --all]] [--stdout | base-name]
 	[--keep-true-parents] < object-list
 
 
@@ -82,8 +82,8 @@ base-name::
 	reference was included in the resulting packfile.  This
 	can be useful to send new tags to native git clients.
 
---window=[N]::
---depth=[N]::
+--window=<n>::
+--depth=<n>::
 	These two options affect how the objects contained in
 	the pack are stored using delta compression.  The
 	objects are first internally sorted by type, size and
@@ -95,10 +95,10 @@ base-name::
 	times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
 
---window-memory=[N]::
+--window-memory=<n>::
 	This option provides an additional limit on top of `--window`;
 	the window size will dynamically scale down so as to not take
-	up more than N bytes in memory.  This is useful in
+	up more than '<n>' bytes in memory.  This is useful in
 	repositories with a mix of large and small objects to not run
 	out of memory with a large window, but still be able to take
 	advantage of the large window for the smaller objects.  The
@@ -106,7 +106,7 @@ base-name::
 	`--window-memory=0` makes memory usage unlimited, which is the
 	default.
 
---max-pack-size=[N]::
+--max-pack-size=<n>::
 	Maximum size of each output pack file. The size can be suffixed with
 	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
 	If specified,  multiple packfiles may be created.
@@ -171,7 +171,7 @@ base-name::
 	wholesale enforcement of a different compression level on the
 	packed data is desired.
 
---compression=[N]::
+--compression=<n>::
 	Specifies compression level for newly-compressed data in the
 	generated pack.  If not specified,  pack compression level is
 	determined first by pack.compression,  then by core.compression,
diff --git a/Documentation/git-relink.txt b/Documentation/git-relink.txt
index 8a5842b..8fc809f 100644
--- a/Documentation/git-relink.txt
+++ b/Documentation/git-relink.txt
@@ -7,7 +7,7 @@ git-relink - Hardlink common objects in local repositories
 
 SYNOPSIS
 --------
-'git relink' [--safe] <dir> [<dir>]* <master_dir>
+'git relink' [--safe] <dir>... <master_dir>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index aa021b0..0d28feb 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 'git remote set-url --delete' [--push] <name> <url>
 'git remote' [-v | --verbose] 'show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
-'git remote' [-v | --verbose] 'update' [-p | --prune] [group | remote]...
+'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 9566727..27f7865 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -8,7 +8,7 @@ git-repack - Pack unpacked objects in a repository
 
 SYNOPSIS
 --------
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [--window=N] [--depth=N]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [--window=<n>] [--depth=<n>]
 
 DESCRIPTION
 -----------
@@ -80,8 +80,8 @@ other objects in that pack they already have locally.
 	this repository (or a direct copy of it)
 	over HTTP or FTP.  See linkgit:git-update-server-info[1].
 
---window=[N]::
---depth=[N]::
+--window=<n>::
+--depth=<n>::
 	These two options affect how the objects contained in the pack are
 	stored using delta compression. The objects are first internally
 	sorted by type, size and optionally names and compared against the
@@ -91,10 +91,10 @@ other objects in that pack they already have locally.
 	to be applied that many times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
 
---window-memory=[N]::
+--window-memory=<n>::
 	This option provides an additional limit on top of `--window`;
 	the window size will dynamically scale down so as to not take
-	up more than N bytes in memory.  This is useful in
+	up more than '<n>' bytes in memory.  This is useful in
 	repositories with a mix of large and small objects to not run
 	out of memory with a large window, but still be able to take
 	advantage of the large window for the smaller objects.  The
@@ -102,7 +102,7 @@ other objects in that pack they already have locally.
 	`--window-memory=0` makes memory usage unlimited, which is the
 	default.
 
---max-pack-size=[N]::
+--max-pack-size=<n>::
 	Maximum size of each output pack file. The size can be suffixed with
 	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
 	If specified,  multiple packfiles may be created.
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 173f3fc..8e1e329 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,10 +9,10 @@ git-rev-list - Lists commit objects in reverse chronological order
 SYNOPSIS
 --------
 [verse]
-'git rev-list' [ \--max-count=number ]
-	     [ \--skip=number ]
-	     [ \--max-age=timestamp ]
-	     [ \--min-age=timestamp ]
+'git rev-list' [ \--max-count=<number> ]
+	     [ \--skip=<number> ]
+	     [ \--max-age=<timestamp> ]
+	     [ \--min-age=<timestamp> ]
 	     [ \--sparse ]
 	     [ \--merges ]
 	     [ \--no-merges ]
@@ -21,10 +21,10 @@ SYNOPSIS
 	     [ \--full-history ]
 	     [ \--not ]
 	     [ \--all ]
-	     [ \--branches[=pattern] ]
-	     [ \--tags[=pattern] ]
-	     [ \--remotes[=pattern] ]
-	     [ \--glob=glob-pattern ]
+	     [ \--branches[=<pattern>] ]
+	     [ \--tags[=<pattern>] ]
+	     [ \--remotes[=<pattern>] ]
+	     [ \--glob=<glob-pattern> ]
 	     [ \--stdin ]
 	     [ \--quiet ]
 	     [ \--topo-order ]
@@ -37,7 +37,7 @@ SYNOPSIS
 	     [ \--regexp-ignore-case | -i ]
 	     [ \--extended-regexp | -E ]
 	     [ \--fixed-strings | -F ]
-	     [ \--date={local|relative|default|iso|rfc|short} ]
+	     [ \--date=(local|relative|default|iso|rfc|short) ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 341ca90..4a27643 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -95,7 +95,7 @@ OPTIONS
 	unfortunately named tag "master"), and show them as full
 	refnames (e.g. "refs/heads/master").
 
---abbrev-ref[={strict|loose}]::
+--abbrev-ref[=(strict|loose)]::
 	A non-ambiguous short name of the objects name.
 	The option core.warnAmbiguousRefs is used to select the strict
 	abbreviation mode.
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index bc1ac77..5cc3baf 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -44,7 +44,7 @@ OPTIONS
 --email::
 	Show the email address of each author.
 
---format[='<format>']::
+--format[=<format>]::
 	Instead of the commit subject, use some other information to
 	describe each commit.  '<format>' can be any string accepted
 	by the `--format` option of 'git log', such as '{asterisk} [%h] %s'.
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 6453263..bd9f886 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 		[--current] [--color[=<when>] | --no-color] [--sparse]
 		[--more=<n> | --list | --independent | --merge-base]
 		[--no-name | --sha1-name] [--topics]
-		[<rev> | <glob>]...
+		[(<rev> | <glob>)...]
 
 'git show-branch' (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]
 
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index be8a51f..139d314 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -438,7 +438,7 @@ git rebase --onto remotes/git-svn A^ master
 OPTIONS
 -------
 
---shared[={false|true|umask|group|all|world|everybody}]::
+--shared[=(false|true|umask|group|all|world|everybody)]::
 --template=<template_directory>::
 	Only used with the 'init' command.
 	These are passed directly to 'git init'.
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 74d1d49..a5782a6 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git update-index'
 	     [--add] [--remove | --force-remove] [--replace]
 	     [--refresh] [-q] [--unmerged] [--ignore-missing]
-	     [--cacheinfo <mode> <object> <file>]*
+	     [(--cacheinfo <mode> <object> <file>)...]
 	     [--chmod=(+|-)x]
 	     [--assume-unchanged | --no-assume-unchanged]
 	     [--skip-worktree | --no-skip-worktree]
@@ -21,7 +21,7 @@ SYNOPSIS
 	     [--info-only] [--index-info]
 	     [-z] [--stdin]
 	     [--verbose]
-	     [--] [<file>]*
+	     [--] [<file>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index e1586c7..51e8e0a 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -32,19 +32,19 @@ Custom commands may also be specified.
 
 OPTIONS
 -------
--b BROWSER::
---browser=BROWSER::
-	Use the specified BROWSER. It must be in the list of supported
+-b <browser>::
+--browser=<browser>::
+	Use the specified browser. It must be in the list of supported
 	browsers.
 
--t BROWSER::
---tool=BROWSER::
+-t <browser>::
+--tool=<browser>::
 	Same as above.
 
--c CONF.VAR::
---config=CONF.VAR::
+-c <conf.var>::
+--config=<conf.var>::
 	CONF.VAR is looked up in the git config files. If it's set,
-	then its value specify the browser that should be used.
+	then its value specifies the browser that should be used.
 
 CONFIGURATION VARIABLES
 -----------------------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index dd57bdc..2e1b2c0 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -12,8 +12,8 @@ SYNOPSIS
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]
     [-p|--paginate|--no-pager] [--no-replace-objects]
     [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
-    [-c name=value]
-    [--help] COMMAND [ARGS]
+    [-c <name>=<value>]
+    [--help] <command> [<args>]
 
 DESCRIPTION
 -----------
@@ -28,7 +28,7 @@ also want to read linkgit:gitcvs-migration[7].  See
 the link:user-manual.html[Git User's Manual] for a more in-depth
 introduction.
 
-The COMMAND is either a name of a Git command (see below) or an alias
+The '<command>' is either a name of a Git command (see below) or an alias
 as defined in the configuration file (see linkgit:git-config[1]).
 
 Formatted and hyperlinked version of the latest git
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 049313d..8676e26 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -52,7 +52,7 @@ no-renormalize;;
 	Disables the `renormalize` option.  This overrides the
 	`merge.renormalize` configuration variable.
 
-subtree[=path];;
+subtree[=<path>];;
 	This option is a more advanced form of 'subtree' strategy, where
 	the strategy makes a guess on how two trees must be shifted to
 	match with each other when merging.  Instead, the specified path
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 9b6f389..50923e2 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -1,5 +1,5 @@
---pretty[='<format>']::
---format='<format>'::
+--pretty[=<format>]::
+--format=<format>::
 
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ebc0108..7a42567 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -13,7 +13,7 @@ include::pretty-options.txt[]
 
 	Synonym for `--date=relative`.
 
---date={relative,local,default,iso,rfc,short,raw}::
+--date=(relative|local|default|iso|rfc|short|raw)::
 
 	Only takes effect for dates shown in human-readable format, such
 	as when using "--pretty". `log.date` config variable sets a default
@@ -246,29 +246,29 @@ endif::git-rev-list[]
 	Pretend as if all the refs in `refs/` are listed on the
 	command line as '<commit>'.
 
---branches[=pattern]::
+--branches[=<pattern>]::
 
 	Pretend as if all the refs in `refs/heads` are listed
-	on the command line as '<commit>'. If `pattern` is given, limit
+	on the command line as '<commit>'. If '<pattern>' is given, limit
 	branches to ones matching given shell glob. If pattern lacks '?',
 	'*', or '[', '/*' at the end is implied.
 
---tags[=pattern]::
+--tags[=<pattern>]::
 
 	Pretend as if all the refs in `refs/tags` are listed
-	on the command line as '<commit>'. If `pattern` is given, limit
+	on the command line as '<commit>'. If '<pattern>' is given, limit
 	tags to ones matching given shell glob. If pattern lacks '?', '*',
 	or '[', '/*' at the end is implied.
 
---remotes[=pattern]::
+--remotes[=<pattern>]::
 
 	Pretend as if all the refs in `refs/remotes` are listed
-	on the command line as '<commit>'. If `pattern`is given, limit
+	on the command line as '<commit>'. If '<pattern>' is given, limit
 	remote tracking branches to ones matching given shell glob.
 	If pattern lacks '?', '*', or '[', '/*' at the end is implied.
 
---glob=glob-pattern::
-	Pretend as if all the refs matching shell glob `glob-pattern`
+--glob=<glob-pattern>::
+	Pretend as if all the refs matching shell glob '<glob-pattern>'
 	are listed on the command line as '<commit>'. Leading 'refs/',
 	is automatically prepended if missing. If pattern lacks '?', '*',
 	or '[', '/*' at the end is implied.
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index ce45bfc..cb3b98a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3850,7 +3850,7 @@ You create a commit object by giving it the tree that describes the
 state at the time of the commit, and a list of parents:
 
 -------------------------------------------------
-$ git commit-tree <tree> -p <parent> [-p <parent2> ..]
+$ git commit-tree <tree> -p <parent> [(-p <parent2>)...]
 -------------------------------------------------
 
 and then giving the reason for the commit on stdin (either through
diff --git a/archive.c b/archive.c
index edd6853..f59afda 100644
--- a/archive.c
+++ b/archive.c
@@ -7,9 +7,9 @@
 #include "unpack-trees.h"
 
 static char const * const archive_usage[] = {
-	"git archive [options] <tree-ish> [path...]",
+	"git archive [options] <tree-ish> [<path>...]",
 	"git archive --list",
-	"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [path...]",
+	"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<path>...]",
 	"git archive --remote <repo> [--exec <cmd>] --list",
 	NULL
 };
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 80649ba..9b87fb9 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -12,8 +12,8 @@
 static const char builtin_bundle_usage[] =
   "git bundle create <file> <git-rev-list args>\n"
   "   or: git bundle verify <file>\n"
-  "   or: git bundle list-heads <file> [refname...]\n"
-  "   or: git bundle unbundle <file> [refname...]";
+  "   or: git bundle list-heads <file> [<refname>...]\n"
+  "   or: git bundle unbundle <file> [<refname>...]";
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index a7a5ee1..65cbee0 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -155,7 +155,7 @@ static void checkout_all(const char *prefix, int prefix_length)
 }
 
 static const char * const builtin_checkout_index_usage[] = {
-	"git checkout-index [options] [--] <file>...",
+	"git checkout-index [options] [--] [<file>...]",
 	NULL
 };
 
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 87f0591..e065739 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -9,7 +9,7 @@
 #include "builtin.h"
 #include "utf8.h"
 
-static const char commit_tree_usage[] = "git commit-tree <sha1> [-p <sha1>]* < changelog";
+static const char commit_tree_usage[] = "git commit-tree <sha1> [(-p <sha1>)...] < changelog";
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6fc5047..d35f000 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -16,7 +16,7 @@
 static const char * const builtin_fetch_usage[] = {
 	"git fetch [<options>] [<repository> [<refspec>...]]",
 	"git fetch [<options>] <group>",
-	"git fetch --multiple [<options>] [<repository> | <group>]...",
+	"git fetch --multiple [<options>] [(<repository> | <group>)...]",
 	"git fetch --all [<options>]",
 	NULL
 };
diff --git a/builtin/grep.c b/builtin/grep.c
index da32f3d..3d5f6ac 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -24,7 +24,7 @@
 #endif
 
 static char const * const grep_usage[] = {
-	"git grep [options] [-e] <pattern> [<rev>...] [[--] path...]",
+	"git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]",
 	NULL
 };
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e243d9d..8dc5c0b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -11,7 +11,7 @@
 #include "exec_cmd.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [{ --keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
+"git index-pack [-v] [-o <index-file>] [ --keep | --keep=<msg> ] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
 struct object_entry
 {
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index bb4f612..6a307ab 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -424,7 +424,7 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
 }
 
 static const char * const ls_files_usage[] = {
-	"git ls-files [options] [<file>]*",
+	"git ls-files [options] [<file>...]",
 	NULL
 };
 
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index a818756..f73e6bd 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -24,7 +24,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
 
 static const  char * const ls_tree_usage[] = {
-	"git ls-tree [<options>] <tree-ish> [path...]",
+	"git ls-tree [<options>] <tree-ish> [<path>...]",
 	NULL
 };
 
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 99654d0..2d43278 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -10,7 +10,7 @@
 #include "strbuf.h"
 
 static const char git_mailsplit_usage[] =
-"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [<mbox>|<Maildir>...]";
+"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [(<mbox>|<Maildir>)...]";
 
 static int is_from_line(const char *line, int len)
 {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d5a8db1..f8eba53 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -23,15 +23,15 @@
 #endif
 
 static const char pack_usage[] =
-  "git pack-objects [{ -q | --progress | --all-progress }]\n"
+  "git pack-objects [ -q | --progress | --all-progress ]\n"
   "        [--all-progress-implied]\n"
-  "        [--max-pack-size=N] [--local] [--incremental]\n"
-  "        [--window=N] [--window-memory=N] [--depth=N]\n"
+  "        [--max-pack-size=<n>] [--local] [--incremental]\n"
+  "        [--window=<n>] [--window-memory=<n>] [--depth=<n>]\n"
   "        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset]\n"
-  "        [--threads=N] [--non-empty] [--revs [--unpacked | --all]*]\n"
+  "        [--threads=<n>] [--non-empty] [--revs [--unpacked | --all]]\n"
   "        [--reflog] [--stdout | base-name] [--include-tag]\n"
   "        [--keep-unreachable | --unpack-unreachable]\n"
-  "        [<ref-list | <object-list]";
+  "        [< ref-list | < object-list]";
 
 struct object_entry {
 	struct pack_idx_entry idx;
diff --git a/builtin/remote.c b/builtin/remote.c
index 48e0a6b..e9a6e09 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -15,7 +15,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote set-head <name> (-a | -d | <branch>)",
 	"git remote [-v | --verbose] show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
-	"git remote [-v | --verbose] update [-p | --prune] [group | remote]",
+	"git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]",
 	"git remote set-branches <name> [--add] <branch>...",
 	"git remote set-url <name> <newurl> [<oldurl>]",
 	"git remote set-url --add <name> <newurl>",
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index efe9360..158ce11 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -11,9 +11,9 @@
 static const char rev_list_usage[] =
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
 "  limiting output:\n"
-"    --max-count=nr\n"
-"    --max-age=epoch\n"
-"    --min-age=epoch\n"
+"    --max-count=<n>\n"
+"    --max-age=<epoch>\n"
+"    --min-age=<epoch>\n"
 "    --sparse\n"
 "    --no-merges\n"
 "    --remove-empty\n"
@@ -33,7 +33,7 @@ static const char rev_list_usage[] =
 "    --objects | --objects-edge\n"
 "    --unpacked\n"
 "    --header | --pretty\n"
-"    --abbrev=nr | --no-abbrev\n"
+"    --abbrev=<n> | --no-abbrev\n"
 "    --abbrev-commit\n"
 "    --left-right\n"
 "  special purpose:\n"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e8719aa..8663cca 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -6,7 +6,7 @@
 #include "parse-options.h"
 
 static const char* show_branch_usage[] = {
-    "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order] [--current] [--color[=<when>] | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [<rev> | <glob>]...",
+    "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order] [--current] [--color[=<when>] | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]",
     "git show-branch (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]",
     NULL
 };
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3ab214d..62d9f3f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -398,7 +398,7 @@ static void read_index_info(int line_termination)
 }
 
 static const char update_index_usage[] =
-"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--skip-worktree|--no-skip-worktree] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] <file>...";
+"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--skip-worktree|--no-skip-worktree] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] [<file>...]";
 
 static unsigned char head_sha1[20];
 static unsigned char merge_head_sha1[20];
diff --git a/daemon.c b/daemon.c
index e22a2b7..9326d3a 100644
--- a/daemon.c
+++ b/daemon.c
@@ -20,15 +20,15 @@ static int reuseaddr;
 
 static const char daemon_usage[] =
 "git daemon [--verbose] [--syslog] [--export-all]\n"
-"           [--timeout=n] [--init-timeout=n] [--max-connections=n]\n"
-"           [--strict-paths] [--base-path=path] [--base-path-relaxed]\n"
-"           [--user-path | --user-path=path]\n"
-"           [--interpolated-path=path]\n"
-"           [--reuseaddr] [--detach] [--pid-file=file]\n"
-"           [--[enable|disable|allow-override|forbid-override]=service]\n"
-"           [--inetd | [--listen=host_or_ipaddr] [--port=n]\n"
-"                      [--user=user [--group=group]]\n"
-"           [directory...]";
+"           [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]\n"
+"           [--strict-paths] [--base-path=<path>] [--base-path-relaxed]\n"
+"           [--user-path | --user-path=<path>]\n"
+"           [--interpolated-path=<path>]\n"
+"           [--reuseaddr] [--detach] [--pid-file=<file>]\n"
+"           [--(enable|disable|allow-override|forbid-override)=<service>]\n"
+"           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
+"                      [--user=<user> [--group=<group>]]\n"
+"           [<directory>...]";
 
 /* List of acceptable pathname prefixes */
 static char **ok_paths;
diff --git a/fast-import.c b/fast-import.c
index 2317b0f..eab68d5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2884,7 +2884,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 }
 
 static const char fast_import_usage[] =
-"git fast-import [--date-format=f] [--max-pack-size=n] [--big-file-threshold=n] [--depth=n] [--active-branches=n] [--export-marks=marks.file]";
+"git fast-import [--date-format=<f>] [--max-pack-size=<n>] [--big-file-threshold=<n>] [--depth=<n>] [--active-branches=<n>] [--export-marks=<marks.file>]";
 
 static void parse_argv(void)
 {
diff --git a/git-am.sh b/git-am.sh
index 9317b38..763fd20 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -5,7 +5,7 @@
 SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
-git am [options] [<mbox>|<Maildir>...]
+git am [options] [(<mbox>|<Maildir>)...]
 git am [options] (--resolved | --skip | --abort)
 --
 i,interactive   run interactively
diff --git a/git-relink.perl b/git-relink.perl
index 937c69a..c2a0ef8 100755
--- a/git-relink.perl
+++ b/git-relink.perl
@@ -163,7 +163,7 @@ sub link_two_files($$) {
 
 
 sub usage() {
-	print("Usage: git relink [--safe] <dir> [<dir> ...] <master_dir> \n");
+	print("Usage: git relink [--safe] <dir>... <master_dir> \n");
 	print("All directories should contain a .git/objects/ subdirectory.\n");
 	print("Options\n");
 	print("\t--safe\t" .
diff --git a/git.c b/git.c
index 50a1401..09855d5 100644
--- a/git.c
+++ b/git.c
@@ -10,10 +10,10 @@ const char git_usage_string[] =
 	"           [-p|--paginate|--no-pager] [--no-replace-objects]\n"
 	"           [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]\n"
 	"           [-c name=value] [--help]\n"
-	"           COMMAND [ARGS]";
+	"           <command> [<args>]";
 
 const char git_more_info_string[] =
-	"See 'git help COMMAND' for more information on a specific command.";
+	"See 'git help <command>' for more information on a specific command.";
 
 static struct startup_info git_startup_info;
 static int use_pager = -1;
diff --git a/upload-pack.c b/upload-pack.c
index 92f9530..f05e422 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -11,7 +11,7 @@
 #include "list-objects.h"
 #include "run-command.h"
 
-static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=nn] <dir>";
+static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<n>] <dir>";
 
 /* bits #0..7 in revision.h, #8..10 in commit.c */
 #define THEY_HAVE	(1u << 11)
-- 
1.7.3.rc2.221.gbf93f.dirty
