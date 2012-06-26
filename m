From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] t9010: Open backflow FIFO once to work around kernel
 race condition
Date: Tue, 26 Jun 2012 18:46:49 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1206261843150.3236@dr-wily.mit.edu>
References: <1340749806-22734-1-git-send-email-andersk@mit.edu> <20120626224053.GA7155@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 00:46:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjeXC-0001Fe-Cj
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 00:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114Ab2FZWqx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 18:46:53 -0400
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:62127 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751841Ab2FZWqx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 18:46:53 -0400
X-AuditID: 1209190f-b7f306d0000008b4-86-4fea3bdbb26c
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 22.C9.02228.BDB3AEF4; Tue, 26 Jun 2012 18:46:51 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id q5QMkp33025165;
	Tue, 26 Jun 2012 18:46:51 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id q5QMkneT023768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 26 Jun 2012 18:46:50 -0400 (EDT)
In-Reply-To: <20120626224053.GA7155@burratino>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IR4hTV1r1t/crfYNFSK4uuK91MFg29V5gt
	3t5cwujA7LFz1l12j4uXlD0+b5ILYI7isklJzcksSy3St0vgylh8ZjJbwVzmiomPfBsYLzN1
	MXJySAiYSLz52MsCYYtJXLi3nq2LkYtDSGAfo8TaX9+hnA2MEldPXGeFcPYwSWxrXADWziKg
	LbF8yXlGEJtNQE1i7obJ7CC2iICGxPNP39hAbGYBa4ld72aygtjCAlESx5ZsBKvnFNCTOP9j
	OTOIzSvgIPHtRAPYGUICiRJrph4D6xUV0JXYe+gMO0SNoMTJmU9YIGaqSxz4dJERwtaWuH+z
	jW0Co+AsJGWzkJTNQlK2gJF5FaNsSm6Vbm5iZk5xarJucXJiXl5qka6JXm5miV5qSukmRnBA
	S/LvYPx2UOkQowAHoxIPbwTLK38h1sSy4srcQ4ySHExKoryRpkAhvqT8lMqMxOKM+KLSnNTi
	Q4wSHMxKIry/dYFyvCmJlVWpRfkwKWkOFiVx3qspN/2FBNITS1KzU1MLUotgsjIcHEoSvIzA
	yBUSLEpNT61Iy8wpQUgzcXCCDOcBGv7JCmR4cUFibnFmOkT+FKOilDgvP0izAEgiozQPrheW
	cF4xigO9IsyrC1LFA0xWcN2vgAYzAQ3m2PQCZHBJIkJKqoHR6aMG5+p3n6OLLjGuXyH/ep9u
	4qHHDtyuezfN+JO7ULfr+GLPN9FJn6XbVz02Livk5PO+zSf0ddK/pAV6lu8+PK4IeXBpv1D9
	5MT5lixxyncC2B0CZJQkerJOHXt9ZrOWf337s0hVTZcn07fWKC++/ubug/l7c5MX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200697>

On Tue, 26 Jun 2012, Jonathan Nieder wrote:
> Anders Kaseorg wrote:
> > Sidestep this problem by opening the backflow FIFO once for
> > read+write.
>=20
> Is that portable?

Presumably; it=E2=80=99s POSIX, at least.
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.htm=
l#tag_18_07_07

> Doesn't this mean we wouldn't notice if test-svn-fe crashes?

Oh hmm, good point.

Anders
