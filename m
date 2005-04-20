From: David Greaves <david@dgreaves.com>
Subject: [PATCH] Some documentation...
Date: Wed, 20 Apr 2005 18:08:29 +0100
Message-ID: <42668C8D.3000209@dgreaves.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040001080207050408070601"
X-From: git-owner@vger.kernel.org Wed Apr 20 19:05:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOId6-0001XE-4j
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 19:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVDTRJC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 13:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVDTRJC
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 13:09:02 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:38617 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261471AbVDTRIu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 13:08:50 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id C0B05E6A88; Wed, 20 Apr 2005 18:07:04 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 14803-07; Wed, 20 Apr 2005 18:07:04 +0100 (BST)
Received: from oak.dgreaves.com (modem-3138.crocodile.dialup.pol.co.uk [81.78.44.66])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 5A701E6A8B; Wed, 20 Apr 2005 18:07:01 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DOIgf-0000ZZ-Ei; Wed, 20 Apr 2005 18:08:29 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------040001080207050408070601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

I'm starting to write some docs...
Comments... even "yep, looks OK, carry on" :)

I plan on putting the 'git command' ones into the 'git help ...' 
structure once Petr accepts it.
I guess the low level ones go into a README.reference until they 
stabilise and become man pages...

In doing this I noticed a couple of points:
* update-cache won't accept ./file or fred/./file
* checkout-cache doesn't seem to preserve mode

Are these bugs or should they be documented?
I've taken the approach of documenting behaviour for now.

Signed-off-by: David Greaves <david@dgreaves.com>
---



--------------040001080207050408070601
Content-Type: text/x-patch;
 name="README.reference.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.reference.patch"

Index: README.reference
===================================================================
--- /dev/null  (tree:cf6a46a2199777c3dac32fa4479b97c0752cdf07)
+++ 30de093673d44c7ea8c56a0194fb792e47225ac8/README.reference  (mode:100644 sha1:2ec6683b22e5672ea46d27770fcb1a4b4c37aa0e)
@@ -0,0 +1,158 @@
+Terminology: - see README for description
+Each line contains terms used interchangeably
+
+object database, .git directory
+directory cache, index
+id, sha1, sha1-id, sha1 hash
+type, tag, tagname
+blob, blob object
+tree, tree object
+commit, commit object
+parent
+root object
+changeset
+
+################################################################
+cat-file
+	cat-file <-t | tagname> <sha1>
+
+Provide contents or type of objects in the repository. The tagname is
+required if it is not being interrogated.
+
+
+<sha1>
+	The sha1 identifier of the object.
+	(This is the sha1 of the uncompressed content.)
+
+-t
+	show the object type identified by <sha1>
+	One of: blob/tree/commit
+
+<tagname>
+	One of: blob/tree/commit
+
+
+################################################################
+check-files
+	check-files <file>...
+
+Check that a list of files are up-to-date between the filesystem and
+the cache. Used to verify a patch target before doing a patch.
+
+Files that do not exist on the filesystem are considered up-to-date
+(whether or not they are in the cache).
+
+Emits an error message on failure.
+
+exits with a status code indicating success if all files are
+up-to-date.
+
+
+see also: update-cache
+
+
+################################################################
+checkout-cache
+	checkout-cache [-q] [-a] [-f] [--] <file>...
+
+Will copy all files listed from the cache to the working directory
+(not overwriting existing files). Note that the file contents are
+restored - NOT the file permissions.
+
+-q
+	be quiet if files exist or are not in the cache
+
+-f
+	forces overwrite of existing files
+
+-a
+	checks out all files in the cache before processing listed
+	files.
+
+Note that the order of the flags matters:
+
+	checkout-cache -a -f file.c
+
+will first check out all files listed in the cache (but not overwrite
+any old ones), and then force-checkout file.c a second time (ie that
+one _will_ overwrite any old contents with the same filename).
+
+Also, just doing "checkout-cache" does nothing. You probably meant
+"checkout-cache -a". And if you want to force it, you want
+"checkout-cache -f -a".
+
+Intuitiveness is not the goal here. Repeatability is. The reason for
+the "no arguments means no work" thing is that from scripts you are
+supposed to be able to do things like
+
+	find . -name '*.h' -print0 | xargs -0 checkout-cache -f --
+
+which will force all existing *.h files to be replaced with their
+cached copies. If an empty command line implied "all", then this would
+force-refresh everything in the cache, which was not the point.
+
+Oh, and the "--" is just a good idea when you know the rest will be
+filenames. Just so that you wouldn't have a filename of "-a" causing
+problems (not possible in the above example, but get used to it in
+scripting!).
+
+
+################################################################
+commit-id
+	commit-id [tag]
+
+Returns the sha1-id of the commit object associated with given tag.
+
+tag
+	tag of commit object - defaults to the current HEAD.
+
+
+################################################################
+commit-tree
+	commit-tree <sha1> [-p <sha1>]* < changelog
+
+
+################################################################
+diff-tree
+	diff-tree [-r] [-z] <tree sha1> <tree sha1>
+
+
+################################################################
+ls-tree
+	ls-tree [-r] [-z] <key>
+
+
+################################################################
+merge-base
+	merge-base <commit-id> <commit-id>
+
+
+################################################################
+merge-cache
+	merge-cache <merge-program> (-a | <filename>*)
+
+
+################################################################
+read-tree
+	read-tree [-m] <sha1>
+
+
+################################################################
+rev-tree
+	rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id>]
+
+
+################################################################
+show-diff
+	show-diff [-q] [-s] [-z] [paths...]
+
+
+################################################################
+show-files
+	show-files [-z] [-t] (--[cached|deleted|others|ignored|stage])*
+
+
+################################################################
+unpack-file
+	unpack-file.c <sha1>
+

--------------040001080207050408070601--
