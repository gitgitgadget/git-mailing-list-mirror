From: Mike Hommey <mh@glandium.org>
Subject: Re: FW: git via http protocol _and_ a proxy using NTLM
	authentication -- git 1.5.4.2 & curl 7.18.0
Date: Fri, 29 Feb 2008 21:32:20 +0100
Organization: glandium.org
Message-ID: <20080229203220.GB27217@glandium.org>
References: <AA28F077645B324881335614E4F7C428034C15@win-ex01.bench.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Ken.Fuchs@bench.com
X-From: git-owner@vger.kernel.org Fri Feb 29 22:11:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVCW8-0003Nu-8V
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 22:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760968AbYB2VLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 16:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760099AbYB2VLH
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 16:11:07 -0500
Received: from vuizook.err.no ([194.24.252.247]:34748 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757420AbYB2VLG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 16:11:06 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVBqf-0001Jc-MT; Fri, 29 Feb 2008 21:29:00 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVBu0-0007Ew-8T; Fri, 29 Feb 2008 21:32:20 +0100
Content-Disposition: inline
In-Reply-To: <AA28F077645B324881335614E4F7C428034C15@win-ex01.bench.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75564>

On Fri, Feb 29, 2008 at 02:06:49PM -0600, Ken.Fuchs@bench.com wrote:
> > On Thu, 28 Feb 2008, Ken.Fuchs@bench.com wrote:
> > 
> > > Unfortunately, this will not work because "git clone" is
> > > implemented by git-clone.sh and has no support for dealing
> > > with proxies at all.
> > 
> > I fail to see why git-clone.sh, which uses git http-fetch 
> > directly, should behave differently from git fetch, which
> > uses git http-fetch directly.
> 
> Sorry, I wasn't very clear.  When I said "git fetch" works, I meant
> only the proxy is initiated properly.  "git fetch" itself still fails:
> 
> fatal: Couldn't find remote ref HEAD 
> 
> As I understand it, this is due to "git clone" failing earlier.
> 
> > I strongly suspect that you did not even try what I suggested.
> 
> I know you were trying to help.  I sincerely regret not thanking
> you in my earlier response to your suggestion.  However, I had
> already tried your suggestion over a week ago (plus numerous
> user-id:password variants of the http_proxy environment variable).
> I also tried "git config http.proxy <proxy.domain>:<proxy-port>".
> I did not try "git config remote.<name>.proxy" which had an issue
> that was recently fixed via a patch submission a few days ago.
> 
> > > So it seems that git's http protocol via a proxy isn't completely 
> > > supported.
> > 
> > If that should really be the case, well, Git is a programmers' tool,
> so 
> > you should be perfectly able to find out what is happening _exactly_.
> 
> Well, all git http proxy stuff is handled by curl, so GIT_CURL_VERBOSE=1
> should get us pretty close to "what is happening _exactly_":
> 
> $ GIT_CURL_VERBOSE=1 git clone http://www.kernel.org/pub/scm/git/git.git
> Initialized empty Git repository in /mnt/nfs/git/test-git/git/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?
> $

git clone is a shell script and doesn't put all the wrap-up around curl.
GIT_CURL_VERBOSE is of no effect, and git http proxy settings won't work.
Only http_proxy environment variable will work.

You can try modifying git-clone and add --proxy-ntlm or --proxy-anyauth
to curl calls, and set the http_proxy environment variable.

Alternatively, you can try again with (work in progress) builtin-clone.c.
http://thread.gmane.org/gmane.comp.version-control.git/75070/focus=75126

Mike
