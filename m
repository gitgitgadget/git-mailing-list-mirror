From: Yaroslav Halchenko <yoh@onerussian.com>
Subject: problems serving non-bare repos with submodules over http
Date: Wed, 20 Apr 2016 11:22:09 -0400
Message-ID: <20160420152209.GH23764@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>
To: Git Gurus hangout <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 17:51:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asuP8-0000Wd-64
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 17:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbcDTPu6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 11:50:58 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:58667 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbcDTPu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 11:50:57 -0400
X-Greylist: delayed 1726 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Apr 2016 11:50:57 EDT
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <yoh@onerussian.com>)
	id 1astxB-00014g-KN; Wed, 20 Apr 2016 11:22:09 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
	(envelope-from <yoh@onerussian.com>)
	id 1astxB-00014b-E0; Wed, 20 Apr 2016 11:22:09 -0400
Content-Disposition: inline
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org, benjaminpoldrack@gmail.com, id@joeyh.name
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292032>

Dear Git Folks,

I do realize that the situation is quite uncommon, partially I guess du=
e
to git submodules mechanism flexibility and power on one hand and
under-use (imho) on the other, which leads to discovery of regressions
[e.g. 1] and corner cases as mine.

[1] http://thread.gmane.org/gmane.comp.version-control.git/288064
[2] http://www.onerussian.com/tmp/git-web-submodules.sh

My use case:  We are trying to serve a git repository with submodules
specified with relative paths over http from a simple web server.  With=
 a demo
case and submodule specification [complete script to reproduce includin=
g the
webserver using python is at 2] such as

(git)hopa:/tmp/gitxxmsxYFO[master]git
$> tree
=2E
=E2=94=9C=E2=94=80=E2=94=80 f1
=E2=94=94=E2=94=80=E2=94=80 sub1
    =E2=94=94=E2=94=80=E2=94=80 f2

$> cat .gitmodules
[submodule "sub1"]
    path =3D sub1
    url =3D ./sub1


1. After cloning=20

    git clone http://localhost:8080/.git

   I cannot 'submodule update' the sub1 in the clone since its url afte=
r
   'submodule init' would be  http://localhost:8080/.git/sub1 .  If I m=
anually fix
   it up -- it seems to proceed normally since in original repository I=
 have
   sub1/.git/ directory and not the "gitlink" for that submodule.

2. If I serve the clone [2 demos that too] itself, there is no easy rem=
edy at
   all since sub1/.git is not a directory but a gitlink.

N.B. I haven't approached nested submodules case yet in [2]

I wondered

a. could 'git clone' (probably actually some relevant helper used by fe=
tch
   etc) acquire ability to sense for URL/.git if URL itself doesn't poi=
nt to a
   usable git repository?

    I think this could provide complete remedy for 1 since then relativ=
e urls
    would be properly assembled, with similar 'sensing' for /.git for t=
he final urls

    I guess we could do it with rewrites/forwards on the "server side",
    but it wouldn't be generally acceptable solution.

b. is there a better or already existing way to remedy my situation?

c. shouldn't "git clone" (or the relevant helper) be aware of remote
   /.git possibly being a gitlink file within submodule?


Thank you in advance for your thoughts and feedback on this case.

P.S. Please maintain the CC list in replies.
--=20
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik       =20
