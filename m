From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: help with distributed workflow/signoff
Date: Wed, 14 Jul 2010 13:24:22 -0400
Message-ID: <AANLkTimdVvKYPQn84IQvk7yxMo-gtrjWWqzN-ypXV78X@mail.gmail.com>
References: <loom.20100714T180615-173@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brock Peabody <brock.peabody@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 19:24:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ5hR-0007D7-O8
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 19:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294Ab0GNRYo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 13:24:44 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34171 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0GNRYo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 13:24:44 -0400
Received: by gwj18 with SMTP id 18so3526718gwj.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=x+0OWySChxuaE9G/HDUsSdJe1xsluRdNyHTMHk7ryCI=;
        b=LMv29Wjd0czxvI5JedZLbvuWiSl50QNagZeRWC1Xm7IJpxPIDYBk1jCQ5MhKa6ft44
         /eyMSNk2+02ys+XV4767h1iegO92xiRHVQj1DyV96FoQyb/jC3wCuB4URj1lzyljodCk
         8+SXyk8VBSuvUta+Arcc46w0weYg3S0OV4+mk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=errSoi+cMd5dI/NUC8wu5IOo77+lLWEi2sVvY3rPbdo67Vv4lD2yBxpKJdCpRNs9HH
         /s1OXZd6LWqTRWzUze8YOjBM6qmmCwTJHiYBgNbU1Dp00LEgmtiIFZq7zoALmt8yCR1k
         gBW1NmwGgTxkfVZ3ryyFDmVbL5RRJnYoj9yZI=
Received: by 10.150.214.20 with SMTP id m20mr2629932ybg.368.1279128282122; 
	Wed, 14 Jul 2010 10:24:42 -0700 (PDT)
Received: by 10.151.85.19 with HTTP; Wed, 14 Jul 2010 10:24:22 -0700 (PDT)
In-Reply-To: <loom.20100714T180615-173@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151017>

On Wed, Jul 14, 2010 at 12:33 PM, Brock Peabody <brock.peabody@gmail.co=
m> wrote:
> We've scoured the internet for solutions. =A0One idea we have tried a=
nd abandoned
> is using 'git commit -s --amend'. This does create a new revision wit=
h the
> signoff information we want, but the problem is that it creates a new=
 revision.
> Eventually, the developers (and the GateKeeper repository) will end u=
p with both
> the revision containing the signoff and one without it.

One option is to avoid trying to signoff each *revision*, but instead
signoff on an entire *batch* of changes.  Basically, the maintainer
would do something like this:

   git checkout master
   git merge --no-ff whateveruser/whateverchanges
   git commit --amend --signoff
   git push

Then the maintainer will have a merge commit that shows he looked at
it.  All the individual sub-patches will remain identical, so nobody's
history gets confused.

> I've seen evidence of what we're after - by browsing the repository o=
f git
> itself. =A0Each revision in it contains an "Author" field and a (freq=
uently
> different) "Committer" field. =A0Furthermore, there are often multipl=
e
> "Signed-off-by" and "Acked by" logs. =A0How are these fields populate=
d? =A0Are new
> revisions created each time the sign-off information is added? If so,=
 how do the
> contributors deal with these new revisions when synchronizing with th=
e master
> later? =A0How are the pre-signoff revisions purged from the bare Gate=
Keeper
> repositories?

The way it works in git is that patches are sent in via this mailing
list - the maintainer rarely uses git merge or pull (except to merge
his own branches).  Thus, the "author" is the person who emailed the
patch, and the "committer" is the person who applied the patch to his
own tree.

The result is an elegant looking history, but of course, the committer
generates an entirely different commit id than the author had in his
own history.  Since the maintainer never pulls directly from the
author, it's each author's job to wipe/rebase his own history
occasionally to stay in sync with the "upstream."

=46or an open source project, where most contributions are by volunteer=
s
and need to have their patches reviewed multiple times before
submission - and frequently, more patchsets are rejected than applied
- this works reasonably well.  For a company where (in my experience
at least) most people's patches *are* applied, and the ratio of
reviewers to coders is much lower, that's much less workable.  And
unfortunately the elegant looking multiple-signed-off-by or acked-by
lines don't work so well for that.

Oh, now that I think of it, you might find git-notes useful.  I've
never used it but I understand it lets you add lines to the log
messages retroactively.  Of course, that can be both a blessing and a
curse.  If you can retroactively change signoffs, the signoffs aren't
that valuable.

Have fun,

Avery
