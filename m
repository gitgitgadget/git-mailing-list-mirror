From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Thu, 29 Mar 2012 13:16:47 +0200
Message-ID: <CAH6sp9Pw75x6YrmEyLmbsbvHrbs8r6xSp3YC2NP-jOed-zZ3+g@mail.gmail.com>
References: <20120327175933.GA1716@sigill.intra.peff.net>
	<20120327180503.GB4659@sigill.intra.peff.net>
	<7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
	<20120328043058.GD30251@sigill.intra.peff.net>
	<7vaa30wrjx.fsf@alter.siamese.dyndns.org>
	<20120328174841.GA27876@sigill.intra.peff.net>
	<7v62dowpdu.fsf@alter.siamese.dyndns.org>
	<20120328194045.GC29019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 13:24:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDDT8-0005b6-PH
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 13:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759108Ab2C2LYj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 07:24:39 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:49361 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab2C2LYh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 07:24:37 -0400
Received: by qcqw6 with SMTP id w6so1294285qcq.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 04:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kWcTLTKUyl0T6j2FmIm/RyCdwZ8qi07q27YR0x/fOMI=;
        b=so0wZpZBbe17ltlg9c+PI+U55fpdCp6JlYIiTuA8X5v8bt1jGaeJBgsUS4Tec3+lJj
         GpsTh40rZPEbrrIhKw0OQTyX/C/SFwWD0xxfvDwblsb2JtwU00sYw9Y5jQiZ8ezhjaY3
         isBqc+gmCMZISq2avB7tI2TRmvu8dDlPsnUwI9QQktZKMBPbgbul++ajwgGZyVN+IspL
         PuKfJ15g4hFF8JZnGNlxdzQtCog/wA+cl7LGW6mcUhPZ9M0aNhV3eVDbNgIQ1ry9DcP9
         i37Dl/JaA5VPc1cFOuVPageOSt4j2LSDsQVBZzH+Fjr8wy00eLAiiV/xj9ClsRytyPhR
         TkEw==
Received: by 10.229.106.227 with SMTP id y35mr4997259qco.23.1333019807498;
 Thu, 29 Mar 2012 04:16:47 -0700 (PDT)
Received: by 10.224.32.19 with HTTP; Thu, 29 Mar 2012 04:16:47 -0700 (PDT)
In-Reply-To: <20120328194045.GC29019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194247>

Hi,

On Wed, Mar 28, 2012 at 9:40 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 28, 2012 at 11:29:17AM -0700, Junio C Hamano wrote:
>
>> > That sounds sensible to me. I think it involves writing our own
>> > execvp, though, right? If we use stock execvp, we can't tell the
>> > difference between the two cases.
>>
>> The stock exec*p() will not hit "/bin/ls" in either case, so we will=
 give
>> "'ls' is not a git command", without having to differenciate it. =C2=
=A0That is
>> what I meant by "we follow the usual rule to ignore it".
>>
>> We already have the code necessary to enumerate the possible command=
s from
>> components of the PATH in order to give suggestion, so we can run it
>> after seeing exec*p() failure to see if we did not see any "ls", or =
we saw
>> "ls" but it was not executable. =C2=A0No need to penalize the normal=
 case, no?
>
> Yes, we can differentiate after the fact. Though I think it ends up
> being almost the same code as just implementing execvp in the first
> place.

It will, but doesn't stock execv*() also provide access to shell
builtins? If that's the case then I wouldn't be bothered by the extra
bit of code we need to understand what execvp has been doing. I think
it would be sane to keep sane_execvp a wrapper instead of a
reimplementation.
