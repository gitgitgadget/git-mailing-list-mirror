From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/9] ref-filter: add support for %(path) atom
Date: Mon, 5 Oct 2015 00:42:43 +0530
Message-ID: <CAOLa=ZS2oWfjrx12q8nRxbquwFhtydqAFZ5zc4t2rMAk68RLYw@mail.gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
 <1443807546-5985-4-git-send-email-Karthik.188@gmail.com> <vpqwpv49so7.fsf@grenoble-inp.fr>
 <CAOLa=ZSdM34_J+gb_=K4-9fgNsMfseAYxUYGm_ncWZstcW+SYw@mail.gmail.com> <vpqfv1q5xop.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 04 21:13:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zioik-0004dz-Ud
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 21:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbbJDTNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 15:13:14 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34565 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbbJDTNN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 15:13:13 -0400
Received: by vkat63 with SMTP id t63so84982121vka.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QAuB9Bz6cWoULxaJtf+iaEi5QBmU6oJJVpeSrrvTSMM=;
        b=a3tjp5x59CLqqrFxUXRSFDvgWybbQRUdUdRKM3RnrdLaYuM/7mSo2DAdAmNxzu1QCy
         AWjnqhaa89Xi02xlJWsuYL6jMUVVI45sNAFBdkTFqB/V8G99njhMsrS0veZMZmXix0HW
         CL1Kug5fKQCE+oxt8/pYodDzMHydOOUbC4+YeTXMf+IxD294Tt0Zh/aXYjeVmQ5DIqDh
         Yo/mV4p0t6I+149143C2JV6a9mvXRNBT3dTi/Yzzt6OBBSZYBTpHMaI30t7ss6ToCEQa
         pmbmiwNMaUoJohThvSoOaT+DG/1g+QG6Ro4zgLHfxlUdMHV+Lj+2JTG4TevRWJmFT7zp
         wZ7g==
X-Received: by 10.31.162.81 with SMTP id l78mr16466809vke.13.1443985992860;
 Sun, 04 Oct 2015 12:13:12 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sun, 4 Oct 2015 12:12:43 -0700 (PDT)
In-Reply-To: <vpqfv1q5xop.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279024>

On Mon, Oct 5, 2015 at 12:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Is that a derived form of the refname, just like %(refname:short)
> that is 'master' for a ref whose %(refname) is 'refs/heads/master'
> is a derived form of %(refname), and ":short" is what tells the
> formatting machinery what kind of derivation is desired?
>
> If so would %(refname:dir) & %(refname:base) be more in line with
> the overall structure?

This seems way better, I like these names more.

On Sun, Oct 4, 2015 at 11:21 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Sat, Oct 3, 2015 at 3:32 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> This adds %(path) and %(path:short) atoms. The %(path) atom will print
>>>> the path of the given ref, while %(path:short) will only print the
>>>> subdirectory of the given ref.
>>>
>>> What does "path" mean in this context? How is it different from
>>> %(refname)?
>>>
>>> I found the answer below, but I could not guess from the doc and commit
>>> message. Actually, I'm not sure %(path) is the right name. If you want
>>> the "file/directory" analogy, then %(dirname) would be better.
>>>
>>
>> Noted will change.
>
> Note: I don't completely like %(dirname) either. I'm convinced it's
> better than %(path), but there may be a better option.
>

I like Junio's suggestion, stick with that?

>>>> +             } else if (match_atom_name(name, "path", &valp)) {
>>>> +                     const char *sp, *ep;
>>>> +
>>>> +                     if (ref->kind & FILTER_REFS_DETACHED_HEAD)
>>>> +                             continue;
>>>> +
>>>> +                     sp = strchr(ref->refname, '/');
>>>> +                     ep = strchr(++sp, '/');
>>>
>>> This assumes you have two / in the fullrefname. It is normally the case,
>>> but one can also create eg. refs/foo references. AFAIK, in this case sp
>>> will be NULL, and you're then calling strchr(++NULL) which may segfault.
>>
>> Not really,
>
> Oops, indeed, for refs/foo, sp points to / and ep is NULL. It would
> segfault for any ref without a /. Currently, the only such ref is HEAD
> and it is dealt with by the 'if' above, but that still sounds a bit
> fragile to me. Ifever we allow listing refs like FETCH_HEAD, I'm not
> sure we'll remember that and test %(path) on it.
>
> Adding something like
>
> if (!sp)
>         continue;
>
> after the first strchr would make me feel safer.
>

Good point! I'll add that.

>> but you made me think of another possible issue.
>>
>> Assume refs/foo "sp = strchr(ref->refname, '/');" would set sp to point at
>> '/' and ++sp will now point at 'f'.
>>
>> The problem now is refs/foo is supposed to print just "refs" whereas it'll
>> print "refs/foo". and %(dirname:short) is supposed to print "" whereas it'll
>> print "foo". Will look into this :)
>
> I think it's worse than that because ep will be NULL, and then you call
>
>         v->s = xstrndup(sp, ep - sp);
>

Ah yes, weirdly though my test didn't yield a problem.

~ git update-ref refs/foo master
~ git for-each-ref --format="%(refname) %(color:red)%(dirname:short)"
refs/foo foo
~ git for-each-ref --format="%(refname) %(color:red)%(dirname)"
refs/foo refs/foo

-- 
Regards,
Karthik Nayak
