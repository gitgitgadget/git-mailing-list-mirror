From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH v2 0/1] git-svn: testcase for partial rebuild
Date: Sat, 20 Sep 2008 22:45:38 -0400
Message-ID: <20080921024538.GB2505@riemann.deskinm.fdns.net>
References: <20080917031304.GA2505@riemann.deskinm.fdns.net> <20080918063754.GA13328@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Sep 21 04:47:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhEz9-00059b-Ei
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 04:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbYIUCqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 22:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbYIUCqO
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 22:46:14 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:4391 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbYIUCqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 22:46:13 -0400
Received: by an-out-0708.google.com with SMTP id d40so87203and.103
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 19:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=ib7QzTaavyPnoCFQZwWkWC2leOZeTENSTk7a6/ZQcuk=;
        b=lRciq1E4RXJiLM7LhhH49GWdmixFs5qhP7cG691etOV3k6I/vZtGDG5joXMI2MRpqj
         8ue+iKgucsp1Nmq694CR6ASuwBMJC80pKyHxwlgBK9Zfi63YfFWUF7W3PKiGiVogIkqM
         5Fq0PJWFYSRIg2RjubQ6goV87Ne5oFfbT807o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Vq13wTE9lG8lhIFp10vWlOsfW0bFNQo9u4T36A8axJ1L2vIRBP11p4uhcyT60/wEDp
         4LB3/fL21AtVJ72ZM3qJCO8KMZYObOga9dCBPtAAuBdBVG57ulycAr7xRvJpzjCBgr7E
         gwKyfuOujcz+WHuLJwq3KDDv3tAvJS9dHE168=
Received: by 10.64.10.2 with SMTP id 2mr3710841qbj.80.1221965171643;
        Sat, 20 Sep 2008 19:46:11 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ( [68.40.49.130])
        by mx.google.com with ESMTPS id 12sm3356619qbw.2.2008.09.20.19.46.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 19:46:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080918063754.GA13328@untitled>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96380>

>From 45c9876a04ff0aac141300dd10fca50d6db30522 Mon Sep 17 00:00:00 2001
From: Deskin Miler <deskinm@umich.edu>
Date: Thu, 18 Sep 2008 17:55:14 -0400

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
On Wed, Sep 17, 2008 at 11:38:04PM -0700, Eric Wong wrote:
> This seems to break the following test case for me:
> 
> *** t9107-git-svn-migrate.sh ***
> *   ok 1: setup old-looking metadata
> *   ok 2: git-svn-HEAD is a real HEAD
> *   ok 3: initialize old-style (v0) git svn layout
> *   ok 4: initialize a multi-repository repo
> *   ok 5: multi-fetch works on partial urls + paths
> *   ok 6: migrate --minimize on old inited layout
> * FAIL 7: .rev_db auto-converted to .rev_map.UUID
> 
> I haven't had time to diagnose it.  Also, can you add a test that
> demonstrates this functionality (and ensures things keeps working when
> future work is done on git-svn?)

Thanks for the response; I had a bug in my Perl that my testing hadn't caught.
Gave me an opportunity to learn how the git testsuites work!

This testcase fails for me when applied to master, and passes with patch 1/1 in
the series.

 t/t9126-git-svn-partial-rebuild.sh |   53 ++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)
 create mode 100755 t/t9126-git-svn-partial-rebuild.sh

diff --git a/t/t9126-git-svn-partial-rebuild.sh b/t/t9126-git-svn-partial-rebuild.sh
new file mode 100755
index 0000000..9a94866
--- /dev/null
+++ b/t/t9126-git-svn-partial-rebuild.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Deskin Miller
+#
+
+test_description='git svn partial-rebuild tests'
+. ./lib-git-svn.sh
+
+test_expect_success \
+    'initialize svnrepo' '
+	mkdir import &&
+	cd import &&
+	mkdir trunk branches tags &&
+	cd trunk &&
+	echo foo > foo &&
+	cd .. &&
+	svn import -m "import for git-svn" . "$svnrepo" >/dev/null &&
+	svn copy "$svnrepo"/trunk "$svnrepo"/branches/a \
+		-m "created branch a" &&
+	cd .. &&
+	rm -rf import &&
+	svn co "$svnrepo"/trunk trunk &&
+	cd trunk &&
+	echo bar >> foo &&
+	svn ci -m "updated trunk" &&
+	cd .. &&
+	svn co "$svnrepo"/branches/a a &&
+	cd a &&
+	echo baz >> a &&
+	svn add a &&
+	svn ci -m "updated a" &&
+	cd .. &&
+	git svn init --stdlayout "$svnrepo"'
+
+test_expect_success 'import an early SVN revision into git' \
+	'git svn fetch -r1:2'
+
+test_expect_success 'make full git mirror of SVN' \
+	'mkdir mirror &&
+	cd mirror &&
+	git init &&
+	git svn init --stdlayout "$svnrepo" &&
+	git svn fetch &&
+	cd ..'
+
+test_expect_success 'fetch from git mirror and partial-rebuild' \
+	'git config --add remote.origin.url "file://$PWD/mirror/.git" &&
+	git config --add remote.origin.fetch refs/remotes/*:refs/remotes/* &&
+	git fetch origin &&
+	git svn fetch
+	'
+
+test_done
-- 
1.6.0.2.GIT
