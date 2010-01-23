From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 0/2] two git-svn changes to help work with chromium.org
Date: Sat, 23 Jan 2010 03:29:59 -0500
Message-ID: <1264235401-44051-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 09:36:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYbTq-00073v-JQ
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 09:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab0AWIgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 03:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630Ab0AWIgY
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 03:36:24 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:34281 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab0AWIgX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 03:36:23 -0500
Received: by yxe17 with SMTP id 17so1664973yxe.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 00:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=yk8/fDnw5W3Gj+5DGLxp66PeG7tcVYFQ17rCJsDw2yM=;
        b=RqsvY9kZWiEdeF5K9UHOzlOaLX257UNPWk/58pZxKlo895mLX7HaTwX12fe45cPuI1
         C/tzdPTqEkPHbb1pjv7KI8TXJRg72TOoyNuLi55GbNlTmcrTqXKrhL9YswgRfrr0XxrZ
         HymvEYqhfAb7V1kj5PzGF9g/XQMQe/wxNu9WU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CT47vT64L1Agvl+YIr03SlMcQ4HUYlrXhtU14qq3nfGkmW+CgGqCIyEM+QcqhvItb/
         O6+YK4124tptKhxGYP+84eKJqPG2M5gWzcQStMLadKclzIQHNklgm6khxuQv0snZR0pZ
         cPI3ezXBVi5az4b0Qyh6Y+1FGueOj22gVNNAg=
Received: by 10.91.19.17 with SMTP id w17mr3714478agi.54.1264235427351;
        Sat, 23 Jan 2010 00:30:27 -0800 (PST)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id 16sm1749962gxk.11.2010.01.23.00.30.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 00:30:26 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1.515.g288caf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137816>

Google nicely mirrors the subversion chrome repository with git-svn. However,
the git-svn mirror has only trunk. I wanted to add in a couple other branches
to my clone of the git-svn mirror, but to do so I needed the ability to lie
about the UUID since the publically accessible subversion repository has a
different UUID than that which google is cloning from using git-svn.

In addition, google has a ton of branches in the subversion repository, and
I only wanted a few. Hence this two-patch series. For posterity, here's what
my .git/config looks like:

[remote "origin"]
	url = git://git.chromium.org/chromium.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[svn-remote "svn"]
	url = http://src.chromium.org/svn
	fetch = trunk/src:refs/remotes/svn/trunk
	branches = branches/{249,302}/src:refs/remotes/svn/*
	rewriteRoot = svn://svn.chromium.org/chrome
	rewriteUUID = 0039d316-1c4b-4281-b951-d872f2087c98

Jay Soffian (2):
  git-svn: allow UUID to be manually remapped via rewriteUUID
  git-svn: allow subset of branches/tags to be specified in glob spec

 Documentation/git-svn.txt       |   31 +++++-
 git-svn.perl                    |   93 ++++++++++++-----
 t/t9153-git-svn-rewrite-uuid.sh |   25 +++++
 t/t9153/svn.dump                |   75 +++++++++++++
 t/t9154-git-svn-fancy-glob.sh   |   42 ++++++++
 t/t9154/svn.dump                |  222 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 460 insertions(+), 28 deletions(-)
 create mode 100755 t/t9153-git-svn-rewrite-uuid.sh
 create mode 100644 t/t9153/svn.dump
 create mode 100755 t/t9154-git-svn-fancy-glob.sh
 create mode 100644 t/t9154/svn.dump
