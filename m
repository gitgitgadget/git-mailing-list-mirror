From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 02/11] ref-filter: introduce ref_formatting_state
Date: Fri, 7 Aug 2015 13:30:48 -0400
Message-ID: <CAPig+cSHfQ+Dan1Ps_C0hnCxAz0ZXRu9-gOtDWp9auLvkobEWg@mail.gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
	<1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
	<1438692188-14367-2-git-send-email-Karthik.188@gmail.com>
	<CAPig+cQftyjKFi0Qkg_ZVEJ9A+zGSAmFtHwQ-8hCnf8xtU_PEA@mail.gmail.com>
	<CAOLa=ZSp3aL0Z5YP5xmzdW7H92yU3EA+MJjLYA29QyoZTD5RiA@mail.gmail.com>
	<CAPig+cTt__tphEqFuyeOiTadOL9cAi51RLd3z6rr3nM-8Qp6Aw@mail.gmail.com>
	<CAOLa=ZSRFcfQqjphdSYkWDry8QibKL78Ev=XnfPRxc3PJ17Dog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 19:30:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNlTp-0007mx-UU
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 19:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbbHGRat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 13:30:49 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34437 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932498AbbHGRat (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 13:30:49 -0400
Received: by ykdt205 with SMTP id t205so13729604ykd.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2d5Tq4bYAO08ZkmJkvf22GGTMdgvd0U58jDt08gRdGA=;
        b=VGOmQ0NsZ7Wy2n9urR6CAye6xCtOeOWyysf2DZi3cpTyzcoWcfBZCjVsws3XARTb6k
         1veHGkZvhYQRWSzFBMZ3NW+urvRIPrcAm0AepcpSPBTq+fU4CpA56uaKwX15RLcmdeNo
         io/st6H1v9zh7j+WxpVjew/O2A+qyo8xOtQTaXM6YvIYWHQwTEDpzSSDa/9C82HcSM/X
         9s7PBs1XqsCO4waaw6sLKf4DCkgjAGhvT+kaZcuqTx9SElYnDZq2pSsX+juNnaysk0wC
         d7LIRvMSmoKdeNQxTU7pKr3wTUclq/SWeJv7xa3mrNN0akLFf2TwtysGuGTflImRr48Q
         qmuw==
X-Received: by 10.13.207.1 with SMTP id r1mr9041730ywd.166.1438968648335; Fri,
 07 Aug 2015 10:30:48 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Fri, 7 Aug 2015 10:30:48 -0700 (PDT)
In-Reply-To: <CAOLa=ZSRFcfQqjphdSYkWDry8QibKL78Ev=XnfPRxc3PJ17Dog@mail.gmail.com>
X-Google-Sender-Auth: Sz-J5BEbKCTqvfx2MNXoxvH6gnM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275477>

On Fri, Aug 7, 2015 at 7:37 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Fri, Aug 7, 2015 at 10:13 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Thu, Aug 6, 2015 at 11:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> On Fri, Aug 7, 2015 at 5:49 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> It feels strange to assign a local variable reference to state.output,
>>>> and there's no obvious reason why you should need to do so. I would
>>>> have instead expected ref_format_state to be declared as:
>>>>
>>>>     struct ref_formatting_state {
>>>>        int quote_style;
>>>>        struct strbuf output;
>>>>     };
>>>>
>>>> and initialized as so:
>>>>
>>>>     memset(&state, 0, sizeof(state));
>>>>     state.quote_style = quote_style;
>>>>     strbuf_init(&state.output, 0);
>>>>
>>>> (In fact, the memset() isn't even necessary here since you're
>>>> initializing all fields explicitly, though perhaps you want the
>>>> memset() because a future patch adds more fields which are not
>>>> initialized explicitly?)
>>>
>>> Yea the memset is needed for bit fields evnetually added in the future.
>>
>> Perhaps move the memset() to the first patch which actually requires
>> it, where it won't be (effectively) dead code, as it becomes here once
>> you make the above change.
>
> But why would I need it there, we need to only memset() the ref_formatting_state
> which is introduced here. Also here it helps in setting the strbuf
> within ref_formatting_state to {0, 0, 0}.

If you declare ref_formatting_state as shown above, and then
initialize it like so:

    state.quote_style = quote_style;
    strbuf_init(&state.output, 0);

then (as of this patch) the structure is fully initialized because
you've initialized each member individually. Adding a memset() above
those two lines would be do-nothing -- it would be wasted code -- and
would likely confuse someone reading the code, specifically because
the code is do-nothing and has no value (in this patch). Making each
patch understandable is one of your goals when organizing the patch
series; if a patch confuses a reader (say, by doing unnecessary work),
then it isn't satisfying that goal.

As for the strbuf member, it's initialized explicitly via
strbuf_init(), so there's no value in having memset() first initialize
it to {0, 0, 0}. Again, that's wasted code.

In a later patch, when you add another ref_formatting_state member or
two, then you will need to initialize those members too. That
initialization may be in the form of explicit assignment to each
member, or it may be the memset() sledgehammer approach, but the
initialization for those members should be added in the patch which
introduces them.

It's true that the end result is the same. By the end of the series,
you'll have memset() above the 'state.quote' and 'state.output'
initialization lines to ensure that your various boolean fields and
whatnot are initialized to zero, but each patch should be
self-contained and make sense on its own, doing just the work that it
needs to do, and not doing unrelated work. For this patch, the
memset() is unrelated work. For the later patch in which you add more
fields to ref_formatting_state(), the memset() is work necessary to
satisfy that patch's objective, thus belongs there.
