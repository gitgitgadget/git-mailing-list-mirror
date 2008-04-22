From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 22 Apr 2008 20:07:03 +0200
Message-ID: <200804222007.03439.Josef.Weidendorfer@gmx.de>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <200804221655.11914.Josef.Weidendorfer@gmx.de> <46dff0320804221013m2ff0320am31b7f8beb5f26f1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 20:08:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoMuJ-0001BK-QA
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 20:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757774AbYDVSHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 14:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753962AbYDVSHI
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 14:07:08 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.12]:40162 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756272AbYDVSHG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2008 14:07:06 -0400
Received: from dhcp-3s-59.lrr.in.tum.de (unknown [131.159.35.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.in.tum.de (Postfix) with ESMTP id EE41A6979;
	Tue, 22 Apr 2008 20:07:04 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <46dff0320804221013m2ff0320am31b7f8beb5f26f1b@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80153>

On Tuesday 22 April 2008, Ping Yin wrote:
> >  A reason you did not mention is security:
> >  You never want your .git/config to be changed behind your back, which
> >  effectivly is the case when using the versioned .gitmodules information
> >  (similar problem as with a .gitconfig in-tree).
> 
> As discussed in another thread about in-tree .gitconfig, security
> issues only arise on limited configuration entries. However, there are
> no entries in .gitmodules falling into any of these entries.

Hmm... At least, it can be very annoying when git fetches data from repositories
you did not expect, only because submodule URLs change via this
fallback mechanism. Perhaps it is a little far reached, but suppose a project
changes its URL, and the old one becomes occupied by a malicious person.
The problem is that the URL with the now malicious repository is bound in the
history of the project. For sure, you do not want to fetch from that old repository
by accident, after you did a checkout of an old commit. And there would be no
way to protect other people from this malicious repository other than rewriting
the whole history.

> >  Another one:
> >  From a design point of view, submodule URLs are project meta information
> >  unrelated to source history. So, actually, I think it was wrong to put
> >  submodule URLs (even hints only) into the versioned .gitmodules files (*).
> 
> But now it actually acts as hints and we don't find a better way. I
> just propose that the hints become the good default.

For me this sounds like: Now that we have made this bad decision, it does
not matter to make it even worse.

What was the motivation for this fallback mechanism?

In any way, it is preferable to always use the correct URL for submodules.
Thus, when the URL ever changes in the projects livetime (covered by
git history), you want to have the correct URL in your .git/config
(not to accidently use the wrong URL when checking out an old commit).
But then, the fallback mechanism does not trigger anyway.

> >  The main reason for .gitmodules is to store submodule information which
> >  has to be in sync with commits, such as a submodule name related to some
> >  path where the submodule happens to be checked out in a given commit, and
> >  also related to some config entry holding the URL to allow for fetch/pull.
> >  The idea is that submodules have an identity in the supermodule (in contrast
> >  to files in git), such that related configuration keeps valid when moving
> >  submodules around. This needs simultanous adjusting the path attribute in
> >  .gitmodules when a submodule is moved.
> 
> If we go back to a old HEAD or switch to another branch with changed
> path for a submodule,  what should 'git submodule update' do?
> I think entries in .gitmodules should take precedence.

Of course. It makes no sense to have submodule path configuration in .git/config,
as it has to be in sync with the current commit. That has nothing to do with
precedence. The same is true for .gitattributes, for example.

> So url in $GIT_DIR/config is authoritative, and path in .gitmodules is
> authoritative.

No.
These are totally different types of configurations.

Josef
