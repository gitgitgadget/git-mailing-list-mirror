From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 14:53:47 -0500
Message-ID: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 20:53:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGKll-0004Vb-Pf
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 20:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbXBKTxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 14:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbXBKTxu
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 14:53:50 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:47260 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbXBKTxu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 14:53:50 -0500
Received: by wr-out-0506.google.com with SMTP id i21so1416686wra
        for <git@vger.kernel.org>; Sun, 11 Feb 2007 11:53:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Dler6+9x9a0MQszAKyMni7uLkOgIa7TZ5Bo32nGa4Y0LMfW3Fm3yXNKCtHQQ2O9znGxJKdueDB+oa2HtuOWfyFgVxDvD5BrW9V/bBvzFBNmHpv+kqOlBQiGIF4YKT9CHtejYjGPXODmtpoEG+3G/FuO0/GrZinQPSgCYBy0Xdmo=
Received: by 10.114.126.1 with SMTP id y1mr6567369wac.1171223627035;
        Sun, 11 Feb 2007 11:53:47 -0800 (PST)
Received: by 10.114.195.13 with HTTP; Sun, 11 Feb 2007 11:53:47 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39305>

I'm doing a clone right now and I see this:

jonsmirl@jonsmirl:/extra$ cg clone
git://git2.kernel.org/pub/scm/linux/kernel/git/linville/wireless-dev.git
Initialized empty Git repository in .git/
Fetching pack (head and objects)...
remote: Generating pack...
remote: Done counting 404120 objects.
remote: Deltifying 404120 objects.
remote:  100% (404120/404120) done
Indexing 404120 objects.
remote: Total 404120, written 404120 (delta 320324), reused 365290
(delta 282572)
 100% (404120/404120) done
Resolving 320324 deltas.
....

Is this happening because the repository on the server is not
completely packed? It is basically building a pack of the whole thing
and shipping it to me, right?

If that is the case, why not first pack the whole repository and then
copy it down the wire? Now the next clone that comes along doesn't
have to do so much work. Would this help to eliminate some of the load
at kernel.org?

Some this is wrong with this tree too, what are these errors about
fatal: pack: not a valid SHA1

fatal: pack: not a valid SHA1
Fetching tags... v2.6.12 v2.6.12-rc2 v2.6.12-rc3 v2.6.12-rc4
v2.6.12-rc5 v2.6.12-rc6 v2.6.13 v2.6.13-rc1 v2.6.13-rc2 v2.6.13-rc3
v2.6.13-rc4 v2.6.13-rc5 v2.6.13-rc6 v2.6.13-rc7 v2.6.14 v2.6.14-rc1
v2.6.14-rc2 v2.6.14-rc3 v2.6.14-rc4 v2.6.14-rc5 v2.6.15 v2.6.15-rc1
v2.6.15-rc2 v2.6.15-rc3 v2.6.15-rc4 v2.6.15-rc5 v2.6.15-rc6
v2.6.15-rc7 v2.6.16 v2.6.16-rc1 v2.6.16-rc2 v2.6.16-rc3 v2.6.16-rc4
v2.6.16-rc5 v2.6.16-rc6 v2.6.17 v2.6.17-rc1 v2.6.17-rc2 v2.6.17-rc3
v2.6.17-rc4 v2.6.17-rc5 v2.6.17-rc6 v2.6.18 v2.6.18-rc1 v2.6.18-rc2
v2.6.18-rc3 v2.6.18-rc4 v2.6.18-rc5 v2.6.18-rc6 v2.6.18-rc7 v2.6.19
v2.6.19-rc1 v2.6.19-rc2 v2.6.19-rc3 v2.6.19-rc4 v2.6.19-rc5
v2.6.19-rc6 v2.6.20-rc1 v2.6.20-rc2 v2.6.20-rc3 v2.6.20-rc4
v2.6.20-rc5 v2.6.20-rc6
remote: Generating pack...
remote: Done counting 63 objects.
remote: Deltifying 63 objects.
remote:  100% (63/63) done
Indexing 63 objects.
remote: Total 63, written 63 (delta 0), reused 63 (delta 0)
 100% (63/63) done
fatal: pack: not a valid SHA1
New branch: 0953670fbcb75e26fb93340bddae934e85618f2e


-- 
Jon Smirl
jonsmirl@gmail.com
