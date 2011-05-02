From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC 0/4] grep: support to match by line number
Date: Mon, 2 May 2011 21:14:22 +0200
Message-ID: <BANLkTi=jABd5+_R-5SjhR163WV=TF1wbmQ@mail.gmail.com>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
	<BANLkTi=NOaWN56qBACoTE2WQWFM3rHXfWA@mail.gmail.com>
	<BANLkTikvYLKKj_Wd0EOxZh+vANxju4CV6Q@mail.gmail.com>
	<7v7ha9oxss.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:14:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGyZh-0005xN-6k
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 21:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab1EBTOY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 15:14:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50081 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868Ab1EBTOX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 15:14:23 -0400
Received: by fxm17 with SMTP id 17so3840217fxm.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=236ZOgqxbRelwP9Azi1ES4pAW53AmQvh0K5YhbQVj1o=;
        b=vLzpUFB0dmug2ipQ4WbMJwqPYJM8AQZaMhuKz0hF3pM85UiQzTVksPGrSvv2zde4si
         thKEiwjtXl59fkG+38iDHfhUNuxwpXmioAlrYJeNOw2sJz4+KAJMK2GLIUfKaIYk07BL
         a8PKvbwueVv9a3rxYs2usL7Fk5fkavPgqom2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ye50Ywnrzd/wwMo4rK+4YFPdoLyk4i2RRkNvf0jj/UQmec1WWp7mtNe/QZ2MSYKTTK
         xfk5v8W+uBHQyLjd2vdyRYDBbnDriTRNCfiSjzjLSAs8ukUAIEk78kSuyCr9TRALj3mb
         2DmOk5VXRnocEZ7sjlxxBqqZJ1LPvh4Csfx20=
Received: by 10.223.145.78 with SMTP id c14mr1835880fav.75.1304363662431; Mon,
 02 May 2011 12:14:22 -0700 (PDT)
Received: by 10.223.71.205 with HTTP; Mon, 2 May 2011 12:14:22 -0700 (PDT)
In-Reply-To: <7v7ha9oxss.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172618>

On Mon, May 2, 2011 at 18:46, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>>> Can you give a concrete example of how you'd use this? I'm not sure=
 I
>>> understand the described use case.
>>
>> I parse the output of compiling a file, there may be warnings or eve=
n
>> errors, I collect the given line numbers, and then call 'git grep -p
>> -C -n (-@ <lno>)+ -- <path>' to show me what these warnings are abou=
t.
>
> What would you do next after doing that? =C2=A0Open the file in your =
editor and
> jump to the line found by the grep? =C2=A0Oh, wait, that's the same l=
ine as
> your compiler already found for you.

A build run will probably produce many warnings or errors (think of
-j) for many files, so you need to handle more than one file. After
the build run, you get a list of files which have warnings/errors,
selecting one of the files will give you the original messages
including the grep -@ output, from there you can select which message
you want to consider opening in the editor, so grep -@ helps you in
your decision what to open in your editor. If this would all be in a
terminal your original output would be far away anyhow.

I haven't implemented this 'workflow' for the terminal, but for a GUI,
so I can jump to original output easily and open the file in the
editor easily too. Prior to this I did this all on the command line,
but with recursive make this become too cumbersome.

>
> And when you open the file in your editor, doesn't it show offending =
line
> in the middle of the screen? =C2=A0You can even fix it up right there=
=2E =C2=A0Isn't
> your editor wonderful?
>
> The extra "grep -@" step in-between looks like a totally made-up use =
case
> that is not interesting nor convincing.
>
>

Visually parsing many warnings/errors of one file by successively
jumping to the offending line in the editor doesn't sound very
productive to me, but having all offending lines with context and
--show-functions in one output does sound.

Bert
