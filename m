From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 07/10] ref-filter: make %(upstream:track) prints
 "[gone]" for invalid upstreams
Date: Sun, 11 Oct 2015 23:16:48 +0530
Message-ID: <CAOLa=ZRvTUpz2Ey9ZLwe_iqVGPaFZGJ2_HiASpn=txAgV57otg@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <1444295885-1657-8-git-send-email-Karthik.188@gmail.com> <vpqa8rtnqzp.fsf@grenoble-inp.fr>
 <CAOLa=ZTvD5cXduPH3G0bGDba_hevLQsuwYsoZFtmfTd2SS4Prw@mail.gmail.com> <vpqa8rp2xku.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 11 19:47:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlKiU-0006sX-U7
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 19:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbbJKRrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 13:47:22 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35041 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbJKRrV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 13:47:21 -0400
Received: by vkha6 with SMTP id a6so18885296vkh.2
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cqF5K3UabcL6u/HGeTAuz0gJ1+VHCiBiEVjJYP7HMyU=;
        b=zU70FBFIogNZ7VAz9GOn7el4tqyPmTes3ErynC2unJDUwUjmkkn588YPykGbu9VG0e
         fe3YDACZA3miifiPLN35yfw/rTIVCYM7dtvkWS0ezs9r+Zb2CYtLax6IuI3W1bUeNnNf
         QWlYgkb9R5Rs/hswNrP/1SjRrbIyVZ2qhG0oau6swqWGDvBc4SW5boxl6lCgdv2hiQZW
         PwiGSfKuWcfKuSq9cDivHv7O0fxKtqeMhxAypK8ifti/syNyIbouOPf005Ad49hlo6oM
         0efigB9U3vxJMBBQmP7mQhwnAJ4LHsqj9PkoVjDA0TF6HgMeT1S/mcGYRGJK8kLj+lhA
         fVFw==
X-Received: by 10.31.173.136 with SMTP id w130mr15835445vke.72.1444585641011;
 Sun, 11 Oct 2015 10:47:21 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sun, 11 Oct 2015 10:46:48 -0700 (PDT)
In-Reply-To: <vpqa8rp2xku.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279346>

On Sun, Oct 11, 2015 at 9:42 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Fri, Oct 9, 2015 at 12:10 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> --- a/ref-filter.c
>>>> +++ b/ref-filter.c
>>>> @@ -1118,8 +1118,10 @@ static void populate_value(struct ref_array_item *ref)
>>>>                               char buf[40];
>>>>
>>>>                               if (stat_tracking_info(branch, &num_ours,
>>>> -                                                    &num_theirs, NULL))
>>>> +                                                    &num_theirs, NULL)) {
>>>> +                                     v->s = "[gone]";
>>>
>>> My remark about translation still holds. The string was previously
>>> translated in "branch" and you are removing this translation (well, not
>>> here, but when 09/10 starts using this code).
>>>
>>
>> I should have mentioned in my cover letter, I didn't really understand
>> what has to be done about this, couldn't find much reference to go
>> about this. What do you suggest?
>
> From the user point of view :
>
> git for-each-ref --format '%(upstream:track)' => Should always be the
> same, because this may be parsed by scripts (plumbing). Should not
> depend on $LANG, and shouldn't change from a version of Git to another.
>

A little blurry on how this works, as in how translation takes place,
probably need to look at some code.

> git branch --format '%(upstream:track)' => Should show what is most
> pleasant to the user (porcelain): translated according to $LANG and
> friends, and may be improved in the future.
>
> I already pointed out a fix where a string was translated in a plumbing
> command. Another example is setup_unpack_trees_porcelain() in
> unpack-trees.c which solves exactly the same problem.
>

You did. I was just too clueless.

> I'll followup with a small series on top of yours to show the way. I did
> not try to polish it since I guess you have local changes on the same
> part of the code. Feel free to squash patches together or to squash them
> with yours. The commit messages are not meant to be final either.
>

Thanks a lot for this. This should help me out. I'll probably squash them along.
Thanks :)

-- 
Regards,
Karthik Nayak
