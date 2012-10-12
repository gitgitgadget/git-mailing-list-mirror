From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: filter-branch IO optimization
Date: Fri, 12 Oct 2012 16:49:54 +0200 (CEST)
Message-ID: <9de87aac-7e15-48d9-832a-e9a030c5ed43@zcs>
References: <878vbc21f3.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 12 16:50:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMgYx-0007vp-R1
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 16:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757951Ab2JLOt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Oct 2012 10:49:57 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:19714 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754433Ab2JLOt4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Oct 2012 10:49:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id C13D6460003;
	Fri, 12 Oct 2012 16:49:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rZLxqaVgkBI4; Fri, 12 Oct 2012 16:49:54 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 6DF52460001;
	Fri, 12 Oct 2012 16:49:54 +0200 (CEST)
In-Reply-To: <878vbc21f3.fsf@pctrast.inf.ethz.ch>
X-Originating-IP: [91.43.215.119]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207547>

Hi,

> The usual advice is "use an index-filter instead".  It's *much*
> faster
> than a tree filter.  However:

I've tried the last example from git-filter-branch manpage, but failed.
Seems like the GIT_INDEX_FILE env variable doesnt get honoured by
git-update-index, no index.new file created, and so mv call fails.

My second try (as index-filter command) was:

git ls-files -s > ../_INDEX_TMP
cat ../_INDEX_TMP |
    sed "s-\t\"*-&addons/-" |
    git update-index --index-info
rm -f ../_INDEX_TMP

It works fine in the worktree (i see files renamed in the index),
but no success when running it as --index-filter. Seems the index
file isn't used at all (or some completely different one).

By the way, inside the index filter, GIT_INDEX_FILTER here is

/home/devel/vnc/openerp/workspace/pkg/openerp-extra-bundle.git/.git-rew=
rite/t/../index

Obviously a different (temporary) index file, while many examples
on the web, suggesting to use commands like 'git add --cached' or
'git rm --cached' _without_ passing GIT_INDEX_FILTER variable.

Could there be some bug that this variable isn't honored properly
everywhere ?

--
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards

Enrico Weigelt
VNC - Virtual Network Consult GmbH
Head Of Development

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de
