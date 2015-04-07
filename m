From: Shane da Silva <shane@dasilva.io>
Subject: Re: Why can't I stash submodule changes?
Date: Mon, 6 Apr 2015 22:19:02 -0700
Message-ID: <CAAKwDd8oNdCWew7AfTg9+7z7gox3n2PYf01DUcCNbdGAWPBjqw@mail.gmail.com>
References: <CAAKwDd8SVA=ynzH_U1M3bb+mLZMnF79-imBLrU+x9qcbXfWO3g@mail.gmail.com>
	<5522C92B.6090700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 07:19:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfLum-0005H7-G2
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 07:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbbDGFTE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2015 01:19:04 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33408 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbbDGFTD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2015 01:19:03 -0400
Received: by qkx62 with SMTP id 62so41441589qkx.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 22:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gTSw4msiUvmQyqILxleZCMlenTR0e0jVFvFxDFWHATs=;
        b=ezwV7NVMLyd22FWfFyX3F5EYnTefMMfIz2XwHTpvroMmDUSQyZETnnwg1UxGzRK3vZ
         a2vVFiFv8wUiRZOW3OLhB3L9hHu3uCCP7LvI45DHG4cKEvNT0fbeLt3DzXkcXWK/0/+Y
         PreQxXPW9J//E48pJ7IfOJ8jWdKLsqYTpwR5NDoZd1aS3YDvyJUEa1JXBt7uvIGznjBc
         GBxLfrTTesSUWpys0H3foghYGqLBc/OWyMq7oA9gG84SE39a5XHScib6n0TJTWxFG8Jd
         gsqKm28EfjmsaiHaxjuUdNDgEybyvmAOznSzfnHjhibjgSSS9aMUrdhLzuZisOeRzFlQ
         WgCQ==
X-Gm-Message-State: ALoCoQnD1huI5hXrSsbde42bGS2mD9zJ5rx7RIoFqS2wR0r/0MbKeYo8CP/C1gtwb0BYUv5sUWGz
X-Received: by 10.55.54.136 with SMTP id d130mr9251458qka.22.1428383942271;
 Mon, 06 Apr 2015 22:19:02 -0700 (PDT)
Received: by 10.229.138.1 with HTTP; Mon, 6 Apr 2015 22:19:02 -0700 (PDT)
X-Originating-IP: [67.180.197.85]
In-Reply-To: <5522C92B.6090700@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266900>

Thanks for your responses, all.

Jens: yes, only the index is updated by the stash. The subdirectory
remains and won't be removed (you will actually receive a warning
about `git` not being able to remove it).

I think the core of my misunderstanding is I was used to the idea that
when `git status` showed modifications to tracked files, `git stash`
would make those modifications disappear. Submodules are fundamentally
different, and it makes sense to me now why it wouldn't necessarily be
a good idea for `git stash` to be a mutating operation on submodules.

I ran into this behavior while debugging an issue with a git-hook
manager I maintain, called Overcommit
(https://github.com/brigade/overcommit). It was discovered that if you
only add submodule changes to the index and then run `git stash save
--keep-index`, an exit status of zero is returned even though no stash
was created. I had assumed that if the return code was zero, a stash
commit was created, but it makes sense why this is not the case.

Thanks again for your time in helping clarify this behavior.

On Mon, Apr 6, 2015 at 10:58 AM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 06.04.2015 um 04:15 schrieb Shane da Silva:
>>
>> I=E2=80=99m having trouble understanding why I cannot stash changes =
to a
>> submodule.
>>
>> When adding a submodule to a repository (`git submodule add
>> ./sub-repo`), I can then run `git stash` and `git stash pop` with
>> expected results=E2=80=94the submodule disappears and reappears in t=
he working
>> tree.
>
>
> Just to be sure: Only the index of the superproject and the .gitmodul=
es
> file are updated by stash to either contain the submodule or not. But
> the subdirectory "sub-repo" stays unchanged and won't be removed or
> reappear, right?
>
>
>> However, when I try stashing an update to a submodule, `git stash`
>> reports =E2=80=9CNo local changes to save=E2=80=9D. The following sh=
ell script
>> illustrates this behavior:
>>
>>
>> # Create repo
>> mkdir test-repo
>> cd test-repo
>> git init
>> git commit --allow-empty -m "Initial commit"
>>
>> # Create submodule
>> mkdir sub-repo
>> cd sub-repo
>> git init
>> git commit --allow-empty -m "Initial commit"
>> cd -
>>
>> # Add submodule
>> git submodule add ./sub-repo
>> git commit -m "Add submodule"
>>
>> # Modify submodule
>> cd sub-repo
>> touch foo
>> git add foo
>> git commit -m "Submodule changed"
>> cd -
>>
>> # Stash submodule change
>> git stash # <---------------------------Displays "No local changes t=
o
>> save=E2=80=9D
>
>
> Thanks for providing a recipe to reproduce this!
>
>> I=E2=80=99m trying to wrap my head around why this is the current be=
havior, as
>> I suspect this is intentional but it seems unexpected. If anyone can
>> shed any light on this, I would really appreciate it!
>
>
> The current behavior of git is that submodule contents aren't updated
> when the superproject changes. Running "git submodule update" later
> will then update their content to most submodule changes (but e.g. it
> won't remove a deleted submodule from the work tree). So yes, this is
> expected until recursive submodule update materializes (and even then
> I'm not sure how to handle untracked but not ignored files inside a
> submodule when stashing will result in the submodule directory to be
> removed).
