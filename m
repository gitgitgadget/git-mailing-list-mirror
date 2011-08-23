From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-svn: Destroy the cache when we fail to read it
Date: Mon, 22 Aug 2011 21:36:37 -0500
Message-ID: <20110823023637.GB4623@elie.gateway.2wire.net>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823022717.GA4623@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jason Gross <jgross@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Aug 23 04:36:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvgr8-0002Fh-HN
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 04:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565Ab1HWCgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 22:36:42 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64248 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab1HWCgl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 22:36:41 -0400
Received: by qwk3 with SMTP id 3so3319450qwk.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 19:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LofbLur+PD1wLMKfj8GK52cQBFc0EUTfrFSOoJOuSJs=;
        b=DcRDjGMG4CQN7Yc+rrx4sS1Icc6J3rh9HQZAdKuiMasurWE23WGET5Mja2lb5PB43t
         T+76hbAbDdFSnddFwoMOb3K8eU7/gckHQ3YA16jQyx/TpaKC5sxtUwdClnjstApBnvtE
         ARYOBSxi/O2FIUrDWhzTXNt9ytnrRYMlyvp3o=
Received: by 10.224.188.135 with SMTP id da7mr1807703qab.131.1314067000783;
        Mon, 22 Aug 2011 19:36:40 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-106-27.dsl.chcgil.ameritech.net [68.255.106.27])
        by mx.google.com with ESMTPS id h16sm1299676qct.20.2011.08.22.19.36.39
        (version=SSLv3 cipher=OTHER);
        Mon, 22 Aug 2011 19:36:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110823022717.GA4623@elie.gateway.2wire.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179914>

Jonathan Nieder wrote:

> [This patch teaches "git svn" to invalidate caches when they
>  fail to load, for example because the endianness or size of
>  some type changed, which is common in the perl 5.6 -> 5.8
>  upgrade.]

Erm, actually it showed up in the perl 5.10 -> 5.12 upgrade in Debian,
due to use of -Duse64bitint when compiling the latter and not the
former[1].

To summarize:

 - "$Storable::interwork_56_64bit = 1;" can be used to work around
   that particular brand of breakage;

 - The interwork_* option does not take care of similar cases in which
   a git-svn repository is generated on one machine and read by
   another[2], though.

Hence my happiness at the arrival of Jason's patch.

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=32;bug=618875
[2] http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=20;bug=587650
