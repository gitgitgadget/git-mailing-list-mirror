From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Wed, 02 Sep 2015 08:45:59 -0700
Message-ID: <xmqqy4goomdk.fsf@gitster.mtv.corp.google.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
	<xmqqegihrg6t.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQ0nyaQmvE3suT6hh0jO3s_iYxFLjSuLUY4STneMFJf9Q@mail.gmail.com>
	<xmqqd1y0q30g.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQLG_HB0trodXPCb9n4x2FuH7h7-+KJYLEdNZSpd0PHsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 17:46:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXAEq-00080G-0m
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 17:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbbIBPqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 11:46:05 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34982 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbbIBPqD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 11:46:03 -0400
Received: by pacfv12 with SMTP id fv12so15710112pac.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 08:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RvufcCxJ9aCwp4qZ6U6etDZhpAZSicbz+yGwywjUfbU=;
        b=xWCcPXUQEM2i2JY5rTFOpqmWxUSQYf2hnaNqFAiGaOrcY1B8rtYeZ/B7lEpw+oCNgf
         TW/tsnZ2tRbQzLFe4MaLXfc7aFcNmHe+EKFVp6WhnQnLjeby6TMfQ7O91UIY6hiEeRfJ
         CQcdmE8Vcr6h2TbGu6vccaQqRrEGhGrMFXZqjr9R/4RCbZNwomG2nyVMxtxSe0mvb9TQ
         TWNvqovkxSrDs35HTcOVl1pKMZ/gA6W/sTwKrSV5O02MWm0x27F2k1ziAcDZAT/YitJa
         /xTskUyDA25PBI3BuvzF3I4Onf306rRONmkFusDyqJ53QNFaX8jtkntAJkJS6Ec18H7n
         bLSA==
X-Received: by 10.68.249.66 with SMTP id ys2mr57627058pbc.82.1441208762665;
        Wed, 02 Sep 2015 08:46:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id t15sm22060962pbs.10.2015.09.02.08.46.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 08:46:00 -0700 (PDT)
In-Reply-To: <CAOLa=ZQLG_HB0trodXPCb9n4x2FuH7h7-+KJYLEdNZSpd0PHsg@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 2 Sep 2015 20:35:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277099>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Wed, Sep 2, 2015 at 8:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>>>> +             die(_("format: `end` atom used without a supporting atom"));
>>>>
>>>> Not a show-stopper, but we may need some wordsmithing for "a
>>>> supporting atom" here; an end-user would not know what it is.
>>>
>>> Probably something like "format: `end` atom should only be
>>> used with modifier atoms".
>>
>> Between "supporting" and "modifier" I do not see much difference,
>> though.
>
> I don't see how we could provide a better message, as %(end) atom
> would be common to various atoms eventually.

I said "not a show-stopper" without giving a suggestion exactly
because I didn't (and I still don't) think either you or I can come
up with a good wording ;-).  That is why the message was Cc'ed to
the list for others to comment.

>>> Cause we wanted to provide an error for usage of "%(ailgn)" without any
>>> subvalues as such.
>>
>> Wouldn't it be something that would be caught in the same codepath
>> as what catches %(unrecognized) in the format string?

One potential issue you have with prefix matching with "align" is
that you can never have a different atom whose name happens to begin
with that substring.  I think the best behaviour is for the higher
level parser to recognize %(ATOM) and %(ATOM:anything) and nothing
else for all ATOM in the valid atoms registry.  That would prevent
%(ATOMfoo) from being handled as part of handling ATOM.

And make the code consider %(ATOM) form as a short-hand for %(ATOM:)
that does not have customizations.  Conceptually %(refname) is a
%(refname:default).

For an atom like 'align' that does not have a reasonable default,
the parser for 'align' can notice that a required customization is
missing and give an error that is specific to 'align'.

So all calls in your code of the from

	... else if (skip_prefix(name, "align", &val)) {
        	...

should become a call to helper that does more than skip_prefix().

int match_atom_name(const char *name, const char *atom_name, char **val)
{
	char *body

       	if (!skip_prefix(name, atom_name, &body))
        	return 0; /* doesn't even begin with "align" */
	if (!body[0]) {
        	*val = NULL; /* %(align) and no customization */
                return 1;
	}
	if (body[0] != ':')
        	return 0; /* "alignfoo" is not "align" or "align:..." */
	*val = body + 1; /* "align:val" */
        return 1;
}
