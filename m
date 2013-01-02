From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH V2] t9810: Do not use sed -i
Date: Wed, 2 Jan 2013 17:44:46 -0500
Message-ID: <20130102224446.GA12363@padd.com>
References: <201301020020.38535.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 02 23:45:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqX3f-0001qU-Qq
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 23:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797Ab3ABWou convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 17:44:50 -0500
Received: from honk.padd.com ([74.3.171.149]:41490 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752772Ab3ABWot (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 17:44:49 -0500
Received: from arf.padd.com (unknown [50.55.142.135])
	by honk.padd.com (Postfix) with ESMTPSA id ECFFE1E43;
	Wed,  2 Jan 2013 14:44:48 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6AF2622763; Wed,  2 Jan 2013 17:44:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <201301020020.38535.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212551>

tboegi@web.de wrote on Wed, 02 Jan 2013 00:20 +0100:
> sed -i is not portable on all systems.
> Use sed with different input and output files.
> Utilize a tmp file whenever needed
>=20
> Added missing && at 2 places
>=20
> Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>

One more teensy fix is needed in this hunk, following Junio's
comment about redirections going at the end:

> @@ -139,7 +140,8 @@ test_expect_success 'scrub ko files differently' =
'
>  		cd "$git" &&
>  		git config git-p4.skipSubmitEdit true &&
>  		git config git-p4.attemptRCSCleanup true &&
> -		sed -i "s/^line4/line4 edit/" fileko &&
> +		sed <fileko "s/^line4/line4 edit/" >fileko.tmp &&
> +		mv -f fileko.tmp fileko &&
>  		git commit -m "fileko line4 edit" fileko &&
>  		git p4 submit &&
>  		scrub_ko_check fileko &&

I checked that the test still works with your changes.

Thanks for the cleanup!

Acked-by: Pete Wyckoff <pw@padd.com>

		-- Pete
