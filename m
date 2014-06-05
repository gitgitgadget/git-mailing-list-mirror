From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: [PATCH v6 2/2] refs.c: SSE4.2 optimizations for
 check_refname_component
Date: Thu, 5 Jun 2014 14:58:46 +0200
Message-ID: <20140605125846.GB9316@domone.podge>
References: <1401853091-15535-1-git-send-email-dturner@twitter.com>
 <1401853091-15535-2-git-send-email-dturner@twitter.com>
 <538ED2F1.9030003@web.de>
 <CACsJy8CK3LNaPVNv=EfFX06uOgpujAz364ZDFL3HBPicDNF57w@mail.gmail.com>
 <538F2C6B.2030004@web.de>
 <1401916560.18134.167.camel@stross>
 <539062D9.60000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twitter.com>
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 15:07:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsXNm-0006IV-Q1
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 15:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbaFENG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2014 09:06:58 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:51058 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbaFENG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 09:06:58 -0400
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jun 2014 09:06:57 EDT
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 7672D17F47;
	Thu,  5 Jun 2014 14:58:47 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id 4ED315F81D; Thu,  5 Jun 2014 14:58:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <539062D9.60000@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.98.1 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250835>

On Thu, Jun 05, 2014 at 02:30:17PM +0200, Torsten B=F6gershausen wrote:
> On 2014-06-04 23.16, David Turner wrote:
> >=20
> > Sure!  I actually went with > 120k to make measurement easier:
> > https://github.com/dturner-tw/many-refs
> Hm, I didn't get so man
>=20
> git remote -v
> origin  https://github.com/dturner-tw/many-refs=20
>=20
>  wc .git/packed-refs=20
>      750    1130   38868 .git/packed-refs
>=20
>=20
>=20
> time git rev-parse HEAD
> 7ac416f789fd4f1e398449113f6e1ec1d699141a
>=20
> real    0m0.008s
> user    0m0.002s
> sys     0m0.004s
>=20
> where only patch 1/2 doesn't seem to speed up things on my system:
>=20
> time ~/projects/git/tb.140604_DavidTurner_SSE4/git rev-parse HEAD
> 7ac416f789fd4f1e398449113f6e1ec1d699141a
>=20
> real    0m0.010s
> user    0m0.002s
> sys     0m0.005s
>=20
>=20
Could you run it 100 times to get better resolution? This could be just
measurement error.
