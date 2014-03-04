From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] [PATCH] commit.c: Replace starts_with() with skip_prefix()
Date: Tue, 4 Mar 2014 23:28:07 +0530
Message-ID: <CAOLa=ZSPeKUyBZ2gJHByhg8QxTdwScfKGA6gdxREvyjZwL0hsw@mail.gmail.com>
References: <1393948445-24689-1-git-send-email-karthik.188@gmail.com> <loom.20140304T182823-503@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 18:58:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKtbt-0002Ih-5A
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 18:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbaCDR62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 12:58:28 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:34503 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbaCDR61 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 12:58:27 -0500
Received: by mail-pb0-f42.google.com with SMTP id rr13so5533476pbb.29
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 09:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dioUTWLyqXX3spTZIsFrJa5EgPXmShB1kV+8pY5xjUY=;
        b=yjwh3Jmd1bIvGJuLRGfcrC5UoHhyBv/pCBMsKlJe7tVX2JdSLmT+lxIQa+BECIdpil
         34B+96lOlv1n67vkj5Wol8wcMVNUwyMnVB/p++6WTIQNJ5jJdEAi0byGw5e3Tf+bs0hv
         kqjGHPJb18b8Kt7jVDA0AjDpL6ZM4hhK/yojsiDhIK53XiICBezVcyyg1e1WkVbnZvUL
         vNCqEUv7GlUbqnOHKv54xZeIOEHsm99RCMsa70IOJ1C2DtT0l5uygaA9BxqkI8hoPmcy
         6L45+gHgNf3SCUDtPgfHYJKYQXTd+4B7GisjwkFfslpXpi74509Z6WFkMw+iQv7D3VEu
         Ac0w==
X-Received: by 10.66.4.130 with SMTP id k2mr893480pak.97.1393955907447; Tue,
 04 Mar 2014 09:58:27 -0800 (PST)
Received: by 10.68.138.138 with HTTP; Tue, 4 Mar 2014 09:58:07 -0800 (PST)
In-Reply-To: <loom.20140304T182823-503@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243363>

Hey Tanay,

1. Yes just getting used to git send-email now, should follow that from now
2. I thought it shouldn't be a part of the commit, so i put it after
the last ---
3. I did have a thought on your lines also , but concluded to it being
more advantageous, you might be right though

Nice to hear from you.
Thanks
-Karthik Nayak

On Tue, Mar 4, 2014 at 11:01 PM, Tanay Abhra <tanayabh@gmail.com> wrote:
>
> Karthik Nayak <karthik.188 <at> gmail.com> writes:
>
>>
>> In record_author_date() :
>> Replace "buf + strlen(author )" by skip_prefix(), which is
>> saved in a new "const char" variable "indent_line".
>>
>> In parse_signed_commit() :
>> Replace "line + gpg_sig_header_len" by skip_prefix(), which
>> is saved in a new "const char" variable "indent_line".
>>
>> In parse_gpg_output() :
>> Replace "buf + strlen(sigcheck_gpg_status[i].check + 1)" by
>> skip_prefix(), which is saved in already available
>> variable "found".
>>
>> Signed-off-by: Karthik Nayak <karthik.188 <at> gmail.com>
>> ---
>>  commit.c | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/commit.c b/commit.c
>> index 6bf4fe0..71a03e3 100644
>> --- a/commit.c
>> +++ b/commit.c
>
>>  <at>  <at>  -1098,6 +1100,7  <at>  <at>  int parse_signed_commit(const
> unsigned char *sha1,
>>       char *buffer = read_sha1_file(sha1, &type, &size);
>>       int in_signature, saw_signature = -1;
>>       char *line, *tail;
>> +     const char *indent_line;
>>
>>       if (!buffer || type != OBJ_COMMIT)
>>               goto cleanup;
>>  <at>  <at>  -1111,11 +1114,11  <at>  <at>  int parse_signed_commit(const
> unsigned char *sha1,
>>               char *next = memchr(line, '\n', tail - line);
>>
>>               next = next ? next + 1 : tail;
>> +             indent_line = skip_prefix(line, gpg_sig_header);
>>               if (in_signature && line[0] == ' ')
>>                       sig = line + 1;
>> -             else if (starts_with(line, gpg_sig_header) &&
>> -                      line[gpg_sig_header_len] == ' ')
>> -                     sig = line + gpg_sig_header_len + 1;
>> +             else if (indent_line && indent_line[1] == ' ')
>> +                     sig = indent_line + 2;
>>               if (sig) {
>>                       strbuf_add(signature, sig, next - sig);
>>                       saw_signature = 1;
>
>
> Hi,
>
> I was attempting the same microproject so I thought I would share some
> points that were told to me earlier .The mail subject should have a
> increasing order of submission numbers for each revision(for example here it
> should be [PATCH v2]).
>
> Also write the superfluous stuff which you have written in the bottom
> after ---(the three dashes after the signed off statement) .
>
> In the parse_signed_commit() function, gpg_sig_header_len and gpg_sig_header
> variables are precomputed outside of the function, and also Junio said to
> prefer starts_with(), whenever skip_prefix() advantages are not so important
> in the context.So the replace may not be so advantageous ,I may be wrong in
> this case.
>
>
>
> Cheers,
> Tanay Abhra.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
