From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git remote set-head not working?
Date: Fri, 18 Dec 2009 12:38:39 -0500
Message-ID: <76c5b8580912180938s2b885efax33be860f963ba92f@mail.gmail.com>
References: <76c5b8580912180825t17bfc90eq20dfc05cafa8c02e@mail.gmail.com>
	 <20091218165302.GA1746@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Eugene Sajine <euguess@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 18:38:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLgmt-0005ro-Ih
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 18:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbZLRRil convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Dec 2009 12:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbZLRRil
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 12:38:41 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:64212 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbZLRRik convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Dec 2009 12:38:40 -0500
Received: by iwn1 with SMTP id 1so2313702iwn.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 09:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W8iIcusNf0seiVWmRKZZQbgu0Uy7p32m5Sq/edoSp1s=;
        b=ooDYgFpYrBAV/wgJgRl5TuOPIbsFi5ah31VaM/gDVT0B94UWZ923Su5SY4icS7Sc2n
         PmF5FoUxVuFbeK+lG0WT+PPyFmutPrFfEP53qS7pdBZDSqmjSw48/W9fp/BbRfBPRxQA
         32kD3G1lWOedr2+1HwEksdW4fnm22VeiTREqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XtUbVXq9BWqaXRMAhEcsuQh8PI5CYomq2cvgwQSREm2Eud4awwqRB1ESQkwLoevr12
         eeRP8q+2gRzC+yU96srK4aWJuflp16Rp+jg/OOk6V8ieNhAPOP/1V/dtL6qwcrzO3IqI
         +MUkVRjEJpRclQBex9tthA8OmbJYbucmsnNY8=
Received: by 10.231.120.90 with SMTP id c26mr1475416ibr.1.1261157919413; Fri, 
	18 Dec 2009 09:38:39 -0800 (PST)
In-Reply-To: <20091218165302.GA1746@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135421>

> Hmm. It probably worked, but what you are being shown is a bit
> confusing.
>
> "git remote show" will actually query the remote server to find where
> its HEAD is pointing. But "git remote set-head" is about changing you=
r
> _local_ idea of where the remote head is pointing (in general, "git
> remote" does not change anything on the remote side. It is about
> managing the local configuration of your remotes).
>
> AFAICT, there is no way to use "git remote" to query the result of yo=
ur
> set-head. And the "show" output makes no distinction between the two.
>
> Perhaps we should print both in "git remote show" if they differ.
> Something like:
>
> =C2=A0 HEAD branch: qa (remote points to "master")
>
> or
>
> =C2=A0 HEAD branch (local): qa
> =C2=A0 HEAD branch (remote): master
>
> That would clear up the confusion of what is happening. Whether that =
is
> what you actually wanted, I don't know. If you want to be able to ref=
er
> to "origin/qa" as "origin", then you're fine. But if you wanted to
> actually change the remote repository's idea of HEAD so that further
> clones will clone "qa" by default, then you can't do that with "git
> remote". You would have to go to the remote repository and run "git
> symbolic-ref", I think.
>
> -Peff
>

Yes. I was trying to change the HEAD on the bare remote (origin) repo
and the concept here is really confusing.


=46irstly, when i cloned from some repo "clone" comand is setting HEAD
branch for remote in accordance to where the HEAD is pointing on
origin side. I just recently realized that and i'm not sure it is best
thing to do - i think it should default to origin/master first, if it
doesn't exist then to where the HEAD is pointing.

Secondly, I don't really understand what is the purpose of "git remote
set-head" if the change cannot be transferred to the actual origin
repo, so it will start serving another branch as default? I might not
have access to the server to perform git symbolic-ref on my bare repo
(imagine the repo on github), so it might be not an option.

The problem with this is that it can be screwed up easily (i did
it;)), but the fix is not trivial.

Scenario i hit was:
My colleague created bare repo on the server and performed some
commits and pushed. We've got 3 branches on the server: master, qa and
featureX The repo got screwed up - i was unable to clone because of
repository corruption (another story probably for Shawn as there was
Egit involved;) )
So i tried to recover I cloned from my colleague, but his head was
pointing to featureX so I've got this featureX, when i was expecting
to see master.
I realized that i have to add master and qa as tracking branches for
origin/master and origin/qa.
Then i deleted corrupted server repo, created bare repo using "clone
--bare" and put it on the server. But i didn't know that i have to
checkout to master branch in order for it to be default branch served
from the server before cloning. So i ended up with the featureX being
default HEAD on the server.
That was not user friendly stuff...

And here i am trying to change this setting on the server...

Thanks,
Eugene
