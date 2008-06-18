From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/4] Add 'core.fsyncobjectfiles' config option
Date: Wed, 18 Jun 2008 15:29:48 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Denis Bueno <dbueno@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 00:31:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K96Bs-0003KJ-Oe
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 00:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbYFRWas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 18:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755992AbYFRWar
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 18:30:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35637 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755785AbYFRWap (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 18:30:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5IMTo9b016976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jun 2008 15:29:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5IMTnY4024066;
	Wed, 18 Jun 2008 15:29:49 -0700
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.853 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85414>


So these four patches end up adding support for conditionally enabling 
fsync() on loose object creation in the .gitconfig file with something 
like

	[core]
		FsyncObjectFiles = true

which can be useful on filesystems that don't already guarantee data 
consistency for other reasons (whether due to ordered writes or due to 
full data journalling).

Actually, just the last one adds the fairly trivial feature, the three 
first patches are just cleanups of the config parsing that I needed in 
order to not gouge my eyes out when looking at the code. The config file 
parser is kind of ad-hoc and people have added more and more options to it 
without ever trying to clean it up, and I refuse to do that.

The full patch-series is

  Split up default "core" config parsing into helper routine
  Split up default "user" config parsing into helper routine
  Split up default "i18n" and "branch" config parsing into helper
    routines
  Add config option to enable 'fsync()' of object files

resulting in the following diffstat:

 Documentation/config.txt |    8 ++++
 cache.h                  |    1 +
 config.c                 |   82 ++++++++++++++++++++++++++++++++++-----------
 environment.c            |    1 +
 sha1_file.c              |    3 +-
 5 files changed, 74 insertions(+), 21 deletions(-)

and the patches themselves will follow..

			Linus
