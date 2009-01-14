From: skillzero@gmail.com
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Wed, 14 Jan 2009 00:08:06 -0800
Message-ID: <2729632a0901140008r59e429aeq3ce367e1bc7df71@mail.gmail.com>
References: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com>
	 <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com>
	 <2729632a0901132221r746144a1y9628615be1c6ad04@mail.gmail.com>
	 <496D9572.2090303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 09:09:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN0oi-0000BR-7C
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 09:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111AbZANIIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 03:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755100AbZANIIK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 03:08:10 -0500
Received: from rn-out-0910.google.com ([64.233.170.190]:18185 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbZANIII (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 03:08:08 -0500
Received: by rn-out-0910.google.com with SMTP id k40so345429rnd.17
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 00:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EAmUMV+fBeVGEKWV/SMh6ukAt5oli05RL7YKBnmv9go=;
        b=RorRLCgW2sEsln6Vp8N7hJwUlIxy74+4pHnsMfCE/6zvb2bEz8j5N7V+38W2cfwEVw
         CrEHaPdI3N2s3+VhnWdY4F7k7GNEvEI9Qi+PD++oL4EUwJOb+/aUb0hxT9zJ1BesiWgX
         qCg2J0k7o04NGoXj2Er4ezjYp5noJQnIToQds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=b5YKLDITLSrLOITkFmT9ILC5x9yA7q9eYQq8YUZVmOQ3hvIuglpV2tWUUiTqpOUwwU
         sXbHHkkD53VvGTja492Z1wjoym/08vdLLUlZSNM2AcNdO/+5q1ZuPW6d0pxJjJKDqz0O
         /uiTrucdToWFLmETUsgfzUH1oRztxH+tzTiFE=
Received: by 10.65.121.14 with SMTP id y14mr21107368qbm.37.1231920486918;
        Wed, 14 Jan 2009 00:08:06 -0800 (PST)
Received: by 10.64.242.15 with HTTP; Wed, 14 Jan 2009 00:08:06 -0800 (PST)
In-Reply-To: <496D9572.2090303@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105599>

On Tue, Jan 13, 2009 at 11:34 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:

> Well, the way to do it is "careful planning".
>
> If you have a *slight* suspicion that some change *might* be needed on a
> different branch, then:
>
> 1. you commit the change on a branch of its own that forks off of the
> merge-base of *all* the branches that *might* need it;
>
> 2. next, you merge this fix-up branch into the branch where you need it
> first, which is very likely your current topic-under-development.
>
> 3. Later you can merge the branch into the other branches if you find that
> it is really needed.

If I create a separate bug-fix-only branch X that forks from the
latest common commit of all the branches that might need it and some
of those branches already have commits after that merge base (e.g.
branch Z is 5 commits after the common merge base by the time I fix
the bug), will git be able to merge the new branch X into Z in a way
that will allow me to also merge branch X into my original feature
branch A and then later merge A into Z without duplicating the commit
that is now in both branch X and Z?

It seems like I'd run into my original duplicate commit problem
because even though branch X was originally based off the same parent
commit, it will have a different parent when it is merged into Z
because Z is no longer at that common merge commit (it's 5 commits
beyond it).
