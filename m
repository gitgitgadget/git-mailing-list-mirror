From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to delete the entire history before a certain commit
Date: Mon, 03 May 2010 15:45:01 -0700 (PDT)
Message-ID: <m3ocgwfvw2.fsf@localhost.localdomain>
References: <hrnidr$etm$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gelonida <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 00:45:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O94O1-0000HQ-EI
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 00:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757089Ab0ECWpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 18:45:07 -0400
Received: from mail-bw0-f217.google.com ([209.85.218.217]:39966 "EHLO
	mail-bw0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571Ab0ECWpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 18:45:05 -0400
Received: by bwz9 with SMTP id 9so1730026bwz.29
        for <git@vger.kernel.org>; Mon, 03 May 2010 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=EyQSs3kb7RuQjzSq0Z0A9hmSvLqdEyEwPxxV7tEstc4=;
        b=JKlVMLDGzofh5Rpz6rpyvYxR5H+AZc2BbaP2dx4bxq8uQW4PpNFDVgYhdLxmHCBBEC
         Z5r52fZCwPP7hHJ37+xtd2SeSB0GyrqBhpXcC504/HamGCNoRRcNXOLsSG+PEi3FchJT
         UGvpnXB/9BLU9E0hI8W/hyiFh86qaRD5kru4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=I40u6Vg2kB3vdjbK0T7+85mhc8Z2/zInafxGLfTDwZC36/P7lOUUEQj4tNxMDfkrk2
         t+12QMhjaFE65cM6i4850BqEMOxHEp00RrvxpMBGJ+Iyyp5VzKuxTa7ZMWVYVsK0LcrP
         PlE46WkgUfc+vwXHrWiclnRgQOdCLpuO5uMFg=
Received: by 10.204.6.203 with SMTP id a11mr2871851bka.8.1272926701830;
        Mon, 03 May 2010 15:45:01 -0700 (PDT)
Received: from localhost.localdomain (abrz91.neoplus.adsl.tpnet.pl [83.8.119.91])
        by mx.google.com with ESMTPS id 16sm1826587bwz.13.2010.05.03.15.45.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 15:45:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o43MieOM002174;
	Tue, 4 May 2010 00:44:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o43MiUmZ002159;
	Tue, 4 May 2010 00:44:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <hrnidr$etm$1@dough.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146266>

Gelonida <gelonida@gmail.com> writes:

> We have a git repository, whose size we want to reduce drastically due
> to frequent clone operations and a slow network connection.
 
Why frequent *clone* operations, instead of using "git fetch" or
equivalent ("git pull" which is fetch+merge, or "git remote update")?

If network is slow, you can do what others did in similar situations:
use hook to allow only not to large fetches (to prevent cloning)
directly on server, and provide bundle (see git-bundle(1)) to "seed"
the clone; it can be on dumb server (served resumably), and can be
also served by BitTorrent or equivalent.
 
> The idea is following:
> 
> * archive the git repository just in case we really have to go back in
> history.
> 
> 
> create a new git repository, which shall only contain last month's activity.
> 
> all changes before should be squashed together.
> It would be no problem if the very first commit remains unmodified.

If you want to simply _remove_ history before specified commit,
instead of squashing it, the best solution would be to use grafts to
cauterize (cut) history, check using [graphical] history viewer that
you cut it correctly, and then then use git-filter-branch to make this
cut permanent.

You can later use grafts or refs/replaces/ mechanism to join "current"
history with historical repository.

HTH.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
