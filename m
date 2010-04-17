From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v5] gitk: Use git-difftool for external diffs when git
 >= 1.7.0
Date: Sat, 17 Apr 2010 18:52:30 +1000
Message-ID: <20100417085230.GC6681@brick.ozlabs.ibm.com>
References: <20100408090211.GA31594@gmail.com>
 <1270717690-32133-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 10:56:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O33p4-0007ew-UZ
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 10:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988Ab0DQI4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 04:56:11 -0400
Received: from ozlabs.org ([203.10.76.45]:54232 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851Ab0DQI4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 04:56:09 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id A9E2CB7D0E; Sat, 17 Apr 2010 18:56:08 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <1270717690-32133-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145125>

On Thu, Apr 08, 2010 at 02:08:10AM -0700, David Aguilar wrote:

> git-difftool is used instead of the built-in external diff
> code when git is >= 1.7.0.  git-difftool's '--extcmd=frotz'
> feature was first introduced in 1.7.0 and is the mechanism
> through which we launch the configured difftool.
> 
> A benefit of this change is that gitk's external diff feature
> no longer needs write-access to the current directory.

I applied this one, and in testing it I noticed that if the git
difftool invocation fails, for example because the user doesn't have
meld installed, there is no notification via the GUI.  Instead an
error message is printed to stderr.  We need to do something more like
what we do in the old-git case -- use open rather than exec -- and pop
up an error dialog with error_popup on error so that the user knows
what the problem is.

Another minor problem is that the file names that meld (or other diff
tool) displays are less informative now.  For example I see
"KyaZ5d_gitk : 8iucke_gitk" as the tab label in meld instead of the
"[87d24ec87abc...e236e0833ff] gitk" label that we got before, which
was a little more informative, though the e236e0833ff is the end of
the second SHA1 rather than the beginning.

So I backed it out.  The error handling needs to be fixed using
something like what delete_at_eof does (except that obviously we don't
have any files to delete).

Paul.
