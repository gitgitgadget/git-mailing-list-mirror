From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Wed, 26 Nov 2008 17:35:59 +0100
Message-ID: <492D7AEF.5030908@viscovery.net>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>	 <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>	 <85b5c3130811260135g4646bf72iaf57f599fdd21a0c@mail.gmail.com>	 <85b5c3130811260218s7529914eyb56a05ec1ca34b8f@mail.gmail.com>	 <492D6CC3.2050408@drmicha.warpmail.net> <85b5c3130811260750y2e24436ye2426ccfc2f66071@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Fabian Seoane <fabian@fseoane.net>
To: Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Wed Nov 26 17:37:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5NOa-0001Ay-4J
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 17:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbYKZQgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 11:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752609AbYKZQgK
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 11:36:10 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61309 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbYKZQgI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 11:36:08 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L5NMt-0008Me-Mb; Wed, 26 Nov 2008 17:36:00 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6BAAC6D9; Wed, 26 Nov 2008 17:35:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <85b5c3130811260750y2e24436ye2426ccfc2f66071@mail.gmail.com>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa03.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Ondrej Certik schrieb: > I am also trying to make the example
	simpler. I tried to squash the > first uninteresting ~1500 commits into one,
	but "git rebase -i" > uterrly fails after squashing about 600 commits. Still
	investigating. [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101745>

Ondrej Certik schrieb:
> I am also trying to make the example simpler. I tried to squash the
> first uninteresting ~1500 commits into one, but "git rebase -i"
> uterrly fails after squashing about 600 commits. Still investigating.

Don't use rebase. Set a graft and rewrite the history:

   $ echo $(git rev-parse HEAD) $(git rev-parse HEAD~1500) >> \
		.git/info/grafts

Assuming "first 1500" means the "most recent 1500" commits. But you get
the idea. You can truncate history as well by omitting the second SHA1.
It's very convenient to keep gitk open and File->Reload after each graft
that you set.

When you're done with setting grafts:

   $ git filter-branch -f --tag-name-filter cat -- --all

(You are doing this on a copy of your repository, don't you?)

-- Hannes
