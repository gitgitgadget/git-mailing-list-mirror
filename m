From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Commiting changes onto more than one branch
Date: Wed, 25 Nov 2009 12:38:56 -0500
Message-ID: <32541b130911250938y63a78e86p3f9b842999ff932c@mail.gmail.com>
References: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com> 
	<76c5b8580911250838x361ae081n271fcee2d1234703@mail.gmail.com> 
	<6b4a562b0911250847x59116687iba1d1640ca6c3887@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Mike Jarmy <mjarmy@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 18:39:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDLqG-00086M-WE
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 18:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759242AbZKYRjR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 12:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759220AbZKYRjP
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 12:39:15 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:35374 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759242AbZKYRjL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 12:39:11 -0500
Received: by yxe26 with SMTP id 26so6633626yxe.4
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 09:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=j+1tCe/iMFaCLahDGlC1Az7khLgtD7+tg7UONicxsl8=;
        b=AX2KsQzFbY1fSCrNDn+qLBX6AIRcvJi2rlb4++fqv2UUtRTmDCO0SdDAINqXCZMrD/
         rBF7FAkcqhk3ir5HlY7qPN9szgKkWnp8XMKxFtwciHnEfqEXZobULmJDq1uunrdkIoud
         2qbW54dEu4ZsgE+WwNlNkzT7+GEKgY2J3Fwlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wOsMNfNxZ7PzA9zmVhfKIv0rQJTEqaXQL3i1EjWcljtsppYZl59bef15KXtv08dDAC
         RywXFu2WD2BOh8jllnaethuw197OsDcmBea/g02NWayaOa77YSYH58l+kkuR1ZLM39HZ
         tAPYJ9ZVNzA4jwniE+gdqGfc9oyXcqhVvCvx4=
Received: by 10.150.161.4 with SMTP id j4mr11761875ybe.264.1259170756104; Wed, 
	25 Nov 2009 09:39:16 -0800 (PST)
In-Reply-To: <6b4a562b0911250847x59116687iba1d1640ca6c3887@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133654>

On Wed, Nov 25, 2009 at 11:47 AM, Mike Jarmy <mjarmy@gmail.com> wrote:
> I guess I didn't explain it too well, I made it sound like v3, v4 and
> v5 were still more-or-less the same. =A0What I'm thinking about here =
is
> a case where we have switched to git a while back, and then done a lo=
t
> of work on the various different branches, so that v3, v4 and v5 have
> diverged very far from each other. =A0In that case, we would never wa=
nt
> to merge them together.

What many people do is, in fact, to merge v3->v4->v5.

This isn't as crazy as it sounds.  Once upon a time, v4 was just an
earlier version of v3, right?  And when you fix a bug in v3, it was
usually also a bug in v4, right?  So in fact, for many projects, it's
safe to say that "after we created v4, all further changes to v3
should be propagated to v4."  And likewise from v4 to v5.

In that case, you'd simply do

   git checkout v3
     # commit your fix
   git checkout v4
   git merge v3

Now, setting that up in the *first* place can be a bit tricky, since
the way your imported history probably currently works, git doesn't
actually know that the history of v4 is a superset of the history of
v3; it thinks of them as two totally different histories, and merging
from one to the other will be completely disastrous.  So you have to
do a bit of setup first

   # manually make sure all your required patches from v3 are now in v4=
=2E
   # just do it the way you used to do it (the hard way)
   # now tell git that it's done:
   git checkout v4
   git merge -s ours v3

After that, future merges from v3 to v4 will be easy (the first set of
steps above) and include only the newer changes.

Note that merging fixes back from v4 to v3 is entirely different,
because you'll *never* want to take *all* the changes from v4 and put
them into v3.  The best thing to do is apply them to v3 first, then
merge them into v4, but of course that won't always be how developers
end up doing it.  In that case, you can backport them using 'git
cherry-pick' (see the git docs).

Note that using topic branches, as Thomas and Jakub mentioned, is
orthogonal to this method.  That is, your problem could be resolved by
doing that, or this, or both.  (Although if the histories really are
totally disjoint, you'll still need to do something like the '-s ours'
trick first.)  On my own projects, I do a bit of both methods; simple
bugfixes go straight to the earliest relevant release branch, but
bigger changes go on topic branches.

Have fun,

Avery
