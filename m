From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] submodule recursion in git-archive
Date: Tue, 26 Nov 2013 23:38:58 +0100
Message-ID: <20131126223858.GA4774@sandbox-ub>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
 <5294BB97.7010707@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nick Townsend <nick.townsend@mac.com>, gitster@pobox.com,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Jeff King <peff@peff.net>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 26 23:39:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlRHn-00021y-HK
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 23:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758208Ab3KZWjL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 17:39:11 -0500
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:46016 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757929Ab3KZWjK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 17:39:10 -0500
Received: from [77.20.34.36] (helo=sandbox-ub)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VlRHb-00053o-AU; Tue, 26 Nov 2013 23:39:03 +0100
Content-Disposition: inline
In-Reply-To: <5294BB97.7010707@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238400>

Hi,

I like where this is going.

On Tue, Nov 26, 2013 at 04:17:43PM +0100, Ren=E9 Scharfe wrote:
> Am 26.11.2013 01:04, schrieb Nick Townsend:
> > +		strbuf_addstr(&dotgit, work_tree);
> > +		strbuf_addch(&dotgit, '/');
> > +		if (args->treepath) {
> > +			  strbuf_addstr(&dotgit, args->treepath);
> > +			  strbuf_addch(&dotgit, '/');
> > +		}
> > +		strbuf_add(&dotgit, path_without_prefix,strlen(path_without_pref=
ix)-1);
> > +		if (add_submodule_odb(dotgit.buf))
> > +			  die("Can't add submodule: %s", dotgit.buf);
>=20
> Hmm, I wonder if we can traverse the tree and load all submodule obje=
ct
> databases before traversing it again to actually write file contents.
> That would spare the user from getting half of an archive together wi=
th
> that error message.

I am not sure whether we should die here. What about submodules that
have not been initialized and or cloned? I think that is a quite regula=
r
use case for example for libraries that not everyone needs or big media
submodules which only the design team uses. How about skipping them (ma=
ybe
issuing a warning) by returning 0 here and proceeding?

Cheers Heiko
