From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Sat, 7 Apr 2012 01:05:51 +0300
Message-ID: <CAMP44s0VWWuM6eeij_nys9OAqu6Jr87Wv4K56mbbqhuMbVXKaQ@mail.gmail.com>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
	<20120406201926.GA1677@sigill.intra.peff.net>
	<CAMP44s0n+dyp-QNOPtiKtGX1VNOsM8GJOLLCksqwPArR+FS8ng@mail.gmail.com>
	<20120406213448.GA5436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 00:06:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGHI6-0000Dj-5H
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 00:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758229Ab2DFWFx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 18:05:53 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:65411 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358Ab2DFWFx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 18:05:53 -0400
Received: by wgbdr13 with SMTP id dr13so2493980wgb.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=WZwYMMtBleW5xa50B4EGMekQOLoohJEF94rcp0b0f/g=;
        b=ieTG94CDBxa/IibjM5Bz2O8tzdb/tow58xdxCVPsZ+UAxADhtva/rqPK9Jtsd1nkZl
         36TMQ6MPgqzlHysnXBlk4OHZTBtl8F8RLuCw/EZCN5WAxh4YxRJAIO38tqdf7oLmGMdj
         8LprH6IBmYtxiLe3ca/ZHn7I2prPJzPA6UHFbCbdz7yqe4sgbpWiqNHlR/iRevbgxg6u
         JJOxZ2SEAlTWhzWDiyU1oFZGqQ/DEOGBMM9Q/h5h2LXMfHsReaCMKRXSc0cDteqHvgz+
         cOxtNqQmD3mDMyul9X7q8W7MDl5k6a71IYkyMr438lNa4i3UXe9TPaDdRcCXqHlFrf7l
         7LaQ==
Received: by 10.180.92.71 with SMTP id ck7mr14630443wib.21.1333749951966; Fri,
 06 Apr 2012 15:05:51 -0700 (PDT)
Received: by 10.216.70.4 with HTTP; Fri, 6 Apr 2012 15:05:51 -0700 (PDT)
In-Reply-To: <20120406213448.GA5436@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194917>

On Sat, Apr 7, 2012 at 12:34 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 07, 2012 at 12:21:35AM +0300, Felipe Contreras wrote:
>
>> On Fri, Apr 6, 2012 at 11:19 PM, Jeff King <peff@peff.net> wrote:
>> > On Fri, Apr 06, 2012 at 10:28:39PM +0300, Felipe Contreras wrote:
>>
>> > I think you need to start with something like:
>> >
>> > =C2=A0#!/bin/sh
>>
>> That is irrelevant, even if it's '#!/bin/foobar', it wouldn't make a=
ny
>> difference since the actual command would be something like
>> '$(SHELL_PATH) t9902-completion.sh'.
>
> True; I thought "prove" would run them directly, but even it uses
> $(SHELL_PATH) to run the tests. However, doesn't that mean your test
> will fail completely when $(SHELL_PATH) isn't bash?

Yes.

> So yes, the #! isn't relevant to "make test" (though marking it as
> #!/bin/sh does serve as documentation for what you expect,

No, it's the opposite; #!/bin/sh would imply that you can run this
with any POSIX shell; you can't. For example, if /bin/sh points to
dash (which is the case in debian AFAIK), the test would fail in the
middle of it. #!/bin/bash would be more proper; it would properly
document that you need bash to run this. Sure, maybe bash is not in
/bin (I have never seen that), but that would not affect 'make tests',
only the people that want to run this directly, which I suspect are
very, *very* few, and they would immediately see a clear error:
'./blah: /bin/bash: bad interpreter: No such file or directory', and
then they could easily try 'bash ./blah'.

> But my point still stands that you cannot assume that you are running
> bash, and you need to either find bash, or gracefully exit the test
> script if it is not available. Anything else will cause "make test" t=
o
> fail on some systems (and indeed, applying and running your test, it
> breaks "make test" on my debian box with dash as /bin/sh).

So? 'make test' fails on my Arch Linux box which doesn't have
/usr/bin/python, which is presumably why there is NO_PYTHON. Instead
of doing some nasty hacks such as 'bash <<\END_OF_BASH_SCRIPT', it
would be much easier to have a NO_BASH option. And in fact, when zsh
completion tests are available, NO_ZSH (probably on by default).

But you clearly prefer the status quo, so I'm not going to bother.

--=20
=46elipe Contreras
