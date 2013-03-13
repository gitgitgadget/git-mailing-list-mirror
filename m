From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 04/13] match_basename: use strncmp instead of strcmp
Date: Wed, 13 Mar 2013 08:05:58 +0700
Message-ID: <CACsJy8An08kFz4iCa-0U8Q30jUNqKzfZHK_jNdXOtnzqqRJEdg@mail.gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1363093500-16796-1-git-send-email-pclouds@gmail.com> <1363093500-16796-5-git-send-email-pclouds@gmail.com>
 <CALWbr2w71DsORxsFBBj4N2wzYQomjvCqxGfovbTDjGAT9eASyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 02:06:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFa9g-0006fd-8v
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 02:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719Ab3CMBG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 21:06:29 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:65022 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932676Ab3CMBG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 21:06:28 -0400
Received: by mail-oa0-f46.google.com with SMTP id k1so531099oag.33
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 18:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=CEagvJOznp0ffeeYF2+pQtT8jdlJQRXMGCWQgKTxKy4=;
        b=abeMpCfRKe418OfrmntZX3FKI2oizxCmtqTOyEDEn4B4M5FoEu+czD939IwQHguLLg
         k7bfck8P3bRpulf3RUon7KMsY0fuocweT+Qfe03PkYdeQduPTfaBcF/Oqc90EZApsezV
         JFPYLsfV6H7rHwHQIQmMiSKukcqrw5mMj/dB6WjVdcGIZnhxegR1NRbm0tRIz8CS9ZV0
         THrapfOSwlZ90q8M1Ni0I883MUNS6ugDI/pJfotlQxco3Gf0y+SitEaZGd5qZDPcR7kW
         NkR9Zx2/LXPGLB3lfXbxEH8f2u5eJcZx5pXpdPJOg30GiC61W77lC4u3gjEqBOdL5IbC
         zhmg==
X-Received: by 10.60.25.65 with SMTP id a1mr14060947oeg.40.1363136788507; Tue,
 12 Mar 2013 18:06:28 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Tue, 12 Mar 2013 18:05:58 -0700 (PDT)
In-Reply-To: <CALWbr2w71DsORxsFBBj4N2wzYQomjvCqxGfovbTDjGAT9eASyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218018>

On Wed, Mar 13, 2013 at 12:40 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -636,12 +636,14 @@ int match_basename(const char *basename, int basenamelen,
>>                    int flags)
>>  {
>>         if (prefix == patternlen) {
>> -               if (!strcmp_icase(pattern, basename))
>> +               if (patternlen == basenamelen &&
>> +                   !strncmp_icase(pattern, basename, patternlen))
>>                         return 1;
>>         } else if (flags & EXC_FLAG_ENDSWITH) {
>>                 if (patternlen - 1 <= basenamelen &&
>> -                   !strcmp_icase(pattern + 1,
>> -                                 basename + basenamelen - patternlen + 1))
>> +                   !strncmp_icase(pattern + 1,
>> +                                  basename + basenamelen - patternlen + 1,
>> +                                  patternlen - 1))
>>                         return 1;
>
>
> I can see that you kept strncmp(), was it worse with memcmp() ?

One step at a time. 05/13 replace strncmp_icase with memcmp (for when
ignore_case == 0).
-- 
Duy
