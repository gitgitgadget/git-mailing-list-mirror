From: "James Pickens" <jepicken@gmail.com>
Subject: Re: hosting git on a nfs
Date: Thu, 13 Nov 2008 16:23:16 -0700
Message-ID: <885649360811131523h2e10dc44x8603c9793dae03b8@mail.gmail.com>
References: <200811121029.34841.thomas@koch.ro>
	 <20081112173651.GA9127@linode.davidb.org>
	 <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org>
	 <loom.20081113T174625-994@post.gmane.org>
	 <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Bruce Fields" <bfields@fieldses.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 00:24:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0lYA-00008B-1q
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 00:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbYKMXXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 18:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbYKMXXT
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 18:23:19 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:58383 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbYKMXXS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 18:23:18 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1108064muf.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 15:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sqdpn4LpC1DwKj8VwVWKwLavUkj4qwbTd2vWqF8LvkM=;
        b=elxkWBOC9MHLE1Km0IY5YkijCAwqz77iYMbQ+xbvyAA0BrLmQuzX/AoFxW6WBVPCqf
         cRMyZmiFKRtDnCyGNEvuc9XREbiaJGp6qB7spno4VzrciPEIuHEfoNuETE2iJKJ1aTl3
         RDXDju7RBiU8QyIKCaU80ArNeuLkgzK92By5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JY279vpgU9M54iRWK7MgVvq6Aw0Sw7TON6mUCgKgbgM/AFWWbtViBe3qSVms6IlM4m
         p7S+z9K0mVuBdjv4yXka8SdFHB3lpKBui0Q9pnbFzprrGGDy5Np/ngCYCzHb9oJNXXCY
         rcllJZPGXUvdoNK/X1lhutgoIx0bGB+vrSffQ=
Received: by 10.180.205.1 with SMTP id c1mr74494bkg.143.1226618596102;
        Thu, 13 Nov 2008 15:23:16 -0800 (PST)
Received: by 10.180.229.10 with HTTP; Thu, 13 Nov 2008 15:23:16 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100925>

On Thu, Nov 13, 2008, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> But it's still hacky as hell. Who has NFS? Can you do the same thing over
> NFS and test it? I'm not going to set up NFS to test this, and as I
> suspected, on a local disk, the cold-cache case makes no difference
> what-so-ever, because whatever seek optimizations can be done are still
> totally irrelevant.

I'm trying to test this and so far I'm not seeing any effect.  The
timings are all over the map, but the average time is about the same as
before.  If I run 'git status' over and over without pausing in between,
it runs very fast, so I guess the client is caching some things for a
short time.  Here are the timings I got by running git 1.6.0.4 and
1.6.0.4 plus this patch, alternating between them and sleeping for 60
seconds after each run:

Git 1.6.0.4:
4.83
4.47
4.54
9.04
5.28
4.33
6.40
13.71
4.51
5.90

Git 1.6.0.4 plus patch:
7.82
10.94
4.61
5.06
5.59
5.22
4.65
5.58
6.70
9.15

I'll play around with the code and see if I figure anything out.

In case it matters, I'm using a 4 core machine with a fairly old kernel:

$ uname -r
2.6.5-7.287.3.PTF.363939.1-smp

BTW thanks a lot for working on it.  I was expecting a response along
the lines of "it's possible but would require extensive code changes so
it's not likely to happen", and instead a patch was posted only a few
hours later.  Maybe I should ask for all those other upgrades I've had
in mind... ;-)

James
