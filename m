From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] log -L: improve error message on malformed argument
Date: Thu, 16 Apr 2015 17:49:24 -0400
Message-ID: <CAPig+cRqJdi6skbszkwFFauqh4qWJDxMq5GdcFuKrJj9wtBvoQ@mail.gmail.com>
References: <1429195387-20573-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqpp73hhnm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 23:49:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yirf8-0008RD-DB
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 23:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbbDPVt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 17:49:26 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33804 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbbDPVtY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 17:49:24 -0400
Received: by iedfl3 with SMTP id fl3so70108475ied.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wWvz4S/PCqbQgmM4ZcD+CryTBMBq5a2w/OTZ+nT8/0E=;
        b=U6upG8Oz3XLWUMk0cQcren/mhttoGVl6J8Z6nBUmaBVBOIuglHLGltAvlDBuM8ThJN
         KkNRePd2JtwvkkQtqkdNHJEUAymm8acN5BhDHrWnOjBuKe2TTgLC+s5odE75Eyd6ylDL
         Wl8fciq6tUS9ZxQOGTIdESuBo72YSfxHrNJECsMQCqcrrTt5o3ZTiQF4qvjS4U1leD3U
         DHU0B7EoJCDtmEItaErUFR+iI6xx2zj1W8voJp6ptbzBuA0PodxUq+eBxmEjTBdIgVJO
         2V+yoUw0/lBbHUzHU7hQjFxcBo8Sjw+HquoqG1m9E0hCUY0Tcbwgx4zBx70f3fpVFFnH
         RitQ==
X-Received: by 10.42.171.8 with SMTP id h8mr240668icz.25.1429220964404; Thu,
 16 Apr 2015 14:49:24 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 16 Apr 2015 14:49:24 -0700 (PDT)
In-Reply-To: <xmqqpp73hhnm.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: tlbT3K0aZR44YBNc2MrxlatqxWE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267337>

On Thu, Apr 16, 2015 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> The old message did not mention the :regex:file form.
>>
>> To avoid overly long lines, split the message into two lines (in case
>> item->string is long, it will be the only part truncated in a narrow
>> terminal).
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>>  line-log.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/line-log.c b/line-log.c
>> index a490efe..e725248 100644
>> --- a/line-log.c
>> +++ b/line-log.c
>> @@ -575,7 +575,8 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
>>
>>               name_part = skip_range_arg(item->string);
>>               if (!name_part || *name_part != ':' || !name_part[1])
>> -                     die("-L argument '%s' not of the form start,end:file",
>> +                     die("invalid -L argument '%s'.\n"
>> +                         "It should be of the form start,end:file or :regex:file.",
>>                           item->string);
>>               range_part = xstrndup(item->string, name_part - item->string);
>>               name_part++;
>
> You forgot to update tests to match their expectations?  4211.20
> wants to see 'argument.*not of the form', it seems.

An alternate wording might be:

    "-L argument not 'start,end:file' or ':regex:file': %s"

This can still wrap onscreen but the important information (the two
forms accepted by -L) is at the head of the error message, and the
variable (user-supplied) bit is at the end after the colon, in typical
error message form.
