From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Git Bug Report: bisect run failed to locate the right commit
Date: Wed, 27 Aug 2014 16:15:46 +0200
Message-ID: <CAP8UFD08sABDPwxfJMNHcU6CWdVfsVTKHSXvT4+Mxf5GPYvhyA@mail.gmail.com>
References: <C40A01C66E914D4EB90E1B40564B0E56CBFE1C82@MBOX2-4.ntu.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?5p2O56WQ5qOg?= <r01942008@ntu.edu.tw>
X-From: git-owner@vger.kernel.org Wed Aug 27 16:15:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMe0z-0004On-C0
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 16:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934845AbaH0OPs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2014 10:15:48 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:59558 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934717AbaH0OPr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2014 10:15:47 -0400
Received: by mail-ig0-f174.google.com with SMTP id c1so6289828igq.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Y/P24Q4COAQshWlYfmCiGuYfzrrWsjt1TFmSSxEjp7U=;
        b=glf68FpRTQ9oAiFOEYG48l5Qo1LDwaBMhFy9Qoud28u8etsxfTYqqyxZbCOkAdFaN7
         REOYlBVEvJDZdTwI467gYEbPNh7A6uGcKzBwsYUBvqAzWoNhuHHdGNPfOUfQUHlZuh6h
         5BGmIuRMZCXqYd+WPCNi7R6yTCgA58vcaA0M65TyW27YuOWjk39CEwPihSGOX2f187cQ
         d4oPHmTWdB3xN256HPyY0cKidzJi9/TqTnKiw7jGxrdemc1sKcADpu0/g7zcIbO5b4Mv
         1AZSjPIL9IQX8Wcaambpvg8lXB6FX0GzAyYh3NHvP+gBvAkf/wRKfII+X6VZiaQW00E3
         NBGg==
X-Received: by 10.43.149.200 with SMTP id kl8mr18533556icc.52.1409148946793;
 Wed, 27 Aug 2014 07:15:46 -0700 (PDT)
Received: by 10.50.212.3 with HTTP; Wed, 27 Aug 2014 07:15:46 -0700 (PDT)
In-Reply-To: <C40A01C66E914D4EB90E1B40564B0E56CBFE1C82@MBOX2-4.ntu.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255994>

Hi,

On Wed, Aug 27, 2014 at 3:42 PM, =E6=9D=8E=E7=A5=90=E6=A3=A0 <r01942008=
@ntu.edu.tw> wrote:
> Dear Git developers:
>
> I just found a suspicious bug that might cause by git-bisect run.
>
> Version:
> The git version is 1.9.2, running on Archlinux 3.14.2
>
> The step to produce the error:
> Here is the repository I participate:
> https://github.com/gawel/pyquery
>
> It got a issue #74, that gives a wrong result in version 1.2.8
> and this is fixed in 1.2.9
>
> Here is the manual test script I use is "manualscript.py":
>
> I use git bisect manually, search from 1.2.9(bad) to 1.2.8(good), I l=
ocate the commit that fixes this issue. The running log is attached in =
this file(manual).
>
> However if I use the automatic script
> git bisect run
> with the script "auto script":
>
> It will give a wrong answer, the log file is also attached(auto)

Your "manual" log contains:

Bisecting: 0 revisions left to test after this (roughly 1 step)
[300cd0822505a4bd308acd1520ff3ef0f20f8635] fixed issue #19
$ ./manualscript.py
=46alse
=46alse

While your "auto" log contains:

Bisecting: 0 revisions left to test after this (roughly 1 step)
[300cd0822505a4bd308acd1520ff3ef0f20f8635] fixed issue #19
running ./autoscript.py
=46alse
True

So for the commit 300cd0822505a4bd308acd1520ff3ef0f20f8635 it looks
like your manualscript.py and your autoscript.py don't return the same
result.

Could you check that by doing something like:

$ git checkout -b testscripts 300cd0822505a4bd308acd1520ff3ef0f20f8635
$ ./manualscript.py
$ echo "manualscript.py exit code: $?"
$ ./autoscript.py
$ echo "autoscript.py exit code: $?"

?

By the way you can get a better bisect log by running "git bisect log"
after your bisection.

Best,
Christian.
