From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH] Make NO_PTHREADS the sole thread configuration variable
Date: Sat, 30 Jan 2010 20:01:02 -0600
Message-ID: <449c10961001301801u46652804n507fe8a479ce66ce@mail.gmail.com>
References: <1264814539-27209-1-git-send-email-dpmcgee@gmail.com>
	 <7vwryzqyjb.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1001302015120.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Jan 31 03:01:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbP81-00072R-O9
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 03:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656Ab0AaCBK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2010 21:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754654Ab0AaCBH
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 21:01:07 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:46512 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645Ab0AaCBE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2010 21:01:04 -0500
Received: by pxi12 with SMTP id 12so2963352pxi.33
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 18:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=elb8xhVYWm0gImPGEhwBecF+LRfIe7Qjh8iakKSl/IU=;
        b=Hybk7fr7weGX3/7fOnoGxsFOY2l9jE6GX1oMkk+f3q0JWkq6DlAD4pI/nrLXNRqpAB
         9Z8L9RYeF1H1pdM5uu2XpI23DoTklpCJmHzYPnxXEqdA4hrm391EIS+gEM0NnYawr2Y0
         tPeMEfiHtE4F1f4MJ1IvYm0Ja6pIOQp94PphE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kwuW30QPXk5RDwWNqiT8ZSwGpBIMILW3GRThTEfYmLdGMe5tb5Ng04Z0JJ+K2LPwOh
         NMX9lP8qtpvPPyIBFBbeS36/UUhpHlq/UTb+HgkRqr2JKvmVDASva25+c1eZoRKHMaM4
         BmoibP20P5TtsjlqfqjbmnsayFkt2yDWU2VCU=
Received: by 10.115.99.7 with SMTP id b7mr1876608wam.76.1264903262582; Sat, 30 
	Jan 2010 18:01:02 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001302015120.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138526>

On Sat, Jan 30, 2010 at 7:29 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Sat, 30 Jan 2010, Junio C Hamano wrote:
>
>> Dan McGee <dpmcgee@gmail.com> writes:
>>
>> > When the first piece of threaded code was introduced in commit 8ec=
ce684, it
>> > came with its own THREADED_DELTA_SEARCH Makefile option. Since thi=
s time,
>> > more threaded code has come into the codebase and a NO_PTHREADS op=
tion has
>> > also been added. Get rid of the original option as the newer, more=
 generic
>> > option covers everything we need.
>>
>> The patch is a good change but only in the "if it were like this fro=
m day
>> one, things would have been much simpler" sense. =C2=A0It is a break=
age to
>> existing users with customized THREADED_DELTA_SEARCH in their config=
=2Emak
>> files, isn't it?
>
> I think that the release of v1.7.0 is the perfect match for such a
> "breakage". =C2=A0Unlike for the dashless move, I really doubt the ma=
jority
> of Git users are using a customized THREADED_DELTA_SEARCH in a
> config.mak if they do build Git themselves at all. =C2=A0So very few =
people
> are likely to be inconvenienced, and yet the inconvenience can hardly=
 be
> qualified as a breakage since nothing will stop working in any case.
>
>> If we take only the part of your patch that applies to Makefile, but
>> exclude the first hunk (description of THREADED_DELTA_SEARCH) and th=
e last
>> hunk (the necessary part to keep THREADED_DELTA_SEARCH working), and
>> instead add something like:
>>
>> =C2=A0 =C2=A0 =C2=A0 ifndef NO_PTHREADS
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 THREADED_DELTA_SEAR=
CH =3D YesPlease
>> =C2=A0 =C2=A0 =C2=A0 endif
>>
>> immediately before we include config.mak, would that be a workable
>> solution to:
>>
>> =C2=A0(1) keep existing users happy;
>>
>> =C2=A0(2) remove the redundant logic to compute the default for two =
Make
>> =C2=A0 =C2=A0 =C2=A0variables; and
>>
>> =C2=A0(3) keep control over use of threading in general _and_ use of
>> =C2=A0 =C2=A0 =C2=A0threading in delta computation?
>
> IMHO I wouldn't bother that much. =C2=A0Simply mentioning in the 1.7.=
0
> release notes that THREADED_DELTA_SEARCH is no more should be fine.
> Like I said, the existing users who might be affected are certainly f=
ew,
> and the impact on them is rather trivial.

This is everything I wanted to say as well. I just don't think this is
that big of a deal to "break compatibility" as I can think of no
reason why you would only want 2/3 of the pthreads code enabled (your
point 3). What this does do is set the precedent for any future
threads code to only use NO_PTHREADS and not introduce yet another
preprocessor define.

If this gets applied, it needs a small correction- I can resubmit, but
the only difference is this:

diff --git a/config.mak.in b/config.mak.in
index 67b12f7..6008ac9 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -56,5 +56,4 @@ NO_DEFLATE_BOUND=3D@NO_DEFLATE_BOUND@
 FREAD_READS_DIRECTORIES=3D@FREAD_READS_DIRECTORIES@
 SNPRINTF_RETURNS_BOGUS=3D@SNPRINTF_RETURNS_BOGUS@
 NO_PTHREADS=3D@NO_PTHREADS@
-THREADED_DELTA_SEARCH=3D@THREADED_DELTA_SEARCH@
 PTHREAD_LIBS=3D@PTHREAD_LIBS@


-Dan
