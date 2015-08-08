From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v9 03/11] ref-filter: implement an `align` atom
Date: Sat, 8 Aug 2015 12:05:24 +0530
Message-ID: <CAOLa=ZSkmkPpiEfDrRXNQ6Tz5GT1+7vef3TOrj1t9aZ_3wm2Lw@mail.gmail.com>
References: <CAOLa=ZRnnMBKpsq1ANBVgF2=xwK=A2EsPKKrGS0R4mZ8iATKfA@mail.gmail.com>
 <1438800854-19901-1-git-send-email-Karthik.188@gmail.com> <CAPig+cSTssDihF5cBwu=2uKX1y6GqH-5EhKnb92Fpp30JA7pwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 08:36:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNxjd-0007wE-3C
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 08:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbbHHGf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Aug 2015 02:35:56 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35832 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932603AbbHHGfz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Aug 2015 02:35:55 -0400
Received: by obbop1 with SMTP id op1so93394724obb.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 23:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4WH0GWBtkG+bAyr36/bIh11gWulFB4J+zraJxK7giyk=;
        b=ycG72Afqcgx7HsZ3YE369ukMNk2IOShLLRUQl2ZPjN1Jk+UKIUwCmdLupaFAFhxwS6
         tugelsqkCLkUzDy6A5rCsSsWVnMnjhPxgquKlgv9WAXyaKzzw3lRsQHd0+P9vXnMHfL3
         6B/z3sXlAZNM9m+M3phVI+y7YCWhu+VIPhHlM1Lf3i3hthuUd1++ell1NrSPK9+UkGO6
         Bq695CXu3gDdm84X8gIo/49xWFRvptZhgsRT07HS7cE5Mi6A0F0uCCz6tErYYU4Yi1Nd
         qT5XPOEidMrIzn3YufIXeKbuR+gyD9U2TCRro8HBZBbhOiCdEipt8FJkCE4XcEyZXrVx
         pxOA==
X-Received: by 10.60.177.195 with SMTP id cs3mr10267935oec.37.1439015754051;
 Fri, 07 Aug 2015 23:35:54 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Fri, 7 Aug 2015 23:35:24 -0700 (PDT)
In-Reply-To: <CAPig+cSTssDihF5cBwu=2uKX1y6GqH-5EhKnb92Fpp30JA7pwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275508>

On Fri, Aug 7, 2015 at 8:57 AM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Wed, Aug 5, 2015 at 2:54 PM, Karthik Nayak <karthik.188@gmail.com>=
 wrote:
>> Implement an `align` atom which will act as a modifier atom and alig=
n
>> any string with or without an %(atom) appearing before a %(end) atom
>> to the right, left or middle.
>
> For someone not familiar with the evolution of this patch series,
> "align any string with or without an %(atom)" is confusing and
> distracting and seems to imply that something extra mysterious is
> going on behind the scenes. Keeping it simple makes it easier to
> understand:
>
>     Add an `align` atom which left-, middle-, or right-aligns the
>     content between %(align:...) and %(end).
>

Ok will change this.

>> It is followed by `:<type>,<paddinglength>`, where the `<type>` is
>
> 'type' may not be the best name. Perhaps 'style' or 'position' or
> something else would be better?
>

position is a better term.

>> either left, right or middle and `<paddinglength>` is the total leng=
th
>
> 'paddinglength' is misleading. You're really describing the container
> width in which alignment takes places, so perhaps call it 'width' or
> 'fieldwidth' or something.
>

width seems good to go.

>> of the padding to be performed. If the atom length is more than the
>> padding length then no padding is performed. e.g. to pad a succeedin=
g
>> atom to the middle with a total padding size of 40 we can do a
>
> It's odd to have alignment described in terms of "padding" and
> "padding length", especially in the case of "center" alignment. It
> might be better to rephrase the discussion in terms of field width or
> such.
>
>> --format=3D"%(align:middle,40).."

Ok this makes sense,
I'll rephrase as :

`<width>` is the total length of the content with alignment.
If the atom length is more than the width then no alignment is performe=
d.
e.g. to align a succeeding atom to the middle with a total width of 40
we can do:
--format=3D"%(align:middle,40).."

>
> I may have missed the discussion, but why was comma chosen as a
> separator here, rather than, say, colon? For instance:
>
>     %(align:middle:40)
>

I think it's based of this:
http://thread.gmane.org/gmane.comp.version-control.git/275119

>> Add documentation and tests for the same.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-=
for-each-ref.txt
>> index e49d578..d865f98 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -127,6 +127,14 @@ color::
>> +align::
>> +       Align any string with or without %(atom) before the %(end)
>> +       atom to the right, left or middle. Followed by
>
> Ditto regarding "any string with or without %(atom)" being confusing
> to someone not familiar with the evolution of this patch series.
> Instead, perhaps:
>
>     Left-, middle-, or right-align content between %(align:...)
>     and %(end).
>

Will change as per change in the commit message.

>> +       `:<type>,<paddinglength>`, where the `<type>` is either left=
,
>> +       right or middle and `<paddinglength>` is the total length of
>> +       the padding to be performed. If the string length is more th=
an
>> +       the padding length then no padding is performed.
>
> Ditto regarding above observations about 'type', 'paddinglength', and=
 "padding".
>

Noted.

>> diff --git a/ref-filter.c b/ref-filter.c
>> index 2c074a1..d123299 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -620,7 +623,7 @@ static void populate_value(struct ref_array_item=
 *ref)
>>                 const char *name =3D used_atom[i];
>>                 struct atom_value *v =3D &ref->value[i];
>>                 int deref =3D 0;
>> -               const char *refname;
>> +               const char *refname =3D NULL;
>
> What is this change about?
>

Was to remove the compiler error, can be removed now.

>>                 const char *formatp;
>>                 struct branch *branch =3D NULL;
>>
>> @@ -687,6 +690,29 @@ static void populate_value(struct ref_array_ite=
m *ref)
>>                         else
>>                                 v->s =3D " ";
>>                         continue;
>> +               } else if (starts_with(name, "align:")) {
>> +                       const char *valp =3D NULL;
>
> Unnecessary NULL assignment.
>

Thats required for the second skip_prefix and so on.
Else we get: "warning: =E2=80=98valp=E2=80=99 may be used uninitialized=
 in this
function [-Wmaybe-uninitialized]"

>> +                       struct align *align =3D xmalloc(sizeof(struc=
t align));
>> +
>> +                       skip_prefix(name, "align:", &valp);
>
> You could simplify the code by combining this skip_prefix() with the
> earlier starts_with() in the conditional:
>
>     } else if (skip_prefix(name, "align:", &valp)) {
>         struct align *align =3D xmalloc(sizeof(struct align));
>         ...
>

That would require valp to be previously defined. Hence the split.

>> +                       if (skip_prefix(valp, "left,", &valp))
>> +                               align->align_type =3D ALIGN_LEFT;
>> +                       else if (skip_prefix(valp, "right,", &valp))
>> +                               align->align_type =3D ALIGN_RIGHT;
>> +                       else if (skip_prefix(valp, "middle,", &valp)=
)
>> +                               align->align_type =3D ALIGN_MIDDLE;
>> +                       else
>> +                               die(_("align: improper format"));
>
> You could do a better job of helping the user track down the offendin=
g
> "improper format" by actually including it in the error message.
>

Ok will do.

>> +                       if (strtoul_ui(valp, 10, &align->align_value=
))
>> +                               die(_("align: positive value expecte=
d"));
>
> Ditto.
>

Will change.

>> +                       v->align =3D align;
>> +                       v->modifier_atom =3D 1;
>> +                       continue;
>> +               } else if (starts_with(name, "end")) {
>> +                       v->end =3D 1;
>> +                       v->modifier_atom =3D 1;
>> +                       continue;
>>                 } else
>>                         continue;
>>
>> @@ -1251,12 +1277,48 @@ static void emit(const char *cp, const char =
*ep, struct ref_formatting_state *st
>>  static void apply_formatting_state(struct ref_formatting_state *sta=
te, struct strbuf *final)
>>  {
>> -       /* More formatting options to be evetually added */
>> +       if (state->align && state->end) {
>> +               struct strbuf *value =3D state->output;
>> +               int len =3D 0, buf_len =3D value->len;
>> +               struct align *align =3D state->align;
>> +
>> +               if (!value->buf)
>> +                       return;
>> +               if (!is_utf8(value->buf)) {
>> +                       len =3D value->len - utf8_strwidth(value->bu=
f);
>
> What is this doing, exactly? If the string is *not* utf-8, then you'r=
e
> asking it for its utf-8 width. Am I reading that correctly?
>
> Also, what is 'len' supposed to represent? I guess you want it to be
> the difference between the byte length and the display length, but th=
e
> name 'len' doesn't convey that at all, nor does it help the reader
> understand the code below where you do the actual formatting.
>
> In fact, if I'm reading this correctly, then 'len' is always zero in
> your tests (because the tests never trigger this conditional), so thi=
s
> functionality is never being exercised.
>

There shouldn't be a "!" there, will change.
I guess 'utf8_compensation' would be a better name.

>> +                       buf_len -=3D len;
>> +               }
>> +
>> +               if (align->align_value < buf_len) {
>
> Shouldn't this be '<=3D' rather than '<'? There's no point going thro=
ugh
> the formatting gyrations below if the string fills the alignment widt=
h
> exactly.
>

Good point.

> Also, what's the purpose of 'buf_len'? It's value is always
> (value->len - len), so you could just as easily say:
>
>     if (align->align_value <=3D value->len - len) {
>
> In fact, the misleading name 'len', along with 'buf_len' and
> value->len tend to make this code difficult to comprehend. If,
> instead, you had a variable named 'display_len', then its meaning
> would be obvious, and computations involving it would be more easily
> understood. The value of 'display_len' could be computed via:
>
>     display_len =3D utf8_strnwidth(value->buf, value->len, 0);

This is brilliant, would also remove the if statement for checking if i=
t's
utf8.

>
> which would give you the utf-8 width if utf-8, or value->len if not.
>
> And, the above conditional would become the more readable:
>
>     if (align->align_value <=3D display_len) {
>
> although, I find it easier to understand the logic with the condition
> switched around:
>
>     if (display_len >=3D align->align_value) {
>         ...don't bother with alignment gyrations...
>
> (but that's just subjective)
>

Yea with the name diplay_len that'd make sense, as you're saying is the=
 length
is greater than alignment value, don't bother with it.

>> +                       state->align =3D NULL;
>> +                       strbuf_addbuf(final, value);
>> +                       strbuf_release(value);
>> +                       return;
>> +               }
>> +
>> +               if (align->align_type =3D=3D ALIGN_LEFT)
>> +                       strbuf_addf(final, "%-*s", len + align->alig=
n_value, value->buf);
>> +               else if (align->align_type =3D=3D ALIGN_MIDDLE) {
>> +                       int right =3D (align->align_value - buf_len)=
/2;
>> +                       strbuf_addf(final, "%*s%-*s", align->align_v=
alue - right + len,
>> +                                   value->buf, right, "");
>
> Why do you use the left-justifying format "%-*s" when interpolating
> the zero-length string considering that "%*s" works just as well?
>

Yes that also would work.

> An aesthetic aside: When (align_value - buf_len) is an odd number,
> this implementation favors placing more whitespace to the left of the
> string, and less to the right. In practice, this often tends to look =
a
> bit more awkward than the inverse of placing more whitespace to the
> right, and less to the left (but that again is subjective).
>

I know that, maybe we could add an additional padding to even out the v=
alue
given?

>> +               } else if (align->align_type =3D=3D ALIGN_RIGHT)
>> +                       strbuf_addf(final, "%*s", align->align_value=
, value->buf);
>
> Why doesn't this case need to take 'len' into account like the other =
cases?
>

This needs to be changed.

> This is a tangent, but I could easily see all of the code from 'if
> (align->align_value < buf_len)' down to this point being placed in
> utf8.c as a general alignment utility function. Doing so would make
> this function shorter, and the patch easier to review overall (which
> might be an important consideration -- especially given that I've
> already spent several hours reviewing this one patch).
>

That's a valid suggestion, will do that, thanks, but that'd mean we nee=
d to
send an align struct to utf8.c which is only defined in ref-filter.h.
Either this
is fine or we need to move the definition of struct align to utf8.h.

I think personally move the align structure and enum over to utf8.h

>> +               strbuf_release(value);
>> +               state->align =3D NULL;
>> +               return;
>> +       } else if (state->align)
>> +               return;
>
> Do you expect additional types of state processing in the future? If
> so, this function is likely to get very long. It might make sense to
> break the alignment logic out into its own function which is called
> from this one.
>

Makes sense, will do.

>>         strbuf_addbuf(final, state->output);
>>         strbuf_release(state->output);
>>  }
>> @@ -1301,6 +1372,7 @@ void show_ref_array_item(struct ref_array_item=
 *info, const char *format, int qu
>>                 print_value(&resetv, &state);
>>                 apply_formatting_state(&state, &final_buf);
>>         }
>> +
>
> Sneaking in a whitespace change which an earlier patch perhaps should
> have formatted correctly in the first place?
>

will change.

>>         for (i =3D 0; i < final_buf.len; i++)
>>                 printf("%c", final_buf.buf[i]);
>>         putchar('\n');
>> diff --git a/ref-filter.h b/ref-filter.h
>> index 9e6c2d4..5575fe9 100644
>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -16,14 +16,30 @@
>>  struct ref_formatting_state {
>> -       int quote_style;
>>         struct strbuf *output;
>> +       struct align *align;
>> +       int quote_style;
>
> Perhaps decide where you'd like 'quote_style' to reside from the star=
t
> so that you don't have to add it at one location in its introductory
> patch and then move it in a later patch. Also, why move it here?
>

Cause that'd save memory on a 64 bit processor, where the pointers woul=
d
be 8 bytes long and int would be 4 bytes long, this would bring in padd=
ing if
int is placed before the pointers. Will change before hand.

>> +       unsigned int end : 1;
>> +};
>> +
>> +struct align {
>> +       align_type align_type;
>
> No need for an "align_" prefix on the members of 'struct align'.
> That's just unneeded verbosity.
>

Noted, will change.

> As mentioned above, 'type' may not be the best name. Perhaps 'style'
> or 'position' or something better.
>

Position seems better choice, will change that throughout.

>> +       unsigned int align_value;
>
> Ditto. 'value' doesn't say much, whereas 'width' or 'fieldwidth' woul=
d
> be more meaningful.
>

width seems good.

>>  };
>> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-f=
ilter.sh
>> index 505a360..76041a2 100755
>> --- a/t/t6302-for-each-ref-filter.sh
>> +++ b/t/t6302-for-each-ref-filter.sh
>> @@ -81,4 +81,52 @@ test_expect_success 'filtering with --contains' '
>>         test_cmp expect actual
>>  '
>>
>> +test_expect_success 'left alignment' '
>> +       cat >expect <<-\EOF &&
>> +       refname is refs/heads/master  |refs/heads/master
>> +       refname is refs/heads/side    |refs/heads/side
>> +       refname is refs/odd/spot      |refs/odd/spot
>> +       refname is refs/tags/double-tag|refs/tags/double-tag
>> +       refname is refs/tags/four     |refs/tags/four
>> +       refname is refs/tags/one      |refs/tags/one
>> +       refname is refs/tags/signed-tag|refs/tags/signed-tag
>> +       refname is refs/tags/three    |refs/tags/three
>> +       refname is refs/tags/two      |refs/tags/two
>> +       EOF
>> +       git for-each-ref --format=3D"%(align:left,30)refname is %(re=
fname)%(end)|%(refname)" >actual &&
>> +       test_cmp expect actual
>> +'
>
> Alluding to a previous review comment, for this left-alignment test,
> perhaps add a third column to prove that the %(align:) atom isn't
> leaking from column 1 to column 2 since it's not obvious to the
> reader, given that trailing whitespace is not otherwise visible.
>

Well its kinda pointless here cause you need an %(end) atom for alignme=
nt,
so if there was a possible leak its hard to tell where the leak would
extend till
as we need an %(end) atom to process alignment.

>> +test_expect_success 'middle alignment' '
>> +       cat >expect <<-\EOF &&
>> +       | refname is refs/heads/master |refs/heads/master
>> +       |  refname is refs/heads/side  |refs/heads/side
>> +       |   refname is refs/odd/spot   |refs/odd/spot
>> +       |refname is refs/tags/double-tag|refs/tags/double-tag
>> +       |   refname is refs/tags/four  |refs/tags/four
>> +       |   refname is refs/tags/one   |refs/tags/one
>> +       |refname is refs/tags/signed-tag|refs/tags/signed-tag
>> +       |  refname is refs/tags/three  |refs/tags/three
>> +       |   refname is refs/tags/two   |refs/tags/two
>> +       EOF
>> +       git for-each-ref --format=3D"|%(align:middle,30)refname is %=
(refname)%(end)|%(refname)" >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'right alignment' '
>> +       cat >expect <<-\EOF &&
>> +       |  refname is refs/heads/master|refs/heads/master
>> +       |    refname is refs/heads/side|refs/heads/side
>> +       |      refname is refs/odd/spot|refs/odd/spot
>> +       |refname is refs/tags/double-tag|refs/tags/double-tag
>> +       |     refname is refs/tags/four|refs/tags/four
>> +       |      refname is refs/tags/one|refs/tags/one
>> +       |refname is refs/tags/signed-tag|refs/tags/signed-tag
>> +       |    refname is refs/tags/three|refs/tags/three
>> +       |      refname is refs/tags/two|refs/tags/two
>> +       EOF
>> +       git for-each-ref --format=3D"|%(align:right,30)refname is %(=
refname)%(end)|%(refname)" >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>>  test_done
>> --
>> 2.5.0



--=20
Regards,
Karthik Nayak
