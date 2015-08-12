From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 02/13] ref-filter: print output to strbuf for formatting
Date: Wed, 12 Aug 2015 18:52:15 +0530
Message-ID: <CAOLa=ZSo9wXj_2wPCfZ=kEYhnFHzqT2AUFKvoDoKh_BD9v+1Hw@mail.gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
 <1439129506-9989-3-git-send-email-Karthik.188@gmail.com> <xmqqlhdhso8i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 15:23:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPVzp-0006IF-Hp
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 15:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933598AbbHLNWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 09:22:47 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34532 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933557AbbHLNWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 09:22:45 -0400
Received: by obbfr1 with SMTP id fr1so12290674obb.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ounSxumxaRGGp+Zy/nzvW65uhkyScbyaX6pyJQJ5RfI=;
        b=XFPCrY1ko20+W6sXoNZic0nRnJrM8sEbtU8YhDN2R/OPzeWS3WwXsKq/UAyHBnw/wp
         YOEccqP0vtC9eB4pCl5GxNR6OaLqaKijYUtT+/x7absoAc7VL/N1HxXcFGy3dQHpN+2E
         Xudxo92mziezvV5RJmwDMyOxJYo7ywaMn8nSAyvJWX7qVgO7tMt+uW2WEHArRXjttoBy
         /iy1Ukfyo0NcvZETteZWRWrE7o/PvrWXQYa+DBKSECadkY6mY0avwU2Oz0D8N2qJ+Wmm
         GGzWDHBKAjzRdcg59NEf9LG/cjKJAYRWv44jj591S2quiWFGs04G1GnpvyG2slYYvGqr
         v79Q==
X-Received: by 10.182.29.68 with SMTP id i4mr29678049obh.57.1439385764901;
 Wed, 12 Aug 2015 06:22:44 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 12 Aug 2015 06:22:15 -0700 (PDT)
In-Reply-To: <xmqqlhdhso8i.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275763>

On Tue, Aug 11, 2015 at 11:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> -static void print_value(struct atom_value *v, int quote_style)
>> +static void format_quote_value(struct atom_value *v, int quote_style, struct strbuf *output)
>>  {
>
> Hmph...
>
>> -static void emit(const char *cp, const char *ep)
>> +static void append_non_atom(const char *cp, const char *ep, struct strbuf *output)
>
> I was tempted to suggest s/non_atom/literal/, but this would do for now...
>

Since I'll be doing a re-roll I could do that.

>> @@ -1262,19 +1257,20 @@ static void emit(const char *cp, const char *ep)
>>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>>  {
>>       const char *cp, *sp, *ep;
>> +     struct strbuf output = STRBUF_INIT;
>>
>>       for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>>               struct atom_value *atomv;
>>
>>               ep = strchr(sp, ')');
>>               if (cp < sp)
>> -                     emit(cp, sp);
>> +                     append_non_atom(cp, sp, &output);
>>               get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
>> -             print_value(atomv, quote_style);
>> +             format_quote_value(atomv, quote_style, &output);
>
> If the one to add a literal string (with %hex escaping) is called "append_",
> then this should be called append_quoted_atom() or something, no?

Although it does append like "append_non_atom" this is more of formatting based
on the quote given hence the name.

-- 
Regards,
Karthik Nayak
