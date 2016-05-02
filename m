From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/6] connect: uniformize and group CONNECT_DIAG_URL
 handling code
Date: Mon, 2 May 2016 17:31:33 +0900
Message-ID: <20160502083133.GA20929@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462082573-17992-3-git-send-email-mh@glandium.org>
 <5726DE16.3030402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon May 02 10:31:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax9Gb-0006wp-18
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 10:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbcEBIbm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 04:31:42 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:53066 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbcEBIbk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 04:31:40 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1ax9GP-0005ns-VC; Mon, 02 May 2016 17:31:33 +0900
Content-Disposition: inline
In-Reply-To: <5726DE16.3030402@web.de>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293231>

On Mon, May 02, 2016 at 06:56:54AM +0200, Torsten B=F6gershausen wrote:
> On 05/01/2016 08:02 AM, Mike Hommey wrote:
> > +	if (flags & CONNECT_DIAG_URL) {
> >   		printf("Diag: url=3D%s\n", url ? url : "NULL");
> >   		printf("Diag: protocol=3D%s\n", prot_name(protocol));
> >   		printf("Diag: hostandport=3D%s\n", hostandport ? hostandport : =
"NULL");
> > +		printf("Diag: userandhost=3D%s\n", host ? host : "NULL");
> > +		printf("Diag: port=3D%s\n", port ? port : "NONE");
> >   		printf("Diag: path=3D%s\n", path ? path : "NULL");
> >   		conn =3D NULL;
> Does it make sense  to write the host twice?
> If things are cleaned up, would something like this make sense ?
>=20
> 		printf("Diag: url=3D%s\n", url ? url : "NULL");
>  		printf("Diag: protocol=3D%s\n", prot_name(protocol));
> 		printf("Diag: user=3D%s\n", user ? user : "NULL");
>  		printf("Diag: host=3D%s\n", host ? host : "NULL");
> 		printf("Diag: port=3D%s\n", port ? port : "NONE");
>  		printf("Diag: path=3D%s\n", path ? path : "NULL");

That's what I'm converging towards, in the end. There is one thing that
needs hostandport, though: the git protocol host header. But I don't
really like that parse_connect_url would return user, host, port, *and*
hostandport. How about "reconstructing" hostandport in that case, addin=
g
square brackets when the host contains colons?

BTW, the git protocol currently doesn't reject urls with users and
doesn't seem to handle them properly either. My changes would fix this
by separating user and host at the parse_connect_url level, but the
question then is what to do when there is a user part? die()?

Mike
