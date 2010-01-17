From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git rm --cached and pull semantics
Date: Sun, 17 Jan 2010 12:42:03 +0100
Message-ID: <vpq1vhpufec.fsf@bauges.imag.fr>
References: <4B51EE39.3010401@phuk.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: list@phuk.ath.cx
X-From: git-owner@vger.kernel.org Sun Jan 17 12:42:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWTWN-0002Xg-JJ
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 12:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab0AQLmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 06:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809Ab0AQLmO
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 06:42:14 -0500
Received: from mx1.imag.fr ([129.88.30.5]:35133 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549Ab0AQLmN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 06:42:13 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o0HBfVkt007635
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 17 Jan 2010 12:41:31 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NWTW8-0004rq-5x; Sun, 17 Jan 2010 12:42:04 +0100
In-Reply-To: <4B51EE39.3010401@phuk.ath.cx> (list@phuk.ath.cx's message of "Sat\, 16 Jan 2010 17\:50\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 17 Jan 2010 12:41:32 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0HBfVkt007635
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1264333292.20982@U0L7mR/IN3gdXx9MvaV8yQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137293>

list@phuk.ath.cx writes:

> Hello everyone,
>
> I'm trying to manage and distribute a subset of /etc with git.
> Therefore, I have * in .gitignore and use git add -f to add files. Now
> sometimes I want to un-track a file that has been in previous commits,
> but naturally I don't want the file deleted. I just want git to ignore
> it again. As I read it, the way to do that is "git rm --cached $file".
> On the local working tree, that works as expected, but when some remote
> machine pulls a subsequent commit, it deletes the file from its working
> tree. But I just want git to ignore the file again, just as it does in
> the origin repo. How can I do that?

I'd say there's no way, and there will hardly ever be any :-(.

Git is purely snapshot-oriented, which means that when you do a "git
rm --cached", the next commit doesn't say "this file has been
removed", but instead, it says "the file is not here", which can be
interpreted as "the file is not here _anymore_" when comparing the
commit and its ancestor.

But as a result, there's no place to store information about _how_ the
file was removed. So, for the remote machine doing a "git pull", the
merge algorithm just sees that it's not there, and deletes it.

OTOH, after "git pull", it's rather simple to do something like

git show HEAD@{1}:your-file.txt > your-file.txt

to restore it as an untracked file. Maybe it's possible to automate
this in a script, but I have no idea how.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
