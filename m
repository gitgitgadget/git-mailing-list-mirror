From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: path limiting broken
Date: Sun, 16 Apr 2006 14:26:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604161411120.15345@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 16 14:26:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV6Ky-0005Fb-Bd
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 14:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWDPM0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 08:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWDPM0j
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 08:26:39 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:61584 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750720AbWDPM0j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Apr 2006 08:26:39 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 5972F1F4B
	for <git@vger.kernel.org>; Sun, 16 Apr 2006 14:26:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 4E5E81F4A
	for <git@vger.kernel.org>; Sun, 16 Apr 2006 14:26:38 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 3AE081F3C
	for <git@vger.kernel.org>; Sun, 16 Apr 2006 14:26:38 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18789>

Hi,

I just tried to find out when certain changes percolated into log-tree.c. 
So I issued "git log --cc next log-tree.c". Wonders of wonders, the 
patches did not contain *anything* about what I tried to find, even if the 
file contains the key words. Because the path limiting is overeager (I 
finally found what I looked for in commit f4235f8b):

	git-name-rev $(git-rev-list --pretty=oneline \
	f4235f8b2ef875b85ead74ffa199d827f9ee9d8d..next log-tree.c | \
	sed "s/ .*$//")

yields

	cb8f64b4e3f263c113b7a2f156af74b810e969ff next^2
	cd2bdc5309461034e5cc58e1d3e87535ed9e093b next~10^2~2

while without path limiting,

	git-name-rev $(git-whatchanged.sh --pretty=oneline \
	f4235f8b2ef875b85ead74ffa199d827f9ee9d8d^..next log-tree.c | \
	sed -n "s/^diff-tree \([^ ]*\).*$/\1/p")

I get

	cb8f64b4e3f263c113b7a2f156af74b810e969ff next^2
	c5ccd8be43df4b916752a176512a9adaf3b94df9 next~4^2
	f4235f8b2ef875b85ead74ffa199d827f9ee9d8d next~6^2
	183df63940bf92ea626af64d0057165b8aad24f6 next~8^2
	cd2bdc5309461034e5cc58e1d3e87535ed9e093b next~10^2~2

I am not intelligent enough to find out why there are three revisions 
which get culled.

Ideas?

Ciao,
Dscho
