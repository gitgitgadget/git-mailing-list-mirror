From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4
Date: Wed, 21 Aug 2013 00:26:38 +0200
Message-ID: <CABPQNSZSXgvLw_i25em38B70EgtZrv9iQh8OaCJzYRCk2vjZXQ@mail.gmail.com>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com>
 <33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley> <166132E40AA54EE387BA9B4558823C55@PhilipOakley>
 <CABPQNSZidMv4MEW+SqVm94pX4szw9QW8LFWsvBTOXYH7ezzycw@mail.gmail.com> <87eh9op5gq.fsf@igel.home>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>,
	"Koch, Rick (Subcontractor)" <Rick.Koch@tbe.com>,
	Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Aug 21 00:27:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBuOa-0002mY-Sg
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 00:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab3HTW1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 18:27:20 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:39685 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab3HTW1U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 18:27:20 -0400
Received: by mail-oa0-f43.google.com with SMTP id i10so2083622oag.16
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=XlBBSRIeY5knKDJDXR6nEplfyJiTYcoL98czOa8dcJs=;
        b=gGMsvAjHGdpX2yrBBpEQ/ruB/s6Au4napdwFf6YW9QhdCtc98d3FZe1G5sHnNpWZFg
         bIDg5cfRdCVo7UJFjsH6i3b1037ZnMR3XlEWv3CjGFL+DSZ8cETc7BCI0xIKQlrnorJF
         lXfcO1vwapVU2i+2zaM85bkzFwZUdoefMOKtR+UJSJ4s7kBI9IH/VnTFMLTCR9dEudTN
         qtY0zWfC5uX6iGXboQdvdCGqYKaykKsAINN3fbmbohKmu78RsjSwstei1stww/HcELJW
         Sq5P1ulGqNz3KEH+mkaYtjhlwBPU9+7l9oaUCcLH0tTH+Xqfp1DfbEfeQdF1+J5vHsm3
         pVQQ==
X-Received: by 10.60.95.99 with SMTP id dj3mr3745230oeb.94.1377037638661; Tue,
 20 Aug 2013 15:27:18 -0700 (PDT)
Received: by 10.76.162.68 with HTTP; Tue, 20 Aug 2013 15:26:38 -0700 (PDT)
In-Reply-To: <87eh9op5gq.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232654>

On Tue, Aug 20, 2013 at 8:44 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
>> index d015e43..0641f4e 100644
>> --- a/compat/win32/syslog.c
>> +++ b/compat/win32/syslog.c
>> @@ -43,11 +43,14 @@ void syslog(int priority, const char *fmt, ...)
>>   va_end(ap);
>>
>>   while ((pos = strstr(str, "%1")) != NULL) {
>> - str = realloc(str, ++str_len + 1);
>> - if (!str) {
>> + char *tmp = realloc(str, ++str_len + 1);
>> + if (!tmp) {
>>   warning("realloc failed: '%s'", strerror(errno));
>> + free(str);
>>   return;
>>   }
>> + pos = tmp + (pos - str);
>
> Pedantically, this is undefined (uses of both pos and str may trap after
> realloc has freed the original pointer), it is better to calculate the
> difference before calling realloc.

I don't see how it's undefined. It's using the memory that 'pos'
*points to* that is undefined, no? The difference between 'pos' and
'str' should still be the same, it's not like realloc somehow
magically updates 'pos'...
