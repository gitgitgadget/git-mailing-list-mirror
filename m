From: Wolfgang Denk <wd@denx.de>
Subject: Can't build RPM's from current cogito tree
Date: Thu, 04 Aug 2005 22:47:19 +0200
Message-ID: <20050804204719.23F9D353C13@atlas.denx.de>
X-From: git-owner@vger.kernel.org Fri Aug 05 01:11:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0oqf-0002CH-7J
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 01:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVHDXJr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 19:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVHDXJk
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 19:09:40 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:445 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262674AbVHDUrf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 16:47:35 -0400
Received: from fwd34.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1E0mcf-00013u-02; Thu, 04 Aug 2005 22:47:25 +0200
Received: from denx.de (Saf252ZYweBMDM3M3WOcV+6vZIb9dqlDdBiVpHofG9SaBL9hwe5UUx@[84.150.103.159]) by fwd34.sul.t-online.de
	with esmtp id 1E0mca-03tQwK0; Thu, 4 Aug 2005 22:47:20 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 568FD42EBD; Thu,  4 Aug 2005 22:47:19 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 23F9D353C13;
	Thu,  4 Aug 2005 22:47:19 +0200 (MEST)
To: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-ID: Saf252ZYweBMDM3M3WOcV+6vZIb9dqlDdBiVpHofG9SaBL9hwe5UUx@t-dialin.net
X-TOI-MSGID: b9c23eae-d358-4d28-938c-6b65753924d3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Building of RPM's from the current cogito tree fails:

-> rpmbuild -ba cogito.spec 
...
make -C tools install
make[1]: Entering directory `/usr/local/BUILD/cogito-0.12.1/tools'
gcc -g -O2 -Wall -o git-mailsplit mailsplit.c
gcc -g -O2 -Wall -o git-mailinfo mailinfo.c
install -m755 -d /usr/bin
install: cannot change permissions of `/usr/bin': Operation not permitted
make[1]: *** [install] Error 1
make[1]: Leaving directory `/usr/local/BUILD/cogito-0.12.1/tools'
make: *** [install-tools] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.6363 (%install)


This fixes it:

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -245,10 +245,10 @@ install-cogito: $(SCRIPT) $(LIB_SCRIPT) 
 	done
 
 install-tools:
-	$(MAKE) -C tools install
+	$(MAKE) -C tools dest=$(DESTDIR) install
 
 install-doc:
-	$(MAKE) -C Documentation install
+	$(MAKE) -C Documentation dest=$(DESTDIR) install
 
 uninstall:
 	cd $(DESTDIR)$(bindir) && rm -f $(PROG) $(SCRIPTS) $(SCRIPT) $(GEN_SCRIPT)


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Every program has at least one bug and can be shortened by  at  least
one  instruction  --  from  which,  by induction, one can deduce that
every program can be reduced to one instruction which doesn't work.
