From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 7/7] replace: add test for --graft with signed commit
Date: Thu, 3 Jul 2014 16:17:20 +0200
Message-ID: <CAP8UFD2ddGr=cHSv06chD402k1dYrcQ=mxxWP+EHs48zE5twuA@mail.gmail.com>
References: <20140628171731.5687.30308.chriscool@tuxfamily.org>
	<20140628181117.5687.83337.chriscool@tuxfamily.org>
	<xmqqlhsbfocm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 16:17:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2hpG-0005oZ-7J
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 16:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757754AbaGCORV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 10:17:21 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:43654 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbaGCORU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 10:17:20 -0400
Received: by mail-vc0-f172.google.com with SMTP id hy10so276524vcb.31
        for <git@vger.kernel.org>; Thu, 03 Jul 2014 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CKlTPj8lOf3XNt1jQACMA0nMabomhfRS6a+pJXyjX6A=;
        b=f9vOQcS6iPFFF7PDzppxgYaLC5IPkYd+cpO6muDllHnmsmz9/b6u0229U2wMCVwA3G
         COJkDHDQWXcE3W2lzOTk4qbrFL8yYOfylhIfyIT3o5H+8+qEv5fJvBDVwDvxKCDuFio1
         +WiS0Xz61RnVdOiHj7ylhFPh7hprzFFwx+8vpfUmxGfzQQQa42W8oy3JvhHaU2eE9ijT
         rmslqXHBe+1oL78gxIo64RXYx8N7p2xkPIy7q6OWaO5wEy8T0IAYBtM1f6SRXrazHaTl
         WzkPn6bbPXmUSOAKAMRGGtoCH7i9fb2Y5FCJX17Bfa92o4UhcR/yOfim63QEVJr9Jfr8
         Jq8w==
X-Received: by 10.52.115.101 with SMTP id jn5mr596880vdb.65.1404397040330;
 Thu, 03 Jul 2014 07:17:20 -0700 (PDT)
Received: by 10.58.76.137 with HTTP; Thu, 3 Jul 2014 07:17:20 -0700 (PDT)
In-Reply-To: <xmqqlhsbfocm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252863>

On Wed, Jul 2, 2014 at 11:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>>
>> +test_expect_success GPG 'set up a signed commit' '
>> +     echo "line 17" >> hello &&
>> +     echo "line 18" >> hello &&
>
> Style?

Yeah, I will change it to:

     echo "line 17" >>hello &&
     echo "line 18" >>hello &&

>> +     git add hello &&
>> +     test_tick &&
>> +     git commit --quiet -S -m "hello: 2 more lines in a signed commit" &&
>> +     HASH8=$(git rev-parse --verify HEAD) &&
>> +     git verify-commit $HASH8
>> +'
>> +
>> +test_expect_success GPG '--graft with a signed commit' '
>> +     git cat-file commit $HASH8 >orig &&
>> +     git replace --graft $HASH8 &&
>> +     git cat-file commit $HASH8 >repl &&
>> +     test_must_fail grep gpgsig repl &&
>> +     diff -u orig repl | grep "^-parent $HASH7" &&
>> +     diff -u orig repl | grep "^-gpgsig -----BEGIN PGP SIGNATURE-----" &&
>
> Almost the same comment as the one for 2/7 applies here.

Ok, I will find a way to make it better.

Thanks,
Christian.
