From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] grep: fix match highlighting for combined patterns with
 context lines
Date: Sun, 26 Oct 2014 19:15:24 +0100
Message-ID: <544D3A3C.4080906@web.de>
References: <1413870963-66431-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Zoltan Klinger <zoltan.klinger@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 26 19:15:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiSM8-0000E7-Jg
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 19:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbaJZSPx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Oct 2014 14:15:53 -0400
Received: from mout.web.de ([212.227.17.11]:55035 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbaJZSPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 14:15:52 -0400
Received: from [192.168.178.27] ([79.250.186.219]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LkyEb-1YGQGF3H5Z-00apcJ; Sun, 26 Oct 2014 19:15:46
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <1413870963-66431-1-git-send-email-zoltan.klinger@gmail.com>
X-Provags-ID: V03:K0:2QK1nb0uQC1l+YMPpU0XHHpJ8OICh0TrjL6WLBI0HFRn4O9Q7v6
 IOm4bxqPQyIFVhIVNQveUKrjtCiaKyJz9xM+BgumnwtzXsr3/cl1lkC0tbd0tx9vpLq5Lbt
 9YwaMNG+4EqT/BEc0wWXo32Ks3qBomvioXaEaZ5ZYvvSImiNZgLNShlmG+6FUAzm9yMpwQL
 s2cNmzLl+MnD2pfTkjwXQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.10.2014 um 07:56 schrieb Zoltan Klinger:
> When git grep is run with combined patterns such as '-e p1 --and -e p=
2'
> and surrounding context lines are requested, the output contains
> incorrectly highlighted matches.
>
> Consider the following output (highlighted matches are surrounded by =
'*'
> characters):
>      $ cat testfile
>      foo a
>      foo b
>      foo bar
>      baz bar foo
>      bar x
>      bar y
>      $ git grep -n -C2 -e foo --and -e bar testfile
>      testfile-1-*foo* a
>      testfile-2-*foo* b
>      testfile:3:*foo* *bar*
>      testfile:4:baz *bar* *foo*
>      testfile-5-*bar* x
>      testfile-6-*bar* y
>
> Lines 1, 2, 5 and 6 do not match the combined patterns, they only
> contain incorrectly highlighted 'false positives'.

The old code highlights all search terms, anywhere. I wouldn't call the=
=20
ones in the context lines false positives.  The user might be intereste=
d=20
in those occurrences as well (I know I am ;).

GNU grep allows coloring to be configured in much greater detail with=20
its GREP_COLORS variable.  I didn't think that level of tuning is=20
desirable until now.  What your patch does is equivalent to change the=20
default of "ms=3D01;31:mc=3D01;31" (color matching string in selected l=
ines=20
and context lines) to "ms=3D01;31:mc=3D" (color matching string in sele=
cted=20
lines).

The difference is only visible with -v or git grep's --not and --and.

So, if you really don't want matching string in context lines to be=20
colored, perhaps it's time to add a color.grep.contextmatch for matchin=
g=20
text in context lines?

Ren=E9
