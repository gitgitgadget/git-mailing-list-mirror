From: John Keeping <john@keeping.me.uk>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is
 misleading
Date: Thu, 8 May 2014 23:10:24 +0100
Message-ID: <20140508221024.GB19464@serenity.lan>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
 <20140508213806.GA19464@serenity.lan>
 <xmqqvbtg0w65.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 09 00:10:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiWWU-0004h4-HP
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 00:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806AbaEHWKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 18:10:34 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:56030 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734AbaEHWKe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 18:10:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9826DCDA5D2;
	Thu,  8 May 2014 23:10:33 +0100 (BST)
X-Quarantine-ID: <ktCmehXgUy0X>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ktCmehXgUy0X; Thu,  8 May 2014 23:10:32 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id A4EABCDA5BA;
	Thu,  8 May 2014 23:10:30 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 98A99161E0A0;
	Thu,  8 May 2014 23:10:30 +0100 (BST)
X-Quarantine-ID: <iHp0fCeFZZPN>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iHp0fCeFZZPN; Thu,  8 May 2014 23:10:30 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 35647161E27D;
	Thu,  8 May 2014 23:10:26 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqvbtg0w65.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248455>

On Thu, May 08, 2014 at 02:58:58PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > On a slight tangent, I tried this in a fairly young repository and got
> > this (with master at v2.0.0-rc2-4-g1dc51c6):
> >
> > $ git blame Makefile | head -5
> > 7a3fc144 (John Keeping      2013-12-26 17:37:53 +0000   1) REL_VERSION = v0.2
> > 5c9829f9 (John Keeping      2013-07-29 17:03:26 +0100   2) 
> > 5c9829f9 (John Keeping      2013-07-29 17:03:26 +0100   3) # The default target is...
> > ^f7fae99 (John Keeping      2013-03-24 17:14:40 +0000   4) all::
> > ^f7fae99 (John Keeping      2013-03-24 17:14:40 +0000   5) 
> >
> > f7fae99 is the initial commit in the repository, so shouldn't the last
> > two lines blame to that, not a non-existent ancestor?
> 
> It is not saying f7fae99^, is it?  It is debatable if it is correct
> to mark the root commit as a boundary, but that is what it is
> showing, I think.  In other words, "this line hasn't changed since
> the inception of the project".

Yes, it's marking it as a boundary but I'm not convinced that's correct.
Compare these two cases:

$ git blame Makefile | head -5
7a3fc144 (John Keeping      2013-12-26 17:37:53 +0000   1) REL_VERSION = v0.2
5c9829f9 (John Keeping      2013-07-29 17:03:26 +0100   2) 
5c9829f9 (John Keeping      2013-07-29 17:03:26 +0100   3) # The default target is...
^f7fae99 (John Keeping      2013-03-24 17:14:40 +0000   4) all::
^f7fae99 (John Keeping      2013-03-24 17:14:40 +0000   5) 

$ git blame ^5c9829f9 Makefile | head -5
7a3fc144 (John Keeping      2013-12-26 17:37:53 +0000   1) REL_VERSION = v0.2
^5c9829f (John Keeping      2013-07-29 17:03:26 +0100   2) 
^5c9829f (John Keeping      2013-07-29 17:03:26 +0100   3) # The default target is...
^5c9829f (John Keeping      2013-07-29 17:03:26 +0100   4) all::
^5c9829f (John Keeping      2013-07-29 17:03:26 +0100   5) 


While it might be useful to mark the initial commit, the current output
seems to mean that lines 4 and 5 existed before the repository was
created.  If you consider blame's output to mean "introduced by commit"
then those lines should simply blame to the initial commit.

`git log --boundary` does not mark the initial commit as a boundary.
