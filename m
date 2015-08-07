From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v9 02/11] ref-filter: introduce ref_formatting_state
Date: Fri, 7 Aug 2015 23:20:30 +0530
Message-ID: <CAOLa=ZTi0BfP1kkK+Ty49Z7kYoh8k0TjrfCfpapBWAot1kMVoQ@mail.gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
 <1438692188-14367-1-git-send-email-Karthik.188@gmail.com> <1438692188-14367-2-git-send-email-Karthik.188@gmail.com>
 <CAPig+cQftyjKFi0Qkg_ZVEJ9A+zGSAmFtHwQ-8hCnf8xtU_PEA@mail.gmail.com>
 <CAOLa=ZSp3aL0Z5YP5xmzdW7H92yU3EA+MJjLYA29QyoZTD5RiA@mail.gmail.com>
 <CAPig+cTt__tphEqFuyeOiTadOL9cAi51RLd3z6rr3nM-8Qp6Aw@mail.gmail.com>
 <CAOLa=ZSRFcfQqjphdSYkWDry8QibKL78Ev=XnfPRxc3PJ17Dog@mail.gmail.com> <CAPig+cSHfQ+Dan1Ps_C0hnCxAz0ZXRu9-gOtDWp9auLvkobEWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 19:51:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNlnS-0006nS-KX
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 19:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945904AbbHGRvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 13:51:03 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36817 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473AbbHGRvB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 13:51:01 -0400
Received: by obnw1 with SMTP id w1so84180620obn.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 10:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3tAsHQNsf3NbpaFwUj0ubSsE54WF8bB3BVbeVCiTDa4=;
        b=JRR1IdMRE5Ob7bcfD8KdWZvWl2DvIkYiD3ooSBy6yii6d/dO6jJO+BCG+fRM5qZ85K
         PJD+GExd/vStxfCgz7sox/i8KoyrK9sazDVaHNJNibtGBTgG8aSXgp75Lt9PQpaUpPYs
         4kQFGsvjGz5VLqOUYoeVvngeq4nBu+9Dr/ItilLlPcWrksu/JhqIsOy5gSyve8QsYgw8
         rWagwCkYO7ejmj3AFAeCfl8QbybyQHp1jHvnjrzXRh5z2SW1WTJYydZE4VFRn6BlWlcQ
         gjRqMgVSDdJ/GM+MH6cMJY2R/cf5f8LYzMb8IhxqLVd+4bcCM8K0Oi7oJrD8AwGtHY42
         18dA==
X-Received: by 10.182.153.161 with SMTP id vh1mr7888258obb.34.1438969859904;
 Fri, 07 Aug 2015 10:50:59 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 7 Aug 2015 10:50:30 -0700 (PDT)
In-Reply-To: <CAPig+cSHfQ+Dan1Ps_C0hnCxAz0ZXRu9-gOtDWp9auLvkobEWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275478>

On Fri, Aug 7, 2015 at 11:00 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Aug 7, 2015 at 7:37 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Fri, Aug 7, 2015 at 10:13 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Thu, Aug 6, 2015 at 11:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> On Fri, Aug 7, 2015 at 5:49 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>>> It feels strange to assign a local variable reference to state.output,
>>>>> and there's no obvious reason why you should need to do so. I would
>>>>> have instead expected ref_format_state to be declared as:
>>>>>
>>>>>     struct ref_formatting_state {
>>>>>        int quote_style;
>>>>>        struct strbuf output;
>>>>>     };
>>>>>
>>>>> and initialized as so:
>>>>>
>>>>>     memset(&state, 0, sizeof(state));
>>>>>     state.quote_style = quote_style;
>>>>>     strbuf_init(&state.output, 0);
>>>>>
>>>>> (In fact, the memset() isn't even necessary here since you're
>>>>> initializing all fields explicitly, though perhaps you want the
>>>>> memset() because a future patch adds more fields which are not
>>>>> initialized explicitly?)
>>>>
>>>> Yea the memset is needed for bit fields evnetually added in the future.
>>>
>>> Perhaps move the memset() to the first patch which actually requires
>>> it, where it won't be (effectively) dead code, as it becomes here once
>>> you make the above change.
>>
>> But why would I need it there, we need to only memset() the ref_formatting_state
>> which is introduced here. Also here it helps in setting the strbuf
>> within ref_formatting_state to {0, 0, 0}.
>
> If you declare ref_formatting_state as shown above, and then
> initialize it like so:
>
>     state.quote_style = quote_style;
>     strbuf_init(&state.output, 0);
>
> then (as of this patch) the structure is fully initialized because
> you've initialized each member individually. Adding a memset() above
> those two lines would be do-nothing -- it would be wasted code -- and
> would likely confuse someone reading the code, specifically because
> the code is do-nothing and has no value (in this patch). Making each
> patch understandable is one of your goals when organizing the patch
> series; if a patch confuses a reader (say, by doing unnecessary work),
> then it isn't satisfying that goal.
>
> As for the strbuf member, it's initialized explicitly via
> strbuf_init(), so there's no value in having memset() first initialize
> it to {0, 0, 0}. Again, that's wasted code.

Yes, what you're saying is true, if we replace memset() with

state.quote_style = quote_style;
strbuf_init(&state.output, 0);

That does replace the need for memset and make the patch
more self-explanatory.

>
> In a later patch, when you add another ref_formatting_state member or
> two, then you will need to initialize those members too. That
> initialization may be in the form of explicit assignment to each
> member, or it may be the memset() sledgehammer approach, but the
> initialization for those members should be added in the patch which
> introduces them.
>
> It's true that the end result is the same. By the end of the series,
> you'll have memset() above the 'state.quote' and 'state.output'
> initialization lines to ensure that your various boolean fields and
> whatnot are initialized to zero, but each patch should be
> self-contained and make sense on its own, doing just the work that it
> needs to do, and not doing unrelated work. For this patch, the
> memset() is unrelated work. For the later patch in which you add more
> fields to ref_formatting_state(), the memset() is work necessary to
> satisfy that patch's objective, thus belongs there.

I understand what you're saying, it makes sense to have individual patches
only bring in changes related to the patch. This makes a lot of sense.

I will change it up. Thanks :)

-- 
Regards,
Karthik Nayak
