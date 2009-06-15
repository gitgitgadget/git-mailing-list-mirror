From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: egit and RSA keys for SSH
Date: Mon, 15 Jun 2009 08:03:41 -0700
Message-ID: <20090615150341.GX16497@spearce.org>
References: <F2969C1B08CBEE42B78C04C280D578E72CAF41E19B@donkey.landcare.ad.landcareresearch.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Aaron Hicks <HicksA@landcareresearch.co.nz>
X-From: git-owner@vger.kernel.org Mon Jun 15 17:03:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGDiu-0007y1-V2
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 17:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbZFOPDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 11:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbZFOPDj
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 11:03:39 -0400
Received: from george.spearce.org ([209.20.77.23]:59171 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbZFOPDi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 11:03:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2DB55381FF; Mon, 15 Jun 2009 15:03:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <F2969C1B08CBEE42B78C04C280D578E72CAF41E19B@donkey.landcare.ad.landcareresearch.co.nz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121612>

Aaron Hicks <HicksA@landcareresearch.co.nz> wrote:
> We have a git repository set up with gitosis and it requires RSA
> keys to authenticate developers who have rights to push to this
> repository. i.e. they are blessed with write privileges. Github
> uses a similar method.
> 
> We use Eclipse, so we would like Eclipse to integrate with Git. So
> we grabbed egit from http://www.jgit.org/update-site and used the
> Eclipse installer (Like we do all the other Eclipse plug-in, given
> that the egit/jgit sites don't give instructions otherwise it seems
> to be the thing to do).
> 
> The problem is I can't see how to associate an RSA key in order
> to authenticate the SSH login with our gitosis repository (or
> GitHub). We have PuTTY installed and use Pageant to manage keys, and
> the required key is already loaded.

Unfortunately both PuTTY's Pageant and OpenSSH's ssh-agent are
not supported from JSch, which is the SSH client used within JGit,
which is what is underneath EGit.  Consequently, you can't use the
agent to manage your keys.

>From within Eclipse, if you go to Window > Preferences > General >
Network Connections > SSH2 you can configure your RSA keys.  But,
these keys are configured globally for the workspace, i.e. its
more like loading the key into the agent than it is about binding
a particular key to a particular host.

To force binding a key to a host, use ~/.ssh/config.  JGit knows
how to read this file on startup and uses the Host blocks to do
some configuration control over the connection.

E.g. if you use a URL like "git@gitserver.example.com:foo.git"
then you can put the following in your ~/.ssh/config to force using
a specific SSH key:

  Host gitserver.example.com
    IdentityFile .ssh/id_gitkey

Note that ~/.ssh/config is cached on startup of EGit, so you'll
need to completely restart the Eclipse workspace after making any
changes to it.

-- 
Shawn.
