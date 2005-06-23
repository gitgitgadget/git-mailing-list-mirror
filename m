From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 23:51:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506222338290.11175@ppc970.osdl.org>
References: <42B9FCAE.1000607@pobox.com> <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org>
 <42BA14B8.2020609@pobox.com> <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org>
 <42BA1B68.9040505@pobox.com> <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org>
 <42BA271F.6080505@pobox.com> <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org>
 <42BA45B1.7060207@pobox.com> <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
 <20050623062045.GA11638@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 08:52:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlLYw-0003BI-CV
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 08:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVFWG4q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 02:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVFWGxz
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 02:53:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2770 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262363AbVFWGtj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 02:49:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5N6nZjA031970
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 23:49:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5N6nYe7031970;
	Wed, 22 Jun 2005 23:49:35 -0700
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050623062045.GA11638@kroah.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Greg KH wrote:
> 
> Hm, that doesn't work right now.

Yeah, my suggested mod sucks.

Try the following slightly modified version instead, with

	git fetch rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.12.y.git tag v2.6.12.1

and now it should work.

		Linus

---
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -1,7 +1,13 @@
 #!/bin/sh
 #
+destination=FETCH_HEAD
+
 merge_repo=$1
 merge_name=${2:-HEAD}
+if [ "$2" = "tag" ]; then
+	merge_name="refs/tags/$3"
+	destination="$merge_name"
+fi
 
 : ${GIT_DIR=.git}
 : ${GIT_OBJECT_DIRECTORY="${SHA1_FILE_DIRECTORY-"$GIT_DIR/objects"}"}
@@ -35,7 +41,7 @@ download_objects () {
 }
 
 echo "Getting remote $merge_name"
-download_one "$merge_repo/$merge_name" "$GIT_DIR"/FETCH_HEAD || exit 1
+download_one "$merge_repo/$merge_name" "$GIT_DIR/$destination" || exit 1
 
 echo "Getting object database"
-download_objects "$merge_repo" "$(cat "$GIT_DIR"/FETCH_HEAD)" || exit 1
+download_objects "$merge_repo" "$(cat "$GIT_DIR/$destination")" || exit 1
