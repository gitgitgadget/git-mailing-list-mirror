From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] diff: round down similarity index
Date: Mon, 25 Jun 2007 07:08:54 +0200
Message-ID: <85y7i8boyh.fsf@lola.goethe.zz>
References: <467EEEE6.3090100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jun 25 07:09:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2gou-0008Tr-NW
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 07:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbXFYFI6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 25 Jun 2007 01:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbXFYFI6
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 01:08:58 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:51073 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751485AbXFYFI5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 01:08:57 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 887A11E4F94;
	Mon, 25 Jun 2007 07:08:56 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 782EB212FAF;
	Mon, 25 Jun 2007 07:08:56 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-011-184.pools.arcor-ip.net [84.61.11.184])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 097073FE2;
	Mon, 25 Jun 2007 07:08:56 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id B34BB1D03440; Mon, 25 Jun 2007 07:08:54 +0200 (CEST)
In-Reply-To: <467EEEE6.3090100@lsrfire.ath.cx> (=?iso-8859-1?Q?=22Ren=E9?=
 Scharfe"'s message of "Mon\, 25 Jun 2007 00\:23\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.90.3/3517/Sun Jun 24 14:28:53 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50859>

Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> +static int similarity_index(struct diff_filepair *p)
> +{
> +	int result =3D p->score * 100.0 / MAX_SCORE;

Use floor(p->score ... MAX_SCORE) here: I don't think that C otherwise
specifies a preferred way of rounding on float->int conversions.

> +	/* Paranoia: guard against floating point rounding errors. */
> +	if (p->score =3D=3D MAX_SCORE)
> +		result =3D 100;
> +	else if (result =3D=3D 100)
> +		result =3D 99;

Also, p->score itself must be calculated by truncating.

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
