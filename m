From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] diff: resurrect XDF_NEED_MINIMAL with --minimal
Date: Mon, 3 Oct 2011 21:04:28 +0800
Message-ID: <CALUzUxrfUF5sbgSv3dwkBC6cggV3mqRDDMrpP-zX_86xdt6ZYA@mail.gmail.com>
References: <7voby0j86c.fsf@alter.siamese.dyndns.org>
	<20111003123843.GA15493@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 15:04:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAiCD-00029N-EK
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 15:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818Ab1JCNEd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 09:04:33 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33083 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645Ab1JCNEc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 09:04:32 -0400
Received: by eya28 with SMTP id 28so2743704eya.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Z/2yCDSUU0uBxH4HLS2oA+yT3mfCiVWZOeh8JR1M50s=;
        b=s+Rgu5YWYapA5uRAkMdTk2QyR2PKBBBI6wLEd8xAvXfARZwVL9M+blnnQHGy0xSQTW
         TarkPNNcPn8kJZtdybhvI5k+tSzw8nyFqYShTsId0zyuAcd3ljYliG79rOFcrhgxdrMN
         IRBSHUq2DL2Z4S6/HT3ktgP2xpjIsGSADrPkA=
Received: by 10.223.42.24 with SMTP id q24mr15018183fae.45.1317647069073; Mon,
 03 Oct 2011 06:04:29 -0700 (PDT)
Received: by 10.223.81.74 with HTTP; Mon, 3 Oct 2011 06:04:28 -0700 (PDT)
In-Reply-To: <20111003123843.GA15493@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182660>

On Mon, Oct 3, 2011 at 8:38 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

Thanks for the Cc, Johnathan.

> Junio C Hamano wrote:
>
>> =A0* This together with Ren=E9's c5aa906 (Revert removal of multi-ma=
tch
>> =A0 =A0discard heuristic in 27af01, 2011-09-25) on top of v1.7.7 see=
ms to give
>> =A0 =A0identical diff output as v1.7.1 (e.g. "git diff-tree -p v2.6.=
39 v3.0"
>> =A0 =A0in the kernel repository, with "--minimal").
>
> Very neat.

Interesting. Clearly there is more than just the multi-match discard
heuristic in (xdl_clean_mmatch() and xdl_cleanup_records()).

> diff --git i/diff.c w/diff.c
> index fcc00780..2282f86f 100644
> --- i/diff.c
> +++ w/diff.c
> @@ -3393,6 +3393,10 @@ int diff_opt_parse(struct diff_options *option=
s, const char **av, int ac)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DIFF_XDL_SET(options, IGNORE_WHITESPAC=
E_AT_EOL);
> =A0 =A0 =A0 =A0else if (!strcmp(arg, "--patience"))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DIFF_XDL_SET(options, PATIENCE_DIFF);
> + =A0 =A0 =A0 else if (!strcmp(arg, "--minimal"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DIFF_XDL_SET(options, NEED_MINIMAL);
> + =A0 =A0 =A0 else if (!strcmp(arg, "--no-minimal"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DIFF_XDL_CLR(options, NEED_MINIMAL);
> =A0 =A0 =A0 =A0else if (!strcmp(arg, "--histogram"))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DIFF_XDL_SET(options, HISTOGRAM_DIFF);
>
>

That's an improvement, but it would be even better if it was placed
above the --<strategy> options, instead of being placed between them.

--=20
Cheers,
Ray Chuan
