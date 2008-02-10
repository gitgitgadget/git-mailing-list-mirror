From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Another bench on gitweb
Date: Sun, 10 Feb 2008 01:09:19 -0200
Message-ID: <20080210030919.GA32733@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 04:10:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO2aL-0000dV-P7
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 04:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495AbYBJDJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 22:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755490AbYBJDJy
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 22:09:54 -0500
Received: from mx.c3sl.ufpr.br ([200.17.202.3]:52947 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339AbYBJDJx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 22:09:53 -0500
Received: from localhost (unknown [189.1.135.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 603E5700000B6
	for <git@vger.kernel.org>; Sun, 10 Feb 2008 01:09:51 -0200 (BRST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73301>

Hello,

I made another SIMPLE bench on gitweb. Testing time on git-for-each-ref.

Using my 1000 projects I ran:
8<----------------
#/bin/bash
PEGAR_ref() { 
    PROJ=projeto$1.git; 
    cd $PROJ; 
    printf "\tlastref = $(git-for-each-ref --sort=-committerdate --count=1\
            --format='%(committer)')\n" >> config; 
    cd -; 
}
cd $HOME/scm
for((i=1;i<=1000;i++)){ PEGAR_ref $i & }
8<----------------

And at the "git_get_last_activity" instead of running git-for-each-ref i
asked to get gitweb.lastref

Here are the results:
"dd" means: dd if=/dev/zero of=$HOME/dd/$i bs=1M count=400000

Running 2 dd to generate disk IO.  Here comes the results:
NO projects_list  projects_list
7m56s55           6m11s95        cached last change, using gitweb.lastref
16m30s69          15m10s74       default gitweb, using FS's owner
16m07s40          15m24s34       patched to get gitweb.owner


Now results for a 1000projects on an idle machine. (No dd running to
generate IO)
NO projects_list  projects_list
0m26s79           0m38s70       cached last change, using gitweb.lastref
1m19s08           1m09s55       default gitweb, using FS's owner
1m17s58           1m09s55       patched to get gitweb.owner


I found out those VERY interesting, so instead of trying to think a new way
to store gitweb config, we should think a way to cache those information.
-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
