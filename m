From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git
 push --mirror" update mirrors
Date: Sun, 27 Apr 2008 09:23:23 +0200
Message-ID: <481429EB.70809@gnu.org>
References: <4812DA50.3000702@gnu.org> <20080426170126.GC29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 09:24:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq1F7-0007Df-Rd
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 09:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbYD0HX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 03:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbYD0HX0
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 03:23:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:64412 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbYD0HXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 03:23:25 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4385394fgb.17
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 00:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=yjvjeGxX8ucHINasr+bresLFVG8l+5GnFVLKVs0U6Ss=;
        b=DYbuuOyIBm1rAr1PS4/D3Gonzbe5xb6N18roUfK0DWxsN96++zzwi2T3+TdM8O2xt2P7cHbRxChoM/WMP6Urzkl6sMFzIRrz+yj7IbSd1lqF9DqARWHhXDHBElI1Z7EfLwQ3XLvt/S8oAk8RPL48tbOHhHe3brjZsmQ1Lvwj6l4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=dTvvRHkjse+4dxnSNQl+nGle5ptadP26hHEmOXwwFv/jiZayubItuRJ/cXekXVHxWOvS9fmL/m2nS3sgvdqSM+FbQRkS5nvLtCAppq3hI4Fp9zjnYiZrH34HlaOLFNfcjhlMU0o4r5n+Ao9C7vUKxbj/AmF2hv+w9Plm/l8+ssY=
Received: by 10.86.31.18 with SMTP id e18mr4837541fge.35.1209281004235;
        Sun, 27 Apr 2008 00:23:24 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id e20sm3622564fga.1.2008.04.27.00.23.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Apr 2008 00:23:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <20080426170126.GC29771@spearce.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80427>


> Sorry, I don't really see a use case behind this.  `git push` today
> will push to origin all branches that exist both locally and already
> on the remote.  If you want to push to multiple locations, just
> specify the other URLs in the remote.origin.url configuration list.
> Linus added support for that years ago.

I publish my topic branches (with --mirror) on my personal site, and the 
master and stable branches on savannah.gnu.org.

>> Similarly, if a developer uses the integrator's repository but
>> wishes to publish his own mirror somewhere, he can just do "git push
>> --mirror".
> 
> Why not just have a remote named "my-mirror" and do `git push my-mirror`?

More precisely, it would be "git push && git push --mirror mirror".  My 
previous patch to add remote.<foo>.mirror shortens it to eliminate the 
--mirror, but I cannot condense it in one remote because one is mirror 
and the other isn't.

I can do this, in other words:

> For example in egit I can publish to both
> the master egit tree (repo.or.cz/egit.git) and to my fork
> (repo.or.cz/egit/spearce.git).  I publish to the latter almost
> daily, and rebase even more often than that.

... just by choosing whether to work in a topic branch or in a repo that 
is already on git.sv.gnu.org, but from a single checked out tree.  Like 
you guys, I have multiple places to push to -- and I want "git push" to 
DWIM.

Of course I have a git-mirror script that does it, but the use case 
seemed frequent enough to warrant the effort to provide it for other 
users too.

Replying to Junio:

> Configuring to push to multiple can already be done as you described, not
> having to have a special case code like this patch is certainly very
> attractive

I considered actually to change it to "push to every remote that has a 
push refspec", and adding code to "git clone" that added a push refspec 
for origin.  This would simplify the magic, but I wasn't sure of the 
ramifications and of whether it would change the behavior of the default 
remote.

Paolo
