From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Allow git-shell to be used as a ssh forced-command
Date: Sat, 18 Apr 2009 01:44:25 +0200
Message-ID: <20090417234425.GC17753@glandium.org>
References: <1239916256-10878-1-git-send-email-mh@glandium.org> <37fcd2780904170924t61168a49uf1800098cdb1d730@mail.gmail.com> <20090417194919.GA7611@glandium.org> <37fcd2780904171400uf9d1f36g4d24e02aebf6ac3f@mail.gmail.com> <20090417223649.GA1881@glandium.org> <20090417224104.GT23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 18 01:46:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luxl8-0007u3-9G
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 01:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbZDQXog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 19:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbZDQXof
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 19:44:35 -0400
Received: from vuizook.err.no ([85.19.221.46]:35663 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007AbZDQXof (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 19:44:35 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LuxjO-00036u-JB; Sat, 18 Apr 2009 01:44:29 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LuxjN-0004d2-Jg; Sat, 18 Apr 2009 01:44:25 +0200
Content-Disposition: inline
In-Reply-To: <20090417224104.GT23604@spearce.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116804>

On Fri, Apr 17, 2009 at 03:41:04PM -0700, Shawn O. Pearce wrote:
> Mike Hommey <mh@glandium.org> wrote:
> > On Sat, Apr 18, 2009 at 01:00:35AM +0400, Dmitry Potapov wrote:
> > > Besides, you made SSH_ORIGINAL_COMMAND to take precedent over explicitly
> > > specified parameters given to git-shell. Maybe it should be the other
> > > way around?
> > 
> > If SSH_ORIGINAL_COMMAND is set, which means forced-commands are in use,
> > I don't see why other parameters should be more important.
> 
> Gitosis runs by forced-command, and invokes git-shell to get to
> the real requested git command.  I'm not sure if it unsets the
> SSH_ORIGINAL_COMMAND environment variable before launching the
> git-shell...
> 
> But, in git, command line arguments override environment variables,
> which in turn override config files, which override any defaults
> that may be guessed from the host.  So Dimtry is asking that you
> follow that same convention.

Except SSH_ORIGINAL_COMMAND is not a traditional environment variable
like GIT_USER_EMAIL or such. SSH_ORIGINAL_COMMAND is the only way to
know from a ssh forced-command what the remote wanted to call
originally. Setting a forced-command with options after git-shell, which
would have to be "-c something" or "cvs server", is pointless, because
you don't need it and should put that "something" as forced-command directly.

However, the patch in its current form will definitely break gitosis if
it doesn't unset SSH_ORIGINAL_COMMAND.

Mike
