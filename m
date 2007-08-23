From: "Josh England" <jjengla@sandia.gov>
Subject: tracking perms/ownership [was: empty directories]
Date: Thu, 23 Aug 2007 15:51:19 -0600
Message-ID: <1187905879.5986.199.camel@beauty>
References: <1187716461.5986.71.camel@beauty>
 <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty>
 <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 23:50:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOKZd-0006oD-Gx
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 23:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761474AbXHWVui (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 17:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760979AbXHWVui
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 17:50:38 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:4078 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760074AbXHWVug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 17:50:36 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Thu, 23 Aug 2007 15:50:24 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l7NLoNtL025662;
 Thu, 23 Aug 2007 15:50:23 -0600
In-Reply-To: <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.311128,
 Antispam-Data: 2007.8.23.142624
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070823215024; SEV=2.2.2; DFV=B2007082316;
 IFV=2.0.4,4.0-9; AIF=B2007082316; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230322E34364345303131462E303033413A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007082316_5.02.0125_4.0-9
X-WSS-ID: 6AD0DEAA3HO172389-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56536>

On Wed, 2007-08-22 at 16:25 -0700, Linus Torvalds wrote:
> But if .gitattributes would work, you probably could introduce both full 
> permissions and ownership rules there. We read git attributes for *other* 
> reasons when checking files out _anyway_, ie we need the CRLF attribute 
> stuff, so adding ownership attributes would not be at all odd.

So here's the initial thought.  Create two new gitattributes, 'perms'
and 'ownership', which will track perms/ownership for files matching the
given pattern.

Looking at the index struct, it already has fields in it for file mode
uid and gid (woohoo!).  It looks like an addition to
builtin-update-index.c could set those fields (if the gitattribute is
set) the same way as how the execute bit is flipped with chmod_path().
I haven't found where the chmod is done at checkout/clone time, but the
question is:  If the mode, uid, and gid are stuffed in the index, will
git diff simply just work to recognize permission/ownership changes?  Is
this the right approach? What kind of merging issues will need to be
worried about?

-JE
