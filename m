From: Paul Mackerras <paulus@samba.org>
Subject: Quick command reference
Date: Sun, 1 May 2005 22:58:14 +1000
Message-ID: <17012.53862.704670.858276@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun May 01 14:54:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSDxC-0007lH-Ji
	for gcvg-git@gmane.org; Sun, 01 May 2005 14:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVEAM7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 08:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVEAM7k
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 08:59:40 -0400
Received: from ozlabs.org ([203.10.76.45]:23464 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261606AbVEAM6U (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 08:58:20 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 5E71E67A6F; Sun,  1 May 2005 22:58:15 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As an aid to my understanding of the core git commands, I created this
summary of the commands and their options and parameters.  I hope it
will be useful to others.  Corrections welcome of course.

Paul.
---

git-cat-file -t sha1-id
	Prints type of object with given sha1-id to stdout.

git-cat-file type sha1-id
	Copies contents of object with given sha1-id to stdout.
	Complains if type of sha1-id isn't of the type specified.

git-check-files pathname...
	Checks that each pathname given is up-to-date in the w.d.
	(i.e. matches the dircache) or is not present.

git-checkout-cache [-a] [-f] [-q] [-n] [--prefix=path] [--] [files...]
	Copies files from the git object repository to the
	working directory or another directory.  Does not rewrite
	files that already exist and match the dircache.
	-a: check out all files listed in dircache.
	-f: overwrite existing files; without this, checkout-cache
		will not overwrite an existing file even if it
		differs from what is in the dircache.
	-q: quiet; don't print an error message when a file is
		unmerged or not in the dircache, or when a file exists
		but differs from the dircache and -f was not given.
	-n: not new files; don't checkout any file that doesn't
		already exist in the dircache.
	--prefix=path: prepend path to the pathname of each file
		being checked out.  If you want to use this to
		check out files with their normal names but in
		another directory, make sure the path ends in /.
	The order of the flags matters; checkout-cache -a -f
	is different from checkout-cache -f -a.  Flags may be
	interspersed between file names.

git-commit-tree tree-id [-p parent-commit-id]* < changelog
	Generates a commit object referring to the given tree with
	the parent commit-ids given.  (If no parents are given, this
	is an initial commit.)  Prints the sha1 id of the generated
	commit to stdout.

git-diff-cache [-r] [-p] [-z] [--cached] tree-id
	Show differences between the tree identified by tree-id
	and the dircache and/or the working directory.
	-r: ignored (old recursive flag)
	-p: generate patches (full diff listings)
	-z: terminate lines with \0 instead of \n
	--cached: diff against last cached state rather than
	    file in w.d. for new or changed files.  New and changed
	    files are always identified by comparing dircache and
	    tree entries, but without this flag, the files that are
	    identified as new or changed are compared against the
	    working directory rather than the cached version.
	Unmerged (non-stage 0) entries in dircache are shown as:
		U <pathname>
	or if -p is given, as
		* Unmerged path pathname
	Files in tree but not in dircache (or w.d., without --cached):
		-mode<tab>blob<tab>sha1<tab>pathname
	or with -p, as a patch deleting the file.
	Files in dircache but not in tree are shown as:
		+mode<tab>blob<tab>sha1<tab>pathname
	or with -p, as a patch adding the file.
	Files that differ are shown as:
		*mode->mode<tab>blob<tab>sha1->sha1<tab>pathname
	or with -p, as a patch showing the differences

git-diff-files
	Compares working-directory with dircache and prints a listing
	of changed files.
	-p: generate patches (full diff listings)
	-q: Silent; don't show files missing from w.d.
	-r: ignored (old recursive flag)
	-s: ignored (old silent flag)
	-z: terminate lines with \0 instead of \n
	If no pathnames given, compare all files in dircache.
	Checks mode, uid, gid, size, mtime, ctime, dev/ino, size.
	Output is as for git-diff-cache ("-" indicates file in
	dircache but not in w.d.).

git-diff-tree [-p] [-r] [-z] tree1-id tree2-id
	Compares two trees identified by their ids.
	-p: generate patches (implies -r)
	-r: recursive
	-z: terminate lines with \0 instead of \n
	Output is as for git-diff-cache (except there are no unmerged
	entries, since they can only exist in the dircache).

git-diff-tree-helper [-R] [-z] pathname...
	Reads the output of git-diff-tree and generates diffs (patches)
	for the files listed on the command line.
	-R: generate reverse diff
	-z: expect input lines to be terminated with \0

git-export top-sha1 [base-sha1]
	top-sha1 and base-sha1 are commit-ids
	Outputs all the changesets to get to top-sha1, with patches.
	If base-sha1 is given, only outputs changesets from base-sha1
	to top-sha1.

git-fsck-cache [--tags] [--root] [--unreachable] head-sha1...
	Checks the consistency of the object repository.
	If given, the head-sha1 parameter(s) is/are the ids of
	one or more heads of the commit graph.

git-http-pull [-c] [-t] [-a] commit-id url
	-t: tree
	-c: commits
	-a: all
	Fetches the commit object with id commit-id.
	With -t or -a, fetches the tree and blobs for that commit-id.
	With -c or -a, fetches the parents, and recursively fetches
	each of their parents, etc.; with -a, fetches the tree and
	blobs for each of the ancestors as well.

git-init-db
	makes .git directory
	if SHA1_FILE_DIRECTORY not set, makes .git/objects/xx dirs

git-ls-files [-c|--cached] [-d|--deleted] [-o|--others] [-i|--ignored]
	[-s|--stage] [-u|--unmerged] [-x pattern|--exclude=pattern]
	[-X excl-file|--exclude-from=excl-file] [-z]
	Lists filenames from dircache.
	-c|--cached: list files in dircache (default)
	-d|--deleted: list files in dircache but not in w.d.
	-o|--others: list files in w.d. but not in dircache
	-i|--ignored: show files that would be excluded;
		requires at least one -x|-X|--exclude|--exclude-from
	-s|--stage: show full information including merge stage
		for each file
	-u|--unmerged: only show files with merge stage > 0 in dircache
	-x pattern|--exclude=pattern: exclude files matching pattern
	-X file|--exclude-from=file: read exclude patterns from
		file, one per line
	-z: terminate lines with \0 instead of \n
	Without -s, just prints pathnames, one per line.
	With -s, prints:
		mode sha1 stage pathname

git-ls-tree [-z] [-r] sha1
	prints contents of tree object in readable form
	4 columns: mode type sha1 name
	-z: terminate lines with \0 instead of \n
	-r: show subdirectories recursively

git-merge-base commit1-id commit2-id
	Finds the nearest common ancestor of commit1 and commit2,
	and prints its sha1 id

git-merge-cache <merge-program> [-a] [--] <filename>*
	-a: merge all files listed in dircache
	For each file to be merged, do nothing if it is at stage
	0 in the dircache.  Otherwise run:
		merge-program stage1-id stage2-id stage3-id \
		    pathname stage1-mode stage2-mode stage3-mode
	The stageX-id and stageX-mode are "" if that stage isn't
	present in the dircache for that file.

git-mktag < signature-file
	Verifies the input is a syntactically valid tag,
	creates an object containing the input, and prints
	its sha1 id.

git-read-tree (-m | stage0-sha1) [stage1-sha1] [stage2-sha1] [stage3-sha1]
	tree-object(s) -> dircache (uids, gids, inos, times, sizes == 0)
	-m: merge, i.e. start in stage 1; requires all objects in
	    dircache to be stage 0 initially; requires 1 or 3 trees.
	    With 1 tree, merges stat info from existing dircache
	    for unchanged files (same name and sha1 as tree).
	    With 3 trees, does a trivial 3-way merge.  Files merged
	    are made stage 0 and old stat info is used if possible.
	    Anything non-trivial is left as stage 1,2,3 entries.
	    Result goes into new index file.
	Without -m, existing dircache contents are discarded.
	Normally only one sha1 id would be given; more than one can be
	given but no merging is done.

git-rev-list commit-id
	prints the commit-ids of the ancestors of commit-id,
	ordered by date.

git-rev-tree [--edges] [^]commit-id [[^]commit-id]*
	--edges: show commits whose reachability differs from one or
	  more of its parents (reachability == which subset of the
	  commit-ids given on the command line it's reachable from).
	^ means don't show commits reachable from this commit-id
	  (ignored with --edges)
	each line of output is formatted as:
	  decimal-date commit-id:flags [parent-commit-id:flags]*
	flags is in decimal and is a reachability bitmap, i.e.
	0x1 is set if reachable from the first commit-id given,
	0x2 if reachable from the second, etc.

git-rpull [-t] [-c] [-a] commit-id url
	Flags are like http-pull.
	Pulls commits, trees and blobs from another machine over
	ssh; execs ssh to run rpush on the remote machine.
	url can be "-" meaning just talk over stdin/stdout
	instead of running ssh.

git-rpush [-t] [-c] [-a] commit-id url
	Flags are like http-pull.
	Pushes commits, tree and blobs from this machine to another
	machine over ssh; execs ssh to run rpull on the remote machine.
	url can be "-" meaning just talk over stdin/stdout
	instead of running ssh.

git-tar-tree sha1-id [basedir]
	Generates a tar-file on stdout for the tree identified by
	sha1-id, which can be a commit id or a tree id.
	If basedir is given, basedir/ is prepended to all pathnames.

git-unpack-file sha1-id
	Generates a temporary file name of the form .merge_file_XXXXXX
	and writes the contents of the blob object identified by sha1-id
	to it; outputs the generated name to stdout.

git-update-cache [--add] [--remove] [--] pathname...
	Update dircache entry for filename(s) from w.d.
	--add: add pathnames that are in w.d. but not dircache to
	    the dircache (without --add, print a message)
	--remove: remove pathnames which are in dircache but not
	    w.d. from the dircache (without --remove, print a message)

git-update-cache --refresh [--ignore-missing]
	Sets uid, gid, times, size on each entry in dircache from w.d.
	Complains if mode or data differs (assumes data matches
	if size and date match).
	Complains if any file not in w.d. unless --ignore-missing is given.

git-update-cache --cacheinfo mode sha1 path
	Adds an entry to the dircache for path with given mode and sha1.

git-write-tree
	Creates a tree object from the contents of the dircache
	(creating tree objects for subdirectories, recursively).
	Prints sha1 of top-level tree-object to stdout.
	Complains if any files are unmerged (merge stage > 0).

N.B.
w.d. = working directory (.)
dircache is in .git/index
object files are in $SHA1_FILE_DIRECTORY or .git/objects
