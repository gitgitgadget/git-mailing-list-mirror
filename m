From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 08 Feb 2008 11:00:55 -0800 (PST)
Message-ID: <m3ejbngtnn.fsf@localhost.localdomain>
References: <200802081828.43849.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jan Holesovsky <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Fri Feb 08 20:02:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNYTy-0001OM-Jv
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 20:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934764AbYBHTBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 14:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934476AbYBHTBP
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 14:01:15 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:30610 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932525AbYBHTA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 14:00:57 -0500
Received: by wa-out-1112.google.com with SMTP id v27so596034wah.23
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 11:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=0QNQk9Tw43eJup1h6SFhwx74xGmLpH8gNKUJAFAvQd0=;
        b=NUm2bSEkBVjybd3kmMAC/me7vSznfP19ubUipHUurapL5nYYyBX5UgMEhP+hc/gYzl93hJVkoZvqfzR4uVScj9VBv7ZoC/IEAyvV3OH87cQ/Pv8cf8kmU/lCgF1eKqApbjpVLAfcEnF+wU+332gwePak3dhQYQB+pnaPfSojxRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=QW/jZyJzY+hmJZNU27xYJ7GKvap3SefWeOXgJEBGnxOR1/TfPD4p4wmFNMxsXyvCK7ffSAqLd2le7vjqt9MaC9fWn+7Zrqrqe8lxnOBFxkxdRmEPaOcmjkMBHP1lAPenVYqVkKEdYJB8dhqHpWs7yv7NiJz3ptX8JJoJtJVtehc=
Received: by 10.115.88.1 with SMTP id q1mr6917787wal.98.1202497257192;
        Fri, 08 Feb 2008 11:00:57 -0800 (PST)
Received: from localhost.localdomain ( [83.8.242.186])
        by mx.google.com with ESMTPS id d25sm32465664nfh.33.2008.02.08.11.00.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Feb 2008 11:00:55 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m18J0nCA030614;
	Fri, 8 Feb 2008 20:00:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m18J0ing030611;
	Fri, 8 Feb 2008 20:00:44 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <200802081828.43849.kendy@suse.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73124>

Jan Holesovsky <kendy@suse.cz> writes:

> This is my attempt to implement the 'lazy clone' I've read about a
> bit in the git mailing list archive, but did not see implemented
> anywhere - the clone that fetches a minimal amount of data with the
> possibility to download the rest later (transparently!) when
> necessary.

It was not implemented because it was thought to be hard; git assumes
in many places that if it has an object, it has all objects referenced
by it.

But it is very nice of you to [try to] implement 'lazy clone'/'remote
alternates'.

Could you provide some benchmarks (time, network throughtput, latency)
for your implementation?

> Currently we are evaluating the usage of git for OpenOffice.org as
> one of the candidates (SVN is the other one), see
> 
>   http://wiki.services.openoffice.org/wiki/SCM_Migration
> 
> I've provided a git import of OOo with the entire history; the
> problem is that the pack has 2.5G, so it's not too convenient to
> download for casual developers that just want to try it.

One of the reasons why 'lazy clone' was not implemented was the fact
that by using large enough window, and larger than default delta
length you can repack "archive pack" (and keep it from trying to
repack using .keep files, see git-config(1)) much tighter than with
default (time and CPU conserving) options, and much, much tighter than
pack which is result of fast-import driven import.

Both Mozilla import, and GCC import were packed below 0.5 GB. Warning:
you would need machine with large amount of memory to repack it
tightly in sensible time!

> Shallow clone is not a possibility - we don't get patches through
> mailing lists, so we need the pull/push, and also thanks to the OOo
> development cycle, we have too many living heads which causes the
> shallow clone to download about 1.5G even with --depth 1.

Wouldn't be easier to try to fix shallow clone implementation to allow
for pushing from shallow to full clone (fetching from full to shallow
is implemented), and perhaps also push/pull between two shallow
clones?

As to many living heads: first, you don't need to fetch all
heads. Currently git-clone has no option to select subset of heads to
clone, but you can always use git-init + hand configuration +
git-remote and git-fetch for actual fetching.


By the way, did you try to split OpenOffice.org repository at the
components boundary into submodules (subprojects)? This would also
limit amount of needed download, as you don't neeed to download and
checkout all subprojects. 

The problem of course is _how_ to split repository into
submodules. Submodules should be enough self contained so the
whole-tree commit is alsays (or almost always) only about submodule.

> Lazy clone sounded like the right idea to me.  With this
> proof-of-concept implementation, just about 550M from the 2.5G is
> downloaded, which is still about twice as much in comparison with
> downloading a tarball, but bearable.

Do you have any numbers for OOo repository like number of revisions,
depth of DAG of commits (maximum number of revisions in one line of
commits), number of files, size of checkout, average size of file,
etc.?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
