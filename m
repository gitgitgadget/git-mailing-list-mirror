From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] Makefile: do not compile git with debugging symbols by default
Date: Thu, 22 Jan 2015 22:53:21 +0600
Message-ID: <CANCZXo6qnfjaYLh8WN8xSocGQcoaX4UTjzFm1FhF6sg8vhng5A@mail.gmail.com>
References: <1421931037-21368-1-git-send-email-kuleshovmail@gmail.com>
	<20150122130036.GC19681@peff.net>
	<CANCZXo7ocgG27Y48NjYxurVMWOvHkvGqDrLuntkSTxHUK6hcNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 22 17:53:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEL0p-0003ue-Lu
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 17:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbbAVQxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 11:53:25 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:47509 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbbAVQxW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 11:53:22 -0500
Received: by mail-ob0-f182.google.com with SMTP id gq1so2433817obb.13
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 08:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mxNrY3x+J802f/M15BQcJ0I+uzhnxrIZFLba7ZuvM0w=;
        b=z6U75HQR0EYiro6t7tr4eKo62Rtfu8ybXZhP3bd89+Id8y5ktcmj1dEwL4uyLwkw+h
         Y9N30TZRugzxUiliBz56ZAQ8qdvFm7r20rhb3jDog1wg6+chTiTu1wKw4D2qlTz6PU7e
         48GmyguwfVywuEg3BLmYr5am21tA4XnW7eNvtTnF7UA+6JKh+w8wVkUT3n14V1IfVbeG
         84jqSPnuthPX3PmaZPgqpaoaweAGHnxVsTi+akvuPIN4kp3cMwE6jooFZGtP8KHWidpB
         3CdSHjUOzXaTFenb7a8+LP2lqKr6x0fC1/vienTNPpuSZW7KQDwppZh5v1LtSer4t/b3
         HvaQ==
X-Received: by 10.182.27.241 with SMTP id w17mr1556592obg.14.1421945601709;
 Thu, 22 Jan 2015 08:53:21 -0800 (PST)
Received: by 10.182.26.116 with HTTP; Thu, 22 Jan 2015 08:53:21 -0800 (PST)
In-Reply-To: <CANCZXo7ocgG27Y48NjYxurVMWOvHkvGqDrLuntkSTxHUK6hcNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262846>

Or even still -g as it now, because anyway debugging info will be
removed with stripping

2015-01-22 22:51 GMT+06:00 Alexander Kuleshov <kuleshovmail@gmail.com>:
> Hello Jeff,
>
> Yes, main point is size of executable. I'm sorry, didn't see 'strip' target.
>
> What if we will strip git and other executable files by default and
> add -g option and don't strip it if DEBUG=1 passed to make. Something
> like this:
>
> git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
>
>     $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) git.o \
>
>         $(BUILTIN_OBJS) $(LIBS)
>
> ifneq ($(DEBUG),1)
>
>     $(MAKE) strip
>
> endif
>
>
> Thank you.
>
> 2015-01-22 19:00 GMT+06:00 Jeff King <peff@peff.net>:
>> On Thu, Jan 22, 2015 at 06:50:37PM +0600, Alexander Kuleshov wrote:
>>
>>> Standard user has no need in debugging information. This patch adds
>>> DEBUG=1 option to compile git with debugging symbols and compile without
>>> it by default.
>>
>> This explanation is missing why it is beneficial _not_ to have the
>> debugging information.
>>
>> I expect the answer is "it makes the executable smaller". And that is
>> true, but it gets smaller still if you run "strip" on the result:
>>
>>   $ make CFLAGS= >/dev/null 2>&1 && wc -c <git
>>   2424248
>>
>>   $ make CFLAGS=-g >/dev/null 2>&1 && wc -c <git
>>   4500816
>>
>>   $ strip git && wc -c <git
>>   2109200
>>
>> So I am not sure who this is helping. If you are size-conscious, you
>> should use strip, in which case the "-g" flag does not matter (and we
>> even have "make strip" to help you).
>>
>> Is there some other reason to avoid the debugging information?
>>
>> -Peff
>
>
>
> --
> _________________________
> 0xAX



-- 
_________________________
0xAX
