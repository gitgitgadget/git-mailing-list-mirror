From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 26/31] rebase: remember strategy and strategy options
Date: Tue, 4 Jan 2011 22:33:47 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1101042140500.11516@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-27-git-send-email-martin.von.zweigbergk@gmail.com> <201101042027.26737.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 05 04:34:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaK8N-0003pv-5e
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 04:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078Ab1AEDdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 22:33:53 -0500
Received: from mail-qw0-f66.google.com ([209.85.216.66]:60354 "EHLO
	mail-qw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab1AEDdw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 22:33:52 -0500
Received: by qwk3 with SMTP id 3so4835313qwk.1
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 19:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=yJPWrC4lkcddSRUow2y0p3KGbvskI+tNHomjnmiJAQU=;
        b=LZ6B5Zzol3Nb0GZsD5DUXsOt6geRIpdvW0lqtFMCa5yXDdhPaBjGrQ1JKiXmHj5Eo6
         ZOZzTvCXHPIqUNfrrGW0lYi+K16g1Sg0kVpIFl7MjvCEF2+C4SaVUAZFE5QLtOAoowsj
         imTygv+Px3YVgalwbJOVzJ8OiwPkqlM4JFqaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=UytL2chO+m7xQxQlGYYQCAfaRwDNujtE3Iy/s1ezzBjgMhacKNJrhSzhZPn25NjNhO
         b4XdhVmTKa/GX/KyIRh/phPlVZWzaqRUYMsbAvTYVlTMLmBgKBao8fIv9Zu2BlRAH5F0
         H1QKaa1VigscAE6K8WXeaV5+ujG4cxijJfFlw=
Received: by 10.229.80.77 with SMTP id s13mr19539959qck.242.1294198431636;
        Tue, 04 Jan 2011 19:33:51 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id m14sm13276350qcu.20.2011.01.04.19.33.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 19:33:50 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <201101042027.26737.trast@student.ethz.ch>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164543>

On Tue, 4 Jan 2011, Thomas Rast wrote:

> Martin von Zweigbergk wrote:
> > How to add support for strategy options to interactive rebase?
> 
> AFAICS rebase -i currently only uses the strategy when dealing with
> multiple parents, i.e., in --preserve-merges mode.  I think
> git-cherry-pick needs to learn about the -s and -X options, and then
> it'll be a simple matter of passing them along.

I just saw that Jonathan has actually implemented that support in
git-cherry-pick. It is currently in pu.

I asked just because the merge strategy is currently passed to the
call to 'git merge' in git-rebase--interactive.sh (when dealing with
multiple parents, as you said), so it seems like it would make sense
to pass any merge options there as well.

Come to think of it, doesn't the merge option when passed to 'git
rebase -i' mean something quite different compared to when it is
passed to 'git rebase -m'? For interactive rebase, the 'ours' side
refers to the upstream, but in the case of merge-based rebase, it
refers to one branch in the branch-to-be-rebased, no? In that case,
should the merge strategy even be passed to 'git merge' when dealing
with multiple parents? Is it likely that one would want to use the
same strategy for both things? Am I just not thinking straight?

Some history:

The command line option '-s' was there from the inception of
interactive rebase in 1b1dce4 (Teach rebase an interactive mode,
2007-06-25) and back then it was passed to git-cherry-pick, which just
ignored it.

Since f09c9b8 (Teach rebase -i about --preserve-merges, 2007-06-25),
the strategy has been passed to git-merge as well.

Since 2a9c53e (git-rebase--interactive.sh: Don't pass a strategy to
git-cherry-pick., 2007-10-31), the strategy has only been passed to
git-merge, because it was ignored by git-cherry-pick.


Anyway, I'll leave any changes related to this outside of the current
series.


/Martin
