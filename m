From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: GIT 0.99.8d
Date: Sun, 16 Oct 2005 10:24:37 -0400
Organization: me
Message-ID: <200510161024.37873.tomlins@cam.org>
References: <7vachadnmy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751319AbVJPOYo@vger.kernel.org Sun Oct 16 16:26:45 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751319AbVJPOYo@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ER9Rw-0000Fz-EA
	for glk-linux-kernel-3@gmane.org; Sun, 16 Oct 2005 16:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVJPOYo (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 16 Oct 2005 10:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVJPOYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 10:24:44 -0400
Received: from mail.aei.ca ([206.123.6.14]:52450 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1751308AbVJPOYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 10:24:43 -0400
Received: from grover (dsl-155-76.aei.ca [66.36.155.76])
	by aeimail.aei.ca (8.12.10/8.12.10) with ESMTP id j9GEOVhZ016045;
	Sun, 16 Oct 2005 10:24:32 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.2
In-Reply-To: <7vachadnmy.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10157>

Hi,

Debian users beware.  This version introduces a dependency - package: 
libcurl3-gnutls-dev
is now needed to build git.

Thanks
Ed Tomlinson

On Sunday 16 October 2005 01:41, Junio C Hamano wrote:
> GIT 0.99.8d is available as usual at:
> 
>     RPMs and tarball: www.kernel.org:/pub/software/scm/git/
>     Debs and tarball: www.kernel.org:/pub/software/scm/git/debian/
> 
> In addition to accumulated bugfixes, there is one important
> futureproofing changes.
> 
> The "master" branch has changes to git-upload-pack (which would
> affect what git-fetch-pack/git-clone-pack see) and
> git-update-server-info (which would affect what fetch and clone
> over http:// transport see) to send extra information about the
> available references, so that the clients can find out what
> objects are referenced by remote tags before downloading them.
> They take the form of "tagname^{}".  "git ls-remote $repository"
> command would show something like this:
> 
>     7a3ca7d2b5ec31b2cfa594b961d77e68075e33c7        refs/heads/master
>     5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c        refs/tags/v2.6.11-tree
>     c39ae07f393806ccf406ef966e9a15afc43cc36a        refs/tags/v2.6.11-tree^{}
>     ...
>     c2bbf523f1d454649897b3e4bcd71778e4fa5913        refs/tags/v2.6.14-rc2
>     676d55ae30ea3b688f0386f70553489f25f24d55        refs/tags/v2.6.14-rc2^{}
>     f92737b18abac90af30ac26a050fda879c9b238b        refs/tags/v2.6.14-rc3
>     1c9426e8a59461688bb451e006456987b198e4c0        refs/tags/v2.6.14-rc3^{}
> 
> when the server side updates to the version in the "master"
> branch.  These "^{}" entries describe the SHA1 of the object the
> tag object points at (so v2.6.11-tree tag, whose object name is
> 5dc01c... points at a tree object whose object name is
> c39ae0...).
> 
> The downloading clients (git-clone and git-fetch) in the
> "master" branch have been taught to recognize these entries;
> after all, these are not real refs and you cannot give them to
> git-http-fetch to fetch from.  GIT 0.99.8d clients have the same
> change, so that people staying with the maintenance branch can
> download from the server that already runs the "master" version
> and sends these fake references without getting confused.
> 
> upload-pack and update-server-info in GIT 0.99.8d would not show
> these extra "fake refs" when used on the server side.  In other
> words, 0.99.8d is to keep the maintenance branch working with
> newer servers.
> 
> There will be GIT 0.99.8e at around the time "master" branch
> will get the updated "git-diff-*", for similar purposes.  The
> updated "git-diff-*" commands deal with pathnames with funny
> characters (most importantly tabs and newlines) in a way
> compatible with the proposed change to GNU patch, which was
> outlined in:
> 
>     http://marc.theaimsgroup.com/?l=git&m=112927316408690&w=2
> 
> The change to "git-diff-*", and corresponding change to
> "git-apply" are cooking in the proposed updates branch right
> now.  When people start generating diffs with them, patches that
> touch paths that have double-quotes '"' or spaces ' ' in them
> need to be applied with the updated git-apply that knows how new
> "git-diff-*" encodes these funny pathnames.  GIT 0.99.8e is
> planned to backport the necessary git-apply changes, in case we
> do not bump the major release number by then.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
