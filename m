From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 01/11] ref-filter: print output to strbuf for formatting
Date: Tue, 4 Aug 2015 02:53:08 +0530
Message-ID: <CAOLa=ZRx+eY_byR=wSinZV9Ay2-iDfs49d9kDOAcM7iFZvm1-g@mail.gmail.com>
References: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
 <1438620861-25219-1-git-send-email-Karthik.188@gmail.com> <xmqq4mkg85ym.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:23:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMND0-0002XZ-Sb
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 23:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbbHCVXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 17:23:40 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34727 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932461AbbHCVXi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 17:23:38 -0400
Received: by obre1 with SMTP id e1so109054632obr.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gEyOo8G/3uJ2b4nUNUfnInRQfK54pak73nkSBmkPF1Q=;
        b=pXcNN5xnzPh4tSO5tG+VAR9QwtC6d7iMTUXRk3Jfw1ktqEv4UgLbSwHY57LgOIu6U+
         ZzC55RNnDBfPjTkKuFgx8wkK57ESxpO6fwvHu2Q08MrfRu9d2rA5eFdklnefbwIL28xw
         /Wbibve6PMORsjDVvh3Ov4WlV4MHuwLvw9u+VgakpbJgUfFD3nxHiMw1Ua4+oijm49Zl
         zy5lDL1CT/ickdjgNHmD2rU7lnFjm1dEi6iXCcKSZZJmtlB1Q/Ijnh+r4axBHNFCH0nF
         uMj9vxa5tqFGC5TaSXmkab+mtV1Yf8qtmLSVw/3wyjclg07QN1wCY+RrCTdEvKrD5fPL
         oF3g==
X-Received: by 10.60.92.37 with SMTP id cj5mr138921oeb.30.1438637017907; Mon,
 03 Aug 2015 14:23:37 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 3 Aug 2015 14:23:08 -0700 (PDT)
In-Reply-To: <xmqq4mkg85ym.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275207>

On Tue, Aug 4, 2015 at 2:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Introduce a strbuf `output` which will act as a substitute rather than
>> printing directly to stdout. This will be used for formatting
>> eventually.
>> ---
>
> Missing sign-off; the patch looks like a good first step in a nice
> direction.
>

Will add, Thanks :)

>>  ref-filter.c | 36 ++++++++++++++++++------------------
>>  1 file changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 7561727..febdc45 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1190,30 +1190,25 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>>       qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
>>  }
>>
>> -static void print_value(struct atom_value *v, int quote_style)
>> +static void print_value(struct atom_value *v, int quote_style, struct strbuf *output)
>>  {
>> -     struct strbuf sb = STRBUF_INIT;
>>       switch (quote_style) {
>>       case QUOTE_NONE:
>> -             fputs(v->s, stdout);
>> +             strbuf_addstr(output, v->s);
>>               break;
>>       case QUOTE_SHELL:
>> -             sq_quote_buf(&sb, v->s);
>> +             sq_quote_buf(output, v->s);
>>               break;
>>       case QUOTE_PERL:
>> -             perl_quote_buf(&sb, v->s);
>> +             perl_quote_buf(output, v->s);
>>               break;
>>       case QUOTE_PYTHON:
>> -             python_quote_buf(&sb, v->s);
>> +             python_quote_buf(output, v->s);
>>               break;
>>       case QUOTE_TCL:
>> -             tcl_quote_buf(&sb, v->s);
>> +             tcl_quote_buf(output, v->s);
>>               break;
>>       }
>> -     if (quote_style != QUOTE_NONE) {
>> -             fputs(sb.buf, stdout);
>> -             strbuf_release(&sb);
>> -     }
>>  }
>>
>>  static int hex1(char ch)
>> @@ -1234,7 +1229,7 @@ static int hex2(const char *cp)
>>               return -1;
>>  }
>>
>> -static void emit(const char *cp, const char *ep)
>> +static void emit(const char *cp, const char *ep, struct strbuf *output)
>>  {
>>       while (*cp && (!ep || cp < ep)) {
>>               if (*cp == '%') {
>> @@ -1243,13 +1238,13 @@ static void emit(const char *cp, const char *ep)
>>                       else {
>>                               int ch = hex2(cp + 1);
>>                               if (0 <= ch) {
>> -                                     putchar(ch);
>> +                                     strbuf_addch(output, ch);
>>                                       cp += 3;
>>                                       continue;
>>                               }
>>                       }
>>               }
>> -             putchar(*cp);
>> +             strbuf_addch(output, *cp);
>>               cp++;
>>       }
>>  }
>> @@ -1257,19 +1252,21 @@ static void emit(const char *cp, const char *ep)
>>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>>  {
>>       const char *cp, *sp, *ep;
>> +     struct strbuf output = STRBUF_INIT;
>> +     int i;
>>
>>       for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>>               struct atom_value *atomv;
>>
>>               ep = strchr(sp, ')');
>>               if (cp < sp)
>> -                     emit(cp, sp);
>> +                     emit(cp, sp, &output);
>>               get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
>> -             print_value(atomv, quote_style);
>> +             print_value(atomv, quote_style, &output);
>>       }
>>       if (*cp) {
>>               sp = cp + strlen(cp);
>> -             emit(cp, sp);
>> +             emit(cp, sp, &output);
>>       }
>>       if (need_color_reset_at_eol) {
>>               struct atom_value resetv;
>> @@ -1278,9 +1275,12 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>>               if (color_parse("reset", color) < 0)
>>                       die("BUG: couldn't parse 'reset' as a color");
>>               resetv.s = color;
>> -             print_value(&resetv, quote_style);
>> +             print_value(&resetv, quote_style, &output);
>>       }
>> +     for (i = 0; i < output.len; i++)
>> +             printf("%c", output.buf[i]);
>>       putchar('\n');
>> +     strbuf_release(&output);
>>  }
>>
>>  /*  If no sorting option is given, use refname to sort as default */



-- 
Regards,
Karthik Nayak
