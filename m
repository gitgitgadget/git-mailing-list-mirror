From: Michal Ostrowski <mostrows@watson.ibm.com>
Subject: [PATCH 0/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Mon, 09 Jan 2006 18:34:37 -0500
Message-ID: <1136849678.11717.514.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Michal Ostrowski <mostrows@watson.ibm.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 00:33:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew6Vn-0001NB-1Z
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 00:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWAIXdM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 18:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWAIXdM
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 18:33:12 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:34963 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1751184AbWAIXdM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 18:33:12 -0500
Received: from sp1n294en1.watson.ibm.com (sp1n294en1.watson.ibm.com [129.34.20.40])
	by igw2.watson.ibm.com (8.12.11/8.13.1/8.13.1-2005-04-25 igw) with ESMTP id k09NZHaF022546
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 18:35:17 -0500
Received: from sp1n294en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with ESMTP id k09NX4c355500
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 18:33:04 -0500
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with ESMTP id k09NX3s387364
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 18:33:03 -0500
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id k0A0Tqdw003576
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 19:29:52 -0500
Received: from brick (brick.watson.ibm.com [9.2.216.48])
	by kitch0.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP id k09NX2m30046;
	Mon, 9 Jan 2006 18:33:02 -0500
To: git@vger.kernel.org
X-Mailer: Evolution 2.4.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14385>

I've been trying to setup a git repository for access via ssh, on a
system where git is to be installed under ~user/bin, and ~user/bin is
not included in the PATH that sshd provides.

Consequently I need to execute something like:

git-clone -u /home/user/bin/git-upload-pack \
ssh://user@system/home/user/repo.git repo

When git-upload-pack executes on the remote system, it tries to execute
git-rev-list and fails, since /home/user/bin is not in the path.

The following patches handle this issue by appending GIT_EXEC_PATH to
PATH prior to exec calls (via git_setup_exec_path()).  Also, the value
of ${bindir} at build time is encoded and used as a default value for
"GIT_EXEC_PATH", if the latter is not present. 


-- 
Michal Ostrowski <mostrows@watson.ibm.com>
