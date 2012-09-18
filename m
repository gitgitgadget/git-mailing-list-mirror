From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCHv5] clone --single: limit the fetch refspec to fetched branch
Date: Tue, 18 Sep 2012 16:08:03 +0200
Message-ID: <CAN0XMOKCZL+X1QNW7CPmu-wdpVN0HjK=3z-sTz5naSQ5RW3x4w@mail.gmail.com>
References: <CACsJy8BGBwNp-oDsnB1QObrVLU54rtDmGGBF=Muww8ZJjfZScA@mail.gmail.com>
	<1347909706-22888-1-git-send-email-ralf.thielow@gmail.com>
	<7v8vc8v1wd.fsf@alter.siamese.dyndns.org>
	<CAN0XMOKCsjfG-DgV_rr99mYXHBSKryL1O46X+7r5ie+=2aKmmA@mail.gmail.com>
	<7vlig8s50o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 16:08:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDyTc-0000jB-03
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 16:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933062Ab2IROIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 10:08:15 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:50552 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933105Ab2IROIE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 10:08:04 -0400
Received: by wibhi8 with SMTP id hi8so4234307wib.1
        for <git@vger.kernel.org>; Tue, 18 Sep 2012 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PGTqwMe2IWXCFeKcb+meKh9qLqQZN/VJ8wZb4q5gZwE=;
        b=BVtKbWNbeHmXD8+DyOHd3SVEGQRvgxqtFrCGhwELrQSzOHk2gM7EWu3617vgbCulk7
         t47ObDgJfV132YscozdsYzFeeY8Fgq98xf20xu5AR4XWcNsRXtOeHPfmkgFUEuM+wDrP
         CyAYGT3Z90CE5r404vQQbFmYP0uSZgbtufxJ+9hjR26j5sudZzhvcaZF70R0Vm8q1Z+k
         tLcC5SJkPoqgjO9UZhuRaInRd2K62ETj09k5TI62LEYArA/5TZH7V7dDv1m+Pyjnoy3E
         FobkzURv+0xsf553DF4Diz0YL3STlGkofgxhVDfYa5PkUVC3kNZF50LYhzmfuhW6KvpD
         vRYA==
Received: by 10.180.91.1 with SMTP id ca1mr33592wib.8.1347977283718; Tue, 18
 Sep 2012 07:08:03 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Tue, 18 Sep 2012 07:08:03 -0700 (PDT)
In-Reply-To: <7vlig8s50o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205831>

On Mon, Sep 17, 2012 at 11:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>>>> - install correct refspec if the value of --branch is a tag (test added)
>>>
>>> What is the definition of "correct"?  I see the documentation says
>>> "--branch can also take tags and treat them like detached HEAD", and
>>> even though I _think_ allowing tags was a huge mistake, if we claim
>>> we treat it like detached HEAD, we should do the same when coming up
>>> with the refspec used for the follow-up "fetch".
>>>
>>
>> This patch would install the refspec "+refs/tags/v1.7.10:refs/tags/v1.7.10",
>> so we would do the same with the follow-up "fetch", not?
>> This can be seen as "it's not a bug, it's a feature". Why not cloning a
>> tag of a repo if someone just want to build a tag without having anything else.
>
> Even though I did say I thought allowing tags was a huge mistake, I
> was not suggesting to break existing users by making such a clone
> into an error.
>
> But the main point of the discussion is what should happen upon the
> next "git fetch" in the repository, no?  Shouldn't the refspec be
> the same as the case where you "clone --single" a repository whose
> HEAD is detached at v1.7.10 in that example, instead of saying
> "fetch the same tag over and over"?  After all that is the way I
> expect that most people would read "treat them line detached HEAD"
> in the documentation.  Subsequent "git fetch" would fetch from the
> HEAD of the upstream just like a clone from a repository with a
> detached HEAD.
>

IMO if a user uses "clone --single-branch --branch <tag>", then he/she
wants to have this tag only. Why should the next "git fetch" fetching
something different?
I read "treat them like detached HEAD" in the way that the resulting
repo is in a "detached HEAD" state.

> The above is *not* a rhetorical question; I just do not think of a
> sensible reason why we want a refspec that says "keep updating the
> v1.7.10 tag, as it might change on the other end, and do not bother
> what other things that happen in that upstream repository".  What
> sensible workflow would benefit from such a refspec?
>
>

When using a tag in a different meaning than "tag this version and
do never change it", for example if someone uses a tag to describe
which revision of the project was lastly delivered to the customer, then
they could use a tag "delivered". After a new version was delivered,
someone changes this tag from "revx" to "revy". Having such a refspec,
you can fetch this tag and always get the delivered version.
This example is very theoretically.
