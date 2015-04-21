From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Why does "git log -G<regex>" works with "regexp-ignore-case"
 but not with other regexp-related options?
Date: Tue, 21 Apr 2015 10:41:33 +0200
Message-ID: <55360D3D.3010201@drmicha.warpmail.net>
References: <1090496912.6338.1429264855691.JavaMail.open-xchange@ox1app>	<55311831.6010004@drmicha.warpmail.net>	<CAPc5daUULhhV0+kL_htLnA8Z_woFLjxg_pO_cB0KLAMuxJnsMQ@mail.gmail.com>	<5534BD87.8020709@drmicha.warpmail.net>	<xmqqbniin1cw.fsf@gitster.dls.corp.google.com>	<CA+55aFzdSgvYo11PHamkOVASz61RUq26+s0na0Zh2RRwsEkrMg@mail.gmail.com> <xmqqtwwaljwb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Tim Friske <me@tifr.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 10:41:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkTkX-0001PH-EO
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 10:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbbDUIlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 04:41:40 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46866 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751473AbbDUIlg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2015 04:41:36 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 455BB209DA
	for <git@vger.kernel.org>; Tue, 21 Apr 2015 04:41:35 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 21 Apr 2015 04:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=a7antrkXBsQOB6Nyio7aTi+n1BQ=; b=A5DwJ9
	ss99euAqU4Kd0LnmnUaTfC5mqoLxNcRrNs6uQMHSjKgcwfmZK2yr66ig/A5AE6XK
	/2TgJ94Qk73hZ4zx8cqTAzLfn9l+M3zXtjPcFKdtxXWUJvASI2ATI/k+HLh1aWyJ
	qsDi1iYQucqFMq3DyG5J6BNr6G8UeBrbOfg1k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=a7antrkXBsQOB6N
	yio7aTi+n1BQ=; b=XN1jy5ctbnhCt1OPaGQqgSJ4cds3utInUnsUbRGEYOLja/f
	YFoWNCLNQT3NQokijTdzr6wvs5LH6GAe6wf3ATYCu604NEgi3j2k7NOpco0y7Nt8
	3fvr3YxHjD3w0bss3LDInwr+qI9lZda5VSNSXEHxxw1/Y064a9Th2lbFTg2Y=
X-Sasl-enc: 5iBe2foqYtFFW+rWfKL4LNS7M4rQkB/hMzGMqC6l3d5X 1429605694
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7E94A680125;
	Tue, 21 Apr 2015 04:41:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqtwwaljwb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267521>

Junio C Hamano venit, vidit, dixit 20.04.2015 20:44:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> And to clarify: I don't suggest always building with libpcre. I
>> literally suggest having something like
>>
>>      /* hacky mac-hack hack */
>>     if (strncmp("(?i)", p->pattern, 4)) {
>>         p->pattern += 4;
>>         p->ignore_case = true;
>>     }
>>
>> just in front of the "regcomp() call, and nothing more fancy than that.
> 
> Yeah, looking at the way grep.c:compile_regexp() is structured, we
> are already prepared to allow
> 
>     $ git log --grep='(?i)torvalds' --grep='Linus'
> 
> that wants to find one piece of text case insensitively while
> another case sensitively in the same text (i.e. the log message
> part), so per-pattern customization may be a good way to do this.
> 

And '(?f)foo' switches to fixed strings ;)

We have engine-switching options and engine-modification options. The
latter are certainly good in the expression itself. Maybe even the
former, though I don't know how to switch away from fixed-strings in
that way...

I had forgotten about pcre. Maybe switching options independently is so
unusual that "use pcre" is good enough as a solution to suggest to those
few users?

In any case, that leaves us with:

- resolve the existing inconsistencies around --regexp-ignore-case
- allow to switch the engine for all greppy operations

Maybe have all command line options apply to all greppy ops as a first
step, which allows pcre and thus '(?i)' for all fields?

Michael
