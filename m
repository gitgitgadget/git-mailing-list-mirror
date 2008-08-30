From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 0/8] Add mergetool functionality to git-gui.
Date: Sun, 31 Aug 2008 00:52:21 +0400
Organization: TEPKOM
Message-ID: <200808310052.21595.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 23:15:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXn7-0007ux-Dq
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 23:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbYH3VO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 17:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755388AbYH3VO0
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 17:14:26 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:57628 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbYH3VOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 17:14:25 -0400
Received: by fk-out-0910.google.com with SMTP id 18so883437fkq.5
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8JKMBUtMgHmdmXgq9wNjQKRuDVuCiA+T1Aoah8/AThw=;
        b=Xv+pg4Da8FlJwkgZ09wP29mHBGG8st/Q4fuGTEPLRP3YrfmmVqpQ5uqE3aNUbbelB0
         gVT7L1Hq+3NybfqQ6F3xCCLcYtTKQjiVVX5vip3vCCyRkSMEnKjBOZe9CuNsnIECHXm6
         3Hau5sz8jPOhLCst0EuTp0trfdmGN7q0tuMXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=XKKtPfBS2z62wZV1GSwgsg1Bt8KE8HM7DWYVxGJOHNHj1ShMxafC4gy6ClLuisBNqn
         iABKQUiZhpgrtgcIpncSe/N0Tijpds4HKMtBqKNzu2XS03PUUAkuIxlz9/qwVjnyj+pN
         crvgOdcZX/s7ejIjjCXarUy2ko+B3R+wNU25g=
Received: by 10.180.221.13 with SMTP id t13mr4134361bkg.19.1220130863089;
        Sat, 30 Aug 2008 14:14:23 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id d13sm4092560fka.3.2008.08.30.14.14.21
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 14:14:22 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94425>

The original git-mergetool program is intended to be used from
the command line, and thus does not integrate well with GUI
usage. For instance, it presents the user with its own interactive
interface, based on text-mode prompts.

This series implements mergetool functionality within git-gui,
replacing the default 'Stage Hunk/Line' context menu items
for unresolved files with conflict resolution commands.

It also enhances auto-selection behavior to minimize the
necessary number of clicks on the items of the file lists,
and adds special handling of diffs for conflicts involving
deletion or symlinks.


Custom merge tools are not supported as I'm not sure of
the best way to evaluate command line patterns that are
intended for the shell from Tcl.



PATCHES:

	git-gui: Don't allow staging files with conflicts.
	---
	 git-gui.sh |    8 ++++++++
	 1 files changed, 8 insertions(+), 0 deletions(-)

	git-gui: Support resolving conflicts via the diff context menu.
	---
	 git-gui.sh        |  152 ++++++++++++++++++++++++++++++++---------------------
	 lib/mergetool.tcl |   98 ++++++++++++++++++++++++++++++++++
	 2 files changed, 190 insertions(+), 60 deletions(-)
	 create mode 100644 lib/mergetool.tcl

	git-gui: Support calling merge tools.
	---
	 git-gui.sh        |    7 ++
	 lib/mergetool.tcl |  252 +++++++++++++++++++++++++++++++++++++++++++++++++++++
	 lib/option.tcl    |    1 +
	 3 files changed, 260 insertions(+), 0 deletions(-)

	git-gui: Support more merge tools.
	---
	 lib/mergetool.tcl |   27 +++++++++++++++++++++++++++
	 1 files changed, 27 insertions(+), 0 deletions(-)

	git-gui: Support conflict states _U & UT.
	---
	 git-gui.sh     |    6 ++++--
	 lib/commit.tcl |    1 +
	 lib/diff.tcl   |    2 +-
	 lib/index.tcl  |    1 +
	 4 files changed, 7 insertions(+), 3 deletions(-)

	git-gui: Reimplement and enhance auto-selection of diffs.
	---
	 git-gui.sh        |  122 +++++++++++++++++++++++++++++++++++++++++------------
	 lib/diff.tcl      |   18 +++++---
	 lib/mergetool.tcl |    8 +---
	 3 files changed, 109 insertions(+), 39 deletions(-)

	git-gui: Make F5 reselect a diff, if an untracked file is selected.
	---
	 git-gui.sh |   44 +++++++++++++++++++++++++++++++++++---------
	 1 files changed, 35 insertions(+), 9 deletions(-)

	git-gui: Show special diffs for complex conflict cases.
	---
	 lib/diff.tcl |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
	 1 files changed, 89 insertions(+), 5 deletions(-)
