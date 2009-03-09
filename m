From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PoC PATCH JGIT 0/2] Proof of concept code for Git Freenet
	transport
Date: Mon, 9 Mar 2009 07:59:55 -0700
Message-ID: <20090309145955.GB11989@spearce.org>
References: <1236569765-8882-1-git-send-email-j16sdiz+freenet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: devl@freenetproject.org, git@vger.kernel.org
To: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 16:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lggyu-0004Cw-2g
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 16:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbZCIO77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 10:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbZCIO76
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 10:59:58 -0400
Received: from george.spearce.org ([209.20.77.23]:44722 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbZCIO75 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 10:59:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1E22538211; Mon,  9 Mar 2009 14:59:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1236569765-8882-1-git-send-email-j16sdiz+freenet@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112700>

"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com> wrote:
> 
> Here is some proof-of-concept code for Git-over-Freenet.
> I am sending this to see the feedback from communities.

Interesting!

I'm quite open to bringing this into JGit itself, so long as it
doesn't cause us to import 42 other libraries that we don't need.

:-)
 
> FIXME:
>  - How to store the private key of repository?
>    Currently, we use URI of form fcp://SSK@<public key>^<private key>/some-id
>    This is quite ugly. Could we use a per remote Config ? How can I get remote
>    name from transport?

Use something like amazon-s3 does, where there is a file path under
~/ specified by the host part of the URI, and store the data there?

I did that rather than storing into ~/.gitconfig or GIT_DIR/config
as the private key really should remain private.  Chmod'ing your
config file to be private is a pain, and "git config" last I checked
wouldn't preserve the permissions when it modified the file for you.

That said, the Transport API in JGit doesn't get access to the
RemoteConfig it was created with, because it isn't always made
from a remote (e.g. you can pass the URIish on the command line).
We could however optionally expose it, but in general I prefer
to make everything that can be obtained via the RemoteConfig be
settable without one, so it can also come through from the CLI
or some higher-level GUI.
 
>  - Make pushing async, could we?

I'm not sure I understand that.  Do you want to background the push
task?  Isn't that what your shell is for?  Or do you want to perform
the writes in an async fashion in parallel, to reduce the latency?

-- 
Shawn.
