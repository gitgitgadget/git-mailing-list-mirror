From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: do not set setgid bit on directories on
 GNU/kFreeBSD
Date: Sat, 22 Oct 2011 06:11:07 -0500
Message-ID: <20111022111107.GA12130@elie.domain.sunraytvi.com>
References: <20111003064120.GA24396@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	"Christopher M. Fuhrman" <cfuhrman@panix.com>,
	Greg Troxel <gdt@ir.bbn.com>, Stefan Sperling <stsp@stsp.name>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 22 13:11:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHZUD-0004k3-Af
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 13:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab1JVLLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 07:11:17 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40983 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab1JVLLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 07:11:16 -0400
Received: by gyb13 with SMTP id 13so4542078gyb.19
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 04:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qXY0RUJU9Q8LAYOP6gPy4/cB0/wBWlRl0pFsySkMmH4=;
        b=GnoWWJnbDEHYLQcKejEIJ2nEdzGVAnLA/DIFMC4J7mFCI1PopAt0EKHKL6yCzStRxw
         a/7A9OiUAMh7jz4x9NMrhiWsJh6fmiwHFyJIB57y8c77HQir7lijLdzEf2xhVD55By+L
         yEhGUtZOTHX8BfWY//t8e75Mptn6jFwSDsqQ4=
Received: by 10.150.181.11 with SMTP id d11mr16686377ybf.42.1319281875641;
        Sat, 22 Oct 2011 04:11:15 -0700 (PDT)
Received: from elie.domain.sunraytvi.com (67.111.52.130.ptr.us.xo.net. [67.111.52.130])
        by mx.google.com with ESMTPS id p5sm44146104anl.18.2011.10.22.04.11.13
        (version=SSLv3 cipher=OTHER);
        Sat, 22 Oct 2011 04:11:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111003064120.GA24396@elie>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184099>

(people cc-ed: your input would be welcome on [*] below.  See commit
81a24b52, "Do not use GUID on dir in git init --shared=all on FreeBSD"
for context)

Hi Junio,

>From Documentation/RelNotes/1.7.7.1.txt:

 * On some BSD systems, adding +s bit on directories is detrimental
   (it is not necessary on BSD to begin with). The installation
   procedure has been updated to take this into account.

I assume this is referring to 0b20dd8f (Makefile: do not set setgid
bit on directories on GNU/kFreeBSD, 2011-10-03), which admittedly
does have a subject line that suggests it would be about that (sorry
about that).  The change was actually about "git init -s" which sets
the setgid bit on SysV-style systems to allow shared access to a
repository (and can provoke errors on BSD-style systems, depending on
how permissive the filesystem in use wants to be).

More to the point, the patch was just taking a fix that arrived for
FreeBSD in v1.5.5 days and making it also apply to machines using an
(obscure) GNU userland/FreeBSD kernel mixture.

By the way, maybe other BSD-style ports (NetBSD, OpenBSD) should be
setting DIR_HAS_BSD_GROUP_SEMANTICS to get this fix, too[*]?  Then the
release notes could look something like this:

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/RelNotes/1.7.7.1.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git i/Documentation/RelNotes/1.7.7.1.txt w/Documentation/RelNotes/1.7.7.1.txt
index fecfac8a..e3c29ff0 100644
--- i/Documentation/RelNotes/1.7.7.1.txt
+++ w/Documentation/RelNotes/1.7.7.1.txt
@@ -5,8 +5,9 @@ Fixes since v1.7.7
 ------------------
 
  * On some BSD systems, adding +s bit on directories is detrimental
-   (it is not necessary on BSD to begin with). The installation
-   procedure has been updated to take this into account.
+   (it is not necessary on BSD to begin with). "git init --shared"
+   has been updated to take this into account without extra makefile
+   settings on platforms the Makefile knows about.
 
  * After incorrectly written third-party tools store a tag object in
    HEAD, git diagnosed it as a repository corruption and refused to
-- 
