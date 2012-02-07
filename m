From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Mon, 6 Feb 2012 21:01:21 -0800
Message-ID: <CAJDDKr6A2UvB3D-Dapw7WCEzWfzLoLd0E8MSDjT0RtdxFeWZAQ@mail.gmail.com>
References: <20120206062713.GA9699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 06:01:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RudBG-0008Ib-Ka
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 06:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960Ab2BGFBW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 00:01:22 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59380 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab2BGFBV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 00:01:21 -0500
Received: by ghrr11 with SMTP id r11so2960730ghr.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 21:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YPSSj3ghYdAgDvW5KUlym8D5CGo40/qZQlRb43tkKMs=;
        b=KT6bs8tORYGZmoqjbZR3VDDsKripYnsTrrZ+K/a8fNQzEN1IFhpw0hdhYhKOmpRIdu
         NVzXzGOnBzgP3h+/lAmAX67Va2sH8pSAWY3Yqi5ehfHh5YqnkXpAOjMwozgNBJRtrevF
         0kEPFwiM8DzCYAP4k4ajomaMz7DFKyHm0MxnQ=
Received: by 10.236.80.41 with SMTP id j29mr573191yhe.85.1328590881110; Mon,
 06 Feb 2012 21:01:21 -0800 (PST)
Received: by 10.146.249.16 with HTTP; Mon, 6 Feb 2012 21:01:21 -0800 (PST)
In-Reply-To: <20120206062713.GA9699@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190139>

On Sun, Feb 5, 2012 at 10:27 PM, Jeff King <peff@peff.net> wrote:
> That leaves the file-inclusion bits:
>
> =C2=A0[1/2]: imap-send: remove dead code
> =C2=A0[2/2]: config: add include directive
>
> The first patch is new in this round, and is a necessary cleanup for =
the
> second patch (though it might be worth applying regardless).
>
> The second patch corresponds to patch 1/4 from the previous round. Am=
ong
> the functional changes are:
>
> =C2=A01. do not use includes for "git config" in single-file mode

I have a questions about this.  Let's say I have ~/foo1.gitconfig:

[foo]
    bar =3D 1

=2E..and ~/.gitconfig (I forgot the syntax):

[foo]
    bar =3D 0

#include "~/foo1.gitconfig"


Does that mean that:

    $ git config -f ~/.gitconfig foo.bar

=2E..prints 0 and not 1?

I can see cases where this would be undesirable behavior.

=46or example, an application that uses "git config -z --list -f
~/.gitconfig" might expect that the result encompasses all of the
user-specific config bits.

=46ollowing this to its natural conclusion means "git config" might
learn some kind of --no-include flag for use with e.g. "git config
--no-include -f ~/.gitconfig".  That said, I don't know where I would
ever actually use such a flag.

I do know where I would use an `--include` flag (if following includes
were not the default behavior when using '-f'), though, and that's why
I'm asking.  The problem with not having it be the default means we
have to use a flag.  This makes it harder to support multiple versions
of git.

Maybe I'm mis-interpreting what you mean by, 'do not use includes for
"git config" in single-file mode', though.
--
David
