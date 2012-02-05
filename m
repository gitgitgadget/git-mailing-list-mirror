From: Vicent Marti <vicent@github.com>
Subject: [ANNOUNCE] libgit2 v0.16.0
Date: Sun, 5 Feb 2012 17:28:03 +0100
Message-ID: <CAFFjANTU4JfZuFJBm_9-F3bb4Q+10SQ_Tny81E=wwosXXyzdtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: libgit2@librelist.org, git@vger.kernel.org, git-dev@github.com
X-From: git-owner@vger.kernel.org Sun Feb 05 17:28:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru4xR-0005Td-Jw
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 17:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664Ab2BEQ2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 11:28:25 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64692 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab2BEQ2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 11:28:24 -0500
Received: by vcge1 with SMTP id e1so3493604vcg.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 08:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=pjQslYZHrCIWQQ0y+qr+95nF7tFOxGvUDaVIhgPhpbc=;
        b=FqDJuXPCIAH2lWtkJ++8uXk+BNLmZXRiF/opmKgCOkc7dxd4EWLBorFHimRB415iXG
         +tq5LFKFDisfNawprQYWb21FdIv/q8J/y75BwvzysfmpP8MUsNI84ziqi1QvQD0KrQfb
         xgumFJW8bJVLViwFihtOSi/RZl/wu5M5KxtLI=
Received: by 10.220.229.68 with SMTP id jh4mr7767420vcb.50.1328459303143; Sun,
 05 Feb 2012 08:28:23 -0800 (PST)
Received: by 10.52.187.97 with HTTP; Sun, 5 Feb 2012 08:28:03 -0800 (PST)
X-Google-Sender-Auth: S1YmN6837a-EeiQ9NS5aZwF2wSs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189947>

Hello everyone,

another minor libgit2 release is here, albeit slightly delayed. This
one ships from Brussels, damn it's cold.

The release has been tagged at:

 https://github.com/libgit2/libgit2/tree/v0.16.0

A dist package can be found at:

 https://github.com/downloads/libgit2/libgit2/libgit2-0.16.0.tar.gz

Updated documentation can be found at:

 http://libgit2.github.com/libgit2/

The full change log follows after the message.

Cheers,
Vicent

===================================

libgit2 v0.16.0 "Dutch Fries"

This lovely and much delayed release of libgit2 ships from the cold city
of Brussels, which is currently hosting FOSDEM 2012.

There's been plenty of changes since the latest stable release, here's a
full summary:

- Git Attributes support (see git2/attr.h)
	There is now support to efficiently parse and retrieve information
	from `.gitattribute` files in a repository. Note that this
	information is not yet used e.g. when checking out files.

- .gitignore support
	Likewise, all the operations that are affected by `.gitignore` files
	now take into account the global, user and local ignores when
	skipping the relevant files.

- Cleanup of the object ownership semantics
	The ownership semantics for all repository subparts (index, odb,
	config files, etc) has been redesigned. All these objects are now
	reference counted, and can be hot-swapped in the middle of
	execution, allowing for instance to add a working directory and an
	index to a repository that was previously opened as bare, or to
	change the source of the ODB objects after initialization.

	Consequently, the repository API has been simplified to remove all
	the `_openX` calls that allowed setting these subparts *before*
	initialization.

- git_index_read_tree()
	Git trees can now be read into the index.

- More reflog functionality
	The reference log has been optimized, and new API calls to rename
	and delete the logs for a reference have been added.

- Rewrite of the References code with explicit ownership semantics
	The references code has been mostly rewritten to take into account
	the cases where another Git application was modifying a repository's
	references while the Library was running.

	References are now explicitly loaded and free'd by the user, and
	they may be reloaded in the middle of execution if the user suspects
	that their values may have changed on disk. Despite the new
	ownership semantics, the references API stays the same.

- Simplified the Remotes API
	Some of the more complex Remote calls have been refactored into
	higher level ones, to facilitate the usual `fetch` workflow of a
	repository.

- Greatly improved thread-safety
	The library no longer has race conditions when loading objects from
	the same ODB and different threads at the same time. There's now
	full TLS support, even for error codes. When the library is built
	with `THREADSAFE=1`, the threading support must be globally
	initialized before it can be used (see `git_threads_init()`)

- Tree walking API
	A new API can recursively traverse trees and subtrees issuing callbacks for
	every single entry.

- Tree diff API
	There is basic support for diff'ing an index against two trees.

- Improved windows support
	The Library is now codepage aware under Windows32: new API calls
	allow the user to set the default codepage for the OS in order to
	avoid strange Unicode errors.
