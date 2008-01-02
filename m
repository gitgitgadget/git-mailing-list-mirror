From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove duplication in t9119-git-svn-info.sh
Date: Wed, 02 Jan 2008 02:27:24 -0800
Message-ID: <7vodc4y12r.fsf@gitster.siamese.dyndns.org>
References: <7vodc65whw.fsf@gitster.siamese.dyndns.org>
	<1199143999-6859-1-git-send-email-ddkilzer@kilzer.net>
	<20080102034317.GB11711@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jan 02 11:28:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA0pO-0004Rg-GU
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 11:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936AbYABK1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 05:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755616AbYABK1e
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 05:27:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbYABK1d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 05:27:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B5B53A386;
	Wed,  2 Jan 2008 05:27:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DE44FA36F;
	Wed,  2 Jan 2008 05:27:26 -0500 (EST)
In-Reply-To: <20080102034317.GB11711@untitled> (Eric Wong's message of "Tue, 1
	Jan 2008 19:43:17 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69469>

Eric Wong <normalperson@yhbt.net> writes:

> Nevertheless, does your change make things work with older
> versions of SVN?  I'm running 1.4.x everywhere these days, but
> I seem to recall the version of SVN on kernel.org was giving
> Junio trouble with the tests.

Ahh, you are right.  Here is what I am getting.

$ sh t9119-git-svn-info.sh -i -v
* expecting success: 
	mkdir info &&
	cd info &&
		echo FIRST > A &&
		echo one > file &&
		ln -s file symlink-file &&
		mkdir directory &&
		touch directory/.placeholder &&
		ln -s directory symlink-directory &&
		svn import -m 'initial' . file:///home/junio/git/t/trash/svnrepo &&
	cd .. &&
	mkdir gitwc &&
	cd gitwc &&
		git-svn init file:///home/junio/git/t/trash/svnrepo &&
		git-svn fetch &&
	cd .. &&
	svn co file:///home/junio/git/t/trash/svnrepo svnwc &&
	ptouch file &&
	ptouch directory &&
	ptouch symlink-file &&
	ptouch symlink-directory
	
Adding         file
Adding         A
Adding         symlink-file
Adding         directory
Adding         directory/.placeholder
Adding         symlink-directory

Committed revision 1.
Initialized empty Git repository in .git/
	A	file
	A	A
	A	symlink-file
	A	directory/.placeholder
	A	symlink-directory
r1 = 153bc4aeb5ed1375deb17b3611c1d2177ff2e5a4 (git-svn)
Checked out HEAD:
  file:///home/junio/git/t/trash/svnrepo r1
A    svnwc/file
A    svnwc/A
A    svnwc/symlink-file
A    svnwc/directory
A    svnwc/directory/.placeholder
A    svnwc/symlink-directory
Checked out revision 1.
*   ok 1: setup repository and import

* expecting success: 
	(cd svnwc; svn info) > expected.info &&
	(cd gitwc; git-svn info) > actual.info &&
	git-diff expected.info actual.info
	
*   ok 2: info

* expecting success: 
	test $(cd gitwc; git-svn info --url) = $svnrepo
	
*   ok 3: info --url

* expecting success: 
	(cd svnwc; svn info .) > expected.info-dot &&
	(cd gitwc; git-svn info .) > actual.info-dot &&
	git-diff expected.info-dot actual.info-dot
	
*   ok 4: info .

* expecting success: 
	test $(cd gitwc; git-svn info --url .) = $svnrepo
	
*   ok 5: info --url .

* expecting success: 
	(cd svnwc; svn info file) > expected.info-file &&
	(cd gitwc; git-svn info file) > actual.info-file &&
	git-diff expected.info-file actual.info-file
	
diff --git a/expected.info-file b/actual.info-file
index 23b45e2..e7f3924 100644
--- a/expected.info-file
+++ b/actual.info-file
@@ -10,6 +10,5 @@ Last Changed Author: junio
 Last Changed Rev: 1
 Last Changed Date: 2008-01-02 10:25:19 +0000 (Wed, 02 Jan 2008)
 Text Last Updated: 2008-01-02 10:25:20 +0000 (Wed, 02 Jan 2008)
-Properties Last Updated: 2008-01-02 10:25:20 +0000 (Wed, 02 Jan 2008)
 Checksum: 5bbf5a52328e7439ae6e719dfe712200
 
* FAIL 6: info file
	
		(cd svnwc; svn info file) > expected.info-file &&
		(cd gitwc; git-svn info file) > actual.info-file &&
		git-diff expected.info-file actual.info-file
		
