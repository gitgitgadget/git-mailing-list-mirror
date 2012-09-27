From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/7] Extract, test and enhance the logic to collapse
 ../foo paths.
Date: Wed, 26 Sep 2012 19:11:52 -0700
Message-ID: <20120927021152.GE31456@elie.Belkin>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-4-git-send-email-schwern@pobox.com>
 <20120730195108.GA20137@dcvr.yhbt.net>
 <5016F2A5.1090102@pobox.com>
 <20120926194504.GA5013@elie.Belkin>
 <20120926205851.GA2166@dcvr.yhbt.net>
 <20120926213831.GB30131@elie.Belkin>
 <20120926215429.GA4637@dcvr.yhbt.net>
 <20120926224307.GA31456@elie.Belkin>
 <20120927001506.GA9515@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 04:12:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH3aB-0001nH-Oy
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 04:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888Ab2I0CL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 22:11:57 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55106 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab2I0CL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 22:11:57 -0400
Received: by padhz1 with SMTP id hz1so915131pad.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 19:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qip5ed8e9snwUzu9xypUbLHn/S5jlWxdHf8cVNBZeIo=;
        b=tViG29kgvHl8G4reRcEILEV+qwfN09sVGt6KdEQtt8OQZNkiTpfAiKqSX6E+WUXEab
         d0TJXpQGOa/TI1wOg3q1z5V9tRE7jsWcwE4OA6ioNRZQn17+I6Bf1C+yJRv5RB8t8qmM
         qGF/JIUxsl8DaAMpGTYmQ15t5uj/KU/3c/JCLaWfvsxMDITi7sZ+Y0So/Tonvc1Dg2IA
         ckG/GUQu9mSrD4QF+2ytfmPIAVgzpA3vxyU1PxX574RV4D2E2NYSesR38uwyTGnrQ+wV
         b6MpHu4zGKzw+xkgCSX2xvUDE3viuKOQeLjnLDseOcAQYpD0LSHGEWNY9+sTZHzx7O8k
         TGKg==
Received: by 10.68.240.66 with SMTP id vy2mr7311473pbc.73.1348711916620;
        Wed, 26 Sep 2012 19:11:56 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id iv7sm2973089pbc.68.2012.09.26.19.11.54
        (version=SSLv3 cipher=OTHER);
        Wed, 26 Sep 2012 19:11:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120927001506.GA9515@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206458>

Eric Wong wrote:

> Ideally, yes.  Is there an easy way to access that from Perl? (and
> for the older versions of SVN folks people are running).

Subversion's swig bindings only wrap a few apr functions and do not
depend on fuller apr bindings.

Something like svn_dirent_is_under_root() could be useful.  It uses
whatever base path you choose.  I haven't tried using base_path=""
yet.  New in Subversion 1.7, but that would be ok --- an imperfect
fallback for older Subversion versions would be fine.

Unfortunately, from swig/core.i: "SWIG can't digest these functions
yet, so ignore them for now. TODO: make them work."

svn_client_args_to_target_array2() is exposed and would probably be
perfect.  I can't seem to find how to create an apr_array_header_t
to pass as its first argument, alas.

> Perhaps we can expose equivalent functionality in git via
> git-rev-parse instead?

It might be possible to add a git-svn--helper command that links to
libsvn or apr, but ick.  The trouble is it's not clear at all how
Subversion's perl API was *designed* to be used.

Hm.
Jonathan
