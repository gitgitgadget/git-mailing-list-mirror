From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add new @ shortcut for HEAD
Date: Wed, 1 May 2013 17:35:03 -0500
Message-ID: <CAMP44s0OysW1Rnc+Dk1R697zhtV+ubCMfDa+aWizOaHEcLbsJA@mail.gmail.com>
References: <1367401888-21055-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4hq7fjy.fsf@alter.siamese.dyndns.org>
	<CAMP44s16X8c_5GgW=ZcA9wrd=oHAiVDZFWxqiGmysaUJckZ5wQ@mail.gmail.com>
	<7vsj264am4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 02 00:35:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXfcF-0003Bp-Nc
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 00:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758241Ab3EAWfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 18:35:07 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:53864 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757677Ab3EAWfF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 18:35:05 -0400
Received: by mail-la0-f53.google.com with SMTP id eo20so392lab.26
        for <git@vger.kernel.org>; Wed, 01 May 2013 15:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ymlwmNQLUfOMygPyz2T5zGd08nGr8Xkj/SBcP347fPI=;
        b=IXi/tFVmlyYrZfDi8NAM+sBG4QcAR06ZJGrX91P1ybYeGYVaVbjY/rdC7yfVzY5V0Y
         2ZKHBssuIiUscYshdImf8LqKYsgoTeGk3ckEF/oHQLnDfuwQSiPAlg3D/YuqoEVOitgl
         gc1uU2m2XHwTLvvZoWQ7gG67UxsIzENrzXe47tQ26ZtnJdWUqF823IltP8m+BRkgW2C/
         aRD8+pR2a3S360zyUOAep1gQ2jffmTQkpHFGhbyUtd1dZtQs9Qop9suue9SkNloYHoXQ
         d/ag9QIjtmbdn+xRlwupEmBspuc4DhpgjX/KbtwCNnh4ZkDC/mltu4jVgin/zFTalZQq
         F19w==
X-Received: by 10.152.3.137 with SMTP id c9mr1635957lac.5.1367447703669; Wed,
 01 May 2013 15:35:03 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 15:35:03 -0700 (PDT)
In-Reply-To: <7vsj264am4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223159>

On Wed, May 1, 2013 at 5:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, May 1, 2013 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
>>>> remove '~0', and we can remove 'HEAD', which leaves us with @{0}, but we
>>>> can't remove '{0}'?
>>>>
>>>> This patch allows '@' to be the same as 'HEAD'.
>>>
>>> While the above reasoning is cute, it is misleading.
>>>
>>> If you start from HEAD@{1}~0^0, we can remove '^0', we can remove
>>> '~0', but you cannot remove HEAD from the remaining "HEAD@{1}"
>>> without changing what it means.  @{1} is where the current branch
>>> was, while HEAD@{1} is where you were---they are different when you
>>> have just did "git checkout anotherbranch".  HEAD@{1} is the tip of
>>> your previous branch, @{1} is where anotherbranch was before its tip
>>> became the commit you have checked out.
>>
>> Replace @{1} with @{u} and it holds.
>
> Yes and no.  Starting from HEAD@{u}~0^0, we can remove ^0 and ~0,
> and you remove HEAD from the remaining "HEAD@{u}" to get @{u} and
> all of them still mean the same thing.  It is the other branch your
> current branch is integrating with.
>
> But that decomposition does not get you to HEAD which is the final
> destination you want to reach.  As soon as you drop the remaining
> {u}, it suddenly changes the meaning and start referring to the
> current branch.

Yeah, @something has different meaning depending on what that
'something' is. We could add @{this-branch} to mean this is basically
a no-op, and then we can do the HEAD@{this-branch}~0^0 reduction
straight-forwardly, but I think it's overkill to add a new idiom only
to prove a point.

At the end of the day the important thing is that @ is the same as
@something, except without the 'something' in there. That's why the
shortcut is @, and not '.', or '+', or '&', or any number of other
single characters we could have chosen.

>>> So I'd suggest toning it down, perhaps something like this:
>>>
>>>         Even though we often can do without having to type "HEAD",
>>>         e.g. "git log origin.." substitutes missing RHS with "HEAD",
>>>         sometimes we still do need to type "HEAD" (thats six f*cking
>>>         keystrokes "Caps Lock", "H", "E", "A", "D" and finally "Caps
>>>         Lock").
>>
>> I don't know what RHS means, and I don't use caps lock :)
>
> "right hand side"?  You can say "Hold down Shift", H, E, A, D and
> "Release Shift" ;-).

Yeah, but the point is that different people have different ways of
doing it. Even if it was 'head' it would be a burden.

>>>         That is four keystrokes too many to name an often needed
>>>         reference.  Make "@" usable as its synonym.
>>
>> Yeah, that's nice, but doesn't explain why "@", and why not something else.
>
> The thing is, HEAD@{0}~0^0 nor HEAD@{u}~0^0 is not a valid
> explanation why it is "@", either.

Let's pick '+' then. Or something else.

> But that does _not_ mean "@" is a good choice.  Nor the explanation
> has to be based on the "starting from this and strip" progression.
>
> "@" is already special and is familiar to users when specifying a
> ref, and that is a good enough reason (you can of course say that in
> the log message).

Exactly, because ref@something is used for operations on a ref. If
'ref' is missing, it only makes sense to use HEAD (or something like
that), and if 'something' is missing, it only makes sense to make it a
no-op, but since we don't want to forbid refs with names like
'master@'. That's the reason why '@' makes sense, and not any other
character.

Cheers.

-- 
Felipe Contreras
