From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Branching strategies
Date: Tue, 20 Sep 2011 10:12:47 +1000
Message-ID: <CAH5451kOS2d5J_iHxi_SDxHW0rDY4Xxd3JgBSgV-o_tETQjgQw@mail.gmail.com>
References: <CAAZ43xaFzJWzPsqhP0QDRTP0Ea-dMpCpr1vDiujFFn94j+SRCQ@mail.gmail.com>
 <CAH5451kn5WD4+S3_SGMarGyoUs6NA6Xvz9Pb8Wdpt9v0nY+Uow@mail.gmail.com> <4E778F15.9050705@myword.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: gitlist <gitlist@myword.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 20 02:13:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5nxb-00047y-IE
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 02:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916Ab1ITANK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 20:13:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37498 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756903Ab1ITANI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 20:13:08 -0400
Received: by fxe4 with SMTP id 4so7695fxe.19
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 17:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4xFwg/VK8XjdmhWtbTQeLMIOZ1oolcgkQy3QGLxPCS4=;
        b=N8VDz7ojPKHe21pCmEi3eWyk0YMPDrMY8VE4s3ZKo6Ek+5xU9yICyhDxhgsFInzLSF
         i4icCfNwnjCrjks44EPfWfJ67NXMuXaUrkEgiDTArTCgmQx7ffVw5YhSCUumVmgXzFNF
         qM/QKOrtDLw+95+APDtgbkxn0a3ZUORob6jNs=
Received: by 10.223.41.87 with SMTP id n23mr220964fae.78.1316477587322; Mon,
 19 Sep 2011 17:13:07 -0700 (PDT)
Received: by 10.152.37.66 with HTTP; Mon, 19 Sep 2011 17:12:47 -0700 (PDT)
In-Reply-To: <4E778F15.9050705@myword.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181722>

On 20 September 2011 04:51, gitlist <gitlist@myword.co.uk> wrote:
>> A very interesting read is
>> http://nvie.com/posts/a-successful-git-branching-model/
>>
>> It may not be perfect for you, however it does discuss some very
>> interesting issues, particularly how workflow is just as important as
>> the branching model.
>
>
> I came across the nvie post some time and it was very useful, but it doesn't
> address handling of feature branches, especially where there is overlap.
>
> I have a website where people can register. They can also buy things. If
> they haven't registered when they come to checkout, the checkout process
> includes registration. Users can also create "sponsorship" pages where they
> ask friends to sponsor them in a marathon etc. If someone setting up a
> sponsorship page is not already registered, it's included in the process.
>
> So there are three strands (to avoid using the word "branch") -
> registration, buying, and sponsorship - which end up affecting the same bits
> of code. Registration was done a year ago but recently needed updating;
> buying was started some months ago but got held up; sponsorship started
> recently, has been completed, and has "overtaken" buying.
>
> How should I use branches in this scenario? Or if I've got the concept
> wrong, how should I change my workflow?
>
> Thanks
>
> Roddie Grant

The concept of 'feature branches' apply primarily to development.They
allow you to build individual features for your system independently
of one another, and concurrently. Further, they provide a history of
commits that detail the effort that went in to creating that feature.

Once the feature is completed however, typically it will get merged
with a given release of the system. If further work is to be done on
that feature, either a new feature branch is created for the
'improvement', or a similar hot-fix/bug-fix branch is created. When
that work is done it gets merged either back on to the same release or
into a future release.

These feature branches do not host the separate functionality of the
system, but instead reveal the history of their development. I have
not heard of any intelligent way to use just an SCM to partition and
keep separate the different functional aspects of a system; developing
modules is generally achieved by writing modular code.

If you do have a number of modules you can track each of them
individually. Write version-dependencies into the modules, and you can
develop on them individually, updating them to depend on the latest
version as appropriate.

If you are not using well separated modules, and the development of
each 'thread' affects the same 'core' files, you need to migrate
changes to these core files between threads when appropriate. For
example, if you are working on the sponsorship thread, and develop a
paypal integration that you now want to include in the buying thread
(and can't continue developing it until you do), you should identify
the commits that entail that change and merge them into the buying
thread branch. Better than retrospectively trying to dig out features
and bug-fixes, however, is ensuring a clean separation of thread code
and core code. Thankfully, since git has such good merging ability,
you can often merge a feature branch which is miles behind the latest
release and it will slot in flawlessly.

There are many different aspects to this sort of work, but the best
thing to do is to keep the future in mind, and try to do things that
will make life easier down the track. The great thing about git is
that it offers many tools that make things easier later on even when
you didn't plan for them - but that is no excuse for poor planning!

Hope that helps somewhat,
Andrew
