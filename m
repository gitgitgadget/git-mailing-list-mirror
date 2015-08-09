From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 03/11] ref-filter: implement an `align` atom
Date: Sat, 8 Aug 2015 23:42:09 -0400
Message-ID: <CAPig+cTHKbn0oCV61n=p5o9WihsaJbvWqKt4y9eFwA0noJoPgA@mail.gmail.com>
References: <CAOLa=ZRnnMBKpsq1ANBVgF2=xwK=A2EsPKKrGS0R4mZ8iATKfA@mail.gmail.com>
	<1438800854-19901-1-git-send-email-Karthik.188@gmail.com>
	<CAPig+cSTssDihF5cBwu=2uKX1y6GqH-5EhKnb92Fpp30JA7pwA@mail.gmail.com>
	<CAOLa=ZSkmkPpiEfDrRXNQ6Tz5GT1+7vef3TOrj1t9aZ_3wm2Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 05:42:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOHVG-0006oF-CS
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 05:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992849AbbHIDmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Aug 2015 23:42:11 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36096 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbbHIDmK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Aug 2015 23:42:10 -0400
Received: by ykeo23 with SMTP id o23so116411975yke.3
        for <git@vger.kernel.org>; Sat, 08 Aug 2015 20:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Dc01OabKBPtdTttV+68tSfOyCGxuLcO+vqUH/UJwc04=;
        b=lBIK8oqg5scMEqQUBkwmHoOQ6cinnk81hu4Zc4tdG96il7eTrCSk1q5MiHBd/ukpOZ
         MI4T3AZThU0Q/xJ60aEbft7tIiaOJVAB5T13reCzU+zdBX7TNn8IUu7NOAS6Depo6e0C
         p5TStw2tZ0JQAJiz2qHSA1d3rIjNWfb/lSZLBpAj3QpsKpy2BWAMa990FqlVVIc/uEoU
         TL/2czb1kqn8LBzHuzc/eacIIsFyzFseLTDlf/QKmKn+I98cL1oiBWDVwYekeoG85ftc
         Ru3KukXyOjLrTjbsTWnVAKLMqTyYdGFQ8C6HU23pYt1gjrBxE2sl6JwME4fIIs4dY7SH
         BRKA==
X-Received: by 10.170.63.196 with SMTP id f187mr15384439ykf.82.1439091729295;
 Sat, 08 Aug 2015 20:42:09 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 8 Aug 2015 20:42:09 -0700 (PDT)
In-Reply-To: <CAOLa=ZSkmkPpiEfDrRXNQ6Tz5GT1+7vef3TOrj1t9aZ_3wm2Lw@mail.gmail.com>
X-Google-Sender-Auth: 3SNAGRTi3LV3RCIiUSDfTgy1gtg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275525>

On Sat, Aug 8, 2015 at 2:35 AM, Karthik Nayak <karthik.188@gmail.com> w=
rote:
> On Fri, Aug 7, 2015 at 8:57 AM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
>> On Wed, Aug 5, 2015 at 2:54 PM, Karthik Nayak <karthik.188@gmail.com=
> wrote:
>>> of the padding to be performed. If the atom length is more than the
>>> padding length then no padding is performed. e.g. to pad a succeedi=
ng
>>> atom to the middle with a total padding size of 40 we can do a
>>
>> It's odd to have alignment described in terms of "padding" and
>> "padding length", especially in the case of "center" alignment. It
>> might be better to rephrase the discussion in terms of field width o=
r
>> such.
>>
>>> --format=3D"%(align:middle,40).."
>
> Ok this makes sense,
> I'll rephrase as :
>
> `<width>` is the total length of the content with alignment.

This doesn't really make sense. <width> isn't the content length; it's
the size of the area into which the content will be placed.

> If the atom length is more than the width then no alignment is perfor=
med.

What "atom"? I think you mean the content between %(align:) and %(end)
rather than "atom". The description might be clearer if you actually
say "content between %(align:) and %(end)" to indicate specifically
what is being aligned.

> e.g. to align a succeeding atom to the middle with a total width of 4=
0
> we can do:
> --format=3D"%(align:middle,40).."
>>> @@ -687,6 +690,29 @@ static void populate_value(struct ref_array_it=
em *ref)
>>>                         else
>>>                                 v->s =3D " ";
>>>                         continue;
>>> +               } else if (starts_with(name, "align:")) {
>>> +                       const char *valp =3D NULL;
>>
>> Unnecessary NULL assignment.
>
> Thats required for the second skip_prefix and so on.
> Else we get: "warning: =E2=80=98valp=E2=80=99 may be used uninitializ=
ed in this
> function [-Wmaybe-uninitialized]"

Okay, so that's because skip_prefix() is inline, and it doesn't touch
its "out" argument unless it actually skips the prefix. Ugly, but
makes sense, although I think this issue would go away if you combined
the starts_with() and skips_prefix() as suggested earlier.

>>> +                       struct align *align =3D xmalloc(sizeof(stru=
ct align));
>>> +
>>> +                       skip_prefix(name, "align:", &valp);
>>
>> You could simplify the code by combining this skip_prefix() with the
>> earlier starts_with() in the conditional:
>>
>>     } else if (skip_prefix(name, "align:", &valp)) {
>>         struct align *align =3D xmalloc(sizeof(struct align));
>>         ...
>
> That would require valp to be previously defined. Hence the split.

Yes, it would require declaring 'valp' earlier, but that seems a
reasonable tradeoff for cleaner, simpler, less redundant code.

>>>  static void apply_formatting_state(struct ref_formatting_state *st=
ate, struct strbuf *final)
>>>  {
>>> -       /* More formatting options to be evetually added */
>>> +       if (state->align && state->end) {
>>> +               struct strbuf *value =3D state->output;
>>> +               int len =3D 0, buf_len =3D value->len;
>>> +               struct align *align =3D state->align;
>>> +
>>> +               if (!value->buf)
>>> +                       return;
>>> +               if (!is_utf8(value->buf)) {
>>> +                       len =3D value->len - utf8_strwidth(value->b=
uf);
>>
>> What is this doing, exactly? If the string is *not* utf-8, then you'=
re
>> asking it for its utf-8 width. Am I reading that correctly?
>>
>> Also, what is 'len' supposed to represent? I guess you want it to be
>> the difference between the byte length and the display length, but t=
he
>> name 'len' doesn't convey that at all, nor does it help the reader
>> understand the code below where you do the actual formatting.
>>
>> In fact, if I'm reading this correctly, then 'len' is always zero in
>> your tests (because the tests never trigger this conditional), so th=
is
>> functionality is never being exercised.
>
> There shouldn't be a "!" there, will change.
> I guess 'utf8_compensation' would be a better name.

Definitely better than 'len'.

>>> +               else if (align->align_type =3D=3D ALIGN_MIDDLE) {
>>> +                       int right =3D (align->align_value - buf_len=
)/2;
>>> +                       strbuf_addf(final, "%*s%-*s", align->align_=
value - right + len,
>>> +                                   value->buf, right, "");
>>
>> An aesthetic aside: When (align_value - buf_len) is an odd number,
>> this implementation favors placing more whitespace to the left of th=
e
>> string, and less to the right. In practice, this often tends to look=
 a
>> bit more awkward than the inverse of placing more whitespace to the
>> right, and less to the left (but that again is subjective).
>
> I know that, maybe we could add an additional padding to even out the=
 value
> given?

I don't understand your question. I was merely suggesting (purely
subjectively), for the "odd length" case, putting the extra space
after the centered text rather than before it. For instance:

    int left =3D (align->align_value - buf_len) / 2;
    strbuf_addf(final, "%*s%-*s", left, "",
        align->align_value - left + len, value->buf);

or any similar variation which would give the same result.

>> This is a tangent, but I could easily see all of the code from 'if
>> (align->align_value < buf_len)' down to this point being placed in
>> utf8.c as a general alignment utility function. Doing so would make
>> this function shorter, and the patch easier to review overall (which
>> might be an important consideration -- especially given that I've
>> already spent several hours reviewing this one patch).
>
> That's a valid suggestion, will do that, thanks, but that'd mean we n=
eed to
> send an align struct to utf8.c which is only defined in ref-filter.h.
> Either this
> is fine or we need to move the definition of struct align to utf8.h.
> I think personally move the align structure and enum over to utf8.h

No, you don't need to move the 'struct align' to utf8.h. That
structure is specific to ref-filter and should stay there. Instead,
you only need to move the enum. For instance, you'd add something like
this to utf8.h:

    enum utf8_alignment {
        ALIGN_LEFT,
        ALIGN_MIDDLE,
        ALIGN_RIGHT
    };

    void strbuf_utf8_align(struct strbuf *buf,
        utf8_alignment where, int width, const char *s);

By the way, I forgot to say earlier that this should be done as a
separate patch (in order to make the current patch smaller).

That raises another question. Why are 'struct ref_formatting_state',
'struct align', 'struct atom_value', etc. defined in ref-filter.h at
all? Aren't those private implementation details of ref-filter.c, or
do you expect other code to be using them?

>>>         for (i =3D 0; i < final_buf.len; i++)
>>>                 printf("%c", final_buf.buf[i]);
>>>         putchar('\n');
>>> diff --git a/ref-filter.h b/ref-filter.h
>>> index 9e6c2d4..5575fe9 100644
>>> --- a/ref-filter.h
>>> +++ b/ref-filter.h
>>> @@ -16,14 +16,30 @@
>>>  struct ref_formatting_state {
>>> -       int quote_style;
>>>         struct strbuf *output;
>>> +       struct align *align;
>>> +       int quote_style;
>>
>> Perhaps decide where you'd like 'quote_style' to reside from the sta=
rt
>> so that you don't have to add it at one location in its introductory
>> patch and then move it in a later patch. Also, why move it here?
>
> Cause that'd save memory on a 64 bit processor, where the pointers wo=
uld
> be 8 bytes long and int would be 4 bytes long, this would bring in pa=
dding if
> int is placed before the pointers. Will change before hand.

As I understand it, you're not likely to have many
ref_fomratting_state's around at any given time, so this sounds like
premature memory micro-optimization.
