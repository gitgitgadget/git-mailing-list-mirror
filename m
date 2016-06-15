From: David Greaves <david@dgreaves.com>
Subject: Re: Quick command reference
Date: Sun, 01 May 2005 15:44:13 +0100
Message-ID: <4274EB3D.2060602@dgreaves.com>
References: <17012.53862.704670.858276@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010407090904060005070205"
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 01 16:40:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSFcg-00078s-Vz
	for gcvg-git@gmane.org; Sun, 01 May 2005 16:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVEAOqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 10:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVEAOqd
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 10:46:33 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:59336 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261637AbVEAOod (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 10:44:33 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id A2F93E6D76; Sun,  1 May 2005 15:44:19 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01588-10; Sun,  1 May 2005 15:44:19 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.147.201])
	by mail.ukfsn.org (Postfix) with ESMTP
	id E9878E6A83; Sun,  1 May 2005 15:44:12 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DSFg5-0007un-BR; Sun, 01 May 2005 15:44:13 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17012.53862.704670.858276@cargo.ozlabs.ibm.com>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------010407090904060005070205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Paul Mackerras wrote:

>As an aid to my understanding of the core git commands, I created this
>summary of the commands and their options and parameters.  I hope it
>will be useful to others.  Corrections welcome of course.
>
>Paul.
>  
>

Thanks Paul

Shame to see duplicated effort...

I've submitted this document to Linus and the list a few times and
included all the feedback but for some reason it's not gone into any of
the trees which means that people like you have to redo it from scratch...

Getting frustrated now...

David

-- 


--------------010407090904060005070205
Content-Type: text/plain;
 name="README.reference"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.reference"

This file contains reference information for the core git commands.
It is actually based on the source from Petr Baudis' tree and may
therefore contain a few 'extras' that may or may not make it upstream.

The README contains much useful definition and clarification info -
read that first.  And of the commands, I suggest reading
'update-cache' and 'read-tree' first - I wish I had!

Thanks to original email authors and proof readers esp Junio C Hamano
<junkio@cox.net>

David Greaves <david@dgreaves.com>
24/4/05

Identifier terminology used:

<object>
	Indicates any object sha1 identifier

<blob>
	Indicates a blob object sha1 identifier

<tree>
	Indicates a tree object sha1 identifier

<commit>
	Indicates a commit object sha1 identifier

<tree/commit>
	Indicates a tree or commit object sha1 identifier (usually
	because the command can read the <tree> a <commit> contains).
	[Eventually may be replaced with <tree> if <tree> means
	<tree/commit> in all commands]

<type>
	Indicates that an object type is required.
	Currently one of: blob/tree/commit

<file>
	Indicates a filename - often includes leading path

<path>
	Indicates the path of a file (is this ever useful?)



################################################################
cat-file
	cat-file (-t | <type>) <object>

Provide contents or type of objects in the repository. The type is
required if -t is not being used to find the object type.

<object>
	The sha1 identifier of the object.

-t
	show the object type identified by <object>

<type>
	One of: blob/tree/commit

Output

If -t is specified, one of:
        blob/tree/commit

Otherwise the raw (though uncompressed) contents of the <object> will
be returned.


################################################################
check-files
	check-files <file>...

Check that a list of files are up-to-date between the filesystem and
the cache. Used to verify a patch target before doing a patch.

Files that do not exist on the filesystem are considered up-to-date
(whether or not they are in the cache).

Emits an error message on failure.
preparing to update existing file <file> not in cache
	  <file> exists but is not in the cache

preparing to update file <file> not uptodate in cache
	  <file> on disk is not up-to-date with the cache

exits with a status code indicating success if all files are
up-to-date.

see also: update-cache


################################################################
checkout-cache
	checkout-cache [-q] [-a] [-f] [-n] [--prefix=<string>]
		       [--] <file>...

Will copy all files listed from the cache to the working directory
(not overwriting existing files). Note that the file contents are
restored - NOT the file permissions.
??? l 58 checkout-cache.c says restore executable bit.

-q
	be quiet if files exist or are not in the cache

-f
	forces overwrite of existing files

-a
	checks out all files in the cache (will then continue to
	process listed files).
-n
	Don't checkout new files, only refresh files already checked
	out.

--prefix=<string>
	When creating files, prepend <string> (usually a directory
	including a trailing /)

--
	Do not interpret any more arguments as options.

Note that the order of the flags matters:

	checkout-cache -a -f file.c

will first check out all files listed in the cache (but not overwrite
any old ones), and then force-checkout file.c a second time (ie that
one _will_ overwrite any old contents with the same filename).

Also, just doing "checkout-cache" does nothing. You probably meant
"checkout-cache -a". And if you want to force it, you want
"checkout-cache -f -a".

Intuitiveness is not the goal here. Repeatability is. The reason for
the "no arguments means no work" thing is that from scripts you are
supposed to be able to do things like

	find . -name '*.h' -print0 | xargs -0 checkout-cache -f --

which will force all existing *.h files to be replaced with their
cached copies. If an empty command line implied "all", then this would
force-refresh everything in the cache, which was not the point.

To update and refresh only the files already checked out:

   checkout-cache -n -f -a && update-cache --ignore-missing --refresh

Oh, and the "--" is just a good idea when you know the rest will be
filenames. Just so that you wouldn't have a filename of "-a" causing
problems (not possible in the above example, but get used to it in
scripting!).

The prefix ability basically makes it trivial to use checkout-cache as
a "export as tree" function. Just read the desired tree into the
index, and do a
  
        checkout-cache --prefix=export-dir/ -a
  
and checkout-cache will "export" the cache into the specified
directory.
  
NOTE! The final "/" is important. The exported name is literally just
prefixed with the specified string, so you can also do something like
  
        checkout-cache --prefix=.merged- Makefile
  
to check out the currently cached copy of "Makefile" into the file
".merged-Makefile".


################################################################
commit-tree
	commit-tree <tree> [-p <parent commit>]*   < changelog

Creates a new commit object based on the provided tree object and
emits the new commit object id on stdout. If no parent is given then
it is considered to be an initial tree.

A commit object usually has 1 parent (a commit after a change) or up
to 16 parents.  More than one parent represents a merge of branches
that led to them.

While a tree represents a particular directory state of a working
directory, a commit represents that state in "time", and explains how
to get there.

Normally a commit would identify a new "HEAD" state, and while git
doesn't care where you save the note about that state, in practice we
tend to just write the result to the file ".git/HEAD", so that we can
always see what the last committed state was.

Options

<tree>
	An existing tree object

-p <parent commit>
	Each -p indicates a the id of a parent commit object.
	

Commit Information

A commit encapsulates:
	all parent object ids
	author name, email and date
	committer name and email and the commit time.

If not provided, commit-tree uses your name, hostname and domain to
provide author and committer info. This can be overridden using the
following environment variables.
	AUTHOR_NAME
	AUTHOR_EMAIL
	AUTHOR_DATE
	COMMIT_AUTHOR_NAME
	COMMIT_AUTHOR_EMAIL
(nb <,> and '\n's are stripped)

A commit comment is read from stdin (max 999 chars). If a changelog
entry is not provided via '<' redirection, commit-tree will just wait
for one to be entered and terminated with ^D

see also: write-tree


################################################################
diff-cache
	diff-cache [-p] [-r] [-z] [--cached] <tree/commit>

Compares the content and mode of the blobs found via a tree object
with the content of the current cache and, optionally ignoring the
stat state of the file on disk.

<tree/commit>
	The id of a tree or commit object to diff against.

-p
	generate patch (see section on generating patches)

-r
	recurse

-z
	\0 line termination on output

--cached
	do not consider the on-disk file at all

Output format:

See "Output format from diff-cache, diff-tree and show-diff" section.

Operating Modes

You can choose whether you want to trust the index file entirely
(using the "--cached" flag) or ask the diff logic to show any files
that don't match the stat state as being "tentatively changed".  Both
of these operations are very useful indeed.

Cached Mode

If --cached is specified, it allows you to ask:
	show me the differences between HEAD and the current index
	contents (the ones I'd write with a "write-tree")

For example, let's say that you have worked on your index file, and are
ready to commit. You want to see eactly _what_ you are going to commit is
without having to write a new tree object and compare it that way, and to
do that, you just do

	diff-cache --cached $(cat .git/HEAD)

Example: let's say I had renamed "commit.c" to "git-commit.c", and I had 
done an "upate-cache" to make that effective in the index file. 
"show-diff" wouldn't show anything at all, since the index file matches 
my working directory. But doing a diff-cache does:
	torvalds@ppc970:~/git> diff-cache --cached $(cat .git/HEAD)
	-100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        commit.c
	+100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        git-commit.c

And as you can see, the output matches "diff-tree -r" output (we
always do equivalent of "-r", since the index is flat).
You can trivially see that the above is a rename.

In fact, "diff-cache --cached" _should_ always be entirely equivalent to
actually doing a "write-tree" and comparing that. Except this one is much
nicer for the case where you just want to check where you are.

So doing a "diff-cache --cached" is basically very useful when you are 
asking yourself "what have I already marked for being committed, and 
what's the difference to a previous tree".

Non-cached Mode

The "non-cached" mode takes a different approach, and is potentially
the even more useful of the two in that what it does can't be emulated
with a "write-tree + diff-tree". Thus that's the default mode.  The
non-cached version asks the question

   "show me the differences between HEAD and the currently checked out 
    tree - index contents _and_ files that aren't up-to-date"

which is obviously a very useful question too, since that tells you what
you _could_ commit. Again, the output matches the "diff-tree -r" output to
a tee, but with a twist.

The twist is that if some file doesn't match the cache, we don't have a
backing store thing for it, and we use the magic "all-zero" sha1 to show
that. So let's say that you have edited "kernel/sched.c", but have not
actually done an update-cache on it yet - there is no "object" associated
with the new state, and you get:

	torvalds@ppc970:~/v2.6/linux> diff-cache $(cat .git/HEAD )
	*100644->100664 blob    7476bbcfe5ef5a1dd87d745f298b831143e4d77e->0000000000000000000000000000000000000000      kernel/sched.c

ie it shows that the tree has changed, and that "kernel/sched.c" has is
not up-to-date and may contain new stuff. The all-zero sha1 means that to
get the real diff, you need to look at the object in the working directory
directly rather than do an object-to-object diff.

NOTE! As with other commands of this type, "diff-cache" does not actually 
look at the contents of the file at all. So maybe "kernel/sched.c" hasn't 
actually changed, and it's just that you touched it. In either case, it's 
a note that you need to upate-cache it to make the cache be in sync.

NOTE 2! You can have a mixture of files show up as "has been updated" and
"is still dirty in the working directory" together. You can always tell
which file is in which state, since the "has been updated" ones show a
valid sha1, and the "not in sync with the index" ones will always have the
special all-zero sha1.

################################################################
diff-tree
	diff-tree [-p] [-r] [-z] <tree/commit> <tree/commit> [<pattern>]*

Compares the content and mode of the blobs found via two tree objects.

Note that diff-tree can use the tree encapsulated in a commit object.

<tree sha1>
	The id of a tree or commit object.

<pattern>

	If provided, the results are limited to a subset of files
	matching one of these prefix strings.
	ie file matches /^<pattern1>|<pattern2>|.../
	Note that pattern does not provide any wildcard or regexp features.

-p
	generate patch (see section on generating patches)

-r
	recurse

-z
	\0 line termination on output

Limiting Output

If you're only interested in differences in a subset of files, for
example some architecture-specific files, you might do:

	diff-tree -r <tree/commit> <tree/commit> arch/ia64 include/asm-ia64

and it will only show you what changed in those two directories.

Or if you are searching for what changed in just kernel/sched.c, just do

	diff-tree -r <tree/commit> <tree/commit> kernel/sched.c

and it will ignore all differences to other files.

The pattern is always the prefix, and is matched exactly (ie there are no
wildcards - although matching a directory, which it does support, can
obviously be seen as a "wildcard" for all the files under that directory).

Output format:

See "Output format from diff-cache, diff-tree and show-diff" section.

An example of normal usage is:

	torvalds@ppc970:~/git> diff-tree 5319e4d609cdd282069cc4dce33c1db559539b03 b4e628ea30d5ab3606119d2ea5caeab141d38df7
	*100664->100664 blob    ac348b7d5278e9d04e3a1cd417389379c32b014f->a01513ed4d4d565911a60981bfb4173311ba3688      fsck-cache.c

which tells you that the last commit changed just one file (it's from
this one:

	commit 3c6f7ca19ad4043e9e72fa94106f352897e651a8
	tree 5319e4d609cdd282069cc4dce33c1db559539b03
	parent b4e628ea30d5ab3606119d2ea5caeab141d38df7
	author Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005
	committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005

	Make "fsck-cache" print out all the root commits it finds.

	Once I do the reference tracking, I'll also make it print out all the
	HEAD commits it finds, which is even more interesting.

in case you care).

################################################################
diff-tree-helper
	diff-tree-helper [-z]

Reads output from diff-cache, diff-tree and show-diff and
generates patch format output.

-z
	\0 line termination on input

See also the section on generating patches.

################################################################
fsck-cache
	fsck-cache [[--unreachable] <commit>*]

Verifies the connectivity and validity of the objects in the database.

<commit>
	A commit object to treat as the head of an unreachability
	trace

--unreachable
	print out objects that exist but that aren't readable from any
	of the specified root nodes

It tests SHA1 and general object sanity, but it does full tracking of
the resulting reachability and everything else. It prints out any
corruption it finds (missing or bad objects), and if you use the
"--unreachable" flag it will also print out objects that exist but
that aren't readable from any of the specified root nodes.

So for example

	fsck-cache --unreachable $(cat .git/HEAD)

or, for Cogito users:

	fsck-cache --unreachable $(cat .git/heads/*)

will do quite a _lot_ of verification on the tree. There are a few
extra validity tests to be added (make sure that tree objects are
sorted properly etc), but on the whole if "fsck-cache" is happy, you
do have a valid tree.

Any corrupt objects you will have to find in backups or other archives
(ie you can just remove them and do an "rsync" with some other site in
the hopes that somebody else has the object you have corrupted).

Of course, "valid tree" doesn't mean that it wasn't generated by some
evil person, and the end result might be crap. Git is a revision
tracking system, not a quality assurance system ;)

Extracted Diagnostics

expect dangling commits - potential heads - due to lack of head information
	You haven't specified any nodes as heads so it won't be
	possible to differentiate between un-parented commits and
	root nodes.

missing sha1 directory '<dir>'
	The directory holding the sha1 objects is missing.

unreachable <type> <object>
	The <type> object <object>, isn't actually referred to directly
	or indirectly in any of the trees or commits seen. This can
	mean that there's another root na SHA1_ode that you're not specifying
	or that the tree is corrupt. If you haven't missed a root node
	then you might as well delete unreachable nodes since they
	can't be used.

missing <type> <object>
	The <type> object <object>, is referred to but isn't present in
	the database.

dangling <type> <object>
	The <type> object <object>, is present in the database but never
	_directly_ used. A dangling commit could be a root node.

warning: fsck-cache: tree <tree> has full pathnames in it
	And it shouldn't...

sha1 mismatch <object>
	The database has an object who's sha1 doesn't match the
	database value.
	This indicates a ??serious?? data integrity problem.
	(note: this error occured during early git development when
	the database format changed.)

Environment Variables

SHA1_FILE_DIRECTORY
	used to specify the object database root (usually .git/objects)

################################################################
git-export
	git-export top [base]

probably deprecated:
On Wed, 20 Apr 2005, Petr Baudis wrote:
>> I will probably not buy git-export, though. (That is, it is merged, but
>> I won't make git frontend for it.) My "git export" already does
>> something different, but more importantly, "git patch" of mine already
>> does effectively the same thing as you do, just for a single patch; so I
>> will probably just extend it to do it for an (a,b] range of patches.


That's fine. It was a quick hack, just to show that if somebody wants to, 
the data is trivially exportable.

		Linus

Although in Linus' distribution, git-export is not part of 'core' git.

################################################################
init-db
	init-db

This simply creates an empty git object database - basically a .git
directory.

If the object storage directory is specified via the
SHA1_FILE_DIRECTORY environment variable then the sha1 directories are
created underneath - otherwise the default .git/objects directory is
used.

init-db won't hurt an existing repository.


################################################################
ls-tree
	ls-tree [-r] [-z] <tree/commit>

convert the tree object to a human readable (and script
processable) form.

<tree/commit>
	Id of a tree or commit object.
-r
	recurse into sub-trees

-z
	\0 line termination on output

Output Format
<mode>\t	<type>\t	<object>\t	<path><file>	


################################################################
merge-base
	merge-base <commit> <commit>

merge-base finds as good a common ancestor as possible. Given a
selection of equally good common ancestors it should not be relied on
to decide in any particular way.

The merge-base algorithm is still in flux - use the source...


################################################################
merge-cache
	merge-cache <merge-program> (-a | -- | <file>*) 

This looks up the <file>(s) in the cache and, if there are any merge
entries, unpacks all of them (which may be just one file, of course)
into up to three separate temporary files, and then executes the
supplied <merge-program> with those three files as arguments 1,2,3
(empty argument if no file), and <file> as argument 4.

--
	Interpret all future arguments as filenames

-a
	Run merge against all files in the cache that need merging.

If merge-cache is called with multiple <file>s (or -a) then it
processes them in turn only stopping if merge returns a non-zero exit
code.

Typically this is run with the a script calling the merge command from
the RCS package.

A sample script called git-merge-one-file-script is included in the
ditribution.

ALERT ALERT ALERT! The git "merge object order" is different from the
RCS "merge" program merge object order. In the above ordering, the
original is first. But the argument order to the 3-way merge program
"merge" is to have the original in the middle. Don't ask me why.

Examples:

	torvalds@ppc970:~/merge-test> merge-cache cat MM
	This is MM from the original tree.			# original
	This is modified MM in the branch A.			# merge1
	This is modified MM in the branch B.			# merge2
	This is modified MM in the branch B.			# current contents

or 

	torvalds@ppc970:~/merge-test> merge-cache cat AA MM
	cat: : No such file or directory
	This is added AA in the branch A.
	This is added AA in the branch B.
	This is added AA in the branch B.
	fatal: merge program failed

where the latter example shows how "merge-cache" will stop trying to
merge once anything has returned an error (ie "cat" returned an error
for the AA file, because it didn't exist in the original, and thus
"merge-cache" didn't even try to merge the MM thing).


################################################################
read-tree
	read-tree (<tree/commit> | -m <tree/commit1> [<tree/commit2> <tree/commit3>])"

Reads the tree information given by <tree> into the directory cache,
but does not actually _update_ any of the files it "caches". (see:
checkout-cache)

Optionally, it can merge a tree into the cache or perform a 3-way
merge.

Trivial merges are done by read-tree itself.  Only conflicting paths
will be in unmerged state when read-tree returns.

-m
	Perform a merge, not just a read

<tree#>
	The id of the tree object(s) to be read/merged.


Merging
If -m is specified, read-tree performs 2 kinds of merge, a single tree
merge if only 1 tree is given or a 3-way merge if 3 trees are
provided.

Single Tree Merge
If only 1 tree is specified, read-tree operates as if the user did not
specify "-m", except that if the original cache has an entry for a
given pathname; and the contents of the path matches with the tree
being read, the stat info from the cache is used. (In other words, the
cache's stat()s take precedence over the merged tree's)

That means that if you do a "read-tree -m <newtree>" followed by a
"checkout-cache -f -a", the checkout-cache only checks out the stuff
that really changed.

This is used to avoid unnecessary false hits when show-diff is
run after read-tree.

3-Way Merge
Each "index" entry has two bits worth of "stage" state. stage 0 is the
normal one, and is the only one you'd see in any kind of normal use.

However, when you do "read-tree" with multiple trees, the "stage"
starts out at 0, but increments for each tree you read. And in
particular, the "-m" flag means "start at stage 1" instead.

This means that you can do

	read-tree -m <tree1> <tree2> <tree3>

and you will end up with an index with all of the <tree1> entries in
"stage1", all of the <tree2> entries in "stage2" and all of the
<tree3> entries in "stage3".

Furthermore, "read-tree" has special-case logic that says: if you see
a file that matches in all respects in the following states, it
"collapses" back to "stage0":

   - stage 2 and 3 are the same; take one or the other (it makes no
     difference - the same work has been done on stage 2 and 3)

   - stage 1 and stage 2 are the same and stage 3 is different; take
     stage 3 (some work has been done on stage 3)

   - stage 1 and stage 3 are the same and stage 2 is different take
     stage 2 (some work has been done on stage 2)

Write-tree refuses to write a nonsensical tree, so write-tree will
complain about unmerged entries if it sees a single entry that is not
stage 0".

Ok, this all sounds like a collection of totally nonsensical rules,
but it's actually exactly what you want in order to do a fast
merge. The different stages represent the "result tree" (stage 0, aka
"merged"), the original tree (stage 1, aka "orig"), and the two trees
you are trying to merge (stage 2 and 3 respectively).

In fact, the way "read-tree" works, it's entirely agnostic about how
you assign the stages, and you could really assign them any which way,
and the above is just a suggested way to do it (except since
"write-tree" refuses to write anything but stage0 entries, it makes
sense to always consider stage 0 to be the "full merge" state).

So what happens? Try it out. Select the original tree, and two trees
to merge, and look how it works:

 - if a file exists in identical format in all three trees, it will 
   automatically collapse to "merged" state by the new read-tree.

 - a file that has _any_ difference what-so-ever in the three trees
   will stay as separate entries in the index. It's up to "script
   policy" to determine how to remove the non-0 stages, and insert a
   merged version.  But since the index is always sorted, they're easy
   to find: they'll be clustered together.

 - the index file saves and restores with all this information, so you
   can merge things incrementally, but as long as it has entries in
   stages 1/2/3 (ie "unmerged entries") you can't write the result.

So now the merge algorithm ends up being really simple:

 - you walk the index in order, and ignore all entries of stage 0,
   since they've already been done.

 - if you find a "stage1", but no matching "stage2" or "stage3", you
   know it's been removed from both trees (it only existed in the
   original tree), and you remove that entry.  - if you find a
   matching "stage2" and "stage3" tree, you remove one of them, and
   turn the other into a "stage0" entry. Remove any matching "stage1"
   entry if it exists too.  .. all the normal trivial rules ..

Incidentally - it also means that you don't even have to have a separate 
subdirectory for this. All the information literally is in the index file, 
which is a temporary thing anyway. There is no need to worry about what is in 
the working directory, since it is never shown and never used.

see also:
write-tree
show-files


################################################################
rev-list <commit>

Lists commit objects in reverse chronological order starting at the
given commit, taking ancestry relationship into account.  This is
useful to produce human-readable log output.


################################################################
rev-tree
	rev-tree [--edges] [--cache <cache-file>] [^]<commit> [[^]<commit>]

Provides the revision tree for one or more commits.

--edges
	Show edges (ie places where the marking changes between parent
	and child)

--cache <cache-file>
	Use the specified file as a cache. [Not implemented yet]

[^]<commit>
	The commit id to trace (a leading caret means to ignore this
	commit-id and below)

Output:
<date> <commit>:<flags> [<parent-commit>:<flags> ]*

<date>
	Date in 'seconds since epoch'

<commit>
	id of commit object

<parent-commit>
	id of each parent commit object (>1 indicates a merge)

<flags>

	The flags are read as a bitmask representing each commit
	provided on the commandline. eg: given the command:

		 $ rev-tree <com1> <com2> <com3>

	The output:

	    <date> <commit>:5

	 means that <commit> is reachable from <com1>(1) and <com3>(4)
	
A revtree can get quite large. rev-tree will eventually allow you to
cache previous state so that you don't have to follow the whole thing
down.

So the change difference between two commits is literally

	rev-tree [commit-id1]  > commit1-revtree
	rev-tree [commit-id2]  > commit2-revtree
	join -t : commit1-revtree commit2-revtree > common-revisions

(this is also how to find the most common parent - you'd look at just
the head revisions - the ones that aren't referred to by other
revisions - in "common-revision", and figure out the best one. I
think.)


################################################################
show-diff
	show-diff [-p] [-q] [-s] [-z] [paths...]

Compares the files in the working tree and the cache.  When paths
are specified, compares only those named paths.  Otherwise all
entries in the cache are compared.  The output format is the
same as diff-cache and diff-tree.

-p
	generate patch (see section on generating patches)

-q
	Remain silent even on nonexisting files

-s
	Does not do anything other than what -q does.

Output format:

See "Output format from diff-cache, diff-tree and show-diff" section.

################################################################
show-files
	show-files [-z] [-t]
		(--[cached|deleted|others|ignored|stage|unmerged])*
		(-[c|d|o|i|s|u])*
		[-x <pattern>|--exclude=<pattern>]
		[-X <file>|--exclude-from=<file>]

This merges the file listing in the directory cache index with the
actual working directory list, and shows different combinations of the
two.

One or more of the options below may be used to determine the files
shown:

-c|--cached
	Show cached files in the output (default)

-d|--deleted
	Show deleted files in the output

-o|--others
	Show other files in the output

-i|--ignored
	Show ignored files in the output
	Note the this also reverses any exclude list present.

-s|--stage
	Show stage files in the output

-u|--unmerged
	Show unmerged files in the output (forces --stage)

#-t [not in Linus' tree (yet?)]
#	Identify the file status with the following tags (followed by
#	a space) at the start of each line:
#	H	cached
#	M	unmerged
#	R	removed/deleted
#	?	other

-z
	\0 line termination on output

-x|--exclude=<pattern>
	Skips files matching pattern.
	Note that pattern is a shell wildcard pattern.

-X|--exclude-from=<file>
	exclude patterns are read from <file>; 1 per line.
	Allows the use of the famous dontdiff file as follows to find
	out about uncommitted files just as dontdiff is used with
	the diff command:
	     show-files --others --exclude-from=dontdiff

Output
show files just outputs the filename unless --stage is specified in
which case it outputs:

[<tag> ]<mode> <object> <stage> <file>

show-files --unmerged" and "show-files --stage " can be used to examine
detailed information on unmerged paths.

For an unmerged path, instead of recording a single mode/SHA1 pair,
the dircache records up to three such pairs; one from tree O in stage
1, A in stage 2, and B in stage 3.  This information can be used by
the user (or Cogito) to see what should eventually be recorded at the
path. (see read-cache for more information on state)

see also:
read-cache


################################################################
unpack-file
	unpack-file <blob>

Creates a file holding the contents of the blob specified by sha1. It
returns the name of the temporary file in the following format:
	.merge_file_XXXXX

<blob>
	Must be a blob id

################################################################
update-cache
	update-cache [--add] [--remove] [--refresh [--ignore-missing]]
		     [--cacheinfo <mode> <object> <path>]*
		     [--] [<file>]*

Modifies the index or directory cache. Each file mentioned is updated
into the cache and any 'unmerged' or 'needs updating' state is
cleared.

The way update-cache handles files it is told about can be modified
using the various options:

--add
	If a specified file isn't in the cache already then it's
	added.
	Default behaviour is to ignore new files.

--remove
	If a specified file is in the cache but is missing then it's
	removed.
	Default behaviour is to ignore removed file.

--refresh
	Looks at the current cache and checks to see if merges or
	updates are needed by checking stat() information.

--ignore-missing
	Ignores missing files during a --refresh

--cacheinfo <mode> <object> <path>
	Directly insert the specified info into the cache.
	
--
	Do not interpret any more arguments as options.

<file>
	Files to act on.
	Note that files begining with '.' are discarded. This includes
	"./file" and "dir/./file". If you don't want this, then use	
	cleaner names.
	The same applies to directories ending '/' and paths with '//'


Using --refresh

--refresh does not calculate a new sha1 file or bring the cache
up-to-date for mode/content changes. But what it _does_ do is to
"re-match" the stat information of a file with the cache, so that you
can refresh the cache for a file that hasn't been changed but where
the stat entry is out of date.

For example, you'd want to do this after doing a "read-tree", to link
up the stat cache details with the proper files.

Using --cacheinfo
--cacheinfo is used to register a file that is not in the current
working directory.  This is useful for minimum-checkout merging.

To pretend you have a file with mode and sha1 at path, say:

 $ update-cache --cacheinfo mode sha1 path

To update and refresh only the files already checked out:

   checkout-cache -n -f -a && update-cache --ignore-missing --refresh


################################################################
write-tree
	write-tree

Creates a tree object using the current cache.

The cache must be merged.

Conceptually, write-tree sync()s the current directory cache contents
into a set of tree files.
In order to have that match what is actually in your directory right
now, you need to have done a "update-cache" phase before you did the
"write-tree".


################################################################

Output format from diff-cache, diff-tree and show-diff.

These commands all compare two sets of things; what are
compared are different:

    diff-cache <tree/commit>

        compares the <tree/commit> and the files on the filesystem.

    diff-cache --cached <tree/commit>

        compares the <tree/commit> and the cache.

    diff-tree [-r] <tree/commit-1> <tree/commit-2> [paths...]

        compares the trees named by the two arguments.

    show-diff [paths...]

        compares the cache and the files on the filesystem.

The following desription uses "old" and "new" to mean those
compared entities.

For files in old but not in new (i.e. removed):
-<mode> \t <type> \t <object> \t <path>

For files not in old but in new (i.e. added):
+<mode> \t <type> \t <object> \t <path>

For files that differ:
*<old-mode>-><new-mode> \t <type> \t <old-sha1>-><new-sha1> \t <path>

<new-sha1> is shown as all 0's if new is a file on the
filesystem and it is out of sync with the cache.  Example:

    *100644->100660 blob    5be4a414b32cf4204f889469942986d3d783da84->0000000000000000000000000000000000000000      file.c

################################################################

Generating patches

When diff-cache, diff-tree, or show-diff are run with a -p
option, they do not produce the output described in "Output
format from diff-cache, diff-tree and show-diff" section.  It
instead produces a patch file.

The patch generation can be customized at two levels.  This
customization also applies to diff-tree-helper.

1. When the environment variable GIT_EXTERNAL_DIFF is not set,
   these commands internally invoke diff like this:

   diff -L k/<path> -L l/<path> -pu <old> <new>

   For added files, /dev/null is used for <old>.  For removed
   files, /dev/null is used for <new>

   The first part of the above command-line can be customized via
   the environment variable GIT_DIFF_CMD.  For example, if you
   do not want to show the extra level of leading path, you can
   say this:

   GIT_DIFF_CMD="diff -L'%s' -L'%s'" show-diff -p

   Caution:  Do not use more than two '%s' in GIT_DIFF_CMD.

   The diff formatting options can be customized via the
   environment variable GIT_DIFF_OPTS.  For example, if you
   prefer context diff:

   GIT_DIFF_OPTS=-c diff-cache -p $(cat .git/HEAD)


2. When the environment variable GIT_EXTERNAL_DIFF is set, the
   program named by it is called, instead of the diff invocation
   described above.

   For a path that is added, removed, or modified,
   GIT_EXTERNAL_DIFF is called with 7 parameters:

     path old-file old-hex old-mode new-file new-hex new-mode

   where
     <old|new>-file are files GIT_EXTERNAL_DIFF can use to read the
                    contents of <old|ne>,
     <old|new>-hex are the 40-hexdigit SHA1 hashes,
     <old|new>-mode are the octal representation of the file modes.

   The file parameters can point at the user's working file
   (e.g. new-file in show-diff), /dev/null (e.g. old-file when a
   new file is added), or a temporary file (e.g. old-file in the
   cache).  GIT_EXTERNAL_DIFF should not worry about
   unlinking the temporary file --- it is removed when
   GIT_EXTERNAL_DIFF exits.

   For a path that is unmerged, GIT_EXTERNAL_DIFF is called with
   1 parameter, path.

################################################################

Terminology: - see README for description
Each line contains terms used interchangeably

object database, .git directory
directory cache, index
id, sha1, sha1-id, sha1 hash
type, tag
blob, blob object
tree, tree object
commit, commit object
parent
root object
changeset


git Environment Variables
AUTHOR_NAME
AUTHOR_EMAIL
AUTHOR_DATE
COMMIT_AUTHOR_NAME
COMMIT_AUTHOR_EMAIL
GIT_DIFF_CMD
GIT_DIFF_OPTS
GIT_EXTERNAL_DIFF
GIT_INDEX_FILE
SHA1_FILE_DIRECTORY


--------------010407090904060005070205--
