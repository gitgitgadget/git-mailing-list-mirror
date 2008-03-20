From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH Second draft] Fast forward strategies allow, never, and only
Date: Wed, 19 Mar 2008 20:44:27 -0800
Message-ID: <402c10cd0803192144n716cf66dgd4d660f4917a80fc@mail.gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
	 <m363vkvvzb.fsf@localhost.localdomain>
	 <402c10cd0803182320k134116cas5f62389482f2650a@mail.gmail.com>
	 <200803192220.59035.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 05:45:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcCep-0007p5-BF
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 05:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbYCTEob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 00:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbYCTEob
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 00:44:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:54645 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbYCTEo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 00:44:29 -0400
Received: by fg-out-1718.google.com with SMTP id l27so658070fgb.17
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 21:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=IY0q5Z2mRr3CPHZkucFbV+hdoxROAWSbZB9GrGUxqGc=;
        b=LhpOS6DY6bU/Y3Dfc3CZWJEz7XJEHAJe9sEeG7OvXoDBaNPXKmZ0BAnbLF0pgPXtq6qICc5KX79s0/UP+L1e1tfmCUIY4nTOc6hoWHRWYldV3cE3BRgF80g3OlqcgARGaKn8VLgJc1FDbVCY3eSn6pJtOOja7d/VFUlNBlgZ7FY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jp0K13Jy00quqGj6b0AQP4MLiSnJZXmgmP5X2zmPsQtNv4W1ODmocr60ojD9aiUvzC2Iuvd/ffcJKj9kAUCIrVBfT9+9wZNoIcnVaZsG/aEVcLF1eBSl992aJlrw2893ilA9bKjAqjabZZ4ZFkgpnYUFjj5z/H3NU3YAXPEMPA8=
Received: by 10.82.177.5 with SMTP id z5mr955045bue.14.1205988268011;
        Wed, 19 Mar 2008 21:44:28 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Wed, 19 Mar 2008 21:44:27 -0700 (PDT)
In-Reply-To: <200803192220.59035.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77625>

On Wed, Mar 19, 2008 at 1:20 PM, Jakub Narebski <jnareb@gmail.com> wrote:

>  > +The following shows master and three topic branches.  TopicB is based
>  > +on TopicA, TopicA is previously branched off from master, and TopicC
>  > +is based on the current `HEAD` of master:
>  > +
>  > +------------
>  > +                    o---o---o  TopicB
>  > +                   /
>  > +          o---o---o  TopicA
>  > +         /
>  > +    o---o---o---o---o---o  master
>  > +                         \
>  > +                          o---o  TopicC
>  > +------------
>
>  I'd provide first simpler example without 'TopicC'.

If we are to explain how this is recorded this is how simple we can
make it without leaving anything out.  However, I am not sure we
should have this in the documentation at all.  Most users probably
don't care exactly how this is recorded as long as the history down
the road is not to complicated.

>  If I understand correctly you have implemented here always using
>  "parent" (or "dependent") reduction of merge heads. IMHO this reduction
>  contradict stated idea of using --ff=never (--no-ff) to always mark
>  where topic branch has ended.

When using --ff=never this reduction will not be done and that is also
how current git works (except that you need to say --no-ff).

>  > +         % git co master
>  > +         % git merge TopicA TopicB TopicC
>  > +
>  > +                    o---o---o  TopicB
>  > +                   /         \
>  > +          o---o---o  TopicA   \
>  > +         /                     \
>  > +    o---o---o---o---o---o.......o  master
>  > +                         \     /
>  > +                          o---o  TopicC
>  > +------------
>
>  This... is a bit unexpected. I thought that there should be line where
>  I have added dotted line.

The graph also describes how current git record this.  Try the example
and see for yourself.  The main difference between the patch and
current git is that the patch is trying to be smarter about how it
selects the merge algorithm, and which commits are passed on to the
real merge algorithm.  In the example above it makes no difference
since octopus is used and whether octopus is getting three or four
branches does not matter at all since the octopus merge is able to do
this reduction internally.  But in the case where we end up with two
branches it makes a huge difference since we then can use the more
smarter merge algorithms, and more cases will be merged automatically.
 However, all this does not make much of a difference in most cases.
Git rocks whether we decide to do this or not.

>  I'd really prefer if you would resurrect merge head reduction options
>  (strategies?) as it was, i.e. as separate patch. And of course talk
>  about reducing heads, not fast-forward options/strategies... this issue
>  is IMVHO orthogonal to options for allowing/forcing/denying fast-forward.

The first patch had the same features, was implemented slightly
differently, but lacked a lot of documentation.

-- 
Sverre Hvammen Johansen
