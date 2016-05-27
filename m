From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Fri, 27 May 2016 14:12:46 +0900
Message-ID: <20160527051246.GA27092@glandium.org>
References: <20160525020609.GA20123@zoidberg>
 <xmqqh9dm37xk.fsf@gitster.mtv.corp.google.com>
 <20160527044112.GA31742@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Fri May 27 07:13:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6A56-0005mI-RT
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 07:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbcE0FNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 01:13:04 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:48588 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbcE0FND (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 01:13:03 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b6A4k-00079Y-Tp; Fri, 27 May 2016 14:12:46 +0900
Content-Disposition: inline
In-Reply-To: <20160527044112.GA31742@zoidberg>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295732>

On Thu, May 26, 2016 at 11:41:12PM -0500, Edward Thomson wrote:
> On Wed, May 25, 2016 at 12:36:55AM -0700, Junio C Hamano wrote:
> > 
> > At the design level, I have a few comments.
> 
> Thanks, I will submit a new patch that incorporates your (and dscho's)
> comments.
> 
> >  * This is about a repository with core.filemode=0; I wonder if
> >    something for a repository with core.symlinks=0 would also help?
> >    That is, would it be a big help to users if they can prepare a
> >    text file that holds symbolic link contents and add it as if it
> >    were a symlink with "git add", instead of having to run two
> >    commands, "hash-objects && update-index --cacheinfo"?
> 
> I think that this is much less common and - speaking only from personal
> experience - nobody has ever asked me how to stage a symlink on a
> Windows machine.  I think that this is due to the fact that symlinks on
> Windows are basically impossible to use, so people doing cross-platform
> development wouldn't even try.
> 
> On the other hand, it's quite common for cross-platform teams to use
> some scripting language since those do work across platforms, and
> Windows users would want to add new scripts as executable for the
> benefit of their brethren on platforms with an executable bit.
> 
> >  * I am not familiar with life on filesystems with core.filemode=0;
> >    do files people would want to be able to "add --chmod=+x" share
> >    common trait that can be expressed with .gitattributes mechanism?
> 
> Perhaps...  It would not be things like `*.bat` or `*.exe` - Windows
> gets those as executable "for free" and would not care about adding the
> execute bit on those files (since they're not executable anywhere else).
> It would be items like `*.sh` or `*.rb` that should be executable on
> POSIX platforms.
> 
> However I do not think that this is a common enough action that it needs
> to be made automatic such that when I `git add foo.rb` it is
> automatically made executable.

Moreover, *.sh, *.rb, etc. are not necessarily meant to be executables.
The files might be modules, included from executables or other modules.
There's an example of this right in the git tree: t/test-lib.sh. It's
even more typical for *.rb files (or *.py, etc.)

However, the common pattern that /might/ be interesting for automatic
executable bits is files starting with "#!".

Mike
