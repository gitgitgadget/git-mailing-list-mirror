From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use git-update-ref in scripts.
Date: Wed, 28 Sep 2005 11:14:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509281106370.3308@g5.osdl.org>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
 <Pine.LNX.4.58.0509251153090.3308@g5.osdl.org> <7vpsqtykor.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509280819000.3308@g5.osdl.org> <7vek79w2ps.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509281007200.3308@g5.osdl.org> <7v3bnpt81e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 28 20:16:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKgS3-0001iL-Bh
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 20:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVI1SOk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 14:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVI1SOk
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 14:14:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13542 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750715AbVI1SOj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2005 14:14:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8SIEW4s023933
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Sep 2005 11:14:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8SIEVxY010228;
	Wed, 28 Sep 2005 11:14:32 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bnpt81e.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9444>



On Wed, 28 Sep 2005, Junio C Hamano wrote:
>
> I was wondering the URL shorthand you mentioned is being used in
> practice.  In theory, you do not "have to write out in full"
> anymore ;-).

Almost always, I end up cut-and-pasting the thing from an email.

In many ways, the most irritating part for me about that is that an email 
that wants to give a publically accessible part has to be something like

   "Please pull from

      rsync://rsync.kernel.org/path

    to get the xyz updates"

and then I cut-and-paste it but have to delete the "rsync://", and replace 
the "rsync.kernel.org/" with "master.kernel.org:/". 

Sad.

So I've actually considered a totally Linus-only hack that does that 
automatically, ie something like this untested patch.. (same goes for http 
too, for that matter)

		Linus

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -32,7 +32,7 @@ get_remote_url () {
 	data_source=$(get_data_source "$1")
 	case "$data_source" in
 	'')
-		echo "$1" ;;
+		echo "$1" | sed 's/rsync:[^/]*kernel.org/master.kernel.org:/ ;;
 	remotes)
 		sed -ne '/^URL: */{
 			s///p
