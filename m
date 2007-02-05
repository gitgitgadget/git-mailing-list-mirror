From: David Woodhouse <dwmw2@infradead.org>
Subject: Why is git-clone --reference so slow?
Date: Mon, 05 Feb 2007 11:46:44 +0000
Message-ID: <1170676004.29759.767.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 12:47:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE2JI-00012B-9M
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 12:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbXBELqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 06:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbXBELqs
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 06:46:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60012 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbXBELqr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 06:46:47 -0500
Received: from pmac.infradead.org ([81.187.2.168])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HE2J4-0006VN-OO
	for git@vger.kernel.org; Mon, 05 Feb 2007 11:46:46 +0000
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38744>

My DSL line sucks; I know this. But why is git-clone so bad at using it?

This is slow and seems to be downloading a lot of stuff it doesn't
need...

pmac /pmac/git $ git-clone --reference /pmac/git/linux-2.6 git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git
remote: Generating pack...
remote: Done counting 14428 objects.
remote: Deltifying 14428 objects.
remote:  100% (14428/14428) done
Indexing 14428 objects.
  25% (3662/14428) done

At this point I got bored and hit ^C, then logged in to hera and did it
there, then rsync'd the result...

hera /home/dwmw2/x $ git-clone -n --bare --reference /pub/scm/linux/kernel/git/torvalds/linux-2.6.git /pub/scm/linux/kernel/git/geoff/ps3-linux.git 
remote: Generating pack...
remote: Done counting 14490 objects.
remote: Deltifying 14490 objects.
remote:  100% (14490/14490) done
Indexing 14490 objects.
remote: Total 14490, written 14490 (delta 579), reused 5598 (delta 367)
 100% (14490/14490) done
Resolving 579 deltas.
 100% (579/579) done

pmac /pmac/git/ps3-linux $  rsync -avz master.kernel.org:/home/dwmw2/x/ps3-linux/ .git
pmac /pmac/git/ps3-linux $ echo /pmac/git/linux-2.6/.git/objects > .git/objects/info/alternates

That was a _lot_ faster, and abused my poor DSL line a lot less. Why's
git so bad at it?

-- 
dwmw2
