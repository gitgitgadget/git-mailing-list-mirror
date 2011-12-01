From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Anyone have a commit hook for forbidding old branches from being merged in?
Date: Thu, 1 Dec 2011 16:50:51 +0100
Message-ID: <201112011650.51547.trast@student.ethz.ch>
References: <CACBZZX4LyTaz=fU1vvgpeL904QFjJULCMVSP0uutcuxZT+-vWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 16:51:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RW8ua-0000ru-7d
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 16:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186Ab1LAPu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Dec 2011 10:50:56 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:1501 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755124Ab1LAPuz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2011 10:50:55 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Dec
 2011 16:50:50 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Dec
 2011 16:50:51 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <CACBZZX4LyTaz=fU1vvgpeL904QFjJULCMVSP0uutcuxZT+-vWQ@mail.gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186174>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
>=20
> So before I write a hook to do this, is there anything that implement=
s
> a hook that:
>=20
>  * Checks if you're pushing a merge commit
>  * If so, is that merge based off and old version of $MAINBRANCH

I think it suffices to check whether any boundary commit in the
updated range is older than what you allow, e.g.

while read old new rev; do
    # omitted: check it's an update, i.e., neither old nor new is 0..0
    git rev-list --boundary $old..$new |
    sed -n 's/^-//p' |
    xargs git rev-list --no-walk --before=3D'cutoff limit' >bad
    test -s bad || exit 1
done

(Not tested much; in particular I'm not sure you can get away without
limiting the number of args to rev-list to 1.  A simple test seems to
indicate so, however.)

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
