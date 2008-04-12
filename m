From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [PATCH] Make core.sharedRepository more generic
Date: Sat, 12 Apr 2008 22:46:34 +0300
Message-ID: <20080412194634.GG31039@zakalwe.fi>
References: <20080412185105.GA14331@zakalwe.fi> <2008-04-12-21-15-04+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Heikki Orsila <heikki.orsila@iki.fi>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Sat Apr 12 21:47:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JklhC-0003fG-BW
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 21:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701AbYDLTqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 15:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755559AbYDLTqg
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 15:46:36 -0400
Received: from zakalwe.fi ([80.83.5.154]:57571 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754462AbYDLTqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 15:46:35 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 590FB2C331; Sat, 12 Apr 2008 22:46:34 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <2008-04-12-21-15-04+trackit+sam@rfc1149.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79379>

On Sat, Apr 12, 2008 at 09:15:03PM +0200, Samuel Tardieu wrote:
> The use of named constants vs. literals seem inconsistent in your
> patch, compare
> 
> | +               mode = (mode & ~0777) | shared_repository;
> 
> to
> 
> | +               mode |= (shared_repository & 0600) ? S_IXUSR : 0;
> | +               mode |= (shared_repository & 0060) ? S_IXGRP : 0;
> | +               mode |= (shared_repository & 0006) ? S_IXOTH : 0;
> 
> I first thought that you were using literals with "shared_repository"
> and named constants with mode but the first line I quoted shows that
> this is not the case.
> 
> Btw, aren't those last three lines better replaced by
> 
>   /* Copy read bits to execute bits */
>   mode |= (shared_repository & 0444) >> 2;

Agreed on both previous points. Will submit a new patch.

> I don't see where you deal with executable files.

> Also, wouldn't it be more consistent to use a negative value to
> --shared, that is a umask-compatible one, rather than a positive value
> which needs to be tweaked for directories and executable files? You
> would only have to "&" 0666 or 0777 with "~perms" to get the right
> permissions.
> 
> --shared=0007 would be equivalent to PERM_GROUP, --shared=0027 to
> group-readable-but-not-writable, and --shared=0002 to PERM_EVERYBODY.

I see the point, but I like to think it as a chmod value rather than a 
umask value.

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
