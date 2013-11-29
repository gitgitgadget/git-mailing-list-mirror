From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v2] stash: handle specifying stashes with spaces
Date: Fri, 29 Nov 2013 22:33:52 +0100
Message-ID: <878uw6dha7.fsf@thomasrast.ch>
References: <87k3frdlwc.fsf@thomasrast.ch>
	<1385758845-8627-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 29 22:34:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmVhl-0002nT-BU
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 22:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927Ab3K2VeN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Nov 2013 16:34:13 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:36230 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755325Ab3K2VeH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Nov 2013 16:34:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 8FA3F4D64E4;
	Fri, 29 Nov 2013 22:34:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3fZgFOjbLYsF; Fri, 29 Nov 2013 22:33:55 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (unknown [89.204.130.229])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id D18144D64DE;
	Fri, 29 Nov 2013 22:33:54 +0100 (CET)
In-Reply-To: <1385758845-8627-1-git-send-email-oystwa@gmail.com>
 (=?utf-8?Q?=22=C3=98ystein?=
	Walle"'s message of "Fri, 29 Nov 2013 22:00:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238539>

Thanks for looking into this!

=C3=98ystein Walle <oystwa@gmail.com> writes:

> -	REV=3D$(git rev-parse --quiet --symbolic --verify $1 2>/dev/null) |=
| {
> +	REV=3D$(git rev-parse --quiet --symbolic --verify "$1" 2>/dev/null)=
 || {
>  		reference=3D"$1"

It's somewhat ironic that the one place where the original did use
quoting is where it's actually not required.

> -	i_commit=3D$(git rev-parse --quiet --verify $REV^2 2>/dev/null) &&
> -	set -- $(git rev-parse $REV $REV^1 $REV: $REV^1: $REV^2: 2>/dev/nul=
l) &&
> +	i_commit=3D$(git rev-parse --quiet --verify "$REV^2" 2>/dev/null) &=
&
> +	set -- $(git rev-parse "$REV" "$REV^1" "$REV:" "$REV^1:" "$REV^2:" =
2>/dev/null) &&

Thanks for being careful here.

I wonder what we would lose by dropping the --symbolic in the line I
quoted above (which is the second parsing pass), so that it resolves to
a SHA1.  We would gain some robustness, as I'm not sure "$REV:" works
correctly in the face of weird revision expressions like ":/foo".

--=20
Thomas Rast
tr@thomasrast.ch
