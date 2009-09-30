From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Re: git svn's performance on cloning mono's branches/tags...
Date: Wed, 30 Sep 2009 23:04:30 +0100
Message-ID: <3ace41890909301504w633323b9ybec1f42c1c169225@mail.gmail.com>
References: <3ace41890906251739r45b3eae9oe1b7e32886defc0f@mail.gmail.com>
	 <4A445959.6090403@op5.se>
	 <3ace41890906260259o3be005fq6be9d0e2c3f9af66@mail.gmail.com>
	 <4A44A9A9.6030008@op5.se>
	 <3ace41890906260644t3eddb2d2sb4ddbcb6499801@mail.gmail.com>
	 <3ace41890906261817y523c9321xd621fb3130941d91@mail.gmail.com>
	 <3ace41890906272008t96bfb04q7218e95055897900@mail.gmail.com>
	 <20090702081615.GB11119@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Oct 01 00:04:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt7Hv-0002Mo-Aa
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 00:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbZI3WE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 18:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754741AbZI3WE3
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 18:04:29 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:60730 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736AbZI3WE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 18:04:27 -0400
Received: by ewy7 with SMTP id 7so6912672ewy.17
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=7QvnPOM6AzoKMETFLiVM0QcEP1o6VimAwb6+ztkXmsI=;
        b=AbwL74+FvM3zY3NtI17w/fmtfBN43vLQ6ICk9MBC0P/iCd8n54Lh8IeJHNwAcN9Y0x
         XEjo6ETT7BajLqv450j0p53CYqVkHpjmGlt+BFRbO6YTUWYRGsHyobcLbK+lpDrJXa8R
         Q6CWh7d6j/zY+yVZGIkVBZFFaOwXccNZf59aA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dmUJX+SszXxd9BDIu2b69aEoeEQlkrZGQvMXOEchoXX30jhRPnajo+mRpM66hKhVQH
         otiiIH3GtuXstC+DIY9exeCDDX8VlgjVcKocCXIC/jyS4GrLHM4uVFjIqc7HJDYojjRL
         RsA8VbZuE8wH1Dkz+JVqIclFiEW8LilKw87b0=
Received: by 10.216.3.3 with SMTP id 3mr79042weg.86.1254348270686; Wed, 30 Sep 
	2009 15:04:30 -0700 (PDT)
In-Reply-To: <20090702081615.GB11119@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129361>

On Thu, Jul 2, 2009 at 9:16 AM, Eric Wong <normalperson@yhbt.net> wrote:
> Hin-Tak Leung <hintak.leung@gmail.com> wrote:
>> On Sat, Jun 27, 2009 at 2:17 AM, Hin-Tak Leung<hintak.leung@gmail.com> wrote:
>>
>> > the tags, branches, url entries are effectively the same, I think - so
>> > the main difference is using trunk instead of fetch.
>> > Why does it make any difference? The example at the bottom of
>> > git-svn's man page uses the trunk notation. Maybe it should be
>> > changed?
>>
>> To answer my question - I think the man page should be updated.
>
> Somebody actually fixed it a while back:
>
> commit 0e5e69a355b7bdd1af6ca33ac7ee35299bda368e
> Author: Wesley J. Landaker <wjl@icecavern.net>
> Date:   Wed Apr 1 16:05:01 2009 -0600
>
>    Documentation: git-svn: fix trunk/fetch svn-remote key typo
>
>
> As far as performance goes, SVN's flexibility of tagging and having
> multiple subprojects interacts quite badly with git svn's --stdlayout
> behavior.
>
> With --stdoulayout, git svn supports tags/branches that are directly
> descended from the top-level of trunk:
>
>        svn cp $root/trunk $root/tags/0.1.0
>
> However, it looks like mono does things like this:
>
>        svn cp $root/trunk/mono $root/tags/mono-0.1.0
>
> And when git svn sees that $root/tags/mono-0.1.0's parent is
> $root/trunk/mono and not $root/trunk (which it's actually following),
> it will try to fetch the complete history of $root/trunk/mono
> ($root/trunk may not contain all the history $root/trunk/mono contained,
> either).
>
> --
> Eric Wong
>


Hmm, I am having another problem with git-svn going back and download
everything over and over with this:

git svn clone -s https://ndiswrapper.svn.sourceforge.net/svnroot/ndiswrapper

I am going to do two-step init -s then fetch --all now to see if it helps.

(it is probably not entirely standard layout with the extra CVSROOT?)
