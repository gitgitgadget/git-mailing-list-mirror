From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Thu, 29 Sep 2011 21:54:04 +0200
Message-ID: <CABPQNSba+nQ+AOmVEVNWhJi2e65EiuhRxfOWZsW03Pkc6zXdHg@mail.gmail.com>
References: <4E37202B.80208@lsrfire.ath.cx> <20110802040004.GC17494@sigill.intra.peff.net>
 <4E3829DC.8070802@lsrfire.ath.cx> <20110802181357.GA1861@sigill.intra.peff.net>
 <4E388A55.6080606@kdbg.org> <4E3D0C1D.9000807@lsrfire.ath.cx>
 <4E3EEF3B.80908@kdbg.org> <4E401869.8060702@lsrfire.ath.cx>
 <20110809050211.GA3588@sigill.intra.peff.net> <4E410B26.1080407@lsrfire.ath.cx>
 <20110809200504.GA31944@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 21:55:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9MhB-0006bl-VU
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 21:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757590Ab1I2Tyr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 15:54:47 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:52538 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757542Ab1I2Typ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 15:54:45 -0400
Received: by pzk1 with SMTP id 1so2511804pzk.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=/9e71Xhej9KGplmBnIWhrSM86Itz30pJFotTCAaRYlc=;
        b=lzovPbsBOxvbFZ0JAUMLVcHxQKOjsvyLPQ1pUhSt22k5W5hnVqECx3RQgcaSFgvpNz
         sg9Vij87Z5uX5spLkdVVwTn1KB5aP2ffVTu8R08jjJM5vQMnMdgqnA8JoSCbrGA6NPua
         y450oEMvSSuh9eZ9sO2N/f5jQQXo8AP17wbuo=
Received: by 10.68.4.132 with SMTP id k4mr52993132pbk.78.1317326084252; Thu,
 29 Sep 2011 12:54:44 -0700 (PDT)
Received: by 10.68.42.169 with HTTP; Thu, 29 Sep 2011 12:54:04 -0700 (PDT)
In-Reply-To: <20110809200504.GA31944@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182427>

OK, this is quite late, but I've got some news on the subject.

On Tue, Aug 9, 2011 at 10:05 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 09, 2011 at 12:25:42PM +0200, Ren=E9 Scharfe wrote:
>
>> > BTW, as nice as this "gzip -cn | cat" idea is, I think it needs to=
 be
>> > wrapped in a shell script. With the code above, we will generate "=
gzip
>> > -cn | cat -9".
>>
>> Yes, the three added lines in the patch above would have to be moved
>> down two lines, after the compression level is added. =A0D'oh!
>
> Also, is adding "| cat" also sufficient for arbitrary shell code (i.e=
=2E,
> whatever the user hands us via the config)? I couldn't think of an
> example that wouldn't work.
>
>> OK, that's one way to do it; another would be let gzip (and bzip2 et=
c.)
>> do whatever cat does to avoid end of line conversions. =A0And yet an=
other
>> is to take them from http://unxutils.sourceforge.net/.
>
> Yeah, I like all of those solutions better than hacking an extra pipe
> into git. I don't know enough to say how painful they are in practice=
,
> though.
>

It turns out, if I compile gzip myself from source the test pass just
fine. So the problem seems indeed to be MSYS vs non-MSYS applications.

So the way forward is probably to just change to a self-compiled gzip
in msysGit (and Git for Windows by proxy).

I'll post the patch to build a native-gzip to the msysGit mailing list
(I only got 1.2.4 to compile on Windows, but it's the same version as
we have in msysGit so it's probably fine), and post the latest version
of this series soon...
