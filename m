From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Thu, 6 Oct 2011 00:02:03 -0400
Message-ID: <CAG+J_DwEx9y-5B+ZppW1jURCYE2f-rkniYnRFjEtd4+spPurQA@mail.gmail.com>
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
	<CAG+J_Dz++SG28a=DhZ+Doz1np21jMavYpc0hKfe1rgq-dHZLPA@mail.gmail.com>
	<7v1uuq51c3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 06:02:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBf9w-0006pH-HA
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 06:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174Ab1JFECG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 00:02:06 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33886 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab1JFECF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 00:02:05 -0400
Received: by ggnv2 with SMTP id v2so1356298ggn.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 21:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qkXhARtmH5p6Ttxd+alXlUhNaZcabJBc4Jk+2P+6/TU=;
        b=Qba9L2xVSxAqrer1ltXM05RDOFk5l02YewD6fman1ngB8dTkWJp8kitMGg7CNzxAd6
         YFLVVK7DU41rREW/BnCY1VDUTQxb9aRySEqTG8x48acaWKCyU4reTEBrCJqvrfJ6Jzba
         zwm+wq0STF/gWrKBNjES3tvklPJOxAkxGq3sY=
Received: by 10.236.76.102 with SMTP id a66mr1034093yhe.25.1317873723835; Wed,
 05 Oct 2011 21:02:03 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 21:02:03 -0700 (PDT)
In-Reply-To: <7v1uuq51c3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182926>

On Wed, Oct 5, 2011 at 9:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>> Now they do what? Either commit --force or create a new branch?
>> Wouldn't it have been better to create the new branch before they
>> started editing?
>
> If they are going to commit, and if they knew that they are going to
> commit, yes.

Committing is obviously the common case for a checked-out branch.

> But why do you want to forbid people from just checking things out if they
> are not interested in committing? That is where I think you are going
> backwards.

Because if they do decide to commit, it's now harder for them to do so.

It would be great if git could intervene after the checkout, but
before they edit any files, so that they don't have uncommitted work.
Obviously that's not possible, so git should prevent them from getting
to that point.

Let's consider the various situations:

1. master is checked out w/edits in workdir1, user wants to work on
topic in workdir2.

There's nothing to warn about in workdir2 neither at checkout nor commit time.

2. master is checked out w/edits in workdir1, user wants examine
unedited master in workdir2

At checkout time in workdir2:

My preference: checkout advices user to use --detach or --force.
Your preference: checkout is silent.

Now user decides they want to commit to master in workdir2 (which is
insane, they've got uncommitted changes to it in workdir1). What
happens?

In my scenario, the commit happens on a detached HEAD. When they
eventually switch back to a branch, git tells them how to move their
commit to a branch.

In your scenario, commit complains. User now has to --force, stash, or
create a new branch.

It's just seems insane to me putting in obstacles to the user
committing their work. That's where I think you are going backwards.

You have a use case where using a detached HEAD doesn't work because
you've scripted around the same branch multiply checked out. I think
that's probably an exceedingly rare use case, and justifies "checkout
--force".

>> I guess it depends what you mostly use your workdirs for. For me, it's
>> to have different branches checked out, not to have the same branch
>> checked out in multiple locations.
>
> Then you wouldn't have any problem if commit refused to make commit on the
> branch that is checked out elsewhere, no?

Yes, I would, because by that point, I've already made the mistake of
checking out the same branch twice. I want git to prevent me from
doing that by accident. Because I don't want to ever be in the
situation which comes next, which is that I've got uncommitted work
for the same branch in two places!

> I am not saying we should never have an option to _warn_ checking out the
> same branch in multiple places. I am saying it is wrong to forbid doing so
> by default.

I am not saying we should never have an option to allow checking out
the same branch in multiple places. I am saying it is wrong to allow
doing so by default.

j.
