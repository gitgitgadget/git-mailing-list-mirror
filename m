From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCH] git-svn: use YAML format for mergeinfo cache when
 possible
Date: Sun, 27 May 2012 20:14:50 +0000
Message-ID: <20120527201450.GA3630@dcvr.yhbt.net>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
 <20120527192541.GA29490@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 22:15:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYjrj-0003O9-Sl
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 22:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202Ab2E0UOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 16:14:53 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38776 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160Ab2E0UOw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 16:14:52 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328201F4C8;
	Sun, 27 May 2012 20:14:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120527192541.GA29490@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198618>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> My personal motivation is the ability to upgrade or downgrade perl or
> change perl's use64bitint compile-time parameter without having to
> invalidate caches or (worse, what users unaware of .git/svn/.caches
> would probably do) reclone repositories.  The Storable format is not
> stable enough for forward-compatibility.
> 
> Seems to work.  I haven't run any benchmarks.  
> 
> Thoughts?  Improvements?
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Seems reasonable, a few comments below.

>  git-svn.perl |  126 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---

> +package Git::SVN::Memoize::YAML;

Can we use this as an opportunity to start splitting git-svn.perl into
multiple .pm files?  Thanks.

> +	my $truehash = (-e $filename) ? YAML::Any::LoadFile($filename) : {};

> +	YAML::Any::DumpFile($self->{FILENAME}, $self->{H});

These should die on errors, right?

> +=head1 BUGS

> +Error handling is awkward.

How so?
