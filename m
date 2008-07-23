From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 17:41:40 +0400
Message-ID: <20080723174140.b749191a.vsu@altlinux.ru>
References: <20080723130518.GA17462@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__23_Jul_2008_17_41_40_+0400_9+D67pea34w7afDw"
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 23 16:03:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLewd-0003ub-WA
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbYGWOCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 10:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbYGWOCz
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:02:55 -0400
Received: from mivlgu.ru ([195.20.195.134]:41565 "EHLO mail.mivlgu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbYGWOCy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:02:54 -0400
X-Greylist: delayed 1267 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jul 2008 10:02:54 EDT
Received: from center4.mivlgu.local (center4.mivlgu.local [192.168.1.4])
	by mail.mivlgu.ru (Postfix) with SMTP
	id 8C4B28076; Wed, 23 Jul 2008 17:41:43 +0400 (MSD)
In-Reply-To: <20080723130518.GA17462@elte.hu>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.12.1; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89655>

--Signature=_Wed__23_Jul_2008_17_41_40_+0400_9+D67pea34w7afDw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2008 15:05:18 +0200 Ingo Molnar wrote:

> Anyone can simulate it by switching to the linus/master branch of the
> current Linux kernel tree, and doing:
>
>    time for ((i=0; i<140; i++)); do git-merge v2.6.26; done
>
>    real    1m26.397s
>    user    1m10.048s
>    sys     0m13.944s

Timing results here (E6750 @ 2.66GHz):
41.61s user 3.71s system 99% cpu 45.530 total

However, testing whether there is something new to merge could be
performed significantly faster:

$ time sh -c 'for ((i=0; i<140; i++)); do [ -n "$(git rev-list --max-count=1 v2.6.26 ^HEAD)" ]; done'
sh -c   5.49s user 0.26s system 99% cpu 5.786 total

The same loop with "git merge-base v2.6.26 HEAD" takes about 40
seconds here - apparently finding the merge base is the expensive
part, and it makes sense to avoid it if you expect that most of your
branches do not contain anything new to merge.

--Signature=_Wed__23_Jul_2008_17_41_40_+0400_9+D67pea34w7afDw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFIhzUXW82GfkQfsqIRAupaAJwLb9n9+L4n+ig/TJMbF0eeEeXI+wCfVbjK
WmX+cpKp8GS3reb2xt6aQ8I=
=cXUc
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jul_2008_17_41_40_+0400_9+D67pea34w7afDw--
