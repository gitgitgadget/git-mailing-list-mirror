From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: [patch v2] documentation: Explain how to free up space after filter-branch
Date: Mon, 22 Dec 2008 10:06:41 +0100
Organization: Intra2net AG
Message-ID: <200812221006.45370.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 10:08:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEglq-0002qw-LD
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 10:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbYLVJGv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Dec 2008 04:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753416AbYLVJGu
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 04:06:50 -0500
Received: from re01.intra2net.com ([82.165.28.202]:60256 "EHLO
	re01.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbYLVJGt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Dec 2008 04:06:49 -0500
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by re01.intra2net.com (Postfix) with ESMTP id 73F479E89;
	Mon, 22 Dec 2008 10:06:47 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 125652AC4E;
	Mon, 22 Dec 2008 10:06:47 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 94F442AC4B;
	Mon, 22 Dec 2008 10:06:45 +0100 (CET)
Content-Disposition: inline
User-Agent: KMail/1.10.3 (Linux/2.6.27.7-53.fc9.i686; KDE/4.1.3; i686; ; )
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-22_04)
X-Spam-Status: hits=-4.1 tests=[ALL_TRUSTED=-1.8,BAYES_00=-2.312]
X-Spam-Level: 959
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103751>

Explain how to free up space after filter-branch.
Thanks to Bj=F6rn Steinbrink for pointing me in the right direction.

The v2 version of this patch uses "git repack -a -d"
instead of "git repack -a -d --depth=3D250 --window=3D250"
as this nocked down a box with 4GB of ram using a repository
with medium sized binary files (50 - 100mb).

Signed-off-by: Thomas Jarosch <thomas.jarosch@intra2net.com>

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-fi=
lter-
branch.txt
index fed6de6..1432380 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -319,6 +319,18 @@ git filter-branch --index-filter \
 	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
 ---------------------------------------------------------------
=20
+Free up the space in .git if the rewritten version is correct
+by deleting refs/original and pruning the reflog:
+
+----------------------------------------------------
+git for-each-ref --format=3D'%(refname)' refs/original
+	| xargs -i git update-ref -d {}
+
+git reflog expire --expire=3D0 --all
+git repack -a -d
+git prune
+----------------------------------------------------
+
=20
 Author
 ------
