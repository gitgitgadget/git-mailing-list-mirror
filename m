From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Sat, 7 Sep 2013 21:47:25 +0200
Message-ID: <CAHGBnuNKrtGSoOYS1T0VH=tGvKUW0XKFnWf_WNvZkOriGurgpg@mail.gmail.com>
References: <522A36AA.3050701@gmail.com>
	<xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
	<CAHGBnuP6w8rvoz+h2Xase1ApY_kpZh4X=VF6LY4O0r7RS0UayA@mail.gmail.com>
	<xmqqsixgvci1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 21:47:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIOTj-0006Ur-QR
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 21:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab3IGTr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 15:47:28 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:42024 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888Ab3IGTr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 15:47:27 -0400
Received: by mail-lb0-f175.google.com with SMTP id y6so3884122lbh.34
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JUl504pz3iOfNkZ2qW4Qz4JgSUH+X6dKSlGZReSA0ic=;
        b=bKXClDxjtktvCdF0zEKnXrtFTI4U0ypJGvBJkQujrV+KW0aJkJx28XukBZNQlJ94b/
         TvDY8qXMUrgjyXXKA34yswXfXyLQwsIhvB6s1hkuULzEpgz6oKGD8R0Vq+9DHP41G38F
         4IuqFLTuSsw7RghDD5Idoofnk0LrEAqlg7pOvIRJ8NDFZdTkErmlCehy0KPWDMGH4YT3
         gHeUCrC/A5atMGZF2ETM0pgo/+Ko4JXXRmsDgoTlBFWBpH9Vu5k0HWoPOZ+HSMpzfkn2
         thNvdWhvnJKnWOOqPYwylxOrrQgrwW/AhpWdVMunb10FJK/jZyyytU58FCaeY0f7CKZ5
         OzSA==
X-Received: by 10.112.89.100 with SMTP id bn4mr8658952lbb.16.1378583245897;
 Sat, 07 Sep 2013 12:47:25 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Sat, 7 Sep 2013 12:47:25 -0700 (PDT)
In-Reply-To: <xmqqsixgvci1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234141>

On Sat, Sep 7, 2013 at 6:10 PM, Junio C Hamano <gitster@pobox.com> wrote:

>>> If you want to give build a custom name,
>>>
>>>     echo buildname >version
>>>
>>> should be sufficient, no?
>>
>> That's not sufficient if you care about a proper (automated) release
>> workflow with your releases tagged.
>
> I take the above "your" does not refer to "mine, Junio's".

Right, I was not meaning to refer to you personally or Git as a
project, but "anyone's project".

> I am not sure what you mean by automated, but if you can tell your
> automation infrastructure that the way to build this Git software is
> to run "make" in it, shouldn't it be trivial to instead tell it to
> run something like this instead?
>
>         git describe --tags HEAD >version && make

It probably would be trivial, but I'd like to use as much of upstream
Git's build logic as possible without the need to create a custom
file.

> Or are these tags you want G-V-G to use also droppings of the
> automated process?  That is, what you tell the automation
> infrastructure is to run something like this?
>
>         git tag build-$(date +"%Y-%m-%d") && make

Sort of. I manually tag a commit as "good for testing", and the CI
server that's watching for new tags in the repo then builds my custom
Git from that tag and runs the tests. If all tests pass the custom Git
binaries are packaged and uploaded to a binary artifact server. I'd
like the version that git reports as well as the version that's
included in the binary artifact file names to be directly derived from
the tag. I simply do not like the idea of having a tag *and* a version
file, even if the version file is derived from the tag, simply because
there's still a slight chance that the tag and version file might
diverge due to some mistake / error / bug.

> I do not think the current use of "describe" helps the builder to
> avoid making a light-weight tag by mistake anyway, as it would be
> very natural to update DEF_VER to a matching string. In a month or
> so, I am sure I'd update that line to v1.8.5 before I make a tag
> with the same name, and it does not matter if the current use of
> "describe" skipped a mistakenly-made lightweight v1.8.5 tag when
> deciding the embedded version string---the end result will get the
> same string from DEF_VER and running "git version" with the built
> binary will happily show v1.8.5 the same way.

Which raises another question on my side: Isn't it tedious for you to
both update DEF_VER *and* tag a version? Wouldn't it probably be less
error prove (in the sense of keeping DEF_VER and tagged version in
sync) to remove DEF_VER completely and just die if all ways to derive
a Git version fail?

> I am however still curious what kind of other tags (either signed,
> annotated, or lightweight) you are using for this purpose. Is there

In general, so far I had very little use for other tags than
lightweight tags. That's mainly because I believe my stuff is not
"important" enough to be signed, and I rarely have something to say
about a tag besides its name. Most annotate tags I've seen so far are
just trivial variations of the tag name, anyway.

> a case where you have your own tag that points at the exact version
> as I tagged?  In such a case, do you have a preference on which tag

No. I always carry patches on top.

-- 
Sebastian Schuberth
