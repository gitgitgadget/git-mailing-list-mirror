From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Wed, 28 Sep 2011 04:37:01 +0000
Message-ID: <CAMOZ1Bv3b-EkvCrRYw=_s9SXQw+v9wgQbGab7hsz+Wx+tndhJw@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com> <4E81F080.7010905@drmicha.warpmail.net>
 <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
 <7v39fhyk21.fsf@alter.siamese.dyndns.org> <CAG+J_DxzcuYiffm6XVX-RQSxeMwy4Yi7CdhCdddAN=xRyJ2b5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 06:37:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8ltp-0001B5-FB
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 06:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab1I1Ehc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Sep 2011 00:37:32 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47234 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab1I1Ehb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 00:37:31 -0400
Received: by qyk7 with SMTP id 7so8739752qyk.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 21:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aOR9HpbcCyglBrK9L74x0ah+KRM8GxZGIu2bU0zjXNE=;
        b=WWCIKxEYicJJP0W2ylflIMR1SfTESfviBI4U+87nzHU7Ukie0lgXLG2CEuYIh2n9f3
         c/PBtOu0E/hvX+/QTFZIvFeK14u9m5xhsEgWZoxj7rpHxmJKzfyd0etJ9594saRzMD14
         OWG9fwZ3O1bUaP7ZYgRCm/4jkIf9VplnmEedI=
Received: by 10.229.40.75 with SMTP id j11mr6201494qce.203.1317184651066; Tue,
 27 Sep 2011 21:37:31 -0700 (PDT)
Received: by 10.229.233.6 with HTTP; Tue, 27 Sep 2011 21:37:01 -0700 (PDT)
In-Reply-To: <CAG+J_DxzcuYiffm6XVX-RQSxeMwy4Yi7CdhCdddAN=xRyJ2b5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182293>

On Wed, Sep 28, 2011 at 04:04, Jay Soffian <jaysoffian@gmail.com> wrote=
:
> On Tue, Sep 27, 2011 at 1:25 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Michael Witten <mfwitten@gmail.com> writes:
>>
>>> It seems like a more logical approach would be instead for "git
>>> commit" to take a "--root" option that would create a new root comm=
it
>>> based on the current index and then point the current branch head t=
o
>>> the new root commit. Thus:
>>>
>>> =C2=A0 $ git checkout -b new_branch old_branch
>>> =C2=A0 $ # Manipulate or not
>>> =C2=A0 $ git commit --root
>>>
>>> That's how people think.
>>
>> This may indeed be an improvement. I suspect that we'd need to think=
 about
>> it a bit more, but it feels right (perhaps introduce this new option=
,
>> deprecate --orphan from the checkout, and then eventually remove it
>> sometime in 1.8.0 timeframe).
>
> Hrm, create new_branch just so you can immediately clobber its SHA1
> with the new commit that has no parents. That doesn't seem quite
> right.

The point is that users think about 2 things:

  * I need to create a root commit.
  * I need a branch head to point to that root commit,
    and I probably want a new branch head to do that.

My goal is to match the way people think; nobody thinks about the SHA1
when doing this task, and everybody thinks about creating a new branch
head.

More to the point, how is it better that "checkout --orphan" sets up
the working tree and index when the user is just going to obliterate
them or alter them significantly?

> Imagine you use "git commit --root" by accident while on
> master, then you have to dig into your reflog?

What's wrong with, say, "git reset --hard ORIG_HEAD"? (note that
ORIG_HEAD is already something understood by git).

> But it's close. Maybe:
>
> $ git commit --new-root-branch=3D<name>
>
> Which creates <name> with the index as its sole commit and switches
> you to that branch? That doesn't feel quite right either.

The "git commit" command shouldn't be canoodling the branch layer so in=
timately.

In fact, that's why I dislike:

  git checkout --orphan <branch_head>

The "--orphan" flag was no doubt added to "git checkout" because of
there already existed:

  git checkout -b <branch_head>

However, that is only available as a convenience (that is, a hack) for:

  git branch <branch_head>
  git checkout <branch_head>

It seems to be an even larger hack that "git checkout" as been given
so much control over setting the stage for not only the creation of a
branch head, but also the nature of the ancestry of the *next* commit.
