From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: jgit problems for file paths with non-ASCII characters
Date: Wed, 25 Nov 2009 22:11:54 +0100
Message-ID: <200911252211.55137.robin.rosenberg@dewire.com>
References: <4B0D356D.1080709@syntevo.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, egit-dev@eclipse.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 22:12:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDP9f-0007Ia-OO
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 22:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933108AbZKYVLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 16:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933040AbZKYVLw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 16:11:52 -0500
Received: from mail.dewire.com ([83.140.172.130]:18172 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932749AbZKYVLv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 16:11:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BD70D80038F;
	Wed, 25 Nov 2009 22:11:56 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z6JELtXzevCc; Wed, 25 Nov 2009 22:11:56 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id E0ECF800387;
	Wed, 25 Nov 2009 22:11:55 +0100 (CET)
User-Agent: KMail/1.11.4 (Linux/2.6.28-11-generic; KDE/4.2.4; i686; ; )
In-Reply-To: <4B0D356D.1080709@syntevo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133675>

onsdag 25 november 2009 14:47:25 skrev  Marc Strapetz:
> I have noticed that jgit converts file paths to UTF-8 when querying the
> repository. Especially,
> org.eclipse.jgit.treewalk.filter.PathFilter#PathFilter performs this
> conversion:
>
>   private PathFilter(final String s) {
>     pathStr = s;
>     pathRaw = Constants.encode(pathStr);
>   }
>
> Because of this conversion, a TreeWalk fails to identify a file with
> German umlauts. When using platform encoding to convert the file path to
> bytes:
>
>   private PathFilter(final String s) {
>     pathStr = s;
>     pathRaw = s.getBytes();e pr
>   }
>
> the TreeWalk works as expected. Actually, the file path seems to be
> stored with platform encoding in the repository.
>
> Is this a bug or a misconfiguration of my repository? I'm using jgit
> (commit e16af839e8a0cc01c52d3648d2d28e4cb915f80f) on Windows.

A bug. 

The problem here is that we need to allow multiple encodings since there
is no reliable encoding specified anywhere. The approach I advocate is
the one we use for handling encoding in general. I.e. if it looks like UTF-8,
treat it like that else fallback. This is expensive however and then we have
all the other issues with case insensitive name and the funny property that
unicode has when it allows characters to be encoding using multiple sequences
of code points as empoloyed by Apple.

-- robin


-- robin
