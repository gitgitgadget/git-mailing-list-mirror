From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git push in a git-init without --bare option?
Date: Sun, 26 Jun 2011 20:17:29 +0200
Message-ID: <vpqliwoa24m.fsf@bauges.imag.fr>
References: <201106261142.28142.psdc1978@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pedro Sa Costa <psdc1978@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 26 20:20:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QatwD-0004uM-Ii
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 20:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab1FZSS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 14:18:57 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39705 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753945Ab1FZSRe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 14:17:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p5QIHRn5025211
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 26 Jun 2011 20:17:27 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Qatti-0007h2-0C; Sun, 26 Jun 2011 20:17:30 +0200
In-Reply-To: <201106261142.28142.psdc1978@gmail.com> (Pedro Sa Costa's message
	of "Sun, 26 Jun 2011 11:42:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 26 Jun 2011 20:17:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p5QIHRn5025211
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1309717048.40257@OJ7+TyWtNNr51Y5N1DaUFg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176325>

Pedro Sa Costa <psdc1978@gmail.com> writes:

> - I see that in git, I can't do git-push to a repository that wasn't created 
> with git-init --bare. Why?
>
> - But doing git-pull and git-checkout to the same repository is possible. I'm 
> really confused. Any help?

git pull involves a merge, and merge may involve conflicts, and
conflicts involve a user fixing them ... So, doing a "git pull" to merge
in remote changes is OK, but a "git push" cannot merge changes remotely,
hence the asymetry.

Git could just send the commits, without updating the working tree, but
that would be terrible for the user. Let's say the user has no local
change before the push. His checkout points to the tip of a branch
(information stored in HEAD), so the tree matches the old HEAD. Updating
the branch means changing the commit pointed to by HEAD, hence after a
push, the tree does not match the HEAD anymore (which means the next
commit will seem to revert the pushed history). This is to prevent this
situation that Git refuses to push to non-bare repos.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
