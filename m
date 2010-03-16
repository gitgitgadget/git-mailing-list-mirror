From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [patch 00/15] Portability Patches v3
Date: Tue, 16 Mar 2010 11:03:13 -0500
Message-ID: <2PY18tW3y3KTt2QABeUBfvQDHHcMVjCimIrW5lt7EM3Y9NG6ntwZeA@cipher.nrlssc.navy.mil>
References: <20100316054220.075676000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 17:03:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrZEr-0000JV-Vo
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 17:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759026Ab0CPQDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 12:03:17 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34684 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758944Ab0CPQDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 12:03:16 -0400
Received: by mail.nrlssc.navy.mil id o2GG3EQT021820; Tue, 16 Mar 2010 11:03:14 -0500
In-Reply-To: <20100316054220.075676000@mlists.thewrittenword.com>
X-OriginalArrivalTime: 16 Mar 2010 16:03:13.0852 (UTC) FILETIME=[2ED177C0:01CAC522]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142339>

On 03/16/2010 12:42 AM, Gary V. Vaughan wrote:
> Here are the portability patches we needed at TWW to enable
> git-1.7.0.2 to compile and run on all of the wide range of Unix
> machines we support.  These patches apply to the git-1.7.0.2 release,
> and address all of the feedback from the previous two times I posted
> them to this list, most particularly splitting everything into many
> small self-contained chunks.
> 
> Note that I have not invested the time to figure out why the testsuite
> is mostly useless on everything but Linux and Solaris 8+, because I'm
> reasonably satisfied that the build itself is working properly.  Most
> likely, it is merely GNUisms in the way the test cases call external
> tools.  But maybe I'm missing something, but even the 3 new patches to
> address test errors when diff does not support the -u option don't
> improve the testsuite situation on HPUX, AIX, OSF1 and Solaris 7 and
> older.

Which shell are you using?  If you're trying to use Korn or /usr/xpg4/bin/sh
on Solaris, you'll have problems, but it is possible.  I can send you a
patch.

I have 3 patches that I apply on top of master which allows me to compile and
test on Solaris 7.  I remove all but the first when installing, since it is
necessary to compile and the others are only necessary for the test suite.

  1) Remove const declaration from arrays with non-constant initializers
  2) t5100/*.mbox: use '646' rather than 'us-ascii' for Solaris
  3) t/test-lib.sh: support Korn shell by converting GIT_EXIT_OK to GIT_EXIT_CODE


Here's the config.mak file I use:

GIT_SKIP_TESTS := \
   t1304.3 \
   t3900.2[23] \
   t5000.1[5-79] t5000.2[013-6] t5000.41 \
   t6030.1[23] \
   t8005.[23]

GIT_TEST_CMP = cmp -s

export GIT_SKIP_TESTS GIT_TEST_CMP

SHELL_PATH = /usr/xpg4/bin/sh

# This is an old GNU tar that's why some of the
# tests in t5000? still fail
TAR = /apps/bin/gtar

CC = /opt/SUNWspro/bin/cc

# zlib is installed in /apps
CFLAGS = -fast -native -I/apps/include
LDFLAGS = -L/apps/lib

NO_CURL = 1
NO_TCLTK = 1
NO_OPENSSL = 1
BLK_SHA1 = 1
NO_PYTHON = 1
DEFAULT_PAGER = more

-brandon
