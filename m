From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCHv3 1/8] Introduce commit notes
Date: Wed, 29 Jul 2009 10:52:56 +0200
Message-ID: <81b0412b0907290152w27c1b5b5l9efbd6980d4f904e@mail.gmail.com>
References: <1248834326-31488-1-git-send-email-johan@herland.net>
	 <1248834326-31488-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, johannes.schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 10:53:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW4uH-0004WG-W7
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 10:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbZG2Iw6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 04:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbZG2Iw5
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 04:52:57 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:32789 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbZG2Iw5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 04:52:57 -0400
Received: by fxm18 with SMTP id 18so247698fxm.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fpI4wRJM48SogjrDtFxp0ogYRW1Ws2clJUkmuNizUoo=;
        b=itHKg1cKACMHHRHHqRcnUYxqGrMEeeUA46cAP9ZsuzTMr3wP3n9y9aRN+sGaT759hB
         PR4uLzzrRhMLIqQM3/QgdI0CAUBmQT4yTrjXHqjI3bt6ngDDo54CJ+bjeoWJ6Mbjef8m
         zgby5aXGFgY2fWcEODccr7DCfl3rOBArVjjKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T9+rdGyiq7jpjkz2DTPQ+WQDEs82iylcpelh2cTPWYmmZNlZiWOzMJP4akf9iP1G4Z
         n0sEAWD+CBizh5v8ZdGA9ZvQFx7ZWxygzEX6kfx2JoN1jPEwpIc84ka1D2PARLmA0YvY
         Qvdpjxz0urB+qXNyYlDCFwZitvN/9YKv4B424=
Received: by 10.204.119.129 with SMTP id z1mr5350762bkq.67.1248857576470; Wed, 
	29 Jul 2009 01:52:56 -0700 (PDT)
In-Reply-To: <1248834326-31488-2-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124330>

On Wed, Jul 29, 2009 at 04:25, Johan Herland<johan@herland.net> wrote:
> +void get_commit_notes(const struct commit *commit, struct strbuf *sb=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *output=
_encoding)
> +{
> + =C2=A0 =C2=A0 =C2=A0 static const char *utf8 =3D "utf-8";

Using an array

  const char utf8[] =3D "utf-8";

costs you less BSS (no separate storage for the pointer).

> @@ -963,5 +964,9 @@ void pretty_print_commit(enum cmit_fmt fmt, const=
 struct commit *commit,
> +
> + =C2=A0 =C2=A0 =C2=A0 if (fmt !=3D CMIT_FMT_ONELINE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_commit_notes(c=
ommit, sb, encoding);
> +

Someday we will need a way to switch off the display of notes
without resolving to oneline format.
Is there a notes specifier for the printf-like log message formatting
(--pretty=3Dformat: or --format) planned, BTW?
