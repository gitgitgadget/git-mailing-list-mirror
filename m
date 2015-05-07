From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 05/12] t5520: test --rebase failure on unborn branch
 with index
Date: Thu, 7 May 2015 14:20:36 -0400
Message-ID: <CAPig+cT6dom8vMoy4eObwQOuERYh4nfLgFHfmofn+C7pD-PnCw@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-6-git-send-email-pyokagan@gmail.com>
	<CAGZ79kY7gstS1xPcNu4HqmmXA+qg9BKpXZwaHeQ91n7vL2Sa-g@mail.gmail.com>
	<CACRoPnQzAjY0bPmHrw2o4Mdzn1Q4Dd587hLXkEPA-qYcYrVGEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:20:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqQPa-0002HD-3A
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 20:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbbEGSUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 14:20:37 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35246 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbbEGSUh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 14:20:37 -0400
Received: by igbyr2 with SMTP id yr2so1305064igb.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 11:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tUQDfwgXta7Iix+TlZpnBebFYfT4+WLYDlUfPPHQYFc=;
        b=sTPAfLxy+LlvpEawv3eeEcGumvIUdndiOSL6umwhOnTSVYrusH7WqjzSXY1ICQcow4
         tBWyk08vFTraf+h1RUyx7kKwtwDATmh+3xY8yrzBnkSzJrASIo6RYOt2PtpZo1TQL7dH
         f9tA0Ueq5X2t+JcqxDEzZxIijQtt3sVfGQM/EqkLj6TM6GJuoIjjVW/37GQnf39aBOpf
         rpNh7lNSZ9atn6inlZUdS2z01lVAqB5TJ7X7OtceeUFwQGON0nVXc6xiV179wODswvQ4
         ulSdqxG/t/PWueTDihzrd7aHM5ktD9/hLBevmJmQx8Q68RtOcrMY2TccOwW7YlpXd8y5
         oI9g==
X-Received: by 10.50.43.227 with SMTP id z3mr16400677igl.22.1431022836486;
 Thu, 07 May 2015 11:20:36 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 7 May 2015 11:20:36 -0700 (PDT)
In-Reply-To: <CACRoPnQzAjY0bPmHrw2o4Mdzn1Q4Dd587hLXkEPA-qYcYrVGEg@mail.gmail.com>
X-Google-Sender-Auth: 66XLCyfYHOHPoPSw2HWQOvrbDFY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268569>

On Thu, May 7, 2015 at 1:44 PM, Paul Tan <pyokagan@gmail.com> wrote:
> On Fri, May 8, 2015 at 12:32 AM, Stefan Beller <sbeller@google.com> wrote:
>> On Thu, May 7, 2015 at 1:44 AM, Paul Tan <pyokagan@gmail.com> wrote:
>>> +test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
>>> +       test_when_finished "rm -rf empty_repo2" &&
>>> +       git init empty_repo2 &&
>>> +       (
>>> +               cd empty_repo2 &&
>>> +               echo staged-file >staged-file &&
>>> +               git add staged-file &&
>>> +               test "$(git ls-files)" = staged-file &&
>>
>> I think usually people use
>>
>>     git ls-files >actual
>>     echo staged-file >expected && # you have this already in your 2nd
>>     # line in the paragraph
>>     test_cmp staged-file actual
>>
>> to make debugging easier as you can inspect the files (actual, expected)
>> after the test has failed.
>>
>> Personally I don't mind the difference as when it comes to debugging
>> using the test suite I haven't found the silver bullet yet.
>
> Ehh, but using test_cmp will litter the test with lots of "echo X
>>expected" lines which I find quite distracting.
>
> Just thinking aloud, but it would be great if there was a function to
> compare a string and a file, or a string and a string.
>
> But yeah, I guess if the patches are verified to be correct, then I
> should change these comparisons to use test_cmp.

Check out verbose() in test-lib-functions.sh:643. It might be just
what you want. t0020-crlf.sh has a bunch of examples of its use.
