From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Status of the svn remote helper project (Nov, 2010)
Date: Sun, 7 Nov 2010 05:21:29 -0600
Message-ID: <20101107112129.GA30042@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 07 12:35:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF3X1-0002VM-Pk
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 12:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482Ab0KGLVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 06:21:44 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35114 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab0KGLVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 06:21:42 -0500
Received: by iwn41 with SMTP id 41so2786192iwn.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 03:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=o+Mpye3YrYY8deSbSIcBbq5Avfk8ae4nCmLRh0BzIdw=;
        b=yBVquyhVRgPwLGmBQ5aykQhawp2TF/UOV3mMbpemS10iY3YP6m0O48ax44CFsjLajN
         PdEENB5mAwY4kItQuZR9abpWQqCg7gk079TBvLd4r7JB+BQmY7IPD2jB7MBrSUY9qC5d
         YkOMAGBuA27efeuS/rc4a+T91ivlYoi49EPf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=aQgakWuSDzBzWyS6UBlyBYybB/iHH1erKM0SCuzG6zRpnB/bomQw29Tzj4VdKjp74l
         Mhq3Xl9w5E8T1uCF4ktECHWU9O6rcLNeAAClawJNzjif71g4UhGPjcdS/4aAoglBLN8g
         ufBqxo20HMEYGUiVHu8NonTbnePVn0oMlhdkA=
Received: by 10.42.170.71 with SMTP id e7mr2659589icz.91.1289128901668;
        Sun, 07 Nov 2010 03:21:41 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id fw4sm4399245ibb.19.2010.11.07.03.21.39
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 03:21:40 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160875>

The svn remote helper project still has a long way to go.  In the
meantime, the svn-fe plumbing and Tomas's scripted prototype are
usable.

Here are some topics that might be roughly in their final form.  If
you would like to build on one of them, please let me know so I can
refrain from rewriting that piece of history.

A merge of these branches is available as

	git://repo.or.cz/git/jrn.git vcs-svn-pu

and individual topic branches are also available in that repository,
though for convenience they are not in the refs/heads namespace.

Thoughts and improvements welcome.

--------------------------------------------------
[Cooking]
* jn/svndiff0 (2010-11-06) 24 commits
 - vcs-svn: Allow deltas to copy from preimage
 - vcs-svn: Reject deltas that read past end of preimage
 - vcs-svn: Let deltas use data from postimage
 - vcs-svn: Reject deltas that do not consume all inline data
 - vcs-svn: Check declared number of output bytes
 - vcs-svn: Implement copyfrom_data delta instruction
 - vcs-svn: Read instructions from deltas
 - vcs-svn: Read inline data from deltas
 - vcs-svn: Read the preimage while applying deltas
 - vcs-svn: Skeleton of an svn delta parser
 - compat: helper for detecting unsigned overflow
 - vcs-svn: Learn to check for SVN\0 magic
 - vcs-svn: Learn to parse variable-length integers
 - vcs-svn: Add code to maintain a sliding view of a file
 - vcs-svn: Allow character-oriented input
 - vcs-svn: Allow input errors to be detected early
 - vcs-svn: Let callers peek ahead to find stream end
 - vcs-svn: Add binary-safe read() function
 - vcs-svn: Improve support for reading large files
 - vcs-svn: Make buffer_skip_bytes() report partial reads
 - vcs-svn: Teach line_buffer to handle multiple input files
 - vcs-svn: Collect line_buffer data in a struct
 - vcs-svn: Replace buffer_read_string() memory pool with a strbuf
 - vcs-svn: Eliminate global byte_buffer[] array

An SVN-format delta applier.  Seems okay, but it has not been heavily
exercised with real-world deltas.

* db/fast-import-cat-blob (2010-11-07) 3 commits
 - fast-import: let importers retrieve blobs
 - fast-import: clarify documentation of "feature" command
 - fast-import: stricter parsing of integer options

As David says: "it has some significant consequences".

A start for bi-directional communication with fast-import (needed by
svn-fe to avoid keeping its own database of blobs).  Seems to be in
okay shape.

* db/svn-fe-dumpfile3 (2010-11-07) 6 commits
 - vcs-svn: apply node text deltas
 - Merge branch 'jn/svndiff0' into db/svn-fe-dumpfile3
 - Merge branch 'db/fast-import-cat-blob' into db/svn-fe-dumpfile3
 - vcs-svn: Add output file param to buffer_copy_bytes()
 - vcs-svn: Find basis for deltified nodes; apply node prop deltas
 - vcs-svn: Teach dump parser about new header types
 (this branch uses jn/svndiff0 and db/fast-import-cat-blob.)

Adding support for dumpfiles with deltas (which is pretty close to
what the ra protocol sends over the wire) to svn-fe.

The tip commit could use some cleaning up.

* rr/svnfe-tests-no-perl (2010-11-07) 1 commit
 - t9010 (svn-fe): Eliminate dependency on svn perl bindings

Ejected from the jn/svndiff0 topic.  A noninvasive simplification;
what more could one ask for?

* jn/wrappers-no-libz (2010-11-06) 7 commits
 - Remove pack file handling dependency from wrapper.o
 - pack-objects: mark file-local variable static
 - wrapper: give zlib wrappers their own translation unit
 - strbuf: move strbuf_branchname to sha1_name.c
 - path helpers: move git_mkstemp* to wrapper.c
 - wrapper: move odb_* to environment.c
 - wrapper: move xmmap() to sha1_file.c

Approach seems reasonable.  More eyes on the tip commit would
be comforting.

* xx/wrappers-no-libz-svndiff0 (2010-11-07) 2 commits
 - svn-fe: stop linking to libz and libxdiff
 - Merge branch 'jn/svndiff0' into xx/wrappers-no-libz-svndiff0
 (this branch uses jn/wrappers-no-libz and jn/svndiff0.)

Example application of the jn/wrappers-no-libz topic.

--------------------------------------------------
[Not picked up yet]

* db/branch-mapper: $gmane/158375
 . contrib/svn-fe: Fast script to remap svn history

Could use a usage example (perhaps a test script).

* tc/remote-helper-usability: $gmane/157860
 . Register new packs after the remote helper is done fetching
 . Properly record history of the notes ref
 . Fix ls-remote output when displaying impure refs
 . Add git-remote-svn
 . Introduce the git fast-import-helper
 . Rename get_mode() to decode_tree_mode() and export it
 . Allow the transport fetch command to add additional refs
 . Allow more than one keepfile in the transport
 . Remote helper: accept ':<value> <name>' as a response to 'list'

The fourth-from-top seems a bit hard to review.  If it really is
necessary to introduce a separate program with a separate interface,
maybe a compile-time flag to choose between them would help?

* rr/remote-helper: http://github.com/artagnon/git
 . remote-svn: Write in fetch functionality
 . run-command: Protect the FD 3 from being grabbed
 . remote-svn: Build a pipeline for the import using svnrdump
 . run-command: Extend child_process to include a backchannel FD
 . Allow the transport fetch command to add additional refs
 . Remote helper: accept ':<value> <name>' as a response to 'list'
 . test-svn-fe: Allow for a dumpfile on stdin
 . contrib/svn-fe: Fast script to remap svn history
 . Add Tom's remote helper for reference
 . Add a stubby remote-svn remote helper
 . Add a correct svndiff applier

Work in progress, waiting on lower levels to be more functional
(in particular, svn-fe does not support incremental imports yet).

* sb/svn-fe-example: $gmane/159054

--------------------------------------------------
[Design note (vaporware)]

See $gmane/157141 for some hints about implementing incremental
imports.

$gmane means http://thread.gmane.org/gmane.comp.version-control.git
