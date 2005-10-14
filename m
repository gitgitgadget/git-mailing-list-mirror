From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Cogito: Merge failure when new remote has been added locally
Date: Thu, 13 Oct 2005 22:06:39 -0300
Message-ID: <200510140106.j9E16dfn017346@inti.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Fri Oct 14 03:32:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQEQm-0003NG-W6
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 03:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVJNBbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 21:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVJNBbN
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 21:31:13 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:57229 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932526AbVJNBbL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 21:31:11 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j9E16dfn017346
	for <git@vger.kernel.org>; Thu, 13 Oct 2005 22:06:40 -0300
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10096>

I've set up an example project to play around with cogito/git. To simulate
patches flowing back and forth I set up several repositories, which I edit
independently. In this I run into trouble with a reasonable scenario:

 A creates a project, and publishes it

 B gets A's version, updates his version, and ships a patch (which creates
   stack.h) to A

 A merges in B's changes, and fixes a typo in stack.h

 B tries to update from A via cg-update, the merge fails because there is a
   local stack.h (which is different than the remote one). The resulting
   message is less than helpful.

A script showing the problem follows:

   mkdir tst1
   cd tst1
   echo "Initial" | cg-init
   
   cd ..
   cg-clone tst1 tst2

   cd tst2
   echo 'Hello!' > greet
   cg-add greet
   cg-commit -m "Add greet"

   cd ../tst1
   echo 'Hi there!' > greet
   cg-add greet
   cg-commit -m "Add greet"

   cd ../tst2
   cg-update

This gives:


     MERGE ERROR: : Not handling case  ->  ->

            Conflicts during merge. Do cg-commit after resolving them.

And there is nothing marked to fix by hand. cg-diff returns an empty
difference in greet.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
