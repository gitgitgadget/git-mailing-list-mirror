From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Achieving efficient storage of weirdly structured repos
Date: Thu, 03 Apr 2008 23:21:06 -0700 (PDT)
Message-ID: <m3tziita2y.fsf@localhost.localdomain>
References: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com>
	<alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roman Shaposhnik <rvs@Sun.COM>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 04 08:21:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhfJE-0006GS-Ax
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 08:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbYDDGVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 02:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbYDDGVM
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 02:21:12 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:64748 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbYDDGVK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 02:21:10 -0400
Received: by fk-out-0910.google.com with SMTP id 19so4779968fkr.5
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 23:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=c+FDS+4HFdFtRvoViZWQB5GDavDx5scFrSmyf/9SP14=;
        b=TNMePyrr6X8Brx+petQ5BjAUU98KVs+1iOTBsOjfichmoL35xjroXrzdhxdLjs8Hvq0LlgYf4KLJqQ2dFfvD9T61hYT6PNguIuIFlJ/s29rj7961GHkO+4P+zP92fdweq9h5Ps6nSmi71cajCu1d5Cz/E68Jr8q3AY35B5LxOGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Dov1r3aI2mCfjrQ9bmjv9hKq9lJTqNg+qnNXl7xycQHa0SXzvXt5+GNgWgZdjDiYJTL1ZDQ+oYF8uKSPBVBvFBaLC5+hIh3pTcerQ5j4iCqtSPt8GJ73eCmRi2htNpMtZWbGUNUTmYOiKX5erJp2x0DRZckDsvF5jqD8lHGmRoE=
Received: by 10.78.29.6 with SMTP id c6mr2002020huc.48.1207290068974;
        Thu, 03 Apr 2008 23:21:08 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.217.217])
        by mx.google.com with ESMTPS id x23sm2344076ugc.87.2008.04.03.23.21.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Apr 2008 23:21:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m346L1Tt010703;
	Fri, 4 Apr 2008 08:21:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m346KcJL010698;
	Fri, 4 Apr 2008 08:20:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78795>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 3 Apr 2008, Roman Shaposhnik wrote:
>> 
>> The last item (trees) also seem to take the most space and the most 
>> reasonable explanation that I can offer is that NetBeans repository has 
>> a really weird structure where they have approximately 700 (yes, seven 
>> hundred!) top-level subdirectories there. They are clearly 
>> Submodules-shy, but that's another issue that I will need to address 
>> with them.
> 
> Trees taking the biggest amount of space is not unheard of, and it may 
> also be that the name heuristics (for finding good packing partners) could 
> be failign, which would result in a much bigger pack than necessary. 
> 
> So if you already did an aggressive repack like the above, I'd happily 
> take a look at whether maybe it's bad heuristics for finding tree objects 
> to pair up for delta-compression. Do you have a place where you can put 
> that repo for people to clone and look at? 

Hmmm... I wonder if it would be the case that would speed-up
development of pack v4.  If I remember correctly one of bigger changes
was the way trees were represented in pack; the biggest improvement
was for trees.

One of bigger hindrances, as I understand it, in developing pack v4
was the fact that it didn't offer that much of improvement in typical
cases for the work needed... but perhaps "your" repository would be
good showcase for pack v4.

Just my 2 eurocents...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
