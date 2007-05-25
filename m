From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 14:27:46 +0200
Message-ID: <200705251427.46903.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site> <7vabvuywix.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	skimo@liacs.nl, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org, Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 25 14:28:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrYtj-0006YJ-70
	for gcvg-git@gmane.org; Fri, 25 May 2007 14:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbXEYM1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 08:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbXEYM1v
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 08:27:51 -0400
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:36170 "EHLO
	tuminfo2.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752491AbXEYM1u (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2007 08:27:50 -0400
Received: from dhcp-3s-55.lrr.in.tum.de (dhcp-3s-55.lrr.in.tum.de [131.159.35.55])
	by mail.in.tum.de (Postfix) with ESMTP id C16AC28DC;
	Fri, 25 May 2007 14:27:48 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48365>

On Thursday 24 May 2007, Linus Torvalds wrote:
> 
> On Thu, 24 May 2007, Junio C Hamano wrote:
> > 
> > Why does this have to be out-of-tree and unversioned to begin
> > with?
> 
> I _really_ think that the right approach is to
> 
>  - have the submodules information under version control (and I'd 
>    personally call it the ".gitmodules" file, but whatever)
> 
>    This gives you the defaults, and the ability to change them.

Sorry to repeat the obvious.

I assume you talk about a versioned .gitmodules file tied to the
superproject history, and any fetch/pull would look into this
file from the current working directory to lookup the default URL.

Wouldn't this have the problem that when you check out an old
revision of the superproject you get out-of-date URLs, so that
a fetch does not work (without local overrides)?

IMHO we really need 2 kinds of submodule config:
(1) One bound to the superproject history
(2) One bound _not_ to the superproject history.

However, (2) could be put into its own, seperate history/branch,
similar to the "todo" branch in the git repository. The tip of the
submodule config history, (2) above, would e.g. be available as
"ref/submodulesconfig" (and could be checked out by "git-clone" into
a separate place like .git/submodulesconfig of the superproject for easy
editing).
Any "git-fetch" of the superproject would also fetch any changed defaults
in the submodulesconfig history.

This even allows to override any URL defaults for downstream clones
of a superproject repository, by commiting such changes as new
revision in the refs/submodulesconfig history.

Perhaps I am missing something obvious, but a history for project
configuration, completely separate from the project history itself,
seems useful in general to me.

Josef
