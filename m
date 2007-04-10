From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Tue, 10 Apr 2007 15:04:33 +0200
Message-ID: <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 18:17:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbG1W-0001P3-IH
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 15:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965483AbXDJNEf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 09:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965513AbXDJNEf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 09:04:35 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:17227 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965483AbXDJNEe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 09:04:34 -0400
Received: by an-out-0708.google.com with SMTP id b33so1935211ana
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 06:04:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iuEduXQGM0WesIdPw8qHW9v3vERRbWwV43J5Pwxg5/gk/Wr6mz8/9Ke6T5F2QpzNkp2uacre39ddAxYcXHbik6NJ1goRnh6X6Nyz2wMqsvf5o1d4+kX/4s1pEo4ae6kvBvgs1ikOL12U546uCFfTJVXIhw4Hik7VTOt6o8F04jg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U1fPeuZBZ0h0SGDDviivVrxdrk0WIVV5bp0Wj0znU+3S3DYn6d+TZDjJz88+Zuk+hwXusUkMpeAbhthWAd332UEq19mvPmQs6jrChCVBgntVc+syPykgtCRIfDT4QOTcWH13E4OnNM9iE2YZcIX6PwqOUP1vwu9WSbr9FvJnpKM=
Received: by 10.100.191.5 with SMTP id o5mr4861501anf.1176210273433;
        Tue, 10 Apr 2007 06:04:33 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Tue, 10 Apr 2007 06:04:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44130>

On 4/10/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Here is, for your enjoyment, the last patch I used to actually test this
> all. I do *not* submit it as a patch for actual inclusion - the other
> patches in the series are, I think, ready to actually be merged. This one
> is not.
>
> It's broken for a few reasons:
>
>  - it allows you to do "git add subproject" to add the subproject to the
>    index (and then use "git commit" to commit it), but even something as
>    simple as "git commit -a" doesn't work right, because the sequence that
>    "git commit -a" uses to update the index doesn't work with the current
>    state of the plumbing (ie the
>
>         git-diff-files --name-only -z |
>                 git-update-index --remove -z --stdin
>
>    thing doesn't work right.
>
>  - even for "git add", the logic isn't really right. It should take the
>    old index state into account to decide if it wants to add it as a
>    subproject.
>

The other thing which will be missed a lot (I miss it that much)
is a subproject-recursive git-commit and git-status.
It is very possible that the default should be different for
the git-commit and git-status: git-commit is likely to have it
off whereas git-status will very much depend on how fast
the usual response is (or wished for). An integrator on very fast
machine may like it on for both, a subproject developer can have
it off for both (to avoid accidental commits and generally being
not interested in anything besides his code), an occasional person
can have the status defaulting to on and commit to off - to avoid
accidental commits in subprojects which are just tracked.

A separate config option and a command-line switch, probably.
