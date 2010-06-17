From: Cesar Crusius <cesar@cariden.com>
Subject: [BUG] Using git-completion with automounted home directories causes
 bogus NFS mount requests
Date: Thu, 17 Jun 2010 19:32:09 +0000
Message-ID: <B0356A858DE69744B8977A67332BFB2C1FE9CDAD@dc1.mv.cariden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 17 21:37:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPKtx-0005yb-Jh
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 21:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760668Ab0FQThU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 15:37:20 -0400
Received: from mail.cariden.com ([204.2.128.131]:52369 "EHLO mail.cariden.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760572Ab0FQThT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 15:37:19 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jun 2010 15:37:19 EDT
Received: from dc1.mv.cariden.com ([172.16.0.6]) by dc1.mv.cariden.com
 ([172.16.0.6]) with mapi; Thu, 17 Jun 2010 12:32:10 -0700
Thread-Topic: [BUG] Using git-completion with automounted home directories
 causes bogus NFS mount requests
Thread-Index: AcsOU8chQA4/Oxs1TvCvf90FX6ppUA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149323>

Hi all,

I have tried this with various versions of .git-completion, including the most recent one as of today, and whenever I have __git_ps1 in my bash prompt, I get messages like this:

Jun 17 12:05:14 sunray automountd[471]: [ID 834250 daemon.error] Mount of <server>:/export/home/.git on /home/.git: No such file or directory
Jun 17 12:05:14 sunray automountd[471]: [ID 834250 daemon.error] Mount of <server>:/export/home/objects on /home/objects: No such file or directory

on /var/adm/messages every time a prompt is printed from the home directory (~). When I am in any subdirectory of ~ this does not happen.

This is probably a result of git/git-completion trying to access the directories above, and automount trying to get them from the server (we're in an NFS home environment, with wildcard automounts in auto_home).

- Cesar