From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: frustrated forensics: hard to find diff that undid a fix
Date: Sat, 5 Mar 2011 09:29:57 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1103050844130.26585@debian>
References: <4D71D63E.3030907@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 15:30:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvsUm-0001kB-Bq
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 15:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab1CEOaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 09:30:04 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44026 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab1CEOaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 09:30:03 -0500
Received: by vxi39 with SMTP id 39so2760330vxi.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 06:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=pNuiTq7RFw/iKw2DQWwIf73FIHD8TF/u6aN6n0e8z0Y=;
        b=SjTttLQsuTua5RhgX1sTc8fQTZa4U9Ofp6SxnuPKQRQPNnSbIJmLSObv2/XWSqzPPL
         se9o2Ey9RM3/V69jATNmIBlv+PVR609JbHt628R16zi42EnaHfRk5WsD9mPTiMqbRTsv
         Znr+nU8b1XsTO2q2jhO/NFlGLdK5Zv1gRRUjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=V6UQg6c/DA+0dRqRCcwKJZwYXGf3+T1LxUelGZYMBXFyk+5llmeRX1NB0as8g3DY0Z
         P+GnOSqGfqUg6DKtlJHZKsIFt5c1sTXWdHFxcp4FR8rSPd6hG8mDs/aHbjAuYXWsrfqg
         rnJFV6rIdoSDGetIKGq+OfjjHQjxWtsWiS/Z4=
Received: by 10.220.14.66 with SMTP id f2mr509971vca.117.1299335402635;
        Sat, 05 Mar 2011 06:30:02 -0800 (PST)
Received: from [192.168.1.104] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id v26sm98829vcr.13.2011.03.05.06.30.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Mar 2011 06:30:01 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <4D71D63E.3030907@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168498>

On Fri, 4 Mar 2011, Adam Monsen wrote:

> I made a fix a month ago on the master branch in a shared repo. A week
> later, a colleague did a merge that undid the fix. I didn't figure out
> the problem until just now because I'd been assuming the fix was still
> on master. I mean, if it wasn't, I should see a reverse patch using "git
> log -p master", right? Wrong. Turns out the fix was undone as part of
> merge conflict resolution (I think).
> 
> Is there some way to include merge conflict resolutions in "git log -p"
> or "git show"? Apparently some important information can be hidden in
> the conflict resolution. Or, more likely, I just don't understand how
> this bit of git works.
> 
> I also tried bisect and pickaxe. Bisect wrongly identified the first bad
> commit, and pickaxe just didn't see the change at all.

I was also bitten by this at work not too long ago. I started
wondering if it would make sense to introduce a new option to git log
and friends that would show the differences compared to a recreated
merge commit. In the simple case where there are no merge conflicts,
this would show only changes that someone explicitly dropped, like in
your case. If there were conflicts, I imagine it would show the same
output as -c or --cc. Does this make any sense?

One of the reasons that people sometimes drop the 'theirs' side while
merging is that they see the files show up when running 'git status'
and they think "Hmm... I didn't modify this file, let's reset
it". Would it be completely nonsensical to suggest that 'git status'
could learn to, during a merge, compare to a recreated merge commit
instead of comparing to HEAD?

Let me know what you think. I haven't really thought this through, so
I wouldn't be surprised if I'm just talking nonsense.


/Martin
