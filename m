From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Alternates corruption issue
Date: Tue, 31 Jan 2012 16:59:09 -0600
Message-ID: <20120131225909.GA13780@burratino>
References: <1328018729.13744.26.camel@ted>
 <20120131193922.GA31551@sigill.intra.peff.net>
 <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
 <20120131204417.GA30969@sigill.intra.peff.net>
 <20120131214047.GA13547@burratino>
 <20120131214740.GA2465@sigill.intra.peff.net>
 <20120131215501.GF13252@burratino>
 <20120131220510.GA3253@sigill.intra.peff.net>
 <20120131222258.GG13252@burratino>
 <20120131224240.GA3844@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 31 23:59:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsMfl-0001JT-Ki
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 23:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342Ab2AaW73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 17:59:29 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:36124 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab2AaW72 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 17:59:28 -0500
Received: by werb13 with SMTP id b13so481548wer.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 14:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JAtVKfSuvP6sHUcGiCx7oUFtcUJZoKuLLXaPhS4C4wY=;
        b=LUJH80Pm3q5pVkFVtkw9uPl/Zo2WZUorKRklE0MYfvjswmbK0W6wXTakjZWBxF+14X
         4Mjw2j5mRnQfpF+U7E8LNMs6dZAYCNiIWNHVk44kP33jPg7pM+dBCfF2MoHhZmYqsWHU
         Pd/gCXz7J4KjDmhNh1ngiDrfEvw+K6CW+TuXk=
Received: by 10.216.133.71 with SMTP id p49mr2281562wei.8.1328050767151;
        Tue, 31 Jan 2012 14:59:27 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dr5sm67663333wib.0.2012.01.31.14.59.24
        (version=SSLv3 cipher=OTHER);
        Tue, 31 Jan 2012 14:59:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120131224240.GA3844@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189482>

Jeff King wrote:
> On Tue, Jan 31, 2012 at 04:22:58PM -0600, Jonathan Nieder wrote:

>> I admit part of the reason I care is that just putting "" first would
>> probably taken care of the more important part of
>> <http://bugs.debian.org/399041>.
>
> Would that fix it? If I understand it, the repo in question is bare with
> a ".git" directory inside it.

The layout was foo/.git/.git.  The real repository was made with plain
"git init" or "git clone", and then "git svn init" or similar was run
from within .git, creating a .git subdirectory.  (Something more must
have happened, actually, since the tree was weirdly sparse:

	$ find .git/.git
	.git/.git
	.git/.git/svn
	.git/.git/svn/git-svn
	.git/.git/svn/git-svn/.rev_db

)

In the current scheme, to access such a broken repository remotely,
you have to use a URL ".../foo".  URLs pointing to foo/.git (like gitk
once used) end up rewritten as .git/.git.  Of course, your patch with
the is_git_directory() will fix this specific case. :)

Not a huge deal, especially since "git svn init" prints out where it
is writing these days.
