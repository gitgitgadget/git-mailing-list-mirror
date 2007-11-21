From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] autoconf: Add tests for memmem, strtoumax and mkdtemp functions
Date: Wed, 21 Nov 2007 01:58:58 -0500
Message-ID: <20071121065858.GU14735@spearce.org>
References: <200711191947.05960.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 07:59:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IujYa-0006qV-DF
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 07:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbXKUG7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 01:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbXKUG7E
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 01:59:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55277 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbXKUG7D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 01:59:03 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IujY3-0003X1-Sg; Wed, 21 Nov 2007 01:59:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C02F920FBAE; Wed, 21 Nov 2007 01:58:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200711191947.05960.jnareb@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65604>

Jakub Narebski <jnareb@gmail.com> wrote:
> By the way, do you have idea how to test for the following
> in configure.ac:
> 
> * Define NO_PREAD if you have a problem with pread() system call (e.g.
>   cygwin.dll before v1.5.22).
> 
>   - what is the problem? how to detect it?

This also appears to be broken on HP-UX (e.g. we need to set
NO_PREAD there).  Thiago on IRC talked about this the other day
when he was trying to build git on a bunch of different systems.

Unfortunately this may just need to be an OS based test.  The code
compiles just fine but when index-pack tries to use pread to walk
back through the deltas and generate their SHA-1s it barfs without
an error code.  I suspect the failure is pread claiming it put the
data into the user buffer but not actually doing so, which causes
zlib's inflate() to then see data corruption.

Ouch.

-- 
Shawn.
