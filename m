From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Tue, 30 Jun 2015 12:23:08 -0700
Message-ID: <xmqqbnfxc86b.fsf@gitster.dls.corp.google.com>
References: <20150625165341.GA21949@peff.net>
	<20150625165545.GC23503@peff.net> <20150629222247.GA31607@flurp.local>
	<20150630102055.GA11928@peff.net>
	<xmqq381988ud.fsf@gitster.dls.corp.google.com>
	<20150630175011.GA5349@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 21:23:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA17l-00015H-MF
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 21:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbbF3TXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 15:23:13 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36781 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbbF3TXK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 15:23:10 -0400
Received: by igrv9 with SMTP id v9so58745465igr.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 12:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=e9XIEJN+vnD/Qf/q+CiTw+I4i5kVcZYIhItksCCvnpc=;
        b=AiUkkShnNLP8bV9viV6k8XHlZGg8NZa15IOPSpzKDB8DSAdWDghRh3oNJfm+xAWv8q
         IyyriHZDJ4EFobtMXl/gSHyPCcaiWZ+VBxMmSt6+kyT57M+aNKoreN040SrIU2D/MfSb
         I5afpAIB8nB+nQCfBUld0iTlhzv2jM8LYSZ9B9l8c+wbCzVaXklbcFm+ucxKU5YgB61x
         3u/o72t33UqHIL6Yjj+0+Og/HcY1pOQiKU277pvTkHG9iwqxqxXDQGPHcH6GyBA7VPqI
         iGMc52Ap/y+/cEZ2dIky/Os51mH4jorl+iwywBcaBTk5sQlqChP218UnVMlL9429ymSU
         DFzQ==
X-Received: by 10.43.45.130 with SMTP id uk2mr28377675icb.38.1435692189732;
        Tue, 30 Jun 2015 12:23:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id j20sm8388654igt.5.2015.06.30.12.23.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 12:23:09 -0700 (PDT)
In-Reply-To: <20150630175011.GA5349@peff.net> (Jeff King's message of "Tue, 30
	Jun 2015 13:50:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273099>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 30, 2015 at 09:22:18AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> 	strbuf_addf(&f, "%s ", fmt);
>> >
>> > Basically I was trying to avoid making any assumptions about exactly how
>> > strftime works. But presumably "stick a space in the format" is a
>> > universally reasonable thing to do. It's a hack, but it's contained to
>> > the function.
>> 
>> Why can't I shake this feeling that (" %s", fmt), i.e. prepend not
>> append, is the safer thing to do than to append?
>
> Because then removing the extra space involves `memmove` of the buffer,
> rather than just shortening the length by one.

That does not explain why I feel the other way is safer, though ;-)

In any case, responding myself to my other question, strftime(3)
does not define any useful error information even for a case where
you feed nonsense format to it, so it is even not possible to
protect ourselves by checking errno or doing something similar X-<.
