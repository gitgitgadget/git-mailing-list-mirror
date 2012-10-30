From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 00/14] New remote-hg helper
Date: Tue, 30 Oct 2012 05:35:22 +0100
Message-ID: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:36:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3YX-0005SX-L7
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498Ab2J3Efr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:35:47 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab2J3Efq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:35:46 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2268812bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=8LiIlo200sVoznp1rf4E+ulNfmrkA384lw65xqKhpbQ=;
        b=VUAvYbnOUbK9PzQ7MdO98equoqqmrEcpkyNXGZg7AOpUuo2inFA1NyU7mHFCxVSVE4
         BoA7zDXGGSL71iX3e0sYsOwgnoimG7evNSs5EaU4blqMVxZWV7wkprFOdmxM/6LZOWlY
         tgCUkCr01k+l1QaMySRufy1oRc1YwNxSHn+J5BOAYi3walk/2hxiWQpudTw5Q1MRoBbj
         npfF7LUlaCkVPVpPsJk1DwAbhzbN2+y9mBUce9gJrQrnDKVOgS6KZzpcbquB6tx0mGLZ
         /whNMCNdBJfwmsgb6Vz38bjFH7XyXwEo6y8AxZgzrT4uF5wfeo31N7dIMJcSmTscgzDY
         CTjg==
Received: by 10.204.150.213 with SMTP id z21mr10111982bkv.45.1351571745099;
        Mon, 29 Oct 2012 21:35:45 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id ia2sm5165975bkc.11.2012.10.29.21.35.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:35:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208663>

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

To use it add it to your $PATH (e.g. ~/bin).

 % git clone hd:///full/path/or/url/to/hg/repo

To run the tests:

 % make -C contrib/remote-hg tests

The only caveat is that you need 'python' in your $PATH.

Changes since v4:

 * Add new simple biridectional tests (no need for hg-git)
 * Move tests to contrib directory
 * Add dependency checks to the tests
 * Trivial fixes

Changes since v3:

 * New extensive tests
 * Add compatibility mode with hg-git
 * Added support for boomkars
 * Add mercurial information to the git msg (branch, renames, extra, etc.)

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

Felipe Contreras (14):
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
  remote-hg: add biridectional tests
  remote-hg: add tests to compare with hg-git
  remote-hg: add extra author test

 contrib/remote-hg/Makefile       |  13 +
 contrib/remote-hg/git-remote-hg  | 773 +++++++++++++++++++++++++++++++++++++++
 contrib/remote-hg/test-hg-git.sh | 464 +++++++++++++++++++++++
 contrib/remote-hg/test.sh        | 241 ++++++++++++
 4 files changed, 1491 insertions(+)
 create mode 100644 contrib/remote-hg/Makefile
 create mode 100755 contrib/remote-hg/git-remote-hg
 create mode 100755 contrib/remote-hg/test-hg-git.sh
 create mode 100755 contrib/remote-hg/test.sh

-- 
1.8.0
