From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] svn test: escape peg revision separator using empty
 peg rev
Date: Wed, 10 Oct 2012 14:02:18 -0700
Message-ID: <20121010210218.GB4517@elie.Belkin>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <1343468872-72133-2-git-send-email-schwern@pobox.com>
 <20120728141652.GA1603@burratino>
 <50143E34.8090802@pobox.com>
 <20121009084145.GA19784@elie.Belkin>
 <5073F2C0.6000504@drmicha.warpmail.net>
 <20121009101953.GB28120@elie.Belkin>
 <20121010203730.GA19115@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Torsten Schmutzler <git-ts@theblacksun.eu>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:02:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM3QI-0002DV-9s
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 23:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab2JJVCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 17:02:23 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40047 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab2JJVCX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 17:02:23 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1016450pad.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 14:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kCWnw8nWgUNdAqQrzuwlvRm8rq6WdjJ39pThfzae1uI=;
        b=ZQh+IvRiTaP1mJkiGglE0UfrUMSeL9vUloUb6pfsDWJuL0Cmddf8DJpTv+vHcrD+kH
         b5dqb6vAKqOUi8NxpTjg+Xv6WSXmjrPqlZvDtmxPQgdsxeEbZ4b8xgnew2ntgvw4qAch
         XdwdIXrTicVypqcWBmzO7z+2Rsz33Xcz4ar0U173FNYaHL/sqpUEb3YN+DPhHiIB3EJh
         FRQrViLgHTRhkkbGgw7I1ZuVVcnzElIGr/8fhAH3KQ4tQqlRKN+ggYPrANQ7Y+shr6xc
         CF/DPeaDSYtbS4s9J+YJ0MU1twvzRLl0mKehSkt+em48/Vs15VyhTCn1qRJX8r7gxr4C
         94RA==
Received: by 10.68.226.136 with SMTP id rs8mr37319590pbc.153.1349902942647;
        Wed, 10 Oct 2012 14:02:22 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id tw5sm1532780pbc.48.2012.10.10.14.02.20
        (version=SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 14:02:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121010203730.GA19115@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207441>

Eric Wong wrote:

> Thanks both.  Also pushed to "master" on git://bogomips.org/git-svn.git
> (commit 44bc5ac71fd99f195bf1a3bea63c11139d2d535f)
>
> Jonathan Nieder (2):
>       git svn: work around SVN 1.7 mishandling of svn:special changes
>       svn test: escape peg revision separator using empty peg rev

Thanks.  Here's the $deletions nit as a patch on top.

-- >8 --
Subject: Git::SVN::Editor::T: pass $deletions to ->A and ->D

This shouldn't make a difference because the $deletions hash is
only used when adding a directory (see 379862ec, 2012-02-20) but
it's nice to be consistent to make reading smoother anyway.  No
functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 perl/Git/SVN/Editor.pm |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index 3bbc20a0..178920c8 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -358,12 +358,12 @@ sub T {
 			mode_a => $m->{mode_a}, mode_b => '000000',
 			sha1_a => $m->{sha1_a}, sha1_b => '0' x 40,
 			chg => 'D', file_b => $m->{file_b}
-		});
+		}, $deletions);
 		$self->A({
 			mode_a => '000000', mode_b => $m->{mode_b},
 			sha1_a => '0' x 40, sha1_b => $m->{sha1_b},
 			chg => 'A', file_b => $m->{file_b}
-		});
+		}, $deletions);
 		return;
 	}
 
-- 
1.7.10.4
