From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Proper way to abort incorrect cherry-picking?
Date: Thu, 29 Apr 2010 08:39:40 +1000
Message-ID: <o2j2cfc40321004281539j28fe44e0r5d029061e3e08b90@mail.gmail.com>
References: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com>
	 <r2s302ed1461004281249xd1b65e41l43fa7b639db7c97d@mail.gmail.com>
	 <h2v76c5b8581004281259yfaca7abfz5a455ff8fd6cdc6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Borowitz <dborowitz@google.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 29 00:40:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7FvI-0000hF-O9
	for gcvg-git-2@lo.gmane.org; Thu, 29 Apr 2010 00:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757106Ab0D1Wjm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 18:39:42 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:60843 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756335Ab0D1Wjl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 18:39:41 -0400
Received: by qyk9 with SMTP id 9so22011807qyk.1
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZHWKosxW4Chl+X40ThTej7yK+w15VAyl6bttTfQe9Ro=;
        b=q4nS0vZ/Kcj/Er/fGQDR5c2MWj0IAdJbuwqb7eLuHpOq0kbWvKK8Qbos4Zmru/FNbl
         DBf1NW87oxR2QdsfRKwP+yfB6pfoLYDa/ZmWHqUDgt6FSEqxVrIjSJ7Net16PVVA7FKl
         ji1vrht7IYEa11dD29JvYdEF/U55PfqsrUwfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DNGD6x1Oz9nlF4YueMCnI9gfLsN5lqVUEd99yguClzYKn/wDv1ei7gJvnla+RwAXZA
         HQl9cjz858SPKfO+yP5pCXpsC025pLDSoxuDREtKjmMmsEXRYrbePSvjtgHLsWzUxI7w
         Np+6S9/vmIl/pQu/m7+kCcNulq+gWdSE2MI7w=
Received: by 10.229.232.198 with SMTP id jv6mr10479623qcb.11.1272494380791; 
	Wed, 28 Apr 2010 15:39:40 -0700 (PDT)
Received: by 10.229.224.65 with HTTP; Wed, 28 Apr 2010 15:39:40 -0700 (PDT)
In-Reply-To: <h2v76c5b8581004281259yfaca7abfz5a455ff8fd6cdc6b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146017>

On Thu, Apr 29, 2010 at 5:59 AM, Eugene Sajine <euguess@gmail.com> wrot=
e:
> On Wed, Apr 28, 2010 at 3:49 PM, David Borowitz <dborowitz@google.com=
> wrote:
>> On Wed, Apr 28, 2010 at 12:38, Eugene Sajine <euguess@gmail.com> wro=
te:
>>>
>>> hi,
>>>
>>> we have tried to cherry-pick 2 commits from one branch to another
>>> branch, but unfortunately the incorrect commit was chosen to be
>>> applied first.
>>>
>>> Thus, the automatic cherry-pick failed and caused conflicts, so in
>>> order to to cancel the whole operation i had to do the following:
>>>
>>> 1. mark the conflicting files as resolved (without even resolving
>>> them) by doing git add.
>>> 2. unstage all files staged for commit as a result of incomplete ch=
erry picking
>>> 3. manually checkout touched files to their correct state (git chec=
kout file)
>>>
>>> and then i was able to repeat cherry-picking with correct commits.
>>>
>>> Is there a better way?
>>
>> git reset --hard HEAD@{1}?
>
> not always working. In our particular case there were some local
> modifications to other files, which would be blown away with this for
> no reason. That's why I went the long way of resetting specific files=
=2E
>

If you use git reset --mixed HEAD@{1} you can reset the index to
HEAD@{1} to reflect the pre-merge state. The unstaged changes will
then be a combination of the failed merge and the local modifications
to the files. You can then revert the changes from the merge.

Then you can use git stash to move the local modifications out of the
way, then repeat the cherry pick in the correct order, then use git
stash pop to reapply the local modifications to the working tree and
index.

This is more complicated than it needs to be - if you had stashed (or
committed) before cherry picking, things would be simpler.

jon.

> Thanks,
> Eugene
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
