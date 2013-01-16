From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 18:12:57 +0100
Message-ID: <CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
References: <1358348003-11130-1-git-send-email-max@quendi.de>
	<20130116160410.GC22400@sigill.intra.peff.net>
	<7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:13:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvWYH-0003UZ-G5
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 18:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756988Ab3APRNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 12:13:00 -0500
Received: from mail-qc0-f169.google.com ([209.85.216.169]:49461 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756968Ab3APRM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 12:12:58 -0500
Received: by mail-qc0-f169.google.com with SMTP id t2so1039306qcq.14
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 09:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=YcD2FaB7WOwvtHeBwSJna3zVBluezptfJpcVK59mEmo=;
        b=frWO+4UhgaNXTavonvPsUlIIQh/sldanRHumlhWShpv2Ljq53oEMVTlE8Z789JRe4c
         vmnNduYQfdo31sS+5xiNXAr7uJ8v7W+HWUp82mm8yNhX/WJtxd2uSCbTMOSV6tTOKGSA
         4FU67feoR3H3IQTzT7ydCbSHoaRwc//DJMkwGfnx5AsRL3ILZ7ZHMaMVNGz0JPbtxqId
         k3IVYcNLISBKyTw+rBhdmVdGjap8cenvdDCOCidZotMi8z+PtFyFgdPiCclCM3MKyyxD
         tLuJsX5PzbhX8c6WQdCIwmbaD3kqRz/UtomvT5j+tEVt09NGIfghpveE0NmLRdbsPjMC
         rMZA==
X-Received: by 10.224.86.136 with SMTP id s8mr2452939qal.72.1358356377783;
 Wed, 16 Jan 2013 09:12:57 -0800 (PST)
Received: by 10.49.11.233 with HTTP; Wed, 16 Jan 2013 09:12:57 -0800 (PST)
In-Reply-To: <7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213773>

FWIW, I also happen to have the warning:

advice.c:69:2: warning: expression result unused [-Wunused-value]
        error("'%s' is not possible because you have unmerged files.", me);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./git-compat-util.h:314:55: note: expanded from:
#define error(fmt, ...) (error((fmt), ##__VA_ARGS__), -1)
                                                      ^~

with clang: Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final)
(based on LLVM 3.0)

I can't say about other versions.

On Wed, Jan 16, 2013 at 5:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Wed, Jan 16, 2013 at 03:53:23PM +0100, Max Horn wrote:
>>
>>> -#ifdef __GNUC__
>>> +#if defined(__GNUC__) && ! defined(__clang__)
>>>  #define config_error_nonbool(s) (config_error_nonbool(s), -1)
>>>  #endif
>>
>> You don't say what the warning is, but I'm guessing it's complaining
>> about throwing away the return value from config_error_nonbool?
>
> Yeah, I was wondering about the same thing.  The other one looks
> similar, ignoring the return value of error().
>
> Also, is this "some versions of clang do not like this"?  Or are all
> versions of clang affected?
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
