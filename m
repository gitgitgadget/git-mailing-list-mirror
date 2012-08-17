From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] contrib: add win32 credential-helper
Date: Thu, 16 Aug 2012 20:34:19 -0700
Message-ID: <7vtxw2w5s4.fsf@alter.siamese.dyndns.org>
References: <1343409006-5056-1-git-send-email-kusmabite@gmail.com>
 <CABPQNSZt0a+447qbr6j9ELHfsmfr03VUw6-efAiu0vLicaKyEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Aug 17 05:34:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2DKS-0004EA-D2
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 05:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030674Ab2HQDeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 23:34:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030672Ab2HQDeW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 23:34:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1223F8350;
	Thu, 16 Aug 2012 23:34:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I69OyU7hphFLfdtvM0s24w/k+GA=; b=KYKJbX
	3iulPzNh4Bzxu3GxsR3TEmz8EIl1HbC8n8gERTTMzlWnirfJbVnMTzg9x/+7P/bW
	1GYRePAocfX10c32aZYpAcJsqDIndask9Opg5LCVSf4SykJAfzpHHIJl/j5gNwp5
	Dr/aBPg1MlMZP2GrQv0Tf341aHEDVvS+KUEW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sMiVeZNlkHzuwIlIrNTgxP8iaj5BHPMF
	uTsRSzk+4ITsXBysxIUEBUTV/WVT6QwfPQTpxH9JTG35+ysj6fA53AkklRhT9Y/U
	2kxL2vhaez/rQkq2C5A7bQKAzARnAMWjEbUXaANKv4VIQ/nncIF8Ez3jGbMGo7so
	GUc0Qr/5E2U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F376C834F;
	Thu, 16 Aug 2012 23:34:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56682834E; Thu, 16 Aug 2012
 23:34:21 -0400 (EDT)
In-Reply-To: <CABPQNSZt0a+447qbr6j9ELHfsmfr03VUw6-efAiu0vLicaKyEg@mail.gmail.com> (Erik
 Faye-Lund's message of "Fri, 27 Jul 2012 19:32:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6ECF0CFA-E81C-11E1-88FE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Fri, Jul 27, 2012 at 7:10 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> Since the Windows port of Git expects binary pipes, we need to make
>> sure the helper-end also sets up binary pipes.
>>
>> Side-step CRLF-issue in test to make it pass.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>>
>> Sorry for the delay, but here's the third iteration of my credential
>> helper for Windows' credential API.
>>
>> The only change since v2 is that it now supports protocols without
>> a host component, as suggested by Jeff King.
>>
>
> ...aaand just as I sent it out, I realized that my Makefile was a bit
> on the light side. Imagine this patch on top for now, please :)
>
> diff --git a/contrib/credential/wincred/Makefile
> b/contrib/credential/wincred/Makefile
> index b4f098f..bad45ca 100644
> --- a/contrib/credential/wincred/Makefile
> +++ b/contrib/credential/wincred/Makefile
> @@ -4,5 +4,11 @@ CC = gcc
>  RM = rm -f
>  CFLAGS = -O2 -Wall
>
> +-include ../../../config.mak.autogen
> +-include ../../../config.mak
> +
>  git-credential-wincred.exe : git-credential-wincred.c
>  	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
> +
> +clean:
> +	$(RM) git-credential-wincred.exe

I notice that I didn't queue either of these; are you still
polishing them, or are they in good enough shape that it wouldn't
make things harder for you if I queue it, with a plan to merge it
soon after 1.7.12?
