From: Yann Dirson <ydirson@altern.org>
Subject: Re: [BUG] stgit: unexpected "unknown user details" on refresh
Date: Fri, 5 Jan 2007 23:29:44 +0100
Message-ID: <20070105222944.GA6179@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070104232224.GA12756@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701050107s21ec8527ud89425df4772998@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 23:29:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2xZT-0000JY-DE
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 23:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbXAEW3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 17:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbXAEW3t
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 17:29:49 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:45646 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbXAEW3s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 17:29:48 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 33D264A0E3;
	Fri,  5 Jan 2007 23:29:47 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 100EF1F08C; Fri,  5 Jan 2007 23:29:45 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0701050107s21ec8527ud89425df4772998@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36031>

On Fri, Jan 05, 2007 at 09:07:51AM +0000, Catalin Marinas wrote:
> It probably tries to set the author information for the patch and
> GIT_AUTH* or GIT_COMMIT* aren't set but it would be probably useful to
> get the full backtrace of this error (at the end of the stgit/main.py
> file, just add a "raise" before sys.exit(2)).

Email vars are set, name is taken (by git) from GECOS.  Apparently
StGIT does not use the latter.  It would surely be more user-friendly
to use it, as much for providing a (hopefully) sane default as to get
a behaviour consistent with GIT.

$ env|grep GIT
GIT_COMMITTER_EMAIL=ydirson@altern.org
GIT_AUTHOR_EMAIL=ydirson@altern.org

As you expected:

Traceback (most recent call last):
  File "./stg", line 43, in ?
    main()
  File "/export/work/yann/git/stgit/stgit/main.py", line 262, in main
    command.func(parser, options, args)
  File "/export/work/yann/git/stgit/stgit/commands/refresh.py", line 145, in func
    backup = True, sign_str = sign_str)
  File "/export/work/yann/git/stgit/stgit/stack.py", line 674, in refresh_patch
    patch.set_authdate(author_date)
  File "/export/work/yann/git/stgit/stgit/stack.py", line 265, in set_authdate
    self._set_field('authdate', date or git.author().date)
  File "/export/work/yann/git/stgit/stgit/git.py", line 475, in author
    __author = user()
  File "/export/work/yann/git/stgit/stgit/git.py", line 457, in user
    raise GitException, 'unknown user details'
stgit.git.GitException: unknown user details

Best regards,
-- 
Yann.
