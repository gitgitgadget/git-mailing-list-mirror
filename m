From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] mailinfo: resolve -Wstring-plus-int warning
Date: Mon, 22 Sep 2014 17:10:08 -0400
Message-ID: <CAPig+cTAFaG5H8rmf1jrvFwr_OOH7u19JMKDUE12UddokUmfaQ@mail.gmail.com>
References: <1411290838-45622-1-git-send-email-sunshine@sunshineco.com>
	<xmqqk34vlfhz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 23:10:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWAsC-00011o-Gy
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 23:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937AbaIVVKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 17:10:10 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:62455 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbaIVVKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 17:10:09 -0400
Received: by mail-yk0-f177.google.com with SMTP id 9so1634844ykp.36
        for <git@vger.kernel.org>; Mon, 22 Sep 2014 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PDa8BzZ5wjffCTZ6xQJUu8VH+QKRRoMTMhmncpk9AaQ=;
        b=vBOMcmnCEyk9CsKlsw/bee4o1oZjPYwYpxdt8FdYh+sDcicpH5InF/XjBiXZSH9007
         zv/l+8DRfyyeyxmHPRXqUY+jsSq2Rjua18mdVe7Hi5Xb3sfjlNRmYR+1g97fwh1BNN9F
         CEknuV9nmcyGIHE1/13eVwSnsXTHT+VF5h96iN3wYULCGxUNDJlR52WvwtPkIEPUYrjY
         UA3AVLK3TKqqyKZtCoG1m8lqwmWl8TorU4O0NuKLk/Atj6bkqi4v5486pujVjP5nE+Jn
         wDYeEwRLMhBLh47Bc/xF5y8LIcZy2rENeOXqnhyEhSjdJYmF95olL6vngfNgrNUQf1kF
         xpdA==
X-Received: by 10.236.129.1 with SMTP id g1mr10770536yhi.30.1411420208113;
 Mon, 22 Sep 2014 14:10:08 -0700 (PDT)
Received: by 10.170.68.68 with HTTP; Mon, 22 Sep 2014 14:10:08 -0700 (PDT)
In-Reply-To: <xmqqk34vlfhz.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 30dicr4KuvqDGqhU3lCkuB-JUjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257384>

On Mon, Sep 22, 2014 at 1:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> The just-released Apple Xcode 6.0.1 has -Wstring-plus-int enabled by
>> default which complains about pointer arithmetic applied to a string
>> literal:
>>
>>     builtin/mailinfo.c:303:24: warning:
>>         adding 'long' to a string does not append to the string
>>             return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) ...
>>                            ~~~~~~~^~~~~~~~~~~~~
>
> And why is that a warning-worthy violation?

Not being privy to Apple's decision making process, I can only guess
that it is in response to their new Swift programming language which
they are pushing heavily on iOS (and soon Mac OS X), in which '+' is
the string concatenation operator. For projects written in Swift and
incorporating legacy or portable components in C, C++, or Objective-C,
the warning may help programmer's avoid the pitfall of thinking that
'+' is also concatenation in the C-based languages.

> Can we have them fix their compiler instead?

If the above supposition is correct, then it's likely that Apple
considers this a feature, not a bug which needs to be fixed.

>> Resolve this issue.
>>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
