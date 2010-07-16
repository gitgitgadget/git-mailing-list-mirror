From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] grep: Don't pass a TODO test if REG_STARTEND is
 supported
Date: Fri, 16 Jul 2010 14:50:08 -0500
Message-ID: <20100716195007.GC16371@burratino>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>
 <7viq4ppxt9.fsf@alter.siamese.dyndns.org>
 <AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
 <7vtyo0vdpz.fsf@alter.siamese.dyndns.org>
 <AANLkTim-4I5Sdu653yJOmnVYDqI8bb71839Vqfd3FKCi@mail.gmail.com>
 <AANLkTimZ3f550HQwx3OEpO6n1b037He6hJ6rAXP8vfIk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 21:51:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZqwC-0005FH-KK
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 21:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab0GPTvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 15:51:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57702 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895Ab0GPTvD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 15:51:03 -0400
Received: by gyh4 with SMTP id 4so1455711gyh.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=r6DZMBAdOl8Ra7OvSStGqlVfC/ewyQhEI/L/pGYgpo8=;
        b=FDFcBV9EfmIWIgGhsyXgkkclSCRPRnrqI5unGG+KyIT13BUnP2RLha7gHylD3OO9hQ
         b7hAit5qaM7BY0+qCX1Do4gHz0r665MXuMFfzpHlGut6rJqj/0LO+iVAL/fXcCk+8A91
         /yIgiSf/VPDUOkeVJXWpcw1is3hJMq4hbpUhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lpLv1U8Zfb2+HTphyFkdGCCALiUZADCToHIU04i9YDuwyQ7I7n8VL//DkI8/nyGf+Q
         t1b8TqO4nGwM3INj43ZVAORucFmf0SrXWhIyVw45AmGymaJ4exq7SttDfwDVUbW4gFPE
         3gRB/x1iKATzJ7lV5VHnAC7gGmhNa+IWYsbA0=
Received: by 10.224.44.221 with SMTP id b29mr1270229qaf.51.1279309861614;
        Fri, 16 Jul 2010 12:51:01 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h41sm11425175qcz.13.2010.07.16.12.51.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 16 Jul 2010 12:51:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimZ3f550HQwx3OEpO6n1b037He6hJ6rAXP8vfIk@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151167>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Well to clarify: The TAP is arguably right, although semantically
> these sort of tests should probably be a SKIP on unsupported
> platforms, not a passing TODO.

No, we support all platforms people are willing to fix without
uglifying the code too much.  So a bug is a bug.  Test
prerequisites get used for behavior that is either out of scope
(Posix-style permissions on Windows) or hard to test (signal
delivery to child process in t7502-commit).

The semantic problem you are describing here is that we have no
separate way to mark bugs that are not consistently reproducible.
A =E2=80=9Cfixed=E2=80=9D test_expect_failure is sometimes a fluke, lik=
e in this
example.

If lucky, you can find an appropriate condition and use
test_expect_success or test_expect_failure as appropriate.  In
the general case, that is not always easy.  Better to eliminate the
unreproducible bugs.

> On Thu, Jul 15, 2010 at 18:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:

>> We should also just upgrade the GNU regex library in compat/regex to
>> the version that supports REG_STARTEND.
[...]
> This is what we should be focusing on

By the way, I have no preference for choice of regex library here.  If
something else is easier to get working correctly, that would be great.
