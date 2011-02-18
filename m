From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [1.8.0] Summary of the discussions
Date: Thu, 17 Feb 2011 21:08:14 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102172033340.14950@debian>
References: <7vwrky5f48.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 03:08:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqFlg-0004Bh-CL
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 03:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab1BRCIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 21:08:19 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51762 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab1BRCIS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 21:08:18 -0500
Received: by qyj19 with SMTP id 19so11341qyj.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 18:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=vR46gYoMIlMQsNGnX1MkIKQU8JHEzHqSBE71XTCdKGQ=;
        b=OuFn9tmrpe4lw3yfpM2ZgJ25wlHoWnqubPvnbKtPGcwCJZZWSnQTI1WTLAYDJwz7Lx
         4OcGtOfwSI1v/ho7KJFXuJD8pepYzcK7SH+g6WbuttuInvJEr6xrjphpj6SwGEHRGCwS
         s2gN1bBE+Y30w7KQPCIpIZvQw2gHWUpfCNqBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=bEslyuLlkck5Sy71e+JOt0BTlJak6GVVR8EGR68trUjDS3On6m39KBTauhWafuIHk2
         yaNtb8o9IXFGgr/kPwnq5Pq/dJHakW/ybJt6M5t4mnvM0nV4wuAqdBEKPGF12wdnd5w6
         UTTlxO9Sie2ggkW2Kxik3AybPyOd8W+lBuZGI=
Received: by 10.229.221.149 with SMTP id ic21mr113155qcb.190.1297994897395;
        Thu, 17 Feb 2011 18:08:17 -0800 (PST)
Received: from [192.168.1.100] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm1183773qck.36.2011.02.17.18.08.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 18:08:16 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7vwrky5f48.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167153>

On Thu, 17 Feb 2011, Junio C Hamano wrote:

>  * "git checkout refs/heads/<name>" checks out <name> branch.
> 
>     From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
>     Date: Mon, 7 Feb 2011 06:01:51 -0500 (EST)
>     Message-ID: <alpine.DEB.1.10.1102062234010.3788@debian>
> 
>     -- summary --
> 
>     In addition to "git checkout <name>" that names an existing branch,
>     special case "git checkout refs/heads/<name>" to check the branch out,

At first I was going to say that I don't think special casing it
should be necessary. It seemed like as long as the name resolves to
something like refs/heads/<name>, the branch should be checked
out. Then I think I realized why you said to special case it. Since
checkout favors branches to tags, we would first have to check if
refs/heads/<arg> is valid and if it is not, check if the argument
resolves to refs/heads/<name> (maybe ignoring tags called
"heads/<name>").

>     instead of detaching HEAD at the tip of the branch.  If you want to
>     detach at a specific commit and wanted to disambiguate <name> that is
>     both a branch and another ref by checking out refs/heads/<name>, your
>     workflow will be broken by this change, but you can still say
>     refs/heads/<name>^0 to work it around.
> 
>     -- comments --
> 
>     I do not think this backward incompatible breakage would seriously
>     hurt in practice, and if people see newbies are hurt by getting a
>     detached HEAD when they check out refs/heads/<name>, this proposal
>     might be an improvement, but I have a feeling that this may be trying
>     to solve a wrong problem.
> 
>     Why are these people _tempted_ to type refs/heads/ explicitly?  It
>     could be our tutorial or documentation.  That might be the thing to
>     fix.

It wasn't until recently that I learned that "git checkout
[refs/]heads/<name>" (and rebase <upstream> [refs/]heads/name)
detaches the head, so it wasn't really to try to help newbies that I
proposed changing it. It was just that the current behavior is not
what I think most people would expect.


/Martin
