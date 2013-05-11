From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Makefile: fix default regex settings on Darwin
Date: Sat, 11 May 2013 00:55:19 -0700
Message-ID: <CAJDDKr5t+hVE-TpNbVWmLL4VFq-NGjuVhcyPG=quaf6icz+E4Q@mail.gmail.com>
References: <1368248913-95188-1-git-send-email-davvid@gmail.com>
	<20130511063132.GF3394@elie>
	<CAJDDKr5StD_bDr7+29qEYc4Lza+q8w=ZrHuwdSLwvCSru3YYWQ@mail.gmail.com>
	<20130511070423.GG3394@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 09:55:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub4eL-0008U3-Es
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 09:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880Ab3EKHzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 03:55:21 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:48947 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab3EKHzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 03:55:21 -0400
Received: by mail-ea0-f178.google.com with SMTP id q15so707343ead.23
        for <git@vger.kernel.org>; Sat, 11 May 2013 00:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=q3x6lprTV+kNKjOjzRa48TBCbfuVNAXDlrYfFexGV5E=;
        b=nDep3+eAya2SySsy03imfZF4AeSHkSlHUWJh1dwSGimr9zj0bilbNVQX0jwJ8vl+pS
         adUD1iQm14DLyN0Kf1qjD74FMmh943ZGdc2oQr6ZlWAWj9sz3ceej6cPsF1WVdfb3ew4
         WSpQKPtA54j3lWbU3/dwrPLLhpUgQ1tCBewy9r80+QBXFQryFa2Wk5h6aVeOlwKYmrcb
         bWRimLC5bAbrdEQnkSkswKrJ96dOg6W2uFyj5BSUzBNCX3420RsBKT+rfK6zdg3kLmK4
         DSQgDhfLzNs7c+D5d+jrb+MtObZF9tQnpWxgS7uY1M3UaLb35dgCX3tPu11welIJ9SFv
         SGYw==
X-Received: by 10.15.24.72 with SMTP id i48mr29813355eeu.37.1368258919789;
 Sat, 11 May 2013 00:55:19 -0700 (PDT)
Received: by 10.14.32.65 with HTTP; Sat, 11 May 2013 00:55:19 -0700 (PDT)
In-Reply-To: <20130511070423.GG3394@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223939>

On Sat, May 11, 2013 at 12:04 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> David Aguilar wrote:
>
>> expecting success:
>> # if this test fails, re-build git with NO_REGEX=1
>> test-regex
>>
>> fatal: regex bug confirmed: re-build git with NO_REGEX=1
>
> Thanks.  Gah.  That means that regcomp() with REG_NEWLINE is letting
>
>         [^={} \t]+
>
> match the newline in
>
>         ={}\nfred
>
> despite the POSIX requirement
>
>         A <newline> in string shall not be matched by a period outside
>         a bracket expression or by any form of a non-matching list
>
> where
>
>         A non-matching list expression begins with a <circumflex> ('^')
>         and specifies a list that shall match any single-character
>         collating element except for the expressions represented in
>         the list after the leading <circumflex>.
>
> and if I understand you correctly, this is a regression in Apple
> libc. :(
>
> With the commit message modified to mention the "fatal: regex bug
> confirmed: re-build git with NO_REGEX=1" and uname -a output,
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks. I can adjust the commit message and re-roll to make this patch 1/3.

> Do you know if this has been reported to Apple and
> openradar.appspot.com?

I checked and nope, there are no bug reports.  I tried to submit one
by creating a "new radar" but that page said to go to
bugreport.apple.com.

I tried to login there but after entering my credentials I got, "An
error has occurred. Please report the error to Apple Inc. by emailing
the error detail to devbugs@apple.com."  Oh bother ;-)

I refreshed the page and finally got in.  I submitted a bug.. Problem # 13868200

I hop on this laptop to test for cross-platform issues (I'm a Linux
user myself ;-) and it's been pretty good at finding 'em.
--
David
