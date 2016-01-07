From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 14/15] ref-filter: introduce contents_atom_parser()
Date: Fri, 8 Jan 2016 01:33:54 +0530
Message-ID: <CAOLa=ZR=id7826YQZ4+Gk-6RzWVKrVomSFvzPqToeLcgt8Jr+Q@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <1451980994-26865-15-git-send-email-Karthik.188@gmail.com>
 <xmqqio37iuvj.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQY09yqDVELb9ObTnWfU-9nRyxJiV=_2tHbZPk_oe8sGQ@mail.gmail.com>
 <xmqqziwh4669.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 21:04:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHGnN-0006EZ-6d
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 21:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbcAGUEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 15:04:25 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34051 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbcAGUEY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 15:04:24 -0500
Received: by mail-vk0-f51.google.com with SMTP id a123so149241746vkh.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 12:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qc03If8ZXVZXGrRSJhnCuyXFsjfFoMvS9H8kOAGdD4o=;
        b=ucC+rB27a+fmiVmJMbh19rF5SD1Ye64mwlHD9r/8DTKKEuWU1pLuyIuDC7Hja+FU0j
         CIz27zc0KDP/eSeqdfxlAYUdCFmMjHImSSKns3GfQ1JCNMy47H1uANoDEf4oABwKP8q1
         PVEDKbqSdhEk0mjUWKjuhjADBaAgsLb4JJDonz+HQo/fPVCpLWVT43RzIb1RBxc3vMUw
         kENGl0dZp6UxJDhTSG5RCgfPF4/xMzYRUXWsr5ZEFkxhYTjWJ3gR5FBdK32HsPdmppsE
         iLOm/FM784iizwKZ5dn8t/rmMHGIWOiwwRGcwNvhQS+FKksCbCM5oXTY+XBOBIjrLew9
         RkNQ==
X-Received: by 10.31.142.16 with SMTP id q16mr73932145vkd.95.1452197063567;
 Thu, 07 Jan 2016 12:04:23 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Thu, 7 Jan 2016 12:03:54 -0800 (PST)
In-Reply-To: <xmqqziwh4669.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283502>

On Thu, Jan 7, 2016 at 11:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>> +static void contents_atom_parser(struct used_atom *atom)
>>>> +{
>>>> +     const char * buf;
>
> const char *buf;
>

will change that.

>>>> +
>>>> +     if (match_atom_name(atom->name, "subject", &buf) && !buf) {
>>>> +             atom->u.contents.option = C_SUB;
>>>> +             return;
>>>> +     } else if (match_atom_name(atom->name, "body", &buf) && !buf) {
>>>> +             atom->u.contents.option = C_BODY_DEP;
>>>> +             return;
>>>> +     } if (!match_atom_name(atom->name, "contents", &buf))
>>>> +               die("BUG: parsing non-'contents'");
>>>
>>> Did you really intend to say "if" here, not "else if"?
>>
>> Not that it makes a difference here since both the previous
>> condition return. I think "else if" would be better.
>
> I am not sure if it is "Y would be better even though X and Y both
> would work".  It looks to me "X and Y behave differently, X is a bug
> and Y is correct".
>
> The above would behave differently between "if" and "else if" (and
> by the way, the code layout suggests it is "else if"; otherwise you
> would be starting "if" on its own line) when you feed "subject:foo",
> no?

It is indeed an "else if". What I was referring to was that since its like

if (cond_a) {
...
return;
} else if (cond_b) {
...
return;
} if (cond_c) {
...
}

cond_c is only checked if cond_a and cond_b don't hold good. Similar to
how 'else if' would work, because cond_a and cond_b return. Sorry for the
confusion.

-- 
Regards,
Karthik Nayak
