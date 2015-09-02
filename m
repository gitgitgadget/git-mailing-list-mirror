From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Wed, 02 Sep 2015 10:28:57 -0700
Message-ID: <xmqqfv2wohly.fsf@gitster.mtv.corp.google.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
	<xmqqegihrg6t.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQ0nyaQmvE3suT6hh0jO3s_iYxFLjSuLUY4STneMFJf9Q@mail.gmail.com>
	<xmqqd1y0q30g.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQLG_HB0trodXPCb9n4x2FuH7h7-+KJYLEdNZSpd0PHsg@mail.gmail.com>
	<xmqqy4goomdk.fsf@gitster.mtv.corp.google.com>
	<vpqio7slpbd.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 02 19:29:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXBqQ-0004GQ-G6
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 19:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717AbbIBR3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 13:29:05 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34647 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550AbbIBR3D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 13:29:03 -0400
Received: by padhy1 with SMTP id hy1so18078040pad.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 10:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JQwr1QmwX9gxSSmv41AMCFy3ySEVS8yYqHyAHRT1fMg=;
        b=Qw1y56OJuMsSeqO6GiFjcroasVB8YNsXY9o0en/hVeE42u2bEpMMA+XJPTLOpN0KPG
         pZROrAPkpz6mHslZhoheHe+Ldo9KaJW1nX+O8DUy0fJslmFAoW72DbCXMBZo8VaA5WwN
         tLb/ukarYoe93J9WoEowzzoXr9AeCcDHgYAcyoOV1W7kve/AycFpUMi7uhM2ZgOZSUCt
         Bnf6LqYDSnJ6v3OEK9uurknvJMHWJKsg+cNWBw54AkFdTKfQhlykDMyya7jLeKoXsEvF
         +h4FzxIH5cVzcl7ypB+ujcY7Prrn9q77h4BxwGY4uVH/32we302CusE0ZBHt/9bMSKSH
         9TRA==
X-Received: by 10.68.133.167 with SMTP id pd7mr56661038pbb.23.1441214943345;
        Wed, 02 Sep 2015 10:29:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id jd12sm18725969pbd.44.2015.09.02.10.29.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 10:29:02 -0700 (PDT)
In-Reply-To: <vpqio7slpbd.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	02 Sep 2015 19:10:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277109>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> On Wed, Sep 2, 2015 at 8:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>>
>>>>>>> +             die(_("format: `end` atom used without a supporting atom"));
>>>>>>
>>>>>> Not a show-stopper, but we may need some wordsmithing for "a
>>>>>> supporting atom" here; an end-user would not know what it is.
>>>>>
>>>>> Probably something like "format: `end` atom should only be
>>>>> used with modifier atoms".
>>>>
>>>> Between "supporting" and "modifier" I do not see much difference,
>>>> though.
>>>
>>> I don't see how we could provide a better message, as %(end) atom
>>> would be common to various atoms eventually.
>>
>> I said "not a show-stopper" without giving a suggestion exactly
>> because I didn't (and I still don't) think either you or I can come
>> up with a good wording ;-).  That is why the message was Cc'ed to
>> the list for others to comment.
>
> I don't really have a better proposal either. What we really mean is
> "%(end) requires an atom that requires to be paired with %(end)", but
> that wouldn't really help. I prefer "supporting" to "modifier":
> To me, %(color:red) can be called a "modifier" by I wouldn't call %(if)
> a modifier. "Supporting" is vague, but less misleading to me.
>
> Perhaps "corresponding"? (not convinced myself ...)

Yeah, it is like an open and a close parentheses that form a
matching pair.  "%(end) without a corresponding atom" (implying
"that opened the environment the %(end) attempts to close")?

We'd need to define what an atom is (or "supporting atom" for that
matter) and explain how nesting works in the documentation anyway,
and I'd expect we would gain definitions of a few terms we can use
in this error message.
