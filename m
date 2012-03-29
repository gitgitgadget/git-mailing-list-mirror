From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v2 6/8] gitweb: Push formatting diff lines to
 print_diff_chunk()
Date: Thu, 29 Mar 2012 19:41:53 +0200
Message-ID: <20120329194153.2e1ad827@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1332543417-19664-7-git-send-email-michal.kiedrowicz@gmail.com>
	<201203291859.44891.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 19:42:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDJMR-0005Kz-IC
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 19:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759194Ab2C2Rl6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 13:41:58 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62956 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759052Ab2C2Rl5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 13:41:57 -0400
Received: by wgbdr13 with SMTP id dr13so1783143wgb.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=ia9UDhOmckbgkdmg92Z6M6BmS5k/6/2cVZ3ABjVjrC4=;
        b=XEfOORGUN/ylqB12GG/3YT2HsBe6KBdZ1WOHKEwfpNoKDIppEmYL1nOD5xS2gVrftk
         qJdP22DQ++kNKU20YIaHNsRIRf6ijo2UMSWIwJpMjlsNUboDR/6x3F8RPfZw6npgRKtJ
         eWjn4BTVTBXwyPScXbtv0Vdl+faxC02YY4LmrbIuOaoER23uLNd351F0rrAyWvea4U3D
         bfEDvZ83EdFp3TDAhurbkfiG+dETy6w0+3m2wwtipzNy8nl4hwePXIpayTiebvSk8tMS
         vOzmQbagim4vDCB8av0U5iJqzQv2lHyXwvrNG2SehImRrbeo2Y9B0S1RlzFUwug4VKcs
         XErg==
Received: by 10.180.24.7 with SMTP id q7mr7711642wif.11.1333042916339;
        Thu, 29 Mar 2012 10:41:56 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id w10sm31331758wiy.3.2012.03.29.10.41.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 10:41:55 -0700 (PDT)
In-Reply-To: <201203291859.44891.jnareb@gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194279>

Jakub Narebski <jnareb@gmail.com> wrote:

> On Fri, 23 Mon 2012, Micha=C5=82 Kiedrowicz wrote:
>=20
> > Now git_patchset_body() only calls diff_line_class(), which is remo=
ved
> > from process_diff_line(). The latter function is renamed to
> > format_diff_line() and its output is changed to return only
> > HTML-formatted line, which brings it in line with outher format_*
> > subroutined.
> >=20
> > This slightly changes the order of operations performed on diff lin=
es.
> > Before this commit, each read line was formatted and then put to th=
e
> > @chunk accumulator. Now, lines are formatted inside print_diff_chun=
k(),
>=20
> This is a bit convoluted description.
>=20
>=20
> As I understand it, what happens here is that formatting lines is
> pushed down to print_diff_chunk(), closer to the place where we
> actually use HTML formatted output.

Yes.

>=20
> This means that we put raw lines in the @chunk accumulator, rather
> than formatted lines.  Because we still need to know class (type)
> of line when accumulating data to post-process and print,=20
> process_diff_line() subroutine was retired and replaced by=20
> diff_line_class() used in git_patchset_body() and new / resurrected
> format_diff_line() used in print_diff_chunk().
>=20
> Isn't it?

Very true.

> =20
>=20
> A side effect is that we have to pass \%from and \%to down the
> callstack.

Yes.

>=20
> > This is a preparation patch for diff refinement highlightning. It's=
 not
> > meant to change gitweb output.
> >=20
> This is a very nice refactoring.  I was never really comfortable with
> the API of process_diff_line(), which was different from all other
> subroutines in gitweb, and error prone to call.  I wish we used this
> solution presented in this commit from the very beginning.
>=20
> BTW. I think we can simply squash this commit with previous one; no
> need to improve process_diff_line() if we are retiring it.

OK, will do.

>=20
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> > Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> > ---
> >  gitweb/gitweb.perl |   25 ++++++++++++-------------
> >  1 files changed, 12 insertions(+), 13 deletions(-)
>=20
