From: Brian Gesiak <modocache@gmail.com>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 16:28:38 +0900
Message-ID: <CAN7MxmXOvkrWPDEUH_Bqz5RVZUS7kuWkwi9kWmdwuwySszd=YA@mail.gmail.com>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
	<20140228053703.GA32556@sigill.intra.peff.net>
	<531032DD.9000904@viscovery.net>
	<20140228071401.GA1229@sigill.intra.peff.net>
	<20140228072606.GA622@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 08:28:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJHsB-0005hY-JN
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 08:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbaB1H2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 02:28:39 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:61581 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbaB1H2j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 02:28:39 -0500
Received: by mail-ig0-f171.google.com with SMTP id uq10so997512igb.4
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 23:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zDIt7J/fGb+JAGBb1TDkc8bu+jMMOq7Cq/2yqRZD3JA=;
        b=G8Y0qLZUlK3T/w2AwO7Yzug3bpOueOb/0fFyxwBt51eHj2Zm96AQF3zKsMG9nCX+xF
         HpvlYZBAe37jlMM5ONbI+KjTATqGAFh8xaEHb5O3qQvI2WuRA4Qc/bWu3KBRzDGJRg7b
         b5I6ldgpv1U2N7vtvMAdX9b5zV3/V9JVDGYJY6sWu5iOuTjtH7zXs5TRsmygHLUg+G/f
         BAjWk6NUtJ70RpQZB+fG/9Vfd1vDThcGutdX6/QheGHqQmFe8N14Ie7xCLm4IiK5gjvC
         /VlF9tejHZaJcRm7wIbLQ5a7WuUQRzDcm8b4pu+lj0wwfy0DeL0kCr9PXCYD8hyk+Gnq
         8h/A==
X-Received: by 10.42.52.209 with SMTP id k17mr9055749icg.1.1393572518744; Thu,
 27 Feb 2014 23:28:38 -0800 (PST)
Received: by 10.64.55.161 with HTTP; Thu, 27 Feb 2014 23:28:38 -0800 (PST)
In-Reply-To: <20140228072606.GA622@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242899>

> Hmm. Looks like it is only a problem if you are calling a shell function
> (since it is the shell function's trace output you are seeing). So this
> test would be OK as-is

Indeed, this test passes when run locally, even using "sh -x".

I would be in favor of using test_i18ngrep, but it seems like this
test file overwhelmingly uses test_(i18n)cmp, even when inspecting
stderr output. Making double-sure that all tests pass when run with
"sh -x" seems like a larger endeavor.

Of course, I'd be happy to submit several patches if there's support
for such a change. But as Peff points out it will be a large diff.

- Brian Gesiak

On Fri, Feb 28, 2014 at 4:26 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 28, 2014 at 02:14:01AM -0500, Jeff King wrote:
>
>> I didn't think we bothered to make "sh -x" work robustly. I don't mind
>> if we do, but "git grep -E 'test_(i18n)?cmp .*err" shows many potential
>> problem spots.
>
> Just for fun:
>
>   cd t
>   make SHELL_PATH="sh -x" prove
>
> causes 326 test failures across 43 scripts. That's slightly misleading,
> because 200 of the failures are all in t0008, and updating one function
> would probably clear up all of them.
>
> -Peff
