From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Sat, 18 May 2013 23:57:41 +0530
Message-ID: <CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org> <CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
 <7vobca3465.fsf@alter.siamese.dyndns.org> <7vzjvu1jes.fsf@alter.siamese.dyndns.org>
 <CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
 <7vk3mx1rox.fsf@alter.siamese.dyndns.org> <CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
 <7vk3mxze8v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 20:28:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udlrn-0003m3-2b
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 20:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648Ab3ERS2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 14:28:22 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:54523 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab3ERS2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 14:28:21 -0400
Received: by mail-ie0-f180.google.com with SMTP id ar20so11625237iec.11
        for <git@vger.kernel.org>; Sat, 18 May 2013 11:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=lMY1lcmuWgyeMQ85ayZ97Ck5/z9WwG1xINfqFjGc9Jk=;
        b=sUfb8L49AUHho6Rt/bZqLUbkVwMvPkVUdWgj6TvBT+VM/vuJE8hfZ6FjUcpDLB61iU
         fTPKHscePOWdAViVIcxwJQipG0q6g4VPxcxKwVLxY6ia/Uvh/JVmQy2DztU2vQAgDKxY
         XSig/zJLVaQJwQz8QCfk75269oNl0KIJOh1x79MUR/c9qKDq7PThp0UtaA0jUdNoxxST
         DNNWTjdQUz6od1Zlr//6+cCnXZFGjxXZn7FYrTI/D52GRlqXhUwoln49zeBd5HplAm/T
         vxMmcLQGNnXS/PQX99Gw5mKHGZC9f6TJ+FgocETI7yLAYmHgIFMm0Heu9FwU8pzHkioe
         9nxA==
X-Received: by 10.50.3.38 with SMTP id 6mr1621227igz.44.1368901701457; Sat, 18
 May 2013 11:28:21 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sat, 18 May 2013 11:27:41 -0700 (PDT)
In-Reply-To: <7vk3mxze8v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224800>

Junio C Hamano wrote:
> Having said that I am not sure where your "not overly fond of" comes
> from, as I do not see a problem with branch.<name>.push.  The only
> problem I may have with the approach would arise _only_ if we make
> it the sole way to allow people push to different names, forcing
> people who want to push N branches to configure it N times.  Other
> than that, I think it is an acceptable solution to give per-branch
> control.

It doesn't strike me as being elegant at all.

[branch "hot-branch"]
    remote = ram
    push = refs/heads/for-junio/hot-branch

1.  I git branch -M for-each-ref and push.  Screwed.

2.  Let's say you give me the thumbs up to write hot-branch to origin.
 Excitedly, I change the remote to origin.  Now I already have push
semantics for origin (you obviously want me to write to rr/, so I can
cooperate with others):

[remote "origin"]
    push = refs/heads/*:refs/heads/rr/*

Unfortunately, it doesn't kick in unless I change branch.<name>.push.

I guess what I'm saying is: refspec semantics are inherent properties
of the remote, not of the local branch.  Since there is no
intermediate refs/remotes/* sitting between the remote and local
branches, this is _not_ like branch.<name>.merge at all.  That is why
I'm tiling towards remote.<name>.push: we're not giving up any
functionality anyway; there's nothing we can't do without
branch.<name>.push.
