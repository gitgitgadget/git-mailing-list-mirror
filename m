From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] gitk: Use git-difftool for external diffs
Date: Thu, 19 Nov 2009 11:39:15 -0800
Message-ID: <20091119193913.GA25410@gmail.com>
References: <1258341126-2108-1-git-send-email-davvid@gmail.com>
 <19205.2531.205062.980468@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: peff@peff.net, sam@vilain.net, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Nov 19 20:40:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBCrI-0003aA-2a
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 20:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707AbZKSTjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 14:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbZKSTjV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 14:39:21 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:39853 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754955AbZKSTjT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 14:39:19 -0500
Received: by bwz27 with SMTP id 27so2733827bwz.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 11:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Y8khEUYNTmCSrgsCWDb5BZygE7dm/ofL+ho7Tky/Kx8=;
        b=Aaq8hXBm0beJo5ocSa5mHhV9+vi9XZaqvVvCCWnVNj+cOBiNJTQ0BlVOmYig9HW6/d
         qVdsf+JIb2WnAkwgRo0q6iqYTYkaksJL62i8ZgUGZRzJ3y5j7C/JmmXumlsGOn6xs1Oo
         NTytt4b5hXP4Wuf/l0yVtN0ZyFv5e269Cd2J0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YOJvxq6WISfBIYZkmrbIxCZYgfPn3haC5LHQ7T8IqY0VHDAccZbXAXn5dZjSceXq6P
         sSj3x0kd9XyGJdbDlHiGiw5dJOj9OLQr3OXtnJvLq5FCk9zVlqdmw0ZRACSrvGEgXLQk
         2c7Tdrh8eovP5ypaa03DSpY5UTQmB2DgYRHtU=
Received: by 10.204.3.219 with SMTP id 27mr412221bko.127.1258659564397;
        Thu, 19 Nov 2009 11:39:24 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id d13sm968727fka.17.2009.11.19.11.39.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 11:39:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <19205.2531.205062.980468@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133247>

On Thu, Nov 19, 2009 at 08:03:31PM +1100, Paul Mackerras wrote:
> David Aguilar writes:
> 
> > This teaches gitk about git-difftool.  A benefit of this change is
> > that gitk's external diff now works with read-only repositories.
> 
> What version of git does git difftool first appear in?  I prefer not
> to introduce hard requirements on very recent versions of git into
> gitk.
> 
> Paul.

git-difftool appeared in git 1.6.3.

If this patch is not going in then how do you suggest we fix the
read-only repository bug?

My immediate thought is to harden the $TMPDIR patch so that the
filenames used by gitk are much less predictable (I bailed on it
once Peff noted the $TMPDIR vulnerabilities and used
git-difftool instead since it is known to be safe).

Does hardening the $TMPDIR patch have a better chance of
being accepted?


In defense of difftool: there are more benefits to using
git-difftool than just read-only repositories.
The current external diff code does not work if 'meld'
is not installed whereas using git-difftool works by default
in more environments.  It also makes things match users'
expectations when they have already gone through the trouble
of configuring a diff or merge tool.

Is there a particular time frame in which such a patch could go
in?


My primary concern is getting gitk to work with read-only
repositories.  git-difftool was just one way of getting there.
If keeping backwards compatibility is a must-have then I can
hold onto the git-difftool patch until some time in the future
when it is more appropriate.  Hopefully something along the
lines of a hardened $TMPDIR patch can stand in for the final
fix in the meantime.

What do you think?

-- 
		David
