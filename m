From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] i18n: mark OPTION_NUMBER (-NUM) for translation
Date: Wed, 6 Feb 2013 17:45:41 +0700
Message-ID: <CACsJy8DcXuFqjBtufQq1-0Vm3H4uxs03Crx+akY-kbrVgY8vUw@mail.gmail.com>
References: <20130205121552.GA16601@lanh> <883efc2358a0deb48bee48134d45ddd528a732d3.1360080194.git.worldhello.net@gmail.com>
 <8d6d4d869ea58e0a26b3bb6377fc102728948997.1360080194.git.worldhello.net@gmail.com>
 <7vd2weu1sq.fsf@alter.siamese.dyndns.org> <CANYiYbF1cS=K9M0cwE5V0pUJMPEYGiJOjJwg5KQScCf8pjyTqw@mail.gmail.com>
 <7vpq0enoui.fsf@alter.siamese.dyndns.org> <CANYiYbF8DCPxqGQ2AFFXpSm0nO+wFDg=qrn9C8uoZO6fj__NHA@mail.gmail.com>
 <7vip66njpj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:46:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U32WV-0006d3-VL
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 11:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab3BFKqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 05:46:14 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:50077 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab3BFKqN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 05:46:13 -0500
Received: by mail-ob0-f176.google.com with SMTP id v19so1266032obq.21
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 02:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5PxwOmgnNkwpwq+5LF62qCbtTrL7u1k3K//xwZ8EV4c=;
        b=GXdUowNNfIhwT8/sStYxb6wflx5Y+7wYbq9noSmpawKyX0k9rUzbDgWJECQi4opUD9
         K26lxNS1mei6HjxBMa/pkqPTQXJCcZlNCPp2UnFPbGFJoVxrjBBb81UKiIdAcXvcJpol
         MH9uKEgp1MyDqY5ZAHXUoSyYRhzBl/DLLOic+qK8KWD8PzJRCPMC6gB8X7ovEHHg30iS
         hh1JCo6BKcolPaVH6yIzepVHZpUl9TBPDhnc9POuGBADC1mHR0L8JiXHs6GRnzFGs+W2
         uBnjczMxCKzT4gMlmRD9mI2JJ2z3s+Lx/5szO9Ivtwy0T60cjdHMVcK/Dl1vYW7deVEM
         sjEA==
X-Received: by 10.60.31.6 with SMTP id w6mr21847365oeh.65.1360147573068; Wed,
 06 Feb 2013 02:46:13 -0800 (PST)
Received: by 10.182.129.46 with HTTP; Wed, 6 Feb 2013 02:45:41 -0800 (PST)
In-Reply-To: <7vip66njpj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215573>

On Wed, Feb 6, 2013 at 11:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> How about this since [PATCH v3]:
>>
>> diff --git a/utf8.c b/utf8.c
>> index 52dbd..b893a 100644
>> --- a/utf8.c
>> +++ b/utf8.c
>> @@ -443,8 +443,11 @@ int utf8_fprintf(FILE *stream, const char *format, ...)
>>         strbuf_vaddf(&buf, format, arg);
>>         va_end (arg);
>>
>> -       fputs(buf.buf, stream);
>> -       columns = utf8_strwidth(buf.buf);
>> +       columns = fputs(buf.buf, stream);
>> +       /* If no error occurs, and really write something (columns > 0),
>> +        * calculate really columns width with utf8_strwidth. */
>> +       if (columns > 0)
>> +               columns = utf8_strwidth(buf.buf);
>>         strbuf_release(&buf);
>>         return columns;
>>  }
>
> The above bugfix does not address my original concern about
> the name, though.

How about utf8_fwprintf? wprintf() deals with wide characters and
returns the number of wide characters, I think the name fits. And we
could just drop utf8_ and use the existing name, because we don't use
wchar_t* anyway.
-- 
Duy
