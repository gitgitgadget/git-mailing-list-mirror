From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 01/10] ref-filter: introduce a parsing function for
 each atom in valid_atom
Date: Thu, 26 Nov 2015 23:31:24 +0530
Message-ID: <CAOLa=ZTHaety8=cxP4PqcXqrRv9OAEAcRyTs9drY6nSFGKvyOQ@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <1447271075-15364-2-git-send-email-Karthik.188@gmail.com> <CAPig+cRYEmbsye78ESOLfmSi56sBFeKpaEkpGSEwF=qrLZWx8g@mail.gmail.com>
 <CAOLa=ZTFeKMMSRCTWi9RkSvuCh7ZecPudSgsJB4TV76U4aGJJA@mail.gmail.com> <CAPig+cRcxr7uT2OJX=TnaVf+gXQdw9ydp+7X+Kis4Vb5+6RHiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 19:02:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a20rr-00037I-W4
	for gcvg-git-2@plane.gmane.org; Thu, 26 Nov 2015 19:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbbKZSB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2015 13:01:56 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36459 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbbKZSBy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2015 13:01:54 -0500
Received: by vkay187 with SMTP id y187so57016578vka.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2015 10:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vx+xNX1Akusp9LCjkzT5z2pwlz+zU0QQ0J7emmND6k8=;
        b=hopm7uUlGBxrcotf1K4OjWO1v1cghCcuhy++5XRPQbMatQsFtT6IA8MwXqZb7CoM/+
         UeOvxuR15cLCTOEF+iKWltS+MG8o6EvS6KAhqqZxakdpVgTDi4vf/yYDpbm1KCKqY3ry
         pNs9+86TkTcnmLHMXvfkxCraXcxHJ/ibyAHWfYaC9vEBO+h0bz9qXXkptN6pUAXIhff1
         uXjww3Bfpy9iQoRfatymANsUobVZ2+SCMFzD9xRGe6FB+WhypM1HUJYCp2l2gCMAosCd
         YY6FcnR0N2EzH+f8eRky2DEKBzaI7iYSGSIrKdTzIyO/9XCCJpO/mQU29eUviPac+RZ9
         SHQg==
X-Received: by 10.31.8.8 with SMTP id 8mr37710627vki.106.1448560913838; Thu,
 26 Nov 2015 10:01:53 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Thu, 26 Nov 2015 10:01:24 -0800 (PST)
In-Reply-To: <CAPig+cRcxr7uT2OJX=TnaVf+gXQdw9ydp+7X+Kis4Vb5+6RHiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281764>

On Thu, Nov 26, 2015 at 1:11 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Nov 25, 2015 at 7:10 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Tue, Nov 24, 2015 at 5:14 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> Introduce a parsing function for each atom in valid_atom. Using this
>>>> we can define special parsing functions for each of the atoms. Since
>>>> we have a third field in valid_atom structure, we now fill out missing
>>>> cmp_type values.
>>>
>>> I don't get it. Why do you need to "fill out missing cmp_type values"
>>> considering that you're never assigning the third field in this patch?
>>> Are you planning on filling in the third field in a future patch?
>>
>> I plan on filling that in upcoming patches. Probably, should mention that in
>> the commit message.
>
> Making it clear that this patch is preparatory for introduction of
> 'valid_atom' is a good idea, however, adding the unused 'valid_atom'
> field in this patch is not recommended. It would be better to
> introduce 'valid_atom' in the patch which actually needs it.
>

I get your point, will do as you suggested.

>>>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>>>> ---
>>>> diff --git a/ref-filter.c b/ref-filter.c
>>>> @@ -19,42 +19,43 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>>>>  static struct {
>>>>         const char *name;
>>>>         cmp_type cmp_type;
>>>> +       void (*parser)(struct used_atom *atom);
>>>
>>> Compiler diagnostic:
>>>
>>>     warning: declaration of 'struct used_atom' will not be
>>>         visible outside of this function [-Wvisibility]
>>>
>>> Indeed, it seems rather odd to introduce the new field in this patch
>>> but never actually do anything with it. It's difficult to understand
>>> the intention.
>>
>> This is to make way for upcoming patches. But the compiler error is
>> accurate used_atom only becomes a structure in the next patch.
>> Should change that.
>
> This problem will go away if you introduce the 'valid_atom' field in
> the patch which actually needs it (as suggested above) rather than in
> this patch.

Yup, agreed.
Thanks for your suggestions.

-- 
Regards,
Karthik Nayak
