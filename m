From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 17/19] Portable alloca for Git
Date: Fri, 28 Feb 2014 18:19:58 +0100
Message-ID: <CABPQNSYnDjhxjpyZQkNP_qwect_tnPvJ_nEfGSq9qnYFMpehWg@mail.gmail.com>
References: <cover.1393257006.git.kirr@mns.spb.ru> <f08867ee212e27074dbb4cbb06af408b16dba0a1.1393257006.git.kirr@mns.spb.ru>
 <CABPQNSaVQuXBEnSrs6hdHwEbaBKFr-NjKpuBRNnbkM+HtfJ4Ag@mail.gmail.com>
 <CABPQNSadTGfiue6G+6x7_o10Ri1E7D5vZFU=Cp8rAha+j9jwSA@mail.gmail.com> <20140228170012.GA5247@tugrik.mns.mnsspb.ru>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Gerrit Pape <pape@smarden.org>,
	Petr Salinger <Petr.Salinger@seznam.cz>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Schwinge <tschwinge@gnu.org>
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Fri Feb 28 18:20:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJR75-0001nk-IK
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 18:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbaB1RUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 12:20:39 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:65283 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbaB1RUi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 12:20:38 -0500
Received: by mail-ig0-f169.google.com with SMTP id y6so2433317igj.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 09:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JxyeR1VFMQyh2dguaeVXIO6odnY6EGsnMb0g52OO9A0=;
        b=zyNwbgXfPhmYbB5/zG/USeMEgZMN+44Wx5OnI49h/ZNtAwg4pguHDn23z1jaR+ulbk
         nwnwTEH+pyVaA4MTzohyfZnXuzUGq9fXnInwiOy/zzIv2SUnAuD6kZtx8LVYnovkW5dw
         o0FSgrne2NauNUTl8lq2Kb8tr/l0wS5vbc57an7UrRktZSOQDIDvFKb1sZ7iLtyH4py9
         I5PkGstQE0K5qH3Z8LebcfH8Kotxu98pV9UiI5hLjh9VeM6ENss4jcwSz4RvFD+ZiPw4
         C2abdxHk9gDpoIFfkBnxwozguJQvDvFjqdHKR8yynkWKMayaxEDwO0FnLxPwoPO4JQ5r
         APwQ==
X-Received: by 10.42.41.82 with SMTP id o18mr11667893ice.50.1393608038275;
 Fri, 28 Feb 2014 09:20:38 -0800 (PST)
Received: by 10.64.166.135 with HTTP; Fri, 28 Feb 2014 09:19:58 -0800 (PST)
In-Reply-To: <20140228170012.GA5247@tugrik.mns.mnsspb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242990>

On Fri, Feb 28, 2014 at 6:00 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> On Fri, Feb 28, 2014 at 02:50:04PM +0100, Erik Faye-Lund wrote:
>> On Fri, Feb 28, 2014 at 2:44 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> > On Mon, Feb 24, 2014 at 5:21 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
>> >> diff --git a/Makefile b/Makefile
>> >> index dddaf4f..0334806 100644
>> >> --- a/Makefile
>> >> +++ b/Makefile
>> >> @@ -316,6 +321,7 @@ endif
>> >>  ifeq ($(uname_S),Windows)
>> >>         GIT_VERSION := $(GIT_VERSION).MSVC
>> >>         pathsep = ;
>> >> +       HAVE_ALLOCA_H = YesPlease
>> >>         NO_PREAD = YesPlease
>> >>         NEEDS_CRYPTO_WITH_SSL = YesPlease
>> >>         NO_LIBGEN_H = YesPlease
>> >
>> > In MSVC, alloca is defined in in malloc.h, not alloca.h:
>> >
>> > http://msdn.microsoft.com/en-us/library/wb1s57t5.aspx
>> >
>> > In fact, it has no alloca.h at all. But we don't have malloca.h in
>> > mingw either, so creating a compat/win32/alloca.h that includes
>> > malloc.h is probably sufficient.
>>
>> "But we don't have alloca.h in mingw either", sorry.
>
> Don't we have that for MSVC already in
>
>     compat/vcbuild/include/alloca.h
>
> and
>
>     ifeq ($(uname_S),Windows)
>         ...
>         BASIC_CFLAGS = ... -Icompat/vcbuild/include ...
>
>
> in config.mak.uname ?

Ah, of course. Thanks for setting me straight!

> And as I've not touched MINGW part in config.mak.uname the patch stays
> valid as it is :) and we can incrementally update what platforms have
> working alloca with follow-up patches.
>
> In fact that would be maybe preferred, for maintainers to enable alloca
> with knowledge and testing, as one person can't have them all at hand.

Yeah, you're probably right.
