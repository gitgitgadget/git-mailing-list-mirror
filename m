From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Wed, 20 Aug 2014 09:28:28 -0700
Message-ID: <CAL=YDW=zmqwjLzjWYLGCjwb_aQTofTJ-CrmPgoq3KKJjfHR3XQ@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-44-git-send-email-sahlberg@google.com>
	<53BC07FC.8080601@alum.mit.edu>
	<20140715180424.GJ12427@google.com>
	<CAL=YDWkYAg-0h3ZwiyZGtUHFEv1KEti_uURTwgbZE9xT_P_XSQ@mail.gmail.com>
	<CAL=YDWmc2gkw=8YavWHyLUAD4du7saPrKzPKT+dsCfdZJz1EiA@mail.gmail.com>
	<53F4B642.7020002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 20 18:28:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK8kV-0001JU-NJ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 18:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbaHTQ2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 12:28:31 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:58435 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbaHTQ2a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 12:28:30 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so9401979vcb.15
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=d/0kp8/ep8gYNgdz5LBE79kQ8M8ECL7o8zVnE8M2Kmk=;
        b=SS0D46TkvbGMR7gIYSs1av/NB+MeVaGGU69yhsZdQc1m47UWFbM1OIpFf0+ryUtwy2
         o+Ykt0pVm2iz5eVICMtj/+E/bsRRWKI95A2LFzpHlbUkfi0Qk/aMjGclrzOcOcaH8lyl
         WD+94jUs2jwMbdRH1SDu19+RPRtMTt7BIwgkRKf8UQw6PQCowpfFHuqrhX+SFqDnRiN0
         D3TLCEMfXdJCUX49GIOPs9eLsd7y+cm8oSSvBN6GkCc/ckIUtHns0yh3Tp55qrDrynj5
         8BJLvAJfFZPYvCZaIGS4cLAlNFqeq8t+hBUPiDTak3pbOqRZ7PIcFAjVl85ypzVQZXM5
         H/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=d/0kp8/ep8gYNgdz5LBE79kQ8M8ECL7o8zVnE8M2Kmk=;
        b=Ww1qzAEFMtJ6bakUWVe6ItPT2z16/Ke0RtfSupkVOnSS/AHfNpwptvLJiB40Uef+1y
         GK/bbSwM411Q0c3xehz14we7y43ImNFNEh1OzsNncrYJilheD1aat3T8EU4U+sEDbmMZ
         os4sYJucAvL9+Jrz7fwxrZN1KWhsM+jv7DfVu2k/cazSrh39B75QwT9X+euIGtGZuPnW
         mSeokQfoIvlC2VOT0qUyvA19MnATOaENmoPGQqInn3HNES+AhN3rMOVgc+byK8kKH+LS
         Mr3nOZt1c1DbBcjyS/eKNACHBRGxkEIjbVVHJPuHyoJ4lb7rqj3JGSZ+ukMXgmxCGCrL
         ULMA==
X-Gm-Message-State: ALoCoQkfAaPTUZGwYqXao+f7zgZMfnyNO7/RcKKbeBo1BVH3MqeDNzgZw27D1sMhe1hvWepiIfQf
X-Received: by 10.220.97.5 with SMTP id j5mr37503663vcn.16.1408552108321; Wed,
 20 Aug 2014 09:28:28 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Wed, 20 Aug 2014 09:28:28 -0700 (PDT)
In-Reply-To: <53F4B642.7020002@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255572>

On Wed, Aug 20, 2014 at 7:52 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 07/15/2014 10:58 PM, Ronnie Sahlberg wrote:
>> On Tue, Jul 15, 2014 at 12:34 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>>> On Tue, Jul 15, 2014 at 11:04 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>>> Michael Haggerty wrote:
>>>>
>>>>> So...I like the idea of enforcing refname checks at the lowest level
>>>>> possible, but I think that the change you propose is too abrupt.  I
>>>>> think it needs either more careful analysis showing that it won't hurt
>>>>> anybody, or some kind of tooling or non-strict mode that people can use
>>>>> to fix their repositories.
>>>>
>>>> The recovery code has been broken for a while, so I don't see harm
>>>> in this change.
>>>>
>>>> How to take care of the recovery use case is another question.  FWIW I
>>>> also would prefer if "git update-ref -d" or "git branch -D" could be
>>>> used to delete corrupt refs instead of having to use fsck (since a
>>>> fsck run can take a while), but that's a question for a later series.
>>>>
>>>> In an ideal world, the low-level functions would allow *reading* and
>>>> *deleting* poorly named refs (even without any special flag) but not
>>>> creating them.  Is that doable?
>>>
>>> That should be doable. Ill add these repairs as 3-4 new patches at the
>>> end of the current patch series.
>>>
>>>> The main complication I can see is
>>>> iteration: would iteration skip poorly named refs and warn, or would
>>>> something more complicated be needed?
>
> I think we can get away with not including broken refnames when
> iterating.  After all, the main goal of tolerating them is to let them
> be deleted, right?  Then as long as iteration is not needed to implement
> the command "git update-ref -d", it seems to me that it is OK if
> iterating over a reference with a broken name causes a die().
>
>>> Right now,  "git branch"  will error and abort right away when it
>>> finds the first bad ref. I haven't checked the exact spot it does this
>>> yet but I suspect it is when building the ref-cache.
>>> I will solve the cases for create and delete for now.
>>>
>>>
>>> What/how to handle iterables will require more thought.
>>> Right now, since these refs will be filtered out and never end up in
>>> ref-cache, either from loose refs or from packed refs
>>> it does mean that anyone that uses an iterator is guaranteed to only
>>> get refs with valid names passed back to them.
>>> We would need to audit all code that uses iterators and make sure it
>>> can handle the case where the callback is suddenly
>>> invoked with a bad refname.
>>>
>>>>
>>>> Thanks,
>>>> Jonathan
>>
>> The following seems to do the trick to allow deleting a bad ref. We
>> would need something for the iterator too.
>> Since this touches the same areas that my ~100 other ref transaction
>> patches that are queued up do, I
>> would like to wait applying this patch until once the next few series
>> are finished and merged.
>> (to avoid having to do a lot of rebases and fix legio of merge
>> conflicts that this would introduce in my branches).
>>
>>
>> Treat this as an approximation on what the fix to repair git branch -D
>> will look like once the time comes.
>
> I'm a little worried that abandoning *all* refname checks could open us
> up to somehow trying to delete a "reference" with a name like
> "../../../../etc/passwd".  Either such names have to be prohibited
> somehow, or we have to be very sure that they can only come from trusted
> sources.
>

I only set this flag from builtin/branch.c so it should only be used
when a user runs 'git branch -D' from the command line.
All other places where we delete branches we should still be checking
the rename for badness.

That said, unless the "rules for good refname" changes in the future,
which is unlikely, is should be exceptionally rare that a user ends up
with a bad refname in the first place.
Perhaps my example I gave was bad since if you manually create bad
refs using echo > .git/refs/heads/...  then you should probably know
how to fix it too and thus maybe we do not need this patch in the
first place.

Do you want me to delete this patch and resend this part of the series
? Or is the 'only works for branch -D from the commandline' sufficient
?
I have no strong feelings either way so I will just follow what you decide.


regards
ronnie sahlberg
