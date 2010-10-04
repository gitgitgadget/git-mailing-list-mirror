From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] diff: "S_IFREG | 0644" to "(S_IFREG | 0644)" to avoid warning
Date: Mon, 4 Oct 2010 09:42:13 +0000
Message-ID: <AANLkTim+QH6=XJikOsZs=qt9ZFHjP7gWz0zo9n4vz+gk@mail.gmail.com>
References: <1286184071-28457-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Dan McMahill <dmcmahill@netbsd.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Steven Drake <sdrake@xnet.co.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 11:42:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2hYp-0005A7-SO
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 11:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458Ab0JDJmO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 05:42:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62999 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab0JDJmO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 05:42:14 -0400
Received: by iwn5 with SMTP id 5so6701905iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 02:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HtncWQq8/n+PL76SmoZle94Ka0M3pYoT/1wuKD4Xf6M=;
        b=GjkGlc/4MQNhYc+e7wUTfpVzT7vAvE4e6mfOoW6mlQT8j6Ba18osLLHs7G7bwzawf0
         5R5tTVFzhr4mA/Fo2EmhnLmB7R7SnfNihqx9qBGYuCQ8u3/hX3xcGKYFMzhMgKuFol8i
         5HSkzuEufz/wOJzuf/i0e6tZ5RT4XmbxpI4nE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rjJyjQ1iCxsBeNT4McRfN0Xo5TSenLpJOb5hRXv0MLsu0NO7ifGRbak0FgSWRWY1Hj
         gsed2nUnXB0IkpoWve75fKOBt1dFokQ9LEboniJMVSCT1R24G3M7NfBmHejoi6ZuVLza
         RM0CltuRJ80xxU19souM5P7eR6ZkyP4C2Rq7c=
Received: by 10.231.11.3 with SMTP id r3mr9883776ibr.53.1286185333552; Mon, 04
 Oct 2010 02:42:13 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 4 Oct 2010 02:42:13 -0700 (PDT)
In-Reply-To: <1286184071-28457-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158020>

On Mon, Oct 4, 2010 at 09:21, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> Wrap "S_IFREG | 0644" in parentheses to avoid a "suggest parentheses
> around arithmetic in operand of |" warning from GCC 4.1.3 on NetBSD
> 5.0.2.
>
> I spotted and fixed this independently on NetBSD, but later found tha=
t
> there was a NetBSD Problem Report that included this fix.

With this and Jonathan's xdiff patch git compiles without warnings on
NetBSD, aside from this:

    imap-send.c: In function 'ssl_socket_connect':
    imap-send.c:310: warning: assignment discards qualifiers from
pointer target type
    imap-send.c:312: warning: assignment discards qualifiers from
pointer target type

I don't see a sane way around that[1], since it appears the NetBSD
people have patched openssl's function definitions without bumping the
OpenSSL version number. Either that or OpenSSL itself changed from
const char* to char* to const char* again, I didn't investigate that.

But tests on NetBSD with /bin/sh still fail since we use cd -P, but we
have unapplied patches for that so I didn't pursue it:

    http://article.gmane.org/gmane.comp.version-control.git/136561/matc=
h=3D
    http://article.gmane.org/gmane.comp.version-control.git/136562/matc=
h=3D

1. We could check for __NetBSD__ and the NetBSD version, but it's not
   worthwhile for a single warning.
