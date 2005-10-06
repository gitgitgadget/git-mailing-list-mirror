From: Linus Torvalds <torvalds@osdl.org>
Subject: Still unsafe: write_sha1_from_fd()
Date: Thu, 6 Oct 2005 15:26:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510061520400.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 07 00:28:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENeCX-0005f2-Ju
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 00:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVJFW0z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 18:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVJFW0z
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 18:26:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1236 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751019AbVJFW0y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 18:26:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j96MQr4s023305
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Thu, 6 Oct 2005 15:26:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j96MQrUe025175
	for <git@vger.kernel.org>; Thu, 6 Oct 2005 15:26:54 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.51__
X-MIMEDefang-Filter: osdl$Revision: 1.122 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9786>


I was looking over the object writing functions, and noticed that 
"write_sha1_from_fd()" writes its object directly into the final object 
name, which means that if it is interrupted with ^C at an inopportune 
time, it will leave a corrupt object behind.

The only user is apparently ssh-fetch, but especially since the input-fd 
is a network connection, it looks like it is not at all unlikely that this 
case will trigger - all it takes is somebody impatient waiting for a large 
object.

Ugh,

		Linus
