From: David Barr <david.barr@cordelta.com>
Subject: vcs-svn: integrate support for text deltas
Date: Sat, 19 Mar 2011 18:20:38 +1100
Message-ID: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:21:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qTf-0007RX-SE
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395Ab1CSHVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:21:19 -0400
Received: from [119.15.97.146] ([119.15.97.146]:65527 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752574Ab1CSHVS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 79978C05E;
	Sat, 19 Mar 2011 18:17:44 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oBqabuO+ljhO; Sat, 19 Mar 2011 18:17:42 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 17C9AC040;
	Sat, 19 Mar 2011 18:17:42 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169396>

This series is largely the work of Jonathan Nieder.
I have painstakingly ported it from the old development branch to the
latest series to hit the list. As previously, I have tested against
the ASF subversion repository to increase confidence in the series.
Hopefully, this brings us a little closer to having full support for
version 3 of the subversion dump format in master.


 Makefile                  |    5 +-
 contrib/svn-fe/svn-fe.txt |    5 +-
 t/t9010-svn-fe.sh         |  108 ++++++++++++++++-
 t/t9011-svn-da.sh         |  250 ++++++++++++++++++++++++++++++++++++
 test-svn-fe.c             |   42 +++++--
 vcs-svn/LICENSE           |    2 +
 vcs-svn/fast_export.c     |  122 +++++++++++++++++-
 vcs-svn/fast_export.h     |    3 +
 vcs-svn/line_buffer.c     |   37 +++---
 vcs-svn/line_buffer.h     |    7 +-
 vcs-svn/line_buffer.txt   |    3 +-
 vcs-svn/sliding_window.c  |   74 +++++++++++
 vcs-svn/sliding_window.h  |   17 +++
 vcs-svn/svndiff.c         |  308 +++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndiff.h         |   10 ++
 vcs-svn/svndump.c         |   35 ++++-
 16 files changed, 980 insertions(+), 48 deletions(-)
