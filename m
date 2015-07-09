From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] clone: Simplify string handling in guess_dir_name()
Date: Thu, 9 Jul 2015 20:16:42 +0200
Message-ID: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
References: <CAHGBnuPkia6UYeN4jekfGzypV2MpyiMs2W+O=SSJR3hR=K3g0A@mail.gmail.com>
	<0000014e73d7c3d8-413991dd-3907-430c-ab99-a0a3d93dcab0-000000@eu-west-1.amazonses.com>
	<xmqq1tghw6jz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 20:16:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDGNM-0000y1-6T
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 20:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbbGISQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 14:16:44 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34117 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbbGISQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 14:16:42 -0400
Received: by iebmu5 with SMTP id mu5so181518045ieb.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 11:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ktsBQinSQR9ejn1FsjsRL8Nq5W/Zo/KavmOzGHJfHIk=;
        b=DI+a5TdnWrValkqpKPgbib/wdpcym7CIleEt/QFHouWMFhS6hBApNOJXjkPKmuUt3X
         muDNvYtiELE7qvs3dfP1bQhP+Tnrqx2zDOTb44InxzRqF2B/6JIX0HQLlyEf4V1uC1gT
         FalYeZkawZvTM7advd7ZVSxDlJxl2wROJSCjZpdz/0wJU73povyrO3FGW/ZqH2X7lGNr
         q5DMQuTJqT3grJG6fbBp3Dy1rjdmhoh9KhOMIOZWTk6RkPxVZPacZo54iv/FHUbiXuSM
         7bnP7LPQtTxZQT95KI9aueKWntGvcmyvrquTkWaW5p1If8e8dvgHoBfOiPE6zBKRXJW8
         2WCw==
X-Received: by 10.50.43.227 with SMTP id z3mr70216554igl.12.1436465802369;
 Thu, 09 Jul 2015 11:16:42 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Thu, 9 Jul 2015 11:16:42 -0700 (PDT)
In-Reply-To: <xmqq1tghw6jz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273768>

On Thu, Jul 9, 2015 at 8:05 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> Subject: Re: [PATCH v2] clone: Simplify string handling in guess_dir_name()
>
> We seem not to capitalize the first word on the subject line.

Will change that.

>> Content-Type: multipart/mixed;  boundary="----=_Part_8_836493213.1436462597065"
>
> Please don't.

This seems to come from submitgit, I've filed an issue about it:

https://github.com/rtyley/submitgit/issues/17

What content type(s) would you accept? Only text/plain?

>> -     if (is_bare) {
>> -             struct strbuf result = STRBUF_INIT;
>> -             strbuf_addf(&result, "%.*s.git", (int)(end - start), start);
>> -             dir = strbuf_detach(&result, NULL);
>> -     } else
>> -             dir = xstrndup(start, end - start);
>> +     dir = is_bare ? xstrfmt("%.*s.git", (int)len, start) : xstrndup(start, len);
>
> This however I had to read twice.  I'd say
>
>         if (is_bare)
>                 dir = xstrfmt(...);
>         else
>                 dir = xstrndup(...);
>
> is much easier to read.

That's what I had locally before. Will revert to that.

-- 
Sebastian Schuberth
