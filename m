From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] sha1_name.c: simplify @-parsing in get_sha1_basic()
Date: Thu, 2 May 2013 03:56:26 +0530
Message-ID: <CALkWK0kJj2J6gg-M+CcLdaM1cXhnLGUWCYwUqc+XGdDDyhwo2Q@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-4-git-send-email-artagnon@gmail.com> <CAMP44s1tHC+i+Wug_UuPnprZNvaPgLMNBX9MZi49SFv4iO62SQ@mail.gmail.com>
 <CALkWK0nTSMYvh8VMgQ6Q0EoPMmRa2vyodz+tDmpPp1d6KYmq8w@mail.gmail.com>
 <CAMP44s0sRqsmhbv-GA5x0FPc5msouSoGaU_Wg51E0F9bNsmkjg@mail.gmail.com>
 <CALkWK0=Z81f4c1X3uXO4O5q_Dj2hRJjSY-i-aDtZ0KqSyo5Wtg@mail.gmail.com> <CAMP44s2sRsJR9xxty9F4c7-G3HQrK3N=-o7KBSpG5TYpdhu-9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 00:27:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXfUX-0005Dh-35
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 00:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760212Ab3EAW1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 18:27:08 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:38647 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758073Ab3EAW1H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 18:27:07 -0400
Received: by mail-ia0-f177.google.com with SMTP id y26so1707240iab.8
        for <git@vger.kernel.org>; Wed, 01 May 2013 15:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6gNG57KWzT+iS0b3PntewbufSJzarpG4REy92sliOcI=;
        b=B9v/GkKOAsWtTtjvapcE1s2m1K5weV7AgesR0yNSMz0tCsL107u0HnRuWK2g5NWwoS
         2H2Z5baA7Nck/yWhe4pL45U1yg5RpkUHUr0LFgetkQGQlfNjI2H9vtbiVV1s8UfdvFyD
         cGKQPH3OQhtYJXMBdMQ5tUNxpGXpVbhpI2m2OYrxish/GZJG2EqQuJw4Pz4ZPaIUxNpm
         MPBmd9QWVBo+Kmlr/HqdN6M687p+Ahk+QWc/QfjUhQTSRfaJZW2Fp7u8Mbul9CY/4q0U
         QKxIN+chGNWyxBbg2vZYKQd2mm7oSccmOLriM/YwImovS2vdhzZ8k+s4xrKpLg6zur+A
         WjVg==
X-Received: by 10.50.66.197 with SMTP id h5mr13658168igt.63.1367447226597;
 Wed, 01 May 2013 15:27:06 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 15:26:26 -0700 (PDT)
In-Reply-To: <CAMP44s2sRsJR9xxty9F4c7-G3HQrK3N=-o7KBSpG5TYpdhu-9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223158>

Felipe Contreras wrote:
> On Wed, May 1, 2013 at 2:40 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>> You don't think I already tried that?  There is no way to sensibly
>> reorganize the old logic sensibly, in a way that doesn't break
>> anything.
>
> See, I tried to split your patch into logical changes, so I started with this:
>
> --- a/sha1_name.c
> +++ b/sha1_name.c

Thanks; I was finding this hard to do.  I'll try to continue from here.

> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -473,7 +473,7 @@ static int get_sha1_basic(const char *str, int
> len, unsigned char *sha1)
>                                 return -1;
>                         }
>                         /* allow "@{...}" to mean the current branch reflog */
> -                       refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
> +                       refs_found = dwim_log("HEAD", 4, sha1, &real_ref);

Yeah, I noticed this just a few minutes ago.  We really should have
tests testing @{N} against HEAD@{N}.

> Of course, this would be easy to see if you had bothered to split your
> patch into logical changes, but you didn't, so the change is lost in a
> mess. This is why it's not recommended to do that.

Right.  I'll try to redo this as multiple parts.

>> There's no need to associate one comment with one line of code.
>> People can see clearly see the failure case following it.
>
> Is that the way you defend your comments? People can see that the
> comment is wrong?

In that case, all the comments are wrong.  Even the ones about @{N}
and @{-N}, because we never really check @{\d+} or @{-\d+}.  Would you
like to make the comments more painful to read and write?

> 2) @{-1}@{-1} now doesn't return an error
>
> 3) @{-1}{0} returns an invalid object

Thanks for the tests!  I'll look into the problem.
