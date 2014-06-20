From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Should branches be objects?
Date: Thu, 19 Jun 2014 18:01:47 -0700
Message-ID: <20140620010147.GZ8557@google.com>
References: <CAK3OfOiB0YWf25Hvvvqi+YBwu2V-gE-sjm7XrfE0p2zds4CE2Q@mail.gmail.com>
 <20140619234614.GY8557@google.com>
 <CAK3OfOjnYXxhWT7Vp-0Pcb=F8ze6wJnqSm1_LW0Zp1FmYZfUEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 03:02:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxnE0-0004Ls-U7
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 03:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbaFTBBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 21:01:51 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:49140 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbaFTBBu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 21:01:50 -0400
Received: by mail-pb0-f42.google.com with SMTP id ma3so2494659pbc.29
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Lo8TGERBgePtu3L6rsfyxMZvc/Km1w0eqfsOto9bdRc=;
        b=dQY6u1yPNxcNyPihDQ2qnuwm1cBvwR/sKhe91CVpW7a0OYY4+LmUivrvZqrbf8hEug
         WI+G5U25ahqNxoQs+SZQBvUF9KvlXNqos+ih/1kc5BiHdPnKoqm3D3M6HsaxQGQN/Th5
         lu9e4kSkx2FbIoyjn2b2oSfaEHaK5DT8D2t9f4qlTogxgRZZkcVNBwSyVCX7nNPKA1v5
         CNLV779Ty1e1Vb0ryTt+X/Nu8MzZ7lrzyDGtHqari2JXUOIrIHMFiCSyuWUdkHQwpzDK
         nUAJfx+Fnx23MRkdwhdEoXT0s/aWUef12CbNR5G5ftWfbh3cVfadVZ7jqL2z2HzAiy7w
         JTow==
X-Received: by 10.68.237.228 with SMTP id vf4mr105979pbc.131.1403226110365;
        Thu, 19 Jun 2014 18:01:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xk1sm34501972pac.21.2014.06.19.18.01.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 19 Jun 2014 18:01:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAK3OfOjnYXxhWT7Vp-0Pcb=F8ze6wJnqSm1_LW0Zp1FmYZfUEg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252201>

Nico Williams wrote:

> a) reflogs include information about what's done to the workspace
> (checkout...) that's not relevant to any branch,

Nope, reflogs just record changes to refs and information about why
they happened.

> b) reflogs aren't objects, which ISTM has caused transactional issued
> (even if they are fixed or soon to be),

Not sure I understand.  Do you mean that if reflogs were named by their
content then they wouldn't need to be renamed when a ref is renamed?
Or are you referring to some other atomicity issue?

[...]
> $ git checkout -b ${branch}-rebase1
> $ git rebase -i master
> ...
> $ git checkout -b ${branch}-rebase2
> $ git rebase -i master
> ...
>
> I iterate through this until a set of commits is the way the upstream wants it.
>
> No one really needs that history, except me: possibly to show my
> boss/customer, possibly to put together a list of changes I've done to
> show the upstream maintainer, ...   Yes, this is in the reflog, but...
> it's mixed up with unrelated stuff.

Yes, this isn't something we do well at all.  It would be nice to have a
tool that can take two versions of a branch (from different refs, taken
from the reflog, or whatever) and visually represent what happened to
corresponding commits.

Thomas Rast started work on such a thing called tbdiff, which you can
find at https://github.com/trast/tbdiff.

[...]
> Also, I'd like to be able to git diff
> <branch-version>..<same-branch-diff-branch-version>.  Again, for my
> own purposes in collating changes I've done to previously submitted
> PRs.

Do you mean 'git diff mybranch mybranch@{3}' /
'git diff <mybranch> <mybranch>@{3.days.ago}'?

[...]
>>>  - object transactional APIs would be used to update branches
>>
>> Ronnie's recent ref-transaction code does this.
>
> Speaking of which: are there any power failure corruption cases left
> in git?  How is this tested?

What kind of power failure corruption are you talking about?  Git
usually updates files by writing a completely new file and then
renaming it into place, so depending on your filesystem this means it
is very hard or very easy to lose data with a power failure. :)

If you're on one of those filesystems where it is very easy and you
lose power a lot, you'll probably want to enable the
core.fsyncobjectfiles configuration option.  It might be worth adding
another knob like that for the other files git writes if someone is
interested.

Jonathan
