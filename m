From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] send-email: Add simple email aliases format
Date: Thu, 21 May 2015 23:59:38 -0400
Message-ID: <CAPig+cSDAagVNhdobtTDGrdzLNSxKpOtUhEEDq+NLQZBOoWJxg@mail.gmail.com>
References: <4b56f6ab3c14aff7752804d11917b1f330f55f40.1432252898.git.allenbh@gmail.com>
	<CAPig+cQ8Gw3Q1QcJ=k4647LW1gBZ3fuJBYpOCE=AxA0ZWtktmQ@mail.gmail.com>
	<CAJ80savXAOMAbdDC_F77esD1Fdi=BP6GK4biFOLJTtqqehjEOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 05:59:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yve7c-0005lL-0Y
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 05:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085AbbEVD7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 23:59:39 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33843 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735AbbEVD7i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 23:59:38 -0400
Received: by igbhj9 with SMTP id hj9so27138534igb.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 20:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ct8SyqJQ9qdkFFVN1oZL7ne972yFXblFxLGhgxCHWsE=;
        b=YT5SvDilOczojT5NcZ8f1+ACdzUvNqv9cRs14iPopgiqqO6xRREg5Evm5lrht7V3vO
         vW4ZEz8MK0vaqTxu+YBNmqRLr2AwtpdDfCoO3nYSHh8/wWAfacvelVYTUXvZm6kfAszE
         gyguYY6XiUV/9z/yZXta9Cs2ONzSgAMZkgu1v28Uugfu2irfMw8Ji6M0Bgr8vzWInzaL
         usAlTqRkwwg2XcW2w0zRuzL6OwjnToXwJpBHB99ITAqz2dNEYMMrtCzzEzxSXTByEvzN
         s+Oco7FZKvPqjWWzzVStc5ozSrKxQgNmSMAN9DMI1f5zkRzhxGrrKQp0UJaZf3L59rUs
         fvFA==
X-Received: by 10.107.151.75 with SMTP id z72mr8010670iod.46.1432267178432;
 Thu, 21 May 2015 20:59:38 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 21 May 2015 20:59:38 -0700 (PDT)
In-Reply-To: <CAJ80savXAOMAbdDC_F77esD1Fdi=BP6GK4biFOLJTtqqehjEOw@mail.gmail.com>
X-Google-Sender-Auth: XYXnvxIkyLG51y-JUNMfQEW1ejQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269688>

On Thu, May 21, 2015 at 11:19 PM, Allen Hubbe <allenbh@gmail.com> wrote:
> On May 21, 2015 9:05 PM, "Eric Sunshine" <sunshine@sunshineco.com> wrote:
>> On Thu, May 21, 2015 at 8:16 PM, Allen Hubbe <allenbh@gmail.com> wrote:
>> > +test_expect_success $PREREQ 'sendemail.aliasfiletype=simple' '
>> > +       clean_fake_sendmail && rm -fr outdir &&
>> > +       git format-patch -1 -o outdir &&
>> > +       {
>> > +               echo "alice: Alice W Land <awol@example.com>"
>> > +               echo "bob: Robert Bobbyton <bob@example.com>"
>> > +               echo "chloe: chloe@example.com"
>> > +               echo "abgroup: alice, bob"
>> > +               echo "bcgrp: bob, chloe, Other <o@example.com>"
>> > +       } >~/.tmp-email-aliases &&
>>
>> A here-doc would be easier to maintain and read:
>>
>>     cat >~/.tmp-email-aliases <<-\EOF &&
>>         alice: Alice W Land <awol@example.com>
>>         bob: Robert Bobbyton <bob@example.com>
>>         ...
>>     EOF
>
> A here-doc does not flow nicely in an indented block.  Each line in
> the here-doc will also contain any indentation which may appear to the
> reader to be part of the test case.  Alternatively, the here-doc could
> be indented differently than the surrounding test case (all the way to
> the left column), but that also has a negative impact for readability.
> Finally, the EOF marker can not be indented.

That's true if you use <<EOF here-doc, but not for <<-EOF, as I did in
the example. With <<-EOF, all leading tabs are stripped from the input
lines, including from the EOF line, which is why it can be indented to
the same level as the other code in the test. The added '\' in <<-\EOF
from my example indicates that you don't want/expect any interpolation
inside the here-doc. The <<-\EOF form is used extensively throughout
the Git test suite.

> With echo "string", exactly "string" is output to the line.  The
> operation is obvious to the reader.  The test case can use sane
> indentation, and the resulting output will be exactly what what it
> would appear to be in the test case.

Same with <<-\EOF; plus <<-\EOF content is more readable since it's
not polluted with 'echo' noise.

> Especially for something like a test case where there should be
> absolutely no confusion as to exactly what is the input to the test,
> clarity matters.  Any operation where the result is not immediately
> obvious to the reader, does not belong here.  Therefore, I will keep
> the lines in the test case as echo "string".
