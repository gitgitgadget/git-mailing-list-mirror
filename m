From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] test-lib.sh: Dynamic test for the prerequisite SANITY
Date: Wed, 28 Jan 2015 09:38:19 -0800
Message-ID: <CAPc5daVAGOnu3pe_r=GuDXp1kNkJgbCqP-qD38kXmdEJa3ZSFQ@mail.gmail.com>
References: <54C7B115.7020405@web.de> <xmqqh9vbkgrg.fsf@gitster.dls.corp.google.com>
 <54C89DC8.1050805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:36:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGZLM-0006iH-Ar
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 21:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760813AbbA1Ufg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jan 2015 15:35:36 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:54455 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760782AbbA1Ufd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2015 15:35:33 -0500
Received: by mail-oi0-f45.google.com with SMTP id g201so19855996oib.4
        for <git@vger.kernel.org>; Wed, 28 Jan 2015 12:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=gYx6zGUXIx5Awxi8xn/auS+2U+aUGupxAYu3UCX+JVw=;
        b=shGw2RVdf9noH+wT9IoxQF3GO4KFrJa1kV6mHqX33BoXWYnmdyNnfnVnI5DOssC6Sp
         uM6ZI4jtBsewq2ERGoFxE8ZAJPU7yOIYtXguPemz5TLF5OQGKqBuKwFF6UH6oYC9RjzA
         Z9aERGAbfABSESPqUhOh1lKOLduKXL50oMzj0tiqmo9L1RtkOzQo7hcgzdbWBjcnD7f6
         y3WpppSUDDBcTMATRgwEEULOI+1JDgifLIAMcNvbylUun19+TgKvDWJhNfmdCzycPIEI
         dRgHmC2FYmwzY9LJlQq/B1wAajxlu4416Dezv5gnLxn1LKB7ga8nKY2Ru3aGd7LDvVNq
         DwLA==
X-Received: by 10.202.87.74 with SMTP id l71mr2769276oib.84.1422466719181;
 Wed, 28 Jan 2015 09:38:39 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Wed, 28 Jan 2015 09:38:19 -0800 (PST)
In-Reply-To: <54C89DC8.1050805@web.de>
X-Google-Sender-Auth: gTwsB4fM2Y3gnKPjtJVNkjkLl-o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263112>

On Wed, Jan 28, 2015 at 12:28 AM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 27.01.15 23:20, Junio C Hamano wrote:
>
>> How about extending it like this (not tested)?
> Thanks, this looks good: the test is more extensive,
> I can test this next week.
>
>>
>> -- >8 --
>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>> Date: Tue, 27 Jan 2015 16:39:01 +0100
>> Subject: [PATCH] test-lib.sh: set prerequisite SANITY by testing wha=
t we really need
>>
>> What we wanted out of the SANITY precondition is that the filesystem
>> behaves sensibly with permission bits settings.
>>
>>  - You should not be able to remove a file in a read-only directory,
>>
>>  - You should not be able to tell if a file in a directory exists if
>>    the directory lacks read or execute permission bits.

=46orgot one thing. I do not offhand know if tests that needs SANITY
depends on this, but we may also want to check for this:

 - You should not be able to write to a file that is marked as read-onl=
y.

by adding something like

  >sanitytest && chmod -w sanitytest && ! echo boo >sanitytest && !
test -s sanitytest"

in the mix.

>>
>> We used to cheat by approximating that condition with "is the /
>> writable?" test and/or "are we running as root?" test.  Neither test
>> is sufficient or appropriate in more exotic environments like
>> Cygwin.
> How about going this direction:
>
> We used to cheat by approximating that condition with "is the /
> writable?" test and/or "are we running as root?" test. Neither test
> is sufficient or appropriate, especially in environments like
> Cygwin, Mingw or Mac OS X.

OK, but MacOS X does not have SANITY problem; "is the / writable?" test
was misdetecting and declaring a system with SANITY does not have one.

Perhaps roll Cygwin and Mingw into a single Windows category? I dunno.
