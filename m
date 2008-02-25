From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Mon, 25 Feb 2008 09:21:45 +0100
Message-ID: <20080225082145.GB20048@auto.tuwien.ac.at>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at> <7vr6f1pwaw.fsf@gitster.siamese.dyndns.org> <20080225074611.GC15761@auto.tuwien.ac.at> <7vskzhmppo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 09:22:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTYbQ-0006XU-RM
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbYBYIVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 03:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbYBYIVr
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 03:21:47 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:56674 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbYBYIVr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 03:21:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 5FC14680B59E;
	Mon, 25 Feb 2008 09:21:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NuHP5nHTIoh0; Mon, 25 Feb 2008 09:21:45 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 42E59680B59A; Mon, 25 Feb 2008 09:21:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vskzhmppo.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75010>

On Sun, Feb 24, 2008 at 11:59:15PM -0800, Junio C Hamano wrote:
> mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
> > How should I define the return value of fsck_walk in the presence o=
f
> > multiple errors?
>=20
> Returning error is fine.  That is not what I was talking about.
>=20
> I was talking about an early return in the code, that does not
> callback once you find an error.

That is not what I was talking about.=20

We need to define the return code of fsck_walk in the case of multiple
errors. What error (of all possible) should it return?

What about this new behaviour:

Callback return values:
* 0 everything OK
* > 0 error, but continue
* < 0 error, but stop

The return value of fsck_walk would be:
* -1, if fsck_walk discoveres an error (eg. not parseable object)
* first callback return value < 0 (and stops further processing in this=
 case)
* first callback return value > 0 (if not callback return value < 0)
* 0, if no errors are discovered

mfg Martin K=F6gler
