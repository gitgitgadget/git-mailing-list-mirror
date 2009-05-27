From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/7] Foreign VCS support
Date: Wed, 27 May 2009 14:15:22 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905271328160.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 20:16:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Nfi-0001Hm-Kl
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 20:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbZE0SP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 14:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933045AbZE0SPZ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 14:15:25 -0400
Received: from iabervon.org ([66.92.72.58]:46843 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932385AbZE0SPX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 14:15:23 -0400
Received: (qmail 18379 invoked by uid 1000); 27 May 2009 18:15:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 May 2009 18:15:22 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120086>

This is a newly-generated and reorganized replacement for db/foreign-scm. 
It applies to recent next.

I'd be particularly interested in feedback from people working on hg 
import/export programs, since that's probably a better user for this code 
than my p4 helper, and also doesn't rely on closed-source code.

The overall goal is to be able to configure a remote in some way and then 
use "git fetch/pull" and "git push" to interact with other version control 
systems, instead of having interface scripts with their own command lines, 
additional instructions, etc.

The main changes are:

 (1) The remote does not need to use a url for the location
 (2) The helper is rearranged to be able to do multiple operations in a 
     single execution, allowing it to keep a single open connection for 
     listing the refs and then fetching them.
 (3) There is some preliminary support for exporting data to the foreign 
     system.

Also, the p4 example helper is significantly more capable and efficient 
than the previously-posted one.

Daniel Barkalow (7):
  Add specification of git-vcs-* helper programs
  Use a function to determine whether a remote is valid
  Allow fetch to modify refs
  Allow programs to not depend on remotes having urls
  Add a config option for remotes to specify a foreign vcs
  Add a transport implementation using git-vcs-* helpers
  Implement git-vcs-p4

 Documentation/config.txt     |    4 +
 Documentation/git-vcs-p4.txt |   47 ++
 Documentation/git-vcs.txt    |   77 +++
 Makefile                     |   24 +
 builtin-clone.c              |    6 +-
 builtin-fetch.c              |   19 +-
 builtin-ls-remote.c          |    4 +-
 builtin-push.c               |   54 ++-
 remote.c                     |   15 +-
 remote.h                     |    2 +
 transport-foreign.c          |  200 +++++++
 transport.c                  |   25 +-
 transport.h                  |   44 ++-
 vcs-p4/p4client-api.cc       |  455 +++++++++++++++
 vcs-p4/p4client.c            |  158 ++++++
 vcs-p4/p4client.h            |   74 +++
 vcs-p4/vcs-p4.c              | 1246 ++++++++++++++++++++++++++++++++++++++++++
 vcs-p4/vcs-p4.h              |  135 +++++
 18 files changed, 2545 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/git-vcs-p4.txt
 create mode 100644 Documentation/git-vcs.txt
 create mode 100644 transport-foreign.c
 create mode 100644 vcs-p4/p4client-api.cc
 create mode 100644 vcs-p4/p4client.c
 create mode 100644 vcs-p4/p4client.h
 create mode 100644 vcs-p4/vcs-p4.c
 create mode 100644 vcs-p4/vcs-p4.h
