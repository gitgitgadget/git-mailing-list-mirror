From: Matt McCutchen <matt@mattmccutchen.net>
Subject: StGIT: Trouble adding files to non-topmost patch
Date: Thu, 07 Feb 2008 23:30:24 -0500
Message-ID: <1202445024.27753.54.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 05:33:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNKvB-0003at-FA
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 05:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760368AbYBHEcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Feb 2008 23:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760329AbYBHEcc
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 23:32:32 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:33498 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756544AbYBHEcb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 23:32:31 -0500
Received: from jankymail-a4.g.dreamhost.com (mailbigip.dreamhost.com [208.97.132.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 169AA17804A
	for <git@vger.kernel.org>; Thu,  7 Feb 2008 20:32:31 -0800 (PST)
Received: from [129.2.207.162] (xkfjemhv.student.umd.edu [129.2.207.162])
	by jankymail-a4.g.dreamhost.com (Postfix) with ESMTP id E92321810F6;
	Thu,  7 Feb 2008 20:30:27 -0800 (PST)
X-Mailer: Evolution 2.21.3 (2.21.3-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73034>

I keep a copy of the Eclipse source code checked out from CVS, and I us=
e
StGIT to manage both long-term and short-term local changes to the
source.  (StGIT is so much nicer than shuffling patches by hand!)  My
StGIT patch stack is based on an empty tree; the bottom-most patch
(named "origin") contains the original Eclipse source and the others
contain my changes.  I use "cvs up" to pull updates from Eclipse's
repository, a custom script to load the updates into the git index, and
"stg refresh -p origin" to load them into the patch stack.

However, when the Eclipse developers create new files, I can't seem to
add them to "origin" this way.  After my index-updating script runs,
"git status" shows that the new files have been added to the index,
but =EF=BB=BF"stg refresh -p origin" doesn't change "origin" and the ne=
w files
show as untracked again.  Some investigation revealed that the problem
is that, whenever StGIT pops a patch (including as part of "stg refresh
-p"), it resets the index.  Here's the relevant code in git.py:

        def switch(tree_id, keep =3D False):
            """Switch the tree to the given id
            """
            if keep:
                # only update the index while keeping the local changes
                GRun('read-tree', tree_id).run()

This behavior doesn't affect changes and deletions since StGIT
automatically adds them back to the index, but it completely controvert=
s
additions.  Please provide a direct way to add files to non-topmost
patches.

One could argue that my setup is bad.  I could work around the problem
by loading updates using a separate tree holding a clean CVS checkout,
but then it is less convenient to check out additional modules.  I coul=
d
download and import the entire CVS history with git-cvsimport, but that
would take an enormous amount of time and disk space.  I'm open to
practical suggestions for a better setup, but I do hope the problem wit=
h
StGIT gets fixed.

[I am off-list; please include me in replies.]

Matt
