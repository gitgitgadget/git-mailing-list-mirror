From: Ed Avis <eda@waniasset.com>
Subject: Re: Log messages beginning # and git rebase -i
Date: Tue, 28 Jul 2015 16:40:10 +0000 (UTC)
Message-ID: <loom.20150728T183310-319@post.gmane.org>
References: <loom.20150727T133256-715@post.gmane.org> <CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com> <loom.20150728T115023-269@post.gmane.org> <vpqsi88qp6q.fsf@anie.imag.fr> <xmqqr3nsfdmw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 18:40:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK7vV-00057m-I9
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 18:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbbG1QkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 12:40:21 -0400
Received: from plane.gmane.org ([80.91.229.3]:42087 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbbG1QkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 12:40:21 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZK7vM-00051i-3S
	for git@vger.kernel.org; Tue, 28 Jul 2015 18:40:16 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 18:40:16 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 18:40:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:39.0) Gecko/20100101 Firefox/39.0 Cyberfox/39.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274787>

I was considering this case:

- git commit -a '-m# characters are now handled OK'
- hack, hack
- git commit -a '-mWhoops, fixed last commit'
- run git-rebase -i
- squash the second commit into the first
- when prompted for the log message for the combined change,
  delete the "Whoops, fixed last commit" line but leave the first line

That will accidentally lose the first log message, assuming commentChar=#.
git-rebase -i should be a bit friendlier and not bring up an editing window
where the log message ends up being one of the comments.

I suggested it could munge the message with an extra space character, but I
agree that is a bit unpleasant.  Perhaps better would be

   % git-rebase -i
   error: commit abcde has log message beginning with '#', which is the
          current setting of commentChar.  This means that the interactive
          editing of the log message will not work.  Please set commentChar
          to some other value (such as 'auto') in your git configuration
          to be able to rebase interactively.

The current behaviour is a bit of a trap for the unwary, and anyway it leaves
no way to specify keeping the existing log message (which begins #).

-- 
Ed Avis <eda@waniasset.com>
