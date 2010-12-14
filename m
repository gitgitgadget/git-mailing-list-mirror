From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 0/5] make open/unlink failures user friendly on windows
 using retry/abort
Date: Tue, 14 Dec 2010 23:06:04 +0100
Message-ID: <20101214220604.GA4084@sandbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 23:06:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSd0i-0002hd-DU
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 23:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329Ab0LNWGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 17:06:10 -0500
Received: from darksea.de ([83.133.111.250]:36994 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752477Ab0LNWGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 17:06:09 -0500
Received: (qmail 21543 invoked from network); 14 Dec 2010 23:06:07 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Dec 2010 23:06:07 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163692>

Hi,

On Wed, Nov 10, 2010 at 09:32:00PM +0100, Johannes Sixt wrote:
> On Dienstag, 9. November 2010, Heiko Voigt wrote:
> > So it seems that unlink also has the problem of getting an
> > ERROR_ACCESS_DENIED (Code 5) sometimes. Johannes would you agree that
> > including this code into the is_file_in_use_error() function and thus
> > having the potential risk of a 71ms delay for real access denials for
> > these calls makes sense?
> 
> Of course, it matches my own observations.

Sorry for the delay. Here is finally a new iteration of the patch
series. I hope I have addressed all raised issues. An extra pair of eyes
is appreciated.

This series has been ported to Junios tree.

I also added one patch from Johannes which I think should be part of
this series.

Cheers Heiko

Heiko Voigt (4):
  mingw: move unlink wrapper to mingw.c
  mingw: work around irregular failures of unlink on windows
  mingw: make failures to unlink or move raise a question
  mingw: add fallback for rmdir in case directory is in use

Johannes Schindelin (1):
  mingw_rmdir: set errno=ENOTEMPTY when appropriate

 compat/mingw.c |  172 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 compat/mingw.h |   14 ++---
 2 files changed, 177 insertions(+), 9 deletions(-)

-- 
1.7.3.3.566.gf422f
