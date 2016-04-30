From: Jan Smets <jan@smets.cx>
Subject: Re: using git-difftool -d when cherry-picking
Date: Sat, 30 Apr 2016 12:50:23 +0200
Message-ID: <CAH9ve7yExPFi-k2K87FWsCX0xtx+z8H94L2=YNNz6imXGCEtiA@mail.gmail.com>
References: <CAH9ve7x3GSVX1M3yuAY1VmM-WoFX36o-vihFQ3Jw-_SZ4Bh_og@mail.gmail.com>
	<20160430011930.GA26977@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 12:50:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awSTp-0008WO-7P
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 12:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbcD3Ku0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2016 06:50:26 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35234 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbcD3KuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2016 06:50:25 -0400
Received: by mail-oi0-f66.google.com with SMTP id w198so18091153oiw.2
        for <git@vger.kernel.org>; Sat, 30 Apr 2016 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smets-cx.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=184v0X/HBI0/K8p6VFWAOqiUkkB/LoGlCoNZY8wFbHw=;
        b=tIswfI4pFMVyD/wkkQjQ2E5l5NqWMNZqveGieLrhuYJzi7Dl0iK4Xf5pL7J2+jlYJY
         RJGvoiiOwZLMAk1uCXSkn+YwkBillJ3RE/lL0h96dywyKrvh/hqoaTGZF/3GFyzPWCe6
         WY8IRLOvxcvoNHKiZs4RycF6iOlD88G0klWhzhmUxs1Dagod7TJTiLiU8kDNWOb9WOPE
         loFcNa1nJp4nK5XP4jrkflsi1opj+xB3AiRhIxCJCxjfNBpuAd8IeJTvl+JlWj2iegDn
         3hF6T0+jWYGJ86YBztOS+pqw/XHg4drrnjHUmxo2+0p1bZNEFsNUSwiynBgojwRgCNf0
         breQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=184v0X/HBI0/K8p6VFWAOqiUkkB/LoGlCoNZY8wFbHw=;
        b=bi6ZQcRfXKakqA6MYHE9WCYrQoSclzj4/KD4RtT5bMQSsL3TgHG1SoitmYFk0ahZxV
         7M+yHaMZn5CPDnTE2OTDdK3NWQepH8r+uANwomOdHXWo7cMVVMGdxbwKdKaiskZgDvXw
         uumfQ5LIoWrGbDsTsAL8I8ZpnBODBOT6q2/3Clixh/1ru4iAavUUDtPgAORLwScYHE9h
         OIFNM7eCc2i8lslRgKvIQJ+Q//M7TmomgFZ49av8g51GTlyt5jisx1c+2r1vWD7B0uww
         Ft3B2lFgFAUA3J+sD06z/Ull/ziKeXwsZ1vpvh0ozuQcBqwLGo2gRKrIOCwo2oYxkW6s
         e5ZQ==
X-Gm-Message-State: AOPr4FV1WrO59/6IELDwxj/QPBRgm5ptQGnzn98U6jNMrm6wL2WAXkn2Z4XLNtLaCbQFy0AjwauPFi4gQDj3TA==
X-Received: by 10.202.231.11 with SMTP id e11mr9970636oih.159.1462013424028;
 Sat, 30 Apr 2016 03:50:24 -0700 (PDT)
Received: by 10.60.138.197 with HTTP; Sat, 30 Apr 2016 03:50:23 -0700 (PDT)
In-Reply-To: <20160430011930.GA26977@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293123>

On Sat, Apr 30, 2016 at 3:19 AM, David Aguilar <davvid@gmail.com> wrote:
> On Wed, Apr 27, 2016 at 11:12:25AM +0200, Jan Smets wrote:
>> Hi
>>
>> Please consider following example
>>
>> #!/bin/bash
>> rm -rf /tmp/gittest
>> mkdir /tmp/gittest
>> cd /tmp/gittest
>>
>> git init
>>
>> echo $RANDOM > testfile
>> git add testfile
>> git commit -m test -a
>>
>> git branch X
>> git checkout X
>> echo $RANDOM > testfile
>> git add testfile
>> git commit -m test -a
>>
>> git checkout master
>> echo $RANDOM > testfile
>> git add testfile
>> git commit -m test -a
>>
>> git cherry-pick X
>> git diff --raw
>> git difftool -d
>>
>>
>> This emulates a merge conflict when using git-cerry-pick.
>>
>> $ git diff --raw
>> :000000 100644 0000000... 0000000... U  testfile
>> :100644 100644 a04e026... 0000000... M  testfile
>>
>> When executing git difftool with the -d option :
>>
>> /usr/lib/git-core/git-difftool line 260: File exists
>>
>> A possible solution is to build an unique list in @working_tree
>>
>> The purpose is to edit/resolve the conflict in the difftool.
>
>
> That could be useful.  git-mergetool is intended to be used when
> merge conflicts exist, but it sounds like you may have already
> found a possible solution by making @working_tree unique.  Have
> you tested that to see if it skirts around the issue?
>
> If you have a patch I'd be happy to help review and test it.

Something like this seems to work.

26a27,32
> sub uniq
> {
>         my %seen;
>         grep !$seen{$_}++, @_;
> }
>
251a258
>     my @unique_working_tree = uniq( @working_tree );
256c263
<     for my $file (@working_tree) {
---
>     for my $file (@unique_working_tree) {

TMTOWTDI

Thanks !

-- 
Smets Jan
jan@smets.cx
