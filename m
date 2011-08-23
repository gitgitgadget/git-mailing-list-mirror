From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Destroy the cache when we fail to read it
Date: Tue, 23 Aug 2011 08:15:46 +0000
Message-ID: <20110823081546.GA28091@dcvr.yhbt.net>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jason Gross <jgross@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Aug 23 10:15:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvm9L-0001gI-5F
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 10:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648Ab1HWIPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 04:15:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33353 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124Ab1HWIPr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 04:15:47 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C0B2101A;
	Tue, 23 Aug 2011 08:15:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1313979422-21286-1-git-send-email-jgross@mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179928>

Jason Gross <jgross@MIT.EDU> wrote:
>  		my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";

Can we make the caches sharable by encoding variables like
$Config{use64bitint} and $Storable::VERSION into $cache_path?

Something like this (untested):

	use Config;

	my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
	$cache_path .= "$Config{use64bitint}.$Storable::VERSION/";

We'll blow everybody's cache away once during the git-svn upgrade, but
in the future people will be able to share the same working tree between
different versions of perl/Storable/whatnot without needing extra code
to detect croaks, different build options, and nuking each other's
caches.

-- 
Eric Wong
