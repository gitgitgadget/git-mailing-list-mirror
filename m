From: eschvoca <eschvoca@gmail.com>
Subject: make install bug?
Date: Mon, 12 Dec 2005 10:35:58 -0500
Message-ID: <2b05065b0512120735v26c8343aged48165f3ccc5892@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Dec 12 16:38:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elpie-0005RM-E7
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 16:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVLLPgA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 10:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVLLPgA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 10:36:00 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:51936 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751145AbVLLPgA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 10:36:00 -0500
Received: by wproxy.gmail.com with SMTP id i14so1724342wra
        for <git@vger.kernel.org>; Mon, 12 Dec 2005 07:35:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VC1+mlYndMG3DonTVcn0d1z8HeYhrKnGyXFq86NJ0vwAibwx5lNbtevd7NoNIj7jRr+XQK2DMWqoZIBhes+J30t9iy54u4/7ior/PLEJRbR/tJMYwwKZ150NOyVtHjghCwEhvXq76Bx6V2yBjED7kggqKLibrPBpIhDgXpfvP28=
Received: by 10.64.232.11 with SMTP id e11mr5704727qbh;
        Mon, 12 Dec 2005 07:35:58 -0800 (PST)
Received: by 10.65.38.9 with HTTP; Mon, 12 Dec 2005 07:35:58 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13521>

Using the latest git on "make prefix=/home/eschvoca/apps/git-0.99.9m
install" I get the following error:

make[1]: Entering directory `/home/eschvoca/downloads/git-0.99.9m/templates'
: no custom templates yet
install -d -m755 '/home/eschvoca/share/git-core/templates/'
(cd blt && tar cf - .) | \
(cd '/home/eschvoca/share/git-core/templates/' && tar xf -)
tar: This does not look like a tar archive
tar: Skipping to next header
tar: Error exit delayed from previous errors
make[1]: *** [install] Error 2


I can fix the problem by changing templates/Makefile to the following:

install: all
    $(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(template_dir))
    (cd blt && $(TAR) cf - . > /tmp/a.tar) | \
    (cd $(call shellquote,$(DESTDIR)$(template_dir)) && $(TAR) xf /tmp/a.tar)
