From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Wed, 2 Sep 2015 21:39:18 +0530
Message-ID: <CAOLa=ZQTKuHH4ktvTdCRM49cinTSeCbhd8ngVzcJh_eBHGk-iw@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-6-git-send-email-Karthik.188@gmail.com> <xmqqegihrg6t.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQ0nyaQmvE3suT6hh0jO3s_iYxFLjSuLUY4STneMFJf9Q@mail.gmail.com>
 <xmqqd1y0q30g.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQLG_HB0trodXPCb9n4x2FuH7h7-+KJYLEdNZSpd0PHsg@mail.gmail.com>
 <xmqqy4goomdk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 18:09:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXAbi-0005Ky-0j
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 18:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbbIBQJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 12:09:49 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36469 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbbIBQJt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 12:09:49 -0400
Received: by obqa2 with SMTP id a2so12047063obq.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 09:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+lhDnmWExwdRkGrWDj4S2HW2Pl5IUQNEsAbXNhOtOaM=;
        b=L0k5dK/jxy/gDlx6kxbyho0Ms7VlmuY3mK0ShwkfaMCLq/nGi/BIMv/Qnp4fMXDyJR
         PCdaR1k4TMh3dk6e7QMO1HM7beN5/AvdfaPT9WmfSppCmh1pnoJr+fJ0XP4MqpxNTrZh
         KksLUfnSyFW8XEsXDtpKvPbrwSS+3HWT/gQa6ArPImHp8bViYGF106+r3aAAcj9VlKam
         TPN16Q/+LNdDIt1NuK4HU9KjnrTPt0UqWfkRFfnW7mS3qYlkNn5s9PtqL0U7wKLKIL06
         DnS46rt43IKZbBND0bXbWW/rmF0dY/FdnRDZibRDnjBBio3MxYm900UfXBrn5K7OI59o
         lXUQ==
X-Received: by 10.182.171.35 with SMTP id ar3mr20401559obc.57.1441210188302;
 Wed, 02 Sep 2015 09:09:48 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 2 Sep 2015 09:09:18 -0700 (PDT)
In-Reply-To: <xmqqy4goomdk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277103>

On Wed, Sep 2, 2015 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Wed, Sep 2, 2015 at 8:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>>>> +             die(_("format: `end` atom used without a supporting atom"));
>>>>>
>>>>> Not a show-stopper, but we may need some wordsmithing for "a
>>>>> supporting atom" here; an end-user would not know what it is.
>>>>
>>>> Probably something like "format: `end` atom should only be
>>>> used with modifier atoms".
>>>
>>> Between "supporting" and "modifier" I do not see much difference,
>>> though.
>>
>> I don't see how we could provide a better message, as %(end) atom
>> would be common to various atoms eventually.
>
> I said "not a show-stopper" without giving a suggestion exactly
> because I didn't (and I still don't) think either you or I can come
> up with a good wording ;-).  That is why the message was Cc'ed to
> the list for others to comment.

Haha okay.

>
>>>> Cause we wanted to provide an error for usage of "%(ailgn)" without any
>>>> subvalues as such.
>>>
>>> Wouldn't it be something that would be caught in the same codepath
>>> as what catches %(unrecognized) in the format string?
>
> One potential issue you have with prefix matching with "align" is
> that you can never have a different atom whose name happens to begin
> with that substring.  I think the best behaviour is for the higher
> level parser to recognize %(ATOM) and %(ATOM:anything) and nothing
> else for all ATOM in the valid atoms registry.  That would prevent
> %(ATOMfoo) from being handled as part of handling ATOM.
>
> And make the code consider %(ATOM) form as a short-hand for %(ATOM:)
> that does not have customizations.  Conceptually %(refname) is a
> %(refname:default).
>
> For an atom like 'align' that does not have a reasonable default,
> the parser for 'align' can notice that a required customization is
> missing and give an error that is specific to 'align'.
>
> So all calls in your code of the from
>
>         ... else if (skip_prefix(name, "align", &val)) {
>                 ...
>
> should become a call to helper that does more than skip_prefix().
>

This is what Eric suggested and we agreed on working on a general
solution to this problem eventually, seems like you beat me to it :)

Will incorporate this :)

> int match_atom_name(const char *name, const char *atom_name, char **val)
> {
>         char *body
>
>         if (!skip_prefix(name, atom_name, &body))
>                 return 0; /* doesn't even begin with "align" */
>         if (!body[0]) {
>                 *val = NULL; /* %(align) and no customization */
>                 return 1;
>         }
>         if (body[0] != ':')
>                 return 0; /* "alignfoo" is not "align" or "align:..." */
>         *val = body + 1; /* "align:val" */
>         return 1;
> }

Thanks.

-- 
Regards,
Karthik Nayak
