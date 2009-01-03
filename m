From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: What about allowing multiple hooks?
Date: Sun, 4 Jan 2009 02:32:52 +0300
Message-ID: <20090103233252.GA12095@myhost>
References: <20081121133828.GB5912@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rogan Dawes <lists@dawes.za.net>,
	martin f krafft <madduck@madduck.net>
To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 04 00:34:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJG0b-0004O8-IL
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 00:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbZACXc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 18:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759941AbZACXc5
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 18:32:57 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:16768 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbZACXc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 18:32:56 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2434966fgg.17
        for <git@vger.kernel.org>; Sat, 03 Jan 2009 15:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=5/GV2GO6AasPoPt42/fUXKBJIGe2qvY4MESsdizqe18=;
        b=WTrwAV7qsZpOfmmi8yTeVxA9hkUj1IN9jr7RT8sW84rU4l7t+dZbE1izhGfEe0yUOm
         iwxeS7KIH/AbkUp9DSRYFVFGqEFW9hYaYsr/Mb8owYucJbCx4a5vqHVpPZzE/EPi6l2g
         n0N6lINGo8uTi9mFPwTbLW5xpVQLmTTEOW/6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=u9CLhUSHK8D/YySHKESiv0O+L/7yEKclvIU1/Q5OLsNbhBrZ8KvpgNy/GXkAAB+8Jo
         8nlcjz0lKTeyEflRCvU7vXbPKPygEOcziAtnx2Ys2UplfQJZPueM6nOnpxX9XchKOyCp
         OSn/v4irm6G+UViMCndLUjPNnndZmqeHHO0wU=
Received: by 10.86.23.17 with SMTP id 17mr11335989fgw.0.1231025573340;
        Sat, 03 Jan 2009 15:32:53 -0800 (PST)
Received: from smtp.gmail.com ([91.78.205.202])
        by mx.google.com with ESMTPS id l12sm1277664fgb.38.2009.01.03.15.32.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 Jan 2009 15:32:52 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Sun, 04 Jan 2009 02:32:52 +0300
Content-Disposition: inline
In-Reply-To: <20081121133828.GB5912@gmx.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104486>

On 14:38 Fri 21 Nov     , Marc Weber wrote:
> Use case:
> 
> I've been reading parts of the topGit code. And it does make for it to
> add its own checks. However having to change the existing scripts
> insterting a call to the tg hooks isn't the best way.
> Why? one is using #/bin/sh the next is using #/bin/ruby maybe..
> 
> So what about allowing (or even enforcing) ths directory layout?
> 
> .git/hooks/pre-commit/hook1.sh
> .git/hooks/pre-commit/hook2.sh
> .git/hooks/pre-commit/topGitcheck.sh
> 
> instead of
> .git/hooks/pre-commit # <- the one and only pre-commit hook
> 
> so that all can be run in squence?

If we have a single hook, git just runs a script. But multiple scripts
can be run in different orders. We can assume that git should run them
in lexicographical order, but sometimes it's not the best order can be
used.

However, prefixes can be used to force a particular lexicographical
order:
	.git/hooks/pre-commit/01-hook2.sh
	.git/hooks/pre-commit/02-topGitcheck.sh
	.git/hooks/pre-commit/03-hook1.sh

Is there a better way to choose the scripts order?

> 
> This way you can keep the original git sample files and update them
> while adding you very own checks more easily.
> 
> But maybe this isn't the best choice either and the way to go is
> 
> .git/hooks/list-of-hook-directories # eg containing ".git/hooks/samples\n.git/hooks/topgit" ?
> 
> .git/hooks/sample/<all the sample hook files>
> .git/hooks/topgit/pro-commit
> 
> ?
> 
> Then you can actually link in your own personal check script directories
> easily *and* you can add them to the repository eg by using
> comitted-repo-hooks instead of .git/hooks
> ?
> This way you could provide different hook directories for different
> platforms and all you have to do is enabling them by adding the path to
> .git/list-of-hook-directories ?
> 
> I guess the second approach of defining kind of overlays is better
> because it doesn't interfer with the existiing scheme?
> Maybe it should be implemented as git config option instead of a file
> containing the list of directories?
> 
> The hook direcotry list apporach is better because you've more control
> about order of execution..
> 
> Thoughts?
> 
> Marc Weber
