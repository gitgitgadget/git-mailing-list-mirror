From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 01/41] usage.c: move format processing out of die_errno()
Date: Tue, 3 May 2016 16:39:45 +0700
Message-ID: <CACsJy8DS5-dL8p8iMQs5B1++GaXNQWwdxUeaMCeZ12OoQcPO7Q@mail.gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462101297-8610-2-git-send-email-pclouds@gmail.com> <CAPig+cQhQ2C-gOuQwJ9RBXM7HBBJkWORfRkq-t-PY=vvxgAonA@mail.gmail.com>
 <xmqqlh3stiyt.fsf@gitster.mtv.corp.google.com> <20160503044528.GA32259@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 03 11:40:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axWoZ-0004xh-TL
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 11:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbcECJkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 05:40:18 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33909 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbcECJkR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 05:40:17 -0400
Received: by mail-lf0-f67.google.com with SMTP id m101so1353353lfi.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NnyRLbyKXrrH1j+u6HMz9Qo/Fb9PWmqmDCsaI6bCLt0=;
        b=CoAllej8bcXg3Etxc9oFlVb3qICbR/cLevB2zu5J9cnBLpEYtlMqoGDAjU8qXdhSDW
         x+6ltjFx/bRUPPvQfyMUz1s3V9ua7dt64pmooHFICOUZ6s6MpZgyi9MinKusa7ilNkgL
         JcbSjkvyGgHkaeyA2UOdzhK6x48B3yqQxuMjmeKV7lTGQCO00CwNhsHKT7qsazQ4J5mx
         WUemfWH0imt3t/W4hp/cU9LO4bDoVoAbYaLMSdutrH5pOlGJkUrebWM/XmDM1yMbLa9j
         nlbgAynhowMxcRf3NW156M21r2cI6rkNyHLK5LsvsDVKmQx4DZbfmfUoShJg20TAk3U8
         /xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NnyRLbyKXrrH1j+u6HMz9Qo/Fb9PWmqmDCsaI6bCLt0=;
        b=ImFPyp4myE8gc6/ltv1n0KP3DyzwYV6lTWKCijghdSCQ73HmpU46DnYy3gbZInPn23
         crQDjqDee7EEDnxVLSi9+opOdYphVLBbrManlSHzU1ZnY5O6U1izK5OV6TStMH/AWWPJ
         iCZDVAXxv/vYq5lLSM6eI84ESQUSsw4atYBg/XvPhvLxRfidSdgKbyokAv5ZRSaW+YYT
         +p1bVdj9u3vMHvMpf7lt2sOMHSBrJGHnG0Eg843Lih55Q8o6X7pA/6pyA2MvStXKciS6
         40rYYMBamqg4onVI5GIw+CdK71ySDBtlrGKjdz7Udicn+5+X+8R/obJtRPdvL999hSUW
         Gk5w==
X-Gm-Message-State: AOPr4FU/MvnmZIQyTfT4uKwVHSLqsYIsC6USZRQQTGEt7mthOyvmXqi1v8/KhqUsv1/tcBm9OZxC2zq+vsYxfg==
X-Received: by 10.25.211.75 with SMTP id k72mr745324lfg.45.1462268415191; Tue,
 03 May 2016 02:40:15 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 3 May 2016 02:39:45 -0700 (PDT)
In-Reply-To: <20160503044528.GA32259@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293350>

On Tue, May 3, 2016 at 11:45 AM, Jeff King <peff@peff.net> wrote:
> On Mon, May 02, 2016 at 11:26:02AM -0700, Junio C Hamano wrote:
>
>> Caller supplied buffer would be the way to go when multiple threads
>> could be showing errors and warnings, right?
>>
>> It would not make too much of a difference for die(), though.
>
> I think it can matter for die(). This is happening above the pluggable
> die_routine() layer, so it's possible for an async task to call die()
> which will end in pthread_exit(), while the main program is calling
> die() to end in regular exit().
>
> I imagine it's exceedingly unlikely, and of course both threads are
> dying anyway, but it could result in some pretty weird memory errors.
> It's probably worth taking precautions against, especially because it's
> to easy to do so.

So, sum it up, the new fmt_with_err() will take a buffer and size.
die_errno() sticks to its static buffer as before. error_errno() and
warning_errno() can allocate 1k on stack to be more
multithread-friendly. Let me know if some other change is needed.
-- 
Duy
