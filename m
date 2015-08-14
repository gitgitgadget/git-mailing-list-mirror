From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 05/13] ref-filter: implement an `align` atom
Date: Fri, 14 Aug 2015 21:16:32 +0530
Message-ID: <CAOLa=ZQcd37Vq8j9sRYwnio0T3ua5C3frMc7-uEqLWsLo6eYYg@mail.gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
 <1439129506-9989-6-git-send-email-Karthik.188@gmail.com> <xmqqy4hhr72q.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZTnS0kL=CK8Lx-brO0tryB5YzOFUpapsM4LMW-m2Yf9pw@mail.gmail.com>
 <xmqqpp2sl9au.fsf@gitster.dls.corp.google.com> <CAOLa=ZQbjVnJCxVu5SgKDUEVnidY=zw9nVYqG_z3nWhK8QnLTA@mail.gmail.com>
 <xmqqr3n8jlvv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 17:47:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQHCG-0006dE-G2
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 17:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344AbbHNPrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 11:47:04 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34174 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140AbbHNPrC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 11:47:02 -0400
Received: by oip136 with SMTP id 136so46165011oip.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fm0PUht3M1kvKpbMVDQCEiY1wCfEKOc9EfMH95jRkwE=;
        b=UwqUBgsgDB/Tm5NhxnM1Y9LZKOoyMz/Oy8pLIWCW8SSSOXJtyM9nyV3iKB/ZCEx1QC
         RJp4LqqCkIHtPZRDHnA93MrzfkjNMgzirXGus/jgPrcDhgWkQBLlHMT2C9iSIkAQwXY/
         32oFygcRkTcOMOPG6gKpa79G1lBHQ5UiRVPX3UTEeTxefYvOSw4C3KnJHglZdLvOBzZg
         31A5z9eR0TS0rxVVKVtEsmWrl6kjlLCxYOWeoRyqYdZ5qPmmVrGT5GrSLjeKIYNP3BDX
         VrfXVQNHsB44xVQNvlemige/Ak9XkHoo5SAA77q2R4Rw/Cs7FvbiphzPMQkfuIbHrr+r
         yhSg==
X-Received: by 10.202.92.6 with SMTP id q6mr38153659oib.11.1439567221539; Fri,
 14 Aug 2015 08:47:01 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Fri, 14 Aug 2015 08:46:32 -0700 (PDT)
In-Reply-To: <xmqqr3n8jlvv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275906>

On Thu, Aug 13, 2015 at 1:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Wed, Aug 12, 2015 at 10:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>> %(objectname:abbrev=8).  To specify two modification magics, each of
>>> which takes a number, the user would say e.g.
>>>
>>>     %(objectname:abbrev=8,magic=4)
>>> ...
>>> And that would be following %(align:8).  Both 'left' (implied
>>> default) and '8' are instructing 'align' what to do.
>>
>> Will follow this. :)
>
> I think the most generic way to think about this is to consider that
> the most fully spelled form of align would be this:
>
>         %(align:width=12,position=left)
>
> And another rule you would have is that the user is allowed to omit
> "<attr>=" when it is obvious from its value.  For "align", 'left'
> can only possibly be the value for 'position' and similarly '12' for
> 'width'.  That is why the "objectname" example says "abbrev=8", and
> not "abbrev,8", because from the value of "8" without the attribute
> name, you cannot tell if the user meant abbrev=8 or magic=8.
>
> That '"<attr>=" can be omitted' rule makes both of these valid
> constructs:
>
>         %(align:12,left) %(align:left,12)
>

Are you sure you want it to be so flexible? I mean It's nice to have it,
but it would include a lot more processing, I'd prefer having either the
generic type you mentioned about so users know what they're typing
or else a predefined way like

           %(align:<width>,<position>)

> Moreover, if you make "left aligned" the default behaviour when
> position is not specified, you can make %(align:12) the shortest way
> to spell the same thing.  Note that I said "if you make"; I do not
> offhand know if all the internal callers of this mechanism your
> updates to "branch -l" and "tag -l" would want left aligned output
> (if so, that is one argument to favor making left-aligned the
> implicit default; if not, it may be better to require the position
> always specified).

Left align is what I'd prefer as default for branch -l and tag -l so
that will be
done.

-- 
Regards,
Karthik Nayak
