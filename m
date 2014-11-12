From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Clean stale environment pointer in finish_command()
Date: Wed, 12 Nov 2014 08:17:12 -0800
Message-ID: <CAPc5daXRUFqjrZbTE968uP5tY9hF3EG0pMKwGW+YPRLBo5=ghQ@mail.gmail.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
 <cover.1415630072.git.johannes.schindelin@gmx.de> <df1b16208e443416f7185c8c8c110e637ea97ac4.1415630072.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.1411101539091.13845@s15462909.onlinehome-server.info>
 <20141111031636.GE21328@peff.net> <xmqqr3x97mv4.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1411121142480.13845@s15462909.onlinehome-server.info>
 <20141112105229.GA29101@peff.net> <20141112105911.GA31608@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 17:17:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xoaby-0002X2-Qf
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 17:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbaKLQRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 11:17:34 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:47943 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbaKLQRd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 11:17:33 -0500
Received: by mail-pa0-f41.google.com with SMTP id et14so2060124pad.0
        for <git@vger.kernel.org>; Wed, 12 Nov 2014 08:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1faGLHomxGuyyi9zRXTAv3SfKj25Iba+wMYcc/q7wyk=;
        b=tP+xMNk/eTG7qy2XFc1b9Ue7WIX20SfYyQcUzqARtC31PMq1ZzhRckF9eZNUSWaozV
         unB/+iGKBQ8CM/gqLMtn6jAPTmgFrtCA4CnThh0Q7y+N4LClw4LxfND2HtY/EXaDhuiQ
         kJn/n7Vn4HTmS/BwWnerC6sV3tJfMDttuQFOiu1NumMyRI2Ik4DnTgjBhd+MBmBzX10W
         ZPQpBj/5yyclRXAY1+z4OCsQNVY5HnkihN6Q8MfUcgpQNRH5EnVQZKYJRiuOGYo77M57
         Y5hT7NkGRT8+K+f3HpOnLM+nHtj2or0TnQfdUJPeTlKk6usTb7VPAXZNqS9NC3ApJ0rH
         yIvg==
X-Received: by 10.70.127.231 with SMTP id nj7mr48412820pdb.125.1415809053066;
 Wed, 12 Nov 2014 08:17:33 -0800 (PST)
Received: by 10.66.74.134 with HTTP; Wed, 12 Nov 2014 08:17:12 -0800 (PST)
In-Reply-To: <20141112105911.GA31608@peff.net>
X-Google-Sender-Auth: qIb_SOGg9U_-_XeAxLuEeI_44x4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 12, 2014 at 2:59 AM, Jeff King <peff@peff.net> wrote:
>>
>> I do not mind much either way. But I doubt that a single extra struct on
>> the stack will break the bank, compared to the fact that we are forking
>> and execing a new program. I'd also not be surprised if a smart compiler
>> could notice that the variables are used exclusively in non-overlapping
>> bits of the code, and just reuse the stack space.
>
> Actually, I take that back. We are passing a pointer to a struct, rather
> than by-value, so the compiler cannot know that the sub-function does
> not store that pointer in a static variable, and reference it in the
> next call. It must use two variables if it cannot see the definition of
> run_command.
>
> I still think it's pointless optimization to worry about, and you should
> write whichever is the most readable and maintainable.

Amen.  I do not have strong preference either way as long as the result
is readable, correct and maintainlable ;-).
