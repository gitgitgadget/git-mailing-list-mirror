From: Brad King <brad.king@kitware.com>
Subject: [PATCH 0/2] Support relative .git file in a submodule
Date: Fri,  8 Jan 2010 17:36:46 -0500
Message-ID: <1262990208-15554-1-git-send-email-brad.king@kitware.com>
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 23:46:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTNao-0004Mp-QD
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 23:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158Ab0AHWqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 17:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754132Ab0AHWqA
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 17:46:00 -0500
Received: from public.kitware.com ([66.194.253.19]:44062 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014Ab0AHWp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 17:45:59 -0500
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jan 2010 17:45:59 EST
Received: by public.kitware.com (Postfix, from userid 5001)
	id 1C28817DCC; Fri,  8 Jan 2010 17:27:37 -0500 (EST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on public.kitware.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id 991CD17DBA;
	Fri,  8 Jan 2010 17:27:37 -0500 (EST)
Received: by hythloth (Postfix, from userid 1000)
	id 8F324CFFE9; Fri,  8 Jan 2010 17:36:48 -0500 (EST)
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136487>

While experimenting with submodules I discovered that if a submodule
has a .git file "symlink" with a relative path to the real submodule
repository then it cannot be added to the superproject:

$ git init
$ mkdir sub
$ cd sub
$ git init
$ mv .git .real
$ echo 'gitdir: .real' > .git
$ echo a > a
$ git add a
$ git commit -m a
$ cd ..
$ git add sub
fatal: Not a git repository: .real

This patch series adds a test demonstrating the problem, and then
fixes it.

Brad King (2):
  Test update-index for a gitlink to a .git file
  Handle relative paths in submodule .git files

 setup.c                         |   17 +++++++++++++++++
 t/t2104-update-index-gitfile.sh |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100755 t/t2104-update-index-gitfile.sh
