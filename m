From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Problem completing remotes when .git/remotes exits
Date: Wed, 26 Sep 2012 13:43:15 +0200
Message-ID: <20120926114315.GF10144@goldbirke>
References: <505A2330.9040800@kdbg.org> <20120925230045.GA13266@goldbirke>
 <7vbogtvfb4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 13:43:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGq1W-0001Yh-KV
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 13:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546Ab2IZLnR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Sep 2012 07:43:17 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:50267 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671Ab2IZLnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 07:43:16 -0400
Received: from localhost6.localdomain6 (goldbirke.fzi.de [141.21.50.31])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0LbJdK-1TihjN1MQE-00kSl4; Wed, 26 Sep 2012 13:43:15 +0200
Content-Disposition: inline
In-Reply-To: <7vbogtvfb4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:tsYhVLDoskhi6CSrE3IqG+q+Y3YDCbz1JlyLQ1KGdYB
 7pYHufzZmbdIWkr5VFC7pACkQwU6dQNEvbKgnES7OydJzhy6aF
 q20KZnu1tWBuQ7V195Vzzeu/qM6BH35z5XAlD+erh/9Pad89vn
 yoGgM1U957iMd2N1uB12nFqEw1zEbzO3NyPzmqWlNIJv5uSjwc
 2CrZBPPX7oVaNlKHDhDHtPP//q6eVpLLw4/2j2FGLCGOytUC/l
 IZTdqWV1oL6Mj5GfG9xBbirACPvR9ujec2z9Nj06SaJTUTNMz1
 lkY7jvjjH6ylG70iwkSx4/M08BJoqIMmHVUF+9Q12a6oJQqe0q
 1+a81I7v7BeenC3bX9R1U9tHkTUvuwZW3L+YuVxcR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206412>

On Tue, Sep 25, 2012 at 04:43:59PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > -	test -d "$d/remotes" && ls -1 "$d/remotes"
> > +	test -d "$d/remotes" && command ls -1 "$d/remotes"
>=20
> Yuck.  For normal scripts, nobody sane would define "alias" for
> non-interactive environments, but because these things work in an
> interactive environment, we have to protect ourselves from user
> aliases.  Not just "ls", but "test" we see above may misbehave X-<.

Right, however, while ls is frequently aliased (my ubuntu box has
alias ls=3D'ls --color=3Dauto' in /etc/skel/.bashrc by default, but tha=
t's
not an issue in this case), I think aliasing test is just crazy.
Yeah, it's possible, but if we go down that route, then we should also
worry about the [ builtin being aliased:

$ if [ -r nonexisting ] ; then echo found ; fi
$ alias [=3D'echo using aliased ['
$ if [ -r nonexisting ] ; then echo found ; fi
using aliased [ -r nonexisting ]
found
$
