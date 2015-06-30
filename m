From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config.c: fix writing config files on Windows network
 shares
Date: Tue, 30 Jun 2015 12:01:25 -0400
Message-ID: <20150630160125.GB3953@peff.net>
References: <20150528075142.GB3688@peff.net>
 <20150528075443.GB23395@peff.net>
 <5592A8E5.2090601@gmail.com>
 <5592ABBC.60904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jorge <griffin@gmx.es>,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 30 18:01:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9xyi-0000qv-Ht
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 18:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbbF3QBk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2015 12:01:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:53778 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752963AbbF3QBj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 12:01:39 -0400
Received: (qmail 31345 invoked by uid 102); 30 Jun 2015 16:01:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 11:01:38 -0500
Received: (qmail 15992 invoked by uid 107); 30 Jun 2015 16:01:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 12:01:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jun 2015 12:01:26 -0400
Content-Disposition: inline
In-Reply-To: <5592ABBC.60904@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273075>

On Tue, Jun 30, 2015 at 04:46:20PM +0200, Torsten B=C3=B6gershausen wro=
te:

> The value of fstat() is not checked here:
> (indicated by a compiler warning, that contents_sz may be uninitalize=
d.
>=20
>  config.c:
>  int git_config_set_multivar_in_file(
>  //around line 2063 (the only call to fstat())
>  		fstat(in_fd, &st);
>  		contents_sz =3D xsize_t(st.st_size);

There is a similar case in git_config_rename_section_in_file. It looks
like they could both just jump to the error case when fstat() fails.

-Peff
