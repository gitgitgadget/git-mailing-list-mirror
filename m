From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Avoid recalculating filename string pointer.
Date: Thu, 22 Nov 2007 20:54:57 +0100
Organization: glandium.org
Message-ID: <20071122195457.GB19675@glandium.org>
References: <b8bf37780711211659i65a99493te3e3d5cee008ae7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-15?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:55:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvI9O-0008EH-M1
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 20:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbXKVTzC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 14:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754012AbXKVTzB
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 14:55:01 -0500
Received: from [80.12.242.17] ([80.12.242.17]:20310 "EHLO smtp19.orange.fr"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbXKVTzA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 14:55:00 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1907.orange.fr (SMTP Server) with ESMTP id 883D61C0009B
	for <git@vger.kernel.org>; Thu, 22 Nov 2007 20:54:58 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-91-30.w86-217.abo.wanadoo.fr [86.217.53.30])
	by mwinf1907.orange.fr (SMTP Server) with ESMTP id 5DBC21C00081;
	Thu, 22 Nov 2007 20:54:58 +0100 (CET)
X-ME-UUID: 20071122195458384.5DBC21C00081@mwinf1907.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IvI8X-0005gU-PG; Thu, 22 Nov 2007 20:54:57 +0100
Content-Disposition: inline
In-Reply-To: <b8bf37780711211659i65a99493te3e3d5cee008ae7d@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65840>

On Wed, Nov 21, 2007 at 10:59:41PM -0200, Andr=E9 Goddard Rosa wrote:
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2304,11 +2304,13 @@ int main(int argc, const char **argv)
>  		else if (!prefixcmp(a, "--export-marks=3D"))
>  			mark_file =3D a + 15;
>  		else if (!prefixcmp(a, "--export-pack-edges=3D")) {
> +			char *filename =3D a + 20;
> +
>  			if (pack_edges)
>  				fclose(pack_edges);
> -			pack_edges =3D fopen(a + 20, "a");
> +			pack_edges =3D fopen(filename, "a");
>  			if (!pack_edges)
> -				die("Cannot open %s: %s", a + 20, strerror(errno));
> +				die("Cannot open %s: %s", filename, strerror(errno));
>  		} else if (!strcmp(a, "--force"))
>  			force_update =3D 1;
>  		else if (!strcmp(a, "--quiet"))

Normally, the compiler takes care of such optimizations. It actually
takes care of it much better than you can do yourself, and doing it
yourself can even sometimes generate less optimized code because it
gets in the compiler optimizations'way.

Mike
