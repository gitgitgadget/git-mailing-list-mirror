From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in
 pack directory
Date: Tue, 3 Nov 2015 21:12:38 -0600
Message-ID: <CAEtYS8Q1T-ig2KqZUoCCODs1YbjOmF__vbiH5rL-s6hNaUhZeA@mail.gmail.com>
References: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
	<1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
	<CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
	<xmqq37zhg8la.fsf@gitster.dls.corp.google.com>
	<xmqqbnbilw9u.fsf@gitster.mtv.corp.google.com>
	<CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 04:13:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtoVb-0000Vb-28
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 04:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbbKDDMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 22:12:39 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35319 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbbKDDMj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 22:12:39 -0500
Received: by igpw7 with SMTP id w7so95440729igp.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 19:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=32NweXrV8TO/gad+S1JUqdg9Kj8RpfwoCAheA2BYsF8=;
        b=vy9lYdil3iFApqbLRdL3zJSzPblzEMoOuzlOqV0u54yRRd+0gwIon7lARs6akavLhX
         f7eR21rueT8kmpKfH9mvbVfWwLnK3cM0uVxwsTxyUbaLJqp0PnZEm+r4vk+K56Cu3gDZ
         69LFBIl1MDaU3K0VNZggwUj67YNkK5+eetNL5rFJiDxnuuzdEalhlhmvkKTeiB7GX25i
         6yu8s0yd64QwixZSJbbJbYurC6tLoM4pzQD9jmvtHAEO19AZienUiJgvTdVGWJVk+lfS
         UvGjDVgV2Zr+9hBEk/JqFGt6On4qZkTwD3utbKebUu4dLvGauSWk9gpymxunfrq/yOaq
         DZjA==
X-Received: by 10.50.30.233 with SMTP id v9mr21610878igh.5.1446606758291; Tue,
 03 Nov 2015 19:12:38 -0800 (PST)
Received: by 10.79.38.129 with HTTP; Tue, 3 Nov 2015 19:12:38 -0800 (PST)
In-Reply-To: <CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280847>

On Wed, Oct 28, 2015 at 5:43 PM, Doug Kelly <dougk.ff7@gmail.com> wrote:
> On Wed, Oct 28, 2015 at 12:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>
>>>>> -static void real_report_garbage(const char *desc, const char *path)
>>>>> +const char *bits_to_msg(unsigned seen_bits)
>>>>
>>>> If you don't expect other callers outside this file, then this should
>>>> be declared 'static'. If you do expect future external callers, then
>>>> this should be declared in a public header file (but renamed to be
>>>> more meaningful).
>>>
>>> I think this can be private to this file.  The sole point of moving
>>> this logic to this file is to make it private, after all ;-)  Thanks
>>> for sharp eyes.
>>>
>>> Together with the need for a description on "why", this probably
>>> deserves a test or two, probably at the end of t5304.
>>>
>>> Thanks.
>>
>> Does somebody want to help tying the final loose ends on this topic?
>> It has been listed in the [Stalled] section for too long, I _think_
>> what it attempts to do is a worthy thing, and it is shame to see the
>> initial implementation and review cycles we have spent so far go to
>> waste.
>>
>> If I find nothing else to do before any taker appears, I could
>> volunteer myself, but thought I should ask first.
>>
>> Thanks.
>
> I agree; I've been wanting to get back to it, but had some
> higher-priority things at work for a while, so I've not had time.  I'd
> be happy to get back into it, but if you get to it first, believe me,
> I'm not going to be offended. :)
>
> I'll see if I can't devote a little extra time to it this upcoming
> week, though.  Hopefully it doesn't need too much additional polishing
> to be ready.
>
> P.S. Does a Googler want to tell the Inbox team that the inability to
> send plain-text email is really annoying? :P

I think the patches I sent (a bit prematurely) address the remaining
comments... I did find there was a relevant test in t5304 already, so
I added a new test in the same section (and cleaned up some of the
garbage it wasn't removing before).  I'm not sure if it's poor form to
move tests around like this, but I figured it might be best to keep
them logically grouped.

Let me know if there's anything I can do, and once again, sorry for the delay!
