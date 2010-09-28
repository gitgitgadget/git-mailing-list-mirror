From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 0/2] use libcharset.h with gettext if available
Date: Tue, 28 Sep 2010 23:47:38 +0200
Message-ID: <AANLkTinxSqPD8H4Giigb1vbi7DC2wpDVqWmXGVZXmeKQ@mail.gmail.com>
References: <AANLkTinHCETsaM=ytHuE9S5A+uAb=e3YLETsJJLga+DM@mail.gmail.com> <1285698577-28395-1-git-send-email-avarab@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 23:49:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0i3H-0004bt-3H
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 23:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381Ab0I1Vt0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 17:49:26 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35508 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0I1VtZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 17:49:25 -0400
Received: by gyh20 with SMTP id 20so56182gyh.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=OMuuFCbKnKRyFohUxovHY4sGADcChzqG+R7o4hlMLCc=;
        b=u+ls3aPlHJ7Oo3LKYfh3oyxOLhMnb8EY+27cqo2K1QsnfdhscdvMI7YYvfpCU181wn
         rU1IAzq6/JKpodBkGGckMg1ItD0Rg1mkuMWLxlzJtQSoB6Uq5hnAhV2YU86dkVrbuYFS
         DQeAdhAmSfrMP7590puJCIMSmczmUqCkoVjQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=NHZTr/BfSAsTj0EE/xmhT1L+k9We4nwhji+5gvEeDp0HSvepvFhTqDjN1Yjyn54XQS
         EcbNYFc+LibzSK+yiKGfLwClN/qCzStwJO6VuyuBQ4UYNvhUt2XVa7ImeWXPrvJOIDs/
         w3I5EYI7I0rezYiU2yYsIDv34QMyPZl6A0dnc=
Received: by 10.220.169.14 with SMTP id w14mr165276vcy.17.1285710478985; Tue,
 28 Sep 2010 14:47:58 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Tue, 28 Sep 2010 14:47:38 -0700 (PDT)
In-Reply-To: <1285698577-28395-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157480>

On Tue, Sep 28, 2010 at 8:29 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> Yeah, I'm hoping it'll get into next soon so we can get more
> reports/fixes like these. Anyway, I amended your patches a bit, here
> are the changes:
>
> =A0* Split up the s/char*/const char*/ change into its own patch, or =
is
> =A0 there a reason for why this needs to be there along with the
> =A0 libcharset.h change?
>

The reason was that my version of locale_charset() returns a const
char *, so I got a warning if I didn't. nl_langinfo() returns a char
*, so I don't think that constness-fix patch makes sense in itself.
But what might make more sense would be to squash it into the original
commit for that line.

> =A0* Added docs about the define to the Makefile
>

Nice!

> =A0* Added defaults for NO_LIBCHARSET to the default, I only changed =
the
> =A0 defaults for the MINGW entry, maybe it should be changed on Cygwi=
n
> =A0 and Windows too? And probably on OpenBSD and NetBSD too.
>

I don't think NO_LIBCHARSET should be the default. libcharset is
reported to be a bit better than nl_langinfo at normalizing the
encoding, and GNU gettext depends on libcharset (through libiconv,
which libcharset is distributed with). So in the case of a GNU
gettext, libcharset should really be present.

> Erik Faye-Lund (2):
> =A0gettext: use const char* instead of char*
> =A0gettext: use libcharset when available
>
> =A0Makefile =A0 =A0 | =A0 17 +++++++++++++++++
> =A0configure.ac | =A0 =A06 ++++++
> =A0gettext.c =A0 =A0| =A0 10 +++++++++-
> =A03 files changed, 32 insertions(+), 1 deletions(-)
>
> --
> 1.7.3.159.g610493
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
