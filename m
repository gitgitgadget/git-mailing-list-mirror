From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 00/13] New remote-hg helper
Date: Sun, 28 Oct 2012 04:54:00 +0100
Message-ID: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 04:54:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSJxZ-0002qk-5Z
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 04:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714Ab2J1DyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 23:54:24 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38829 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab2J1DyY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 23:54:24 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1585004eek.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 20:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=WivNEAy7C6bzioBITj0X4nE01xGHfyBzJNAPahMcTyI=;
        b=pngbBv835cwWkpYTnIxg6vXjAd7KBZOy3dScpdEkL0UvRMqsF8t04OrEV3BdgXeqOX
         vgiXXkttRmTr9J5vXK0XJrx8lc1YkQg2iSg9X807PV9OWyXAQji4nV/Iv/BIaOqudSc5
         8aT7gA1PbSt64lQlnszfCXMChuuEMC5kMzS+/0/yFa0e/IlQz/TXN83DxjRUtiiFDl2G
         8SfdPn29XV8YpgXsuwSmMxPKss7iQBQhshx9vFCFCHqTmNEdombSs3qpl6aKz+ws7MB+
         G+hS7IKHd/8S33FvGwT4YhB7nUcx/3fQuQ7pHsmsFOUwTExHXktxB5tVTy1R+J6k910m
         ZDfg==
Received: by 10.14.194.71 with SMTP id l47mr47491771een.6.1351396462621;
        Sat, 27 Oct 2012 20:54:22 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id f3sm13220335eeo.13.2012.10.27.20.54.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 20:54:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208520>

Hi,

I've ported the tests from hg-git and made sure that the output from remote-hg
matches the output of hg-git. With these extensive tests I would consider this
one ready for wide use. Not only do the tests pass, I've compared the generated
repos of a few projects, and the SHA-1's are exactly the same :)

This remote-hg has advantages other tools don't have:

 * Uses transport-helper (git clone hg::path)
 * The code is small
 * The code is simple
 * No external dependencies (other than mercurial)
 * It's easy to install (put into your path)
 * Has extensive tests
 * Active development
 * Has compatibility with hg-git
 * The required patches are available
 * No changes necesary to git core

One important alternative is the one written by Sverre Rabbelier that is now
maintained and distributed in msysgit. It's hard to evaluate this option as
there isn't a branch specific to this remote helper so it would be possible to
evaluate the necessary patches.

Changes since v3:

 * New extensive tests
 * Add compatibility mode with hg-git
 * Added support for boomkars
 * Add mercurial information to the git msg (branch, renames, extra, etc.)
 * Properly handle HEAD
 * Fix author/committer information
 * Implement 'done' feature for error handling
 * Restore hg user properly
 * Set file correct modes
 * Match hg merge behavior
 * Prefix hg branches
 * Encoding fixes
 * Stricter parser
 * Support for 'reset' command
 * Fix support for URL pushing (unaliased)

Changes since v2:

 * Added support for pushing
 * Tests copied from original remote-hg
 * Custom default -> master renames removed
 * Code reorganized

Changes since v1:

 * Improved documentation
 * Use more common 'python' binary
 * Warn, don't barf when a branch has multiple heads
 * Fixed marks to fetch after cloned
 * Support for cloning/pulling remote repositories
 * Use a more appropriate internal directory (e.g. .git/hg/origin)
 * Fixes for python3

Felipe Contreras (13):
  Add new remote-hg transport helper
  remote-hg: add support for bookmarks
  remote-hg: add support for pushing
  remote-hg: add support for remote pushing
  remote-hg: add support to push URLs
  remote-hg: make sure the encoding is correct
  remote-hg: match hg merge behavior
  remote-hg: add support for hg-git compat mode
  remote-hg: add compat for hg-git author fixes
  remote-hg: fake bookmark when there's none
  remote-hg: add support for fake remote
  remote-hg: add tests to compare with hg-git
  remote-hg: add extra author test

 contrib/remote-hg/git-remote-hg | 770 ++++++++++++++++++++++++++++++++++++++++
 t/t5802-remote-hg-hg-git.sh     | 449 +++++++++++++++++++++++
 2 files changed, 1219 insertions(+)
 create mode 100755 contrib/remote-hg/git-remote-hg
 create mode 100755 t/t5802-remote-hg-hg-git.sh

-- 
1.8.0
