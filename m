From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 3/4] diff --stat: use the real terminal width
Date: Fri, 10 Feb 2012 12:25:14 +0100
Message-ID: <4F34FE9A.7020600@in.waw.pl>
References: <1328831921-27272-1-git-send-email-zbyszek@in.waw.pl> <1328831921-27272-4-git-send-email-zbyszek@in.waw.pl> <CACsJy8APGeTNv_E3qD=xFCiLC25M_nm3aJbq6YU73J=X0Wxh2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 10 12:25:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvobc-00029M-5q
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 12:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758851Ab2BJLZ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 06:25:27 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52329 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758689Ab2BJLZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 06:25:26 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RvobQ-0007yW-Lx; Fri, 10 Feb 2012 12:25:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <CACsJy8APGeTNv_E3qD=xFCiLC25M_nm3aJbq6YU73J=X0Wxh2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190400>

On 02/10/2012 07:15 AM, Nguyen Thai Ngoc Duy wrote:
> 2012/2/10 Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>:
>> @@ -1341,7 +1342,7 @@ static void show_stats(struct diffstat_t *data=
, struct diff_options *options)
>>                 line_prefix =3D msg->buf;
>>         }
>>
>> -       width =3D options->stat_width ? options->stat_width : 80;
>> +       width =3D options->stat_width ? options->stat_width : term_c=
olumns();
>>         name_width =3D options->stat_name_width ? options->stat_name=
_width : 50;
>>         count =3D options->stat_count ? options->stat_count : data->=
nr;
>
> I tried this in the past and "git log -p" looked ugly on git.git
> mainly because commit messages are still ~70 char long lines on my 27=
9
> char wide terminal. If this is project dependent, perhaps a config
> key? Also the "50" below the changed line, maybe you want to change i=
t
> to 0.6 * width.

Thanks for all the comments. I'll post a newer version, but I have two=20
questions:

I agree that making the output very wide with lots of +- is not very=20
elegant. (E.g. 8f24a6323ece9be1bf1a04b4b5856112438337f2 has
    builtin/grep.c |  142 +++--------------------------------....--
which doesn't look right.). So I think it would make sense to limit
the graph part to something like 50 columns, even if there's more space=
=2E
I believe that git.git would look fine with this change. There are some=
=20
fairly long lines=20
(t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=3DTESTCAS=
E_initial..master=20
is 86 chars) but with 50 columns of graph the output would take 140=20
columns -- with the graph part slightly sticking out from the 80 column=
=20
descriptions, but still not too ugly.

Should I add a new option --stat-graph-width in analogy to=20
--stat-name-width, or should this be hard-coded?

JC:
 > The output from "git format-patch" shouldn't be affected at all by t=
he
 > width of the terminal the patch sender happened to have used when th=
e
 > command was run when the user did not explicitly ask a custom width =
by
 > giving a --stat-width command line option.
 >
 > How do you prevent regression to the command in this series?
git format-patch is not affected by default. But with --stdout
the width is changed, iff stdout is a tty. When --stdout output
is connected to a pipe, the width is not changed. I think that
this behaviour is OK.

Should a test be added to check that 'git format-patch --stat' output=20
doesn't change? Should I test for something else?

--
Zbyszek
