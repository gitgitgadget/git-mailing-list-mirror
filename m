From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 5 Oct 2011 21:38:42 -0400
Message-ID: <CAG+J_Dz++SG28a=DhZ+Doz1np21jMavYpc0hKfe1rgq-dHZLPA@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
	<CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
	<CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
	<7vpqib8jzk.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
	<7vzkhf713u.fsf@alter.siamese.dyndns.org>
	<CACsJy8BHeZZqsOP_+OSPfrPdkYgKQe3LgaGfo3bERD+hWT7U0g@mail.gmail.com>
	<7vaa9f59p5.fsf@alter.siamese.dyndns.org>
	<CACsJy8D5FGr3R0tLYOND0kKNct4e_KgYfLUK8xL2Q4uNzWczgQ@mail.gmail.com>
	<7vwrcj3sow.fsf@alter.siamese.dyndns.org>
	<CAG+J_DzZrFx2v09zNxKm2xyA82MyKRTq3AEus3QthtpZYhQn0A@mail.gmail.com>
	<7vsjn73q6j.fsf@alter.siamese.dyndns.org>
	<CAG+J_DxXcvF3tBPkf7ZEtiXvEK80zYJvP1rNx-PagM8TV-1KSA@mail.gmail.com>
	<7v62k253ad.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 03:38:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBcvA-0006XF-8L
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 03:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab1JFBin convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 21:38:43 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57373 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab1JFBin convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 21:38:43 -0400
Received: by ywb5 with SMTP id 5so2160272ywb.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 18:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=H837HRS00bk1RpY/rG23Hs3cww9FpOxhP/y6XGmxtx4=;
        b=sPkLFhaQFuVzj/SiXgCu2snnGJPUMkneagDGLvn7skyh8Ko5sgaQ3t/7nVB766OQok
         qC0cIfbYFxOZX8vZKACLxoniOrIM0uYZu66Bt4AKeBgb1Z/a+QJVinbwk2fMuyQm06YE
         d4Na9QHLCmi07zA9Vg3TPmsAWteV5BS1bEbN0=
Received: by 10.236.76.102 with SMTP id a66mr617638yhe.25.1317865122485; Wed,
 05 Oct 2011 18:38:42 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 18:38:42 -0700 (PDT)
In-Reply-To: <7v62k253ad.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182915>

On Wed, Oct 5, 2011 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> So you're envisioning this?
>>
>> =C2=A0 $ git commit foo.c
>> =C2=A0 Warning, master is also checked out in workdir2
>
> No. I would rather think it needs to be forced.

Now they do what? Either commit --force or create a new branch?
Wouldn't it have been better to create the new branch before they
started editing?

Here's what I'm trying to avoid:

  $ cd workdir2
  $ git checkout master
  $ edit foo.c
  $ git commit foo.c
  By default, committing to a branch that is checked out in more than
  one location is denied, because it will make the index and work tree
  inconsistent in the other locations and will require 'git reset --har=
d'
  to match the work tree to HEAD in each of those other locations.

  Either switch to a new branch first with 'git checkout -b <new_branch=
>'
  or use 'git commit --force' to override this message.

User: "crap, I wanted that on master". Now they do what. Something like=
:

  $ git checkout -b foo
  $ git commit foo.c
  $ cd workdir1
  $ git cherry-pick foo
  $ git branch -d foo

Or maybe they use stash instead. In either case, I just think that's a
terrible user experience compared to:

 $ cd workdir2
 $ git checkout master
 error: master already checked out in workdir1
 $ cd workdir1
 $ edit foo.c
 $ git commit foo.c

I guess it depends what you mostly use your workdirs for. For me, it's
to have different branches checked out, not to have the same branch
checked out in multiple locations. I want git to help me up front, not
when I go to commit.

j.
