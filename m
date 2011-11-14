From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git behaviour question regarding SHA-1 and commits
Date: Mon, 14 Nov 2011 08:39:59 +0100
Message-ID: <4EC0C5CF.3010708@viscovery.net>
References: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: vinassa vinassa <vinassa.vinassa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 08:41:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPrA5-0003n2-Rv
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 08:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab1KNHkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 02:40:45 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:34329 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751770Ab1KNHkp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 02:40:45 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RPr9n-0003wG-D4; Mon, 14 Nov 2011 08:40:43 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 28A5E1660F;
	Mon, 14 Nov 2011 08:40:43 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185368>

Am 11/13/2011 18:04, schrieb vinassa vinassa:
> I am wondering about how git behaves currently, if I kinda win the
> lottery of the universe, and happen to create a commit with a SHA-1
> that is already the SHA-1 of another commit in the previous history.
> However improbable.
> 
> Would that be detected, so that I could just add a newline, and then
> commit with a different resulting SHA-1,
> would I just lose one of those commits (hopefully the new one), would
> I end up with a corrupted repository?

I *think* the following would happen:

1. Git detects that the (commit) object that it is about to generate
already exists, and does not write a new one.

2. Then the branch's ref is updated to the SHA-1. Since the original
commit is somewhere back in history, this is effectively like 'git reset
--soft that-commit'.

3. At your next 'git diff --cached', you notice unexpected differences
between the index and the branch head. You will wonder what happened.
("Who typed 'git reset --soft that-commit' while I was looking the other
way??")

4. To recover, you just 'git reset --soft @{1}' to revert to the state
before the commit attempt, and commit again. Your commit message from the
first attempt will be lost unless you have used -C or -F for your commit.
At any rate, you can reuse the exact same commit message for this second
commit attempt, because by now time will have advanced by at least one
second, which gives you a different commit timestamp and, hence, a
different commit object.

-- Hannes
