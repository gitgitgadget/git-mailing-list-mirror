From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] [PATCH] commit.c: Replace starts_with() with skip_prefix()
Date: Tue, 4 Mar 2014 17:30:09 -0500
Message-ID: <CAPig+cTR8PfRSTAMxCbnHbHGT4fn5xEO=iaOTQ0MQ0KSsy-gDQ@mail.gmail.com>
References: <1393948445-24689-1-git-send-email-karthik.188@gmail.com>
	<loom.20140304T182823-503@post.gmane.org>
	<CAOLa=ZSPeKUyBZ2gJHByhg8QxTdwScfKGA6gdxREvyjZwL0hsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tanay Abhra <tanayabh@gmail.com>, Git List <git@vger.kernel.org>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 23:30:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKxqs-0000hJ-WD
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 23:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007AbaCDWaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 17:30:12 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:50099 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbaCDWaK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 17:30:10 -0500
Received: by mail-yk0-f175.google.com with SMTP id 131so510179ykp.6
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 14:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7g8O980GGI969b/dVONOToLpinAauXEy7ayTB54gG1w=;
        b=orscUnxojs+I9RE85ogeuoYZmPvYGyz/3m/OiY7fLkSbQhV4hgkEGZPQ0VA90F5rGc
         WtL67qdvxAJWuS2JoQZmFeiwfvDIs0pmnEOVPryE8eedlINsL+HqStkd5U4ZRXJTXs9h
         tnCSHTxGGWd9jpsWSRSKmTYSzwpxWozF4hp2K922FI1BpKhh4T3KgiLMJTY466gqWPoQ
         sIVzehhGhmG8J0+Aw/Y3Dl0yrEmNWPn2qD6isD40vMCDMLIWsFvvIAnXd0sl+Ma11aHR
         8xs39e4mHi2EUhHDjH9DcpFAb5O7kJ6AEYhDY3JfZ7O4/65bMoM6ZHoBbKMgvfBSf98N
         mPVg==
X-Received: by 10.236.175.161 with SMTP id z21mr2476447yhl.80.1393972209762;
 Tue, 04 Mar 2014 14:30:09 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Tue, 4 Mar 2014 14:30:09 -0800 (PST)
In-Reply-To: <CAOLa=ZSPeKUyBZ2gJHByhg8QxTdwScfKGA6gdxREvyjZwL0hsw@mail.gmail.com>
X-Google-Sender-Auth: XHSLYcBiktT-g3bCjAtE91J4RyM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243400>

On Tue, Mar 4, 2014 at 12:58 PM, karthik nayak <karthik.188@gmail.com> wrote:
> Hey Tanay,
>
> 1. Yes just getting used to git send-email now, should follow that from now
> 2. I thought it shouldn't be a part of the commit, so i put it after
> the last ---
> 3. I did have a thought on your lines also , but concluded to it being
> more advantageous, you might be right though

Minor etiquette note: On this list, respond inline rather than top-posting.

To understand why, look at how much scrolling up and down a person has
to do to relate your points 1, 2, and 3 to review statements made by
Tanay at the very bottom of the email.

> Nice to hear from you.
> Thanks
> -Karthik Nayak
>
> On Tue, Mar 4, 2014 at 11:01 PM, Tanay Abhra <tanayabh@gmail.com> wrote:
>>
>> Karthik Nayak <karthik.188 <at> gmail.com> writes:
>>
>>>
>>> In record_author_date() :
>>> Replace "buf + strlen(author )" by skip_prefix(), which is
>>> saved in a new "const char" variable "indent_line".
>>>
>>> In parse_signed_commit() :
>>> Replace "line + gpg_sig_header_len" by skip_prefix(), which
>>> is saved in a new "const char" variable "indent_line".
>>>
>>> In parse_gpg_output() :
>>> Replace "buf + strlen(sigcheck_gpg_status[i].check + 1)" by
>>> skip_prefix(), which is saved in already available
>>> variable "found".
>>>
>>> Signed-off-by: Karthik Nayak <karthik.188 <at> gmail.com>
>>> ---
>>>  commit.c | 23 ++++++++++++-----------
>>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/commit.c b/commit.c
>>> index 6bf4fe0..71a03e3 100644
>>> --- a/commit.c
>>> +++ b/commit.c
>>
>>>  <at>  <at>  -1098,6 +1100,7  <at>  <at>  int parse_signed_commit(const
>> unsigned char *sha1,
>>>       char *buffer = read_sha1_file(sha1, &type, &size);
>>>       int in_signature, saw_signature = -1;
>>>       char *line, *tail;
>>> +     const char *indent_line;
>>>
>>>       if (!buffer || type != OBJ_COMMIT)
>>>               goto cleanup;
>>>  <at>  <at>  -1111,11 +1114,11  <at>  <at>  int parse_signed_commit(const
>> unsigned char *sha1,
>>>               char *next = memchr(line, '\n', tail - line);
>>>
>>>               next = next ? next + 1 : tail;
>>> +             indent_line = skip_prefix(line, gpg_sig_header);
>>>               if (in_signature && line[0] == ' ')
>>>                       sig = line + 1;
>>> -             else if (starts_with(line, gpg_sig_header) &&
>>> -                      line[gpg_sig_header_len] == ' ')
>>> -                     sig = line + gpg_sig_header_len + 1;
>>> +             else if (indent_line && indent_line[1] == ' ')
>>> +                     sig = indent_line + 2;
>>>               if (sig) {
>>>                       strbuf_add(signature, sig, next - sig);
>>>                       saw_signature = 1;
>>
>>
>> Hi,
>>
>> I was attempting the same microproject so I thought I would share some
>> points that were told to me earlier .The mail subject should have a
>> increasing order of submission numbers for each revision(for example here it
>> should be [PATCH v2]).
>>
>> Also write the superfluous stuff which you have written in the bottom
>> after ---(the three dashes after the signed off statement) .
>>
>> In the parse_signed_commit() function, gpg_sig_header_len and gpg_sig_header
>> variables are precomputed outside of the function, and also Junio said to
>> prefer starts_with(), whenever skip_prefix() advantages are not so important
>> in the context.So the replace may not be so advantageous ,I may be wrong in
>> this case.
>>
>>
>>
>> Cheers,
>> Tanay Abhra.
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
