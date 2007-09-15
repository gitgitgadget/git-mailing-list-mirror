From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Sat, 15 Sep 2007 15:56:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709151430040.5298@iabervon.org>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sat Sep 15 21:56:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWdl3-0006cU-HE
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 21:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbXIOT4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 15:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753371AbXIOT4o
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 15:56:44 -0400
Received: from iabervon.org ([66.92.72.58]:48330 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383AbXIOT4o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 15:56:44 -0400
Received: (qmail 12466 invoked by uid 1000); 15 Sep 2007 19:56:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Sep 2007 19:56:42 -0000
In-Reply-To: <20070915145437.GA12875@piper.oerlikon.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58271>

On Sat, 15 Sep 2007, martin f krafft wrote:

> also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2007.09.15.1610 +0200]:
> > No.  Git is a source code management system.  Everything else that
> > you can do with it is a bonus, a second class citizen.  Should we
> > really try to support your use case, we will invariably affect the
> > primary use case.
> 
> I thought git was primarily a content tracker... so it all comes
> down to how to define content, doesn't it? But either way, we need
> not discuss that because that definition depends a lot on context
> and purpose and thus cannot be answered once and for all.
> 
> I understand that for the primary use case, tracking nothing more
> than +x makes sense and should not be interfered with. This is why
> I was proposing a policy-based approach. The primary use case is
> unaffected, it's the default policy. Someone may choose to track
> other mode bits or file/inode attributes, according to one of
> several policies available with git, or even a custom policy. In
> that case, the repository needs to be appropriately configured.

Configuration options only apply to the local aspects of the repository. 
That is, when you clone a repository, you don't get the configuration 
options from it, in general. And changing configuration options on a 
repository does not have any effect on the content it contains. So 
configuration options aren't appropriate.

> The reason why I say this should be done inside git rather than with
> hooks and an external tool, such as metastore is quite simple: git
> knows about every content entity in any tree of a repo and already
> has a data node for each object. Rather than introducing a parallel
> object database (shadow hierarchy or single file), it would make
> a lot more sense and be way more robust to attach additional
> information to these object nodes, wouldn't it?

Git doesn't have any way to represent owners or groups, and they would 
need to be represented carefully in order to make sense across multiple 
computers. If you're adding support for metadata-as-content (for more than 
"is this a script?"), you should be able to cover all of the common cases 
of extended stuff, like AFS-style ACLs. And if you want to allow 
meaningful development with this mechanism (as opposed to just archival of 
a sequence of states of a live system), the normal case will be that the 
metadata beyond +x is manipulated by ordinary users in some way other than 
modifying their working directory. So the normal case here will be like 
working on a filesystem that doesn't support symlinks or an executable bit 
when this is important content.

	-Daniel
*This .sig left intentionally blank*
