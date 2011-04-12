From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH 5/3] Alternative --dirstat implementation, based on
 diffstat analysis
Date: Tue, 12 Apr 2011 15:12:14 -0700
Message-ID: <BANLkTi=6gV1S+6JtK0GNKW6jhA1RFbYXHw@mail.gmail.com>
References: <7vtye834al.fsf@alter.siamese.dyndns.org> <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <BANLkTi=yYU+v1Xx_YO6kpC8+1ukOdwb6SQ@mail.gmail.com> <201104130003.02869.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 00:12:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9lpA-0003QM-LD
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 00:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417Ab1DLWMg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 18:12:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55167 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757303Ab1DLWMf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 18:12:35 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p3CMCYbf031420
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 12 Apr 2011 15:12:34 -0700
Received: by iwn34 with SMTP id 34so25099iwn.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 15:12:34 -0700 (PDT)
Received: by 10.231.34.4 with SMTP id j4mr7428958ibd.83.1302646354105; Tue, 12
 Apr 2011 15:12:34 -0700 (PDT)
Received: by 10.231.33.199 with HTTP; Tue, 12 Apr 2011 15:12:14 -0700 (PDT)
In-Reply-To: <201104130003.02869.johan@herland.net>
X-Spam-Status: No, hits=-103.483 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171422>

On Tue, Apr 12, 2011 at 3:03 PM, Johan Herland <johan@herland.net> wrot=
e:
>
> --stat has a special output mode for binary files:
>
> =A0 =A0 =A0 =A0Documentation/logo.gif =A0 =A0 =A0| Bin 0 -> 16335 byt=
es

Yeah, I think that's the one we introduced exactly to not give crazy
results (ie really big bars of +++/---).

One option might be to just do something like

    if (binary)
       damage /=3D 52;

and just say that "52 bytes of binary diff counts as one line".

Which is obviously totally crazy and idiotic, but it actually is
roughly what happens when you print out the binary diff (that "52" is
made up, but I think it may be true. I forget what encoding rules we
use, it's in that kind of range).

So it's "true" in some insane made-up sense.

=46eel free to pick any number you like instead of "52" that makes some=
 sense.

Because I don't think we have the option to just dismiss the binary
changes entirely, and I don't like the idea of comparing bytes against
lines.

The other option would be to turn lines (of a non-binary diff) into
bytes, and not count lines at all.

                      Linus
