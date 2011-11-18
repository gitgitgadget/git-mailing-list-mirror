From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Fixing a broken GIT repo
Date: Fri, 18 Nov 2011 14:49:15 +0100
Message-ID: <4EC6625B.2070301@viscovery.net>
References: <ja5dgo$nlf$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bart van den Burg <bart@burgov.nl>
X-From: git-owner@vger.kernel.org Fri Nov 18 14:49:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RROom-0003CH-Uk
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 14:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215Ab1KRNtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 08:49:20 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:10445 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756074Ab1KRNtT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 08:49:19 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RROoe-0000Ks-6U; Fri, 18 Nov 2011 14:49:16 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E54F11660F;
	Fri, 18 Nov 2011 14:49:15 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
In-Reply-To: <ja5dgo$nlf$1@dough.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185660>

Am 11/18/2011 11:54, schrieb Bart van den Burg:
> I somehow managed to break my GIT repo. Whenever I try to clone or fetch
> from a clean local repo, I get an error.
> 
> I'm able to go back on the server, to the very last commit where
> everything works, but as soon as I make a change locally and push it, it
> breaks again.
...
> $ git clone git@git.samson-it.nl:/home/git/shifter_rai
...
> Receiving objects: 100% (9557/9557), 2.85 MiB | 1.06 MiB/s, done.
...
> $ git push
> Counting objects: 4, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (3/3), 271 bytes, done.
> Total 3 (delta 1), reused 0 (delta 0)
> To git@git.samson-it.nl:/home/git/shifter_rai
>    cc5693a..85d1ee9  master -> master

It looks like you are pushing via git protocol from Windows
(Git-for-Windows). This is known to dead-lock in most cases, and even
though it did not here, I would not be surprised if it had other issues.

Do not do it. Push via ssh instead.

> bbu@SIT-WST-05 /d/workspace9
> $ git clone git@git.samson-it.nl:/home/git/shifter_rai
> Cloning into shifter_rai...
> remote: Counting objects: 9557, done.
> remote: Compressing objects: 100% (1887/1887), done.
> remote: Total 9557 (delta 7107), reused 9397 (delta 7019)
> Receiving objects: 100% (9557/9557), 2.85 MiB | 1.16 MiB/s, done.
> Resolving deltas: 100% (7107/7107), done.

Did you notice that this downloaded the exact same number of objects as
the first clone? There should have been at least 9558, but most likely
9560 objects. There's something fishy.

> error: refs/remotes/origin/master does not point to a valid object!
> error: Trying to write ref refs/heads/master with nonexistant object
> 85d1ee957c65485ed9c937a4f1bfdd44fda4ea35
> fatal: Cannot update the ref 'HEAD'.
>
> Needless to say, the mentioned object in fact does exist on the server:
> git@server:~/shifter_rai.git$ ls -la
> objects/85/d1ee957c65485ed9c937a4f1bfdd44fda4ea35
> -r--r--r-- 1 git git 153 Nov 18 11:39
> objects/85/d1ee957c65485ed9c937a4f1bfdd44fda4ea35

Does git fsck --full on the server indeed report a good repository? Can
you clone this repository to a different client?

-- Hannes
