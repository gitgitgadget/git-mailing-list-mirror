From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: How to find where a branch was taken from.
Date: Fri, 21 Mar 2008 14:48:28 -0400
Message-ID: <32541b130803211148r651d03eev98a478b13e69f710@mail.gmail.com>
References: <47E37A63.9070209@glidos.net>
	 <7v4pb0qw28.fsf@gitster.siamese.dyndns.org>
	 <32541b130803211039h1f5b8da5k8fb353d46e57b05e@mail.gmail.com>
	 <20080321183225.GA13583@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Paul Gardiner" <osronline@glidos.net>, git@vger.kernel.org
To: "Charles Bailey" <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcmIj-00048Y-Ii
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 19:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968AbYCUSsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 14:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754143AbYCUSsb
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 14:48:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:18464 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbYCUSsa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 14:48:30 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1437018fgb.17
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 11:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=X5hBAu3NkfRa5JMQTzM/O1mcNEruD4gKrLdXrPQck6E=;
        b=peUYskz/E6SAr8mStjcH8r7PcrWZVOjTeL2z0VMgAIX2eJ0VhL3Tp6aBeA1o0MCZywZ2RmdIfyo4qC+kDxEUVpdXh62wyOn7sKUGPEmVpPDo7KCyp5n7wbwj0Ior9OC1ipG7eF1MUvdrwMnStE84fSRpxg3ZgGWSMsa2GPT4EHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pEs1tYek9uPnI2XGB6PuGJKr2ht4ESQHZgjOniyZ0mJcr/+Sx0+ezg86apHowER5W5sRJFp1yBd/JXfJZ2uxqyV2farDWypg1tXlgVxZffl+6tqTqg5xQadvGCzGsRq7cSCUSgSqpwM+dSZ3SFmnMKcOS54wDRN23WSiMer/bQ8=
Received: by 10.82.118.2 with SMTP id q2mr8178876buc.27.1206125308268;
        Fri, 21 Mar 2008 11:48:28 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Fri, 21 Mar 2008 11:48:28 -0700 (PDT)
In-Reply-To: <20080321183225.GA13583@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77757>

On Fri, Mar 21, 2008 at 2:32 PM, Charles Bailey <charles@hashpling.org> wrote:
>  > In order to do this, however, I'm forced to remember where I got my
>  > "original" version from, which isn't even that important.  As the
>  > developer of a particular patch, all I *really* should have to know
>  > is: a) here are the things I added since I made my topic branch, and
>  > b) here is the branch I want to rebase them onto so I can submit my
>  > cleaned patches upstream.
>
>  Why are you forced to remember?
>
>  If you don't want to transplant the patches onto where the remote
>  branch is now, then you just need to pick a commit on your current
>  branch that is before any commit that you want to reorder/recombine
>  and do a git rebase -i <sha1>. (It should be easy to pick a commit
>  from git log. Perhaps it's the first one with and author that isn't
>  you.  [...]

All these things work, but they're unnecessarily tedious manual
remembering.  If I have a lot of topic branches on the go at once,
things start getting a little messy and it's hard to remember which
patches came from where, particularly if I'm aggregating, reviewing,
and cleaning up patches from several people at work before sending
them upstream (in which case I don't always recognize the checkin
messages presented in git-rebase -i).

svn has "svn log --stop-on-copy", which is useful in exactly this
situation.  A git branch is not really a "copy", of course, so the
actual implementation can't be the same.

"git show-branch" has logic very close to what we need here: if you
give it the names of your current branch and its parent, it'll show
you just the changes on both branches since the branchpoint.  But I
don't really want to know about additional changes on the parent, only
on the branch I'm working with, and I often prefer the output to be in
git-log's (very flexible) format instead of git-show-branch.

Have fun,

Avery
