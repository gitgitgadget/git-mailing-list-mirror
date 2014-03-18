From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] tests: set temp variables using 'env' in test function
 instead of subshell
Date: Tue, 18 Mar 2014 18:36:29 -0400
Message-ID: <CAPig+cRHJmzZMahNaz641t8i7di3YinYV=OQPd=-zDo6U3NkQg@mail.gmail.com>
References: <244284@gmane.comp.version-control.git>
	<1395144518-2489-1-git-send-email-unsignedzero@gmail.com>
	<xmqqd2hj6y5o.fsf@gitster.dls.corp.google.com>
	<20140318214536.GA10076@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	David Tran <unsignedzero@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 18 23:36:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ2cc-000764-W7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 23:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757987AbaCRWga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 18:36:30 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:32876 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756803AbaCRWg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 18:36:29 -0400
Received: by mail-yk0-f178.google.com with SMTP id 79so20902007ykr.9
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 15:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JRlg3pwkEXTue2dKGRt14ZNSiCl08B4Fk0ReF8Ej97w=;
        b=m64fZBRZjQIoL32nwYhUHFFjZxJZYDb7Jmqr9NxCUqKhjyKLDGEzPLRvF5A0amrixu
         8P+4g5MMAUnNa46SbXyRhzFGK9Oy8qTAfS9gEoSGQxL4kpvpuvXM91hzTiru/ulUYRHZ
         RLQCsXcuF/uMjUjLtvg8SW91/efFNUhB0gdqQPd3YNcJgOay+MukOtY9Y6uhbCjiGIlA
         QrAD0PerMZ/2vyyNb3UJU9DrTivZIB2IdUhkpKS2fCkn/+j5AEbd+ZChZZcNKal/YVen
         naLyQhbze0MAsvzFm9RQHFkcsmVY2gDvIEaBXNk32R0L8JskAm0SRi5lbLkbPp6yYioj
         pORQ==
X-Received: by 10.236.92.115 with SMTP id i79mr21059220yhf.62.1395182189098;
 Tue, 18 Mar 2014 15:36:29 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 18 Mar 2014 15:36:29 -0700 (PDT)
In-Reply-To: <20140318214536.GA10076@sigill.intra.peff.net>
X-Google-Sender-Auth: UIaVPquZ_Fsp8ybrLHinKwTJWCk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244391>

On Tue, Mar 18, 2014 at 5:45 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 18, 2014 at 01:37:39PM -0700, Junio C Hamano wrote:
>
>> > diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
>> > index c9c426c..3e3f77b 100755
>> > --- a/t/t1300-repo-config.sh
>> > +++ b/t/t1300-repo-config.sh
>> > @@ -974,24 +974,15 @@ test_expect_success SYMLINKS 'symlinked configuration' '
>> >  '
>> >
>> >  test_expect_success 'nonexistent configuration' '
>> > -   (
>> > -           GIT_CONFIG=doesnotexist &&
>> > -           export GIT_CONFIG &&
>> > -           test_must_fail git config --list &&
>> > -           test_must_fail git config test.xyzzy
>> > -   )
>> > +   test_must_fail env GIT_CONFIG=doesnotexist git config --list &&
>> > +   test_must_fail env GIT_CONFIG=doesnotexist git config test.xyzzy
>> >  '
>
> Isn't GIT_CONFIG here another way of saying:
>
>   test_must_fail git config -f doesnotexist --list
>
> Perhaps that is shorter and more readable still (and there are a few
> similar cases in this patch.

Such a change could be the subject of a separate cleanup patch, but is
tangental to the GSoC microproject which begat this submission.
