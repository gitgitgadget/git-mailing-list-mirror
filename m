X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: svn versus git
Date: Wed, 13 Dec 2006 23:29:16 +0100
Organization: At home
Message-ID: <elpun9$qp1$1@sea.gmane.org>
References: <200612132200.41420.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 13 Dec 2006 22:27:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 125
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34243>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GucZh-0000u1-Sl for gcvg-git@gmane.org; Wed, 13 Dec
 2006 23:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751636AbWLMW12 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 17:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbWLMW11
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 17:27:27 -0500
Received: from main.gmane.org ([80.91.229.2]:39255 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751636AbWLMW10
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 17:27:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GucZE-0003zp-24 for git@vger.kernel.org; Wed, 13 Dec 2006 23:27:12 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 23:27:12 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 13 Dec 2006
 23:27:12 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

By the way, it would be nice to have this discussion added to GitWiki:
  http://git.or.cz/gitwiki/GitSvnComparsion

Andy Parkins wrote:

> svn cat::
> Output the contents of specified files or URLs.  Optionally at a
> specific revision.

> git cat-file -p $(git-ls-tree $REV $file | cut -d " " -f 3 | cut -f 1)::
> git-ls-tree lists the object ID for $file in revision $REV, this is cut
> out of the output and used as an argument to git-cat-file, which should
> really be called git-cat-object, and simply dumps that object to stdout.

You can use extended sha1 syntax, described in git-rev-parse(1) (although
it would be nice to have relevant parts of documentation repeated in
git-cat-file(1)), namely
  git cat-file -p REV:file
(and you can use "git cat-file -p ::file" to get index/staging area
version)
 
As for alias: what about "alias.less = --paginate cat-file -p",
set using "git repo-config alias.less '--paginate cat-file -p'"?
 
> svn cleanup::
> Recursively clean up the working copy, removing locks, resuming
> unfinished operations, etc.
> git fsck-objects::
> git prune::
> git repack::
> Check the repository for consistency, remove unreferenced objects, or
> recompress existing objects.
> 
> They don't really serve the exact same purpose, but they are all
> maintenance commands.
> 
> Subversion wins, as it only has one command and you don't need to
> understand the repository in order to understand what its doing.

git-fsck-objects is needed only if something doesn't work when
it should. "git repack" is safe, "git repack -a -d" is almost safe,
while "git prune" is not.
 
> svn export::
> Create an unversioned copy of a tree.
> git archive::
> Creates an archive of the files in the named tree.
> 
> Git wins.  It can make zip/tar directly and add directory prefixes
> should you want them.  It could perhaps be a modicum easier if it had a
> default output format so that "git-archive HEAD" would do something.

Perhaps git-archive should support "tree" format, i.e. writing
unversioned copy of a tree to filesystem.
 
> svn resolved::
> Remove 'conflicted' state on working copy files or directories.
> git update-index::
> git checkout::
> Git doesn't have a direct "resolved"; after you fix conflicts, you push
> the changes into the staging area with "git-update-index".
> Alternatively you can simply accept the version in HEAD by checking out
> that version.
> 
> Draw.  "svn-resolved" is rubbish, as it doesn't do any checks, it just
> removes the conflict markers.  Git could do with something that makes
> life easier than understanding the index.

There was discussion about adding thin wrapper around git-update-index
to specifically mark resolved merge conflicts. The option to pick up
ours, theirs, ancestor version is another argument for having such command.
 
> svn revert::
> Restore pristine working copy file (undo most local edits).
> git reset --hard::
> Reset the repository to an arbitrary point in the past, updating the
> working copy as well.
> git checkout -f HEAD <file>::
> Checks out <file> from HEAD, forcing an overwrite of any working
> directory changes to that file.
> 
> Draw.  There is no easy way to undo changes that have already been
> committed to a subversion repository, so git would win.  However, it's
> uncomfortable to revert a single file using checkout.

There was talk about adding "git reset [<commit-ish>] -- <file>".

> Discussion
> ----------
> 
> What would git need to do to win in every section?
> 
> Subversion won:
>  - svn cat: the git equivalent is too complicated.
>    It wouldn't be hard to write a git-cat; if git's aliases allowed
>    pipes, it could be done instantly.

It can be done without pipes: "git cat-file -p REV:file".
You can use aliases to have shorter name for that.

>  - svn checkout: the output from git-clone is unfriendly.
>    -------------------
>    remote: Generating pack...
>    remote: Done counting 6 objects.
>    remote: Deltifying 6 objects.
>    remote:  100% (6/6) done
>    Indexing 6 objects.
>    remote: Total 6, written 6 (delta 0), reused 0 (delta 0)
>     100% (6/6) done
>    -------------------
>    What are "objects"?  What is deltifying?  Why does object count
>    matter to me?  What is indexing?  How much data was transferred?  How
>    long did it take?  How big is my local clone?
>    
>    While transferring: how long is it going to take to finish?  How much
>    data is there to transfer in total?

Hmmm... I thought that some progress indicator of download/upload was
added... guess I was wrong.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

