From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Wed, 18 Apr 2007 17:04:13 -0700
Message-ID: <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
	<7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 02:04:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeK8K-0000Dz-KI
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 02:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbXDSAEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 20:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbXDSAEQ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 20:04:16 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:43843 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030503AbXDSAEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 20:04:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070419000414.OJEU1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 20:04:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id oo4D1W01N1kojtg0000000; Wed, 18 Apr 2007 20:04:14 -0400
X-master-at: 6fb8e8f401a065bdffe379764871551e37a041a0
X-next-at: 53e3da1b9c669cf957b505aa70b61b603cfad345
In-Reply-To: <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 15 Apr 2007 18:53:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44968>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* np/pack (Mon Apr 16 12:32:13 2007 -0400) 25 commits
 + pack-objects: better check_object() performances
 + add get_size_from_delta()
 + pack-objects: make in_pack_header_size a variable of its own
 + pack-objects: get rid of create_final_object_list()
 + pack-objects: get rid of reuse_cached_pack
 + pack-objects: clean up list sorting
 + pack-objects: rework check_delta_limit usage
 + pack-objects: equal objects in size should delta against newer
   objects
 + pack-objects: optimize preferred base handling a bit
 + clean up add_object_entry()
 + tests for various pack index features
 + use test-genrandom in tests instead of /dev/urandom
 + simple random data generator for tests
 + validate reused pack data with CRC when possible
 + allow forcing index v2 and 64-bit offset treshold
 + pack-redundant.c: learn about index v2
 + show-index.c: learn about index v2
 + sha1_file.c: learn about index version 2
 + index-pack: learn about pack index version 2
 + pack-objects: learn about pack index version 2
 + compute object CRC32 with index-pack
 + compute a CRC32 for each object as stored in a pack
 + add overflow tests on pack offset variables
 + make overflow test on delta base offset work regardless of
   variable size
 + get rid of num_packed_objects()

Nico's "optionally 64-bit pack idx" aka idx format version 2.
I've taken another pass at them and am planning to push them out
on 'master' hopefully this weekend, but a documentation update
that mention the new --index-version option to git-pack-objects
would be nice to have before that happens.

* lt/objalloc (Mon Apr 16 22:13:09 2007 -0700) 3 commits
 - Make the object lookup hash use a "object index" instead of a
   pointer
 + Clean up object creation to use more common code
 + Use proper object allocators for unknown object nodes too

The bottom 2 are genuine clean-ups, and I'd like to push them
out to 'master' this weekend after giving them one last look.

* jc/attr (Wed Apr 18 16:16:37 2007 -0700) 19 commits
 + Fix funny types used in attribute value representation
 + Allow low-level driver to specify different behaviour during
   internal merge.
 + Custom low-level merge driver: change the configuration scheme.
 + Allow the default low-level merge driver to be configured.
 + Custom low-level merge driver support.
 + Add a demonstration/test of customized merge.
 + Allow specifying specialized merge-backend per path.
 + merge-recursive: separate out xdl_merge() interface.
 + Allow more than true/false to attributes.
 + Document git-check-attr
 + Change attribute negation marker from '!' to '-'.
 + Define a built-in attribute macro "binary".
 + attribute macro support
 + Makefile: add patch-ids.h back in.
 + Fix 'diff' attribute semantics.
 + Fix 'crlf' attribute semantics.
 + Teach 'diff' about 'diff' attribute.
 + Define 'crlf' attribute.
 + Add basic infrastructure to assign attributes to paths

You've heard a lot of noises between me and Linus on this one
for the past few days.  Remaining tasks before it can graduate
to 'master' are:

 (1) I haven't decided how to allow the merge driver override
     the decision to punt on symlinks and some other minor
     policy decision merge-recursive hardcodes yet;

 (2) Not enough test coverage;

 (3) No documentation other than my e-mail messages to the list
     and commit log messages as to how you use this stuff;

 (4) Example "low level merge driver" scripts; covering the same
     set of tools git-mergetool knows about would be good.

Help from the list, probably starting from (3) and (4), would
help polish the series and squash any remaining bugs.

We could do $blobid$ only keywords by hooking into this, but
that would involve philosophical discussion and I'd rather
postpone that and have the infrastructure in 'master' first.

* jp/refs (Tue Apr 17 02:42:50 2007 +0100) 1 commit
 + refs.c: add a function to sort a ref list, rather then sorting on
   add
* jc/quickfetch (Mon Apr 16 00:42:29 2007 -0700) 3 commits
 + Make sure quickfetch is not fooled with a previous, incomplete
   fetch.
 + git-fetch: use fetch--tool pick-rref to avoid local fetch from
   alternate
 + git-fetch--tool pick-rref

I think these two topics should graduate to 'master' this
weekend, as I haven't heard any breakage from anybody, and they
do seem to help.

* lt/gitlink (Sun Apr 15 11:14:28 2007 -0700) 17 commits
 + Expose subprojects as special files to "git diff" machinery
 + Fix some "git ls-files -o" fallout from gitlinks
 + Teach "git-read-tree -u" to check out submodules as a directory
 + Teach git list-objects logic to not follow gitlinks
 + Fix gitlink index entry filesystem matching
 + Teach "git-read-tree -u" to check out submodules as a directory
 + Teach git list-objects logic not to follow gitlinks
 + Don't show gitlink directories when we want "other" files
 + Teach git-update-index about gitlinks
 + Teach directory traversal about subprojects
 + Fix thinko in subproject entry sorting
 + Teach core object handling functions about gitlinks
 + Teach "fsck" not to follow subproject links
 + Add "S_IFDIRLNK" file mode infrastructure for git links
 + Add 'resolve_gitlink_ref()' helper function
 + Avoid overflowing name buffer in deep directory structures
 + diff-lib: use ce_mode_from_stat() rather than messing with modes
   manually

Stalled; Alex has a set of tests that should go on top of this
series but I haven't taken a look at it yet.  I think we should
have enough for interested people to start futzing with, and I
am wondering why nobody has sent a note saying "Hey, I did this
using tree objects with commits in it, it works nicely for these
operations but these things are still cumbersome to do and I
need to polish it more".

* jc/the-index (Sun Apr 1 23:26:07 2007 -0700) 2 commits
 - Make read-cache.c "the_index" free.
 - Move index-related variables into a structure.

A small part of libification; nobody seems to want it.

* jc/blame (Tue Mar 27 01:58:01 2007 -0700) 4 commits
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up
 - blame -s: suppress author name and time.

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

Stalled.
