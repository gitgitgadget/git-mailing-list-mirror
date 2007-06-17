From: Alex Riesen <raa.lkml@gmail.com>
Subject: repack behaves unexpectedly if called in a bare _subrepo_
Date: Sun, 17 Jun 2007 17:38:10 +0200
Message-ID: <20070617153810.GB2763@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 17 17:38:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzwpU-0001TQ-Bx
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 17:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbXFQPiP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 11:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbXFQPiP
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 11:38:15 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:28384 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbXFQPiO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 11:38:14 -0400
Received: from tigra.home (Fcaba.f.strato-dslnet.de [195.4.202.186])
	by post.webmailer.de (mrclete mo43) (RZmta 7.3)
	with ESMTP id Q01a8cj5HD68TZ for <git@vger.kernel.org>;
	Sun, 17 Jun 2007 17:38:12 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8DB14277BD
	for <git@vger.kernel.org>; Sun, 17 Jun 2007 17:38:12 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 571ABC164; Sun, 17 Jun 2007 17:38:10 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTv+Fmk=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50353>

Just a heads-up. This took me by surprise. And I suppose it will be
the same even if the subrepo is a real subproject.

To illustrate:

(
    mkdir super && cd super
    git init
    echo 0 > a; git add a; git commit -m0
    echo 2 >> a; git commit -a -m1
    echo 3 >> a; git commit -a -m2
    cp -a .git sub
    cd sub
    git --bare config --bool core.bare true
    git repack -a -d
)

Unexpectedly, the "super" repo is repacked, even though repack is
called from the "sub". To actually repack the repo in the current
directory if it is bare, use "git --bare repack ...".

This kind of makes core.bare pointless: can't rely on it anyway.
