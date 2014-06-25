From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: BUG: git request-pull broken for plain branches
Date: Wed, 25 Jun 2014 05:05:51 -0700
Message-ID: <CA+55aFwZb7tT7xb7y2XJpzcmrxB=Rf--bjz5XbBcxC-7MMm9eg@mail.gmail.com>
References: <20140625095535.GA27365@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>, kernel@pengutronix.de
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Jun 25 14:05:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzlxc-0001Ps-Rr
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 14:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297AbaFYMFw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2014 08:05:52 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:41943 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205AbaFYMFw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jun 2014 08:05:52 -0400
Received: by mail-ve0-f172.google.com with SMTP id jz11so1844248veb.31
        for <git@vger.kernel.org>; Wed, 25 Jun 2014 05:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=3NS9NAChyx+CEOJtqKZ6OotK+HXZaVF1Ysp7SkPe4qI=;
        b=u4VpuSJIly41r4AUll5DHwAVSIkHR5Tl3BOW1jjICSxE1BiwrvQx9Rca4+m/b+DCUf
         qHjMo1Lc1L/Zgx4t+GHCfBj9cXwW4ZeM9oROpda+ss3I1fo5Ds8h9Vtn3VqVrVAN96c9
         s2hbmW1un1ZVnbwTCXCHjdRDfvpOf74xv/lh2l+OLKpohgLfQTTcKsYBeqb7OXEBawo4
         T3HXcoqpDulFbnrjlkANY+fv5ze2H+P6D1r4f7NtPghiKSLzx4bareE4f7nUuTOW0XRu
         l+Ud+7qfxQQBDI4T+6lZSIfz72smF9HHzOJQ6JX//pPZdDIiTuYTF3+GOhyRTyHTUY9X
         wogQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=3NS9NAChyx+CEOJtqKZ6OotK+HXZaVF1Ysp7SkPe4qI=;
        b=iF4RWBHlEF5psuXPx53hIla71iOhBACuiRphP1aIeaBUfwyWCvjoxUTlu1p3FNYDU+
         3wvHWKbB084l6WpSEAYeIcEtlppY68xkch6NKOvdkXi0i4gkDz+e3E4ovjHgSEVVTAh/
         OItITRhvlJ3KaFNPWP9SN0QgQgNU7Ns8V8Pus=
X-Received: by 10.52.116.194 with SMTP id jy2mr5446772vdb.39.1403697951424;
 Wed, 25 Jun 2014 05:05:51 -0700 (PDT)
Received: by 10.220.13.16 with HTTP; Wed, 25 Jun 2014 05:05:51 -0700 (PDT)
In-Reply-To: <20140625095535.GA27365@pengutronix.de>
X-Google-Sender-Auth: 2xMu1EorQWh9xAtCI2CrZAshb8Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252442>

On Wed, Jun 25, 2014 at 2:55 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
>         $ git rev-parse HEAD
>         9e065e4a5a58308f1a0da4bb80b830929dfa90b3
>         $ git ls-remote origin | grep 9e065e4a5a58308f1a0da4bb80b8309=
29dfa90b3
>         9e065e4a5a58308f1a0da4bb80b830929dfa90b3        refs/heads/uk=
l/for-mainline
>         $ git request-pull origin/master origin HEAD > /dev/null
>         warn: No match for commit 9e065e4a5a58308f1a0da4bb80b830929df=
a90b3 found at origin
>         warn: Are you sure you pushed 'HEAD' there?

Notice how "HEAD" does not match.

The error message is perhaps misleading. It's not enough to match the
commit. You need to match the branch name too. git used to guess the
branch name (from the commit), and it often guessed wrongly. So now
they need to match.

So you should do

    git request-pull origin/master origin ukl/for-mainline

to let request-pull know that you're requesting a pull for "ukl/for-mai=
nline".

If you have another name for that branch locally (ie you did something
like "git push origin local:remote"), then you can say

    git request-pull origin/master origin local-name:remote-name

to specify what the branch to be pulled is called locally vs remotely.

In other words, what used to be "pick some branch randomly" is now
"you need to _specify_ the branch".

                Linus
