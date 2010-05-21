From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Need to change old commit (and regenerate tree)
Date: Fri, 21 May 2010 07:31:47 +0200
Message-ID: <AANLkTinzl_sc9G1PUtLczEjHFdpRqMFuKkEiQTUXaEgQ@mail.gmail.com>
References: <AANLkTilTAknKPFv5AZBrwsITPsRlVSnsuX8TDXlUTWmw@mail.gmail.com>
	 <m2sk5mtecw.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antriksh Pany <antriksh.pany@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri May 21 07:31:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFKpv-0001Z5-C1
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 07:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab0EUFbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 01:31:50 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43364 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab0EUFbs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 01:31:48 -0400
Received: by wyg36 with SMTP id 36so406760wyg.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 22:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=krUorGH4USWG0zAp6DZ6N5TwRZKwnEWIOQQljBDz+3I=;
        b=DfZECUwYnsqgasmaf9zOiCo82vnvgOwhpgAFo5YW9YxJStLau0FMwn+CDq7mU8Xksl
         jw3M8+c1fRknIwGmLkS/NRbpkU2jx+eVOtGxj3sLrf/hct/I3eNl4iZKjX1rqGoXSWZV
         L0FNvAJC15I2qfTRCxuZpJuXlRtxfoXlrQJeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=Drff4xqD58GHWsQcjdQEcJeffooYBrF4pKt6UhFGHlovmp0Ks7tLRdJJYGPVktHsV/
         1niK6GYmDDAv0L1WMgnJ0aKPIh9I1UdYmk0uPWTAVQLPUDfxzjXNWC1YERegwBdQdVzG
         PD5wGKSFnRC8oc3TbbBL1/LDdVyR8CypEIUcg=
Received: by 10.216.156.193 with SMTP id m43mr489220wek.11.1274419907534; Thu, 
	20 May 2010 22:31:47 -0700 (PDT)
Received: by 10.216.55.202 with HTTP; Thu, 20 May 2010 22:31:47 -0700 (PDT)
In-Reply-To: <m2sk5mtecw.fsf@igel.home>
X-Google-Sender-Auth: r9cnLsT7nyMv9kWUUK0NEln1TgI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147440>

On Fri, May 21, 2010 at 00:09, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Antriksh Pany <antriksh.pany@gmail.com> writes:
>
>> Instead of (what I initially expected):
>>
>> A--------o--------o--------o--------o(old B)--------o--------o--------o(old C)
>>
>> A2--------o--------o--------o--------B--------o--------o--------C
>>
>>
>> So what I am missing here? Aren't the new commits B~1, B~2, B~3
>> identical to C~4, C~5, C~6 (respectively) in all ways so as to have
>> gotten them the same SHA1 and hence appear as what I expected them to
>> appear?
>
> No, they have a different commit time, which is also part of the hash.

Indeed.

To avoid this, you have to:
  - rebase B on top of A2 first,

        git rebase --onto A2 A B

  - rebase of C on top of the new B.

        git rebase --onto B B_old C
       ("git rebase --onto B A C" should work too, as usually git is
smart enough to see
        that A-B_old is already applied. Use "git rebase --skip" if it isn't)

If A is an ancestor of A2, you can simplify to:

    git rebase A2 B
    git rebase B C

(Disclaimer: the examples without --onto I use almost daily, the ones
with I don't)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
