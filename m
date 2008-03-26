From: Jeff King <peff@peff.net>
Subject: Re: Undo git-rm without commit?
Date: Wed, 26 Mar 2008 02:26:35 -0400
Message-ID: <20080326062635.GC26286@coredump.intra.peff.net>
References: <D6386C1A-92D3-4E11-8DE6-CC7553211A33@faithfulgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joe Fiorini <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 07:27:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeP6U-0001mh-SH
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 07:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbYCZG0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 02:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbYCZG0i
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 02:26:38 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2781 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253AbYCZG0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 02:26:37 -0400
Received: (qmail 4600 invoked by uid 111); 26 Mar 2008 06:26:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Mar 2008 02:26:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2008 02:26:35 -0400
Content-Disposition: inline
In-Reply-To: <D6386C1A-92D3-4E11-8DE6-CC7553211A33@faithfulgeek.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78264>

On Wed, Mar 26, 2008 at 02:17:18AM -0400, Joe Fiorini wrote:

> I hadn't done a git-commit yet, but I used git-rm thinking it would  
> remove files that I had just added.  Instead, it deleted everything I had 
> added from the disk.  Is there a way to undo this?  I'm doubtful, but 
> would love to not have to rewrite what I was working on.

If by "added" you mean "git add"ed, then yes. The file is hashed and the
blob is put in the object database during the add. Unfortunately,
nothing actually _refers_ to it, so you will have to pick it out
manually by its hash. Try:

  git fsck --lost-found

and then poke around .git/lost-found/other for your missing content.

As an aside, didn't git-rm warn you? While confirming that the command I
was giving you was correct, I did this:

  git init
  echo content >file
  git add file
  git rm file

and got:

  error: 'file' has changes staged in the index
  (use --cached to keep the file, or -f to force removal)

-Peff
