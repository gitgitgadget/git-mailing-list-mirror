From: John Bito <jwbito@gmail.com>
Subject: Re: git diff looping?
Date: Tue, 16 Jun 2009 10:39:39 -0700
Message-ID: <3ae83b000906161039s1cd540a9k3506a09a5e616c67@mail.gmail.com>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com>
	 <20090616114726.GA4343@coredump.intra.peff.net>
	 <7v3aa0dsvn.fsf@alter.siamese.dyndns.org>
	 <20090616171531.GA17538@coredump.intra.peff.net>
	 <RFQLUdKWnVWgwwX0qsqUhC-pl9v39aFOKMpTbbABiCEXczTo26fVow@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:39:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGcdR-0007Cb-Gv
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 19:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758058AbZFPRjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2009 13:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbZFPRjk
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 13:39:40 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:20488 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbZFPRjj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2009 13:39:39 -0400
Received: by an-out-0708.google.com with SMTP id d40so10319774and.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+bL9V1jJf0l3Oe9ayOvzOscjyuwMHh98yDeyVT7/MrE=;
        b=j6bPyXilKBd9xRnL34CNvvTSRnS98mQVsmjvhFmtUoM3TBG6ixz9GCHPWMTPxisWbM
         tD0XvX8cafHmoWwV2I5NHI+vvnYuvNMkShiYRRolfWOJQ0ZPYOF4irm7XzDW2YY/R4Gj
         wKKV1Efwl+AHvxlMNyWkpWC41rx/4f/v3niL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=idE9JJQn2Gc3m6TUJN6GwFtEOvZQ8vgsN0itjHhmDmzJcymEN/UDA4UUZ9e5scng3T
         jLNicOZ3DhPfHwSpMArfiuCIj+u92BNE922Albcvl6gkVGoblSeabLjt8RxIaEgjMqL0
         LwlWKfCJqqsPJSlGuKdJ7S/xpo8HkwKn+4Raw=
Received: by 10.100.126.19 with SMTP id y19mr10756446anc.100.1245173980078; 
	Tue, 16 Jun 2009 10:39:40 -0700 (PDT)
In-Reply-To: <RFQLUdKWnVWgwwX0qsqUhC-pl9v39aFOKMpTbbABiCEXczTo26fVow@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121694>

I believe the issue is that Solaris implements 'extended' regular
expressions only in regcomp/regexec.  The implementation of
regcmp/regex seems to be from SysV and supports only 'basic' regular
expressions.

On Tue, Jun 16, 2009 at 10:35 AM, Brandon Casey<casey@nrlssc.navy.mil> =
wrote:
> Jeff King wrote:
>> On Tue, Jun 16, 2009 at 09:51:24AM -0700, Junio C Hamano wrote:
>>
>>>> I can reproduce the problem on Solaris 8 using git v1.6.3. It seem=
s to
>>>> be caused by a horribly slow system regex implementation; it reall=
y
>>>> chokes on the regex we use to find the "funcname" line for java fi=
les.
>>> Hmm. =A0Is running under LC_ALL=3DC LANG=3DC _with_ the slow system=
 regex help?
>>
>> No, it remains extremely slow (it is possible that it _is_ faster,
>> though, but I never managed to run either case to completion; they a=
re
>> both clearly orders of magnitude off of acceptable).
>
> I haven't tried setting LC_ALL, LANG, but this Solaris regex is MANY =
orders
> of magnitude slower. =A0I've been running your example diff on the eg=
it
> repository for 2 hours and it still hasn't finished. =A0The compat/re=
gex
> version finished in 3 seconds. =A0Solaris 10 x86.
>
> -brandon
>
