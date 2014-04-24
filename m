From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Wed, 23 Apr 2014 20:11:23 -0500
Message-ID: <535864bbc3a84_3c7abff3107b@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <5355793A.5020000@gmail.com>
 <53558476703cb_5c94d452ec4e@nysa.notmuch>
 <53558A54.4060801@gmail.com>
 <53558ae6f1282_604be1f30cf3@nysa.notmuch>
 <53559020.1050407@gmail.com>
 <53558f6269f91_640076f2f08f@nysa.notmuch>
 <857g6h5ssh.fsf@stephe-leake.org>
 <5356996d12ede_3e5aed7308e5@nysa.notmuch>
 <85mwfc4hab.fsf@stephe-leake.org>
 <535782d95bbed_24448772ec7a@nysa.notmuch>
 <xmqqoazrwtsc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stephen Leake <stephen_leake@stephe-leake.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 03:22:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd8MQ-00042A-Go
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 03:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbaDXBVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 21:21:52 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:41566 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbaDXBVt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 21:21:49 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so1917618oag.34
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 18:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=k04XeOoGAmwHEOgOXnwMwIpTPrleyXFKnSA8gMrrOcw=;
        b=DR0UNncr8GFUhPYlmFAxgq/UHyg+JWUy2R3Xnp8wKyRctk1Ime0psH9nkGsLclFOMB
         eB70k4Ib+Kum275FEte1PE4ukfa9w9+FG0WpYJ5gZyubWas1c0vCFBYMOOaNfoaRFsgj
         xcecxkgB23w0kEI60eZ3zeDvVQnbDipA7XMDgdSjR3R2vqWXHLO3VL8os3dg4wahcg+0
         6QcVcB3zsiHj+uZhCYpXGciDGDRXoLp6qjWwDz/ObNzHSiNDS1G0Q9AC4ip4rzWJA8+h
         5BEbmhuFls5JxRqN3bbiGxLq424DGEf+9+DWfy8rd5djK5Bd6ztJAMGQ5zOsaLqXssAQ
         PMBg==
X-Received: by 10.182.113.227 with SMTP id jb3mr12746391obb.3.1398302509071;
        Wed, 23 Apr 2014 18:21:49 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dg2sm5283350obb.17.2014.04.23.18.21.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 18:21:47 -0700 (PDT)
In-Reply-To: <xmqqoazrwtsc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246914>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> >> I have a branch which should always be recompiled on update;
> >> >> post-update-branch would be a good place for that.
> >> >
> >> > And why would pre-update-branch not serve that purpose?
> >> 
> >> Because the code that needs to be compiled is not yet in the workspace
> >
> > And it won't be in 'post-update-branch' either.
> >
> >  % git checkout master
> >  % git branch feature-a stable
> >  <- update-branch hook will be called here
> >
> > The hook will get 'feature-a' as the first argument, but the code in the
> > workspace would correspond to 'master'; the checked out branch (pre or post).
> 
> The whole point of a pre- hook is to run _before_ the externally
> observable state changes due to the operation.
> 
> If Stephen has a separate build-tree that fetches from the branch
> every time the tip of the branch changes in this repository to
> produce build artifacts for the branch to be shared in his network,
> perhaps via NFS or something.  "git fetch" that will be run from
> that build-tree repository will *not* see the tip of the branch, and
> running such a hook will not be possible from a pre-update-branch
> hook.
> 
> We can certainly argue that such a hook could instead push to the
> build-tree repository using the commit object name,

Exactly, it could do that.

> but I tend to think such an argument is merely sidestepping the real issue.

So you grant that there is no reason anybody can think of why we would ever
want a post-update-branch?

> Some hooks do want to observe the state _after_ the operation [*1*], while
> some hooks can do without seeing exactly the state after the operation.

Yes, and when the operation is updating a branch, nobody can think of why we
would want the former.

> So while I am generally not very supportive towards post-anything
> hook, I would reject a claim that says "pre-anything can be used
> without inventing post-anything---do the same thing and allow the
> operation and you are done".  That is not simply true.

Let's make a bet, we go for 'pre-update-branch' and five years from now, if
there's no 'post-update-branch', you will publicly accept thta I was right.

Deal?

-- 
Felipe Contreras
