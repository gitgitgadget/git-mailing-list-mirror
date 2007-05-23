From: skimo@liacs.nl
Subject: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 00:22:49 +0200
Message-ID: <11799589913153-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:24:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzFm-0003VS-AS
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015AbXEWWXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757162AbXEWWXo
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:23:44 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:33751 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755846AbXEWWXh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:23:37 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4NMNBwo011545;
	Thu, 24 May 2007 00:23:16 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 23C873C009; Thu, 24 May 2007 00:23:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48194>

From: Sven Verdoolaege <skimo@kotnet.org>

This patch series implements a mechanism for cloning submodules.
Each submodule is specified by a 'submodule.<submodule>.url'
configuration option, e.g.,

bash-3.00$ ./git-config --remote=http://www.liacs.nl/~sverdool/isa.git --get-regexp 'submodule\..*\.url' 
submodule.cloog.url /home/sverdool/public_html/cloog.git
submodule.cloog.url http://www.liacs.nl/~sverdool/cloog.git

git-checkout will use the first url that works.
E.g., a

git clone --submodules ssh://liacs/~/public_html/isa.git

followed by

git checkout origin/submodule

(which only works for me), will use the first url, while a

git clone --submodules http://www.liacs.nl/~sverdool/isa.git

followed by

git checkout origin/submodule

will use the second.

The cloning of submodules is handled inside git-checkout.

git-checkout will now also checkout/fetch any submodule
than is present (i.e., the corresponding subdirectory has a .git)
irrespective of the --submodules option.

A forced checkout of the submodule directory, i.e.,

git checkout submodule

will (clone and) checkout the submodule.

Note that this is still WIP, so there is no need to remind
me that I still need to write documentation and tests.

skimo
