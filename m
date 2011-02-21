From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to recovery a corrupted git repo
Date: Mon, 21 Feb 2011 15:51:21 +0100
Message-ID: <vpqpqql1lw6.fsf@bauges.imag.fr>
References: <AANLkTi=W3RckA=e-YwDJzELaEOAa+7P74V-G0G=bQhex@mail.gmail.com>
	<20110221100454.GM22168@axel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 21 15:54:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrX9s-0000EK-TR
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 15:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516Ab1BUOyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 09:54:35 -0500
Received: from imag.imag.fr ([129.88.30.1]:65491 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813Ab1BUOye (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 09:54:34 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p1LEpLmV020190
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Feb 2011 15:51:21 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PrX6f-0000Ho-Hc; Mon, 21 Feb 2011 15:51:21 +0100
In-Reply-To: <20110221100454.GM22168@axel> (Axel Freyn's message of "Mon\, 21 Feb 2011 11\:04\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 21 Feb 2011 15:51:21 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167484>

Axel Freyn <axel-freyn@gmx.de> writes:

> I don't know whether there is a single git command to do it, but you can
> copy those 5 objects "by hand": in your backup, you should have a
> directory .git/objects, where you have the files
>    b7/1eb55f2dbc97dafd4a769fc61f346e69a5e0af
>    28/2035f3ae964e1e288f352c370be8edd11d3078
>    3c/20f556eecc476e3542cc522d46a62a4461fec6
>    f3/21b578edeb452358497e832815d6cae6b36886
>    6d/23f5084c975be637f7d748db82116bf84d3872
>
> It should be sufficient to just copy those files into the corrupted
> repo.
>
> However if you packed the git-files in the backup (e.g. by running "git
> gc"), those objects might be found in a pack in .git/objects/pack.
> The easiest ist probably to use git-unpack-objects to unpack the
> objects, and then copy the 5 missing objects.

There's also the brute-force approach

rsync $good_repo/.git/objects/ $bad_repo/.git/objects/
cd $bad_repo
git gc

Notice the absence of --delete in the rsync command: I'm just adding
new files in the $bad_repo, not deleting any (since files with
identical names must have identical content).

This will result in a lot of duplicates (objects found in several
packs), but "git gc" should be able to remove them.

(the notice about doing backups before also applies to my
proposal ;-) )

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
