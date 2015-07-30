From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 01/10] ref-filter: introduce 'ref_formatting_state'
Date: Thu, 30 Jul 2015 12:23:47 +0530
Message-ID: <CAOLa=ZTOakNY79h7HUUxbbop9bFhTXDSm+WCLa6xze8G=XF15A@mail.gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
 <1438065211-3777-1-git-send-email-Karthik.188@gmail.com> <CAPig+cS+w8ECma--ncJDoN1fEgrFZMvBC8GBgU6+tLYm_oGkaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"christian.couder@gmail.com" <christian.couder@gmail.com>,
	"Matthieu.Moy@grenoble-inp.fr" <Matthieu.Moy@grenoble-inp.fr>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 08:54:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKhja-0003zq-CU
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 08:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbbG3GyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 02:54:20 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:32888 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbbG3GyR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 02:54:17 -0400
Received: by obdeg2 with SMTP id eg2so24503001obd.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 23:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CL+M1YTyxMWPXzhkoIuwF9WDvFmMa31fHJTJMILAG3E=;
        b=jM5/Hj2RmwwmlJEiYttQDt/sBo3H2yjFFw+H3HUBjvwa5lsXIYluVZzmdQprQM119n
         t48Rcnbg8M6zdSRKSxf3SnY9l/b1QRn8PNV7BHK2wYDjGaIsxGSYT4Nw5WLgN5joBJvT
         TSTw5MCryP4NMNxOQ9I0DUUhvtAk6bT5ol7BiCDbaM1WNqbeBs7CYf8G06QKht09xtqu
         X8Zazyh1DgpAJPQUbsGoWqDEJZy+X9csl3NV8FJ+ClsGqwlU2IEX90YNQLIjzP5k1mbZ
         jo+lx9yDp0gjLa06g7HLaW69TC8lebJb3kw12lvx3a9hFZi2gHVZl/ky4eCZlnB+FCCk
         Y5FQ==
X-Received: by 10.182.29.68 with SMTP id i4mr43263600obh.57.1438239256741;
 Wed, 29 Jul 2015 23:54:16 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 23:53:47 -0700 (PDT)
In-Reply-To: <CAPig+cS+w8ECma--ncJDoN1fEgrFZMvBC8GBgU6+tLYm_oGkaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274973>

On Thu, Jul 30, 2015 at 12:49 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tuesday, July 28, 2015, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce 'ref_formatting' structure to hold values of pseudo atoms
>> which help only in formatting. This will eventually be used by atoms
>> like `color` and the `padright` atom which will be introduced in a
>> later patch.
>
> Isn't this commit message outdated now that you no longer treat color
> specially and since the terminology is changing from "pseudo" to
> "modifier"? Also, isn't the structure now called
> 'ref_formatting_state' rather than 'ref_formatting'?

Yes, thanks for pointing it out. will change.

>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 7561727..a919a14 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -620,7 +622,7 @@ static void populate_value(struct ref_array_item *ref)
>>                 const char *name = used_atom[i];
>>                 struct atom_value *v = &ref->value[i];
>>                 int deref = 0;
>> -               const char *refname;
>> +               const char *refname = NULL;
>
> What is this change about? It doesn't seem to be related to anything
> else in the patch.
>

In previous versions it was giving a refname not assigned error before usage
error, in the current version, its not needed. will remove.

>>                 const char *formatp;
>>                 struct branch *branch = NULL;
>>
>> @@ -1190,30 +1192,47 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>> +static void print_value(struct atom_value *v, struct ref_formatting_state *state)
>> +{
>> +       struct strbuf value = STRBUF_INIT;
>> +       struct strbuf formatted = STRBUF_INIT;
>> +
>> +       /*
>> +        * Some (pesudo) atoms have no immediate side effect, but only
>> +        * affect the next atom. Store the relevant information from
>> +        * these atoms in the 'state' variable for use when displaying
>> +        * the next atom.
>> +        */
>> +       apply_formatting_state(state, v, &value);
>
> The comment says that this is "storing" formatting state, however, the
> code is actually "applying" the state. You could move this comment
> down to show_ref_array_item() where formatting state actually gets
> stored. Or you could fix it to talk about "applying" the state.
> However, now that apply_formatting_state() has a meaningful name, you
> could also drop the comment altogether since it doesn't say much
> beyond what is said already by the function name.
>

I guess I'll drop the comment thanks :)

>> +       switch (state->quote_style) {
>>         case QUOTE_NONE:
>> -               fputs(v->s, stdout);
>> @@ -1254,9 +1273,26 @@ static void emit(const char *cp, const char *ep)
>> +static void reset_formatting_state(struct ref_formatting_state *state)
>> +{
>> +       int quote_style = state->quote_style;
>> +       memset(state, 0, sizeof(*state));
>> +       state->quote_style = quote_style;
>
> I wonder if this sledge-hammer approach of saving one or two values
> before clearing the entire 'ref_formatting_state' and then restoring
> the saved values will scale well. Would it be better for this to just
> individually reset the fields which need resetting and not touch those
> that don't?
>
> Also, the fact that quote_style has to be handled specially may be an
> indication that it doesn't belong in this structure grouped with the
> other modifiers or that you need better classification within the
> structure. For instance:
>
>     struct ref_formatting_state {
>         struct global {
>             int quote_style;
>         };
>         struct local {
>             int pad_right;
>         };
>
> where 'local' state gets reset by reset_formatting_state(), and
> 'global' is left alone.
>
> That's just one idea, not necessarily a proposal, but is something to
> think about since the current arrangement is kind of yucky.
>

Did you read Junio's suggestion about not having a reset_formatting_state()
and rather just have each state be responsible of resetting itself.

I think thats seems to be a better approach.

>> +}
>> +
>>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>>  {
>>         const char *cp, *sp, *ep;
>> +       struct ref_formatting_state state;
>> +
>> +       memset(&state, 0, sizeof(state));
>> +       state.quote_style = quote_style;
>
> It's a little bit ugly to use memset() here when you have
> reset_formatting_state() available. You could set quote_style first,
> and then call reset_formatting_state() rather than memset(). Or,
> perhaps, change reset_formatting_state(), as described above, to stop
> using the sledge-hammer approach.
>

I guess even this would be taken care of by implementing Junio's suggestion.

-- 
Regards,
Karthik Nayak
