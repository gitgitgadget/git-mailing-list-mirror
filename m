From: Arafangion <thestar@fussycoder.id.au>
Subject: Re: git and mtime
Date: Wed, 19 Nov 2008 23:37:32 +1100
Message-ID: <1227098252.11370.8.camel@therock.nsw.bigpond.net.au>
References: <20081119113752.GA13611@ravenclaw.codelibre.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 15:50:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2oO3-0004dD-Dy
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 15:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbYKSOtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 09:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbYKSOtU
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 09:49:20 -0500
Received: from nschwqsrv03p.mx.bigpond.com ([61.9.189.237]:48045 "EHLO
	nschwqsrv03p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753339AbYKSOtT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Nov 2008 09:49:19 -0500
Received: from nschwotgx01p.mx.bigpond.com ([58.173.132.215])
          by nschwmtas06p.mx.bigpond.com with ESMTP
          id <20081119122722.IBOM1799.nschwmtas06p.mx.bigpond.com@nschwotgx01p.mx.bigpond.com>;
          Wed, 19 Nov 2008 12:27:22 +0000
Received: from therock.local ([58.173.132.215])
          by nschwotgx01p.mx.bigpond.com with ESMTP
          id <20081119122718.EBWP1935.nschwotgx01p.mx.bigpond.com@therock.local>;
          Wed, 19 Nov 2008 12:27:18 +0000
In-Reply-To: <20081119113752.GA13611@ravenclaw.codelibre.net>
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150205.49240626.00E0,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101350>

On Wed, 2008-11-19 at 11:37 +0000, Roger Leigh wrote:
<snip>
> different systems).  However, the fact that git isn't storing the
> mtime of the files confuses make, so it then tries to regenerate these
> (already up-to-date) files, and fails in the process since the tools
> aren't available.

Unless I'm mistaken, I was under the impression that the reason why git
doesn't, and shouldn't do this is _because_ it confuses make.

Suppose you've got two branches, and you check out the other branch,
resulting in changes in 3 files.  Should git go and modify the mtime for
every single file, and remove any file that isn't part of the repo (Such
as generated object files)?

If it modifies the dates on every file, but doesn't remove the generated
object files, how does make handle that, as it'll likely generate some
of the object files, but not all of them.

If it doesn't, but touches the files that changed, and the dates are now
older than the corresponding object files, make would fail to recompile
the project properly!

The only way this could work is if you never switch branches, which is
quite limiting for git, and never check out an older revision, which is
quite limiting for the RCS systems in general.

You should probably fix your build script, or add a hook script that
sets the dates on the files in question manually, but the former
solution would be much better.
